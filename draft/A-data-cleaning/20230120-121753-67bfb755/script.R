#data cleaning goes here

#read in file, skipping rows without data and ignoring introduction sheet
df <- readxl::read_xlsx("data_received/data_20230120.xlsx",
                        sheet = "Data1",
                        skip = 2)

#tidy names
df <- df %>% janitor::clean_names()

# make sure all dates are in correct format
df <- df %>% mutate(date = as.Date(date))

#get coverage in same format for both yf and measles
df <-  df %>% mutate(measles_coverage = measles_coverage/100)

#save the data for analysis downstream
df %>%
  saveRDS("cleaned_data.rds")
