import urllib.parse
import re
import gzip
# filter every line in input_file
# if not applicable, return none; else return [title, views]
#  start of filter
def decode(encoded):
    def getHexValue(b):
        if '0' <= b <= '9':
            return chr(ord(b) - 0x30)
        elif 'A' <= b <= 'F':
            return chr(ord(b) - 0x37)
        elif 'a' <= b <= 'f':
             return chr(ord(b) - 0x57)
        return None

    if encoded is None:
        return None
    encodedChars = encoded
    encodedLength = len(encodedChars)
    decodedChars = ''
    encodedIdx = 0
    while encodedIdx < encodedLength:
        if encodedChars[encodedIdx] == '%' and encodedIdx + 2 < encodedLength and getHexValue(encodedChars[encodedIdx + 1]) and getHexValue(encodedChars[encodedIdx + 2]):
                #  current character is % char
            value1 = getHexValue(encodedChars[encodedIdx + 1])
            value2 = getHexValue(encodedChars[encodedIdx + 2])
            decodedChars += chr((ord(value1) << 4) + ord(value2))
            encodedIdx += 2
        else:
            decodedChars += encodedChars[encodedIdx]
        encodedIdx += 1
    return str(decodedChars)

def Filter(line):
#    count: used to count the total views
#     global countViews
    line = line.strip()
    array = line.split()
    # 1. drop na
    if (len(array)!=4):
        return None

    domain = array[0]
    title = array[1]
    views = array[2]
    data = array[3]
#     countViews+=int(views)

# 2. drop not 'en|en.m'
    if(domain!='en' and domain!='en.m'):
        return None

# # 3.1 encode
#     def encode(url):
#         if url is None:
#             return None
#         return urllib.parse.quote(url,safe='/')
#     title=encode(title)

# 3.2 decode
    title=decode(title)

# 4.filter out bad prefix
    badPrefix=['media:', 'special:', 'talk:', 'user:', 'user_talk:', 'wikipedia:', 'wikipedia_talk:', 'file:',
               'file_talk:', 'mediawiki:', 'mediawiki_talk:', 'template:', 'template_talk:', 'help:', 'help_talk:',
               'category:', 'category_talk:', 'portal:', 'portal_talk:', 'book:', 'book_talk:', 'draft:', 'draft_talk:',
               'education_program:', 'education_program_talk:', 'timedtext:', 'timedtext_talk:', 'module:',
               'module_talk:', 'gadget:', 'gadget_talk:', 'gadget_definition:', 'gadget_definition_talk:']
    if any(title.lower().startswith(word) for word in badPrefix):
        return None

# 5. filter out lowercase Eng
    match=re.search(r'^[a-z]',title)
    if match!=None:
        return None

# 6. filter out bad sufix
    badSufix=['.png','.gif','.jpg','.jpeg','.tiff','.tif','.xcf','.mid','.ogg','.ogv','.svg','.djvu','.oga','.flac','.opus',
    '.wav','.webm','.ico','.txt','_(disambiguation)']
    if any(title.lower().endswith(word) for word in badSufix):
        return None

# 7.filter out bad pages
    badPage = re.compile(r'\A404.php$|\AMain_page$|\A-$')
    match = badPage.match(title)
    if match != None:
        return None

# 8. return array with title and views [title]\t[views]
    return [title,int(views)]

# end of filter function
# deal with input
source = gzip.open('pageviews-20161109-000000.gz',mode='rt',encoding='utf-8')
# countViews=0
res=dict()
result=[]
for line in source:
    temp=Filter(line)
    if temp != None:
        if(res.get('temp[0]')!=None):
            res[temp[0]]+=temp[1]
        else:
            res[temp[0]]=temp[1]
# validLines=len(res)
# sort result:
# res=sorted(sorted(res,key=lambda x:x.keys()),key=lambda x: x.values(),reverse=True)
# for key, value in res.items():
#     temp = [key,value]
#     result.append(temp)
result=res.items()
result=sorted(sorted(result,key=lambda x:x[0]),key=lambda x: x[1],reverse=True)
# print result:
# output = gzip.open('output', mode='wt',encoding='utf-8',newline='\n')
output = open('output','w',encoding='utf-8',newline='\n')
for key in result:
    output.write(key[0]+"\t"+str(key[1])+"\n")
# print(countViews)
output.close()
# print(validLines)
