original_data <- read.csv("../../../output/RT/all_data.csv")

cleaned_data <- read.csv("../../../output/RT/all_data_cleaned.csv")

# nrow(original_data)
original_data_subset <- subset(original_data, Subject != "K07")
nrow(cleaned_data)/nrow(original_data)
nrow(cleaned_data)/nrow(original_data_subset)

