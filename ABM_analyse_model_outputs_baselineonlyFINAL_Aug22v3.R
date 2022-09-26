library(tidyverse)
library(reshape2)
library(ggplot2)
# library(DescTools)

setwd("C:/Users/f-crawford/OneDrive - UWE Bristol/Dissertation/Python_initial/AAA Final12_baseline COMBINED")

all_vars <- c("avcupboard", "emptycupboard", 
              "totpurch", 
              "totshop", "varcupboard")

all_var_labels <- c("Average food stock in cupboards", 
                    "Number of agents with\nno food stock in cupboards", 
              "Total food purchased", 
              "Total food required", 
              "Variance between agents in\nfood stock in cupboards")




# read in relevant files


for (j in 1:length(all_vars)){
  
    file_name1 <- paste0("./Combined_outputs/histcombv3_baseline__hist_", 
                         all_vars[j], ".csv")
    baseline1 <- read.csv(file_name1,
                          stringsAsFactors = F, header = TRUE)
    baseline1 <- baseline1[baseline1$run_num != "run_num",]
    

    # for each batch, row numbers are 1-100 so need to differentiate
    baseline1$run_num <- c(1:nrow(baseline1))
    baseline1[,2:ncol(baseline1)] <- apply(baseline1[,2:ncol(baseline1)], 2,            
                                           function(x) as.numeric(as.character(x)))
    
    
    baseline2 <- apply(baseline1[, !(colnames(baseline1) %in% "run_num")], 
                       2, 
                       median)
    
    all_data1 <- as.data.frame(baseline2)
    
    
  # need numeric day col for plots
  all_data1$day <- row.names(all_data1)
  all_data1$day <- substr(all_data1$day, 
                          which(strsplit(all_data1$day, "")[[1]] == "_") +1,
                          nchar(all_data1$day))
  all_data1$day <- as.numeric(all_data1$day)
  
  all_data2 <- all_data1 %>% 
    pivot_longer(!day, names_to = "model1", 
                 values_to = "median1")
  
  all_data2$median2 <- as.numeric(all_data2$median1)
  all_data2$median1 <- NULL
  
  
  
  
  
  # bootstrapping for CI of medians
  uppANDlowCI <- apply(baseline1, 2, function(x) stats::quantile(x, c(.025, 0.975)))
  
  uppANDlowCI <- t(uppANDlowCI)
  uppANDlowCI <- as.data.frame(uppANDlowCI)
  uppANDlowCI <- uppANDlowCI[!(row.names(uppANDlowCI) == "run_num"),]

  # sort out day column so we can merge in
  uppANDlowCI$day <- row.names(uppANDlowCI)
  uppANDlowCI$day <- substr(uppANDlowCI$day, 
                          which(strsplit(uppANDlowCI$day, "")[[1]] == "_") +1,
                          nchar(uppANDlowCI$day))
  uppANDlowCI$day <- as.numeric(uppANDlowCI$day)
  
  all_data3 <- merge(all_data2, uppANDlowCI,
                     by = "day", all = T)
  
  all_data3 <- rename(all_data3, c(low_bound = `2.5%`, upper_bound = `97.5%`))

  
print(ggplot(all_data3, aes(x=day, y=median2))+ 
          geom_ribbon(aes(y = median2, ymin = low_bound, ymax = upper_bound),
                      fill="turquoise1", alpha = 0.6)+
          geom_line(colour = "black")+
    theme_bw()+
    theme(legend.position = "none",
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 14))+
  ylab(all_var_labels[j])+
  xlab("Day")+
  scale_x_continuous(breaks = seq(0, 400, by = 50)))
  
  
}






