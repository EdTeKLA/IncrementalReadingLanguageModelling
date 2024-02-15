library(ggplot2)
library(dplyr)
library(rstatix)
library(dgof)
library(nortest)
library(diptest)
library(LaplacesDemon)
library(forcats)
library(mclust)
library(Matching)
library(tidyverse)
library(DescTools)


data_path <- "../../output/RT/all_data_cleaned.csv"
img_path = "../../output/RT/images/"
data <- read.csv(data_path)

# check the modality of each group of speakers based on first language
for (language in list("C", "E", "K", "S")) {
  if (is.unimodal(log(subset(data, Reader==language)$RT))) {
    print(paste(language, "is unimodal"), sep=" ")
  }
  else if (is.bimodal(log(subset(data, Reader==language)$RT))) {
    print(paste(language, "is bimodal"), sep=" ")
  }
  else if (is.trimodal(log(subset(data, Reader==language)$RT))) {
    print(paste(language, "is trimodal"), sep=" ")
  }
  print(Modes(log(subset(data, Reader==language)$RT))$modes)
}

# check the modality of each group of speakers based on first language
for (language in list("C", "E", "K1", "K2", "S")) {
  if (is.unimodal(log(subset(data, ReaderSplit==language)$RT))) {
    print(paste(language, "is unimodal"), sep=" ")
  }
  else if (is.bimodal(log(subset(data, ReaderSplit==language)$RT))) {
    print(paste(language, "is bimodal"), sep=" ")
  }
  else if (is.trimodal(log(subset(data, ReaderSplit==language)$RT))) {
    print(paste(language, "is trimodal"), sep=" ")
  }
  print(Modes(log(subset(data, ReaderSplit==language)$RT))$modes)
}


# check the modality of each individual
for (language in list("C", "E", "K", "S")) {
  for (subject in unique(subset(data, Reader==language)$Subject)) {
    if (is.unimodal(log(subset(data, Subject==subject)$RT))) {
      print(paste(subject, "is unimodal"), sep=" ")
    }
    else if (is.bimodal(log(subset(data, Subject==subject)$RT))) {
      print(paste(subject, "is bimodal"), sep=" ")
    }
    else if (is.trimodal(log(subset(data, Subject==subject)$RT))) {
      print(paste(subject, "is trimodal"), sep=" ")
    }
  }
}


# tests for normality
ad.test(log(subset(data, Reader=="S")$RT))

# set width and height for images
width = 8
height = 10


# plot the word frequency
counts = subset(data, Subject=="K01") %>% group_by(Word) %>%tally()
ggplot(counts, aes(x = n)) +
  geom_histogram(fill = "white", colour = "black", bins=40)

# plot the log of reading time to check normality
ggplot(data, aes(x = log(RT))) +
  geom_histogram(fill = "white", colour = "black", bins=100) +
  facet_grid(Reader ~ .)

ggsave(filename ="log_outliers_removed_K07_removed.png", path = img_path, device='png', width=width, height=height, dpi=300)

ggplot(data, aes(x = log(RT))) +
  geom_histogram(fill = "white", colour = "black", bins=100) +
  facet_grid(ReaderSplit ~ .)
ggsave(filename ="split1_log_outliers_removed.png", path = img_path, device='png', width=width, height=height, dpi=300)


ggplot(data, aes(x = log(RT))) +
  geom_histogram(fill = "white", colour = "black", bins=100) +
  facet_grid(ReaderSplit4 ~ .)

ggsave(filename ="split2_L2_log_outliers_removed.png", path = img_path, device='png', width=width+4, height=height, dpi=300)

ggplot(data, aes(x = log(RT))) +
  geom_histogram(fill = "white", colour = "black", bins=100) +
  facet_grid(ReaderSplit3 ~ .)

ggsave(filename ="split3_log_outliers_removed.png", path = img_path, device='png', width=width, height=height, dpi=300)

ggplot(data, aes(sample = log(RT))) +
  stat_qq() + stat_qq_line() +
  facet_grid(Reader ~ .)

