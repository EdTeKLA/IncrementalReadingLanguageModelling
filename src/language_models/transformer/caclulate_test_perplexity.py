import pandas as pd
import math


def main(data_type):
    results = pd.DataFrame(columns=["lr", "batch_size", "mean_surp", "std_surp", "max_surp", "min_surp", "perplexity"])

    surps = []
    words = []
    if data_type == 'word':
        lr = 0.005
        batch_size = 5
        surp_column = f'parameters_{lr}_{batch_size}_nwp_model_1_11711340'
    elif data_type == 'pos':
        lr = 0.025
        batch_size = 20
        surp_column = f'parameters_{data_type}_{lr}_{batch_size}_nwp_model_1_11711340'


    for split in range(1, 7):
        surp_path = f'../../../output/transformer/{data_type}/test/{split}_test_{data_type}_1620_sentences_{lr}_{batch_size}.csv'

        surp = pd.read_csv(surp_path, low_memory=False)
        word = surp["original word"].values
        surp = surp[surp_column].values
        surps.extend(surp)
        words.extend(word)

    surp = pd.Series(surps)

    results = pd.concat([results, pd.DataFrame({"lr": [lr],
                                                "batch_size": [batch_size],
                                                "mean_surp": [surp.mean()],
                                                "std_surp": [surp.std()],
                                                "max_surp": [surp.max()],
                                                "min_surp": [surp.min()],
                                                "perplexity": [math.exp(surp.mean())]})])

    output_path = f'../../../output/transformer/{data_type}/test/test_{data_type}_results.csv'
    results.to_csv(output_path, index=False)

    surp_output_path = f'../../../output/transformer/{data_type}/test/test_{data_type}_transformer_surp.csv'
    surp_results = pd.DataFrame(data={'word': words, 'surp': surps})
    surp_results.to_csv(surp_output_path, index=False, header=False)


if __name__ == '__main__':
    main('word')
    main('pos')
