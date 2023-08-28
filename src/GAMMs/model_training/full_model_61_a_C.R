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

get_model <- function(language, model_num, type) {
  filename <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}

language = "C"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
GAMM_61 <- get_model(language, 61, "original")

GAMM_62 <- update(GAMM_61, . ~ . + s(n_gram_word_surp) +
                    ti(n_gram_word_surp, WordLength) + 
                    ti(n_gram_word_surp, LogFreq) + 
                    ti(n_gram_word_surp, WordPos) +
                    n_gram_word_surp:SentPos) 

saveRDS(GAMM_62, file =paste(save_path, language, "_GAMM_62.rds", sep = ""))

GAMM_63 <- update(GAMM_61, . ~ . + s(n_gram_POS_surp) +
                    ti(n_gram_POS_surp, WordLength) + 
                    ti(n_gram_POS_surp, LogFreq) + 
                    ti(n_gram_POS_surp, WordPos) +
                    n_gram_POS_surp:SentPos)
saveRDS(GAMM_63, file =paste(save_path, language, "_GAMM_63.rds", sep = ""))

GAMM_64 <- update(GAMM_61, . ~ . + s(n_gram_word_POS_surp)+
                    ti(n_gram_word_POS_surp, WordLength) + 
                    ti(n_gram_word_POS_surp, LogFreq) + 
                    ti(n_gram_word_POS_surp, WordPos) +
                    n_gram_word_POS_surp:SentPos)
saveRDS(GAMM_64, file =paste(save_path, language, "_GAMM_64.rds", sep = ""))

GAMM_65 <- update(GAMM_61, . ~ . + s(PCFG_total_surp)+
                    ti(PCFG_total_surp, WordLength) + 
                    ti(PCFG_total_surp, LogFreq) + 
                    ti(PCFG_total_surp, WordPos) +
                    PCFG_total_surp:SentPos)
saveRDS(GAMM_65, file =paste(save_path, language, "_GAMM_65.rds", sep = ""))

GAMM_66 <- update(GAMM_61, . ~ . + s(PCFG_syn_surp)+
                    ti(PCFG_syn_surp, WordLength) + 
                    ti(PCFG_syn_surp, LogFreq) + 
                    ti(PCFG_syn_surp, WordPos) +
                    PCFG_syn_surp:SentPos)
saveRDS(GAMM_66, file =paste(save_path, language, "_GAMM_66.rds", sep = ""))


