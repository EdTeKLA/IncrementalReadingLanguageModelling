library(ggplot2)
library(patchwork)
library(dplyr)
library(coin)
library(rcompanion)
library(rstatix)

save_path = "../../../stats/surprisal_violin_plots"

data_path <- "../../../GAMMs/all_data_cleaned.csv"
data <- read.csv(data_path)
head(data)
nrow(data)

# convert Subject, Word, and Trial to factors
data$Subject = factor(data$Subject)
data$Word = factor(data$Word)
data$procWord = factor(data$procWord)
data$procWordID = factor(data$procWordID)
data$WordID = factor(data$WordID)
data$POS = factor(data$POS)
data$Trial = factor(data$Trial)
data$HasPunct = factor(data$HasPunct)
data$SentPos = factor(data$SentPos)


surprisals <- data[!duplicated(data$WordID),]
surprisals

n_gram_word_surp_df <- data.frame(surp_type = "N-Gram Word Surprisal",
                                 surp_value = surprisals$n_gram_word_surp,
                                 colour = "#348ABD")
n_gram_POS_surp_df <- data.frame(surp_type = "N-Gram POS Surprisal",
                                 surp_value = surprisals$n_gram_POS_surp,
                                 colour = "#188487")
n_gram_word_POS_surp_df <- data.frame(surp_type = "N-Gram Word/POS Surprisal",
                                    surp_value = surprisals$n_gram_word_POS_surp,
                                    colour = "#FDBF11")
PCFG_total_surp_df <- data.frame(surp_type = "PCFG Total Surprisal",
                                 surp_value = surprisals$PCFG_total_surp,
                                 colour = "#E24A33")
PCFG_syn_surp_df <- data.frame(surp_type = "PCFG Syntactic Surprisal",
                                surp_value = surprisals$PCFG_syn_surp,
                               colour = "#FC7E5E")
PCFG_lex_surp_df <- data.frame(surp_type = "PCFG Lexical Surprisal",
                               surp_value = surprisals$PCFG_lex_surp,
                               colour = "#7E2F8E")
PCFG_pos_surp_df <- data.frame(surp_type = "PCFG POS Surprisal",
                               surp_value = surprisals$PCFG_pos_surp,
                               colour = "#AF7F3D")
RNNG_surp_df <- data.frame(surp_type = "RNNG Surprisal",
                           surp_value = surprisals$RNNG_surp,
                           colour = "#33BBCC")
transformer_surp_df <- data.frame(surp_type = "Transformer Surprisal",
                           surp_value = surprisals$transformer_surp,
                           colour = "#E586B6")


violin_df <- rbind(n_gram_word_surp_df, n_gram_POS_surp_df, n_gram_word_POS_surp_df,
                   PCFG_total_surp_df, PCFG_syn_surp_df, PCFG_lex_surp_df, PCFG_pos_surp_df,
                   RNNG_surp_df, transformer_surp_df)

violin_lex_df <- rbind(n_gram_word_surp_df,  n_gram_word_POS_surp_df,
                   PCFG_total_surp_df,  PCFG_lex_surp_df, 
                   RNNG_surp_df, transformer_surp_df)

violin_syn_df <- rbind(n_gram_POS_surp_df, PCFG_syn_surp_df,
                       PCFG_pos_surp_df)



n_gram_word_surp_wins_df <- data.frame(surp_type = "N-Gram Word Surprisal",
                                  surp_value = surprisals$n_gram_word_surp_wins,
                                  colour = "#348ABD")
n_gram_POS_surp_wins_df <- data.frame(surp_type = "N-Gram POS Surprisal",
                                 surp_value = surprisals$n_gram_POS_surp_wins,
                                 colour = "#188487")
n_gram_word_POS_surp_wins_df <- data.frame(surp_type = "N-Gram Word/POS Surprisal",
                                      surp_value = surprisals$n_gram_word_POS_surp_wins,
                                      colour = "#FDBF11")
PCFG_total_surp_wins_df <- data.frame(surp_type = "PCFG Total Surprisal",
                                 surp_value = surprisals$PCFG_total_surp_wins,
                                 colour = "#E24A33")
