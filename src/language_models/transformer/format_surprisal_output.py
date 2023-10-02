import pandas as pd
import csv


def main():
    data_types = ['word', 'pos']
    stimuli = ['L1', 'L2']
    for data_type in data_types:
        for stimulus in stimuli:
            if data_type == 'word':
                surprisal_path = f'../../../output/transformer/{data_type}/stimuli/{stimulus}_{data_type}_0.005_5.csv'
                surp_column = 'parameters_0.005_5_nwp_model_1_11711340'
            elif data_type == 'pos':
                surprisal_path = f'../../../output/transformer/{data_type}/stimuli/{stimulus}_{data_type}_0.025_20.csv'
                surp_column = 'parameters_pos_0.025_20_nwp_model_1_11711340'

            surp = pd.read_csv(surprisal_path)
            output_path = f'../../../output/transformer/{data_type}/stimuli/stimuli_{stimulus}_{data_type}_transformer_surp.csv'

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
