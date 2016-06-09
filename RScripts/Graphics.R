# Boxplot (Outlier remove) -----------------------------------------------------------------

library(car)

bp <- Boxplot( TUBDW  ~ Genotype, dtg, las = 3, id.n=Inf) 
dtg$TUBDW[as.numeric(bp)]  <- NA
bp <- Boxplot( TUBDW  ~ Genotype, dtg, las = 3, id.n=Inf ) 


# Barplot -----------------------------------------------------------------

library(ggplot2)

ggplot(sm$Summary, aes(x = Genotype , y =  means , fill = Irrigation))+
  geom_bar(stat="identity", size=.5, colour="black", position = "dodge")+
  geom_errorbar(aes(ymin= means - ste , ymax= means + ste), size=.3,width=.2,  position=position_dodge(.9)) +
  ylab("Tuber Dry Weight (g)") +
  xlab("")+
  scale_y_continuous(limits = c(0,80), breaks= 0:100*5) +
  theme_bw()


# Line Plot ---------------------------------------------------------------

library(ggplot2)

ggplot(sm$Summary, aes(x = Genotype , y = means, group= Irrigation, colour=Irrigation)) +
  geom_line() +
  geom_point(shape=19, size=2)+
  ylab("Tuber Dry Weight (g)") +
  xlab("")+
  scale_y_continuous(limits = c(0,80), breaks=0:50*5)+
  geom_errorbar(aes(ymin= means - ste , ymax= means + ste), size=.3,width=.2)+
  theme_bw()
