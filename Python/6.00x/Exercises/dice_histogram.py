import pylab
import random

def rollDie(size):
    answer = random.randint(1,size)
    assert size >= answer
    return answer

def simRolls(size, numTrials):
    rolls = []
    for trial in range(numTrials):
        rolls.append(rollDie(size))
    assert len(rolls) == numTrials
    return rolls

def checkChains(target, rolls, minChain):
    chains = []
    chain = 0
    for roll in rolls:
        if roll == target:
            chain += 1
        else:
            if chain > minChain - 1:
                chains.append(chain)
            chain = 0
    return chains

def plotChains(dieSize = 2, targetRoll = 1, numTrials = 100000,\
               numBins = 30, minChain = 2):
    if targetRoll > dieSize:
        raise ValueError
    chains = checkChains(targetRoll, simRolls(dieSize, numTrials), minChain)
    pylab.hist(chains, bins = numBins)
    title = 'Consecutive Rolls of ' + str(targetRoll) + ' while Rolling a Die ' + \
                str(dieSize)
    pylab.title(title)
    pylab.xlabel('Length of Chain (MAX CHAIN = ' + str(max(chains)) +')')
    pylab.ylabel('Number of Chains in ' + str(numTrials) + ' Trials')
    limit = max(chains)
    pylab.xlim(minChain, limit)
    pylab.xticks(xrange(minChain, max(chains) + 1))
    pylab.show()


plotChains(4)
