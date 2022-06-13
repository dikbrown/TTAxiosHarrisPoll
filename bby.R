bbypoll <- poll[poll$company == "Best Buy",]
bbyrep <- reputation[reputation$company == "Best Buy",]
bbyrep
bbyrep$from_top <- 100 - bbyrep$rank + 1
bbyrep$name[4] <- "PRODUCTS\n&\nSERVICES"

ggplot(data = bbyrep, aes(x = name, y = score)) +
  geom_col(fill = "#0a4abf") +  
  xlab("\nArea Evaluated") + 
  ylab("Reputation Score") +
  labs(title = "How did Best Buy do in the Axios-Harris Reputation Poll?",
       caption = 'Data from Axios-Harris poll regarding top 100 "Most Visible companies"\n
       image © 2022, Dick Brown, Store 531') +
#add grade labels
  geom_rect(aes(xmin = 3.65, ymin = 81, xmax = 4.35, ymax = 84), fill = "#f6eb16", color = "black") +
  annotate("text", x =4, y = 82.5, size = 6, label = "Excellent") +
  geom_rect(aes(xmin = 3.65, ymin = 76, xmax = 4.35, ymax = 79), fill = "#f6eb16", color = "black") +
  annotate("text", x = 4, y = 77.5, size = 6, label = "Very Good") +
  geom_rect(aes(xmin = 3.65, ymin = 71, xmax = 4.35, ymax = 74), fill = "#f6eb16", color = "black") +
  annotate("text", x = 4, y = 72.5, size = 6, label = "Good") +
  geom_rect(aes(xmin = 3.65, ymin = 66, xmax = 4.35, ymax = 69), fill = "#f6eb16", color = "black") +
  annotate("text", x = 4, y = 67.5, size = 6, label = "Fair") +
  geom_rect(aes(xmin = 3.65, ymin = 58.5, xmax = 4.35, ymax = 61.5), fill = "#f6eb16", color = "black") +
  annotate("text", x = 4, y = 60, size = 6, label = "Poor") +
  geom_rect(aes(xmin = 3.65, ymin = 51, xmax = 4.35, ymax = 54), fill = "#f6eb16", color = "black") +
  annotate("text", x = 4, y = 52.5, size = 6, label = "Very Poor") +
  geom_rect(aes(xmin = 3.65, ymin = 46, xmax = 4.35, ymax = 49), fill = "#f6eb16", color = "black") +
  annotate("text", x = 4, y = 47.5, size = 6, label = "Critical") +
#add grade dividers
  geom_hline(aes(yintercept = 50), color = "white") +
  geom_hline(aes(yintercept = 55), color = "white") +
  geom_hline(aes(yintercept = 65), color = "white") +
  geom_hline(aes(yintercept = 70), color = "white") +
  geom_hline(aes(yintercept = 75), color = "white") +
  geom_hline(aes(yintercept = 80), color = "white") +
  
  geom_label(aes(label = paste0(name,
                                "\nscore: ",round(score,1), 
                                "\n\n",grade,
                                "\n\nranked\n#",rank, 
                                "\n    out of 100    ")), fill = "#f6eb16", y = 20, size = 6)+
  scale_y_continuous(breaks = c(50, 55, 65, 70, 75, 80)) +
  theme(axis.text.y = element_text(size = 16),
        axis.title.y = element_text(size = 20),
        axis.text.x = element_blank(),  #no x-axis labels
        axis.title.x = element_blank(), #no x-axis title
        axis.ticks.x = element_blank(), #no x-axis ticks
        panel.grid = element_blank(),
        plot.title = element_text(size = 40, hjust = 0.5),
        panel.background = element_rect(fill = "black"),
        legend.position = "none",
        plot.caption = element_text(vjust = 1, hjust = 1, size = 12))

