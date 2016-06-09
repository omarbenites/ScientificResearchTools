library(car)

dta <- read.csv(choose.files())

bp <- Boxplot( lm , dta , las = 3 , xlab = "" , ylab = " ") 
dta$variable[as.numeric(bp)]  <- NA

write.xlsx(dta,"dataclean.xls")

#############################################################

remo <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}