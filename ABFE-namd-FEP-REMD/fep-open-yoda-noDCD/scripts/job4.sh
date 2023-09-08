#!/bin/bash
#SBATCH -J open-yoda
#SBATCH -o prot.o%j
#SBATCH -p normal
###SBATCH -p development
#SBATCH -N 64
#SBATCH -n 128   # Total number of MPI tasks for  all nodes
#SBATCH -t 48:00:00
#SBATCH -A TG-MCB160119
#SBATCH --mail-user=sibylaries@gmail.com
#SBATCH --mail-type=ALL

jobid=4


ibrun  /work2/00410/huang/share/namd2_knl_2021-06-02  +replicas 128  +ppn 64 +pemap 0-63 +commap 64-67 restart_4.conf --source reFEP_remd_wca.namd +stdout output_site/%d/job${jobid}.%d.log 

