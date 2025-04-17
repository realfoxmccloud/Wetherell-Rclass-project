# Load necessary libraries
library(tidyverse)

# Define file paths (go up two levels from Processing_Code to project root)
input_path <- "../../Data/Raw_data/penguins_raw_dirty.csv"
output_csv <- "../../Data/Processed_data/penguins_cleaned.csv"
output_rda <- "../../Data/Processed_data/penguins_cleaned.rda"



# Load raw data
raw_data <- read_csv(input_path)

# Standardize column names (fix spaces and special characters)
cleaned_data <- raw_data %>%
  rename_with(~ str_replace_all(., "[ ()]", "_") %>% str_replace_all("__", "_")) 

# Standardize species names (fix typos and inconsistencies)
cleaned_data <- cleaned_data %>%
  mutate(Species = case_when(
    str_detect(Species, "Adelie|AdeKie|PengTin|Pengufn|PeOguin|MPenguin") ~ "Adelie",
    str_detect(Species, "Gentoo|Ventoo") ~ "Gentoo",
    str_detect(Species, "Chinstrap") ~ "Chinstrap",
    TRUE ~ Species  # Keep unchanged if already correct
  ))


# Handle missing values
cleaned_data <- cleaned_data %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>%
  mutate(Sex = replace_na(Sex, "Unknown"))

# Remove unnecessary columns
cleaned_data <- cleaned_data %>% select(-studyName)

# Save cleaned dataset
write_csv(cleaned_data, output_csv)
save(cleaned_data, file = output_rda)

# Print confirmation message
print("Data cleaning completed! Cleaned dataset saved in Processed_data/")
