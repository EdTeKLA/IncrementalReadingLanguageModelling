from nltk.tokenize import sent_tokenize
import re

def splitWriteSents(filename, filename_output):
    #not_new_article = ['= De <unk> a <unk> : interviews with persons affected by the 2010 Haiti earthquake =', '= 14.1 years ) , <unk> ( t1 / 2 =', '= Played , W =', '= Losses , D =', '= Ties , A =', '= <unk> points , <unk> =', '= <unk> / <unk> , Pts =', '= Played , W =', '= Ties , L =', '= No result , Pts =', '= Played , W =', '= Losses , T =', '= No result , Pts =', '= Played , W =', '= Ties , L =', '= No result , Pts =', '= Played , W =', '= Losses , T =', '= No result , Pts =', '= 10.6 ° compared to 7 ° for Mercury and 17 ° for Pluto ) and moderately eccentric ( e =', '= and =', '= 7 / 2 ) <unk> the <unk> , which is induced by eliminating this local moment ( J =']
    org_lines = open(filename, 'r').readlines()
    f = open(filename_output, 'w')
    for line in org_lines:
        line = line.strip()
        line = re.sub(r" @", r"", line)
        line = re.sub(r"@ ", r"", line)

        matchObj = re.match(r'^=\s[^=;]+\s=$', line) # match title
        if not matchObj:  
            prts = sent_tokenize(line)
            for prt in prts:
                # Remove URLs
                matchObj = re.match(r'(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.(com|org)(\.[a-z]{2,3})?', prt)
                if matchObj:
                    continue
                words = prt.strip().split()
                for word in words:
                    # check if anything not A-Za-z.,<>0-9
                    matchObj = re.match(r'[^A-Za-z,\.<>0-9]+', word)
                    if matchObj:
                        continue
                    if word != "" and word != "\n":
                        f.write(word.strip() + " ")
                f.write("\n")

        
    f.close()
    return

if __name__ == "__main__":
    filename = '/home/dteodore/projects/def-cepp/dteodore/wikitext2/test.txt'
    filename_output = '/home/dteodore/projects/def-cepp/dteodore/wiki_test_clean.txt'

    splitWriteSents(filename, filename_output)
