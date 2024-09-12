''' code for reading in an MHC:peptide:TCR complex, mutating the peptide,
and computing the binding energy between the TCR and the peptide:MHC

assumes that the MHC:peptide:TCR complex has four chains:
 1. MHC
 2. peptide
 3. TCRa
 4. TCRb

allows the backbone of the peptide to move
allows the sidechains of all residues that are at the interface to move

'''

import argparse

parser = argparse.ArgumentParser(
    description="Compute peptide-MHC binding energies and stats")

parser.add_argument('--peptides_listfile',
                    help='A text file containing the peptide sequences to '
                    'be modeled, one per line. They should have the same '
                    'length as the peptide in --template_pdbfile')
parser.add_argument('--template_pdbfile',
                    help='PDB file containing MHC:peptide:TCR complex to be used '
                    'as a template for modeling')
parser.add_argument('--outfile_prefix',
                    help='Prefix that will be prepended to the output '
                    'filenames')
parser.add_argument('--ex1', action='store_true',
                    help='extra rotamer sampling around chi1')
parser.add_argument('--ex2', action='store_true',
                    help='extra rotamer sampling around chi2')
parser.add_argument('--weights_filetag', default="ref2015_cart.wts",
                    help='name of score function weights file')
parser.add_argument('--move_neighbor_backbones', action='store_true',
                    help='allow neighbor positions in the MHC or TCR to change '
                    'backbone position (their sidechain atoms can already move')
parser.add_argument('--debug', action='store_true',
                    help='for testing, dont do any simulations, dump pdbs')

args = parser.parse_args()

from os.path import exists

assert exists(args.peptides_listfile) and exists(args.template_pdbfile)

### more imports
import pandas as pd
import numpy as np
import sys
import pyrosetta

from pyrosetta.rosetta import core, protocols, numeric, basic, utility
from pyrosetta.rosetta.utility import vector1_bool as bools

# pyrosetta init
init_flags = '-ignore_unrecognized_res 1 -include_current'

if args.ex1:
    init_flags += f' -ex1'
if args.ex2:
    init_flags += f' -ex2'

pyrosetta.init(init_flags)

################################################################################
# FUNCTIONS
################################################################################


def mutate_peptide_sequence( peptide_sequence, pose ):
    ''' This function mutates the current peptide sequence in pose
    to peptide_sequence
    '''
    old_sequence = pose.chain_sequence(2)
    print(f'mutate_peptide_sequence: from {old_sequence} to',
          peptide_sequence)

    pep_begin = pose.chain_begin(2)
    pep_end = pose.chain_end(2)

    amino_acids = 'ACDEFGHIKLMNPQRSTVWY'

    if all(x in amino_acids for x in peptide_sequence): # all canonical AAs
        assert len(peptide_sequence) == pep_end-pep_begin+1

        tf = core.pack.task.TaskFactory()

        # freeze non-peptide:
        op = core.pack.task.operation.PreventRepacking()
        for i in range(1,pose.size()+1):
            if pose.chain(i) != 2:
                op.include_residue(i)
        tf.push_back(op)

        # force desired sequence at peptide
        for i, aa in zip(range(pose.chain_begin(2), pose.chain_end(2)+1),
                         peptide_sequence):
            op = core.pack.task.operation.RestrictAbsentCanonicalAAS()
            op.include_residue(i)
            op.keep_aas(aa)
            tf.push_back(op)

        packer = protocols.minimization_packing.PackRotamersMover()
        packer.task_factory(tf)

        packer.apply(pose)
    else:
        peptide_pose = core.pose.Pose()
        core.pose.make_pose_from_sequence(
            peptide_pose, peptide_sequence, "fa_standard")
        assert peptide_pose.size() == len(old_sequence)
        for i in range(len(old_sequence)):
            old_rsd = pose.residue(pep_begin+i)
            new_rsd = peptide_pose.residue(1+i)
            if old_rsd.name() != new_rsd.name():
                print('residue change:', old_rsd.name(), new_rsd.name())
                pose.replace_residue(pep_begin+i, new_rsd, True)




