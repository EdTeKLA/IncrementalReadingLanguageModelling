#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=20:00

module load python/3.9.6
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install torch --no-index
pip install nltk --no-index

SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/preprocess.py'
TRAIN_PATH='IncrementalReadingLanguageModelling/data/wiki/trees/wiki_train_trees.txt'
VAL_PATH='IncrementalReadingLanguageModelling/data/wiki/trees/wiki_validation_trees.txt'
TEST_PATH='IncrementalReadingLanguageModelling/data/wiki/trees/empty_test.txt'
OUTPUT_PATH='IncrementalReadingLanguageModelling/data/wiki/trees/'
python "$SRC_PATH" --trainfile "$TRAIN_PATH"  --valfile "$VAL_PATH" --testfile "$TEST_PATH" --outputfile "$OUTPUT_PATH" --vocabminfreq 0 --unkmethod berkeleyrule
