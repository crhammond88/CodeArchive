#Created By: Chris Hammond
#Modified from requested exercise for file writing

PRIME_FILE = "primelist.txt"


def loadPrimes():
    #loads prime numbers into primeList
    #open file
    primeFile = open(PRIME_FILE, 'r', 0)
    #create empty list
    primeList = []
    print("Loading Primes...")
    #fill list with file contents
    for line in primeFile:
        primeList.append(int(line.strip("\n")))
    #close file
    primeFile.close()
    print("   " + str(len(primeList)) + " primes loaded.")
    return primeList



def isPrime(n, primeList):
#returns true if n is prime
    #set number of starting primes to check
    sPrime = 40
    #if n is in the first 25 primes, return True
    if n in primeList[:sPrime]: return True 
    #check the first 25 primes
    for prime in range(sPrime):
        #if n is divisible by prime, return false
        if (n % int(primeList[prime]) == 0): return False
    #create last prime variable
    lastPrime = primeList[len(primeList) - 1]
    #create square root of n variable
    sqrtn = int(n**(0.5))
    #while last element in primeList is smaller than sqrtn
    guess = lastPrime
    while lastPrime <= sqrtn:
        #check for new primes, starting after the last prime in primeList
        guess += 1
        #if number isPrime
        if isPrime(guess, primeList):
            #add prime to lists
            #print("Adding Prime...")
            #append to primeList
            primeList.append(guess)
            #open the file
            primeFile = open(PRIME_FILE, 'a', 0)
            #write to file at the end
            primeFile.write(str(guess)+'\n')
            #close the file
            primeFile.close()
            #set lastPrime equal to newest prime
            lastPrime = guess
    #while the prime being checked is greater than sqrtn
    prime = sPrime
    while primeList[prime] <= sqrtn:
            #if n is divisible by prime, return false
            if (n % int(primeList[prime]) == 0): return False
            prime += 1
    #n is not divisible by any primes, return true
    return True

