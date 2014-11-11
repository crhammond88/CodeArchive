import pylab
import numpy

highTemps = []
lowTemps = []


inFile = open('julyTemps.txt')
for line in inFile:
    fields = line.split(' ')
    if len(fields) != 3 or not fields[0].isdigit():
        continue
    highTemps.append(int(fields[1]))
    lowTemps.append(int(fields[2]))

def producePlot(lowTemps, highTemps):
    assert len(highTemps) == len(lowTemps)
    pylab.figure(1)
    pylab.plot(lowTemps, highTemps, 'ro')
    pylab.title('Rough Prediciton of Low to High Temperatures')
    pylab.xlabel('Low Daily Temperature')
    pylab.ylabel('High Daily Temperature')
    pylab.plot([60,64,68,76], [75, 80, 85, 95])
    pylab.show()

producePlot(lowTemps, highTemps)
