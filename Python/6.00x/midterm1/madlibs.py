def generateForm(story, listOfAdjs, listOfNouns, listOfVerbs):
#returns the story with Adjs, Nouns, and Verbs from the lists omitted
    #split story into list of words
    words = story.split(' ')
    #create dict matching lists to replacements
    lists = {'[ADJ]': listOfAdjs, '[NOUN]': listOfNouns, '[VERB]': listOfVerbs}
    #create new string
    madStory = ''
    #for word in words
    for word in words:
        #check in each list for word
        #establish notInList condition
        notInList = True
        for check in lists:
            #if word, minus extra characters, is in list dict
            if word.strip(" !@#$%^&*()-_+={}[]|\\:;'<>?,./\"") in lists[check]:
                #set notInList to False
                notInList = False
                #create variable to save nonalphanumeric characters
                extras = ''
                #for letter in word
                for letter in word:
                    #if not alphanumeric
                    if not letter.isalnum():
                        #add letter to extras
                        extras += letter
                #change word to replacement, the key in dict, plus the extra characters
                word = check + extras
                #add word to new string plus a space
                madStory += word + ' '
                break
        #if not in lists
        if notInList:
            #add word to new string plus a space
            madStory += word + ' '       
    #return new string
    return madStory


def generateTemplates(madLibsForm):
#returns a list of word replacements in the order they appear in madLibsForm
    #split madLibsForm into words
    madLibsForm = madLibsForm.split(' ')
    #creat list of replacement words
    rwords = ['[ADJ]', '[NOUN]', '[VERB]']
    #create answer list variable
    answer = []
    #for each word in madLibsForm
    for word in madLibsForm:
        #strip extra characters other than []
        word = word.strip(" !@#$%^&*()-_+={}|\\:;'<>?,./\"")
        #if it's a replacement word
        if word in rwords:
            #add word to answer
            answer.append(word)
    #return answer
    return answer

def verifyWord(userWord, madTemplate, listOfAdjs, listOfNouns, listOfVerbs):
#returns True if userWord is a valid word in the list that matchs madTemplate
    #create dict matching madTemplates(keys) to lists(values)
    lists = {'[ADJ]': listOfAdjs, '[NOUN]': listOfNouns, '[VERB]': listOfVerbs}
    #if userWord in appropriate list
    if userWord in lists[madTemplate]:
        #return True
        return True
    #return False
    return False
