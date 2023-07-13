#!/bin/bash
#SBATCH --gpus-per-node=v100l:1  # Request GPU "generic resources"
#SBATCH --cpus-per-task=6        # Cores proportional to GPUs: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M             # Memory proportional to GPUs: 32000 Cedar, 64000 Graham.
#SBATCH --time=3-0

module load python/3.9.6
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install torch --no-index
pip install nltk --no-index
pip install tensorboard --no-index

SRC_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/train.py'
TRAIN_PATH='IncrementalReadingLanguageModelling/data/wiki/trees/word/wiki-train.json'
VAL_PATH='IncrementalReadingLanguageModelling/data/wiki/trees/word/wiki-val.json'
SAVE_PATH='IncrementalReadingLanguageModelling/src/language_models/RNNG/rnng-pytorch/'


LR_SCHEDULER=('None')
LR=(0.01)
DROPOUT=(0.9)
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
          OUTPUT_PATH_NAME="output/round_1/wiki_time_${LR_SCHEDULER[i]}""_"${LR[j]}"_"${DROPOUT[k]}"_"${BATCH_SIZE[l]}"_"${BATCH_GROUP[m]}".txt"
          SAVE_PATH_NAME="$SAVE_PATH${LR_SCHEDULER[i]}""_"${LR[j]}"_"${DROPOUT[k]}"_"${BATCH_SIZE[l]}"_"${BATCH_GROUP[m]}"_wiki.pt"
          echo $SAVE_PATH_NAME
          echo $OUTPUT_PATH_NAME
          if [ ${LR_SCHEDULER[i]} = 'None' ];
          then
            { time python "$SRC_PATH" --train_file "$TRAIN_PATH"  --val_file "$VAL_PATH" --save_path "$SAVE_PATH_NAME" --batch_size ${BATCH_SIZE[l]} --batch_group ${BATCH_GROUP[m]} --fixed_stack --strategy top_down --dropout ${DROPOUT[k]} --optimizer adam --lr ${LR[j]} --gpu 0 ; } 2> $OUTPUT_PATH_NAME
          else
            { time python "$SRC_PATH" --train_file "$TRAIN_PATH"  --val_file "$VAL_PATH" --save_path "$SAVE_PATH_NAME" --batch_size ${BATCH_SIZE[l]} --batch_group ${BATCH_GROUP[m]} --fixed_stack --strategy top_down --dropout ${DROPOUT[k]} --optimizer adam --lr ${LR[j]} --lr_scheduler ${LR_SCHEDULER[i]} --gpu 0 ; } 2> $OUTPUT_PATH_NAME
          fi
        done
      done
    done
  done
done
