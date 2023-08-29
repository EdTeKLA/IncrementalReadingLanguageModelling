#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=64000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=3:00:00

SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/transformer/language_modelling/nwp_tf.py'
DATA_PATH='IncrementalReadingLanguageModelling/data/wiki/sequences/pos/transformer/'
DICT_PATH='wiki_train_pos_indices'
SAVE_PATH='IncrementalReadingLanguageModelling/src/language_models/transformer/parameters_pos/'

module load python/3.9.6
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install torch --no-index
pip install nltk --no-index
pip install tensorboard --no-index

mkdir $SAVE_PATH
python "$SRC_PATH" -data_loc "$DATA_PATH"  -results_loc "$SAVE_PATH" -dict_loc "$DATA_PATH$DICT_PATH" -lr 0.005 -batch_size 5
