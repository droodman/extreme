set more off

use http://fmwww.bc.edu/repec/bocode/p/portpirie, clear
extreme gev SeaLevel
extreme plot, xiprofile(-.3 .3) retprofile(4.15 4.6, period(10)) // Figures 3.2, 3.3
extreme plot, retprofile(4.4 6, period(100)) pp qq return density // Figures 3.4, 3.5
est store GEV // save results for this unrestricted model

extreme gev SeaLevel, gumbel // impose Gumbel constraint (xi = 0)
lrtest GEV . // likelihood ratio test of Gumbel vs. unrestricted model: accepts restriction
extreme plot, pp qq return density // Figure 3.6

use http://fmwww.bc.edu/repec/bocode/g/glass
gen negBreakingStrength = -BreakingStrength
extreme gev negBreakingStrength
extreme plot, pp qq return density // Figure 3.7

use http://fmwww.bc.edu/repec/bocode/v/venice, clear
extreme gev SeaLevel1 // Table 3.1
extreme gev SeaLevel1-SeaLevel5 // Table 3.1
extreme plot, pp qq return density // Figure 3.9
extreme gev SeaLevel1-SeaLevel10 // Table 3.1: use 10 order stats, except only 6 availble for 1935

forvalues r=2/10 {
 extreme gev SeaLevel1-SeaLevel`r'
 extreme plot, return name(v`r') nodraw title(r=`r')
}
graph combine v2Return v3Return v4Return v5Return v6Return v7Return v8Return v9Return v10Return // Figure 3.8

* Examples from Coles (2001), chapter 4

use http://fmwww.bc.edu/repec/bocode/r/rain
extreme plot Rainfall, mrl(. .) // Figure 4.1
extreme gpd Rainfall, thresh(0(2.5)50) // Figure 4.2
extreme gpd Rainfall, thresh(30)
extreme plot, pp qq return density // Figure 4.3
nlcom Return100: `e(threshold)' + exp([lnsig]_cons)/[xi]_cons * ((365*100 * `e(zeta)')^[xi]_cons - 1) // conf. interval for 100-year return level
extreme plot, xiprofile(-.1 .6) retprofile(79 220, period(36500)) // Figures 4.4, 4.5

use http://fmwww.bc.edu/repec/bocode/d/dowjones, clear
gen change = 100*ln(Index/Index[_n-1])
extreme plot change, mrl(-7 5) // Figure 4.6
extreme gpd change, thresh(2)
extreme plot, pp qq return density // Figure 4.7

* Examples from Coles (2001), chapter 6

use http://fmwww.bc.edu/repec/bocode/p/portpirie, clear
extreme gev SeaLevel
est store Stationary
extreme gev SeaLevel, muvar(Year) // add covariate Year to location equation
lrtest Stationary . // LR test comparing it to stationary model

use http://fmwww.bc.edu/repec/bocode/f/fremantle
replace Year = Year - 1896 // code 1897 as 1
extreme gev SeaLevel // stationary model
est store Stationary
extreme gev SeaLevel, muvar(Year) // add covariate Year to location equation
predict muhat
scatter SeaLevel Year || line muhat Year // Figure 6.1
lrtest Stationary . // LR test comparing it to stationary model
est store muYear
extreme plot, pp qq // Figure 6.2
extreme gev SeaLevel, muvar(SOI) // add covariate Southern Oscillation Index to location equation
extreme gev SeaLevel, muvar(Year SOI) // add Year back too
lrtest muYear . // LR test comparing this to Year-only model

use http://fmwww.bc.edu/repec/bocode/v/venice, clear
extreme gev SeaLevel*, muvar(Year)
predict muhat
scatter SeaLevel* Year, pstyle(p1...) msize(vsmall...) || line muhat Year, legend(off) // Figure 6.5

use http://fmwww.bc.edu/repec/bocode/r/rain, clear
gen time = _n
extreme gpd Rainfall, thresh(30) sigvar(time) // model log sigma = beta_0 + beta_1*time
extreme plot, pp qq // Figure 6.7

use http://fmwww.bc.edu/repec/bocode/w/wooster, clear
gen negTemperature = -Temperature
gen byte Season = mod(floor((Day+30)/(365.25/4)),4)+1 // seasons definition?
mat threshmat = -10, -25, -50, -30 // Coles seasonal thresholds
gen threshvar = threshmat[1,Season]
bysort Season: extreme gpd negTemperature, thresh(threshvar) // separate model for each season
extreme gpd negTemperature, thresh(threshvar) sigvar(ibn.Season, nocons) // combined model with single shape parameter

* Other examples

use http://fmwww.bc.edu/repec/bocode/p/portpirie, clear
extreme gev SeaLevel
extreme plot, xiprofile(-.3 .3) retprofile(4.15 4.6, period(10))
mat list e(xiprofileCI) // programmatically extract profile-based confidence interval for xi
mat list e(retprofileCI) // programmatically extract profile-based confidence interval for return level
extreme plot, qq scheme(s1rcolor) aspect(1) title(Quantile-quantile plot) xtitle(Modeled sea level quantile) // Q-Q plot with altered appearance
extreme gev SeaLevel, muvar(Year) small(cs) // Cox-Snell small-sample correction for non-stationary GEV model
extreme gev SeaLevel, muvar(Year) small(cs) vce(bs, reps(100)) // Same, with bootstrapped standard errors
extreme gev SeaLevel, muvar(Year) small(bs, reps(200)) // Parametric-bootstrap-based bias correction and standard errors
predict mypr, pr // Predict probability densities
predict myretlevel, invccdf(1/100) // Predict 100-year SeaLevel value, as modeled function of Year
