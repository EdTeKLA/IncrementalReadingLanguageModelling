library(mgcv)

# load data
data_path <- "../../../output/GAMMs/all_data_cleaned.csv"
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
  filename <- paste("../../../output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}

language = "C"
save_path <- paste("../../../output/GAMMs/models/original/", language, "/", sep="")
GAMM_61 <- get_model(language, 61, "original")

GAMM_67 <- update(GAMM_61, . ~ . + s(PCFG_lex_surp)+
                    ti(PCFG_lex_surp, WordLength) + 
                    ti(PCFG_lex_surp, LogFreq) + 
                    ti(PCFG_lex_surp, WordPos) +
                    PCFG_lex_surp:SentPos)
saveRDS(GAMM_67, file =paste(save_path, language, "_GAMM_67.rds", sep = ""))


GAMM_68 <- update(GAMM_61, . ~ . + s(PCFG_pos_surp)+
                    ti(PCFG_pos_surp, WordLength) + 
                    ti(PCFG_pos_surp, LogFreq) + 
                    ti(PCFG_pos_surp, WordPos) +
                    PCFG_pos_surp:SentPos)
saveRDS(GAMM_68, file =paste(save_path, language, "_GAMM_68.rds", sep = ""))

GAMM_69 <- update(GAMM_61, . ~ . + s(RNNG_surp)+
                    ti(RNNG_surp, WordLength) + 
                    ti(RNNG_surp, LogFreq) + 
                    ti(RNNG_surp, WordPos) +
                    RNNG_surp:SentPos)
saveRDS(GAMM_69, file =paste(save_path, language, "_GAMM_69.rds", sep = ""))

GAMM_70 <- update(GAMM_61, . ~ . + s(transformer_surp)+
                    ti(transformer_surp, WordLength) + 
                    ti(transformer_surp, LogFreq) + 
                    ti(transformer_surp, WordPos) +
                    transformer_surp:SentPos)
saveRDS(GAMM_70, file =paste(save_path, language, "_GAMM_70.rds", sep = ""))


