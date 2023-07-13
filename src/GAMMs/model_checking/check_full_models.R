library(mgcv)

get_model <- function(language, model_num, type) {
  filename <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}

base_model_num = 1
type = "original"
for (language in list("E", "C", "K", "S")) {
  for (model_num in 1:9) {
    GAMM <- get_model(language, model_num+base_model_num, type)
    print(k.check(GAMM))
  }
}


GAMM <- get_model(language, 1+base_model_num, type)
gam.check(GAMM)
summary(GAMM)
concurvity(GAMM, full=TRUE)
plot(GAMM)
