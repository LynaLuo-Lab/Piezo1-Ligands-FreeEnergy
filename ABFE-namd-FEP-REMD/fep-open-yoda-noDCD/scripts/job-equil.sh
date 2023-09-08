#!/bin/bash
#SBATCH -J prot
#SBATCH -o prot.o%j
###SBATCH -p normal
#SBATCH -p development
#SBATCH -N 4
#SBATCH -n 4   # Total number of MPI tasks for  all nodes
#SBATCH -t 00:10:00
#SBATCH -A TG-MCB160119
#SBATCH --mail-user=sibylaries@gmail.edu
#SBATCH --mail-type=ALL

#jobid=1


ibrun  /work2/00410/huang/share/namd2_knl_2021-06-02  +ppn 32 +pemap 0-63 +commap 64-67 equil1.inp > equil1.log
