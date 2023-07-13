from collections import Counter
import math


def get_data_wiki(data_path):
    texts = []
    with open(data_path) as f:
        lines = f.readlines()
        line = " ".join(lines)
        words = [word.lower() for word in line.split(" ") if word.isalpha()]
        texts.extend(words)
    return texts


def get_words(stimuli):
    words = []
    filename = f"../../data/stimuli/{stimuli}/stimuli_{stimuli}_word.txt"
    with open(filename, 'r') as file:
        lines = file.readlines()
        for line in lines:
            line = line.strip().split(' ')
            for word in line:
                if word not in [".", ","]:
                    words.append(word)
    words = list(set(words))
    return words


def counts_to_log_freq(counts):
    total_count = sum(counts.values())

    log_frequencies = {}
    for key, value in counts.items():
        log_frequencies[key] = math.log10(value / total_count)

    return log_frequencies


def get_wiki_frequencies(split):
    texts = get_data_wiki(f"../../data/wiki/sequences/word/wiki_{split}_word.txt")
    counts = Counter(texts)

    all_words_log_freqs = counts_to_log_freq(counts)

    words = get_words("L2")
    stimuli_log_freqs = {}
    for word in words:
        if word in all_words_log_freqs:
            stimuli_log_freqs[word] = all_words_log_freqs[word]
        else:
            stimuli_log_freqs[word] = math.log10(1 / 1000000000)

    return stimuli_log_freqs


def main():
    log_freqs = get_wiki_frequencies("train")



if __name__ == "__main__":
    main()
