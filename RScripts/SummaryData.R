library(doBy)

dta <- read.csv(choose.files())
smry <- function(x, ...){ c( m = mean(x, ...), N = length(x) ,  sd = sd(x, ...))}
rsm <- summaryBy("lm" , dta ,  FUN = smry, na.rm = TRUE )
write.xlsx(rsm, "name.xlsx")




library(plyr)

sm <- ddply(dta, c("F1", "F2"), summarise,
            N    = sum(!is.na(variable)),
            mean = mean(variable, na.rm=TRUE),
            sd   = sd(variable, na.rm=TRUE),
            se   = sd / sqrt(N) )