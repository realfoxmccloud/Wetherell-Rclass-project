###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the Processed_data folder
#

## ---- packages --------
require(dplyr) #for data processing/cleaning
require(tidyr) #for data processing/cleaning
require(skimr) #for nice visualization of data 

## ---- loaddata --------
# path to data
data_location <- "../../Data/Raw_data/penguins_raw_dirty.csv"
data_path <- "../../Data/Raw_data/"

# read data. 
rawdata <- read.csv(data_location, check.names=FALSE)

# read the data dictionary
dictionary <- read.csv(paste(data_path, "datadictionary.csv", sep=""))
print(dictionary)


## ---- exploredata --------

#take a look at the data
dplyr::glimpse(rawdata)

summary(rawdata)
head(rawdata)
skimr::skim(rawdata)

orig_names <- names(rawdata)
new_names <- c("study", "sampleN", "species", "region", "island", "stage", "id", "clutch", "eggdate", "culmenL", "culmenD", "flipperL", "mass", "sex", "d15N", "d13C", "comments" )
names(orig_names) <- new_names   # label the original names vector with the new names
															# useful for plot axis labels
orig_names													

## ---- cleandata1 --------
# Inspecting the data, we find some problems that need addressing:
# There are 9 unique names, should be 3. 

#check skimr or 
unique(rawdata$species)

# Letʻs save rawdata as d1, and modify d1 so we can compare versions. 

d1 <- rawdata
names(d1) <- new_names   # rename the data with short names


ii <- grep("PengTin", d1$species)
d1$species[ii] <- "Adelie Penguin (Pygoscelis adeliae)"

#Another way:

d1$species <- sub("gTin", "guin", d1$species)

# look at partially fixed data again
unique(d1$species)

## ---- fixtypos --------

# Fix all of the errors. 
d1$species <- sub("gufn", "guin", d1$species)
d1$species <- sub("Oguin", "nguin", d1$species)
d1$species <- sub("Kie", "lie", d1$species)
d1$species <- sub("lieM", "lie ", d1$species)
d1$species <- sub("Vent", "Gent", d1$species)

#  Shorten species just keeping the three common names "Adelie", 
#  "Gentoo", and "Chinstrap" and delete the rest of the species character string. 
#  For this we have to set the argument fixed=T because () are special characters for grouping

d1$species <- sub(" Penguin (Pygoscelis adeliae)","", d1$species, fixed=T)
d1$species <- sub(" penguin (Pygoscelis papua)","", d1$species, fixed=T)
d1$species <- sub(" penguin (Pygoscelis antarctica)","", d1$species, fixed=T)

unique(d1$species)

## ---- cleandata2 --------
# Change the Culmen Length entry "missing" to NA
 
cl <- d1$culmenL

cl[ cl == "missing" ] <- NA  # find cl=="missing and replace "missing" with NA
cl <- as.numeric(cl)  # coerce to numeric
d1$culmenL <- cl

# another way using dplyr from the tidyverse
d1 <- d1 %>% 
			dplyr::mutate( culmenL = replace(culmenL, culmenL=="missing", NA)) %>% 
			dplyr::mutate( culmenL = as.numeric(culmenL))

# look at partially fixed data again
skimr::skim(d1)
hist(d1$culmenL)

# letʻs also do a bivariate plot with mass
plot(d1$mass, d1$culmenL)
plot(d1$mass, d1$culmenL, xlab=orig_names["mass"], ylab=orig_names["culmenL"])


## ---- cleandata3.1 --------
#  Three penguins have impossibly long culmens (300+mm) 
#  Assume they are misplaced decimals (for example if we could 
#  verify with field records), and letʻs fix this:

d2 <- d1 
cl[ cl > 300 ] 


## ---- cleandata3.2 --------
# cl > 300 are decimal place errors, correct by dividing by 10

cl[ !is.na(cl) & cl>300 ] <- cl[ !is.na(cl) & cl>300 ]/10   
d2$culmenL <- cl

#culmen length values seem ok now
skimr::skim(d2)
hist(d2$culmenL)

plot(d2$mass, d2$culmenL, xlab=orig_names["mass"], ylab=orig_names["culmenL"])

## ---- cleandata4.1 --------
hist(d2$mass)

