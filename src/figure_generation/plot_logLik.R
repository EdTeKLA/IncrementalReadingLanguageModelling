library(mgcv)
library(ggplot2)

base_model_num = 21
type = "winsorized"



angle = -45
margin = 3
margin_2 = 0.3
height = 5
width = 6


data <- read.csv(paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/model_performance_metrics/logLik_",type,"_base_model_", base_model_num, ".csv", sep=""))

data
save_path = paste("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/figures/logLik_" ,type,"_base_model_", base_model_num, "_plots/", sep="")

if (base_model_num == 1) {
  y_min = -5
  y_max = 80
  
  
} else if (base_model_num == 11) {
  y_min = -5
  y_max = 60
  
} else if (base_model_num == 21) {
  y_min = -5
  y_max = 250
  
}else if (base_model_num == 41) {
  y_min = -5
  y_max = 38
}


newdata = subset(data, language=="E")
newdata <- newdata[order(-newdata$delta_logLik),]
newdata$surprisal <- factor(newdata$surprisal, levels = newdata$surprisal)
ggplot(newdata, aes(x = surprisal, y = delta_logLik, fill=surprisal)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  geom_hline(yintercept=0, colour = 'black') +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  ylim(y_min, y_max) +
  ylab("\u0394logLik") +
  ggtitle("English") +
  scale_fill_manual(values=newdata$colour) +
  theme(plot.margin = margin(margin_2,margin,margin_2,margin_2, "cm"),
        axis.title.y = element_text(margin = margin(r = 12)),
        axis.text =  element_text(colour = 'black', size = 12),
        text = element_text(colour = 'black', size = 16),
        axis.title.x = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.line.y = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5))
ggsave(filename ="E_logLik.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="E_logLik.png", path = save_path, width=width, height=height, device="png")

newdata = subset(data, language=="C")
newdata <- newdata[order(-newdata$delta_logLik),]
newdata$surprisal <- factor(newdata$surprisal, levels = newdata$surprisal)
ggplot(newdata, aes(x = surprisal, y = delta_logLik, fill=surprisal)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  geom_hline(yintercept=0, colour = 'black') +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  ylim(y_min, y_max) +
  ylab("\u0394logLik") +
  ggtitle("Chinese") +
  scale_fill_manual(values=newdata$colour) +
  theme(plot.margin = margin(margin_2,margin,margin_2,margin_2, "cm"),
        axis.title.y = element_text(margin = margin(r = 12)),
        axis.text =  element_text(colour = 'black', size = 12),
        text = element_text(colour = 'black', size = 16),
        axis.title.x = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.line.y = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5))

ggsave(filename ="C_logLik.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="C_logLik.png", path = save_path, width=width, height=height, device="png")


newdata = subset(data, language=="K")
newdata <- newdata[order(-newdata$delta_logLik),]
newdata$surprisal <- factor(newdata$surprisal, levels = newdata$surprisal)
ggplot(newdata, aes(x = surprisal, y = delta_logLik, fill=surprisal)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  geom_hline(yintercept=0, colour = 'black') +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  ylim(y_min, y_max) +
  ylab("\u0394logLik") +
  ggtitle("Korean") +
  scale_fill_manual(values=newdata$colour) +
  theme(plot.margin = margin(margin_2,margin,margin_2,margin_2, "cm"),
        axis.title.y = element_text(margin = margin(r = 12)),
        axis.text =  element_text(colour = 'black', size = 12),
        text = element_text(colour = 'black', size = 16),
        axis.title.x = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.line.y = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5))

ggsave(filename ="K_logLik.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="K_logLik.png", path = save_path, width=width, height=height, device="png")


newdata = subset(data, language=="S")
newdata <- newdata[order(-newdata$delta_logLik),]
newdata$surprisal <- factor(newdata$surprisal, levels = newdata$surprisal)
ggplot(newdata, aes(x = surprisal, y = delta_logLik, fill=surprisal)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  geom_hline(yintercept=0, colour = 'black') +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  ylim(y_min, y_max) +
  ylab("\u0394logLik") +
  ggtitle("Spanish") +
  scale_fill_manual(values=newdata$colour) +
  theme(plot.margin = margin(margin_2,margin,margin_2,margin_2, "cm"),
        axis.title.y = element_text(margin = margin(r = 12)),
        axis.text =  element_text(colour = 'black', size = 12),
        text = element_text(colour = 'black', size = 16),
        axis.title.x = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.line.y = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5))

ggsave(filename ="S_logLik.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="S_logLik.png", path = save_path, width=width, height=height, device="png")


