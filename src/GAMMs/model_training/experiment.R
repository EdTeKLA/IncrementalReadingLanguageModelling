library(mgcv)

# load data
data_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/all_data_cleaned.csv"
data <- read.csv(data_path)
head(data)
nrow(data)
data

data$Subject = factor(data$Subject)
data$Word = factor(data$Word)
data$procWord = factor(data$procWord)
data$procWordID= factor(data$procWordID)
data$WordID = factor(data$WordID)
data$POS = factor(data$POS)
data$Trial = factor(data$Trial)
data$HasPunct = factor(data$HasPunct)
# data$SentPos = factor(data$SentPos)

data <- subset(data, IncludePrev1 == "True")
data

# language = "E"
# save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
# 
# m_1 <- bam(log(RT)~ s(Subject, bs = "fs") + 
#                     s(Trial, bs = "fs") + 
#                     s(procWordID, bs="fs") + 
#                     SentPos +
#                     s(Vocab_Competence.Acc) + 
#                     s(Comp_Competence.Acc) + 
#                     s(WordNo) + 
#                     s(WordLength) + 
#                     s(LogFreq) + 
#                     ti(LogFreq, WordLength) + 
#                     s(WordLengthPrev1) + s(LogFreqPrev1) + 
#                     ti(LogFreqPrev1, WordLengthPrev1) + 
#                     s(n_gram_word_surp) + 
#                     ti(n_gram_word_surp, WordLength) + 
#                     ti(n_gram_word_surp, LogFreq) + 
#                     ti(n_gram_word_surp, WordNo) + 
#                     s(n_gram_word_surpPrev1) + 
#                     ti(n_gram_word_surpPrev1, WordLengthPrev1) + 
#                     ti(n_gram_word_surpPrev1, LogFreqPrev1), method = "ML", data=subset(data, Reader==language))
# 
# saveRDS(m_1, file =paste(save_path, language, "_GAMM_m_1.rds", sep = ""))
# 
# summary(m_1)

language = "E"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")

m_2 <- bam(log(RT)~ s(Subject, bs = "fs") + 
             s(Trial, bs = "fs") + 
             s(procWordID, bs="fs") + 
             SentPos +
             s(Vocab_Competence.Acc) + 
             s(Comp_Competence.Acc) + 
             s(WordNo) + 
             s(WordLength) + 
             s(LogFreq) + 
             ti(LogFreq, WordLength) + 
             s(WordLengthPrev1) + 
             s(LogFreqPrev1) + 
             ti(LogFreqPrev1, WordLengthPrev1) + 
             s(n_gram_word_surp) + 
             ti(n_gram_word_surp, WordLength) + 
             ti(n_gram_word_surp, LogFreq) + 
             ti(n_gram_word_surp, WordNo) + 
             s(n_gram_word_surpPrev1) + 
             ti(n_gram_word_surpPrev1, WordLengthPrev1) + 
             ti(n_gram_word_surpPrev1, LogFreqPrev1) +
             ti(n_gram_word_surpPrev1, WordNo-1), method = "ML", data=subset(data, Reader==language), select=TRUE)

saveRDS(m_2, file =paste(save_path, language, "_GAMM_m_2.rds", sep = ""))
