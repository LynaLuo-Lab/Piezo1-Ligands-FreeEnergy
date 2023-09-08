#!/bin/bash
#SBATCH -J sortreplica-stampede2
#SBATCH -o sortreplica-stampede2.o%j
#SBATCH -p development
#SBATCH -N 1
#SBATCH -n 1   # Total number of MPI tasks for  all nodes
#SBATCH -t 00:20:00
#SBATCH -A TG-MCB160119
##SBATCH --mail-user=luoy@westernu.edu
##SBATCH --mail-type=ALL

#number of reps and runs_per_frames
#module load intel/16.0.3 impi namd/2.12

module load intel/18.0.2  mvapich2/2.3.6
module load namd/2.14
module load python2/2.7.15
#module load namd/2.14
sortreplicas output_sort/%s/fep.job4 128 50 
#ibrun namd2 +ppn 32 +pemap 0-63+68 +commap 64-67  +replicas 64 fep_site.conf --source FEP_remd_wca.namd +stdout output_site/%d/job0.%d.log
