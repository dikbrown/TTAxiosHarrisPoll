### only do these steps once
poll <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/poll.csv')
reputation <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/reputation.csv')

write.csv(poll, "./data/poll.csv")
write.csv(reputation, "./data/reputation.csv")

#### do this after first d/l and save
poll <- read.csv("./data/poll.csv")
reputation <- read.csv("./data/reputation.csv")

reputation$quality <- NA
reputation$quality[reputation$rank <= 5] <- "high"
reputation$quality[reputation$rank > 95] <- "low"

vision_score <- reputation[reputation$name == 'VISION',]
trust_score <-  reputation[reputation$name == 'TRUST',]
ethics_score <-  reputation[reputation$name == 'ETHICS',]
growth_score <-  reputation[reputation$name == 'GROWTH',]
#Products & Services
PnS_score <-  reputation[reputation$name == 'P&S',]
citizen_score <-  reputation[reputation$name == 'CITIZENSHIP',]
culture_score <-  reputation[reputation$name == 'CULTURE',]


top_bottom_vision <-  arrange(vision_score[(vision_score$rank <= 5) | (vision_score$rank > 95),], rank)
top_bottom_trust <-  trust_score[(trust_score$rank <= 5) | (trust_score$rank > 95),]
top_bottom_ethics <-  ethics_score[(ethics_score$rank <= 5) | (ethics_score$rank > 95),]
top_bottom_growth <-  growth_score[(growth_score$rank <= 5) | (growth_score$rank > 95),]
top_bottom_PnS <-  PnS_score[(PnS_score$rank <= 5) | (PnS_score$rank > 95),]
top_bottom_citizen <-  citizen_score[(citizen_score$rank <= 5) | (citizen_score$rank > 95),]
top_bottom_culture <-  culture_score[(culture_score$rank <= 5) | (culture_score$rank > 95),]

barplot(rank ~ company, top_bottom_vision[order(top_bottom_vision$rank, decreasing = TRUE),], horiz = TRUE, 
          ylab = )

### Assign grades
reputation$grade = "Excellent"
reputation$grade <- case_when(
                              reputation$score < 50 ~ "Critical",
                              reputation$score < 55 ~ "Very Poor",
                              reputation$score < 65 ~ "Poor",
                              reputation$score < 70 ~ "Fair",
                              reputation$score < 75 ~ "Good",
                              reputation$score < 80 ~ "Very Good",
                              TRUE ~ "Excellent")

library(ggplot2)

ggplot(data = top_bottom_trust, aes(fct_reorder(company, score, .desc = TRUE), score)) +
  geom_col(aes(fill = quality)) +
  labs(title = "Most and Least Trusted Companies in the U.S.",
       caption = 'Data from Axios-Harris poll regarding top 100 "Most Visible companies"') +
  xlab("Company") +
  ylab("Trust Score") +
# add grade labels 
  geom_rect(aes(xmin = 5, ymin = 81, xmax = 6, ymax = 84), fill = "white", color = "black") +
  annotate("text", x =5.5, y = 82.5, size = 4, label = "Excellent") +
  geom_rect(aes(xmin = 5, ymin = 76, xmax = 6, ymax = 79), fill = "white", color = "black") +
  annotate("text", x = 5.5, y = 77.5, size = 4, label = "Very Good") +
  geom_rect(aes(xmin = 5, ymin = 71, xmax = 6, ymax = 74), fill = "white", color = "black") +
  annotate("text", x = 5.5, y = 72.5, size = 4, label = "Good") +
  geom_rect(aes(xmin = 5, ymin = 66, xmax = 6, ymax = 69), fill = "white", color = "black") +
  annotate("text", x = 5.5, y = 67.5, size = 4, label = "Fair") +
  geom_rect(aes(xmin = 5, ymin = 58.5, xmax = 6, ymax = 61.5), fill = "white", color = "black") +
  annotate("text", x = 5.5, y = 60, size = 4, label = "Poor") +
  geom_rect(aes(xmin = 5, ymin = 51, xmax = 6, ymax = 54), fill = "white", color = "black") +
  annotate("text", x = 5.5, y = 52.5, size = 4, label = "Very Poor") +
  geom_rect(aes(xmin = 5, ymin = 46, xmax = 6, ymax = 49), fill = "white", color = "black") +
  annotate("text", x = 5.5, y = 47.5, size = 4, label = "Critical") +
  
  geom_rect(aes(xmin = 1, ymin = 15, xmax = 5, ymax = 25), fill = "white") +
  annotate("text", x = 3, y = 20, size = 6, label = "Five most-trusted companies") +
  geom_rect(aes(xmin = 6, ymin = 15, xmax = 10, ymax = 25), fill = "white") +
  annotate("text", x = 8, y = 20, size = 6, label = "Five least-trusted companies") +
#add grade dividers
  geom_hline(aes(yintercept = 50)) +
  geom_hline(aes(yintercept = 55)) +
  geom_hline(aes(yintercept = 65)) +
  geom_hline(aes(yintercept = 70)) +
  geom_hline(aes(yintercept = 75)) +
  geom_hline(aes(yintercept = 80)) +
  scale_y_continuous(breaks = c(50, 55, 65, 70, 75, 80)) +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 16),
        plot.title = element_text(size = 24, hjust = 0.5),
        panel.background = element_rect(fill = "white"),
        legend.position = "none",
        plot.caption = element_text(vjust = 1, hjust = 0.9, size = 12))
  