PCFG_syn_surp_wins_df <- data.frame(surp_type = "PCFG Syntactic Surprisal",
                               surp_value = surprisals$PCFG_syn_surp_wins,
                               colour = "#FC7E5E")
PCFG_lex_surp_wins_df <- data.frame(surp_type = "PCFG Lexical Surprisal",
                               surp_value = surprisals$PCFG_lex_surp_wins,
                               colour = "#7E2F8E")
PCFG_pos_surp_wins_df <- data.frame(surp_type = "PCFG POS Surprisal",
                                   surp_value = surprisals$PCFG_pos_surp_wins,
                                   colour = "#AF7F3D")
RNNG_surp_wins_df <- data.frame(surp_type = "RNNG Surprisal",
                           surp_value = surprisals$RNNG_surp_wins,
                           colour = "#33BBCC")
transformer_surp_wins_df <- data.frame(surp_type = "Transformer Surprisal",
                                  surp_value = surprisals$transformer_surp_wins,
                                  colour = "#E586B6")


violin_wins_df <- rbind(n_gram_word_surp_wins_df, n_gram_POS_surp_wins_df, n_gram_word_POS_surp_wins_df,
                        PCFG_total_surp_wins_df, PCFG_syn_surp_wins_df, PCFG_lex_surp_wins_df, PCFG_pos_surp_wins_df,
                        RNNG_surp_wins_df, transformer_surp_wins_df)

violin_lex_wins_df <- rbind(n_gram_word_surp_wins_df,  n_gram_word_POS_surp_wins_df,
                       PCFG_total_surp_wins_df,  PCFG_lex_surp_wins_df, 
                       RNNG_surp_wins_df, transformer_surp_wins_df)

violin_syn_wins_df <- rbind(n_gram_POS_surp_wins_df, PCFG_syn_surp_wins_df,
                       PCFG_pos_surp_wins_df)




violin_df <- violin_df %>%
  mutate( surp_type=factor(surp_type,levels=c("N-Gram Word Surprisal", "N-Gram POS Surprisal", "N-Gram Word/POS Surprisal","PCFG Total Surprisal", 
                                              "PCFG Lexical Surprisal","PCFG Syntactic Surprisal","PCFG POS Surprisal","RNNG Surprisal", "Transformer Surprisal"))) 

violin_wins_df <- violin_wins_df %>%
  mutate( surp_type=factor(surp_type,levels=c("N-Gram Word Surprisal", "N-Gram Word/POS Surprisal","PCFG Total Surprisal", 
                                              "PCFG Lexical Surprisal","RNNG Surprisal", "Transformer Surprisal",
                                              "N-Gram POS Surprisal", "PCFG Syntactic Surprisal", "PCFG POS Surprisal")) )

violin_lex_df <- violin_lex_df %>%
  mutate( surp_type=factor(surp_type,levels=c("N-Gram Word Surprisal", "N-Gram Word/POS Surprisal","PCFG Total Surprisal", 
                                              "PCFG Lexical Surprisal","RNNG Surprisal", "Transformer Surprisal")) )

violin_syn_df <- violin_syn_df %>%
  mutate( surp_type=factor(surp_type,levels=c("N-Gram POS Surprisal", "PCFG Syntactic Surprisal", "PCFG POS Surprisal")) )



violin_lex_wins_df <- violin_lex_wins_df %>%
  mutate( surp_type=factor(surp_type,levels=c("N-Gram Word Surprisal", "N-Gram Word/POS Surprisal","PCFG Total Surprisal", 
                                              "PCFG Lexical Surprisal","RNNG Surprisal", "Transformer Surprisal")) )

violin_syn_wins_df <- violin_syn_wins_df %>%
  mutate( surp_type=factor(surp_type,levels=c("N-Gram POS Surprisal", "PCFG Syntactic Surprisal", "PCFG POS Surprisal")) )



