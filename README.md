# GroceryABM

This repository contains the code developed by Fiona Crawford as part of her dissertation at Cardiff University.  The aim of the project was to develop a prototype agent-based model of grocery shopping behaviour which can respond to demand- and supply-side disruptions.

The agent-based model itself can be viewed in the file titled Diss_ABM_Model1v12_baseline_multi2_final3_Aug22.ipynb.  

In order to see how the parameters change for scenario D (all three disruptions combined), the file Diss_ABM_Model1v12_baseline_multi2_final3_Aug22_ALL3.ipynb has also been uploaded.  

In both cases, the input files required are: ABM_input_locs4.csv and ABM_input_shops4.csv (these are also available in this repository).






A sample of the code used for analysing the outputs are:

ABM_process_model_outputs1_v2_Aug22v2.R => to combine the model outputs

ABM_analyse_model_outputs_baselineonlyFINAL_Aug22v3.R => to generate some of the baseline graphs

ABM_analyse_model_outputs_allFINAL_shopsattempted_TYPELOC_75perc.R => to examine the number of shopping trips attempted

ABM_Vis_KPIs_v2.Rmd => used in early testing to check that the model is functioning correctly by examining much more detailed model outputs for a limited number of runs (the pdf file of the same name is the knitted version).
