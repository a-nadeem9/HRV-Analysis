# kubios2RHRV.r
#
# load RR into RHRV package
#
# version: 20.11.2022
#
# by Stefan Mendt
#

library(readr)
library(RHRV)

# read kubios output into R ####
dataset <- read_csv("~/Documents/Charité/ZWMB/Projects/Various/RHRV/17-57-43_hrv.csv", skip = 156)

# modify
dataset.mod <- dataset[, 1:2]
dataset.mod <- as.data.frame(dataset.mod)

# extracted dataset will be truncated
# part after the word "HR Zones" in column "Time"
dataset.mod <- dataset.mod[-c(1: (grep("SAMPLE 1", dataset.mod$Time)+3)), ] 

# get RR series from Time
RRs <- as.numeric(dataset.mod$Time); RRs <- RRs-RRs[1]


# load RRs into RHRV package ####
hrv <-  CreateHRVData()
hrv <-  SetVerbose(hrv, TRUE )
#LoadBeatVector(HRVData, beatPositions, scale = 1,
#               datetime = "1/1/1900 0:0:0")

RRs.data <- LoadBeatVector(hrv, RRs, scale = 1) 
hrv.data <-  BuildNIHR(RRs.data)

PlotNIHR(hrv.data, main = "example", ylim = c(60,200))
