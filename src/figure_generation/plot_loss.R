library(ggplot2)

data <- read.csv("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/transformer/train_val_loss_transformer.csv")
data <- subset(data, Epoch != 0)
ggplot(data) +
  geom_line(aes(x = Epoch, y = TrainingLoss, color = "Training"), linewidth=1.3) +
  geom_line(aes(x = Epoch, y = ValidationLoss, color = "Validation"), linewidth=1.3) +
  labs(x = "Epoch",
       y = "Average Loss per Batch") +
  scale_color_manual(values = c("Training" = "#333333", "Validation" = "#919191")) +
  theme(legend.title = element_blank(),
        legend.position = "top",
        legend.key = element_rect(fill = "white"),
        legend.margin = margin(b = -8),
        axis.title.y = element_text(margin = margin(r = 12)),
        axis.title.x = element_text(margin = margin(t = 12)),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"))

ggsave(filename ="transformer_loss_vs_epochs.svg", path = "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/transformer", width=4, height=4)

data <- read.csv("/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/RNNG/train_val_loss_rnng.csv")
data <- subset(data, Epoch != 0)
ggplot(data) +
  geom_line(aes(x = Epoch, y = TrainingWordPerplexity, color = "Training"), linewidth=1.3) +
  geom_line(aes(x = Epoch, y = ValidationWordPerplexity, color = "Validation"), linewidth=1.3) +
  labs(x = "Epoch",
       y = "Word Perplexity") +
  scale_color_manual(values = c("Training" = "#333333", "Validation" = "#919191")) +
  scale_x_continuous(breaks=seq(0,18,by=3), limits = c(0,18)) +
  theme(legend.title = element_blank(),
        legend.position = "top",
        legend.key = element_rect(fill = "white"),
        legend.margin = margin(b = -8),
        axis.title.y = element_text(margin = margin(r = 12)),
        axis.title.x = element_text(margin = margin(t = 12)),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"))

ggsave(filename ="RNNG_perplexity_vs_epochs.svg", path = "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/RNNG", width=4, height=4)

