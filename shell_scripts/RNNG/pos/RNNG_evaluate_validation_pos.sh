#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=3-0

module load python/3.9.6
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install torch --no-index
pip install numpy --no-index
pip install nltk --no-index
pip install tensorboard --no-index

SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/beam_search.py'
MODEL_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/None_0.001_0.2_256_random_wiki_pos.pt'


STIMULI_PATH="IncrementalReadingLanguageModelling/data/wiki/sequences/pos/wiki_validation_pos.txt"
SURPRISAL_PATH="surprisals_validation_pos.txt"
TREE_PATH="trees_validation_pos.parsed"
python "$SRC_PATH"  --test_file "$STIMULI_PATH"  --model_file "$MODEL_PATH" --batch_size 10 --block_size 100 --beam_size 400 --word_beam_size 40 --shift_size 4  --gpu 0 --lm_output_file "$SURPRISAL_PATH" > "$TREE_PATH"

