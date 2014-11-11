from ps7 import *

testRoom = RectangularRoom(4,7)
testPos0 = Position(2,3)
testPos1 = Position(2,4)
testPos2 = Position(-2,1)

print str(testRoom)

testRoom.cleanTileAtPosition(testPos0)

print str(testRoom)



print testRoom.isTileCleaned(2,3), 'should be True'
print testRoom.isTileCleaned(3,4), 'should be False'

testRoom.cleanTileAtPosition(testPos1)

print testRoom.getNumTiles(), 'should be 28'
print testRoom.getNumCleanedTiles(), 'should be 2'

for i in range(20):
    print testRoom.getRandomPosition(), '---',

print '\n'

print testRoom.isPositionInRoom(testPos0), 'should be True'
print testRoom.isPositionInRoom(testPos2), 'should be False'
