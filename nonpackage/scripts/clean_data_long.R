fiftysix::workhorse()

BM010$område %>% unique()

BM010$område

BM010$område[str_detect(BM010$område, "Region")] %>% unique()

BM010$område_type <-
ifelse(str_detect(BM010$område, "Region"), "region",
       ifelse(str_detect(BM010$område, "Hele landet"), "danmark",
              ifelse(str_detect(BM010$område, "Landsdel"), "landsdel", "kommune")))


BM010_kom <- BM010 %>% filter(område_type == "kommune")

BM010_kom$område %>% unique() %>% length()

names(BM010)

BM010$`priser på realiserede handler`

BM010 <- BM010 %>% gather(date, value, -c(`priser på realiserede handler`, ejendomskategori, område, område_type))

########

{BM011$postnumre %>% unique() %>% length()} == 592

BM011 <- BM011 %>% gather(date, value, -c(`priser på realiserede handler`, ejendomskategori, postnumre))

########

{BM020$område %>% unique() %>% length()} == 115

BM020$område_type <-
  ifelse(str_detect(BM020$område, "Region"), "region",
         ifelse(str_detect(BM020$område, "Hele landet"), "danmark",
                ifelse(str_detect(BM020$område, "Landsdel"), "landsdel", "kommune")))

BM020 <- BM020 %>% gather(date, value, -c(bevægelsestype, ejendomskategori, område, område_type))

########

{BM021$postnumre %>% unique() %>% length()} == 592

BM021 <- BM021 %>% gather(date, value, -c(bevægelsestype, ejendomskategori, postnumre))

########

{BM030$område %>% unique() %>% length()} == 115

BM030$område_type <-
  ifelse(str_detect(BM030$område, "Region"), "region",
         ifelse(str_detect(BM030$område, "Hele landet"), "danmark",
                ifelse(str_detect(BM030$område, "Landsdel"), "landsdel", "kommune")))

BM030 <- BM030 %>% gather(date, value, -c(ejendomskategori, område, område_type))

########

{BM031$postnumre %>% unique() %>% length()} == 592

BM031 <- BM031 %>% gather(date, value, -c(ejendomskategori, postnumre))

########

# devtools::use_data(BM010, BM011, BM020, BM021, BM030, BM031, overwrite = TRUE )
