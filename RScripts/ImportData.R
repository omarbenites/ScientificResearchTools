
# Import data form Google Spread Shets ------------------------------------

library(gsheet)

url <- "https://docs.google.com/spreadsheets/d/1sfy6XaCAYKqU1siOr9VP_I5wAzRBjjMmdr1nK387J0s/edit#gid=1326844779"
dtg <- gsheet2tbl(url)
dtg <- as.data.frame(dtg)
str(dtg) # Verificacion de datos

# Import data from excel --------------------------------------------------

library(openxlsx)

dte <- read.xlsx(choose.files(), sheet = "MV")
dte <- as.data.frame(dte)
str(dte) # Verificacion de datos