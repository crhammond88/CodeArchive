corr <- function(directory, threshold = 0) {
  files <- list.files(full.names = TRUE, path = directory)
  data = do.call("rbind", lapply(files, read.csv))
  c = data[complete.cases(data), ]
  id = 1:length(files)
  nobs = sapply(id, function(x) { nrow(c[which(c[,"ID"] == x),])})  
  nobsFrame = data.frame(id, nobs)
  t <- nobsFrame[which(nobsFrame[,"nobs"] > threshold,),]
  tid <- t$id

  s <- lapply(t$id, function(x) { c[which(c[,"ID"] == x),"sulfate"]})
  n <- lapply(t$id, function(x) { c[which(c[,"ID"] == x),"nitrate"]})
  numT <- length(t$id)
  if(numT > 0)
    sapply(1:numT, function(x) { cor(unlist(s[x]),unlist(n[x]))})
  else 
    blank <- numeric(0)
}