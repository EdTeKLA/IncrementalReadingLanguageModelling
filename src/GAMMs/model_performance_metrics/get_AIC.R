library(mgcv)



get_model <- function(language, model_num, type) {
  filename <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}

colours = list("#348ABD",
               "#188487",
               "#FDBF11",
               "#E24A33",
               "#FC7E5E",
               "#7E2F8E",
               "#AF7F3D",
               "#33BBCC",
               "#E586B6")

x_labels = list("N-Gram Word Surprisal",
                "N-Gram POS Surprisal",
                "N-Gram Word/POS Surprisal",
                "PCFG Total Surprisal",
                "PCFG Syntactic Surprisal",
                "PCFG Lexical Surprisal",
                "PCFG POS Surprisal",
                "RNNG Surprisal",
                "Transformer Surprisal")

base_model_num <- 21
type <- "original"

df = data.frame()
for (language in list("E", "C", "K")) {
  for (model_num in 1:9) {
    base_model <- get_model(language, base_model_num, "original")
    full_model <- get_model(language, model_num+base_model_num, type)
    delta_AIC = AIC(base_model) - AIC(full_model)
    df = rbind(df, c(language, x_labels[[model_num]], delta_AIC, colours[[model_num]]))
    print(paste(language, x_labels[[model_num]], delta_AIC, colours[[model_num]], sep=","))
  }
}

colnames(df) <- c("language", "surprisal", "delta_AIC", "colour")

df
write.csv(df, paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/model_performance_metrics/AIC_",type,"_base_model_", base_model_num, ".csv", sep=""), row.names=FALSE, quote=FALSE) 





