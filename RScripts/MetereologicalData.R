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
