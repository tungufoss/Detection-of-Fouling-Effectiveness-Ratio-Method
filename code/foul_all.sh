#!/bin/bash
totalnodes=10 #fjoldi processora; 1 verk per processor

#for gen in $(seq 1 1 1); do
 echo Sameina lausnir fyrir itrun $gen
 cat WTeval[0-9]*.txt > WTinit.txt

  for node in  $(seq 1 1 $totalnodes); do  
   echo Itrun $gen, utreikningar fyrir orgjorva $node af $totalnodes
   qsub -o xxWT$node.out -v node=$node foul_single.sh
 done

# Sja til thess ad allir processorar eru bunir med sitt verk, tha eru allar WT[0-9]*eval.txt uppfaerdar
# while [ `qstat | wc -l` -gt 0 ]; do sleep 20; done

#done
