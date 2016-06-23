areas <- c("BM010", "BM011", "BM020", "BM021", "BM030", "BM031")

for(pattern in areas){

  files <- list.files("nonpackage/newest", full.names = T, pattern = pattern)

  all_stats <- data.frame()

  for(file in files) {

    stats <- readr::read_tsv(file)

    all_stats <- rbind(all_stats, stats)
  }

  all_stats <- all_stats[,-which(is.na(names(all_stats)))]

  all_stats[,stringr::str_detect(names(all_stats),"^(\\d+)")] <- sapply(all_stats[,stringr::str_detect(names(all_stats),"^(\\d+)")], function(x) as.numeric(x))

  all_stats <- as.data.frame(all_stats)

  pattern2 <- str_c(pattern,"_new")

  assign(pattern2, all_stats)
}

rm(list=setdiff(ls(), objects(pattern = "new")))





###

fiftysix::workhorse()

BM010_new$område_type <-
  ifelse(str_detect(BM010_new$område, "Region"), "region",
         ifelse(str_detect(BM010_new$område, "Hele landet"), "danmark",
                ifelse(str_detect(BM010_new$område, "Landsdel"), "landsdel", "kommune")))

BM010_new <- BM010_new %>% gather(date, value, -c(`priser på realiserede handler`, ejendomskategori, område, område_type))

########

{BM011_new$postnumre %>% unique() %>% length()} == 592

BM011_new <- BM011_new %>% gather(date, value, -c(`priser på realiserede handler`, ejendomskategori, postnumre))

########

{BM020_new$område %>% unique() %>% length()} == 115

BM020_new$område_type <-
  ifelse(str_detect(BM020_new$område, "Region"), "region",
         ifelse(str_detect(BM020_new$område, "Hele landet"), "danmark",
                ifelse(str_detect(BM020_new$område, "Landsdel"), "landsdel", "kommune")))

BM020_new <- BM020_new %>% gather(date, value, -c(bevægelsestype, ejendomskategori, område, område_type))

########

{BM021_new$postnumre %>% unique() %>% length()} == 592

BM021_new <- BM021_new %>% gather(date, value, -c(bevægelsestype, ejendomskategori, postnumre))

########

{BM030_new$område %>% unique() %>% length()} == 115

BM030_new$område_type <-
  ifelse(str_detect(BM030_new$område, "Region"), "region",
         ifelse(str_detect(BM030_new$område, "Hele landet"), "danmark",
                ifelse(str_detect(BM030_new$område, "Landsdel"), "landsdel", "kommune")))

BM030_new <- BM030_new %>% gather(date, value, -c(ejendomskategori, område, område_type))

########

{BM031_new $postnumre %>% unique() %>% length()} == 592

BM031_new  <- BM031_new  %>% gather(date, value, -c(ejendomskategori, postnumre))

################################################################################
################################################################################
################################################################################


BM010_new$kvartal <- BM010_new$date %>% str_replace_all("\\d{4}", "")
BM010_new$date <- BM010_new$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM010_new) <- c("price.type" ,"category","area","area.type","year","value","quarter")
BM010_new <- BM010_new %>% select(year, quarter, price.type, category, area, area.type, value)

###

BM011_new$kvartal <- BM011_new$date %>% str_replace_all("\\d{4}", "")
BM011_new$date <- BM011_new$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM011_new) <- c("price.type" ,"category","postalcode","year","value","quarter")
BM011_new$postalarea <- BM011_new$postalcode %>% str_replace_all("\\d{4}", "") %>% str_trim()
BM011_new$postalarea <- BM011_new$postalarea %>% str_replace_all("[-]", "") %>% str_trim()
BM011_new$postalcode <- BM011_new$postalcode %>% str_replace_all("[^(\\d{4}]", "") %>% str_trim() %>% as.numeric()
BM011_new$postalcode <- BM011_new$postalcode %>% str_sub(1,4) %>% as.numeric()
BM011_new <- BM011_new %>% select(year, quarter, price.type, category, postalcode, postalarea, value)
BM011_new <- BM011_new %>% arrange(postalcode)

###

BM020_new$kvartal <- BM020_new$date %>% str_replace_all("\\d{4}", "")
BM020_new$date <- BM020_new$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM020_new) <- c("sales.type" ,"category","area","area.type","year","count","quarter")
BM020_new <- BM020_new %>% select(year, quarter, sales.type, category, area, area.type, count)

###

BM021_new$kvartal <- BM021_new$date %>% str_replace_all("\\d{4}", "")
BM021_new$date <- BM021_new$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM021_new) <- c("sales.type" ,"category","postalcode","year","value","quarter")
BM021_new$postalarea <- BM021_new$postalcode %>% str_replace_all("\\d{4}", "") %>% str_trim()
BM021_new$postalarea <- BM021_new$postalarea %>% str_replace_all("[-]", "") %>% str_trim()
BM021_new$postalcode <- BM021_new$postalcode %>% str_replace_all("[^(\\d{4}]", "") %>% str_trim() %>% as.numeric()
BM021_new$postalcode <- BM021_new$postalcode %>% str_sub(1,4) %>% as.numeric()
BM021_new <- BM021_new %>% select(year, quarter, sales.type, category, postalcode, postalarea, value)
BM021_new <- BM021_new %>% arrange(postalcode)

###

BM030_new$kvartal <- BM030_new$date %>% str_replace_all("\\d{4}", "")
BM030_new$date <- BM030_new$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM030_new) <- c("category","area","area.type","year","days","quarter")
BM030_new <- BM030_new %>% select(year, quarter, category, area, area.type, days)

###

BM031_new$kvartal <- BM031_new$date %>% str_replace_all("\\d{4}", "")
BM031_new$date <- BM031_new$date %>% str_replace_all("K(\\d{1})", "") %>% as.numeric()
names(BM031_new) <- c("category","postalcode","year","days","quarter")
BM031_new$postalarea <- BM031_new$postalcode %>% str_replace_all("\\d{4}", "") %>% str_trim()
BM031_new$postalarea <- BM031_new$postalarea %>% str_replace_all("[-]", "") %>% str_trim()
BM031_new$postalcode <- BM031_new$postalcode %>% str_replace_all("[^(\\d{4}]", "") %>% str_trim() %>% as.numeric()
BM031_new$postalcode <- BM031_new$postalcode %>% str_sub(1,4) %>% as.numeric()
BM031_new <- BM031_new %>% select(year, quarter, category, postalcode, postalarea, days)
BM031_new <- BM031_new %>% arrange(postalcode)

################################################################################
################################################################################
################################################################################

for(x in list.files("data", full.names = T)) load(x)

BM010 <- rbind(BM010, BM010_new)
BM011 <- rbind(BM011, BM011_new)
BM020 <- rbind(BM020, BM020_new)
BM021 <- rbind(BM021, BM021_new)
BM030 <- rbind(BM030, BM030_new)
BM031 <- rbind(BM031, BM031_new)


devtools::use_data(BM010, BM011, BM020, BM021, BM030, BM031, overwrite = T)

