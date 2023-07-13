import os
from nltk.parse import stanford
from tqdm import tqdm
import re

os.environ['STANFORD_PARSER'] = 'stanford_parser/jars/'
os.environ['STANFORD_MODELS'] = 'stanford_parser/jars/'


def remove_root(tree):
    return tree.replace('(ROOT ', '')[:len(tree) - 5 - 2]


def write_to_file(trees, filename):
    with open(filename, 'w') as f:
        for tree in trees:
            f.write(tree + '\n')


def main():
    for split in ['validation', 'test', 'train']:
        print(f'The {split} set has began')
        sentences = []
        raw_sentences = []
        with open(f'../../data/wiki/sequences/word_pos/wiki_{split}_word_pos.txt', 'r') as file:
            line = file.readline()
            while line:
                raw_sentences.append(line)
                word_pos_tuples = [tuple(word_pos.split("/")) for word_pos in line.split()]
                sentences.append(word_pos_tuples)
                line = file.readline()

        parser = stanford.StanfordParser()

        word_trees = []
        pos_trees = []
        for sentence in tqdm(sentences):
            tree = parser.tagged_parse(sentence)
            for x in tree:
                word_tree = ' '.join(str(x).split())
                word_tree = remove_root(word_tree)
                word_trees.append(word_tree)

                pos_tree = re.sub(r'\(([^\s]+)\s([^\)\s]+)\)', r'(\1 \1)', word_tree.strip())
                pos_trees.append(pos_tree)

        write_to_file(word_trees, f'../../data/wiki/trees/word_trees/wiki_{split}_word_trees.txt')
        write_to_file(pos_trees, f'../../data/wiki/trees/pos_trees/wiki_{split}_pos_trees.txt')


if __name__ == "__main__":
    main()
