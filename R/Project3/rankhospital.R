rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data[, 11] <- as.numeric(data[, 11])
  data[, 17] <- as.numeric(data[, 17])
  data[, 23] <- as.numeric(data[, 23])
  ## Check that state and outcome are valid
  if(state %in% unique(data$State)) {} 
  else { stop("invalid state")}
  if(outcome %in% c("heart attack", "heart failure", "pneumonia")) {} 
  else { stop("invalid outcome")}
  if(num == "best") { num <- 1}  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  switch(outcome, 
         "heart attack" = {colN <- 11},
         "heart failure" = {colN <- 17},
         "pneumonia" = {colN <- 23})
  stateData <- data[which(data[,"State"] == state),] 
  ranks <- stateData[order(stateData[,colN], stateData[,"Hospital.Name"],na.last = NA),]
  if(num == "worst") { hospital <- tail(ranks, n = 1)[,"Hospital.Name"] }  
  else {  
    if(num <= length(ranks)) { hospital <- ranks[num, "Hospital.Name"] }
    else { hospital = NA }
  }
  hospital
}