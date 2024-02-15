library(ggplot2)
library(ggbreak) 
library(patchwork)

data <- read.csv("../../../transformer/word/train_val_loss_transformer.csv")
# data <- subset(data, Epoch != 0)
data
ggplot(data) +
  geom_line(aes(x = Epoch, y = exp(TrainingLoss), color = "Training"), linewidth=1.3) +
  geom_line(aes(x = Epoch, y = exp(ValidationLoss), color = "Validation"), linewidth=1.3) +
  labs(x = "Epoch",
       y = "Word Perplexity") +
  ylim(0, 70000) +
  scale_color_manual(values = c("Training" = "#333333", "Validation" = "#919191")) +
  scale_y_cut(c(400), which=c(1, 2), scales=c(1, 3), space = 0.8) +
  theme(legend.title = element_blank(),
        legend.position = "top",
        legend.key = element_rect(fill = "white"),
        legend.margin = margin(b = -8),
        axis.text = element_text(colour="black"),
        axis.title.y = element_text(margin = margin(r = 12), angle=90),
        axis.title.x = element_text(margin = margin(t = 12)),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"))

ggsave(filename ="transformer_loss_vs_epochs.svg", path = "../../../transformer/word", width=4, height=4)

data <- read.csv("../../../RNNG/word/train_val_loss_rnng.csv")
data
t2.rect1 <- data.frame (xmin=1.08, xmax=18, ymin=250, ymax=Inf)
# data <- subset(data, Epoch != 0)
ggplot(data) +
  geom_line(aes(x = Epoch, y = TrainingWordPerplexity, color = "Training"), linewidth=1.3) +
  geom_line(aes(x = Epoch, y = ValidationWordPerplexity, color = "Validation"), linewidth=1.3) +
  labs(x = "Epoch",
       y = "Word Perplexity") +
  ylim(0, 80000) +
  scale_color_manual(values = c("Training" = "#333333", "Validation" = "#919191")) +
  scale_y_cut(c(300), which=c(1, 2), scales=c(1, 3), space = 0.8) +
  # geom_rect(data=t2.rect1, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill="white", inherit.aes = FALSE) +
  scale_x_continuous(breaks=seq(0,18,by=3), limits = c(0,18)) +
  theme(legend.title = element_blank(),
        legend.position = "top",
        legend.key = element_rect(fill = "white"),
        legend.margin = margin(b = -8),
        axis.text = element_text(colour="black"),
        axis.title.y = element_text(margin = margin(r = 12), angle=90),
        axis.title.x = element_text(margin = margin(t = 12)),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"))

ggsave(filename ="RNNG_perplexity_vs_epochs.svg", path = "../../../RNNG/word", width=4, height=4)

