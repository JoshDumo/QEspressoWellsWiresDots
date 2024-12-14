#!/bin/sh
NAME="ecut"

for CUTOFF in  5 10 15 20 25 30 35 40
do
cat > ${NAME}_${CUTOFF}.in << EOF
 &control
    calculation = 'scf',
    prefix = 'silicon'
    outdir = './outputs'
    pseudo_dir = '.'
 /
 &system
    ibrav =  2,
    celldm(1) = 10.0,
    nat =  2,
    ntyp = 1,
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

K_POINTS (automatic)
  6 6 6 0 0 0
EOF

pw.x < ${NAME}_${CUTOFF}.in > ${NAME}_${CUTOFF}.out
echo ${NAME}_${CUTOFF}
grep ! ${NAME}_${CUTOFF}.out

done
