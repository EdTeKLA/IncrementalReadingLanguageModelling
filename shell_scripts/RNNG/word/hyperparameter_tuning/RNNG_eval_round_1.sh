#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6 	 # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M      	 # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=12:00:00

module load python/3.9.6
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install torch --no-index
pip install numpy --no-index
pip install nltk --no-index
pip install tensorboard --no-index

SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/beam_search.py'
STIMULI_PATH="IncrementalReadingLanguageModelling/data/wiki/sequences/word/wiki_validation_word.txt"

LR_SCHEDULER=('None')
LR=(0.0001 0.001 0.01)
DROPOUT=(0.1 0.5 0.9)
BATCH_SIZE=(256 512 1024)
BATCH_GROUP=('similar_length' 'random')
for ((i=0; i<${#LR_SCHEDULER[*]}; i=i+1))
do
  for ((j=0; j<${#LR[*]}; j=j+1))
  do
    for ((k=0; k<${#DROPOUT[*]}; k=k+1))
    do
      for ((l=0; l<${#BATCH_SIZE[*]}; l=l+1))
      do
        for ((m=0; m<${#BATCH_GROUP[*]}; m=m+1))
        do
          MODEL=${LR_SCHEDULER[i]}"_"${LR[j]}"_"${DROPOUT[k]}"_"${BATCH_SIZE[l]}"_"${BATCH_GROUP[m]}
          MODEL_PATH="IncrementalReadingLanguageModelling/src/RNNG/rnng-pytorch/"$MODEL"_wiki.pt"
          SURPRISAL_PATH="surprisals_validation_"$MODEL".txt"
          TREE_PATH="trees_validation"$MODEL".parsed"
          python "$SRC_PATH" --test_file "$STIMULI_PATH" --model_file "$MODEL_PATH" --batch_size 10 --beam_size 100 --word_beam_size 10 --shift_size 1 --block_size 100 --gpu 0 --lm_output_file "$SURPRISAL_PATH" > "$TREE_PATH"
        done
      done
    done
  done
done
