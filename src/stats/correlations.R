# load data
data_path <- "../../output/RT/all_data_cleaned.csv"
data <- read.csv(data_path)
head(data)
nrow(data)

data <- data[!duplicated(data[,c('procWord')]),]
head(data)
nrow(data)

cor(data$LogFreq, data$WordLength)

cor(data$LogFreq, data$n_gram_word_surp)
cor(data$LogFreq, data$n_gram_POS_surp)
cor(data$LogFreq, data$n_gram_word_POS_surp)

cor(data$LogFreq, data$PCFG_total_surp)
cor(data$LogFreq, data$PCFG_syn_surp)
cor(data$LogFreq, data$PCFG_lex_surp)
cor(data$LogFreq, data$PCFG_demberg_surp)

cor(data$LogFreq, data$transformer_surp)

cor(data$LogFreq, data$RNNG_surp)

ggplot(aes(x=data$LogFreq,y=data$n_gram_word_surp),data=data)+
  geom_point()

ggplot(aes(x=data$LogFreq,y=data$WordLength),data=data)+
  geom_point()
