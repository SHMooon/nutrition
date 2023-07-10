library(decisionSupport)

make_variables<-function(est,n=1)
{ x<-random(rho=est, n=n)
for(i in colnames(x)) assign(i, as.numeric(x[1,i]),envir=.GlobalEnv)}
make_variables(estimate_read_csv("Input_table_updated_3.csv"))

example_decision_function <- function(x, varnames){
  
  # total health care cost 
  cost_diabetes <-vv(total_diabetes_case, var_CV, n_years)*
    vv(cost_diabetes_euro, var_CV, n_years)
  
  cost_obesities <- vv(total_obesity_case, var_CV, n_years)*
    vv(cost_obesity_euro, var_CV, n_years)
  
  cost_cancer <- vv(total_cancer_case, var_CV, n_years)*
    vv(cost_cancer_euro, var_CV, n_years)
  
  total_health_care_cost <- cost_diabetes + cost_obesities + cost_cancer
  
  
  # pre-calculate common random draws for all intervention model runs ####
  #saved health care cost after implementation of tax and Tax revenue 
  
  precalc_HC_with_interv_DI <- (vv(total_diabetes_case, var_CV, n_years)*
                                  vv(cost_diabetes_euro, var_CV, n_years)) - 
    (vv(red_diabetes_case, var_CV, n_years)* vv(cost_diabetes_euro, var_CV, n_years))
  
  
  precalc_HC_with_interv_OB <-  (vv(total_obesity_case, var_CV, n_years)*
                                   vv(cost_obesity_euro, var_CV, n_years))-
    (vv(red_obesity_case, var_CV, n_years)*vv(cost_obesity_euro, var_CV, n_years))
  
  precalc_HC_with_interv_CA <- (vv(total_cancer_case, var_CV, n_years)*
                                  vv(cost_cancer_euro, var_CV, n_years))- 
    (vv(red_cancer_case, var_CV, n_years)*vv(cost_cancer_euro, var_CV, n_years))
  
  precalc_tax_revenue <- vv(revenue_tax_euro, var_CV, n_years)
  
  
  

  ###Implementation###
  
  for (decision_implementation_SSB_Tax in c(FALSE,TRUE)){
    
    if (decision_implementation_SSB_Tax){
      
      implementation_SSB <- TRUE
      implementation_admin <- TRUE
      implementation_indu_info <- TRUE
    } else
    {
      implementation_SSB <- FALSE
      implementation_admin <- FALSE
      implementation_indu_info <- FALSE
    }
    
    
    ##cost for intervention##
    if (implementation_admin) {
      cost_implementation_admin <-
        intervention_costs_admin
    } else
      cost_implementation_admin <- 0
    
    
    if (implementation_indu_info) {
      cost_implementation_indu_info <-
        intervention_costs_prod + intervention_costs_info
    } else
      cost_implementation_indu_info <- 0
    
    # calculating the maintenance costs, initializing the array with 0 costs for the first year:
    maintenance_cost <- rep(0, n_years)
    
    if (implementation_SSB)
      maintenance_cost <-
      maintenance_cost + vv(maintenance_intervention_SSB_Tax, 
                            var_CV, n_years)
    
    intervention_cost <- maintenance_cost
    #intervention cost for first year 
    intervention_cost[1] <-
      intervention_cost[1] + 
      cost_implementation_admin + 
      cost_implementation_indu_info
    
    
    
    # Benefits from  saving in intervention SSB Tax ####
    
    # intervention_saved_health_care_cost <-
    #   as.numeric(implementation_SSB) * (precalc_imple_SSB_Tax)???
    
    ######
    implementation_SSB_tax_Di <- 
      as.numeric(intervention_cost) * precalc_HC_with_interv_DI
    implementation_SSB_tax_OB <-
      as.numeric(intervention_cost) * precalc_HC_with_interv_OB
    implementation_SSB_tax_Ca <- 
      as.numeric(intervention_cost) * precalc_HC_with_interv_CA
    
    HC_with_intervention <- implementation_SSB_tax_Di +implementation_SSB_tax_OB+
      implementation_SSB_tax_Ca
    
    
    
    if(implementation_SSB){
      imple_tax_revenue <- precalc_tax_revenue
    } else imple_tax_revenue <- 0
    
    
    ## Total saving with SSB tax##
    if (decision_implementation_SSB_Tax){
      
      net_health_care_cost <-   total_health_care_cost - (HC_with_intervention - intervention_cost + imple_tax_revenue)
        #-(Healthcare cost with intervention -intervention implementation cost + tax_difference due to internvention)
      
      result_imple <- net_health_care_cost
      }
    
    
    if (!decision_implementation_SSB_Tax){
      net_health_care_cost <- total_health_care_cost 
      
      result_n_imple <- net_health_care_cost
      }
    
  }#close implementation
  
  NPV_imple <-
    discount(result_imple, discount_rate, calculate_NPV = TRUE)
  
  NPV_n_imple <-
    discount(result_n_imple, discount_rate, calculate_NPV = TRUE)
  
  
  # Beware, if you do not name your outputs (left-hand side of the equal sign) in the return section, 
  # the variables will be called output_1, _2, etc.
  
  return(list(Imple_NPV = NPV_imple,
              NO_Imple_NPV = NPV_n_imple,
              NPV_decision_do = NPV_imple - NPV_n_imple,
              Cashflow_decision_do = result_imple - result_n_imple))
}

library(readr)
input_table <- read_csv("Input_table_updated_3.csv")
names(input_table)


###Model assessment###
mcSimulation_results1 <- mcSimulation(estimate = 
                                        estimate_read_csv("Input_table_updated_3.csv"),
                                      model_function = example_decision_function,
                                      numberOfModelRuns = 1000,
                                      functionSyntax = "plainNames"
)

###Plot Net Present Value (NPV) distributions###


plot_distributions(mcSimulation_object = mcSimulation_results1, 
                   vars = c("Imple_NPV",
                            "NO_Imple_NPV"),
                   method = 'smooth_simple_overlay', 
                   base_size = 10)


decisionSupport::plot_distributions(mcSimulation_object = mcSimulation_results1, 
                                    vars = c("Imple_NPV",
                                             "NO_Imple_NPV"),
                                    method = 'boxplot')


decisionSupport::plot_distributions(mcSimulation_object = mcSimulation_results1, 
                                    vars = "NPV_decision_do",
                                    method = 'boxplot_density')



###Cashflow analysis###
plot_cashflow(mcSimulation_object = mcSimulation_results1, 
              cashflow_var_name = "Cashflow_decision_do")

###Value of Information (VoI) analysis###

#here we subset the outputs from the mcSimulation function (y) by selecting the correct variables
# choose this carefully and be sure to run the multi_EVPI only on the variables that the you want
mcSimulation_table <- data.frame(mcSimulation_results1$x, mcSimulation_results1$y[1:3])

evpi <- multi_EVPI(mc = mcSimulation_table, first_out_var = "Imple_NPV")

plot_evpi(evpi, decision_vars = "NPV_decision_do")

#put here mcSimulation_result instead of pls_result
compound_figure(mcSimulation_object = mcSimulation_results1, 
                input_table = input_table, 
                plsrResults = mcSimulation_results1, 
                EVPIresults = evpi, decision_var_name = "NPV_decision_do", 
                cashflow_var_name = "Cashflow_decision_do", 
                base_size = 7)


###Projection to Latent Structures (PLS) analysis###
  
  pls_result <- plsr.mcSimulation(object = mcSimulation_results1,
                                  resultName = names(mcSimulation_results1$y)[3], ncomp = 1)
plot_pls(pls_result, input_table = input_table, threshold = 0)


