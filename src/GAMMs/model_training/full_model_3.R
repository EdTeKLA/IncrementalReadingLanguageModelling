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


for (language in list("E", "C", "K", "S")) {
  save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/winsorized/", language, "/", sep="")
  print(language)
  GAMM_11 <- get_model(language, 11, "original")
  
  GAMM_12 <- update(GAMM_11, . ~ . + s(n_gram_word_surp_wins, k=3))
  saveRDS(GAMM_12, file =paste(save_path, language, "_GAMM_12.rds", sep = ""))
  
  GAMM_13 <- update(GAMM_11, . ~ . + s(n_gram_POS_surp_wins, k=3))
  saveRDS(GAMM_13, file =paste(save_path, language, "_GAMM_13.rds", sep = ""))
  
  GAMM_14 <- update(GAMM_11, . ~ . + s(n_gram_word_POS_surp_wins, k=3))
  saveRDS(GAMM_14, file =paste(save_path, language, "_GAMM_14.rds", sep = ""))
  
  GAMM_15 <- update(GAMM_11, . ~ . + s(PCFG_total_surp_wins, k=3))
  saveRDS(GAMM_15, file =paste(save_path, language, "_GAMM_15.rds", sep = ""))
  
  GAMM_16 <- update(GAMM_11, . ~ . + s(PCFG_syn_surp_wins, k=3))
  saveRDS(GAMM_16, file =paste(save_path, language, "_GAMM_16.rds", sep = ""))
  
  GAMM_17 <- update(GAMM_11, . ~ . + s(PCFG_lex_surp_wins, k=3))
  saveRDS(GAMM_17, file =paste(save_path, language, "_GAMM_17.rds", sep = ""))
  
  GAMM_18 <- update(GAMM_11, . ~ . + s(PCFG_pos_surp_wins, k=3))
  saveRDS(GAMM_18, file =paste(save_path, language, "_GAMM_18.rds", sep = ""))
  
  GAMM_19 <- update(GAMM_11, . ~ . + s(RNNG_surp_wins, k=3))
  saveRDS(GAMM_19, file =paste(save_path, language, "_GAMM_19.rds", sep = ""))
  
  GAMM_20 <- update(GAMM_11, . ~ . + s(transformer_surp_wins, k=3))
  saveRDS(GAMM_20, file =paste(save_path, language, "_GAMM_20.rds", sep = ""))
  
}
