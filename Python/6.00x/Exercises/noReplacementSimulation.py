import random

def noReplacementSimulation(numTrials):
    '''
    Runs numTrials trials of a Monte Carlo simulation
    of drawing 3 balls out of a bucket containing
    3 red and 3 green balls. Balls are not replaced once
    drawn. Returns the a decimal - the fraction of times 3 
    balls of the same color were drawn.
    '''
    results = 0
    for trial in range(numTrials):
        bucket = [0,0,0,1,1,1]
        balls = []
        for ball in range(3):
            choice = random.choice(bucket)
            bucket.remove(choice)
            balls.append(choice)
        if balls[0] == balls[1] == balls[2]:
            results += 1
    return float(results)/numTrials
