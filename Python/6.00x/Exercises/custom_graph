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
    axisRange = range(len(lowTemps))
    diffTemps = [highTemps[i] - lowTemps[i] for i in axisRange]
    pylab.figure(1)
    axisRange = range(len(lowTemps))
    pylab.plot(axisRange, diffTemps)
    pylab.title('Day by Day Ranges in Temperature in Boston in July 2012')
    pylab.xlabel('Days')
    pylab.ylabel('Temperature Ranges')
    pylab.show()

producePlot(lowTemps, highTemps)
