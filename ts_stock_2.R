# https://ionides.github.io/531w16/midterm_project/project21/531-Midterm_Project.html

require(knitr)
library(quantmod)
library(tseries)
library(timeSeries)
library(forecast)
library(xts)

# Pull data from Yahoo finance 
getSymbols('AMZN', from='2015-01-01', to='2018-10-04')

# Select the relevant close price series
stock_prices <-  AMZN[,4]

# Compute the log returns for the stock
stock <- diff(log(stock_prices),lag=1)
stock <- stock[!is.na(stock)]

# Plot log returns 
plot(stock, type='l', main='log returns plot')

plot(diff(sqrt(stock_prices)), type = "l", main = "Square root transformed data")

acf(stock)


ms_ts <- ts(stock, frequency = 365,start = 2015-01-01 )
ms_de <- decompose(ms_ts)
plot(ms_de)

# Then we fit the ARMA(p,q) model
ms_rand <- ms_de$random
aic_table <- function(data, P, Q){
  table <- matrix(NA,(P+1),(Q+1))
  for(p in 0:P) {
    for(q in 0:Q) {
      table[p+1,q+1] <- arima(data,order=c(p,0,q))$aic
    }
  }
  dimnames(table) <- list(paste("<b> AR",0:P, "</b>", sep=""), paste("MA",0:Q,sep=""))
  table
}

kable(ms_aic_table, digits=2)


arma11 <- arima(ms_rand, order = c(1,0,1));arma11


ms_rand1 <- ms_rand
r <- resid(arima(ms_rand1, order = c(1,0,1)))
plot(r)

acf(r)



ms_train <- ms_rand1[1:((0.9)*length(ms_rand1))]
ms_test <- ms_rand1[(0.9*length(ms_rand1)):length(ms_rand1)]
train11 <- arima(ms_train, order = c(1,0,1))
pred <- predict(train11, n.ahead = (length(ms_rand1)-(0.9*length(ms_rand1))))$pred
forecast <- forecast(train11, h = 25)
plot(forecast)