widths <- c("N-Gram Word Surprisal" = 0.5, "N-Gram Word/POS Surprisal"= 0.5,"PCFG Total Surprisal"= 0.5, 
            "PCFG Lexical Surprisal"= 0.5,"RNNG Surprisal"= 0.5, "Transformer Surprisal"= 0.5,
            "N-Gram POS Surprisal"= 0.5, "PCFG Syntactic Surprisal"= 0.5, "PCFG POS Surprisal"= 0.5)



colours = list("#348ABD",
               "#FDBF11",
               "#E24A33",
               "#7E2F8E",
               "#33BBCC",
               "#E586B6",
               "#188487",
               "#FC7E5E",
               "#AF7F3D")

colours_lex = list("#348ABD",
               "#FDBF11",
               "#E24A33",
               "#7E2F8E",
               "#33BBCC",
               "#E586B6")
               
colours_syn = list("#188487",
                   "#FC7E5E",
                   "#AF7F3D")
angle = -45
margin = 2
margin_2 = 0.3
box_width = 0.15
width = 8
height = 5
offset = 0.65
size = 1.5

plot1 <- ggplot(violin_lex_df, aes(x = surp_type, y = surp_value, fill = surp_type)) +
  geom_violin(show.legend = FALSE, color ='black', size=0.3) +
  labs(y="Surprisal") +
  geom_boxplot(width=box_width, outlier.size = 0,show.legend = FALSE, color ='black', size=0.4) +
  scale_y_continuous(expand = c(0, 0),lim=c(0,30)) +
  scale_x_discrete(guide = guide_axis(angle = angle), labels =c("N-Gram Word", "N-Gram Word/POS", "PCFG Total", "PCFG Lexical", "RNNG", "Transformer")) +
  scale_fill_manual(values=colours_lex) +
  theme(plot.margin = margin(margin_2,margin,margin_2,margin_2, "cm"),
        axis.title.y = element_text(margin = margin(r = 12)),
        axis.text =  element_text(colour = 'black', size = 12),
        text = element_text(colour = 'black', size = 16),
        axis.title.x = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5))
plot1
ggsave(filename ="lex.svg", path = save_path, width=width, height=height, device="svg")


plot2 <- ggplot(violin_syn_df, aes(x = surp_type, y = surp_value, fill = surp_type)) +
  geom_violin(show.legend = FALSE, color ='black', size=0.3) +
  labs(y="Surprisal") +
  geom_boxplot(width=box_width, outlier.size = 0,show.legend = FALSE, color ='black', size=0.4) +
  scale_y_continuous(expand = c(0, 0), lim=c(0,30)) +
  scale_x_discrete(guide = guide_axis(angle = angle), labels =c("N-Gram POS", "PCFG Syntactic", "PCFG POS")) +
  scale_fill_manual(values=colours_syn) +
  theme(plot.margin = margin(margin_2,margin,margin_2,margin_2),
        axis.text.x =  element_text(colour = 'black', size = 12),
        text = element_text(colour = 'black', size = 16),
        axis.title = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5))
plot2
ggsave(filename ="syn.svg", path = save_path, width=width, height=height, device="svg")

combined_plot <- plot1 + plot2 + plot_layout(widths=c(2,1)) +plot_annotation(theme = theme(plot.margin = margin(0,75,0,0)))
combined_plot

ggsave(filename ="surp.svg", path = save_path, width=width+1, height=height, device="svg")


plot1_wins <-ggplot(violin_lex_wins_df, aes(x = surp_type, y = surp_value, fill = surp_type)) +
  geom_violin(show.legend = FALSE, color ='black', size=0.3) +
  labs(y="Value") +
  geom_boxplot(width=box_width, outlier.size = 0,show.legend = FALSE, color ='black', size=0.4) +
  scale_y_continuous(expand = c(0, 0), lim=c(0,30)) +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  scale_fill_manual(values=colours_lex) +
  theme(plot.margin = margin(margin_2,margin,margin_2,margin_2, "cm"),
        axis.title.y = element_text(margin = margin(r = 12)),
        axis.text =  element_text(colour = 'black', size = 12),
        text = element_text(colour = 'black', size = 16),
        axis.title.x = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5))

plot1_wins

