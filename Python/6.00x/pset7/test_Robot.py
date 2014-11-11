from ps7 import *

room = RectangularRoom(3, 5)
speed = 3.5

robo = Robot(room, speed)

print room

print robo.getRobotPosition(), 'starting position'
print robo.getRobotDirection(), 'starting direction'

pos0 = Position(1,2)
pos1 = Position(2,3)
dir0 = 90.0
dir1 = 45.5

robo.setRobotPosition(pos0)
robo.setRobotDirection(dir0)

print robo.getRobotPosition(), 'should be 1,2'
print robo.getRobotDirection(), 'should be 90.0'

robo.setRobotPosition(pos1)
robo.setRobotDirection(dir1)

print robo.getRobotPosition(), 'should be 2,3'
print robo.getRobotDirection(), 'should be 45.5'





