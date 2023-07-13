library("ggplot2")
library("plyr")
library("reshape2")
library("patchwork")
library("coin")
# load data
# http://www.sthda.com/english/wiki/kruskal-wallis-test-in-r

data_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/data/reading_time/proficiency.csv"
data <- read.csv(data_path)
head(data)
nrow(data)
data
chinese = data$Vocab_Comp_C[!is.na(data$Vocab_Comp_C)]
english = data$Vocab_Comp_E[!is.na(data$Vocab_Comp_E)]
korean = data$Vocab_Comp_K[!is.na(data$Vocab_Comp_K)]
spanish = data$Vocab_Comp_S[!is.na(data$Vocab_Comp_S)]


wilcox.test(english, chinese)


chinese = data$Vocab_Perf_C[!is.na(data$Vocab_Comp_C)]
english = data$Vocab_Perf_E[!is.na(data$Vocab_Comp_E)]
korean = data$Vocab_Perf_K[!is.na(data$Vocab_Comp_K)]
spanish = data$Vocab_Perf_S[!is.na(data$Vocab_Comp_S)]


wilcox.test(english, chinese)


chinese = data$Comprehension_Comp_C[!is.na(data$Vocab_Comp_C)]
english = data$Comprehension_Comp_E[!is.na(data$Vocab_Comp_E)]
korean = data$Comprehension_Comp_K[!is.na(data$Vocab_Comp_K)]
spanish = data$Comprehension_Comp_S[!is.na(data$Vocab_Comp_S)]


wilcox.test(english, chinese)

chinese = data$Comprehension_Perf_C[!is.na(data$Vocab_Comp_C)]
english = data$Comprehension_Perf_E[!is.na(data$Vocab_Comp_E)]
korean = data$Comprehension_Perf_K[!is.na(data$Vocab_Comp_K)]
spanish = data$Comprehension_Perf_S[!is.na(data$Vocab_Comp_S)]


wilcox.test(english, chinese)



data_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/data/reading_time/LOR.csv"
data <- read.csv(data_path)
head(data)
nrow(data)



kruskal.test(LOR ~ Language, data = data)
pairwise.wilcox.test(data$LOR, data$Language, p.adj="holm", exact=F)

chinese_korean_data = subset(data, Language=="Chinese"|Language=="Korean")
chinese_spanish_data = subset(data, Language=="Chinese"|Language=="Spanish")
korean_spanish_data = subset(data, Language=="Korean"|Language=="Spanish")

wilcox_test(LOR ~ factor(Language), data=chinese_korean_data, distribution="exact")
nrow(chinese_korean_data)
wilcox_test(LOR ~ factor(Language), data=chinese_spanish_data, distribution="exact")
nrow(chinese_spanish_data)
wilcox_test(LOR ~ factor(Language), data=korean_spanish_data, distribution="exact")
nrow(korean_spanish_data)



find_outliers <- function(y, coef = 1.5) {
  qs <- c(0, 0.25, 0.5, 0.75, 1)
  stats <- as.numeric(quantile(y, qs))
  iqr <- diff(stats[c(2, 4)])
  
  outliers <- y < (stats[2] - coef * iqr) | y > (stats[4] + coef * iqr)
  
  return(y[outliers])
}


outlier_data <- ddply(data, .(Language), summarise, LOR = find_outliers(LOR))



ggplot(data, aes(x = Language, y = LOR)) +
  geom_boxplot(show.legend = FALSE, outlier.colour = NA, fill="#D1D1D1") +
  geom_dotplot(data = outlier_data, binaxis = "y",
               stackdir = "center", binwidth = 1.25, stackratio = 1.5, dotsize = 2) +
  labs(x="Native Language of Participant", y = "Length of Residence in the U.S. (Years)") +
  scale_y_continuous(breaks=seq(0,264,by=36), labels=function(x)x/12, limits = c(0,264)) +
  theme(axis.text.x = element_text(colour = 'black'),
        axis.text.y = element_text(colour = 'black'),
        axis.title.x = element_text(margin = margin(t = 12)),
        axis.title.y = element_text(margin = margin(r = 12)),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"))


ggsave(filename ="LOR_boxplot.svg", path = "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/RT/images/boxplots/", width=4, height=4)

ggplot(data, aes(x = Language, y = LOR)) +
  geom_boxplot(show.legend = FALSE) +
  labs(x="Native Language of Participant", y = "Length of Residence in the U.S. (Years)") +
  scale_y_continuous(breaks=seq(0,264,by=48), labels=function(x)x/12, limits = c(0,264))


ggsave(filename ="LOR_boxplot.svg", path = "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/RT/images/boxplots/", width=4, height=4)





ggplot(data, aes(x = Language, y = LOR))+ 
  geom_boxplot(fill='#ededeb', color = "#000000", show.legend = FALSE, outlier.colour = NA) +
  geom_dotplot(data = outlier_data, binaxis = "y",
               stackdir = "center", binwidth = 1.75, stackratio = 1.5, dotsize = 1.25) +
  labs(x="Native Language of Participant", y = "Length of Residence in the U.S. (Years)") +
  scale_y_continuous(breaks=seq(0,264,by=24), labels=function(x)x/12, limits = c(0,264)) +
  theme(axis.text.x = element_text(colour = 'black'),
        axis.text.y = element_text(colour = 'black'),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "white"),
        panel.border = element_rect(colour = "black", fill=NA, size=0.7))


