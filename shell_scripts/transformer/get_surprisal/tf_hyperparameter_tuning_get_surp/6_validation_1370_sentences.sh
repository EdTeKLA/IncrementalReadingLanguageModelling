#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=64000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=3-0

module load python/3.9.6
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install torch --no-index
pip install nltk --no-index
pip install tensorboard --no-index


SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/transformer/data_preparation/load_models_hyperparameter_tuning.py'
OUTPUT_ID='6_validation_1370_sentences'
DATA_LOC='IncrementalReadingLanguageModelling/data/wiki/sequences/word/transformer/validation/'$OUTPUT_ID'.txt'

python $SRC_PATH -data_loc "$DATA_LOC" -output_id "$OUTPUT_ID"

