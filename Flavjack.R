
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


# Fieldbook Design --------------------------------------------------------

library(agricolae)

# Seeds (3) .: Tomato, Corn, Beans  
# Temperature (5) .: T15, T20, T25, T30, T35
# Rep .: 5

fb <- design.ab(trt = c(3,5), r = 5,design = "crd")
fb$book


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


# Correlation Anlisys -----------------------------------------------------

library(agricolae)

cr <- correlation(dtg[5:18], method = "pearson")
cr$correlation
cr$pvalue



# Correlation plot (output$cr) --------------------------------------------------------

library(corrplot)

#png(height=1500, width=1500, pointsize=20, file="correlation.png")

col <- colorRampPalette(c("#1E90FF", "#6495ED","#7FFFD4", "#FFF0F5", "#FFF0F5","#FFD700", "#FF4500", "#DC143C"))

cp <- corrplot(corr = cr$correlation, method = "color", type = "upper", tl.col="black", 
               tl.srt=30, tl.cex = 1, addCoef.col = "black", col=col(200), 
               p.mat = cr$pvalue, sig.level = 0.05, insig = "blank", addgrid.col = "black" )

#dev.off()



# Principal Component Analisys (PCA) --------------------------------------

library(FactoMineR)

pca <- PCA(dtg[4:18], graph = F, quali.sup = 1)
pca

summary(pca, nbelements=Inf, file="PCA.txt")


# PCA plot ----------------------------------------------------------------

#png(height=1000, width=1000, pointsize=20, file="PCA.png")

plot(pca,choix=c("var"),habillage= 1, cex=0.8,shadow=T,autoLab="yes",title = "") # choix=c("ind")

#dev.off()


# Metereological data -----------------------------------------------------

library(gsheet)

url <- "https://docs.google.com/spreadsheets/d/1sfy6XaCAYKqU1siOr9VP_I5wAzRBjjMmdr1nK387J0s/edit#gid=225298935"
md <- gsheet2tbl(url)
md <- as.data.frame(md)
md$DATE <- as.Date(md$DATE, format = "%m/%d/%y")
str(md)


# Temperature Plot --------------------------------------------------------

library(ggplot2)

ggplot(md, aes(x = DATE, y = Temp)) + 
  geom_point(aes(colour = Temp)) +
  geom_smooth() +
  scale_y_continuous(limits = c(20,45), breaks=0:100*5) +
  scale_x_date(date_labels = "%d/%m", date_breaks = "10 day") +
  xlab("") +  ylab ("Temperature (ºC)") +
  scale_colour_gradient2(low = "blue", mid = "green" , high = "red", midpoint = 31) + 
  theme_bw()+
  theme(axis.text.x=element_text(angle=35, hjust=1))


# Relative Humidity -------------------------------------------------------

library(ggplot2)

ggplot(md,aes(x = DATE, y = HR)) + 
  geom_point(aes(colour = HR)) +
  geom_smooth() +
  scale_y_continuous(limits = c(10,100), breaks=0:100*10) +
  scale_x_date(date_labels = "%d %b", date_breaks = "10 day")+
  xlab("") +  ylab ("Relative Humidity (%)")+
  scale_colour_gradient2(low = "blue", mid = "green" , high = "red", midpoint = 65) + 
  theme_bw()+
  theme(axis.text.x=element_text(angle=35, hjust=1))
