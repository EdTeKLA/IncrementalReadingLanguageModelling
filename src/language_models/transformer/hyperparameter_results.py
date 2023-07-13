import pandas as pd
import math


def main():
    results = pd.DataFrame(columns=["lr", "batch_size", "mean_surp", "std_surp", "max_surp", "min_surp", "perplexity"])
    lrs = [0.0002, 0.001, 0.005, 0.025]
    batch_sizes = [5, 10, 20, 40, 80]
    for lr in lrs:
        for batch_size in batch_sizes:
            surps = []
            words = []
            for split in range(1, 7):
                surp_path = f'../../../output/transformer/hyperparameter_tuning/{split}/{split}_dev_1370_sentences_{lr}_{batch_size}.csv'

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

    output_path = '../../../output/transformer/hyperparameter_tuning/hyperparameter_results.csv'
    results.to_csv(output_path, index=False)



if __name__ == '__main__':
    main()
