import math
import csv


def get_total_perplexity(surprisal_path):
    total_count = 0
    count = 0
    total_surp = 0
    with open(surprisal_path, 'r') as file:
        surprisals = csv.reader(file, delimiter=",", quotechar='"')
        for row in surprisals:
            total_count += 1
            word = row[0]
            surp = row[1]
            if word != "</s>" and word != "":
                count += 1
                total_surp += float(surp)

    return math.exp(total_surp / count)


def main():
    ngram_orders = [2, 3, 4, 5, 6]
    corpus = 'wiki'
    data_types = ['word', 'pos', 'word_pos']

    perplexity_path = f'../../../output/n-gram/hyperparameter_tuning/summary.csv'

    with open(perplexity_path, 'w') as out_file:
        out_writer = csv.writer(out_file, delimiter=",", quotechar='"')
        for data_type in data_types:
            for ngram_order in ngram_orders:
                surprisal_path = f'../../../output/n-gram/hyperparameter_tuning/dev_{corpus}_{data_type}_{ngram_order}gram_surprisal.csv'
                perplexity = get_total_perplexity(surprisal_path)

                out_writer.writerow([data_type, ngram_order, perplexity])


if __name__ == "__main__":
    main()
