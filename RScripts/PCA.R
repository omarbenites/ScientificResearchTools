
# Principal Component Analisys (PCA) --------------------------------------

library(FactoMineR)

pca <- PCA(dtg[4:18], graph = F, quali.sup = 1)
pca

summary(pca, nbelements=Inf, file="PCA.txt")


# PCA plot ----------------------------------------------------------------

#png(height=1000, width=1000, pointsize=20, file="PCA.png")

plot(pca,choix=c("var"),habillage= 1, cex=0.8,shadow=T,autoLab="yes",title = "") # choix=c("ind")

#dev.off()