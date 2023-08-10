orderly2::orderly_strict_mode()

orderly2::orderly_dependency("data-cleaning", "latest", c(cleaned_data.rds = "cleaned_data.rds"))

orderly2::orderly_artefact("All output tables", "summary_cov_stat.rds")
orderly2::orderly_artefact("All output figures", "coverage.png")

library(dplyr)
library(ggplot2)
library(MetBrewer)
library(tidyr)
library(lubridate)

# data analysis goes here
options(dplyr.summarise.inform = FALSE)

df <- readRDS("cleaned_data.rds")

# table of data summary stats
df %>%
  group_by(disease) %>%
  summarise(min_cov = min(coverage),
            max_cov = max(coverage),
            mean_cov = mean(coverage)) %>%
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
