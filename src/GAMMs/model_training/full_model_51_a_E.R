library(mgcv)

# load data
data_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/all_data_cleaned.csv"
data <- read.csv(data_path)
head(data)
nrow(data)

data$Subject = factor(data$Subject)
data$Word = factor(data$Word)
data$procWord = factor(data$procWord)
data$procWordID= factor(data$procWordID)
data$WordID = factor(data$WordID)
data$POS = factor(data$POS)
data$Trial = factor(data$Trial)
data$HasPunct = factor(data$HasPunct)
data$SentPos = factor(data$SentPos)

get_model <- function(language, model_num, type) {
  filename <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}

language = "E"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
GAMM_51 <- get_model(language, 51, "original")

GAMM_52 <- update(GAMM_51, . ~ . + s(n_gram_word_surp) +
                    ti(n_gram_word_surp, WordLength) + 
                    ti(n_gram_word_surp, LogFreq) + 
                    ti(n_gram_word_surp, WordPos) +
                    n_gram_word_surp:SentPos) 

saveRDS(GAMM_52, file =paste(save_path, language, "_GAMM_52.rds", sep = ""))

GAMM_53 <- update(GAMM_51, . ~ . + s(n_gram_POS_surp) +
                    ti(n_gram_POS_surp, WordLength) + 
                    ti(n_gram_POS_surp, LogFreq) + 
                    ti(n_gram_POS_surp, WordPos) +
                    n_gram_POS_surp:SentPos)
saveRDS(GAMM_53, file =paste(save_path, language, "_GAMM_53.rds", sep = ""))

GAMM_54 <- update(GAMM_51, . ~ . + s(n_gram_word_POS_surp)+
                    ti(n_gram_word_POS_surp, WordLength) + 
                    ti(n_gram_word_POS_surp, LogFreq) + 
                    ti(n_gram_word_POS_surp, WordPos) +
                    n_gram_word_POS_surp:SentPos)
saveRDS(GAMM_54, file =paste(save_path, language, "_GAMM_54.rds", sep = ""))

GAMM_55 <- update(GAMM_51, . ~ . + s(PCFG_total_surp)+
                    ti(PCFG_total_surp, WordLength) + 
                    ti(PCFG_total_surp, LogFreq) + 
                    ti(PCFG_total_surp, WordPos) +
                    PCFG_total_surp:SentPos)
saveRDS(GAMM_55, file =paste(save_path, language, "_GAMM_55.rds", sep = ""))

GAMM_56 <- update(GAMM_51, . ~ . + s(PCFG_syn_surp)+
                    ti(PCFG_syn_surp, WordLength) + 
                    ti(PCFG_syn_surp, LogFreq) + 
                    ti(PCFG_syn_surp, WordPos) +
                    PCFG_syn_surp:SentPos)
saveRDS(GAMM_56, file =paste(save_path, language, "_GAMM_56.rds", sep = ""))


