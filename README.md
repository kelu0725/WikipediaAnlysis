# WikipediaAnlysis

Project 1.1
Data Pre-processing
1. Handle dirty data: Removing malformed data is always the very first step in data pre-processing. Some lines don't have the four columns as expected. You should filter out these lines.
In data processing, you need to make sure that your code must not crash when given malformed data.

2. URL normalization and percent-encoding: According to RFC 3986, URLs should be normalized and special characters will be converted by percent-encoding.

3. Desktop/mobile Wikipedia sites: We will focus on English Desktop/Mobile Wikipedia pages, keep the rows only if the first column is exactly en or en.m (case sensitive) and exclude all others.

4. Wikipedia namespaces: There are many special pages in Wikipedia that are not actually Wikipedia articles. Remove these pages. A Wikipedia namespace is a set of Wikipedia pages whose names begin with a particular reserved word recognized by the MediaWiki software (followed by a colon).

5. Wikipedia article title limitation: Wikipedia policy states that if any article starts with an English letter, the letter must be capitalized.

6. Miscellaneous filename extensions: Despite having already filtered pages in File: or Media: namespace, you may still get files instead of articles.

7. Wikipedia Disambiguation

8. Special pages

Project1.2

1. Filter out elements based on the rules discussed in Project 1.1. Get the input filename from within a Mapper
2. Sort the output in descending numerical order of the number of monthly accesses
3. Break ties by ascending lexicographical order (based on the Unicode value of each character in the strings) of page titles.
4. Edit the script runner.sh to include the commands/code used to answer the checkpoint questions. Do not move any of the provided files. If you are using any external scripts, ensure that you are calling the correct scripts from runner.sh. 
