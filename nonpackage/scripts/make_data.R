loc <- readr::locale(decimal_mark = ",", encoding = "Latin1")
areas <- c("BM010", "BM011", "BM020", "BM021", "BM030", "BM031")

for(pattern in areas){

  files <- list.files("inst/extdata/", full.names = T, pattern = pattern)

  all_stats <- data.frame()

  for(file in files) {

    stats <- readr::read_tsv(file, locale = loc)

    all_stats <- rbind(all_stats, stats)
  }

  all_stats <- all_stats[,-which(is.na(names(all_stats)))]

  all_stats[,stringr::str_detect(names(all_stats),"^(\\d+)")] <- sapply(all_stats[,stringr::str_detect(names(all_stats),"^(\\d+)")], function(x) as.numeric(x))

  assign(pattern, all_stats)
}
