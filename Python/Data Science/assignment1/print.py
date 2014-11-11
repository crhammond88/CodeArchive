import urllib
import json

line = '--------------------------------------'
for i in xrange(1,11):
	print "PAGE " + str(i) +'\n' + line

	response = urllib.urlopen("http://search.twitter.com/search.json?q=sourcefed&page=" + str(i))

	pyresponse = json.load(response)

	results = pyresponse["results"]

	for i in xrange(len(results)):
		print results[i]["text"], '\n'

	print line + '\n\n\n'
