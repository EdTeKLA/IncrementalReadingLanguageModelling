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

data <- subset(data, IncludePrev1 == "True")
data

get_model <- function(language, model_num, type) {
  filename <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}


for (language in list("E", "C", "K", "S")) {
  save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
  print(language)
  GAMM_41 <- get_model(language, 41, "original")
  
  GAMM_42 <- update(GAMM_41, . ~ . + n_gram_word_surp + n_gram_word_surpPrev1)
  saveRDS(GAMM_42, file =paste(save_path, language, "_GAMM_42.rds", sep = ""))
  
  GAMM_43 <- update(GAMM_41, . ~ . + n_gram_POS_surp + n_gram_POS_surpPrev1)
  saveRDS(GAMM_43, file =paste(save_path, language, "_GAMM_43.rds", sep = ""))
  
  GAMM_44 <- update(GAMM_41, . ~ . + n_gram_word_POS_surp + n_gram_word_POS_surpPrev1)
  saveRDS(GAMM_44, file =paste(save_path, language, "_GAMM_44.rds", sep = ""))
  
  GAMM_45 <- update(GAMM_41, . ~ . + PCFG_total_surp + PCFG_total_surpPrev1)
  saveRDS(GAMM_45, file =paste(save_path, language, "_GAMM_45.rds", sep = ""))
  
  GAMM_46 <- update(GAMM_41, . ~ . + PCFG_syn_surp + PCFG_syn_surpPrev1)
  saveRDS(GAMM_46, file =paste(save_path, language, "_GAMM_46.rds", sep = ""))
  
  GAMM_47 <- update(GAMM_41, . ~ . + PCFG_lex_surp + PCFG_lex_surpPrev1)
  saveRDS(GAMM_47, file =paste(save_path, language, "_GAMM_47.rds", sep = ""))
  
  GAMM_48 <- update(GAMM_41, . ~ . + PCFG_pos_surp +  PCFG_pos_surpPrev1)
  saveRDS(GAMM_48, file =paste(save_path, language, "_GAMM_48.rds", sep = ""))
  
  GAMM_49 <- update(GAMM_41, . ~ . + RNNG_surp + RNNG_surpPrev1)
  saveRDS(GAMM_49, file =paste(save_path, language, "_GAMM_49.rds", sep = ""))
  
  GAMM_50 <- update(GAMM_41, . ~ . + transformer_surp + transformer_surpPrev1)
  saveRDS(GAMM_50, file =paste(save_path, language, "_GAMM_50.rds", sep = ""))
  
}
