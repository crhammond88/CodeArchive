class hashSet (object):
    
    def __init__(self, numBuckets):
        #initalize hashset equal to size of numBuckets
        if (numBuckets < 1) or (type(numBuckets) != int):
            raise ValueError('hashSet size must be a number greater than 0.')
        self.numBuckets = numBuckets
        self.hashset = []
        for i in range(numBuckets):
            self.hashset.append([])
            
    def __str__(self):
        #show each bucket
        return '{' + ','.join([str(e) for e in self.hashset]) + '}'
        
    def hashValue(self, e):
        #returns a hash value for e
        if type(e) != int:
            raise ValueError("Requires an integer.")
        return e % self.numBuckets
        
    def member(self, e):
        #returns true if e is in self
        if e in self.hashset[self.hashValue(e)]:
            return True
        return False
        
    def insert(self, e):
        if type(e) != int:
            raise ValueError("Requires an integer.")
        if self.member(e):
            return
        self.hashset[self.hashValue(e)].append(e)
        
    def remove(self, e):
        if type(e) != int:
            raise ValueError("Must be an integer in current hashSet.")
        self.hashset[self.hashValue(e)].remove(e)

    def getNumBuckets(self):
        return self.numBuckets
    
    
    