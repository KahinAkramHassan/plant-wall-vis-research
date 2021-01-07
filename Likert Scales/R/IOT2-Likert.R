
if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}
if (!require("xtable")) {
  install.packages("xtable")
  library(xtable)
}

if (!require("likert")) {
  install.packages("likert")
  library(likert)
}

library(dplyr)

if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}

install.packages('svglite')

source("HelperFunctions.R")

data <- read.csv("Application/Study/Likerts/Data/graphs.csv")
#data <- read.csv("Application/Study/Likerts/Data/interaction.csv")
#data <- read.csv("Application/Study/Likerts/Data/usability.csv")



#We remove the row scale max
scales <- data[1,]
# We remove the first row which only gives us the max scale
data <- data[-1,]

summary(data)

datalikert5 <- data$Participant

for(i in 2:ncol(data)){
    if(scales[i] == 5){
    datalikert5 <- cbind(datalikert5,data[i])
    
    }
  data[[i]] <- factor(data[[i]], levels = 1:5, labels = letters[1:5])
}

#Change colnam to id 
colnames(datalikert5)[1] <- "id"

#Let's now plot the data for both levels of granularity
datalikert5[2:ncol(datalikert5)] <- lapply(datalikert5[2:ncol(datalikert5)], factor, levels=1:5)

names(datalikert5) <- c("Id", "Line Graph","Silhouette Graph","Horizon Graph")
#names(datalikert5) <- c("Id", "Brush","Zoom")
#names(datalikert5) <- c("Id", "SimpleToUse","UnderstandFast","HelpInBeginning","WellIntegrated","UseTheTool")


str(datalikert5)
likt <- likert(datalikert5[2:ncol(datalikert5)])

p <- likert.bar.plot(
  likt, 
  high.color = "#19A79B", 
  low.color = "#E67A2B",
  neutral.color = "#f5f5f5", 
  ordered = FALSE,
  wrap = 100,
  text.size=2,
  wrap.grouping = 100,
  legend.position = "bottom",
  legend='Strongly disagree',
  )
names(likt$results) <- c("Item", "1", "2", "3", "4", "5")
font_size <- 2
p + guides(fill=guide_legend(nrow=1)) + theme(axis.text.x.bottom = element_text(size=font_size),
          axis.text.y = element_text(size=font_size),
          legend.title = element_text(size=font_size),
          legend.text = element_text(size = font_size),
          axis.title.x.bottom = element_text(size=font_size))
#setEPS()
#postscript("Figures/graphs.pdf",width = 20,height = 4, onefile = FALSE)
#postscript("Figures/interaction.pdf",width = 20,height = 4)
#postscript("Figures/usability.pdf",width = 20,height = 4)

plot(p)
#ggsave(file="test.svg", plot=p, width=10, height=8)
#figureName <- "Figures/usability.pdf"
#figureName <- "Figures/interaction.pdf"
figureName <- "Figures/graphs.pdf"
ggsave(figureName)
#dev.off()


