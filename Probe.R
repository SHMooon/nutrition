library(decisionSupport)
example_decision_function <- function(x, varnames){
  
  
  
  # pre-calculate common random draws for all intervention model runs ####
  
  # benefits of Consumption
  precalc_intervention_Consumption<-
    vv(Rate_of_SBB_Consumption, var_CV, n_years) *
    vv(Rate_of_Diabetes_Population, var_CV, n_years) *
    
    
    # benefits of Risk
    precalc_intervention_Risk <-
      vv(Rate_of_Risk_of_Diabetes_with_lower_consumption, var_CV, n_years) *
      vv(Rate_of_Risk_of_Diabetes_with_higher_consumption, var_CV, n_years) *
      
      
      #  Intervention ####
    
    for (SSB_Tax in c(FALSE,TRUE)){
      
      if (SSB_Tax){
        
        intervention_strips <- TRUE
        intervention_strips_PlanningCost <- TRUE
        intervention_strips_cost <- TRUE
      } else
      {
        intervention_strips <- FALSE
        intervention_strips_PlanningCost <- FALSE
        intervention_strips_cost <- FALSE
      }
      
      
      # Benefits from  cultivation in the intervention strips ####
      
      intervention_Consumption <-
        as.numeric(intervention_strips) * precalc_intervention_Consumption
      intervention_Risk <-
        as.numeric(intervention_strips) * precalc_intervention_Risk
      
      # Total benefits from crop production (agricultural development and riparian zone) ####
      SSB_Tax <-
        intervention_Consumption +
        intervention_Risk 
      
      # Benefits from livestock ####
      # The following allows considering that intervention strips may
      # restrict access to the reservoir for livestock.
      
    }#close intervention loop bracket
    
    NPV_interv <-
      discount(result_interv, discount_rate, calculate_NPV = TRUE)
    
    NPV_n_interv <-
      discount(result_n_interv, discount_rate, calculate_NPV = TRUE)
    
    # Beware, if you do not name your outputs 
    # (left-hand side of the equal sign) in the return section, 
    # the variables will be called output_1, _2, etc.
    
    return(list(Interv_NPV = NPV_interv,
                NO_Interv_NPV = NPV_n_interv,
                NPV_decision_do = NPV_interv - NPV_n_interv,
                Cashflow_decision_do = result_interv - result_n_interv))
}

library(readr)
example_input_table <- read_csv("probe.csv")
example_input_table
names(input_table)


###Model assessment###
mcSimulation_results <- decisionSupport::mcSimulation(
  estimate = decisionSupport::estimate_read_csv("probe.csv"),
  model_function = example_decision_function,
  numberOfModelRuns = 200,
  functionSyntax = "plainNames"
)

###Plot Net Present Value (NPV) distributions###

decisionSupport::plot_distributions(mcSimulation_object = mcSimulation_results, 
                                    vars = c("Interv_NPV", "NO_Interv_NPV"),
                                    method = 'smooth_simple_overlay', 
                                    base_size = 7)

decisionSupport::plot_distributions(mcSimulation_object = mcSimulation_results, 
                                    vars = c("Interv_NPV",
                                             "NO_Interv_NPV"),
                                    method = 'boxplot')


decisionSupport::plot_distributions(mcSimulation_object = mcSimulation_results, 
                                    vars = "NPV_decision_do",
                                    method = 'boxplot_density')


###Cashflow analysis###

plot_cashflow(mcSimulation_object = mcSimulation_results, 
              cashflow_var_name = "Cashflow_decision_do")

###Value of Information (VoI) analysis###

#here we subset the outputs from the mcSimulation function (y) by selecting the correct variables
# choose this carefully and be sure to run the multi_EVPI only on the variables that the you want
mcSimulation_table <- data.frame(mcSimulation_results$x, mcSimulation_results$y[1:3])

evpi <- multi_EVPI(mc = mcSimulation_table, first_out_var = "Interv_NPV")

plot_evpi(evpi, decision_vars = "NPV_decision_do")

#put here mcSimulation_result instead of pls_result
compound_figure(mcSimulation_object = mcSimulation_results, 
                input_table = input_table, plsrResults = mcSimulation_results, 
                EVPIresults = evpi, decision_var_name = "NPV_decision_do", 
                cashflow_var_name = "Cashflow_decision_do", 
                base_size = 7)


+###Projection to Latent Structures (PLS) analysis###
  
  pls_result <- plsr.mcSimulation(object = mcSimulation_results,
                                  resultName = names(mcSimulation_results$y)[3], ncomp = 1)
plot_pls(pls_result, input_table = input_table, threshold = 0)


