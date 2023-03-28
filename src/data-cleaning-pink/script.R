
df <- readxl::read_xlsx("pink_fever_monthly.xlsx")

df <- df %>%
  mutate(date = paste0(year, "-", month, "-", day)) %>%
  mutate(date = lubridate::ymd(date)) %>%
  select(date, coverage) %>%
  mutate(coverage= coverage/100)

saveRDS(df, "cleaned_pink.rds")