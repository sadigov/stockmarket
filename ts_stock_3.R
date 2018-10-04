# https://ntguardian.wordpress.com/2017/03/27/introduction-stock-market-data-r-1/
# https://ntguardian.wordpress.com/2017/04/03/introduction-stock-market-data-r-2/


library(magrittr)
require(knitr)
library(quantmod)
library(tseries)
library(timeSeries)
library(forecast)
library(xts)


start <- as.Date("2017-01-01")
end <- as.Date("2018-10-04")

# Let's get Apple stock data; Apple's ticker symbol is AAPL. We use the
# quantmod function getSymbols, and pass a string as a first argument to
# identify the desired ticker symbol, pass 'yahoo' to src for Yahoo!
# Finance, and from and to specify date ranges

# The default behavior for getSymbols is to load data directly into the
# global environment, with the object being named after the loaded ticker
# symbol. This feature may become deprecated in the future, but we exploit
# it now.

getSymbols("AMZN", src = "yahoo", from = start, to = end)

plot(AMZN[, "AMZN.Close"], main = "AMZN")

candleChart(AMZN, up.col = "black", dn.col = "red", theme = "white")

stock_return = apply(AMZN, 1, function(x) {x / AMZN[1,]}) %>%  t %>% as.xts

head(stock_return)

stock_change = AMZN %>% log %>% diff
head(stock_change)
plot(as.zoo(stock_change), screens = 1, lty = 1:3, xlab = "Date", ylab = "Log Difference")

# Moving Avrage
candleChart(AMZN, up.col = "black", dn.col = "red", theme = "white")
addSMA(n = c(20, 50, 200))
