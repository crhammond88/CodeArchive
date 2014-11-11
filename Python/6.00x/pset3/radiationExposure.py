def f(x):
    import math
    return 10*math.e**(math.log(0.5)/5.27 * x)





def radiationExposure(start, stop, step):
    if start >= stop:
        return 0
    else:
        return f(start) * step + radiationExposure(start + step, stop, step)
##    answer = 0
##    while start < stop:
##        answer += f(start) * step
##        start += step
##    return answer





print radiationExposure(0, 5, 1)
print radiationExposure(5, 11, 1)
print radiationExposure(0, 11, 1)
print radiationExposure(40, 100, 1.5)



