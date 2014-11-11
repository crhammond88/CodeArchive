from ps7 import *

def runSimulation(num_robots, speed, width, height, min_coverage, num_trials,
                  robot_type):
    """
    Runs NUM_TRIALS trials of the simulation and returns the mean number of
    time-steps needed to clean the fraction MIN_COVERAGE of the room.

    The simulation is run with NUM_ROBOTS robots of type ROBOT_TYPE, each with
    speed SPEED, in a room of dimensions WIDTH x HEIGHT.

    num_robots: an int (num_robots > 0)
    speed: a float (speed > 0)
    width: an int (width > 0)
    height: an int (height > 0)
    min_coverage: a float (0 <= min_coverage <= 1.0)
    num_trials: an int (num_trials > 0)
    robot_type: class of robot to be instantiated (e.g. StandardRobot or
                RandomWalkRobot)
    """
    results = 0.00
    for __ in xrange(num_trials):
        anim = ps7_visualize.RobotVisualization(num_robots, width, height)
        room = RectangularRoom(width, height)
        robots = [robot_type(room, speed) for __ in xrange(num_robots)]
        results += len(robots)
        while float(room.getNumCleanedTiles())/room.getNumTiles() < min_coverage:
            results += 1
            anim.update(room, robots)
            for robot in robots:
                robot.updatePositionAndClean()
        anim.update(room, robots)
        anim.done()

    return results/num_trials
       
print runSimulation(3, 1.0, 20, 20, 1.0, 1, RandomWalkRobot)
