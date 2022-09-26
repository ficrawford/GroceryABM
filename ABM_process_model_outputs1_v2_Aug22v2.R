library(dplyr)
library(reshape2)
library(ggplot2)

setwd("C:/Users/f-crawford/OneDrive - UWE Bristol/Dissertation/Python_initial/AAA Final12_baseline COMBINED")

list.files()


all_folders1 <- c(list.files())
all_folders1 <- all_folders1[grepl("Final12_baseline_", all_folders1)]


mod_name <- all_folders1[1]
mod_name <- substr(mod_name, 
                   which(strsplit(mod_name, "")[[1]] == "_") +1,
                   nchar(mod_name)-1)


all_files <- c("hist_avcupboard.csv", "hist_emptycupboard.csv", 
                  "hist_successes.csv", "hist_totpurch.csv", 
                  "hist_totshop.csv", "hist_varcupboard.csv",
                "hist_EndOfDay.csv")


avcupboard1 <- read.csv(paste(all_folders1[1], all_files[1], 
                              sep = "/"),
                      stringsAsFactors = F)

emptycupboard1 <- read.csv(paste(all_folders1[1], all_files[2], 
                                 sep = "/"),
                           stringsAsFactors = F)

successes1 <- read.csv(paste(all_folders1[1], all_files[3], 
                             sep = "/"),
                       stringsAsFactors = F)

totpurch1 <- read.csv(paste(all_folders1[1], all_files[4], 
                            sep = "/"),
                      stringsAsFactors = F)

totshop1 <- read.csv(paste(all_folders1[1], all_files[5], 
                           sep = "/"),
                     stringsAsFactors = F)

varcupboard1 <- read.csv(paste(all_folders1[1], all_files[6], 
                               sep = "/"),
                         stringsAsFactors = F)

endofday1 <- read.csv(paste(all_folders1[1], all_files[7], 
                               sep = "/"),
                         stringsAsFactors = F)








###############################################
##  read in other files to append

for (k in 1:(length(all_folders1)-1)){
    
    avcupboard2 <- read.csv(paste(all_folders1[k+1], 
                                  all_files[1],
                                  sep = "/"),
                            stringsAsFactors = F, 
                            header = TRUE)
    colnames(avcupboard2) <- colnames(avcupboard1)
    avcupboard1 <- rbind(avcupboard1, avcupboard2)
    
    
    emptycupboard2 <- read.csv(paste(all_folders1[k+1], 
                                     all_files[2],
                                     sep = "/"),
                               stringsAsFactors = F, 
                               header = TRUE)
    colnames(emptycupboard2) <- colnames(emptycupboard1)
    emptycupboard1 <- rbind(emptycupboard1, emptycupboard2)
    
    
    successes2 <- read.csv(paste(all_folders1[k+1], 
                                 all_files[3],
                                 sep = "/"),
                           stringsAsFactors = F, 
                           header = TRUE)
    colnames(successes2) <- colnames(successes1)
    successes1 <- rbind(successes1, successes2)
    
    
    totpurch2 <- read.csv(paste(all_folders1[k+1], 
                                all_files[4],
                                sep = "/"),
                          stringsAsFactors = F, 
                          header = TRUE)
    colnames(totpurch2) <- colnames(totpurch1)
    totpurch1 <- rbind(totpurch1, totpurch2)
    
    
    totshop2 <- read.csv(paste(all_folders1[k+1], 
                               all_files[5],
                               sep = "/"),
                         stringsAsFactors = F, 
                         header = TRUE)
    colnames(totshop2) <- colnames(totshop1)
    totshop1 <- rbind(totshop1, totshop2)
    
    
    varcupboard2 <- read.csv(paste(all_folders1[k+1], 
                                   all_files[6],
                                   sep = "/"),
                             stringsAsFactors = F, 
                             header = TRUE)
    colnames(varcupboard2) <- colnames(varcupboard1)
    varcupboard1 <- rbind(varcupboard1, varcupboard2)
    
    
    endofday2 <- read.csv(paste(all_folders1[k+1], 
                                   all_files[7],
                                   sep = "/"),
                             stringsAsFactors = F, 
                          header = TRUE)
    colnames(endofday2) <- colnames(endofday1)
    endofday1 <- rbind(endofday1, endofday2)
    
    
    


}








### then write files:
# row.names(avcupboard2) <- avcupboard2$run_num
write.csv(avcupboard1, 
          file=paste0("./Combined_outputs/histcombv3_", 
                      mod_name,
                      "_",
                      all_files[1]), 
          row.names = F)

write.csv(emptycupboard1, 
          file=paste0("./Combined_outputs/histcombv3_", 
                      mod_name,
                      "_",
                      all_files[2]),
          row.names = F)

write.csv(successes1, 
          file=paste0("./Combined_outputs/histcombv3_", 
                      mod_name,
                      "_",
                      all_files[3]),
          row.names = F)

write.csv(totpurch1, 
          file=paste0("./Combined_outputs/histcombv3_", 
                      mod_name,
                      "_",
                      all_files[4]),
          row.names = F)

write.csv(totshop1, 
          file=paste0("./Combined_outputs/histcombv3_", 
                      mod_name,
                      "_",
                      all_files[5]),
          row.names = F)

write.csv(varcupboard1, 
          file=paste0("./Combined_outputs/histcombv3_", 
                      mod_name,
                      "_",
                      all_files[6]),
          row.names = F)

write.csv(endofday1, 
          file=paste0("./Combined_outputs/histcombv3_", 
                      mod_name,
                      "_",
                      all_files[7]),
          row.names = F)













