import os
import csv
import math


def main():
    ngram_orders = [2, 3, 4, 5, 6]
    corpus = 'wiki'
    data_types = ['word', 'pos', 'word_pos']

    for data_type in data_types:
        data_path = f'../../../data/wiki/sequences/{data_type}/{corpus}_train_{data_type}.txt'
        dev_path = f'../../../data/wiki/sequences/{data_type}/{corpus}_validation_{data_type}.txt'

        for ngram_order in ngram_orders:
            LM_path = f'kenlm/build/LMs/{corpus}_{data_type}_{ngram_order}gram'
            kenlm_output_path = f'../../../output/n-gram/hyperparameter_tuning/dev_{corpus}_{data_type}_{ngram_order}gram.txt'
            surprisal_output_path = f'../../../output/n-gram/hyperparameter_tuning/dev_{corpus}_{data_type}_{ngram_order}gram_surprisal.csv'

            if not os.path.exists(f'{LM_path}.binary'):
                train_command = f'kenlm/build/bin/lmplz -o {ngram_order} < {data_path} > {LM_path}.arpa'
                os.system(train_command)
                convert_command = f'kenlm/build/bin/build_binary {LM_path}.arpa {LM_path}.binary'
                os.system(convert_command)

            if not os.path.exists(kenlm_output_path):
                open(kenlm_output_path, "w").close()
                with open(dev_path) as file:
                    stimuli = file.read().split('\n')

                for stimulus in stimuli:
                    query_command = f'echo "{stimulus}" | kenlm/build/bin/query {LM_path}.binary >> {kenlm_output_path}'

                    os.system(query_command)
                    os.system(f'echo >> {kenlm_output_path}')

            with open(kenlm_output_path, 'r') as file:
                lines = file.read()
                lines = lines.split('\n')
                sentences = [lines[i] for i in range(0, len(lines) - 1, 6)]


            with open(surprisal_output_path, 'w') as file:
                csv_out = csv.writer(file)
                for sentence in sentences:
                    words = sentence.split('\t')
                    for i in range(len(words) - 1):
                        word = words[i].split('=')[0]
                        prob = words[i].split()[2]
                        csv_out.writerow((word, -float(prob) / math.log10(math.exp(1)))) # convert to base e
                    csv_out.writerow(('', ''))



if __name__ == "__main__":
    main()
