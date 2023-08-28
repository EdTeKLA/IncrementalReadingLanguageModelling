#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=64000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=2-0

module load python/3.9.6
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install torch --no-index
pip install numpy --no-index
pip install nltk --no-index
pip install tensorboard --no-index

SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/beam_search.py'
MODEL_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/None_0.002_0.2_256_random_wiki.pt'
STIMULI_PATH="IncrementalReadingLanguageModelling/data/wiki/sequences/word/wiki_validation_word.txt"


BATCH_SIZE=(5 10 20)
BLOCK_SIZE=(50 100 200)

BEAM_SIZE=(100 200 400 600)
WORD_BEAM_SIZE=(10 20 40 60)
SHIFT_SIZE=(1 2 4 6)

#BATCH_SIZE=(20)
#BLOCK_SIZE=(200)
#
#BEAM_SIZE=(800 1000)
#WORD_BEAM_SIZE=(80 100)
#SHIFT_SIZE=(8 10)


for ((i=0; i<${#BATCH_SIZE[*]}; i=i+1))
do
  for ((j=0; j<${#BEAM_SIZE[*]}; j=j+1))
  do
    PARAMS=${BATCH_SIZE[i]}"_"${BLOCK_SIZE[i]}"_"${BEAM_SIZE[j]}"_"${WORD_BEAM_SIZE[j]}"_"${SHIFT_SIZE[j]}
    SURPRISAL_PATH="surprisals_validation_"$PARAMS".txt"
    TREE_PATH="trees_validation_"$PARAMS".parsed"
    python "$SRC_PATH"  --test_file "$STIMULI_PATH"  --model_file "$MODEL_PATH" --batch_size "${BATCH_SIZE[i]}" --beam_size "${BEAM_SIZE[j]}" --word_beam_size "${WORD_BEAM_SIZE[j]}" --shift_size "${SHIFT_SIZE[j]}" --block_size "${BLOCK_SIZE[i]}" --gpu 0 --lm_output_file "$SURPRISAL_PATH" > "$TREE_PATH"
  done
done
