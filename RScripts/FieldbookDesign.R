
# Fieldbook Design --------------------------------------------------------

library(agricolae)

# Seeds (3) .: Tomato, Corn, Beans  
# Temperature (5) .: T15, T20, T25, T30, T35
# Rep .: 5

fb <- design.ab(trt = c(3,5), r = 5,design = "crd")
fb$book