ml Python/3.8.2-GCCcore-9.3.0
alphafold_models=(`find kras_tcr_alphafold_models/*.pdb`)

for a in ${alphafold_models[@]}; do
    prefix=`basename $a`
    python3 mhc_peptide_tcr_for_jihoon_v2.py --template_pdbfile $a --outfile_prefix $prefix --peptides_listfile A2KRAS_methylated_variants.txt 
done

