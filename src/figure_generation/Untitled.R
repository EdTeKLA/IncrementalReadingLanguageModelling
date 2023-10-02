library(dplyr)
library(DescTools)

# load data
data_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/all_data.csv"

data <- read.csv(data_path)
head(data)
nrow(data)

english <- subset(data, Reader == "E")
(nrow(english) - nrow(subset(english, ACC == 1)))/nrow(english)
english_1 <- english %>% group_by(Subject) %>%
  filter(RT <= mean(RT) + (2.5 * sd(RT)),  RT >= mean(RT) - (2.5 * sd(RT)))
(nrow(english) - nrow(english_1))/nrow(english)
(nrow(english) - nrow(subset(english, RT >= 50 & RT <= 2000)))/nrow(english)


chinese <- subset(data, Reader == "C")
(nrow(chinese) - nrow(subset(chinese, ACC == 1)))/nrow(chinese)
chinese_1 <- chinese %>% group_by(Subject) %>%
  filter(RT <= mean(RT) + (2.5 * sd(RT)),  RT >= mean(RT) - (2.5 * sd(RT)))
(nrow(chinese) - nrow(chinese_1))/nrow(chinese)
(nrow(chinese) - nrow(subset(chinese, RT >= 50 & RT <= 2000)))/nrow(chinese)

korean <- subset (data, Reader == "K")
korean <- subset(korean, Subject != "K07")
(nrow(korean) - nrow(subset(korean, ACC == 1)))/nrow(korean)
korean_1 <- korean %>% group_by(Subject) %>%
  filter(RT <= mean(RT) + (2.5 * sd(RT)),  RT >= mean(RT) - (2.5 * sd(RT)))
(nrow(korean) - nrow(korean_1))/nrow(korean)
(nrow(korean) - nrow(subset(korean, RT >= 50 & RT <= 2000)))/nrow(korean)
(nrow(korean) - nrow(subset(korean, Subject != "K07")))/nrow(korean)


spanish <- subset(data, Reader == "S")
(nrow(spanish) - nrow(subset(spanish, ACC == 1)))/nrow(spanish)
spanish_1 <- spanish %>% group_by(Subject) %>%
  filter(RT <= mean(RT) + (2.5 * sd(RT)),  RT >= mean(RT) - (2.5 * sd(RT)))
(nrow(spanish) - nrow(spanish_1))/nrow(spanish)
(nrow(spanish) - nrow(subset(spanish, RT >= 50 & RT <= 2000)))/nrow(spanish)




