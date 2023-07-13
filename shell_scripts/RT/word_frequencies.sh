#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=1-0

module load python/3.9.6
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip

SRC_PATH='IncrementalReadingLanguageModelling/src/reading_time_prediction/cc_get_word_frequencies.py'
python $SRC_PATH