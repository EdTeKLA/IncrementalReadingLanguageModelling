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


language = "C"
save_path <- paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/models/original/", language, "/", sep="")
GAMM_51 <- bam(log(RT)~s(Subject, bs = "fs") + 
                 s(Trial, bs = "fs") + 
                 s(procWordID, bs="fs") +  
                 s(Vocab_Competence.Acc) + 
                 s(Comp_Competence.Acc) + 
                 SentPos +
                 s(WordPos) + 
                 s(LogFreq) +
                 s(WordLength) +
                 ti(LogFreq, WordLength), method = "ML", data=subset(data, Reader==language))

saveRDS(GAMM_51, file =paste(save_path, language, "_GAMM_51.rds", sep = ""))

