#####Data Explorer is an R Package with commands to explore datasets efficiently. 
####By Boxuan Cui, Data Scientist at Smarter Traveler
####This script uses 6 commands to explore the dataset


###dataset: BostonHousing
###variables: begining dataset has 14, ending dataset has 18 which includes 4 transformed variables

#package mlbench, dataset BostonHousing from mlbench
library (mlbench)
data ("BostonHousing", package = "mlbench")

summary (BostonHousing)

plot_str(BostonHousing)



#initial visualization. first 3 commands to explore the data
library (DataExplorer)
plot_missing (BostonHousing) ##Are there missing values and what is the missing data profile?
plot_bar (BostonHousing) ##How does the categorical frequency for each discrete variable look like?
plot_histogram(BostonHousing) ##What is the distribution of each continous variable?

#transform variables based on results from histogram
##Set rad to factor
BostonHousing$rad <- as.factor (BostonHousing$rad)

##Creat new discrete variables, makes binary variables
for (col in c ("crim", "zn", "indus", "b"))
  BostonHousing[[paste0(col, "_d")]] <- as.factor (ggplot2::cut_interval(BostonHousing[[col]], 2))

##Plot bar chart for all discrete variables
plot_bar (BostonHousing)



#Plot variable medv against all other variables
plot_boxplot(BostonHousing, by = "medv")


plot_scatterplot(
  subset(BostonHousing, select = -c(crim, zn, indus, b)), by = "medv", size = 0.5)


#colorcoded correlation plot.  Plot all variables against all other variables
plot_correlation(BostonHousing)


##generate report in html
create_report(BostonHousing)