

url <- "http://rkr.statistikbank.dk/statbank5a/temp/2016426161931171565390BM01058787851190.txt"

loc <- readr::locale(decimal_mark = ",", encoding = "Latin1")

BM010 <- readr::read_tsv(url, locale = loc)

urls <-
c(
"http://rkr.statistikbank.dk/statbank5a/temp/201642785743171585499BM01032428154780.txt",
"http://rkr.statistikbank.dk/statbank5a/temp/20164279259171585499BM01032586081673.txt",
"http://rkr.statistikbank.dk/statbank5a/temp/20164279347171585499BM01032634714969.txt",
"http://rkr.statistikbank.dk/statbank5a/temp/20164279430171585499BM01032680264943.txt",
"http://rkr.statistikbank.dk/statbank5a/temp/2016427952171585499BM01032713827312.txt"
)


BM010 <- data.frame()

for(i in urls) {

  BM010_data <- readr::read_tsv(i, locale = loc)
  BM010 <- rbind(BM010, BM010_data)

}

BM010 <- BM010[,-100]

BM010[,4:99] <- sapply(BM010[,4:99], function(x) as.numeric(x))

save(BM010, file = "data/BM010.rda")
