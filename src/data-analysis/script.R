# data analysis goes here
options(dplyr.summarise.inform = FALSE)

df <- readRDS("cleaned_data.rds")

# table of data summary stats
df %>%
  group_by(disease) %>%
  summarise(min_cov = min(coverage, na.rm = TRUE),
            max_cov = max(coverage, na.rm = TRUE),
            mean_cov = mean(coverage, na.rm = TRUE)) %>%
  saveRDS("summary_cov_stat.rds")

#figure showing both datasets and trends
p <- df %>%
  mutate(disease = toupper(disease)) %>%
  ggplot()+
  aes(x = date,
      y = coverage,
      colour = disease, 
      fill = disease)+
  geom_point()+
  geom_smooth()+
  theme_minimal()+
  scale_fill_met_d("Renoir")+
  scale_color_met_d("Renoir")+
  labs(x = "Date", y = "Coverage", fill = "Disease", colour = "Disease")+
  ylim(0,1)

ggsave(plot = p, filename = "coverage.png")

# extra figures for stakeholder B
p2 <- df %>%
  filter(disease == "of") %>%
  ggplot()+
  aes(x = date, y = coverage)+
  geom_point(colour = "orange")+
  xlim(as.Date("2010-01-01"), as.Date("2026-01-01"))+
  stat_smooth(method = "lm",fullrange = TRUE, colour = "orange")+
  theme_minimal()+
  labs(x = "Date", y = "Coverage")+
  ggtitle("Projected orange fever coverage in 2025")

ggsave(plot = p2, filename = "projected_of_2025.png")