import csv
import os
import math
from get_perplexity import get_total_perplexity


def main():
    ngram_orders = {'word': 6, 'pos': 5, 'word_pos': 6}  # based on hyperparameter tuning
    for stimuli_name in ['L1', 'L2', 'test', 'validation']:
        for data_type in ['word', 'pos', 'word_pos']:
            ngram_order = ngram_orders[data_type]
            data_path = f'../../../data/wiki/sequences/{data_type}/wiki_train_{data_type}.txt'

            if stimuli_name == 'test' or stimuli_name == 'validation':
                stimuli_path = f'../../../data/wiki/sequences/{data_type}/wiki_{stimuli_name}_{data_type}l.txt'
            else:
                stimuli_path = f'../../../data/stimuli/{stimuli_name}/stimuli_{stimuli_name}_{data_type}.txt'
            kenlm_output_path = f'../../../output/n-gram/{data_type}/wiki_{stimuli_name}_{data_type}_{ngram_order}gram.txt'
            surprisal_output_path = f'../../../output/n-gram/{data_type}/wiki_{stimuli_name}_{data_type}_{ngram_order}gram_surprisal.csv'


            LM_path = f'kenlm/build/LMs/wiki_{data_type}_{ngram_order}gram'

            if not os.path.exists(f'{LM_path}.binary'):
                train_command = f'kenlm/build/bin/lmplz -o {ngram_order} < {data_path} > {LM_path}.arpa'
                os.system(train_command)
                convert_command = f'kenlm/build/bin/build_binary {LM_path}.arpa {LM_path}.binary'
                os.system(convert_command)

            if not os.path.exists(kenlm_output_path):
                with open(stimuli_path) as file:
                    stimuli = file.read().split('\n')

                for stimulus in stimuli:
                    query_command = f'echo "{stimulus}" | kenlm/build/bin/query {LM_path}.binary >> {kenlm_output_path}'

                    os.system(query_command)
                    os.system(f'echo >> {kenlm_output_path}')

            with open(kenlm_output_path, 'r') as file:
                lines = file.read()
                lines = lines.split('\n')
                sentences = [lines[i] for i in range(0, len(lines), 6)]

            with open(surprisal_output_path, 'w') as file:
                csv_out = csv.writer(file)
                for sentence in sentences:
                    words = sentence.split('\t')
                    for i in range(len(words) - 1):
                        word = words[i].split('=')[0]
                        prob = words[i].split()[2]
                        csv_out.writerow((word, -float(prob) / math.log10(math.exp(1)))) # convert to base e
                    csv_out.writerow(('', ''))

            perplexity = get_total_perplexity(surprisal_output_path)
            print(stimuli_name, data_type, perplexity)


if __name__ == '__main__':
    main()
