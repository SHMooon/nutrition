

library(decisionSupport)


decision_SSB_Tax <- function(x, varnames){
  
  
  #Estimate Saved cost of Diabetes care
  
  saved_diabetes <- red_diabetes * saved_diabetes
  
  #Estimate Saved cost of Obesities care
  
  saved_obesities <- red_obesity * saved_obesity
  
  #Estimate Saved cost of Cancers care
  saved_cancer <- red_cancer * saved_cancer
  
  #calculation saved Health care 
  saved_health_care <- sum(saved_diabetes + saved_obesities +
                             saved_cancer)
  
  #Estimate implement cost 
  
  implementation_cost <- sum(intervention_costs_admin + intervention_costs_prod + 
                               intervention_costs_info)
  
  #Esitmate final result (saving - cost)
  final_result <- saved_health_care - implementation_cost
 
  
  
  #not clear
  NPV_interv <-
    discount(result_interv, discount_rate, calculate_NPV = TRUE)
  
  NPV_n_interv <-
    discount(result_n_interv, discount_rate, calculate_NPV = TRUE)
  
  
  return(list(Interv_NPV = NPV_interv,
              NO_Interv_NPV = NPV_n_interv,
              NPV_decision_do = NPV_interv - NPV_n_interv,
              Cashflow_decision_do = result_interv - result_n_interv))
  
  
  
  
  #Generate the list of outputs from the Monte Carlo simulation 
  return(list(final_result))
  
}


library(readr)
input_table <- read_csv("Input_table_updated_3.csv")
input_table


names(input_table)


###Model assessment###
mcSimulation_results <- mcSimulation(estimate = 
      estimate_read_csv("Input_table_updated2.csv"),
  model_function = decision_SSB_Tax,
  numberOfModelRuns = 500,
  functionSyntax = "plainNames"
)

###Plot Net Present Value (NPV) distributions###

decisionSupport::plot_distributions(mcSimulation_object = mcSimulation_results, 
                                    vars ,
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


