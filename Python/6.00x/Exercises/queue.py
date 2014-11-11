class Queue(object):
    
    def __init__(self):
        self.qlist = []
    def insert(self, new):
        self.qlist.append(new)
    def remove(self):
        try:
            return self.qlist.pop(0)
        except IndexError:
            raise ValueError("Queue is empty.")
    def __str__ (self):
        return str(self.qlist)




queue = Queue()
queue.insert(5)
queue.insert(4)
print queue
queue.remove()
print queue
queue.insert(7)
queue.remove()
print queue
queue.remove()

