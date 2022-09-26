
library(reshape2)
library(tidyverse)
library(scales)


setwd("C:/Users/f-crawford/OneDrive - UWE Bristol/Dissertation/Python_initial/AAA Final12_socialdist sets")

num_agents = 6000
all_vars <- c("successes")

all_var_labels <- c("Shopping success percentage")



# read in relevant files
j=1

# CI_data <- function(j){

  all_data4 <- data.frame(matrix(ncol = 6, nrow = 0))
  colnames(all_data4) <- c("model1", "day", "type1", 
                           "median1", "low_bound", "upper_bound")
  
  
  
      
        
        file_name1 <- paste0("Comb_socialdist_75PERCred_hist_", 
                             all_vars[j], ".csv")
        baseline1 <- read.csv(file_name1,
                              stringsAsFactors = F, header = TRUE)
 
        
        baseline1$X[baseline1$X == ""] <- NA
        
        baseline1 <- baseline1[baseline1$run_num != "run_num",]
        
        baseline1[,3:ncol(baseline1)] <- apply(baseline1[,3:ncol(baseline1)], 2,            
                                               function(x) as.integer(as.character(x)))
        
        
        baseline1$run_num[1] <- 1
        
        for (k in 2:nrow(baseline1)){
          
          if (is.na(baseline1$X[k])) baseline1$run_num[k] <- 1 + baseline1$run_num[k-1]
          if (!is.na(baseline1$X[k])) baseline1$run_num[k] <- baseline1$run_num[k-1]  
        }
        
        
        baseline1_succ_names <- stringr::str_split_fixed(baseline1$X, pattern = "_", n=3)
        baseline1[,c("result1", "type1", "storeloc1")] <- as.data.frame(baseline1_succ_names)
        
        
        baseline1$result1[is.na(baseline1$result1) | baseline1$result1 == ""] <- "No shop attempted"
        
        baseline1 <- as.data.frame(baseline1)
        
        baseline1$result1 <- factor(baseline1$result1,
                                    levels = c("No shop attempted",
                                               "Suc",
                                               "Part",                            
                                               "UnSuc"),
                                    labels = c("No shop attempted",
                                               "Successful",
                                               "Partially successful",                            
                                               "Unsuccessful"))
        
        baseline1$type1 <- factor(baseline1$type1,
                                  levels = c("",
                                             "supermarket",
                                             "online"),
                                  labels = c("No shop attempted",
                                             "Physical store",
                                             "Online"))
        
        ####  Get success %s
        
        ### DO FOR ONE LOCATION AT A TIME (automatically excludes not attempted)
        all_attempted <- subset(baseline1, storeloc1 %in% seq(0,3))
        
        
        
        
        all_attempted$result1[all_attempted$result1 == "Partially successful"] <- "Unsuccessful"
        
        all_attempted[is.na(all_attempted)] <- 0
        
        overall_succ2 <- all_attempted %>% 
          group_by(run_num, type1, storeloc1) %>% 
          summarise(across(starts_with("day_"),
                           ~ sum(.x, na.rm = TRUE))) 
        
        overall_succ3 <- overall_succ2 %>% 
          pivot_longer(colnames(overall_succ2)[grepl(pattern = "day_", 
                                                     colnames(overall_succ2))],
                        names_to = "day",
                       values_to = "count") 
        

        baseline2 <- overall_succ3 %>% 
          group_by(type1, day, storeloc1) %>% 
          summarise(median1 = median(count),
                    low_bound = quantile(count, 0.025),
                    upper_bound = quantile(count, 0.975))   
        
        
        baseline2$day <- substr(baseline2$day, 
                              which(strsplit(baseline2$day, "")[[1]] == "_") +1,
                              nchar(baseline2$day))
        baseline2$day <- as.numeric(baseline2$day)
        
    
        all_data3 <- baseline2[,c("type1", "day", "storeloc1",
                                  "median1", "low_bound", "upper_bound")]
      
      all_data4 <- rbind(all_data4, all_data3)
      

  

      
      
      
  
  
  
  
  

  all_data4$storeloc1 <- factor(all_data4$storeloc1,
                                levels = c(0:3),
                                labels = c(paste0("Zone ", 1:4)))

  
  # print(
    ggplot(all_data4, aes(x=day, y=median1, 
                              colour = type1,
                              fill = type1))+ 
          geom_ribbon(aes(y = median1, 
                          ymin = low_bound, ymax = upper_bound),
                       alpha = 0.2,
                      linetype = 0)+
          geom_line(size = 0.1)+
          theme_bw()+
          theme(axis.text = element_text(size = 10),
                legend.title = element_blank(),
                axis.title = element_text(size = 12),
                strip.background = element_rect(colour = "black", fill = "white"))+
          ylab("Number of shopping trips attempted")+
          xlab("Day")+
          ggtitle("Number of shops attempted")+
          scale_y_continuous(limits = c(0,NA)) +
          scale_x_continuous(breaks = seq(0, 400, by = 50))+
          scale_colour_brewer(palette = "Set1")+
          scale_fill_brewer(palette = "Set1")+
          facet_grid(storeloc1 ~.)
    
    # )
  
    
#   return(all_data4)
# }   
#     
#     
# ### to get successes:
# success_CIs <- CI_data(j=1)



    last_day1 <- subset(all_data4, day == 365)

