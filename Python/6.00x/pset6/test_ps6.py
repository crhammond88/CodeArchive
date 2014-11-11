from ps6 import *

w = WordTrigger('Title')
print w.isWordIn('Title'), '  <--Should be True'



news = NewsStory('Guid', 'Title!!', 'Subject', 'Summary', 'Link')
news2 = NewsStory('Guid', 'foo', 'Subject', 'Summary', 'Link')

check = TitleTrigger('!!!!Title?.!')


print check.evaluate(news), '  <--Should be True'
print check.evaluate(news2), ' <--Should be False'

pillow = NewsStory('', 'I prefer pillows that are soft.', '', '', '')
check0 = TitleTrigger('soft')



print check0.evaluate(pillow),'  <--Should be True\n\n\n'



notT = NotTrigger(check)

print notT.evaluate(pillow), '  <--Should be True'
print notT.evaluate(news), ' <--Should be False'

andT = AndTrigger(check, check0)
news3 = NewsStory('', 'Soft and Title', '', '', '')

print andT.evaluate(news3), '  <--Should be True'
print andT.evaluate(news), ' <--Should be False'
