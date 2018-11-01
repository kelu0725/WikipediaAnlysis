#!/usr/bin/env python3
import urllib.parse
import re
import gzip
import sys
import os

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
    line = line.strip()
    array = line.split()

    if (len(array)!=4):
        return None

    domain = array[0]
    title = array[1]
    views = array[2]
    data = array[3]

    if(domain!='en' and domain!='en.m'):
        return None

    title=decode(title)

    badPrefix=['media:', 'special:', 'talk:', 'user:', 'user_talk:', 'wikipedia:', 'wikipedia_talk:', 'file:',
               'file_talk:', 'mediawiki:', 'mediawiki_talk:', 'template:', 'template_talk:', 'help:', 'help_talk:',
               'category:', 'category_talk:', 'portal:', 'portal_talk:', 'book:', 'book_talk:', 'draft:', 'draft_talk:',
               'education_program:', 'education_program_talk:', 'timedtext:', 'timedtext_talk:', 'module:',
               'module_talk:', 'gadget:', 'gadget_talk:', 'gadget_definition:', 'gadget_definition_talk:']
    if any(title.lower().startswith(word) for word in badPrefix):
        return None

    match=re.search(r'^[a-z]',title)
    if match!=None:
        return None

    badSufix=['.png','.gif','.jpg','.jpeg','.tiff','.tif','.xcf','.mid','.ogg','.ogv','.svg','.djvu','.oga','.flac','.opus',
    '.wav','.webm','.ico','.txt','_(disambiguation)']
    if any(title.lower().endswith(word) for word in badSufix):
        return None

    badPage = re.compile(r'\A404.php$|\AMain_Page$|\A-$')
    match = badPage.match(title)
    if match != None:
        return None

    return [title,views]

# source_file= gzip.open('pageviews-20161110-000000.gz',mode='rt',encoding='utf-8')
source_file=os.environ["mapreduce_map_input_file"]#e.g.pageviews-20161109-000000.gz
filename = source_file.split(".")[0].split("-")
[date,hours]=[filename[-2],filename[-1]]#e.g 20161109 000000
for line in sys.stdin:
    line=line.strip()
    temp=Filter(line) # return a list:[title, views]
    if temp!=None:
        info = str(date)+"-"+str(hours)+"-"+temp[1]
        print ('%s\t%s' %(temp[0],info)) #title 20161110-000000-9
