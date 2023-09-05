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

data <- subset(data, Reader == "E")
# Scatterplot for continuous variables
plot(log(RT) ~ WordLength, data = data, main = "Scatterplot: y vs WordLength")
plot(log(RT) ~ n_gram_word_surp, data = data, main = "Scatterplot: y vs n_gram_word_surp")

# Line plot for categorical/discrete variables
plot(log(RT) ~ WordLength, data = data, type = "l", col = "blue",
     main = "Line Plot: y vs WordLength", xlab = "WordLength", ylab = "log(RT)")

plot(log(RT) ~ n_gram_word_surp, data = data, type = "l", col = "red",
     main = "Line Plot: y vs x2", xlab = "n_gram_word_surp", ylab = "log(RT)")
# 
# Interaction plot for categorical/discrete variables
interaction.plot(x.factor = data$n_gram_word_surp, #x-axis variable
                 trace.factor = data$WordLength, #variable for lines
                 response = log(data$RT), #y-axis variable
                 fun = median, #metric to plot
                 ylab = "log(RT)",
                 xlab = "n_gram_word_surp",
                 col = c("pink", "blue"),
                 lty = 1, #line type
                 lwd = 2, #line width
                 trace.label = "WordLength")


model <- lm(log(RT) ~ n_gram_word_surp, data = data)
plot(model)
model_2 <- lm(log(RT) ~ WordLength, data = data)
plot(model_2)

