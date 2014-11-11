#Created By: Chris Hammond
PRIME_FILE = "primelist.txt"

def isPrime(n):
#silly, overcomplicated way of finding primes, including an option to write the list to a file
#returns true if n is prime
    #raise value error if n is not a positive number
    if n < 1:
        raise ValueError
    #raise type error if n is a float
    if type(n) is float:
        raise TypeError
    #if n is 1 - 3 or 5, return True
    if (n in range(1,4)) or (n == 5): return True 
    #if n is divisible by 2,3, or 5: return False
    if (n % 2 == 0) or (n % 3 == 0) or (n % 5 == 0): return False

    def bestMatch(primeList, sqrtn):
    #returns primeList shortened so that the highest number is the best match to sqrtn
        guess = 0
        while True:
            if primeList[guess] >= sqrtn:
                return primeList[:guess + 1]
            guess += 1    

##    ##file version
##    #open file
##    primeFile = open(PRIME_FILE, 'r', 0)
##    #create empty list
##    primeList = []
##    #fill list with file contents
##    for line in primeFile:
##        primeList.append(int(line.strip("\n")))
##    #close file
##    primeFile.close()
    ##list version:
    #create list
    primeList = [2,3,5,7,11,13,17,19,23,29]
    #if n is in primeList, return true
    if n in primeList: return True
    #create last prime variable
    lastPrime = primeList[len(primeList) - 1]
    #create square root of n variable
    sqrtn = n**(0.5)
    
    #while last element in primeList is smaller than sqrtn
    while lastPrime < sqrtn:
        #check for new primes, starting after the last prime in primeList
        lastPrime += 1
        #if number isPrime
        if isPrime(lastPrime):
            #add prime to list(s)
            #append to primeList
            primeList.append(lastPrime)
##            ##file version only
##            #open the file
##            primeFile = open(PRIME_FILE, 'a', 0)
##            #write to file at the end
##            primeFile.write(str(lastPrime)+'\n')
##            #close the file
##            primeFile.close()

    #use linear search on primeList shorten to sqrtn
    searchPrimes = bestMatch(primeList, sqrtn)
    #for each prime in list up to the sqrtn
    for prime in range(len(searchPrimes)):
        #if n is divisible by prime, return false
        if (n % int(searchPrimes[prime]) == 0): return False
    #else n is not divisible by any primes, return true
    return True