ggsave(filename ="lex_wins.svg", path = save_path, width=width, height=height, device="svg")



plot2_wins <- ggplot(violin_syn_wins_df, aes(x = surp_type, y = surp_value, fill = surp_type)) +
  geom_violin(show.legend = FALSE, color ='black', size=0.3) +
  labs(y="Value") +
  geom_boxplot(width=box_width, outlier.size = 0,show.legend = FALSE, color ='black', size=0.4) +
  scale_y_continuous(expand = c(0, 0), lim=c(0,30)) +
  scale_x_discrete(guide = guide_axis(angle = angle)) +
  scale_fill_manual(values=colours_syn) +
  theme(plot.margin = margin(margin_2,margin,margin_2,margin_2),
        axis.text.x =  element_text(colour = 'black', size = 12),
        text = element_text(colour = 'black', size = 16),
        axis.title = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.line = element_line(colour = "black"),
        plot.title = element_text(hjust = 0.5))



plot2_wins

ggsave(filename ="syn_wins.svg", path = save_path, width=width, height=height, device="svg")



combined_plot_wins <- plot1_wins + plot2_wins + plot_layout(widths=c(2,1)) +plot_annotation(theme = theme(plot.margin = margin(0,75,0,0)))
combined_plot_wins

ggsave(filename ="surp_wins.svg", path = save_path, width=width+1, height=height, device="svg")


head(violin_df)


# STATISTICAL TESTING

kruskal.test(surp_value ~ surp_type, data = violin_df)
kruskal_effsize(data = violin_df, surp_value ~ surp_type)
pairwise.wilcox.test(violin_df$surp_value, violin_df$surp_type, p.adjust.method="holm", exact=F)


n_gram_word = subset(violin_df, surp_type == "N-Gram Word Surprisal")$surp_value
n_gram_pos = subset(violin_df, surp_type == "N-Gram POS Surprisal")$surp_value
n_gram_word_pos = subset(violin_df, surp_type == "N-Gram Word/POS Surprisal")$surp_value
PCFG_total = subset(violin_df, surp_type == "PCFG Total Surprisal")$surp_value
PCFG_lex = subset(violin_df, surp_type == "PCFG Lexical Surprisal")$surp_value
PCFG_syn = subset(violin_df, surp_type == "PCFG Syntactic Surprisal")$surp_value
PCFG_pos = subset(violin_df, surp_type == "PCFG POS Surprisal")$surp_value
RNNG = subset(violin_df, surp_type == "RNNG Surprisal")$surp_value
transformer = subset(violin_df, surp_type == "Transformer Surprisal")$surp_value


wilcox.test(n_gram_word, n_gram_pos, exact=F)
wilcox.test(n_gram_word, n_gram_word_pos, exact=F)
wilcox.test(n_gram_word, PCFG_total, exact=F)
wilcox.test(n_gram_word, PCFG_lex, exact=F)
wilcox.test(n_gram_word, PCFG_syn, exact=F)
wilcox.test(n_gram_word, PCFG_pos, exact=F)
wilcox.test(n_gram_word, RNNG, exact=F)
wilcox.test(n_gram_word, transformer, exact=F)

wilcox.test(n_gram_pos, n_gram_word_pos, exact=F)
wilcox.test(n_gram_pos, PCFG_total, exact=F)
wilcox.test(n_gram_pos, PCFG_lex, exact=F)
wilcox.test(n_gram_pos, PCFG_syn, exact=F)
wilcox.test(n_gram_pos, PCFG_pos, exact=F)
wilcox.test(n_gram_pos, RNNG, exact=F)
wilcox.test(n_gram_pos, transformer, exact=F)

wilcox.test(n_gram_word_pos, PCFG_total, exact=F)
wilcox.test(n_gram_word_pos, PCFG_lex, exact=F)
wilcox.test(n_gram_word_pos, PCFG_syn, exact=F)
wilcox.test(n_gram_word_pos, PCFG_pos, exact=F)
wilcox.test(n_gram_word_pos, RNNG, exact=F)
wilcox.test(n_gram_word_pos, transformer, exact=F)