ggsave(filename ="log_qq_outliers_removed.png", path = img_path, device='png', width=width, height=height, dpi=300)

ggplot(data, aes(sample = log(RT))) +
  stat_qq() + stat_qq_line() +
  facet_grid(ReaderSplit ~ .)

ggsave(filename ="split1_log_qq_outliers_removed.png", path = img_path, device='png', width=width, height=height, dpi=300)


ggplot(data, aes(sample = log(RT))) +
  stat_qq() + stat_qq_line() +
  facet_grid(ReaderSplit4 ~ .)

ggsave(filename ="split2_L2_log_qq_outliers_removed.png", path = img_path, device='png', width=width+4, height=height, dpi=300)

ggplot(data, aes(sample = log(RT))) +
  stat_qq() + stat_qq_line() +
  facet_grid(ReaderSplit3 ~ .)

ggsave(filename ="split3_log_qq_outliers_removed.png", path = img_path, device='png', width=width, height=height, dpi=300)

# distribution by subject by language
for (language in list("C", "E", "K", "S")) {
  print(language)
  log_means <- subset(data, Reader == language) %>%
    group_by(Subject) %>%
    summarise_at(vars(log_RT), list(mean_log_RT = mean))
  
  ggplot(subset(data, Reader == language), aes(x = log(RT))) +
    geom_histogram(fill = "white", colour = "black", bins=100) +
    facet_grid(fct_relevel(Subject,log_means[order(log_means$mean_log_RT),]$Subject) ~ .) +
    ggtitle(language)
  
  ggsave(filename =paste(language, ".png", sep=""), path = img_path, device='png', width=width, height=height, dpi=300)
  
  
  if (language == "K") {
    ggplot(subset(data, Reader == language), aes(x = log(RT))) +
      geom_histogram(fill = "white", colour = "black", bins=100) +
      facet_grid(fct_relevel(Subject,log_means[order(log_means$mean_log_RT),]$Subject) ~ .) +
      geom_vline(xintercept=5.29554, linetype="solid",color="red", size=0.5) +
      geom_vline(xintercept=5.93869, linetype="solid",color="red", size=0.5) +
      ggtitle(language)
  }
  else {
    ggplot(subset(data, Reader == language), aes(x = log(RT))) +
      geom_histogram(fill = "white", colour = "black", bins=100) +
      facet_grid(fct_relevel(Subject,log_means[order(log_means$mean_log_RT),]$Subject) ~ .) +
      geom_vline(xintercept=Modes(log(subset(data, Reader==language)$RT))$modes, linetype="solid",color="red", size=0.5) +
      ggtitle(language)
  }
  
  ggsave(filename =paste(language, "_modes.png", sep=""), path = img_path, device='png', width=width, height=height, dpi=300)
}


subset(data, ReaderSplit == "K1")
for (language in list("K1", "K2", "K3")) {
  print(language)
  log_means <- subset(data, ReaderSplit3 == language) %>%
    group_by(Subject) %>%
    summarise_at(vars(log_RT), list(mean_log_RT = mean))
  
  ggplot(subset(data, ReaderSplit3 == language), aes(x = log(RT))) +
    geom_histogram(fill = "white", colour = "black", bins=100) +
    facet_grid(fct_relevel(Subject,log_means[order(log_means$mean_log_RT),]$Subject) ~ .) +
    ggtitle(language)
  
  ggsave(filename =paste("split3_", language, ".png", sep=""), path = img_path, device='png', width=width, height=height, dpi=300)
  
  ggplot(subset(data, ReaderSplit3 == language), aes(x = log(RT))) +
    geom_histogram(fill = "white", colour = "black", bins=100) +
    facet_grid(fct_relevel(Subject,log_means[order(log_means$mean_log_RT),]$Subject) ~ .) +
    geom_vline(xintercept=Modes(log(subset(data, ReaderSplit3==language)$RT))$modes, linetype="solid",color="red", size=0.5) +
    ggtitle(language)
  
  
  ggsave(filename =paste("split3_", language, "_modes.png", sep=""), path = img_path, device='png', width=width, height=height, dpi=300)
}


