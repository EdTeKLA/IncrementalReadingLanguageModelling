import os
import math
from format_surprisals import read_roark_surprisals


def get_total_perplexity(surprisals):
    surp = list(surprisals['surp'].astype(float))
    return math.exp(sum(surp) / len(surp))


def parse(data_path, data_split, t, data_type):
    src = 'incremental-top-down-parser/'
    output = '../../../output/PCFG/'
    model_name = f'{src}hyperparameter_tuning/wiki_full_model_{data_type}_t_{t}'
    output_path = f'{output}parse_{data_split}_{data_type}_t_{t}.output'

    if not os.path.exists(output_path):
        parse_command = f'{src}bin/tdparse -v -p -F {output_path} {model_name} {data_path}'
        os.system(parse_command)
    return output_path


def main():
    data = '../../../data/'
    for data_type in ["pos", "word"]:
        for data_split in ['L1', 'L2', 'test']:
            if data_split == 'test':
                data_path = f'{data}wiki/sequences/{data_type}/wiki_test_{data_type}.txt'
            else:
                data_path = f'{data}stimuli/{data_split}/stimuli_{data_split}_{data_type}.txt'

            output_path = parse(data_path, data_split, 0.02, data_type)
            surprisals = read_roark_surprisals(output_path)
            surprisals = surprisals[surprisals.token != '</s>']
            print(f'{data_split}, {data_type}, perplexity: {get_total_perplexity(surprisals)}')


if __name__ == "__main__":
    main()
