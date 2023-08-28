library(mgcv)

get_model <- function(language, model_num, type) {
  filename <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}

GAMM_1 <- get_model("E", 62, "original")

gam.check(GAMM_1)
summary(GAMM_1)
concurvity(GAMM_1, full=TRUE)
plot(GAMM_1)
