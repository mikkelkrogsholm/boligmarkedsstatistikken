library(stringr); library(dplyr)

BM010$kvartal <- BM010$date %>% str_replace_all("\\d{4}", "")
BM010$date <- BM010$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM010) <- c("price.type" ,"category","area","area.type","year","value","quarter")
BM010 <- BM010 %>% select(year, quarter, price.type, category, area, area.type, value)

###

BM011$kvartal <- BM011$date %>% str_replace_all("\\d{4}", "")
BM011$date <- BM011$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM011) <- c("price.type" ,"category","postalcode","year","value","quarter")
BM011$postalarea <- BM011$postalcode %>% str_replace_all("\\d{4}", "") %>% str_trim()
BM011$postalarea <- BM011$postalarea %>% str_replace_all("[-]", "") %>% str_trim()
BM011$postalcode <- BM011$postalcode %>% str_replace_all("[^(\\d{4}]", "") %>% str_trim() %>% as.numeric()
BM011$postalcode <- BM011$postalcode %>% str_sub(1,4) %>% as.numeric()
BM011 <- BM011 %>% select(year, quarter, price.type, category, postalcode, postalarea, value)
BM011 <- BM011 %>% arrange(postalcode)

###

BM020$kvartal <- BM020$date %>% str_replace_all("\\d{4}", "")
BM020$date <- BM020$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM020) <- c("sales.type" ,"category","area","area.type","year","count","quarter")
BM020 <- BM020 %>% select(year, quarter, sales.type, category, area, area.type, count)

###

BM021$kvartal <- BM021$date %>% str_replace_all("\\d{4}", "")
BM021$date <- BM021$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM021) <- c("sales.type" ,"category","postalcode","year","value","quarter")
BM021$postalarea <- BM021$postalcode %>% str_replace_all("\\d{4}", "") %>% str_trim()
BM021$postalarea <- BM021$postalarea %>% str_replace_all("[-]", "") %>% str_trim()
BM021$postalcode <- BM021$postalcode %>% str_replace_all("[^(\\d{4}]", "") %>% str_trim() %>% as.numeric()
BM021$postalcode <- BM021$postalcode %>% str_sub(1,4) %>% as.numeric()
BM021 <- BM021 %>% select(year, quarter, sales.type, category, postalcode, postalarea, value)
BM021 <- BM021 %>% arrange(postalcode)

###

BM030$kvartal <- BM030$date %>% str_replace_all("\\d{4}", "")
BM030$date <- BM030$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM030) <- c("category","area","area.type","year","days","quarter")
BM030 <- BM030 %>% select(year, quarter, category, area, area.type, days)

###

BM031$kvartal <- BM031$date %>% str_replace_all("\\d{4}", "")
BM031$date <- BM031$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM031) <- c("category","postalcode","year","days","quarter")
BM031$postalarea <- BM031$postalcode %>% str_replace_all("\\d{4}", "") %>% str_trim()
BM031$postalarea <- BM031$postalarea %>% str_replace_all("[-]", "") %>% str_trim()
BM031$postalcode <- BM031$postalcode %>% str_replace_all("[^(\\d{4}]", "") %>% str_trim() %>% as.numeric()
BM031$postalcode <- BM031$postalcode %>% str_sub(1,4) %>% as.numeric()
BM031 <- BM031 %>% select(year, quarter, category, postalcode, postalarea, days)
BM031 <- BM031 %>% arrange(postalcode)


devtools::use_data(BM010, BM011, BM020, BM021, BM030, BM031, overwrite = T)
