from ps7 import *

room = RectangularRoom(3, 5)
speed = 3.5
pos0 = Position(1,2)
pos1 = Position(2,3)
dir0 = 90.0
dir1 = 45.5


robo = StandardRobot(room, speed)
robo.setRobotPosition(pos0)
robo.setRobotDirection(dir0)
print robo.getRobotPosition(), 'starting POS'
print robo.getRobotDirection(), 'starting DIR'

for i in range(10):
    robo.updatePositionAndClean()
    print robo.getRobotPosition(), 'current POS'
    print robo.getRobotDirection(), 'current DIR'
