library(decisionSupport)

make_variables<-function(est,n=1)
{ x<-random(rho=est, n=n)
for(i in colnames(x)) assign(i, as.numeric(x[1,i]),envir=.GlobalEnv)}

make_variables(estimate_read_csv("Presentation/input_table_updated_3.csv"))




example_decision_function <- function(x, varnames){
  
<<<<<<< HEAD
  # total health care cost 
  cost_diabetes <-vv(total_diabetes_case, var_CV, n_years)*
    vv(cost_diabetes_euro, var_CV, n_years)
  
  cost_obesities <- vv(total_obesity_case, var_CV, n_years)*
    vv(cost_obesity_euro, var_CV, n_years)
  
  cost_cancer <- vv(total_cancer_case, var_CV, n_years)*
    vv(cost_cancer_euro, var_CV, n_years)
  
  total_health_care_cost <- cost_diabetes + cost_obesities + cost_cancer
=======
  # total health care cost per year for Germany 
  # related to sugar consumption:
  # type 2 diabetes, cancer and obesity 
  cost_diabetes <-vv(total_diabetes_case*proportion_cases_from_sugar, var_CV, n_years)*
    vv(cost_diabetes_euro, var_CV, n_years)
  
  cost_obesities <- vv(total_obesity_case*proportion_cases_from_sugar, var_CV, n_years)*
    vv(cost_obesity_euro, var_CV, n_years)
  
  cost_cancer <- vv(total_cancer_case*proportion_cases_from_sugar, var_CV, n_years)*
    vv(cost_cancer_euro, var_CV, n_years)
  

>>>>>>> 2956b3bfa89ab4bd1485aa35b1c84369794e6187
  
  
  # pre-calculate common random draws for all intervention model runs ####
  #health care cost after implementation of tax and Tax revenue 
  
<<<<<<< HEAD
  precalc_HC_with_interv_Tax_DI <- (vv(total_diabetes_case, var_CV, n_years)*
                                  vv(cost_diabetes_euro, var_CV, n_years)) - 
    (vv(red_diabetes_case, var_CV, n_years)* vv(cost_diabetes_euro, var_CV, n_years))
  
  
  precalc_HC_with_interv_Tax_OB <-  (vv(total_obesity_case, var_CV, n_years)*
                                   vv(cost_obesity_euro, var_CV, n_years))-
    (vv(red_obesity_case, var_CV, n_years)*vv(cost_obesity_euro, var_CV, n_years))
  
  precalc_HC_with_interv_Tax_CA <- (vv(total_cancer_case, var_CV, n_years)*
                                  vv(cost_cancer_euro, var_CV, n_years))- 
    (vv(red_cancer_case, var_CV, n_years)*vv(cost_cancer_euro, var_CV, n_years))
=======
  precalc_HC_with_interv_Tax_DI <- (vv(total_diabetes_case*proportion_cases_from_sugar, var_CV, n_years)*
                                  vv(cost_diabetes_euro, var_CV, n_years)) - 
    (vv(red_diabetes_case*proportion_cases_from_sugar, var_CV, n_years)* vv(cost_diabetes_euro, var_CV, n_years))
  
  
  precalc_HC_with_interv_Tax_OB <-  (vv(total_obesity_case*proportion_cases_from_sugar, var_CV, n_years)*
                                   vv(cost_obesity_euro, var_CV, n_years))-
    (vv(red_obesity_case*proportion_cases_from_sugar, var_CV, n_years)*vv(cost_obesity_euro, var_CV, n_years))
  
  precalc_HC_with_interv_Tax_CA <- (vv(total_cancer_case*proportion_cases_from_sugar, var_CV, n_years)*
                                  vv(cost_cancer_euro, var_CV, n_years))- 
    (vv(red_cancer_case*proportion_cases_from_sugar, var_CV, n_years)*vv(cost_cancer_euro, var_CV, n_years))
>>>>>>> 2956b3bfa89ab4bd1485aa35b1c84369794e6187
  
  
  precalc_tax_revenue <- vv(revenue_tax_euro, var_CV, n_years)
  
  
  ###Intervention of implementation SSB Tax ###
  
  for (decision_implementation_SSB_Tax in c(FALSE,TRUE)){
    
    if (decision_implementation_SSB_Tax){
      
      implementation_SSB_Tax <- TRUE
      implementation_admin <- TRUE
      no_implementation <- FALSE
      
    } else
    {
      implementation_SSB_Tax <- FALSE
      implementation_admin <- FALSE
      no_implementation <- TRUE
      
    }
    
    
    ##cost for intervention##
    if (implementation_admin){
      cost_implementation_govern <-
        implementation_costs_admin + implementation_costs_info
    } else{
      cost_implementation_govern <- 0
      }
    
   
    
    # calculating the maintenance costs, initializing the array with 0 costs for the first year:
    maintenance_cost <- rep(0, n_years)
    
    if (implementation_SSB_Tax){
      maintenance_cost <-
      maintenance_cost + vv(maintenance_intervention_SSB_Tax, 
                            var_CV, n_years)
    
    intervention_cost <- maintenance_cost
    
    #intervention cost for first year 
    intervention_cost[1] <-
      cost_implementation_govern 
    }
    
    
    # health care cost after SSB Tax  ####
    
    
    implementation_SSB_Tax_Di <- 
      as.numeric(implementation_SSB_Tax) * precalc_HC_with_interv_Tax_DI
    implementation_SSB_Tax_OB <-
      as.numeric(implementation_SSB_Tax) * precalc_HC_with_interv_Tax_OB
    implementation_SSB_Tax_Ca <- 
      as.numeric(implementation_SSB_Tax) * precalc_HC_with_interv_Tax_CA
    
    
    total_healthcare_cost_with_SSB_Tax <-
      implementation_SSB_Tax_Di + implementation_SSB_Tax_OB + implementation_SSB_Tax_Ca
    
    implementation_SSB_Tax_tax_revenue <- 
      as.numeric(implementation_SSB_Tax) * precalc_tax_revenue
  
    #Health care cost without SSB Tax   
        
    cost_diabetes_no_SSB_Tax <-  as.numeric(no_implementation)*cost_diabetes
    
    cost_obesities_no_SSB_Tax <- as.numeric(no_implementation)* cost_obesities
    
    cost_cancer_no_SSB_Tax <- as.numeric(no_implementation)*cost_cancer
    
      total_health_care_cost_no_SSB_Tax <- 
        cost_diabetes_no_SSB_Tax + cost_obesities_no_SSB_Tax + cost_cancer_no_SSB_Tax
        
        
    
    if(implementation_SSB_Tax){
      imple_tax_revenue <- implementation_SSB_Tax_tax_revenue
    } else imple_tax_revenue <- 0
    
    
    ## Total cost with SSB tax##
    if (decision_implementation_SSB_Tax){
      
      net_health_care_cost_with_imple <-  
<<<<<<< HEAD
        total_healthcare_cost_with_SSB_Tax  - intervention_cost + implementation_SSB_Tax_tax_revenue
=======
        total_healthcare_cost_with_SSB_Tax + intervention_cost - implementation_SSB_Tax_tax_revenue
>>>>>>> 2956b3bfa89ab4bd1485aa35b1c84369794e6187
      #-(Healthcare cost with intervention -intervention implementation cost + tax_difference due to internvention)
      
      result_imple <- net_health_care_cost_with_imple
    }
    
    
    if (!decision_implementation_SSB_Tax){
      net_health_care_cost <- total_health_care_cost_no_SSB_Tax 
      
      result_no_imple <- net_health_care_cost
    }
    
  }#close implementation
  
  NPV_imple <-
    discount(result_imple, discount_rate, calculate_NPV = T)
  
  NPV_n_imple <-
    discount(result_no_imple, discount_rate, calculate_NPV = T)
  
  
  # Beware, if you do not name your outputs (left-hand side of the equal sign) in the return section, 
  # the variables will be called output_1, _2, etc.
  
<<<<<<< HEAD
  return(list(Imple_NPV =  - NPV_imple,
              NO_Imple_NPV = - NPV_n_imple,
              NPV_decision_do =  NPV_n_imple- NPV_imple,
              Cashflow_decision_do =  result_no_imple - result_imple))
=======
  return(list(Imple_NPV =  - NPV_imple, #invert because this is the spending
              NO_Imple_NPV = - NPV_n_imple, #invert because this is the spending
              NPV_decision_do =  NPV_n_imple - NPV_imple, #how much they will save
              Cashflow_decision_do =  result_no_imple - result_imple)) #how much they will save
>>>>>>> 2956b3bfa89ab4bd1485aa35b1c84369794e6187
}




