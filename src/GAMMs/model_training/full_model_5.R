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


for (language in list("S")) {
  save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/winsorized/", language, "/", sep="")
  print(language)
  GAMM_21 <- get_model(language, 21, "original")
  
  # GAMM_22 <- update(GAMM_21, . ~ . + s(n_gram_word_surp_wins, k=3) + ti(n_gram_word_surp_wins, WordNo, k=9) + ti(n_gram_word_surp_wins, WordLength, k=9) + ti(n_gram_word_surp_wins, LogFreq, k=9))
  # saveRDS(GAMM_22, file =paste(save_path, language, "_GAMM_22.rds", sep = ""))
  # 
  # GAMM_23 <- update(GAMM_21, . ~ . + s(n_gram_POS_surp_wins, k=3) + ti(n_gram_POS_surp_wins, WordNo, k=9) + ti(n_gram_POS_surp_wins, WordLength, k=9) + ti(n_gram_POS_surp_wins, LogFreq, k=9))
  # saveRDS(GAMM_23, file =paste(save_path, language, "_GAMM_23.rds", sep = ""))
  # 
  # GAMM_24 <- update(GAMM_21, . ~ . + s(n_gram_word_POS_surp_wins, k=3) + ti(n_gram_word_POS_surp_wins, WordNo, k=9) + ti(n_gram_word_POS_surp_wins, WordLength, k=9) + ti(n_gram_word_POS_surp_wins, LogFreq, k=9))
  # saveRDS(GAMM_24, file =paste(save_path, language, "_GAMM_24.rds", sep = ""))
  # 
  # GAMM_25 <- update(GAMM_21, . ~ . + s(PCFG_total_surp_wins, k=3) + ti(PCFG_total_surp_wins, WordNo, k=9) + ti(PCFG_total_surp_wins, WordLength, k=9) + ti(PCFG_total_surp_wins, LogFreq, k=9))
  # saveRDS(GAMM_25, file =paste(save_path, language, "_GAMM_25.rds", sep = ""))
  
  GAMM_26 <- update(GAMM_21, . ~ . + s(PCFG_syn_surp_wins, k=3) + ti(PCFG_syn_surp_wins, WordNo, k=9) + ti(PCFG_syn_surp_wins, WordLength, k=9) + ti(PCFG_syn_surp_wins, LogFreq, k=9))
  saveRDS(GAMM_26, file =paste(save_path, language, "_GAMM_26.rds", sep = ""))
  
  GAMM_27 <- update(GAMM_21, . ~ . + s(PCFG_lex_surp_wins, k=3) + ti(PCFG_lex_surp_wins, WordNo, k=9) + ti(PCFG_lex_surp_wins, WordLength, k=9) + ti(PCFG_lex_surp_wins, LogFreq, k=9))
  saveRDS(GAMM_27, file =paste(save_path, language, "_GAMM_27.rds", sep = ""))
  
  GAMM_28 <- update(GAMM_21, . ~ . + s(PCFG_pos_surp_wins, k=3) + ti(PCFG_pos_surp_wins, WordNo, k=9) + ti(PCFG_pos_surp_wins, WordLength, k=9) + ti(PCFG_pos_surp_wins, LogFreq, k=9))
  saveRDS(GAMM_28, file =paste(save_path, language, "_GAMM_28.rds", sep = ""))
  
  GAMM_29 <- update(GAMM_21, . ~ . + s(RNNG_surp_wins, k=3) + ti(RNNG_surp_wins, WordNo, k=9) + ti(RNNG_surp_wins, WordLength, k=9) + ti(RNNG_surp_wins, LogFreq, k=9))
  saveRDS(GAMM_29, file =paste(save_path, language, "_GAMM_29.rds", sep = ""))
  
  GAMM_30 <- update(GAMM_21, . ~ . + s(transformer_surp_wins, k=3) + ti(transformer_surp_wins, WordNo, k=9) + ti(transformer_surp_wins, WordLength, k=9) + ti(transformer_surp_wins, LogFreq, k=9))
  saveRDS(GAMM_30, file =paste(save_path, language, "_GAMM_30.rds", sep = ""))
  
}
