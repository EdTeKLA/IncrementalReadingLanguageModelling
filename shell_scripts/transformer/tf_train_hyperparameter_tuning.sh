#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=3-0

module load python/3.9.6
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install torch --no-index
pip install nltk --no-index
pip install tensorboard --no-index

SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/transformer/language_modelling/nwp_tf.py'
DATA_PATH='IncrementalReadingLanguageModelling/data/wiki/sequences/word/transformer/'
DICT_PATH='wiki_train_word_final_indices'

LR=(0.0002 0.001 0.005 0.025 0.125)
BATCH_SIZE=(5 10 20 40 80)

for ((i=0; i<${#LR[*]}; i=i+1))
do
  for ((j=0; j<${#BATCH_SIZE[*]}; j=j+1))
  do
    SAVE_PATH="IncrementalReadingLanguageModelling/src/language_models/transformer/parameters_"${LR[i]}"_"${BATCH_SIZE[j]}"/"
    mkdir $SAVE_PATH
    echo $SAVE_PATH
    time python "$SRC_PATH" -data_loc "$DATA_PATH"  -results_loc "$SAVE_PATH" -dict_loc "$DATA_PATH$DICT_PATH" -lr ${LR[i]} -batch_size ${BATCH_SIZE[j]}
  done
done
