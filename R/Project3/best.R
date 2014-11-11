best <- function(state, outcome) {
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
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  switch(outcome, 
         "heart attack" = {colN <- 11},
          "heart failure" = {colN <- 17},
          "pneumonia" = {colN <- 23})
  rates <- data[which(data[,"State"] == state), colN]
  minRate <- min(rates, na.rm = TRUE)
  hospitals <- data[which(data[,colN] == minRate & data[,"State"] == state), "Hospital.Name"]
  n <- sort(hospitals)
  n[1]
  
}