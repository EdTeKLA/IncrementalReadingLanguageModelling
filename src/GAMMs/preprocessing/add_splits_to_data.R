library(dplyr)
library(mclust)
library(Matching)


# packageload <- c("dplyr", "rstatix", "dgof", "nortest", "diptest", "LaplacesDemon", "forcats", "mclust", "Matching", "tidyverse", "DescTools")
# lapply(packageload, library, character.only = TRUE)
# 
# 
# used.functions <- NCmisc::list.functions.in.file(filename = rstudioapi::getSourceEditorContext()$path, alphabetic = FALSE) |> print()
# used.packages <- used.functions |> names() |> grep(pattern = "package:", value = TRUE) |> gsub(pattern = "package:", replacement = "") |> print()
# 
# unused.packages <- packageload[!(packageload %in% used.packages)] |> print()


# load data
data_path <- "../../../output/GAMMs/all_data_cleaned.csv"
data <- read.csv(data_path)
head(data)
nrow(data)


log_RT_only <- subset(data, Reader == "K")$log_RT
fit <- Mclust(log_RT_only, G = 2)

summary(fit)
means <- fit$parameters$mean
vars <- fit$parameters$variance$sigmasq

clusters <- vector()
for (subject in unique(subset(data, Reader == "K")$Subject)) {
  print(subject)
  subject_data <- subset(data, Subject == subject)$log_RT
  norm_1 <- rnorm(100000, mean = means[1], sd = sqrt(vars[1]))
  norm_2 <- rnorm(100000, mean = means[2], sd = sqrt(vars[2]))
  res_1 <- ks.boot(subject_data, norm_1)
  res_2 <- ks.boot(subject_data, norm_2)
  if (res_1$ks$statistic < res_2$ks$statistic) {
    print("yes")
    clusters <- append(clusters, "1")
  } else {
    clusters <- append(clusters, "2")
    print("no")
  }
}
nrow(subset(data, Subject == "K01"))
clusters = as.data.frame(clusters)
rownames(clusters) <- unique(subset(data, Reader == "K")$Subject)
clusters

data$ReaderSplit2 = data$Reader
for (subject in unique(subset(data, Reader == "K")$Subject)) {
  data$ReaderSplit2[data$Subject == subject] <-paste("K", clusters[subject,], sep="")
}

log_RT_only <- subset(data, Reader == "C")$log_RT
fit <- Mclust(log_RT_only, G = 2)
summary(fit)
means <- fit$parameters$mean
vars <- fit$parameters$variance$sigmasq

clusters <- vector()
for (subject in unique(subset(data, Reader == "C")$Subject)) {
  print(subject)
  subject_data <- subset(data, Subject == subject)$log_RT
  norm_1 <- rnorm(100000, mean = means[1], sd = sqrt(vars[1]))
  norm_2 <- rnorm(100000, mean = means[2], sd = sqrt(vars[2]))
  res_1 <- ks.boot(subject_data, norm_1)
  res_2 <- ks.boot(subject_data, norm_2)
  if (res_1$ks$statistic < res_2$ks$statistic) {
    print("yes")
    clusters <- append(clusters, "1")
  } else {
    clusters <- append(clusters, "2")
    print("no")
  }
}

clusters = as.data.frame(clusters)
rownames(clusters) <- unique(subset(data, Reader == "C")$Subject)
clusters

for (subject in unique(subset(data, Reader == "C")$Subject)) {
  data$ReaderSplit2[data$Subject == subject] <-paste("C", clusters[subject,], sep="")
}

data = as.data.frame(data)
data
log_RT_only <- subset(data, Reader == "S")$log_RT
fit <- Mclust(log_RT_only, G = 2)
summary(fit)
means <- fit$parameters$mean
vars <- fit$parameters$variance$sigmasq

clusters <- vector()
for (subject in unique(subset(data, Reader == "S")$Subject)) {
  print(subject)
  subject_data <- subset(data, Subject == subject)$log_RT
  norm_1 <- rnorm(100000, mean = means[1], sd = sqrt(vars[1]))
  norm_2 <- rnorm(100000, mean = means[2], sd = sqrt(vars[2]))
  res_1 <- ks.boot(subject_data, norm_1)
  res_2 <- ks.boot(subject_data, norm_2)
  if (res_1$ks$statistic < res_2$ks$statistic) {
    print("yes")
    clusters <- append(clusters, "1")
  } else {
    clusters <- append(clusters, "2")
    print("no")
  }
}

clusters = as.data.frame(clusters)
rownames(clusters) <- unique(subset(data, Reader == "S")$Subject)
clusters

