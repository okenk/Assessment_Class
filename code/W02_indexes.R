## ---- eval=FALSE-------------------------------------------------------------------------------------
## remotes::install_github("pfmc-assessments/nwfscSurvey")


## ----plot_cpue, fig.show='hide'----------------------------------------------------------------------
library(nwfscSurvey)
# Pull survey data from NWFSC data warehouse
catch <- PullCatch.fn(Name = "rex sole", # all lowercase 
                      SurveyName = "NWFSC.Combo",
                      SaveFile = FALSE)
plot_cpue(dir = NULL, catch)




## ----strata, results='hide'--------------------------------------------------------------------------
strata <- CreateStrataDF.fn(
  names = c("shallow_s", "mid_s", "deep_s", "shallow_n", "mid_n", "deep_n"), 
  depths.shallow = c( 55,   200, 300,    55, 200, 300),
  depths.deep    = c(200,   300, 400,   200, 300, 400),
  lats.south     = c( 32,    32,  32,    42,  42,  42),
  lats.north     = c( 42,    42,  42,    49,  49,  49))
strata




## ----index_plot, fig.show='hide'---------------------------------------------------------------------
biomass <- Biomass.fn(dir = NULL, 
                      dat = catch,  
                      strat.df = strata)
ggplot(biomass$Bio) +
  geom_pointrange(aes(x = as.numeric(Year),
                      y = Value,
                      ymin = exp(log(Value) - 1.96*seLogB),
                      ymax = exp(log(Value) + 1.96*seLogB))) +
  labs(x = 'Year', y = 'Index')

