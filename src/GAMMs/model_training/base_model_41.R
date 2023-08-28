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
data$SentPos = factor(data$SentPos)

data <- subset(data, IncludePrev1 == "True")
data

language = "E"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
GAMM_41 <- bam(log(RT)~s(Subject, bs = "fs", k=31, fx=TRUE) + s(Trial, bs = "fs", k=63, fx=TRUE) + s(procWordID, bs="fs", k=463, fx=TRUE) + Comp_Competence.Acc + Vocab_Competence.Acc + s(WordNo, k=3, fx=TRUE) + te(LogFreq, WordLength, k=3, fx=TRUE) + te(LogFreqPrev1, WordLengthPrev1, k=3, fx=TRUE), method = "ML", data=subset(data, Reader==language))
saveRDS(GAMM_41, file =paste(save_path, language, "_GAMM_41.rds", sep = ""))

language = "C"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
GAMM_41 <- bam(log(RT)~s(Subject, bs = "fs", k=33, fx=TRUE) + s(Trial, bs = "fs", k=62, fx=TRUE) + s(procWordID, bs="fs", k=392, fx=TRUE) + Comp_Competence.Acc + Vocab_Competence.Acc + s(WordNo, k=3, fx=TRUE) + te(LogFreq, WordLength, k=3, fx=TRUE) + te(LogFreqPrev1, WordLengthPrev1, k=4, fx=TRUE), method = "ML", data=subset(data, Reader==language))
saveRDS(GAMM_41, file =paste(save_path, language, "_GAMM_41.rds", sep = ""))

language = "K"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
GAMM_41 <- bam(log(RT)~s(Subject, bs = "fs", k=26, fx=TRUE) + s(Trial, bs = "fs", k =54, fx=TRUE) + s(procWordID, bs="fs", k=280, fx=TRUE) + Comp_Competence.Acc + Vocab_Competence.Acc + s(WordNo, k=3, fx=TRUE) + te(LogFreq, WordLength, k=3, fx=TRUE) + te(LogFreqPrev1, WordLengthPrev1, k=3, fx=TRUE), method = "ML", data=subset(data, Reader==language))
saveRDS(GAMM_41, file =paste(save_path, language, "_GAMM_41.rds", sep = ""))

language = "S"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
GAMM_41 <- bam(log(RT)~s(Subject, bs = "fs", k=42, fx=TRUE) + s(Trial, bs = "fs", k=63, fx=TRUE) + s(procWordID, bs="fs", k=451, fx=TRUE) + Comp_Competence.Acc + Vocab_Competence.Acc + s(WordNo, k=3, fx=TRUE) + te(LogFreq, WordLength, k=3, fx=TRUE) + te(LogFreqPrev1, WordLengthPrev1, k=3, fx=TRUE), method = "ML", data=subset(data, Reader==language))
saveRDS(GAMM_41, file =paste(save_path, language, "_GAMM_41.rds", sep = ""))



