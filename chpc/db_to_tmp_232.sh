#!/bin/bash
# as set these databases occupy ~25 GB on the RAM disk
# SCRDB=/scratch/general/lustre/app-repo/alphafold
SCRDB=/scratch/general/vast/app-repo/alphafold
TMPDIR=/tmp/$SLURM_JOBID
mkdir $TMPDIR
#SCRDB=/scratch/general/dtn/u0101881
echo Copying uniref30
mkdir $TMPDIR/uniref30
time cp $SCRDB/uniref30/UniRef30_2021_03_cs219.ff{data,index} $TMPDIR/uniref30
echo Copying bfd
mkdir $TMPDIR/bfd
time cp $SCRDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_cs219.ffindex $TMPDIR/bfd
time cp $SCRDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_cs219.ffdata $TMPDIR/bfd
echo Copying pdb70
mkdir $TMPDIR/pdb70
time cp $SCRDB/pdb70/pdb70_cs219.ff{data,index} $TMPDIR/pdb70
echo Copying pdb_seqres
time cp $SCRDB/pdb_seqres/pdb_seqres.txt $TMPDIR
echo Linking
# MC try to put the ffindex files to ramdisk as well
cd $TMPDIR
ln -s $SCRDB/uniref30/UniRef30_2021_03_a3m* ./uniref30
ln -s $SCRDB/uniref30/UniRef30_2021_03_hhm* ./uniref30
ln -s $SCRDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_a3m* ./bfd
ln -s $SCRDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_hhm* ./bfd
ln -s $SCRDB/pdb70/pdb70_a3m* ./pdb70
ln -s $SCRDB/pdb70/pdb70_hhm* ./pdb70
#ln -s $SCRDB/uniprot .
#ln -s /scratch/general/dtn/u0101881/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt_cs219.ffdata .
