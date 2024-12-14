#!/bin/sh
NAME="ecut_bands"

for CUTOFF in 4 6 8 10 12
do
cat > ${NAME}_${CUTOFF}.in << EOF
 &control
    calculation = 'bands',
    prefix = 'silicon'
    outdir = './outputs'
    pseudo_dir = '.'
 /
 &system
    ibrav =  2,
    celldm(1) = 10.0,
    nat =  2,
    ntyp = 1,
    nbnd = 10,
    ecutwfc = $CUTOFF
 /
 &electrons
    mixing_beta = 0.6
 /

ATOMIC_SPECIES
 Si 28.086  Si.pbe-n-kjpaw_psl.1.0.0.UPF

ATOMIC_POSITIONS (alat)
 Si 0.0 0.0 0.0
 Si 0.25 0.25 0.25

K_POINTS {crystal_b}
2
0.00 0.00 0.00 2 !G
0.50 0.00 0.50 2 !X
EOF

pw.x < ${NAME}_${CUTOFF}.in > ${NAME}_${CUTOFF}.out
echo ${NAME}_${CUTOFF}
grep "k = 0.0000 0.0000 0.0000 (" ${NAME}_${CUTOFF}.out

done
