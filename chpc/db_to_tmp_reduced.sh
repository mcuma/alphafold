#!/bin/bash
# as set these databases occupy ~18 GB on the RAM disk
SCRDB=/scratch/general/vast/app-repo/alphafold
TMPDIR=/tmp/$SLURM_JOBID
mkdir $TMPDIR
#echo Copying uniclust30
#time cp $SCRDB/uniclust30/uniclust30_2018_08/uniclust30_2018_08_cs219.ff{data,index} /dev/shm/af
# echo Copying bfd
#time cp $SCRDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_cs219.ffindex /dev/shm/af
#time cp $SCRDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_cs219.ffdata /dev/shm/af
echo Copying small bfd
time cp $SCRDB/small_bfd/bfd-first_non_consensus_sequences.fasta $TMPDIR
echo Copying pdb70
time cp $SCRDB/pdb70/pdb70_cs219.ff{data,index} $TMPDIR
echo Copying pdb_seqres
time cp $SCRDB/pdb_seqres/pdb_seqres.txt $TMPDIR
echo Linking
# MC try to put the ffindex files to ramdisk as well
cd $TMPDIR
#ln -s $SCRDB/uniclust30/uniclust30_2018_08/uniclust30_2018_08_a3m* .
#ln -s $SCRDB/uniclust30/uniclust30_2018_08/uniclust30_2018_08_hhm* .
#ln -s $SCRDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_a3m* .
#ln -s $SCRDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_hhm* .
ln -s $SCRDB/pdb70/pdb70_a3m* .
ln -s $SCRDB/pdb70/pdb70_hhm* .
ln -s $SCRDB/uniprot .
#ln -s /scratch/general/dtn/u0101881/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_cs219.ffdata .
