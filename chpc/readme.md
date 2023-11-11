Version 2.3.2

CHPC setup

Use container from UNL and hand modify a few pieces related to ParallelFold, in particular
- separate the CPU intense and GPU intense parts
- put SLURM_NTASKS into the CPU intense parts (jackhmmer, hhblits). That does not provide a huge improvement over the default 8 CPUs, but, for the hhblits, there are sections where it runs well multi-threaded, so we see 2-3x speedup going from 8 to 32 CPUs, which overall about halves the CPU part runtime.

We hand modify the UNL container for now, as:

```
apptainer build --sandbox alphafold-unl docker://unlhcc/alphafold:2.3.2

sudo /uufs/chpc.utah.edu/sys/installdir/apptainer/1.1.8/bin/apptainer shell -w alphafold-unl/
apt-get update
apt-get install vim
cd /app
cp run_alphafold.sh run_alphafold_org.sh
vim run_alphafold_org.sh, replace /app/alphafold/run_alphafold.py with /app/alphafold/run_alphafold_org.py
cd alphafold
# changes to alphafold runner to split the calculation into CPU and GPU part
cp run_alphafold.py run_alphafold_org.py
vim run_alphafold.py, make changes (afsplit.patch)
# changes to run the CPU database searches on $SLURM_NTASKS 
cp alphafold/data/pipeline.py alphafold/data/pipeline_org.py
vim alphafold/data/pipeline.py, make changes (hhblitspar.patch)
```

Additional files in this directory include the AF module file which defines the run_alphafold.sh to run from the container, and run_alphafold_full.sh which includes the location of the databases.

We also include some SLURM scripts that show how to run the first, CPU, stage (which submits the 2nd, GPU stage, job with sbatch -d afterok), and the second, GPU, stage.
