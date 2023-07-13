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

for (language in list("E", "C", "K", "S")) {
  save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
  GAMM_1 <- bam(log(RT)~s(Subject, bs = "fs") + s(Trial, bs = "fs") + s(procWordID, bs="fs") + s(Comp_Competence.Acc, k=3) + s(Vocab_Competence.Acc, k=3) + s(WordNo, k=3) + s(LogFreq, k=3) + s(WordLength, k=3) +ti(WordLength, LogFreq, k=9), method = "ML", data=subset(data, Reader==language))

  saveRDS(GAMM_1, file =paste(save_path, language, "_GAMM_1.rds", sep = ""))

}
