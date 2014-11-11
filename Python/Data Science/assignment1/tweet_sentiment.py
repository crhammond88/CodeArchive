import sys
import urllib
import json

afinnfile = open(sys.argv[1])
scores = {}
for line in afinnfile:
  term, score  = line.split("\t")  
  scores[term] = int(score)

data = []
tweet_file = open(sys.argv[2])
for line in tweet_file:
	data.append(json.loads(line))

for i in xrange(len(data)):
	if "text" in data[i]:
		text = data[i]["text"]
		sent = 0.00
		text = text.split()
		for word in text:
			word = word.lower()
			if word in scores.keys():
				sent += scores[word]
		print sent
			
		
	



