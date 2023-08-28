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
  GAMM_31 <- get_model(language, 31, "original")
  
  GAMM_32 <- update(GAMM_31, . ~ . + n_gram_word_surp + n_gram_word_surpPrev1)
  saveRDS(GAMM_32, file =paste(save_path, language, "_GAMM_32.rds", sep = ""))
  
  GAMM_33 <- update(GAMM_31, . ~ . + n_gram_POS_surp + n_gram_POS_surpPrev1)
  saveRDS(GAMM_33, file =paste(save_path, language, "_GAMM_33.rds", sep = ""))
  
  GAMM_34 <- update(GAMM_31, . ~ . + n_gram_word_POS_surp + n_gram_word_POS_surpPrev1)
  saveRDS(GAMM_34, file =paste(save_path, language, "_GAMM_34.rds", sep = ""))
  
  GAMM_35 <- update(GAMM_31, . ~ . + PCFG_total_surp + PCFG_total_surpPrev1)
  saveRDS(GAMM_35, file =paste(save_path, language, "_GAMM_35.rds", sep = ""))
  
  GAMM_36 <- update(GAMM_31, . ~ . + PCFG_syn_surp + PCFG_syn_surpPrev1)
  saveRDS(GAMM_36, file =paste(save_path, language, "_GAMM_36.rds", sep = ""))
  
  GAMM_37 <- update(GAMM_31, . ~ . + PCFG_lex_surp + PCFG_lex_surpPrev1)
  saveRDS(GAMM_37, file =paste(save_path, language, "_GAMM_37.rds", sep = ""))
  
  GAMM_38 <- update(GAMM_31, . ~ . + PCFG_pos_surp +  PCFG_pos_surpPrev1)
  saveRDS(GAMM_38, file =paste(save_path, language, "_GAMM_38.rds", sep = ""))
  
  GAMM_39 <- update(GAMM_31, . ~ . + RNNG_surp + RNNG_surpPrev1)
  saveRDS(GAMM_39, file =paste(save_path, language, "_GAMM_39.rds", sep = ""))
  
  GAMM_40 <- update(GAMM_31, . ~ . + transformer_surp + transformer_surpPrev1)
  saveRDS(GAMM_40, file =paste(save_path, language, "_GAMM_40.rds", sep = ""))
  
}