library(readr)
input_table <- read.csv("Presentation/input_table_updated_3.csv")
names(input_table)


###Model assessment###
mcSimulation_results1 <- mcSimulation(estimate = 
                                        estimate_read_csv("Presentation/input_table_updated_3.csv"),
                                      model_function = example_decision_function,
<<<<<<< HEAD
                                      numberOfModelRuns = 200,
=======
                                      numberOfModelRuns = 2000,
>>>>>>> 2956b3bfa89ab4bd1485aa35b1c84369794e6187
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
<<<<<<< HEAD
                                    method = 'boxplot_density',
=======
                                    method = "smooth_simple_overlay",
>>>>>>> 2956b3bfa89ab4bd1485aa35b1c84369794e6187
                                    old_names = "NPV_decision_do",
                                    new_names = "Outcome distribution for savings")



###Cashflow analysis###
plot_cashflow(mcSimulation_object = mcSimulation_results1, 
              cashflow_var_name = "Cashflow_decision_do")


###Value of Information (VoI) analysis###

#here we subset the outputs from the mcSimulation function (y) by selecting the correct variables
# choose this carefully and be sure to run the multi_EVPI only on the variables that the you want
#EVPI = (EOL : Expected Opportunity Loss)



mcSimulation_table <- data.frame(mcSimulation_results1$x, mcSimulation_results1$y[1:3])

evpi <- multi_EVPI(mc = mcSimulation_table, first_out_var = "Imple_NPV")


plot_evpi(evpi, decision_vars = "NPV_decision_do")


#put here mcSimulation_result instead of pls_result
compound_figure(mcSimulation_object = mcSimulation_results1, 
                input_table = input_table, 
                plsrResults = mcSimulation_results1, 
                EVPIresults = evpi, decision_var_name = "NPV_decision_do", 
                cashflow_var_name = "Cashflow_decision_do", 
                base_size = 5)


###Projection to Latent Structures (PLS) analysis###

pls_result <- plsr.mcSimulation(object = mcSimulation_results1,
                                resultName = names(mcSimulation_results1$y)[3], ncomp = 1)
plot_pls(pls_result, input_table = input_table, threshold = 0)



a <- mean(mcSimulation_table$NPV_decision_do)
a
b <- sd(mcSimulation_table$NPV_decision_do)
c <- b/a
c
