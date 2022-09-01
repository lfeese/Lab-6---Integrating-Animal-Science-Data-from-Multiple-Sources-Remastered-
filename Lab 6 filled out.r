# Download packages

install.packages("readxl")
install.packages("lubridate")

# Ready the package
library("readxl")    
library("lubridate")

# Set working directory
# NOTE: working directory for GitHub is "/home/jovyan" it will be an error
# on Jupyter Notebook but will work on MyBinder
setwd("/home/jovyan")
getwd()

#  Check xls sheet names and how many. Save Beef data.xlsx to the folder of the notebook!

excel_sheets("Beef data.xlsx")

# Import first sheet from file.
calf.id.raw <- read_excel("Beef data.xlsx", sheet="ID")


# Examine first rows.

head(calf.id.raw)

# Remove the first 2 rows from Beef data.xlsx and save as calf.id

calf.id <- read_excel("Beef data.xlsx", sheet="ID", skip=2)

# View calf.id as string

str(calf.id)

# Examine the end of the data for any non-data entries

tail(calf.id)

# Change to a factor (class variable)

calf.id$Calf.ID <- factor(calf.id$Calf.ID)

# Check that it worked

str(calf.id)

# Then repeat for all factors.
source <- read_excel("Beef data.xlsx", sheet="Calf data", skip=2)
source$Source <- factor(source$Source)
str(source)

# Avoid typing "calf.id" over and over.
attach(calf.id)




  

# Source <- factor(Source)
# Repeat for TRT, Barn, Pen, ASA.num, Plant, Plant.ID

Source <- factor(Source)
TRT <- factor(TRT)
Barn <- factor(Barn)
Pen <- factor(Pen)
ASA.num <- factor(ASA.num)
Plant <- factor(Plant)
Plant.ID <- factor(Plant.ID)

# Detach calf.id

detach(calf.id)

# Print calf.id as a string

str(calf.id)    

# Note that it worked for most but not all.

# store genomics as the 'Genomic EPD' sheet
genomics <- read_excel("Beef data.xlsx", sheet="Genomic EPD", skip=2)

# print genomics as a string

str(genomics)

# Isolate the coresponding ASA.num values to calf.id

calf.id$ASA.num

# Find which calf.id has a ASA.num equals 3383368

which(calf.id$ASA.num=="3383368") 

# Within genomics, find the Carc.Wt.EPD from the calf.id that
# has a ASA.num = "3383368"

genomics$Carc.Wt.Epd[which(calf.id$ASA.num=="3383368")]  

# Make a vector called pred.wt that makes a prediction of
# weight gain based on the genomics of yearlings

pred.wt <- genomics$Yrl.Wt.Epd[which(calf.id$ASA.num==genomics$ASA.num)]
pred.wt

# See how pred.wt is stored as a separate vector

ls()

# Combine calf.id with pred.wt using cbind and save as calf

calf <- cbind(calf.id, pred.wt)

# Print calf as a string

str(calf)

## Your code here

calf.id$Calf.ID <- factor(calf.id$Calf.ID)


## Your code here 
## Note! USE THE SAME DATE FORMAT FOR BEGINNGING AND END. Can't operate w/date()
date.end <- ymd("2017-12-31")
date.begin <- ymd("2017-12-17")

datediff <- as.numeric(date.end - date.begin)
datediff

## Your code here

feedlot.id <- read_excel("Beef data.xlsx", sheet="Feedlot individual data", skip = 2)

performance <- (feedlot.id$Slaughter.wt- feedlot.id$Feedlot.entry
) / datediff

feedlot <- cbind(feedlot.id, performance)
str(feedlot)


