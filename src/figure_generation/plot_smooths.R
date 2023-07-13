library(mgcv)
library(ggplot2)
library(gratia)

data_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/all_data_cleaned.csv"
data <- read.csv(data_path)

head(data)

data$Subject = factor(data$Subject)
data$Word = factor(data$Word)
data$procWord = factor(data$procWord)
data$procWordID = factor(data$procWordID)
data$WordID = factor(data$WordID)
data$POS = factor(data$POS)
data$Trial = factor(data$Trial)
data$HasPunct = factor(data$HasPunct)
data$SentPos = factor(data$SentPos)



get_model <- function(language, model_num, type) {
  filename <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/", type, "/", language, "/", language, "_GAMM_", model_num, ".rds", sep = "")
  readRDS(filename)
}



x_labels = list("N-Gram Word Surprisal",
                "N-Gram POS Surprisal",
                "N-Gram Word/POS Surprisal",
                "PCFG Total Surprisal",
                "PCFG Syntactic Surprisal",
                "PCFG Lexical Surprisal",
                "PCFG POS Surprisal",
                "RNNG Surprisal",
                "Transformer Surprisal")

colours = list("#348ABD",
               "#188487",
               "#FDBF11",
               "#E24A33",
               "#FC7E5E",
               "#7E2F8E",
               "#AF7F3D",
               "#33BBCC",
               "#E586B6")


type = "original"
base_model_num = 1
residuals = TRUE

if (base_model_num == 1) {
  select_opt = 10
} else if (base_model_num == 11) {
  select_opt = 4
}
if (type == "winsorized") {
  y_min = -40
  y_max = 40
  
  x_mins = list(min(data$n_gram_word_surp_wins),
                min(data$n_gram_POS_surp_wins),
                min(data$n_gram_word_POS_surp_wins),
                min(data$PCFG_total_surp_wins),
                min(data$PCFG_syn_surp_wins),
                min(data$PCFG_lex_surp_wins),
                min(data$PCFG_pos_surp_wins),
                min(data$RNNG_surp_wins),
                min(data$transformer_surp_wins))
  x_maxes = list(max(data$n_gram_word_surp_wins),
                 max(data$n_gram_POS_surp_wins),
                 max(data$n_gram_word_POS_surp_wins),
                 max(data$PCFG_total_surp_wins),
                 max(data$PCFG_syn_surp_wins),
                 max(data$PCFG_lex_surp_wins),
                 max(data$PCFG_pos_surp_wins),
                 max(data$RNNG_surp_wins),
                 max(data$transformer_surp_wins))
} else {
  y_min = -70
  y_max = 70
  
  x_mins = list(min(data$n_gram_word_surp),
                min(data$n_gram_POS_surp),
                min(data$n_gram_word_POS_surp),
                min(data$PCFG_total_surp),
                min(data$PCFG_syn_surp),
                min(data$PCFG_lex_surp),
                min(data$PCFG_pos_surp),
                min(data$RNNG_surp),
                min(data$transformer_surp))
  x_maxes = list(max(data$n_gram_word_surp),
                 max(data$n_gram_POS_surp),
                 max(data$n_gram_word_POS_surp),
                 max(data$PCFG_total_surp),
                 max(data$PCFG_syn_surp),
                 max(data$PCFG_lex_surp),
                 max(data$PCFG_pos_surp),
                 max(data$RNNG_surp),
                 max(data$transformer_surp))
}


save_path = paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/figures/smooth_" ,type,"_base_model_", base_model_num, "_plots", sep="")


for (language in list("E", "C", "K", "S")) {
  for (model in 1:9) {
    b <- get_model(language, model+base_model_num, type)
    exponent <- function(x) {
      exp(x+coef(b)[1]) - exp(coef(b)[1])
    }
    if (model == 2 | model == 5 | model == 7) {
      # ,fun = exponent
      draw(b, rug= FALSE, select=select_opt, fun = exponent, smooth_col = colours[[model]], ci_col = colours[[model]]) + labs(x=x_labels[model]) + 
        ylim(y_min, y_max) +
        scale_x_continuous(breaks=seq(0,30,by=1), limits = c(x_mins[[model]],x_maxes[[model]])) +
        theme(axis.text.x = element_text(colour = 'black'),
              axis.text.y = element_text(colour = 'black'),
              plot.title=element_blank(),
              axis.title.y = element_blank(),
              plot.caption = element_blank(),
              axis.title.x = element_text(margin = margin(t = 12)),
              panel.background = element_rect(fill = "white"),
              panel.border = element_rect(colour = "black", fill=NA, linewidth=0.7))
    }
    else {
      # , fun = exponent
      draw(b, rug= FALSE, select=select_opt,fun = exponent, smooth_col = colours[[model]], ci_col = colours[[model]]) + labs(x=x_labels[model]) + 
        ylim(y_min, y_max) +
        scale_x_continuous(breaks=seq(0,30,by=2), limits = c(x_mins[[model]],x_maxes[[model]])) +
        theme(axis.text.x = element_text(colour = 'black'),
              axis.text.y = element_text(colour = 'black'),
              plot.title=element_blank(),
              axis.title.y = element_blank(),
              plot.caption = element_blank(),
              axis.title.x = element_text(margin = margin(t = 12)),
              panel.background = element_rect(fill = "white"),
              panel.border = element_rect(colour = "black", fill=NA, linewidth=0.7))
    }
    ggsave(filename =paste(language,"_", model,".svg", sep=""), path = save_path, width=2.5, height=2.5, device="svg")
    
    
  } 
}


