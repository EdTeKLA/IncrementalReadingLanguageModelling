library(mgcv)
library(gratia)

get_model <- function(language, model_num, type) {
  filename <- paste("../../../output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
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
GAMM = get_model("S", 70, "original")
summary(GAMM)
logLik(GAMM)
gam.check(GAMM)

concurvity(GAMM, full=TRUE)
plot(GAMM)

AIC(GAMM)
help(logLik.gam)
coef(GAMM)

width = 6
height = 6
save_path = "../../../output/GAMMs/gam_check_plots"

E = get_model("E", 61, "original")
appraise(E)
ggsave(filename ="E.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="E.png", path = save_path, width=width, height=height, device="png", dpi=400)

K = get_model("K", 61, "original")
appraise(K)
ggsave(filename ="K.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="K.png", path = save_path, width=width, height=height, device="png", dpi=400)


C = get_model("C", 61, "original")
appraise(C)
ggsave(filename ="C.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="C.png", path = save_path, width=width, height=height, device="png", dpi=400)


S = get_model("S", 61, "original")
appraise(S)
ggsave(filename ="S.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="S.png", path = save_path, width=width, height=height, device="png", dpi=400)




qq_file = paste("../../../output/RT/gam_check_plots/",language, "/", model, "/qq_", language, "_GAMM_", model, ".png", sep = "")
png(qq_file, width = 4, height = 4, units = "in", res = 300)
par(mar = c(4.5, 4.5, 1, 1))
qq.gam(b, rep = 0, level = 0.9, type = type, rl.col = 2,
       rep.col = "gray80")
dev.off()

hist_file = paste("../../../output/RT/gam_check_plots/",language, "/", model, "/hist_", language, "_GAMM_", model, ".png", sep = "")
png(hist_file, width = 4, height = 4, units = "in", res = 300)
par(mar = c(4.5, 4.5, 1.5, 1.5))
hist(resid, xlab = "Residuals", main = "Histogram of residuals")
dev.off()

resids_file = paste("../../../output/RT/gam_check_plots/",language, "/", model, "/resids_", language, "_GAMM_", model, ".png", sep = "")
png(resids_file, width = 4, height = 4, units = "in", res = 300)
par(mar = c(4.5, 4.5, 1.5, 1.5))
plot(linpred, resid, main = "Resids vs. linear pred.",
     xlab = "linear predictor", ylab = "residuals")
dev.off()

response_file = paste("../../../output/RT/gam_check_plots/",language, "/", model, "/response_", language, "_GAMM_", model, ".png", sep = "")
png(response_file, width = 4, height = 4, units = "in", res = 300)
par(mar = c(4.5, 4.5, 1.5, 1.5))
plot(fitted(b), observed.y, xlab = "Fitted Values",
     ylab = "Response", main = "Response vs. Fitted Values")
dev.off()
