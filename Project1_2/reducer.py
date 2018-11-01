#!/usr/bin/env python3
import sys

current_article = None
total_views = 0
article = None
daily_views=[0]*30
# input: title 20161110-000000-9
for line in sys.stdin:
    line.strip()
    [article, info] = line.split("\t",1); #input: title 20161110-000000-9
    [date,hour,views]=info.split("-",2) # output: 20161110 000000 9
    date=date[-2:] # output: 10
    try:
        views=int(views)
        date=int(date)
    except ValueError:
        continue
    if current_article==article: #same article with last line
        daily_views[date-1]+=views
    else:
        if current_article:
            total_views=sum(i for i in daily_views)  # sum up daily views = total views for article
            if total_views>100000:
                print(str(total_views) + "\t"+current_article+ "\t"+"\t".join(str(i) for i in daily_views))
        current_article=article
        daily_views=[0]*30
        daily_views[date-1]=views

if current_article==article:
    total_views=sum(i for i in daily_views)
    if total_views>100000:
        print(str(total_views) + "\t"+current_article+ "\t"+"\t".join(str(i) for i in daily_views))
