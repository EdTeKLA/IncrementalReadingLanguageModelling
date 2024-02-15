library(mgcv)
library(itsadug)

get_model <- function(language, model_num, models) {
  models[[paste(language, model_num, sep = "_")]]
}



for (model in 81:90) {
  print(model)
}
# "K", "S"
# "E", "S", "C"
for (language in list("E", "C", "K", "S")) {
  for (model in 178) {
    b = get_model(language, model)
    type <- "deviance"  ## "pearson" & "response" are other valid choices
    resid <- residuals(b, type = type)
    linpred <- napredict(b$na.action, b$linear.predictors)
    observed.y <- napredict(b$na.action, b$y)
    
    
    # plot_file = paste("../../../RT/gam_check_plots/",language, "/", model, "/plot_", language, "_GAMM_", model, ".png", sep = "")
    # png(plot_file, width = 4, height = 4, units = "in", res = 300)
    # par(mar = c(4.5, 4.5, 1.5, 1.5))
    # plot(b, pages=0, shade = TRUE, select = 5)
    # dev.off()
    # 
    # plot_file = paste("../../../RT/gam_check_plots/",language, "/", model, "/plot_EQ_", language, "_GAMM_", model, ".png", sep = "")
    # png(plot_file, width = 4, height = 4, units = "in", res = 300)
    # par(mar = c(4.5, 4.5, 1.5, 1.5))
    # plot(b, ylim = c(-20, 20), pages=0, shade = TRUE, select = 5)
    # dev.off()
    
    # plot_file = paste("../../../RT/gam_check_plots/",language, "/", model, "/plot_Prev_", language, "_GAMM_", model, ".png", sep = "")
    # png(plot_file, width = 4, height = 4, units = "in", res = 300)
    # par(mar = c(4.5, 4.5, 1.5, 1.5))
    # plot(b, pages=0, shade = TRUE)
    # dev.off()
    # 
    # plot_file = paste("../../../RT/gam_check_plots/",language, "/", model, "/plot_Prev_EQ_", language, "_GAMM_", model, ".png", sep = "")
    # png(plot_file, width = 4, height = 4, units = "in", res = 300)
    # par(mar = c(4.5, 4.5, 1.5, 1.5))
    # plot(b, ylim = c(-0.08, 0.08), pages=0, shade = TRUE)
    # dev.off()
    # par(mar = c(1, 1, 1, 1))

    qq_file = paste("../../../RT/gam_check_plots/",language, "/", model, "/qq_", language, "_GAMM_", model, ".png", sep = "")
    png(qq_file, width = 4, height = 4, units = "in", res = 300)
    par(mar = c(4.5, 4.5, 1, 1))
    qq.gam(b, rep = 0, level = 0.9, type = type, rl.col = 2,
           rep.col = "gray80")
    dev.off()

    hist_file = paste("../../../RT/gam_check_plots/",language, "/", model, "/hist_", language, "_GAMM_", model, ".png", sep = "")
    png(hist_file, width = 4, height = 4, units = "in", res = 300)
    par(mar = c(4.5, 4.5, 1.5, 1.5))
    hist(resid, xlab = "Residuals", main = "Histogram of residuals")
    dev.off()

    resids_file = paste("../../../RT/gam_check_plots/",language, "/", model, "/resids_", language, "_GAMM_", model, ".png", sep = "")
    png(resids_file, width = 4, height = 4, units = "in", res = 300)
    par(mar = c(4.5, 4.5, 1.5, 1.5))
    plot(linpred, resid, main = "Resids vs. linear pred.",
         xlab = "linear predictor", ylab = "residuals")
    dev.off()

    response_file = paste("../../../RT/gam_check_plots/",language, "/", model, "/response_", language, "_GAMM_", model, ".png", sep = "")
    png(response_file, width = 4, height = 4, units = "in", res = 300)
    par(mar = c(4.5, 4.5, 1.5, 1.5))
    plot(fitted(b), observed.y, xlab = "Fitted Values",
         ylab = "Response", main = "Response vs. Fitted Values")
    dev.off()
  }
}

get_model <- function(language, model_num) {
  filename <- paste("../../../RT/models/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}

for (language in list("E")) {
  for (model in 1:9) {
    b = get_model(language, model+178)
    print(summary(b))
    # print(gam.check(b))
  }
}


b = get_model("S", 178)
gam.check(b)
summary(b)

plot_smooth(b,
            view = "n_gram_word_surp_wins")





concurvity(b, full=FALSE)
AIC(b)

gam.check(b)
summary(b)
k.check(b)

plot(b, shade=TRUE)


for (language in list("K", "C", "E", "S")) {
  print(language)
  for (model in 93:101) {
    model_names <- vector()
    dict_names <- vector()
    model_names <- append(model_names, paste("../../../RT/models/", language, "/", language, "_GAMM_", model, ".rds", sep = ""))
    # model_names <- append(model_names, paste("../../../RT/models/", language, "/", model, ".rds", sep = "")) #individual models
    dict_names <- append(dict_names, paste(language, model, sep = "_"))
    models <- lapply(model_names, function(filename) readRDS(filename))
    names(models) <- dict_names
    
    
    b = get_model(language, model, models)
    print(k.check(b, n.rep=10000))
    # print(AIC(b))
    
  }
}
