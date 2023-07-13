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
  GAMM_1 <- get_model(language, 1, "original")
  if (language != "E") {
    GAMM_2 <- update(GAMM_1, . ~ . + s(n_gram_word_surp_wins, k=3))
    saveRDS(GAMM_2, file =paste(save_path, language, "_GAMM_2.rds", sep = ""))
  
    GAMM_3 <- update(GAMM_1, . ~ . + s(n_gram_POS_surp_wins, k=3))
    saveRDS(GAMM_3, file =paste(save_path, language, "_GAMM_3.rds", sep = ""))
  
    GAMM_4 <- update(GAMM_1, . ~ . + s(n_gram_word_POS_surp_wins, k=3))
    saveRDS(GAMM_4, file =paste(save_path, language, "_GAMM_4.rds", sep = ""))
  }

  GAMM_5 <- update(GAMM_1, . ~ . + s(PCFG_total_surp_wins, k=3))
  saveRDS(GAMM_5, file =paste(save_path, language, "_GAMM_5.rds", sep = ""))

  GAMM_6 <- update(GAMM_1, . ~ . + s(PCFG_syn_surp_wins, k=3))
  saveRDS(GAMM_6, file =paste(save_path, language, "_GAMM_6.rds", sep = ""))

  GAMM_7 <- update(GAMM_1, . ~ . + s(PCFG_lex_surp_wins, k=3))
  saveRDS(GAMM_7, file =paste(save_path, language, "_GAMM_7.rds", sep = ""))

  GAMM_8 <- update(GAMM_1, . ~ . + s(PCFG_pos_surp_wins, k=3))
  saveRDS(GAMM_8, file =paste(save_path, language, "_GAMM_8.rds", sep = ""))

  GAMM_9 <- update(GAMM_1, . ~ . + s(RNNG_surp_wins, k=3))
  saveRDS(GAMM_9, file =paste(save_path, language, "_GAMM_9.rds", sep = ""))

  GAMM_10 <- update(GAMM_1, . ~ . + s(transformer_surp_wins, k=3))
  saveRDS(GAMM_10, file =paste(save_path, language, "_GAMM_10.rds", sep = ""))

}
