from collections import Counter
import statistics as stats

stimuli_dir = "../../data/stimuli"
stimuli_names = ["L1", "L2"]

sentences = []

for name in stimuli_names:
    stimuli_path = f"{stimuli_dir}/{name}/stimuli_{name}_word_original.txt"
    with open(stimuli_path, "r") as f:
        sentences.append([line.replace(",", "").replace(".", "").strip() for line in f.readlines()])

L1_sentences = sentences[0]
L2_sentences = sentences[1]

L2_passages = []
count = 0
passage = []
for sentence in L2_sentences:
    if count < 2:
        passage.append(sentence)
    else:
        L2_passages.append(passage)
        passage = [sentence]
        count = 0
    count += 1
L2_passages.append(passage)
L2_passages = [" ".join(passage) for passage in L2_passages]
print(len(L2_sentences))
print(len(L2_passages))
print(L2_passages)
print(L2_sentences)
L2_words = []
for sentence in L2_sentences:
    words = sentence.split()
    for word in words:
        if word != "." and word != ",":
            L2_words.append(word)

print(L2_words)
print(Counter(L2_words))
word_frequencies = Counter(Counter(L2_words).values())
print(word_frequencies)
print(sum(word_frequencies.values()))
L1_unique = []
L2_unique = []
shared = []
for i in range(len(L1_sentences)):
    if L1_sentences[i] in L2_sentences:
        shared.append(L1_sentences[i])
    else:
        L1_unique.append(L1_sentences[i])

    if L2_sentences[i] not in L1_sentences:
        L2_unique.append(L2_sentences[i])

print(f"Number of shared sentences {len(shared)}")
print(f"Number of sentences unique to L1 {len(L1_unique)}")
print(f"Number of sentences unique to L2 {len(L2_unique)}")

L1_lengths = [len(sentence.split()) for sentence in L1_sentences]
L2_lengths = [len(sentence.split()) for sentence in L2_sentences]
L2_passage_lengths = [len(passage.split()) for passage in L2_passages]
L2_word_lengths = [len(word) for word in L2_words]

print(f"The minimum length of an L1 sentence: {min(L1_lengths)}")
print(f"The maximum length of an L1 sentence: {max(L1_lengths)}")

print(f"The minimum length of an L2 sentence: {min(L2_lengths)}")
print(f"The maximum length of an L2 sentence: {max(L2_lengths)}")

print(f"The average length of an L2 sentence: {stats.mean(L2_lengths)}")
print(f"The standard deviation of an L2 sentence: {stats.stdev(L2_lengths)}")

print(f"The minimum length of an L2 passage: {min(L2_passage_lengths)}")
print(f"The maximum length of an L2 passage: {max(L2_passage_lengths)}")

print(f"The average length of an L2 passage: {stats.mean(L2_passage_lengths)}")
print(f"The standard deviation of an L2 passage: {stats.stdev(L2_passage_lengths)}")

print(f"The minimum length of an L2 word: {min(L2_word_lengths)}")
print(f"The maximum length of an L2 word: {max(L2_word_lengths)}")

print(f"The average length of an L2 word: {stats.mean(L2_word_lengths)}")
print(f"The standard deviation of an L2 word: {stats.stdev(L2_word_lengths)}")
