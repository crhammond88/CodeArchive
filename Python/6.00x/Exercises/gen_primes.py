def genPrimes():
    primeList = []
    lastPrime = 1
    while True:
        lastPrime += 1
        sqrtPrime = lastPrime**(0.5)
        for p in primeList:
            if lastPrime % p == 0:
                break
            if p > sqrtPrime:
                primeList.append(lastPrime)
                yield lastPrime
                break
        else:
            primeList.append(lastPrime)
            yield lastPrime
