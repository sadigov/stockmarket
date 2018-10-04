


library(quantmod)
library(tseries)
library(timeSeries)
library(forecast)
library(xts)

# Pull data from Yahoo finance 
getSymbols('AMZN', from='2015-01-01', to='2018-10-04')

# Select the relevant close price series
stock_prices = AMZN[,4]