wilcox.test(PCFG_total, PCFG_lex, exact=F)
wilcox.test(PCFG_total, PCFG_syn, exact=F)
wilcox.test(PCFG_total, PCFG_pos, exact=F)
wilcox.test(PCFG_total, RNNG, exact=F)
wilcox.test(PCFG_total, transformer, exact=F)

wilcox.test(PCFG_lex, PCFG_syn, exact=F)
wilcox.test(PCFG_lex, PCFG_pos, exact=F)
wilcox.test(PCFG_lex, RNNG, exact=F)
wilcox.test(PCFG_lex, transformer, exact=F)

wilcox.test(PCFG_syn, PCFG_pos, exact=F)
wilcox.test(PCFG_syn, RNNG, exact=F)
wilcox.test(PCFG_syn, transformer, exact=F)

wilcox.test(PCFG_pos, RNNG, exact=F)
wilcox.test(PCFG_pos, transformer, exact=F)

wilcox.test(RNNG, transformer, exact=F)



wilcoxonZ(n_gram_word, n_gram_pos)/sqrt(2818)
wilcoxonZ(n_gram_word, n_gram_word_pos)/sqrt(2818)
wilcoxonZ(n_gram_word, PCFG_total)/sqrt(2818)
wilcoxonZ(n_gram_word, PCFG_lex)/sqrt(2818)
wilcoxonZ(n_gram_word, PCFG_syn)/sqrt(2818)
wilcoxonZ(n_gram_word, PCFG_pos)/sqrt(2818)
wilcoxonZ(n_gram_word, RNNG)/sqrt(2818)
wilcoxonZ(n_gram_word, transformer)/sqrt(2818)

wilcoxonZ(n_gram_pos, n_gram_word_pos)/sqrt(2818)
wilcoxonZ(n_gram_pos, PCFG_total)/sqrt(2818)
wilcoxonZ(n_gram_pos, PCFG_lex)/sqrt(2818)
wilcoxonZ(n_gram_pos, PCFG_syn)/sqrt(2818)
wilcoxonZ(n_gram_pos, PCFG_pos)/sqrt(2818)
wilcoxonZ(n_gram_pos, RNNG)/sqrt(2818)
wilcoxonZ(n_gram_pos, transformer)/sqrt(2818)

wilcoxonZ(n_gram_word_pos, PCFG_total)/sqrt(2818)
wilcoxonZ(n_gram_word_pos, PCFG_lex)/sqrt(2818)
wilcoxonZ(n_gram_word_pos, PCFG_syn)/sqrt(2818)
wilcoxonZ(n_gram_word_pos, PCFG_pos)/sqrt(2818)
wilcoxonZ(n_gram_word_pos, RNNG)/sqrt(2818)
wilcoxonZ(n_gram_word_pos, transformer)/sqrt(2818)

wilcoxonZ(PCFG_total, PCFG_lex)/sqrt(2818)
wilcoxonZ(PCFG_total, PCFG_syn)/sqrt(2818)
wilcoxonZ(PCFG_total, PCFG_pos)/sqrt(2818)
wilcoxonZ(PCFG_total, RNNG)/sqrt(2818)
wilcoxonZ(PCFG_total, transformer)/sqrt(2818)

wilcoxonZ(PCFG_lex, PCFG_syn)/sqrt(2818)
wilcoxonZ(PCFG_lex, PCFG_pos)/sqrt(2818)
wilcoxonZ(PCFG_lex, RNNG)/sqrt(2818)
wilcoxonZ(PCFG_lex, transformer)/sqrt(2818)

wilcoxonZ(PCFG_syn, PCFG_pos)/sqrt(2818)
wilcoxonZ(PCFG_syn, RNNG)/sqrt(2818)
wilcoxonZ(PCFG_syn, transformer)/sqrt(2818)

wilcoxonZ(PCFG_pos, RNNG)/sqrt(2818)
wilcoxonZ(PCFG_pos, transformer)/sqrt(2818)

wilcoxonZ(RNNG, transformer)/sqrt(2818)










