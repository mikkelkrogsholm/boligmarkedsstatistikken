library(rvest)
library(stringr)
library(RSelenium)

BM010 <- data.frame()

checkForServer() # search for and download Selenium Server java binary.  Only need to run once.
startServer() # run Selenium Server binary
remDr <- remoteDriver(browserName="firefox", port=4444) # instantiate remote driver to connect to Selenium Server

Sys.sleep(5)

remDr$open(silent=T)

Sys.sleep(5)

remDr$navigate("http://rkr.statistikbank.dk/statbank5a/SelectVarVal/Define.asp?MainTable=BM020")

BM <- data.frame()

i <- unlist(remDr$getCurrentUrl())
BM_data <- readr::read_tsv(i, locale = loc)
BM <- rbind(BM, BM_data)


BM020 <- BM[,-100]

BM020[,4:99] <- sapply(BM020[,4:99], function(x) as.numeric(x))

save(BM020, file = "data/BM020.rda")

##################

"http://rkr.statistikbank.dk/statbank5a/SelectVarVal/Define.asp?MainTable=BM020"
