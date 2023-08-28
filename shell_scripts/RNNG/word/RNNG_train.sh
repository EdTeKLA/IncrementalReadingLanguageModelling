#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=36:00:00

module load python/3.9.6
module load scipy-stack/2022a
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install torch --no-index
pip install nltk --no-index
pip install tensorboard --no-index

SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/train.py'
TRAIN_PATH='IncrementalReadingLanguageModelling/data/wiki/trees/word/wiki-train.json'
VAL_PATH='IncrementalReadingLanguageModelling/data/wiki/trees/word/wiki-val.json'
SAVE_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/wiki-rnng.pt'
python "$SRC_PATH" --train_file "$TRAIN_PATH"  --val_file "$VAL_PATH" --save_path "$SAVE_PATH" --batch_size 256 --fixed_stack --strategy top_down --dropout 0.2 --optimizer adam --lr 0.002 --gpu 0 --batch_group random
