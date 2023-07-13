import pandas as pd
import csv


def main():
    stimuli = ['L1', 'L2']
    for stimulus in stimuli:
        surprisal_path = f'../../../output/transformer/stimuli/{stimulus}_0.005_5.csv'
        surp_column = 'parameters_0.005_5_nwp_model_1_11711340'
        surp = pd.read_csv(surprisal_path)
        output_path = f'../../../output/transformer/stimuli/stimuli_{stimulus}_transformer_surp.csv'

        sent_index_counter = 1
        with open(output_path, 'w') as file:
            csv_out = csv.writer(file)
            for _, row in surp.iterrows():
                if sent_index_counter == row['sent_nr']:
                    csv_out.writerow((row['original word'], row[surp_column]))
                elif sent_index_counter < 126:
                    csv_out.writerow(('', ''))
                    csv_out.writerow((row['original word'], row[surp_column]))
                    sent_index_counter += 1


if __name__ == "__main__":
    main()
