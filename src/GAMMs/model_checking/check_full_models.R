library(mgcv)

get_model <- function(language, model_num, type) {
  filename <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}

base_model_num = 61
type = "original"
for (language in list("C")) {
  for (model_num in 1:9) {
    GAMM <- get_model(language, model_num+base_model_num, type)
    print(k.check(GAMM))
    # print(summary(GAMM))
  }
}
GAMM = get_model("K", 21, type)
summary(GAMM)
logLik(GAMM)
gam.check(GAMM)

concurvity(GAMM, full=TRUE)
plot(GAMM)
AIC(GAMM)
help(logLik.gam)
coef(GAMM)
