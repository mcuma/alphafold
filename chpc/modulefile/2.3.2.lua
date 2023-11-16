-- -*- lua -*-
help(
[[
To start Alphafold, run "run_alphafold.sh"
To see Alphafold runtime options, run "run_alphafold.sh --help"
The database paths are in the AFDATA environment variable
We provide two scripts that explicitly point to all the needed databases, so one only needs to supply additional AF arguments such as the FASTA file name, etc.:
  "run_alphafold_full.sh" - runs AF with full databases
  "run_alphafold_red.sh" - runs AF with reduced databases
For detailed documentation and important performance aspects see https://www.chpc.utah.edu/documentation/software/alphafold.php
]])

-- built from docker://unlhcc/alphafold:2.3.2

depends_on("singularity")
local AFPATH="/uufs/chpc.utah.edu/sys/installdir/alphafold/2.3.2"
local AFCONT="alphafold-unl-2.3.2.sif"
if os.getenv("UUFSCELL") == "redwood.bridges" then
   AFDATA="/scratch/general/pe-nfs1/u0101881/alphafold"
else
   AFDATA="/scratch/general/vast/app-repo/alphafold"
end
setenv("AFDATA",AFDATA)
local AF_ARGS="--data_dir=" .. AFDATA .. " --uniref90_database_path=" .. AFDATA .. "/uniref90/uniref90.fasta" .. " --mgnify_database_path=" .. AFDATA .. "/mgnify/mgy_clusters_2022_05.fa" .. " --template_mmcif_dir=" .. AFDATA .. "/pdb_mmcif/mmcif_files" .. " --obsolete_pdbs_path=" .. AFDATA .. "/pdb_mmcif/obsolete.dat"
local AF_ARGS_TMP=" --uniref30_database_path=$TMPDB/uniref30/UniRef30_2021_03 --bfd_database_path=$TMPDB/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt --pdb70_database_path=$TMPDB/pdb70/pdb70"
local AF_ARGS_RED=" --small_bfd_database_path=$TMPDB/small_bfd/bfd-first_non_consensus_sequences.fasta --pdb_seqres_database_path=$TMPDB/pdb_seqres/pdb_seqres.txt --uniprot_database_path=$TMPDB/uniprot --uniprot_database_path=/scratch/general/vast/app-repo/alphafold/uniprot/uniprot.fasta"

set_shell_function("shellAlphafold",'singularity shell --nv -s /bin/bash ' .. AFPATH .. '/' .. AFCONT,"singularity shell --nv -s /bin/bash " .. AFPATH .. "/" .. AFCONT)
set_shell_function("run_alphafold_red.sh",'singularity exec --nv ' .. AFPATH .. '/' .. AFCONT .. ' /app/run_alphafold.sh ' .. AF_ARGS .. AF_ARGS_RED .. ' $@',"singularity exec --nv " .. AFPATH .. "/" .. AFCONT .. " /app/run_alphafold.sh " .. AF_ARGS .. AF_ARGS_RED)
set_shell_function("run_alphafold_full.sh",'singularity exec --nv ' .. AFPATH .. '/' .. AFCONT .. ' /app/run_alphafold.sh ' .. AF_ARGS .. AF_ARGS_TMP .. ' $@',"singularity exec --nv " .. AFPATH .. "/" .. AFCONT .. " /app/run_alphafold.sh " .. AF_ARGS .. AF_ARGS_TMP)
set_shell_function("run_alphafold.sh",'singularity exec --nv ' .. AFPATH .. '/' .. AFCONT .. ' /app/run_alphafold.sh' .. ' $@',"singularity exec --nv " .. AFPATH .. "/" .. AFCONT .. " /app/run_alphafold.sh")
-- to export the shell function to a subshell
if (myShellName() == "bash") then
 execute{cmd="export -f shellAlphafold",modeA={"load"}}
 execute{cmd="export -f run_alphafold.sh",modeA={"load"}}
 execute{cmd="export -f run_alphafold_full.sh",modeA={"load"}}
 execute{cmd="export -f run_alphafold_red.sh",modeA={"load"}}
end

whatis("Name         : Alphafold")
whatis("Version      : 2.3.2")
whatis("Category     : Protein structure prediction")
whatis("URL          : https://github.com/deepmind/alphafold")
whatis("Installed on : 11/08/2023")
whatis("Installed by : Martin Cuma")

