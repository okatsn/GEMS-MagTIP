
## Introduction

MagTIP calculates the TIP (Time of Increased Probability) of earthquakes basing on the geomagnetic records of Central Weather Bureau of Taiwan. 
The algorithm allows for the optimization of the model parameters, and gives the overall TIP (named joint-station TIP). 
The probability of capturing a target event in space and time can be derived based on the joint-station TIP, by considering the results from a large set of randomly permuted of model parameters simultaneously.

In the traditional TIP forecasting, the type and the number of input data have to be uniquely formatted otherwise re-training according to the new format is required. 
As a result, either the conversion for fitting new data to old format (where some information must lose), or an extra waiting period (e.g. 7 years) for re-training models with new data, is required. 
The time scale of the evolution of the underground dynamical system is generally thought to be large, hence data collected from old stations are precious. For being able to fully utilizing both the data from the most modern instruments and older sensors, the project of this year aims for the multivariate MagTIP forecasting system. 

The newest multivariate MagTIP forecasting system not only supports three-component and one-component geomagnetic signals simultaneously, but also allows additional earthquake-relevant time series to be involved in calculating TIP.

