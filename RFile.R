suppressMessages(library(tidyverse))
suppressMessages(library(RPostgreSQL))
setwd("E:/maynooth university/SEM 1/NCG Project")
d <- read.csv('SAPS2016_CTY31.csv')
attach(d)
BroadBandCount <- as.numeric(gsub(",", "", d$T15_3_B))
TotalCount <- as.numeric(gsub(",", "", d$T15_3_T))
d_needed <- data.frame(GUID, GEOGID, GEOGDESC, BroadBandCount, TotalCount)
names(d_needed) <- c('guid','geogid','geogdesc','broadbandcount','totalcount')

BroadbandData_db <- dbConnect(PostgreSQL(), user= "postgres", password="postgres", dbname="postgres")

dbExecute(BroadbandData_db, "CREATE TABLE BroadbandData (
                         GUID TEXT NOT NULL,
                         GEOGID TEXT NOT NULL,
                         GEOGDESC TEXT NOT NULL,
                         BroadBandCount NUMERIC NOT NULL,
                         TotalCount NUMERIC NOT NULL,
                         PRIMARY KEY (GUID)
);")

dbWriteTable(BroadbandData_db, "broadbanddata",d_needed,  row.names=FALSE, append=TRUE)
dbGetQuery(BroadbandData_db, "SELECT * FROM BroadbandData")
dbExecute(BroadbandData_db, "ALTER TABLE BroadbandData ADD COLUMN BroadbandCountPercentage REAL;")
dbGetQuery(BroadbandData_db, "UPDATE BroadbandData SET BroadbandCountPercentage = BroadBandCount / TotalCount * 100")



e <- read.csv('SAPS2016_ED3409.csv')
attach(e)
BroadBandCountED <- as.numeric(gsub(",", "", e$T15_3_B))
TotalCountED <- as.numeric(gsub(",", "", e$T15_3_T))
e_needed <- data.frame(GUID, GEOGID, GEOGDESC, BroadBandCountED, TotalCountED)
names(e_needed) <- c('guid','geogid','geogdesc','broadbandcounted','totalcounted')

BroadbandDataED_db <- dbConnect(PostgreSQL(), user= "postgres", password="postgres", dbname="postgres")

dbExecute(BroadbandData_db, "CREATE TABLE BroadbandDataED (
          GUID TEXT NOT NULL,
          GEOGID TEXT NOT NULL,
          GEOGDESC TEXT NOT NULL,
          BroadBandCountED NUMERIC NOT NULL,
          TotalCountED NUMERIC NOT NULL,
          PRIMARY KEY (GUID)
);")

dbWriteTable(BroadbandDataED_db, "broadbanddataed",e_needed,  row.names=FALSE, append=TRUE)
dbGetQuery(BroadbandDataED_db, "SELECT * FROM BroadbandDataED")
dbExecute(BroadbandDataED_db, "ALTER TABLE BroadbandDataED ADD COLUMN BroadbandCountPercentageED REAL;")
dbGetQuery(BroadbandDataED_db, "UPDATE BroadbandDataED SET BroadbandCountPercentageED = BroadBandCountED / TotalCountED * 100")

