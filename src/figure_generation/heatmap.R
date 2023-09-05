library(ggplot2)
library(patchwork)

data_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/term_significance/significance_heatmap.csv"
data <- read.csv(data_path)

data$term <- factor(data$term, levels = rev(c("s(Participant)",
"s(Trial)",
"s(Word)",
"s(VocabAdjPerf)",
"s(ReadingCompAdjPerf)",
"SentPos",
"s(WordPos)",
"s(LogWordFreq)",
"s(WordLength)",
"ti(LogWordFreq,WordLength)",
"s(Surprisal)",
"SentPos:Surprisal",
"ti(Surprisal,WordLength)",
"ti(Surprisal,LogWordFreq)",
"ti(Surprisal,WordPos)")))
data$significance <- factor(data$significance, levels = c("Significant", "Non-Significant", "N/A"))

data$language_model <- factor(data$language_model, levels = c("None (Base Model)", "N-Gram Word", "N-Gram POS", "N-Gram Word/POS", 
                                                              "PCFG Total", "PCFG Lexical", "PCFG Syntactic", "PCFG POS",
                                                              "RNNG", "Transformer"))

angle = -45
width = 4
height = 4
offset = 0.65
big_font = 10
small_font = 8
legend_pos = "top"
legend_key_size = 0.3
geom_col = "black"
geom_size = 0.1
#3289a8
# 5bb097
save_path <- "/Users/shannon/Documents/IncrementalReadingLanguageModelling/output/GAMMs/term_significance/"


# ggplot(subset(data, language == "English"), aes(x = language_model , y = term, fill = significance)) +
#   geom_tile(colour="black") +
#   scale_fill_manual(values = c("Significant" = "#585858", "Non-Significant" = "#dedede", "N/A" = "white")) + 
#   coord_fixed() +
#   scale_x_discrete(guide = guide_axis(angle = angle)) +
#   labs(x="Surprisal Type", y = "Term", title = "English") +
#   theme(legend.position = "right",
#         legend.title = element_blank(),
#         legend.key.size = unit(0.3, 'cm'),
#         legend.text = element_text(colour = 'black', size = small_font),
#         axis.title.y = element_text(margin = margin(r = 12)),
#         axis.title.x = element_text(margin = margin(t = 12)),
#         axis.text =  element_text(colour = 'black', size = small_font),
#         text = element_text(colour = 'black', size = big_font),
#         panel.background = element_rect(fill = "white"),
#         plot.title = element_text(hjust = 0.5))
# 
# ggsave(filename ="E_heatmap.svg", path = save_path, width=width, height=height, device="svg")
# ggsave(filename ="E_heatmap.png", path = save_path, width=width, height=height, device="png")
# 
# ggplot(subset(data, language == "Chinese"), aes(x = language_model , y = term, fill = significance)) +
#   geom_tile(colour="black") +
#   scale_fill_manual(values = c("Significant" = "#585858", "Non-Significant" = "#dedede", "N/A" = "white")) + 
#   coord_fixed() +
#   scale_x_discrete(guide = guide_axis(angle = angle)) +
#   labs(x="Surprisal Type", y = "Term", title = "Chinese") +
#   theme(legend.position = "right",
#         legend.title = element_blank(),
#         legend.text = element_text(colour = 'black', size = small_font),
#         legend.key.size = unit(0.3, 'cm'),
#         axis.title.y = element_text(margin = margin(r = 12)),
#         axis.title.x = element_text(margin = margin(t = 12)),
#         axis.text =  element_text(colour = 'black', size = small_font),
#         text = element_text(colour = 'black', size = big_font),
#         panel.background = element_rect(fill = "white"),
#         plot.title = element_text(hjust = 0.5))
# 
# ggsave(filename ="C_heatmap.svg", path = save_path, width=width, height=height, device="svg")
# ggsave(filename ="C_heatmap.png", path = save_path, width=width, height=height, device="png")
# 
# ggplot(subset(data, language == "Korean"), aes(x = language_model , y = term, fill = significance)) +
#   geom_tile(colour="black") +
#   scale_fill_manual(values = c("Significant" = "#585858", "Non-Significant" = "#dedede", "N/A" = "white")) + 
#   coord_fixed() +
#   scale_x_discrete(guide = guide_axis(angle = angle)) +
#   labs(x="Surprisal Type", y = "Term", title = "Korean") +
#   theme(legend.position = "right",
#         legend.title = element_blank(),
#         legend.text = element_text(colour = 'black', size = small_font),
#         legend.key.size = unit(0.3, 'cm'),
#         axis.title.y = element_text(margin = margin(r = 12)),
#         axis.title.x = element_text(margin = margin(t = 12)),
#         axis.text =  element_text(colour = 'black', size = small_font),
#         text = element_text(colour = 'black', size = big_font),
#         panel.background = element_rect(fill = "white"),
#         plot.title = element_text(hjust = 0.5))
# 
# ggsave(filename ="K_heatmap.svg", path = save_path, width=width, height=height, device="svg")
# ggsave(filename ="K_heatmap.png", path = save_path, width=width, height=height, device="png")
# 
# ggplot(subset(data, language == "Spanish"), aes(x = language_model , y = term, fill = significance)) +
#   geom_tile(colour="black") +
#   scale_fill_manual(values = c("Significant" = "#585858", "Non-Significant" = "#dedede", "N/A" = "white")) + 
#   coord_fixed() +
#   scale_x_discrete(guide = guide_axis(angle = angle)) +
#   labs(x="Surprisal Type", y = "Term", title = "Spanish") +
#   theme(legend.position = "right",
#         legend.title = element_blank(),
#         legend.text = element_text(colour = 'black', size = small_font),
#         legend.key.size = unit(0.3, 'cm'),
#         axis.title.y = element_text(margin = margin(r = 12)),
#         axis.title.x = element_text(margin = margin(t = 12)),
#         axis.text =  element_text(colour = 'black', size = small_font),
#         text = element_text(colour = 'black', size = big_font),
#         panel.background = element_rect(fill = "white"),
#         plot.title = element_text(hjust = 0.5))
# 
# ggsave(filename ="S_heatmap.svg", path = save_path, width=width, height=height, device="svg")
# ggsave(filename ="S_heatmap.png", path = save_path, width=width, height=height, device="png")
# 
# 


