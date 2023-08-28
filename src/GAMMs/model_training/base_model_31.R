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

for (language in list("E", "C", "K", "S")) {
  print(language)
  save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
  GAMM_31 <- bam(log(RT)~s(Subject, bs = "fs") + s(Trial, bs = "fs") + s(procWordID, bs="fs") + Comp_Competence.Acc + Vocab_Competence.Acc + s(WordNo) + te(LogFreq, WordLength) + te(LogFreqPrev1, WordLengthPrev1), method = "ML", data=subset(data, Reader==language))
  
  saveRDS(GAMM_31, file =paste(save_path, language, "_GAMM_31.rds", sep = ""))
  
}