for (subject in unique(subset(data, Reader == "S")$Subject)) {
  data$ReaderSplit2[data$Subject == subject] <-paste("S", clusters[subject,], sep="")
}



data = as.data.frame(data)
data
log_RT_only <- subset(data, Reader == "E")$log_RT
fit <- Mclust(log_RT_only, G = 2)
summary(fit)
means <- fit$parameters$mean
vars <- fit$parameters$variance$sigmasq

clusters <- vector()
for (subject in unique(subset(data, Reader == "E")$Subject)) {
  print(subject)
  subject_data <- subset(data, Subject == subject)$log_RT
  norm_1 <- rnorm(100000, mean = means[1], sd = sqrt(vars[1]))
  norm_2 <- rnorm(100000, mean = means[2], sd = sqrt(vars[2]))
  res_1 <- ks.boot(subject_data, norm_1)
  res_2 <- ks.boot(subject_data, norm_2)
  if (res_1$ks$statistic < res_2$ks$statistic) {
    print("yes")
    clusters <- append(clusters, "1")
  } else {
    clusters <- append(clusters, "2")
    print("no")
  }
}

clusters = as.data.frame(clusters)
rownames(clusters) <- unique(subset(data, Reader == "E")$Subject)
clusters

for (subject in unique(subset(data, Reader == "E")$Subject)) {
  data$ReaderSplit2[data$Subject == subject] <-paste("E", clusters[subject,], sep="")
}

data = as.data.frame(data)
data = as.data.frame(data)




log_RT_only <- subset(data, Reader == "K")$log_RT
fit <- Mclust(log_RT_only, G = 3)
summary(fit)
means <- fit$parameters$mean
vars <- fit$parameters$variance$sigmasq

clusters <- vector()
for (subject in unique(subset(data, Reader == "K")$Subject)) {
  print(subject)
  subject_data <- subset(data, Subject == subject)$log_RT
  norm_1 <- rnorm(100000, mean = means[1], sd = sqrt(vars[1]))
  norm_2 <- rnorm(100000, mean = means[2], sd = sqrt(vars[2]))
  norm_3 <- rnorm(100000, mean = means[2], sd = sqrt(vars[3]))
  res_1 <- ks.boot(subject_data, norm_1)
  res_2 <- ks.boot(subject_data, norm_2)
  res_3 <- ks.boot(subject_data, norm_3)
  if (res_1$ks$statistic <= res_2$ks$statistic & res_1$ks$statistic <= res_3$ks$statistic) {
    clusters <- append(clusters, "1")
    print("1")
  } else if (res_2$ks$statistic < res_1$ks$statistic & res_2$ks$statistic <= res_3$ks$statistic) {
    clusters <- append(clusters, "2")
    print("2")
  } else {
    clusters <- append(clusters, "3")
    print("3")
  }
}

clusters = as.data.frame(clusters)
rownames(clusters) <- unique(subset(data, Reader == "K")$Subject)
clusters

data$ReaderSplit3 = data$Reader
for (subject in unique(subset(data, Reader == "K")$Subject)) {
  data$ReaderSplit3[data$Subject == subject] <-paste("K", clusters[subject,], sep="")
}

data = as.data.frame(data)




unique(data$ReaderSplit2)

head(data)
# split the Korean data into two normally distributed groups
log_means <- subset(data, Reader == "K") %>%
  group_by(Subject) %>%
  summarise_at(vars(log_RT), list(mean_log_RT = mean))

log_means <- as.data.frame(log_means)
rownames(log_means) <- log_means$Subject
log_means$Subject <- NULL
km.res = kmeans(log_means, 2, iter.max = 10, nstart = 2)
log_means <- cbind(log_means, cluster = km.res$cluster)



data$ReaderSplit = data$Reader
for (subject in unique(subset(data, Reader == "K")$Subject)) {
  data$ReaderSplit[data$Subject == subject] <-paste("K", log_means[subject,]$cluster, sep="")
}

data$ReaderSplit3
for (subj in unique(data$Subject[data$ReaderSplit3 == "K3"])) {
  print(subj)
}
data = as.data.frame(data)


data$ReaderSplit4 = data$ReaderSplit2
data$ReaderSplit4[data$ReaderSplit2 == "E1"] <- "E"
data$ReaderSplit4[data$ReaderSplit2 == "E2"] <- "E"
data = as.data.frame(data)

write.csv(data, "../../../output/GAMMs/all_data_cleaned_with_splits.csv", row.names=FALSE)
