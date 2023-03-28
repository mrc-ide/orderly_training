#data cleaning goes here

#read in file, skipping rows without data and ignoring introduction sheet
df <- readxl::read_xlsx("data_received/data_20240127.xlsx",
                        sheet = "Data",
                        skip = 2)

#tidy names
df <- df %>% janitor::clean_names()

# make sure all dates are in correct format
df <- df %>% mutate(date = as.Date(date, forma="%d/%m/%Y"))

# make long
df <- df %>%
  tidyr::pivot_longer(names_to = "disease", values_to = "coverage", -date) 

#tidy disease names
df <- df %>%
  mutate(disease = gsub("_coverage", "", disease))

#save the data for analysis downstream
df %>%
  saveRDS("cleaned_data.rds")
