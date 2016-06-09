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
