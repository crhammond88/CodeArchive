from ps7 import *


print runSimulation(1, 1.0, 5, 5, 1.00, 100, StandardRobot), 'est 150'

print runSimulation(1, .5, 5, 5, 1.00, 100, StandardRobot), '^half speed'

print runSimulation(1, 1.0, 10, 10, 0.75, 100, StandardRobot), 'est 190'

print runSimulation(1, 1.0, 20, 20, 1.0, 10, StandardRobot), 'est 3322'

print runSimulation(3, 1.0, 20, 20, 1.0, 20, StandardRobot), 'est 1105'





