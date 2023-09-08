# Piezo1-Ligands-FreeEnergy
This repository contains three computational methods (ABFE, RBFE, SILCS) to compute or rank ligand binding affinities at the transmembrane region of the mechanosensitive Piezo1 channel.

ABFE-namd-FEP-REMD and SILCS folders were prepared by Wenjuan Jiang <sibylaries@gmail.com> (09/06/2023)

RBFE-amber-TI folder was prepared by Han Zhang <haz519@lehigh.edu> (09/03/2023)

ABFE-namd-FEP-REMD contains files for absolute binding free energy simulation:

For input files, there are general NAMD input files in inputfiles/, ligand parameter files lig-forcefield/, simulation configuration file configure/,  protein-ligand distance restraint files in restraints/, analysis and related run scripts in folder scripts/, CHARMM force field files in toppar/. 

For output files, there are three folders: 

output_site/, the main output folders include all the log file, trajectory files, restart files, FEP output files and others for each replica. 

Output_off/, for free energy calculations. 

Output_sort/, for sorting trajectory files.

Before running any simulation, check folder scripts/, it will show the steps as 1_mkdir.pl, 2_mkconf.pl, 4_sort.pl (this one will call sort.py), 5_fe.pl (this perl script will use calc_fe.pl). Since this project mainly utilized TACC-stampede2 clusters, all the run-job scripts are based on stampede2 version. Job-equil.sh is the script to run equilibrium simulations. Job-4.sh is the script to run ABFE simulation, sortreplica-stampede2.sh is the one to sort trajectories for each replica. For this project, 128 replica were chosen.
Steps for running ABFE simulation with NAMD software.
1.	run 1_mkdir.pl to generate 128 folders to save 128 lambda run
2.	set up protein-ligand distance restraint and ligand RMSD restraint in inputfiles/distance_restraint.namd.col (for large ligand, add ligand RMSD restraint to help sampling) with flat-bottom harmonic restraints, the fep_restraint.namd.col is intended for calculation of restraint free energy Uc at fully decoupled state using NAMD TI module.
3.	change B column to 1 for ligand atoms in inputifles/pdb.fep
4.	make sure you have all inputfiles needed for fep_site_init.namd
5.	run job0.sh. Once done, check the acceptance ratio in output files. If some ratio are low between certain lambda, modify "num_replicas" in configure/fep_site.conf. 
6.	Note: in job files such as job4.sh, the source file FEP_remd_wca.namd was modified to reFEP_remd_wca.namd. This is because the standard format of source .namd file cannot produce full time series FEP history file, due to NAMD 2021-06-02 version update. The following line was added:
set rehistory_file [open [format "$job_output_root.$replica_id.rehistory" $replica_id] "w"]
  	fconfigure $rehistory_file -buffering line
7.	continue with job1.sh, job2.sh (modify configure/restart_1.conf if necessary)
8.	run scripts/5_fe.pl to compute free energy for each job
9.	run sortreplica-stampede2.sh to unscramble trajectories so each trajectory represents one lambda value. The 0 is fully decoupled and 127 is fully coupled. When the job is finished, we can use scripts/copy_name.sh to move rehistory file to output_sort/ folder for each replica. When .rehistory files are in output_sort file, we are safe to run scripts/sortreplica-stampede2.sh to sort trajectories for each replica.


RBFE-amber-TI contains files for relative binding free energy simulations:

1. According to the difference between ligands (L0 and L1), change the scmask1 and scmask2 (in the .tmpl files) to be consistent with the system.
2. Run 1_setup.sh to generate 12 lambda windows.
3. Submit the 1-dooku.sh script to perform AMBER-TI.
4. To extend the simulations, change the jidx to a different number in the submit.sh file. The number of MD steps (nstlim in ti.in.tmpl file) might also need to be adjusted to reach the desired simulation length.
5. Run 1-dooku.sh for the TI simulation extension.
6. Run 3_analysis.sh to compute the relative binding free energy and plot convergence

SILCS folder contains silcsmap for Piezo1 open state protein:

1. The protein file is yoda_open_ordered.pdb, and the view_maps.vmd is the script to visualize silcs fragmaps maps/.
In linux, you can visualize as "vmd -e view_maps.vmd", make sure all the related plugins/ folder is under the same folder. You can also use view_maps.pml to visualize in Pymol. Yoda1.FEP.pdb is the pose directly from previous ABFE simulation. We can take this as a reference of Yoda1 pose in Piezo1 open state pocket.


2. The silcs-mc docked poses are saved in folder docked_poses/ 
The related silcs pharmocophore files are all saved in silcs_pharmcophore/. There is also log file to show the in-process notes of silcs-pharmcophore generation.The pharmcophore .ph4 file can be visualized in MOE too and later was used to do virsual screening for searching new potential ligands.
