ml fhPython
alphafold_models=(`find kras_tcr_alphafold_models/*.pdb`)
prefix=TCR-pMHC-mod_models_v3/

for a in ${alphafold_models[@]}; do
    prefix=`basename $a`
    python3 mhc_peptide_tcr_for_jihoon_v3.py --template_pdbfile $a --outfile_prefix $prefix --peptides_listfile A2KRAS_methylated_variants.txt --move_neighbor_backbones
done
