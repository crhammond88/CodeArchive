def numPens(n):
#returns True if n is equal to a combination of 5, 8, and 24
    #if n is 0
    if n == 0:
        #return false
        return False
    #check to see if n is divisible by a combination of 5 and 8
    for guess in range((n / 5) + 1):
        if ((n - 5 * guess) == 0) or (((n - 5 * guess) % 8) == 0):
            #return true
            return True
    #else, return false
    return False