def fastrelax_peptide(
        scorefxn,
        nrepeats,
        peptide_positions,
        neighbor_positions,
        pose
):
    ''' This function optimizes the rosetta energy of the mhc-peptide complex
    It allows the amino acid side chains to change and all atoms in the peptide
    and nearby to move a small amount
    '''
    # movemap:
    mm = pyrosetta.rosetta.core.kinematics.MoveMap()
    mm.set_bb(False)
    mm.set_chi(False)
    mm.set_jump(False)

    for i in peptide_positions:
        mm.set_bb(i, True)
        mm.set_chi(i, True)

    for i in neighbor_positions:
        mm.set_chi(i, True)
        if args.move_neighbor_backbones:
            mm.set_bb(i, True)

    print('fastrelax_peptide:: adding chi flex at',
          len([x for x in neighbor_positions
               if x not in set(peptide_positions)]),
          'nbr positions')
    if args.move_neighbor_backbones:
        print('fastrelax_peptide:: adding backbone flex at',
              len([x for x in neighbor_positions
                   if x not in set(peptide_positions)]),
              'nbr positions')

    fr = protocols.relax.FastRelax(scorefxn_in=scorefxn,
                                   standard_repeats=nrepeats)
    fr.cartesian(True)
    fr.set_movemap(mm)
    fr.set_movemap_disables_packing_of_fixed_chi_positions(True)

    # For non-Cartesian scorefunctions, use "dfpmin_armijo_nonmonotone"
    fr.min_type("lbfgs_armijo_nonmonotone")
    if not args.debug:
        fr.apply(pose)


# def unbind_peptide(pose):
#     ''' This function slides the peptide away from the MHC so we can
#     compute an unbound energy
#     '''
#     posl = range(1,pose.size()+1)

#     chains = np.array([pose.chain(x) for x in posl])
#     calphas = np.array([pose.residue(x).xyz("CA") for x in posl])

#     mhc_cen = np.mean(calphas[chains==1], axis=0)
#     pep_cen = np.mean(calphas[chains==2], axis=0)

#     trans = pep_cen - mhc_cen
#     trans = numeric.xyzVector_double_t(trans[0], trans[1], trans[2])

#     j = pose.jump(1)
#     j.translation_along_axis(pose.conformation().upstream_jump_stub(1), trans,
#                              25.0)

#     pose.set_jump(1, j)


def unbind_tcr(pose):
    ''' This function slides the TCR away from the pMHC so we can
    compute an unbound energy
    '''
    posl = range(1,pose.size()+1)

    chains = np.array([pose.chain(x) for x in posl])
    calphas = np.array([pose.residue(x).xyz("CA") for x in posl])

    mhc_cen = np.mean(calphas[chains==1], axis=0)
    tcr_cen = np.mean(calphas[(chains==3)|(chains==4)], axis=0)

    trans = tcr_cen - mhc_cen
    trans = numeric.xyzVector_double_t(trans[0], trans[1], trans[2])

    jump_number = 2 # from MHC to TCRa

    j = pose.jump(jump_number)
    j.translation_along_axis(
        pose.conformation().upstream_jump_stub(jump_number), trans, 25.0)
    pose.set_jump(jump_number, j)



def find_neighbors(core_positions, pose, heavyatom_distance_threshold = 3.0):
    ''' This function finds MHC residues that are nearby the peptide
    They will be allowed to move during the energy optimization
    '''
    # include all the 'core' positions as neighbors (of themselves, e.g.)
    nbr_positions = set(core_positions)

    posl = range(1, pose.size()+1)

    for i in posl:
        rsd1 = pose.residue(i)
        if rsd1.is_virtual_residue():
            continue
        for j in core_positions:
            rsd2 = pose.residue(j)
            if ( rsd1.nbr_atom_xyz().distance_squared( rsd2.nbr_atom_xyz() ) <=
                 ( rsd1.nbr_radius() + rsd2.nbr_radius() +
                   heavyatom_distance_threshold )**2):
                nbr_positions.add(i)
                break
    return nbr_positions


