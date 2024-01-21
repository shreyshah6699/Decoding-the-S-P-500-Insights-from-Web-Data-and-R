rm(list = ls())

library(tidyverse)

library(rvest)
url <- "https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"


Snp500page <- read_html(url)

Symbol <- Snp500page %>% html_nodes("#constituents td:nth-child(1)") %>%
  html_text()
Security <- Snp500page %>% html_nodes("#constituents td:nth-child(2)") %>%
  html_text()

GICS_Sector <- Snp500page %>% html_nodes("#constituents td:nth-child(3)") %>%
  html_text()
GICS_Sub_Indusry <- Snp500page %>% html_nodes("#constituents td:nth-child(4)") %>% html_text()
Headquarters_Location <- Snp500page %>% html_nodes("#constituents td:nth-child(5)") %>% html_text()
Date_first_added <- Snp500page %>% html_nodes("td:nth-child(6)") %>%html_text()
Date_first_added <- Date_first_added[1:503]
CIK <- Snp500page %>% html_nodes("td:nth-child(7)") %>% html_text()
Founded <- Snp500page %>% html_nodes("td:nth-child(8)") %>% html_text()

Sp500 <- data.frame(Symbol,Security, GICS_Sector,
                    GICS_Sub_Indusry, Date_first_added,
                    Headquarters_Location, CIK,
                    stringsAsFactors = F)



write.csv(Sp500 , "Sp500.csv")

head(Sp500)
summary(Sp500)
tail(Sp500)

library(ggplot2)
Sp500$GICS_Sector <- as.factor(Sp500$GICS_Sector)
ggplot(Sp500,aes(y=GICS_Sector))+geom_bar()

ggplot(Sp500,aes(y=GICS_Sector))+geom_density()

ggplot(Sp500,aes(x=Founded, y=GICS_Sector))+geom_point()

