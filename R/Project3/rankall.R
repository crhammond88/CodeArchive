rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data[, 11] <- as.numeric(data[, 11])
  data[, 17] <- as.numeric(data[, 17])
  data[, 23] <- as.numeric(data[, 23])
  if(outcome %in% c("heart attack", "heart failure", "pneumonia")) {} 
  else { stop("invalid outcome")}
  if(num == "best") { num <- 1}  
  ## For each state, find the hospital of the given rank
  state <- sort(unique(data$State))
  numStates <- length(state)
  hospital <- character(numStates)  
  switch(outcome, 
         "heart attack" = {colN <- 11},
         "heart failure" = {colN <- 17},
         "pneumonia" = {colN <- 23})    
  for(i in 1:numStates) {
    stateData <- data[which(data[,"State"] == state[i]),] 
    ranks <- stateData[order(stateData[,colN], stateData[,"Hospital.Name"],na.last = NA),]
    if(num == "worst") { selected <- tail(ranks, n = 1)[,"Hospital.Name"] }  
    else {  
      if(num <= length(ranks)) { selected <- ranks[num, "Hospital.Name"] }
      else { selected = NA }
    }
    hospital[i] <- selected
  }
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name  
  allRanks <- data.frame(hospital, state)
  allRanks
}