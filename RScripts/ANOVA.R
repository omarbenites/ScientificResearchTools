# Analise of Variance -----------------------------------------------------

av <- aov( TUBDW  ~ Treat * Genotype, dtg )
summary(av)

# Mean comparison test ----------------------------------------------------

library(agricolae)

mc <- SNK.test(av, c("Genotype", "Treat"))
mc$statistics
mc$means
mc$groups

# Data Summary (output$mc) ------------------------------------------------

library(dplyr)
library(tidyr)

sm <- mutate(mc$means, trt = row.names(mc$means), means = mc$means[ , 1] , ste = std/sqrt(r))
sm <- select(sm, trt, means, std, r, ste)
sm <- separate(sm, "trt", into = c("Genotype", "Irrigation"))
sm <- list(Statistics = mc$statistics, Summary = sm, SNK = mc$groups)
sm

