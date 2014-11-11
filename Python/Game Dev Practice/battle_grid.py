#create battle grid
def createBattleGrid(size):
#returns an empty square grid
    assert type(size) == int
    battle_grid = []
    for column in range(size):
        battle_grid.append([])
        for row in range(size):
            battle_grid[column].append([''])
    return battle_grid

class Character(object):
    def __init__(self, name):
        self.name = name
    def getName(self):
        return self.name


battle_grid = createBattleGrid(4)
Arvisk = Character('Arvisk')

battle_grid[1][1] = Arvisk

print battle_grid
print battle_grid[1][1].getName()
