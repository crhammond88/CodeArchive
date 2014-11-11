import sys
import urllib
import json


afinnfile = open(sys.argv[1])
scores = {}
for line in afinnfile:
  term, score  = line.split("\t")  
  scores[term] = int(score)


tweet_file = open(sys.argv[2])
data = []
for line in tweet_file:
	data.append(json.loads(line))

states = {
        'AK': 0,
        'AL': 0,
        'AR': 0,
        'AS': 0,
        'AZ': 0,
        'CA': 0,
        'CO': 0,
        'CT': 0,
        'DC': 0,
        'DE': 0,
        'FL': 0,
        'GA': 0,
        'GU': 0,
        'HI': 0,
        'IA': 0,
        'ID': 0,
        'IL': 0,
        'IN': 0,
        'KS': 0,
        'KY': 0,
        'LA': 0,
        'MA': 0,
        'MD': 0,
        'ME': 0,
        'MI': 0,
        'MN': 0,
        'MO': 0,
        'MS': 0,
        'MT': 0,
        'NC': 0,
        'ND': 0,
        'NE': 0,
        'NH': 0,
        'NJ': 0,
        'NM': 0,
        'NV': 0,
        'NY': 0,
        'OH': 0,
        'OK': 0,
        'OR': 0,
        'PA': 0,
        'RI': 0,
        'SC': 0,
        'SD': 0,
        'TN': 0,
        'TX': 0,
        'UT': 0,
        'VA': 0,
        'VI': 0,
        'VT': 0,
        'WA': 0,
        'WI': 0,
        'WV': 0,
        'WY': 0
}


for i in xrange(len(data)):
	tweet = data[i]
	if "place" in tweet:
		tweetPlace = tweet["place"]
		if tweetPlace is None:
			continue
		if "country" in tweetPlace:
			tweetCountry = tweetPlace["country"]
			if tweetCountry == "United States":
				if "full_name" in tweetPlace:
					tweetLoc = tweetPlace["full_name"]
					for state in states.keys():
						if state in tweetLoc:

							tweetText = tweet["text"]
							tweetText = tweetText.split()
							sentScore = 0.00
							for word in tweetText:
								word = word.lower()
								if word in scores.keys():
									sentScore += scores[word]
							states[state] += sentScore
							break
happyState = 'Failure'
happyScore = 0
for state in states.keys():
	score = states[state]
	if score > happyScore:
		happyState = state
		happyScore = score

print happyState
