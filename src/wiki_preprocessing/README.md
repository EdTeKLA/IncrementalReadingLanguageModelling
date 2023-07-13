# WikiText-2 Data Preprocessing

To preprocess the WikiText-2 data first run preprocess_sequences.py. 

Then remove line 21960 from the train files for all sequence data
* data/wiki/sequences/pos/wiki_train_pos.txt (pos: NNP NN CD : '' NN CD) 
* data/wiki/sequences/word/wiki_train_word.txt (word: cd cdcl2 CD alcl3 cd2 alcl4 CD)
* data/wiki/sequences/word/wiki_train_word.txt (word/POS: cd/NNP cdcl2/NN CD/CD alcl3/: cd2/'' alcl4/NN CD/CD)

Then correct line 2921 for the test files for all sequence data with POS tags
* data/wiki/sequences/pos/wiki_test_pos.txt -RRB- to RB
* data/wiki/sequences/pos/wiki_test_word_pos.txt better/-RRB- to better/RB


Then run generate_trees_from_sequences.py to generate the trees from the WikiText-2 data.