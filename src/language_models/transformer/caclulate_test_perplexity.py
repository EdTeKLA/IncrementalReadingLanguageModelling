import pandas as pd
import math


def main():
    results = pd.DataFrame(columns=["lr", "batch_size", "mean_surp", "std_surp", "max_surp", "min_surp", "perplexity"])
    lr = 0.005
    batch_size = 5
    surps = []
    words = []
    for split in range(1, 7):
        surp_path = f'../../../output/transformer/test/{split}_test_1620_sentences_{lr}_{batch_size}.csv'

        surp_column = f'parameters_{lr}_{batch_size}_nwp_model_1_11711340'
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

    output_path = '../../../output/transformer/test/test_results.csv'
    results.to_csv(output_path, index=False)

    surp_output_path = '../../../output/transformer/test/test_transformer_surp.csv'
    surp_results = pd.DataFrame(data={'word': words, 'surp': surps})
    surp_results.to_csv(surp_output_path, index=False, header=False)


if __name__ == '__main__':
    main()
