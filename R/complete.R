complete <- function(directory = ".", id = 1:332) {
  files <- list.files(full.names = TRUE, path = directory)
  data = do.call("rbind", lapply(files, read.csv))
  c = data[complete.cases(data), ]
  nobs = sapply(id, function(x) { nrow(c[which(c[,"ID"] == x),])})
  data.frame(id, nobs)
}