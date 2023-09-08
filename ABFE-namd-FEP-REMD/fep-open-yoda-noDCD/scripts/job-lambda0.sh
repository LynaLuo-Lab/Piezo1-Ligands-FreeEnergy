#!/bin/bash
#SBATCH -J rmsdFEP
#SBATCH -o prot.o%j
#SBATCH -p normal
###SBATCH -p development
#SBATCH -N 16
#SBATCH -n 32  # Total number of MPI tasks for  all nodes
#SBATCH -t 48:00:00
#SBATCH -A TG-MCB160119
#SBATCH --mail-user=sibylaries@gmail.com
#SBATCH --mail-type=ALL

#jobid=1

ibrun  /work2/00410/huang/share/namd2_knl_2021-06-02  +ppn 32 +pemap 0-63 +commap 64-67 lambda0.pme.namd > lambda0.log
