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

language = "S"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
GAMM_51 <- get_model(language, 51, "original")

GAMM_57 <- update(GAMM_51, . ~ . + s(PCFG_lex_surp)+
                    ti(PCFG_lex_surp, WordLength) + 
                    ti(PCFG_lex_surp, LogFreq) + 
                    ti(PCFG_lex_surp, WordPos) +
                    PCFG_lex_surp:SentPos)
saveRDS(GAMM_57, file =paste(save_path, language, "_GAMM_57.rds", sep = ""))


GAMM_58 <- update(GAMM_51, . ~ . + s(PCFG_pos_surp)+
                    ti(PCFG_pos_surp, WordLength) + 
                    ti(PCFG_pos_surp, LogFreq) + 
                    ti(PCFG_pos_surp, WordPos) +
                    PCFG_pos_surp:SentPos)
saveRDS(GAMM_58, file =paste(save_path, language, "_GAMM_58.rds", sep = ""))

GAMM_59 <- update(GAMM_51, . ~ . + s(RNNG_surp)+
                    ti(RNNG_surp, WordLength) + 
                    ti(RNNG_surp, LogFreq) + 
                    ti(RNNG_surp, WordPos) +
                    RNNG_surp:SentPos)
saveRDS(GAMM_59, file =paste(save_path, language, "_GAMM_59.rds", sep = ""))

GAMM_60 <- update(GAMM_51, . ~ . + s(transformer_surp)+
                    ti(transformer_surp, WordLength) + 
                    ti(transformer_surp, LogFreq) + 
                    ti(transformer_surp, WordPos) +
                    transformer_surp:SentPos)
saveRDS(GAMM_60, file =paste(save_path, language, "_GAMM_60.rds", sep = ""))