ggplot(subset(data, language == "English"), aes(x = language_model , y = term, fill = significance)) +
  geom_tile() +
  scale_fill_manual(values = c("Significant" = "#27374D", "Non-Significant" = "#9DB2BF", "N/A" = "#DDE6ED")) +
  coord_fixed() +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  labs(x=" ", y = "Term", title = "English") +
  theme(legend.position = legend_pos,
        legend.title = element_blank(),
        legend.text = element_text(colour = 'black', size = small_font-2),
        legend.key.size = unit(legend_key_size, 'cm'),
        axis.title.y = element_blank(),
        axis.title.x = element_text(margin = margin(t = 12)),
        axis.text =  element_text(colour = 'black', size = small_font),
        text = element_text(colour = 'black', size = big_font),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5),
        plot.margin = unit(c(0.25, 0, 0, -4), "lines"))

ggsave(filename ="E_heatmap.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="E_heatmap.png", path = save_path, width=width, height=height, device="png")

ggplot(subset(data, language == "Chinese"), aes(x = language_model , y = term, fill = significance)) +
  geom_tile() +
  scale_fill_manual(values = c("Significant" = "#27374D", "Non-Significant" = "#9DB2BF", "N/A" = "#DDE6ED")) +
  coord_fixed() +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  labs(x=" ", y = "Term", title = "Chinese") +
  theme(legend.position = legend_pos,
        legend.title = element_blank(),
        legend.text = element_text(colour = 'black', size = small_font-2),
        legend.key.size = unit(legend_key_size, 'cm'),
        axis.title.y = element_blank(),
        axis.title.x = element_text(margin = margin(t = 12)),
        axis.text =  element_text(colour = 'black', size = small_font),
        text = element_text(colour = 'black', size = big_font),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5),
        plot.margin = unit(c(0.25, 0, 0, -4), "lines"))

ggsave(filename ="C_heatmap.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="C_heatmap.png", path = save_path, width=width, height=height, device="png")

ggplot(subset(data, language == "Korean"), aes(x = language_model , y = term, fill = significance)) +
  geom_tile() +
  scale_fill_manual(values = c("Significant" = "#27374D", "Non-Significant" = "#9DB2BF", "N/A" = "#DDE6ED")) +
  coord_fixed() +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  labs(x="Surprisal Type", y = "Term", title = "Korean") +
  theme(legend.position = legend_pos,
        legend.title = element_blank(),
        legend.text = element_text(colour = 'black', size = small_font-2),
        legend.key.size = unit(legend_key_size, 'cm'),
        axis.title.y = element_blank(),
        axis.title.x = element_text(margin = margin(t = 12)),
        axis.text =  element_text(colour = 'black', size = small_font),
        text = element_text(colour = 'black', size = big_font),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5),
        plot.margin = unit(c(.25, 0, 0, -4), "lines"))

ggsave(filename ="K_heatmap.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="K_heatmap.png", path = save_path, width=width, height=height, device="png")

ggplot(subset(data, language == "Spanish"), aes(x = language_model , y = term, fill = significance)) +
  geom_tile() +
  scale_fill_manual(values = c("Significant" = "#27374D", "Non-Significant" = "#9DB2BF", "N/A" = "#DDE6ED")) +
  coord_fixed() +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  labs(x="Surprisal Type", y = "Term", title = "Spanish") +
  theme(legend.position = legend_pos,
        legend.title = element_blank(),
        legend.text = element_text(colour = 'black', size = small_font-2),
        legend.key.size = unit(legend_key_size, 'cm'),
        axis.title.y = element_blank(),
        axis.title.x = element_text(margin = margin(t = 12)),
        axis.text =  element_text(colour = 'black', size = small_font),
        text = element_text(colour = 'black', size = big_font),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5),
        plot.margin = unit(c(0.25, 0, 0, -4), "lines"))

ggsave(filename ="S_heatmap.svg", path = save_path, width=width, height=height, device="svg")
ggsave(filename ="S_heatmap.png", path = save_path, width=width, height=height, device="png")