ggsave(filename ="LOR_boxplot.svg", path = "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/RT/images/boxplots/", width=4, height=4)





kruskal.test(LOR ~ Language, data = data)
pairwise.wilcox.test(data$LOR, data$Language,
                     p.adjust.method = "BH")




data_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/data/reading_time/proficiencies.csv"
data <- read.csv(data_path)
head(data)
nrow(data)
data = subset(data, LID != "K07")
performance = subset(data, Measure=="Performance")

kruskal.test(Comp ~ Language, data = performance)
pairwise.wilcox.test(performance$Comp, performance$Language, p.adj="holm", exact=F)


english_chinese_performance = subset(performance, Language=="English"|Language=="Chinese")
english_korean_performance = subset(performance, Language=="English"|Language=="Korean")
english_spanish_performance = subset(performance, Language=="English"|Language=="Spanish")
chinese_korean_performance = subset(performance, Language=="Chinese"|Language=="Korean")
chinese_spanish_performance = subset(performance, Language=="Chinese"|Language=="Spanish")
korean_spanish_performance = subset(performance, Language=="Korean"|Language=="Spanish")


wilcox_test(Comp ~ factor(Language), data=english_chinese_performance, distribution="exact")
nrow(english_chinese_performance)
wilcox_test(Comp ~ factor(Language), data=english_korean_performance, distribution="exact")
nrow(english_korean_performance)
wilcox_test(Comp ~ factor(Language), data=english_spanish_performance, distribution="exact")
nrow(english_spanish_performance)
wilcox_test(Comp ~ factor(Language), data=chinese_korean_performance, distribution="exact")
nrow(chinese_korean_performance)
wilcox_test(Comp ~ factor(Language), data=chinese_spanish_performance, distribution="exact")
nrow(chinese_spanish_performance)
wilcox_test(Comp ~ factor(Language), data=korean_spanish_performance, distribution="exact")
nrow(korean_spanish_performance)


competence = subset(data, Measure=="Competence")

kruskal.test(Comp ~ Language, data = competence)
pairwise.wilcox.test(competence$Comp, competence$Language, p.adj="holm", exact=F)


english_chinese_competence = subset(competence, Language=="English"|Language=="Chinese")
english_korean_competence = subset(competence, Language=="English"|Language=="Korean")
english_spanish_competence = subset(competence, Language=="English"|Language=="Spanish")
chinese_korean_competence = subset(competence, Language=="Chinese"|Language=="Korean")
chinese_spanish_competence = subset(competence, Language=="Chinese"|Language=="Spanish")
korean_spanish_competence = subset(competence, Language=="Korean"|Language=="Spanish")


wilcox_test(Comp ~ factor(Language), data=english_chinese_competence, distribution="exact")
nrow(english_chinese_competence)
wilcox_test(Comp ~ factor(Language), data=english_korean_competence, distribution="exact")
nrow(english_korean_competence)
wilcox_test(Comp ~ factor(Language), data=english_spanish_competence, distribution="exact")
nrow(english_spanish_competence)
wilcox_test(Comp ~ factor(Language), data=chinese_korean_competence, distribution="exact")
nrow(chinese_korean_competence)
wilcox_test(Comp ~ factor(Language), data=chinese_spanish_competence, distribution="exact")
nrow(chinese_spanish_competence)
wilcox_test(Comp ~ factor(Language), data=korean_spanish_competence, distribution="exact")
nrow(korean_spanish_competence)

wilcoxonZ(subset(competence, Language == "English")$Comp, subset(competence, Language == "Chinese")$Comp)



