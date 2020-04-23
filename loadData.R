
  #--- download data set from web
  zFileDir <-"./zfile"
  zFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  zFileName <- "file.zip"
  zFilePath <- paste0(zFileDir,"/",zFileName)
  dataDir <- "./data"
  
  # skip download if it already exists
  if (!file.exists(zFileDir)) {
    message("downloading zip file...")
    dir.create(zFileDir)
    download.file(url = zFileUrl, destfile = zFilePath)
  }
  
  # skip unzip if data is already exist
  if (!file.exists(dataDir)) {
    message("uncompressing zip file...")
    dir.create(dataDir)
    unzip(zipfile = zFilePath, exdir = dataDir)
    message("done..")
  }
  
  # --- read file
  # skip reading if the data frame object already exists.
  if (!exists("NEI")){
    message("loading NEI file...")
    filePath1 <- paste0(dataDir,"/summarySCC_PM25.rds")
    NEI <- readRDS(filePath1)
    message("done.")
  }
  if (!exists("SCC")){
    message("loading SCC file...")
    filePath2 <- paste0(dataDir,"/Source_Classification_Code.rds")
    SCC <- readRDS(filePath2)
    message("done.")
  }