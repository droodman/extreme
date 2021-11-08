# extreme
 Extreme value theory package for Stata

extreme is a Stata package that fits  the most-used models in univariate extreme value theory, using Maximum Likelihood: the generalized Pareto distribution (GPD), which is appropriate for modeling exceedances of a threshold; the generalized extreme value distribution (GEV), which is appropriate for modeling block maxima; and the extension of the GEV for multiple order statistics for blocks. extreme also provides a variety of diagnostic and profile plots. extreme's major novelty is the ability to compute the Cox-Snell small-sample bias correction for all models fit. The correction for the GPD is derived in Giles, Feng, and Godwin (2015). The correction for the GEV, including for multiple order statistics, is new (Roodman 2018). The correction is also extended to non-stationary models. Maximum Likelihood is always biased in finite samples, and the bias can be significant in the small samples often used in extreme value analysis.

# Reference
Roodman, David. 2018. “Bias and Size Corrections in Extreme Value Modeling.” Communications in Statistics - Theory and Methods 47 (14): 3377–91. https://doi.org/10.1080/03610926.2017.1353630.
