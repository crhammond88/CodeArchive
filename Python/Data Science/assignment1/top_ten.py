import sys
import urllib
import json


tweet_file = open(sys.argv[1])
data = []
for line in tweet_file:
	data.append(json.loads(line))

hashTags = {}
for i in xrange(len(data)):
	tweet = data[i]
	if "entities" in tweet:
		tweetEnt = tweet["entities"]
		if tweetEnt is None:
			continue
		if "hashtags" in tweetEnt:
			tweetTags = tweetEnt["hashtags"]
			for hashTag in tweetTags:
				hashText = hashTag["text"]
				try:
					hashTags[hashText] += 1
				except KeyError:
					hashTags[hashText] = 1

topTen = {}
for i in range(10):
	topTen[('tag' + str(i))] = 0

for hashTag in hashTags.keys():
	for tag in topTen.keys():
		if hashTags[hashTag] > topTen[tag]:
			del topTen[tag]
			topTen[hashTag] = hashTags[hashTag]
			break

for hashTag in topTen.keys():
	print hashTag, topTen[hashTag]

				
