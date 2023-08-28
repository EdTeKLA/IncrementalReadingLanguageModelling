import os
import math
import pandas as pd
import time

from format_surprisals import read_roark_surprisals


def get_total_perplexity(surprisals):
    surp = list(surprisals['surp'].astype(float))
    return math.exp(sum(surp)/len(surp))


def train_and_parse(t, data_type):
    src = 'incremental-top-down-parser/'
    train_data = 'incremental-top-down-parser/normalized_wiki_train_trees.txt'
    validation_data = f'../../../data/wiki/sequences/{data_type}/wiki_validation_{data_type}.txt'

    model_name = f'{src}/hyperparameter_tuning/wiki_full_model_{data_type}_t_{t}'
    output_path = f'{src}/hyperparameter_tuning/parse_dev_{data_type}_t_{t}.output'


    # if not os.path.exists(model_name):
    train_command = f'{src}bin/tdptrain -t{t} -p -s"(SINV(S" -v -F {model_name} -m {src}data/tree.functs.sfile {train_data}'
    os.system(train_command)
    print("train")

    if not os.path.exists(output_path):
        parse_command = f'{src}bin/tdparse -v -p -F {output_path} {model_name} {validation_data}'
        os.system(parse_command)

    return output_path


def main():

    thresholds = [0.02, 0.04, 0.05, 0.06, 0.08]

    for data_type in ["pos"]:
        summary_df = pd.DataFrame()
        summary_path = f'../../../output/PCFG/hyperparameter_tuning_summary_{data_type}.csv'
        for t in thresholds:
            parse_output = train_and_parse(t, data_type)
            surprisals = read_roark_surprisals(parse_output)
            surprisals = surprisals[surprisals.token != '</s>']
            print(t, get_total_perplexity(surprisals))
            summary_df['token'] = surprisals['token']
            summary_df[str(t)] = surprisals['surp']
        summary_df.to_csv(summary_path, index=False)


if __name__ == "__main__":
    start_time = time.time()
    main()
    print("--- %s seconds ---" % (time.time() - start_time))