################################################################################
################################################################################

bound_pose = pyrosetta.pose_from_pdb(args.template_pdbfile)

# set up a fold tree
# jump #1 is from the MHC to peptide
# jump #2 is from the MHC to TCRa
# jump #3 is from the TCRa to TCRb
#
f = core.kinematics.FoldTree(bound_pose.size())
f.new_jump(1, bound_pose.chain_begin(2), bound_pose.chain_end(1))
f.new_jump(1, bound_pose.chain_begin(3), bound_pose.chain_end(2))
f.new_jump(bound_pose.chain_begin(3), bound_pose.chain_begin(4),
           bound_pose.chain_end(3))
f.reorder(1)
bound_pose.fold_tree(f)

# find neighbor positions
mhc_positions = set(range(bound_pose.chain_begin(1), bound_pose.chain_end(1)+1))
pep_positions = set(range(bound_pose.chain_begin(2), bound_pose.chain_end(2)+1))
tcr_positions = set(range(bound_pose.chain_begin(3), bound_pose.chain_end(4)+1))


mhc_nbrs = find_neighbors(mhc_positions, bound_pose)
pep_nbrs = find_neighbors(pep_positions, bound_pose)
tcr_nbrs = find_neighbors(tcr_positions, bound_pose)

neighbor_positions = (pep_nbrs |
                      (tcr_nbrs & mhc_positions) |
                      (mhc_nbrs & tcr_positions))

template_peptide = bound_pose.chain_sequence(2)

with open(args.peptides_listfile, 'r') as data:
    peptides = [x[:-1] for x in data]

scorefxn = pyrosetta.create_score_function(args.weights_filetag)
peptide_scores = []

for peptide in peptides:
    pose = bound_pose.clone()

    if args.debug:
        pose.dump_pdb('start.pdb')

    mutate_peptide_sequence(peptide, pose)

    if args.debug:
        pose.dump_pdb('after_pepmut.pdb')

    fastrelax_peptide(scorefxn, 1, pep_positions, neighbor_positions, pose)
    bound_score = scorefxn(pose)

    unbound_pose = pose.clone()

    unbind_tcr(unbound_pose)
    unbound_score_frozen = scorefxn(unbound_pose)

    if args.debug:
        unbound_pose.dump_pdb('after_unbinding.pdb')

    fastrelax_peptide(scorefxn, 1, pep_positions, neighbor_positions,
                      unbound_pose)
    unbound_score = scorefxn(unbound_pose)

    binding_energy = bound_score - unbound_score
    binding_energy_frozen = bound_score - unbound_score_frozen


    print('annotated_sequence:', pose.annotated_sequence())
    print('bound_score:', bound_score)
    print('unbound_score:', unbound_score)
    print('unbound_score_frozen:', unbound_score_frozen)
    print('binding_energy:', peptide, binding_energy)
    print('binding_energy_frozen:', peptide, binding_energy_frozen)
    print('bound_energies:', peptide,
          pose.energies().total_energies().weighted_string_of(
              scorefxn.weights()))
    print('unbound_energies:', peptide,
          unbound_pose.energies().total_energies().weighted_string_of(
              scorefxn.weights()))

    peptide_scores.append(dict(
        peptide=peptide,
        template=args.template_pdbfile,
        bound_score=bound_score,
        unbound_score=unbound_score,
        unbound_score_frozen=unbound_score_frozen,
        binding_energy=binding_energy,
        binding_energy_frozen=binding_energy_frozen,
    ))


    if args.outfile_prefix is not None:
        # save the final pdb file
        peptide_for_filename = peptide.replace('[','_')\
                                      .replace(']','_')\
                                      .replace(':','_')
        outfile = f'{args.outfile_prefix}_{peptide_for_filename}.pdb'
        pose.dump_pdb(outfile)

        # write out the accumulate scores (we keep over-writing the old scores)
        outfile = f'{args.outfile_prefix}_scores.tsv'
        pd.DataFrame(peptide_scores).to_csv(outfile, sep='\t', index=False)

    sys.stdout.flush()



print('DONE')
