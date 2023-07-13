import math

import pandas as pd


def get_surprisals(path, stimuli):
    surprisal = pd.read_csv(path, header=None, names=['token', 'surp'])
    surprisal = surprisal.dropna()
    surprisal = surprisal[surprisal.token != "</s>"]

    item_nums = []
    word_nos = []
    item_count = 1
    word_count = 0
    num_sentences = 0
    for token in surprisal['token']:
        if path == '../../output/n-gram/word_pos/wiki_L1_word_pos_6gram_surprisal.csv' or path == '../../output/n-gram/word_pos/wiki_L2_word_pos_6gram_surprisal.csv':
            if not (token == ",/," or token == "./."):
                word_count += 1
                word_nos.append(word_count)
                item_nums.append(item_count)
            if token == "./.":
                num_sentences += 1
            if num_sentences == 2:
                item_count += 1
                word_count = 0
                num_sentences = 0
        else:
            if not (token == "," or token == "."):
                word_count += 1
                word_nos.append(word_count)
                item_nums.append(item_count)
            if token == ".":
                num_sentences += 1
            if num_sentences == 2:
                item_count += 1
                word_count = 0
                num_sentences = 0
    if path == '../../output/n-gram/word_pos/wiki_L1_word_pos_6gram_surprisal.csv' or path == '../../output/n-gram/word_pos/wiki_L2_word_pos_6gram_surprisal.csv':
        surprisal = surprisal[surprisal.token != "./."]
        surprisal = surprisal[surprisal.token != ",/,"]
    else:
        surprisal = surprisal[surprisal.token != "."]
        surprisal = surprisal[surprisal.token != ","]
    surprisal['WordNo'] = word_nos
    surprisal['ItemNum'] = item_nums
    surprisal['Stimuli'] = stimuli

    return surprisal


def main():
    surprisal_paths = {'n_gram_word': '../../output/n-gram/word/wiki_L2_word_6gram_surprisal.csv',
                       'n_gram_POS': '../../output/n-gram/pos/wiki_L2_pos_5gram_surprisal.csv',
                       'n_gram_word_POS': '../../output/n-gram/word_pos/wiki_L2_word_pos_6gram_surprisal.csv',
                       'PCFG_total': '../../output/PCFG/L2/L2_word_surp.csv',
                       'PCFG_syn': '../../output/PCFG/L2/L2_word_syn_surp.csv',
                       'PCFG_lex': '../../output/PCFG/L2/L2_word_lex_surp.csv',
                       'PCFG_pos': '../../output/PCFG/L2/L2_pos_surp.csv',
                       'RNNG': '../../output/RNNG/formatted_surprisals/stimuli_L2_RNNG_surp.csv',
                       'transformer': '../../output/transformer/stimuli/stimuli_L2_transformer_surp.csv'
                       }

    surprisal_paths = {'n_gram_word': '../../output/n-gram/word/wiki_test_word_6gram_surprisal.csv',
                       'n_gram_POS': '../../output/n-gram/pos/wiki_test_pos_5gram_surprisal.csv',
                       'n_gram_word_POS': '../../output/n-gram/word_pos/wiki_test_word_pos_6gram_surprisal.csv',

                       'PCFG_total': '../../output/PCFG/test/test_word_surp.csv',

                       'PCFG_syn': '../../output/PCFG/test/test_word_syn_surp.csv',

                       'PCFG_lex': '../../output/PCFG/test/test_word_lex_surp.csv',

                       'PCFG_pos': '../../output/PCFG/test/test_pos_surp.csv',

                       'RNNG': '../../output/RNNG/formatted_surprisals/stimuli_test_RNNG_surp.csv',
                       'transformer': '../../output/transformer/test/test_transformer_surp.csv'
                       }

    for model, path in surprisal_paths.items():
        surp = pd.read_csv(path, header=None,names=["token", "surp"])
        surp = surp[pd.to_numeric(surp['surp'], errors='coerce').notnull()]
        surp = surp[surp.token != "</s>"]
        surp["surp"] = pd.to_numeric(surp['surp'], errors='coerce')
        perplexity = math.exp(surp["surp"].mean())

        surp["surp_wins"] = surp["surp"].clip(
            lower=surp["surp"].quantile(0), upper=surp["surp"].quantile(0.95))
        perplexity_wins = math.exp(surp["surp_wins"].mean())


        print(model, perplexity, perplexity_wins)

if __name__ == "__main__":
    main()
