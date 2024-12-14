#!/bin/sh
NAME="ecut_bands2"

for CUTOFF in  4 6 8 10 12
do
cat > ${NAME}_${CUTOFF}.in << EOF
&BANDS
outdir='./outputs',
prefix='silicon',
filband='${NAME}_${CUTOFF}_bands.dat',
/
EOF

bands.x < ${NAME}_${CUTOFF}.in > ${NAME}_${CUTOFF}.out
echo ${NAME}_${CUTOFF}

done
