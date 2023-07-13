from datasets import load_dataset
import spacy
from spacy.tokenizer import Tokenizer
from tqdm import tqdm
from nltk.tokenize import sent_tokenize
import re
import contractions


def preprocess(data):
    pos_tagger = spacy.load("en_core_web_sm")
    pos_tagger.tokenizer = Tokenizer(pos_tagger.vocab, token_match=re.compile(r'\S+').match)

    word_data = []
    pos_data = []
    word_pos_data = []
    for line in tqdm(data):

        line = line.strip()
        # Split long sentences into multiple shorter sentences
        line = line.replace(" ; ", " . ")
        line = line.replace("...", ":")  # Replace ellipses with their POS tag
        line = line.replace(" can not ", " cannot ")  # For consistency with stimuli
        line = line.replace("-", " ")

        # Remove periods that might confuse the sentence tokenizer but add them back in later
        line = line.replace(" . ", " *ENDOFSENTENCE* ")
        line = line.replace(".", "*MIDDLEOFSENTENCE*")
        line = line.replace(" *ENDOFSENTENCE* ", " . ")

        is_title = re.match(r'^(=\s)+[^=;]+(\s=)+$',
                            line)  # match article titles and subheadings, which are not sentences
        if not is_title:
            sentences = sent_tokenize(line)
            for sent in sentences:
                word_sent = []
                pos_sent = []
                word_pos_sent = []
                sent = sent.replace("*MIDDLEOFSENTENCE*", ".")
                # recombine contractions into one token and then separate them into two full words
                # you 're --> you are
                # Gary 's --> Gary 's (the possessive form is not affected)
                # Occurrences of ' as a quote are removed
                split_contractions = re.findall(r'(\s(\'[a-zA-Z]+))', sent)
                for match in split_contractions:
                    sent = sent.replace(match[0], match[1])
                sent = contractions.fix(sent)
                sent = sent.replace(" ' ", " ")
                sent = sent.replace("'s", " 's")

                original_words = sent.strip().split()
                words = []
                for word in original_words:
                    if not re.match(r'[^A-Za-z,\.0-9\']+', word):
                        words.append(word)
                tags = [word.tag_ for word in pos_tagger(" ".join(words))]

                for i in range(len(words)):
                    word = words[i]
                    tag = tags[i]

                    if ".'" in word:
                        word = word[:-2] + " ."

                    if word != "" and word != "\n" and word != "'":
                        if tag == "CD":
                            word_sent.append(tag)
                            pos_sent.append(tag)
                            word_pos_sent.append(f'{tag}/{tag}')
                        else:
                            word_sent.append(word.strip().lower())
                            pos_sent.append(tag)
                            word_pos_sent.append(f'{word.strip().lower()}/{tag}')

                word_data.append(word_sent)
                pos_data.append(pos_sent)
                word_pos_data.append(word_pos_sent)

    return word_data, pos_data, word_pos_data


def write_to_file(data, filename):
    with open(filename, 'w') as f:
        for sent in data:
            if sent and len(sent) <= 52:
                f.write(f'{" ".join(sent)}\n')


def main():
    for split in ['validation', 'test', 'train']:
        data = load_dataset("wikitext", "wikitext-2-raw-v1", split=split)
        word_data, pos_data, word_pos_data = preprocess(data['text'])

        write_to_file(word_data, f'../../data/wiki/sequences/word/wiki_{split}_word.txt')
        write_to_file(pos_data, f'../../data/wiki/sequences/pos/wiki_{split}_pos.txt')
        write_to_file(word_pos_data, f'../../data/wiki/word_pos/wiki_{split}_word_pos.txt')



if __name__ == "__main__":
    main()