competence = subset(data, Measure=="Competence")

kruskal.test(Comp ~ Language, data = competence)
pairwise.wilcox.test(competence$Comp, competence$Language, p.adj="holm", exact=F)

ggplot(data, aes(x = Language, y = Comp/100, fill = factor(Measure, levels = c("Performance", "Competence"))))+ 
  scale_y_continuous(breaks=seq(0,1,by=0.20), labels = scales::percent, limits = c(0,1)) +
  geom_boxplot() +
  labs(x="Native Language of Participant", y = "English Reading Comprehension Test Scores") +
  theme(axis.text.x = element_text(colour = 'black'),
        axis.text.y = element_text(colour = 'black'),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.key = element_rect(fill = "white"),
        legend.position = "top",
        legend.title = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA, size=0.7)) + 
  scale_x_discrete(limits=c("English","Chinese","Korean", "Spanish")) +
  scale_fill_manual(values=c("#d0d0d0", "#7d7d7d"))

ggsave(filename ="comp_boxplot.svg", path = "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/RT/images/boxplots/", width=4, height=4)


ggplot(data, aes(x = Language, y = Vocab/100, fill = factor(Measure, levels = c("Performance", "Competence"))))+ 
  scale_y_continuous(breaks=seq(0,1,by=0.20), labels = scales::percent, limits = c(0,1)) +
  geom_boxplot() +
  labs(x="Native Language of Participant", y = "English Vocbulary Test Scores") +
  theme(axis.text.x = element_text(colour = 'black'),
        axis.text.y = element_text(colour = 'black'),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "white"),
        legend.key = element_rect(fill = "white"),
        legend.position = "top",
        legend.title = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA, size=0.7)) + 
  scale_x_discrete(limits=c("English","Chinese","Korean", "Spanish")) +
  scale_fill_manual(values=c("#d0d0d0", "#7d7d7d"))


ggsave(filename ="vocab_boxplot.svg", path = "/Users/shannon/Documents/incremental-reading-language-modelling/output/RT/images/boxplots/", width=4, height=4)





data_path <- "/Users/shannon/Documents/incremental-reading-language-modelling/data/reading_time/proficiencies.csv"
data <- read.csv(data_path)
head(data)
nrow(data)


plot1 <- ggplot(data, aes(x = Language, y = Comp/100, fill = factor(Measure, levels = c("Performance", "Competence"))))+ 
  scale_y_continuous(breaks=seq(0,1,by=0.20), labels = scales::percent, limits = c(0,1)) +
  geom_boxplot(outlier.size=1) +
  labs( y = "English Reading Comprehension Test Scores") +
  theme(axis.text.x =  element_text(colour = 'black'),
        legend.position = "top",
        legend.key = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.margin = margin(b = -8),
        axis.title.x = element_blank(),
        axis.title.y = element_text(margin = margin(r = 12)),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black")) +
  scale_x_discrete(limits=c("English","Chinese","Korean", "Spanish")) +
  scale_fill_manual(values=c("#FFFFFF", "#D1D1D1"))
plot1

ggsave(filename ="comp_boxplot.svg", path = "/Users/shannon/Documents/incremental-reading-language-modelling/output/RT/images/boxplots/", width=4, height=4)


plot2 <- ggplot(data, aes(x = Language, y = Vocab/100, fill = factor(Measure, levels = c("Performance", "Competence"))))+ 
  scale_y_continuous(breaks=seq(0,1,by=0.20), labels = scales::percent, limits = c(0,1)) +
  geom_boxplot(show.legend = FALSE, outlier.size=1) +
  labs(x="Native Language of Participant", y = "English Vocbulary Test Scores") +
  theme(axis.text.x = element_text(colour = 'black'),
        axis.text.y = element_text(colour = 'black'),
        axis.title.x = element_text(margin = margin(t = 12)),
        axis.title.y = element_text(margin = margin(r = 12)),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black")) +
  scale_x_discrete(limits=c("English","Chinese","Korean", "Spanish")) +
  scale_fill_manual(values=c("#FFFFFF", "#D1D1D1"))


ggsave(filename ="vocab_boxplot.svg", path = "/Users/shannon/Documents/incremental-reading-language-modelling/output/RT/images/boxplots/", width=4, height=4)


combined_plot <- plot1 / plot2 + plot_layout(ncol = 1)

combined_plot

ggsave(filename ="proficiency.svg", path = "/Users/shannon/Documents/incremental-reading-language-modelling/output/RT/images/boxplots/", width=5, height=8.25)