## ---- cleandata4.2 --------
# Some masses are impossibly small, delete these observations

d3 <- d2
mm <- d3$mass

mm[ mm < 100 ] <- NA       # replace tiny masses with NA
nas <- which( is.na(mm) )  # find which rows have NA for mass

d3 <- d3[-nas,]    # remove all rows with mass = NA

skimr::skim(d3)
hist(d3$mass)

plot(d3$mass, d3$culmenL, xlab=orig_names["mass"], ylab=orig_names["culmenL"])

## ---- comment5 --------
# Does it look better?

# We also want to have Species, Sex, and Island coded as a categorical/factor variable

## ---- cleandata5 --------
# Species, Sex, and Island coded as a categorical/factor variable
d3$species <- as.factor(d3$species)
d3$sex <- as.factor(d3$sex)
d3$island <- as.factor(d3$island)  
skimr::skim(d3)


## ---- bivariateplots --------
# bivariate plots of each numeric variable with mass to ensure there are no further
# errors.:
plot(d3$mass, d3$culmenL, xlab=orig_names["mass"], ylab=orig_names["culmenL"])
plot(d3$mass, d3$culmenD, xlab=orig_names["mass"], ylab=orig_names["culmenD"])
plot(d3$mass, d3$flipperL, xlab=orig_names["mass"], ylab=orig_names["flipperL"])
plot(d3$mass, d3$d15N, xlab=orig_names["mass"], ylab=orig_names["d15N"])
plot(d3$mass, d3$d13C, xlab=orig_names["mass"], ylab=orig_names["d13C"])

## ---- histograms --------

# We will not subset by region, stage as they have only 1 value
# nor eggdate and sampleN which have many values

require(ggplot2)
hist(d3$mass)   # a single histogram of mass

d3 %>%   # mass histogram by species
    ggplot( aes(x=mass)) + 
   geom_histogram( aes(fill=species), alpha=.5) 
 
d3 %>%    # mass density by species
    ggplot( aes(x=mass)) + 
   geom_density( aes(fill=species), alpha=.5) 
 
d3 %>%    # by island
    ggplot( aes(x=mass)) + 
    geom_histogram( aes(fill=island), alpha=.5)   

d3 %>% 
    ggplot( aes(x=mass)) + 
    geom_density( aes(fill=island), alpha=.5)   

d3 %>% 
    ggplot( aes(x=mass)) + 
    geom_histogram( aes(fill=clutch), alpha=.5)   

d3 %>% 
    ggplot( aes(x=mass)) + 
    geom_density( aes(fill=clutch), alpha=.5)   

d3 %>% 
    ggplot( aes(x=mass)) + 
    geom_histogram( aes(fill=sex), alpha=.5)   

d3 %>% 
    ggplot( aes(x=mass)) + 
    geom_density( aes(fill=sex), alpha=.5)   
 
## ---- finalizedata --------
# Finalize the cleaned dataset. 
# save these variables

vars <- c("id", "species", "island", "clutch", "eggdate", "culmenL", "culmenD", "flipperL", "mass", "sex", "d15N", "d13C")

d4 <- d3[vars]   # save only the variables in vars
names(d4) <- orig_names[vars]  # revert to original names
print(orig_names[vars])

dictionary <- dictionary[dictionary$variable %in% orig_names[vars],]  # drop unused variables

# another way to drop unused rows: 
dictionary <- dictionary %>% filter( variable %in% orig_names[vars] )  # dplyr

print(dictionary)

## ---- savedata --------
processeddata <- d4      # clean data
save_path <- "../../Data/Processed_data/"   # path where clean data is saved

save_data_rds <- paste( save_path, "processeddata.rds", sep="")  # clean data RDS format
saveRDS(processeddata, file = save_data_rds)

save_data_csv <- paste( save_path, "processeddata.csv", sep="")  # clean data .csv
write.csv(processeddata, file = save_data_csv, row.names=FALSE)

save_dictionary_csv <- paste( save_path, "dictionary.csv", sep="")  # clean data dictionary .csv
write.csv(dictionary, file = save_dictionary_csv, row.names=FALSE)

saveRDS(orig_names[vars], paste( save_path, "orig_names.rds", sep=""))  # original names and short names as values

