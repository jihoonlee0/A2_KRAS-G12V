# VMD for WIN32, version 1.9.3 (November 30, 2016)
# Must maximize the rendering window for good rendering
# Log file 'X:/user/jwlee/peptides/kras_tcr_alphafold_models_2023-12-23', created by user Jihoon
proc viz_mol {file} {
    # mol new {X:/user/jwlee/peptides/stuff_for_jihoon_2022-05-11/A2KRAS02_GA_2UM_model_v1.pdb_KLVVVGAVGV.pdb} type {pdb} first 0 last -1 step 1 waitfor 1
    set molID [mol new]
    mol addfile $file type pdb first 0 last -1 step 1 waitfor 1 molid $molID
    animate style Loop
    # Color TRA, TRB, HLA by chain and draw as NewCartoon
    mol modselect 0 $molID chain A or chain C or chain D
    mol modcolor 0 $molID Chain
    mol modstyle 0 $molID NewCartoon 0.300000 10.000000 4.100000 0
    mol color Chain
    mol representation NewCartoon 0.300000 10.000000 4.100000 0
    mol selection chain A or chain C or chain D
    mol material Opaque
    # Color antigen by element and draw as licorice
    mol addrep $molID
    mol modselect 1 $molID chain B
    mol modcolor 1 $molID Element
    mol modstyle 1 $molID Licorice 0.300000 12.000000 12.000000
    mol color Element
    mol representation Licorice 0.300000 12.000000 12.000000
    mol selection chain B
    mol material Opaque
    # Color the core CDR3 residues by amino acid and draw as licorice
    mol addrep $molID
    mol modselect 2 $molID resid 279 or resid 280 or resid 281 or resid 282
    mol modcolor 2 $molID ResName
    mol representation Licorice 0.300000 12.000000 12.000000
    mol color ResName
    mol selection resid 279 or resid 280 or resid 281 or resid 282
    mol material Opaque
    rotate x by -20
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate y by -0.333333
    rotate x by -0.133333
    rotate y by -0.133333
    rotate x by -0.666667
    rotate x by -0.266667
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate y by -0.333333
    rotate x by -0.133333
    rotate y by -0.133333
    rotate x by -1.000000
    rotate x by -0.400000
    rotate x by -1.333333
    rotate x by -0.533333
    rotate x by -1.666667
    rotate y by -0.333333
    rotate x by -0.666667
    rotate y by -0.133333
    rotate x by -1.666667
    rotate x by -0.666667
    rotate x by -1.666667
    rotate y by -0.333333
    rotate x by -0.666667
    rotate y by -0.133333
    rotate x by -1.333333
    rotate x by -0.533333
    rotate x by -0.666667
    rotate x by -0.266667
    rotate x by -1.000000
    rotate x by -0.400000
    rotate x by -0.666667
    rotate y by -0.333333
    rotate x by -0.266667
    rotate y by -0.133333
    rotate x by -1.000000
    rotate x by -0.400000
    rotate x by -0.666667
    rotate x by -0.266667
    rotate x by -0.666667
    rotate y by -0.333333
    rotate x by -0.266667
    rotate y by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -1.000000
    rotate x by -0.400000
    rotate x by -0.666667
    rotate x by -0.266667
    rotate x by -10.666667
    rotate y by -0.666667
    rotate x by -4.266667
    rotate y by -0.266667
    rotate y by -0.333333
    rotate y by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.666667
    rotate z by 0.266667
    rotate z by 1.000000
    rotate z by 0.400000
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 2.000000
    rotate z by 0.800000
    rotate z by 2.333333
    rotate z by 0.933333
    rotate z by 2.000000
    rotate z by 0.800000
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 2.000000
    rotate z by 0.800000
    rotate z by 2.333333
    rotate z by 0.933333
    rotate z by 2.333333
    rotate z by 0.933333
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 1.333333
    rotate z by 0.533333
    rotate z by 1.333333
    rotate z by 0.533333
    rotate z by 2.000000
    rotate z by 0.800000
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 1.333333
    rotate z by 0.533333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.666667
    rotate z by 0.266667
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.666667
    rotate z by 0.266667
    rotate z by 1.000000
    rotate z by 0.400000
    rotate z by 1.000000
    rotate z by 0.400000
    rotate z by 1.000000
    rotate z by 0.400000
    rotate z by 1.333333
    rotate z by 0.533333
    rotate z by 1.000000
    rotate z by 0.400000
    rotate z by 1.000000
    rotate z by 0.400000
    rotate z by 1.000000
    rotate z by 0.400000
    rotate z by 1.333333
    rotate z by 0.533333
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by 0.666667
    rotate z by 0.266667
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.666667
    rotate z by 0.266667
    rotate z by 0.333333
    rotate z by 0.133333
    scale by 1.200000
    scale by 1.200000
    scale by 1.200000
    scale by 1.200000
    scale by 1.200000
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate x by -0.333333
    rotate y by -0.666667
    rotate x by -0.133333
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -21.333334
    rotate y by -8.533334
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -2.333333
    rotate y by -0.933333
    rotate y by -2.000000
    rotate y by -0.800000
    rotate x by 0.333333
    rotate y by -2.333333
    rotate x by 0.133333
    rotate y by -0.933333
    rotate y by -1.666667
    rotate y by -0.666667
    rotate y by -1.666667
    rotate y by -0.666667
    rotate y by -1.666667
    rotate y by -0.666667
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -1.333333
    rotate y by -0.533333
    rotate x by 0.333333
    rotate y by -1.000000
    rotate x by 0.133333
    rotate y by -0.400000
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -1.333333
    rotate y by -0.533333
    rotate x by 0.333333
    rotate y by -1.000000
    rotate x by 0.133333
    rotate y by -0.400000
    rotate y by -1.666667
    rotate y by -0.666667
    rotate y by -1.333333
    rotate y by -0.533333
    rotate x by 0.333333
    rotate y by -1.666667
    rotate x by 0.133333
    rotate y by -0.666667
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -1.333333
    rotate y by -0.533333
    rotate x by 1.000000
    rotate y by -18.000000
    rotate x by 0.400000
    rotate y by -7.200000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -1.333333
    rotate y by -0.533333
    rotate x by 0.333333
    rotate y by -1.333333
    rotate x by 0.133333
    rotate y by -0.533333
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.333333
    rotate y by -0.533333
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate x by 0.333333
    rotate y by -0.666667
    rotate x by 0.133333
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate x by 0.333333
    rotate y by -1.000000
    rotate x by 0.133333
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate x by 0.333333
    rotate y by -0.666667
    rotate x by 0.133333
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate x by 0.333333
    rotate y by -1.000000
    rotate x by 0.133333
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate x by 0.333333
    rotate y by -5.000000
    rotate x by 0.133333
    rotate y by -2.000000
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate x by 0.333333
    rotate y by -0.333333
    rotate x by 0.133333
    rotate y by -0.133333
    rotate y by -1.000000
    rotate y by -0.400000
    rotate x by 0.333333
    rotate y by -1.333333
    rotate x by 0.133333
    rotate y by -0.533333
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -1.000000
    rotate y by -0.400000
    rotate x by 0.333333
    rotate y by -0.666667
    rotate x by 0.133333
    rotate y by -0.266667
    rotate y by -1.000000
    rotate y by -0.400000
    rotate y by -0.666667
    rotate y by -0.266667
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.666667
    rotate z by -0.266667
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -1.000000
    rotate z by -0.400000
    rotate z by -0.666667
    rotate z by -0.266667
    rotate z by -1.000000
    rotate z by -0.400000
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.666667
    rotate z by -0.266667
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.666667
    rotate z by -0.266667
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.666667
    rotate z by -0.266667
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 4.000000
    rotate z by 1.600000
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 0.333333
    rotate z by 0.133333
    rotate z by 1.666667
    rotate z by 0.666667
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate z by -0.333333
    rotate z by -0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.666667
    rotate x by 0.266667
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.666667
    rotate x by 0.266667
    rotate x by 0.333333
    rotate x by 0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    rotate x by 0.333333
    rotate x by 0.133333
    scale by 1.200000
    scale by 1.200000
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -1.000000
    rotate x by -0.400000
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -1.000000
    rotate x by -0.400000
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.666667
    rotate x by -0.266667
    rotate x by -0.333333
    rotate y by 0.333333
    rotate x by -0.133333
    rotate y by 0.133333
    rotate x by -0.666667
    rotate x by -0.266667
    rotate x by -0.333333
    rotate x by -0.133333
    rotate x by -0.333333
    rotate y by 0.333333
    rotate x by -0.133333
    rotate y by 0.133333
    rotate x by -0.333333
    rotate x by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    rotate y by -0.333333
    rotate y by -0.133333
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.020000 0.000000
    translate by 0.000000 0.020000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.020000 0.000000
    translate by 0.000000 0.020000 0.000000
    translate by -0.010000 0.030000 0.000000
    translate by 0.000000 0.030000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by -0.010000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by -0.010000 0.010000 0.000000
    translate by -0.010000 0.030000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by -0.010000 0.020000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by -0.010000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by -0.010000 0.010000 0.000000
    translate by 0.000000 0.010000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by 0.010000 -0.000000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by 0.010000 -0.010000 0.000000
    translate by 0.000000 -0.020000 0.000000
    translate by 0.010000 -0.010000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by 0.010000 -0.000000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by 0.010000 -0.000000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by 0.000000 -0.010000 0.000000
    translate by -0.010000 -0.000000 0.000000
    translate by -0.010000 -0.000000 0.000000
    menu render off
    menu render on
    render snapshot ${file}_render.bmp
    mol delete $molID
    puts [concat "Molecule" $molID "is" $file "\n"]
}

# Run the above function for each file
set pdb_files [glob -nocomplain -directory X:/user/jwlee/peptides/kras_tcr_alphafold_models_2023-12-23/TCR-pMHC-mod_models_v3 {*ft_struc*.pdb}]
foreach file $pdb_files {
    viz_mol $file
}

# VMD for WIN32, version 1.9.3 (November 30, 2016)
# end of log file.
