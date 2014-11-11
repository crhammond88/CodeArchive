pollutantmean <- function(directory = ".", pollutant, id = 1:332) {
  files <- list.files(full.names = TRUE, path = directory)
  data = do.call("rbind", lapply(files, read.csv))
  p <- data[which(data[,"ID"] %in% id),pollutant]
  mean(p, na.rm = TRUE)
}