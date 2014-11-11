import sys
import urllib
import json

tweet_file = open(sys.argv[1])
data = []
for line in tweet_file:
	data.append(json.loads(line))

allterms = 0
terms = {}
for i in xrange(len(data)):
	if "text" in data[i]:
		text = data[i]["text"]
		text = text.split()
		for word in text:
			allterms += 1
			try:
				terms[word] += 1
			except KeyError:
				terms[word] = 1

for word in terms.keys():
	print terms[word], allterms
	print word, float(terms[word])/allterms