# large size of distribution for each subject
for (subject in unique(data$Subject)) {
  ggplot(subset(data, Subject == subject), aes(x = log(RT))) +
    geom_histogram(fill = "white", colour = "black", bins=50) + 
    ggtitle(subject)
  ggsave(filename =paste(subject, ".png",sep = ""), path = paste(img_path,"subjects/",sep = ""), device='png', width=width, height=height, dpi=300)
  
}


# ggplot(data, aes(x = n_gram_word_surp)) +
#   geom_histogram(aes(y =..density..), fill = "white", colour = "black", bins=25)+
#   stat_function(fun = dnorm, args = list(mean = mean(data$n_gram_word_surp), sd = sd(data$n_gram_word_surp)))
width = 4
data_unique = data[!duplicated(data$WordID),]
data$WordID
unique(data$WordID)
data_unique
ggplot(data_unique, aes(x = n_gram_word_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25)

ggsave(filename ="n_gram_word_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)

ggplot(data_unique, aes(x = n_gram_POS_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$n_gram_POS_surp, n = 6))

ggsave(filename ="n_gram_POS_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)

ggplot(data_unique, aes(x = n_gram_word_POS_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25)

ggsave(filename ="n_gram_word_POS_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)


ggplot(data_unique, aes(x = PCFG_total_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25)

ggsave(filename ="PCFG_total_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)

ggplot(data_unique, aes(x = PCFG_syn_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$PCFG_syn_surp, n = 7))

ggsave(filename ="PCFG_syn_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)


ggplot(data_unique, aes(x = PCFG_lex_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$PCFG_lex_surp, n = 8))

ggsave(filename ="PCFG_lex_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)


ggplot(data_unique, aes(x = PCFG_demberg_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$PCFG_demberg_surp, n = 6))

ggsave(filename ="PCFG_demberg_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)

ggplot(data_unique, aes(x = RNNG_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$RNNG_surp, n = 6))

ggsave(filename ="RNNG_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)


ggplot(data_unique, aes(x = transformer_surp)) +
  geom_histogram(fill = "white", colour = "black", bins=25)

ggsave(filename ="transformer_surp.png", path = paste(img_path,"surprisals/",sep = ""), device='png', width=width, height=width, dpi=300)







ggplot(data_unique, aes(x = n_gram_word_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25)

ggsave(filename ="n_gram_word_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)

ggplot(data_unique, aes(x = n_gram_POS_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$n_gram_POS_surp_wins, n = 6))

ggsave(filename ="n_gram_POS_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)

ggplot(data_unique, aes(x = n_gram_word_POS_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25)

ggsave(filename ="n_gram_word_POS_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)


ggplot(data_unique, aes(x = PCFG_total_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25)

ggsave(filename ="PCFG_total_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)

ggplot(data_unique, aes(x = PCFG_syn_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$PCFG_syn_surp_wins, n = 7))

ggsave(filename ="PCFG_syn_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)


ggplot(data_unique, aes(x = PCFG_lex_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$PCFG_lex_surp_wins, n = 8))

ggsave(filename ="PCFG_lex_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)


ggplot(data_unique, aes(x = PCFG_demberg_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$PCFG_demberg_surp_wins, n = 6))

ggsave(filename ="PCFG_demberg_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)

ggplot(data_unique, aes(x = RNNG_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25) +
  scale_x_continuous(breaks = pretty(data_unique$RNNG_surp_wins, n = 6))

ggsave(filename ="RNNG_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)


ggplot(data_unique, aes(x = transformer_surp_wins)) +
  geom_histogram(fill = "white", colour = "black", bins=25)

ggsave(filename ="transformer_surp_wins.png", path = paste(img_path,"surprisals/winsorized/",sep = ""), device='png', width=width, height=width, dpi=300)






