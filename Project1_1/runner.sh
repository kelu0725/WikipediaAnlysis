#!/bin/bash

################################################################################
##                 15-319/15-619 Cloud Computing Course                       ##
##                Runner Script for Project 1 Module 1                        ##
##                                                                            ##
##     Copyright 2017-2018, 15-319/15-619: Cloud Computing Course             ##
##                     Carnegie Mellon University                             ##
##   Unauthorized distribution of copyrighted material, including             ##
##  unauthorized peer-to-peer file sharing, may subject the students          ##
##  to the fullest extent of Carnegie Mellon University copyright policies.   ##
################################################################################

################################################################################
##                      README Before You Start                               ##
################################################################################
# Fill in the functions below for each question.
# You may use any programming language(s) in any question.
# You may use other files or scripts in these functions as long as they are in
# the submission folder.
# All files MUST include source code (e.g. do not just submit jar or pyc files).
#
# We will suggest tools or libraries in each question to enrich your learning.
# You are allowed to solve questions without the recommended tools or libraries.
#
# The colon `:` is a POSIX built-in basically equivalent to the `true` command,
# REPLACE it with your own command in each function.
# Before you fill your solution,
# DO NOT remove the colon or the function will break because the bash functions
# may not be empty!


################################################################################
##                          Setup & Cleanup                                   ##
################################################################################

setup() {
  # Fill in this helper function to do any setup if you need to.
  #
  # This function will be executed once at the beginning of the grading process.
  # Other functions might be executed repeatedly in arbitrary order.
  # Make use of this function to reduce unnecessary overhead and to make your
  # code behave consistently.
  #
  # e.g. You should compile Java code in this function.
  #
  # However, DO NOT use this function to solve any question or
  # generate any intermediate output.
  #
  # Examples:
  # javac *.java
  # mvn clean package
  # pip3 install -r requirements.txt
  #
  # Standard output format:
  # No standard output needed
  setup() {
  # Fill in this helper function to do any setup if you need to.
  #
  # This function will be executed once at the beginning of the grading process.
  # Other functions might be executed repeatedly in arbitrary order.
  # Make use of this function to reduce unnecessary overhead and to make your
  # code behave consistently.
  #
  # e.g. You should compile Java code in this function.
  #
  # However, DO NOT use this function to solve any question or
  # generate any intermediate output.
  #
  # Examples:
  # javac *.java
  # mvn clean package
  # pip3 install -r requirements.txt

  # Standard output format:
  # No standard output needed
  pip3 install --upgrade pip
}

cleanup() {
  # Fill this helper function to clean up if you need to.
  #
  # This function will be executed once at the end of the grading process
  # Other functions might be executed repeatedly in arbitrary order.
  #
  # Examples:
  # mvn clean
  #
  # Standard output format:
  # No standard output needed
  :
}

################################################################################
##                        Data Pre-processing                                 ##
################################################################################

json() {
  # (5 point) JSON parsing
  #
  # Question:
  # Parse the Wikipedia namespace JSON into a list for later use.
  #
  # The order of the namespaces and the letter case will not affect the
  # correctness.
  # The colon is required.
  #
  # Standard output format:
  # media:
  # special:
  # talk:
  # user:
  # user_talk:  # instead of "User talk:"
  # wikipedia:
  # wikipedia_talk:
  # ... # some title prefixes omitted
  # gadget_definition_talk
}

filter() {
  # (45 points)
  #
  # Question:
  # Fill this function to filter the dataset `pageviews-20161109-000000.gz` and
  # redirect the output to a file called `output`.
  # You need to read the gz file directly as the input stream, instead of
  # uncompressing and then reading it.
  #
  # One possible approach is to use `zcat` to uncompress the gz file to StdOut
  # and pipes it to your data filter program.
  #
  # Examples:
  # zcat pageviews-20161109-000000.gz | ./data_filter.sh
  # zcat pageviews-20161109-000000.gz | python data_filter.py
  # zcat pageviews-20161109-000000.gz | java DataFilter
  #
  # Hint for Java users:
  # DO NOT compile java code in this function,
  # you should put the `mvn` or `javac` command in setup() function
  #
  # Standard output format:
  # No standard output needed

}

################################################################################
##                           Data Analysis                                    ##
################################################################################
# In the following sections, you should write a function to compute the answer
# and print it to StdOut for each question.
#
# Finish the related primers first if you have not done so, as they will help
# you to get well prepared for the questions.
#
# WARNING:
# Treat every function as an independent and standalone program.
# Any question below should not depend on the result or the intermediate
# output from another.


# The intent in the questions below is to give you experience with the Unix philosophy:
# "Do One Thing and Do It Well."
# Besides, the ability to search the solutions for simple tasks quickly is an
# important skill to develop.

q1() {
  # (1 point) pattern-action statement in awk
  #
  # Question:
  # Print the record(s) that contain "Electoral_College_(United_States)"
  # as a substring.
  #
  # Be careful about regular expression operators, a.k.a metacharacters.
  #
  # Fill in the template and finish the solution:
  # awk '/regex/' input_file
  #
  # Standard output format:
  # <record>
  awk '$1~/Electoral_College_\(United_States\)/' output
}

q2() {
  # (1 point) simple data processing with awk
  #
  # Question:
  # How many requests were made to English Wikipedia in the hour?
  # (i.e. the sum of the accesses in the filtered file, `output`)
  #
  # Fill in the template and finish the solution:
  # awk '{ action } END { end_action }' input_file
  #
  # Standard output format:
  # <number>
  awk '{sum+=$2} END {print sum}' output
}

q3() {
  # (2 points) search and process data with awk
  #
  # Question:
  # How many total requests were made to English articles whose titles contain
  # "Donald_Trump"?
  #
  # Fill in the template and finish the solution:
  # awk '/regex/ { action } END { end_action }' input_file
  #
  # Standard output format:
  # <number>
  awk '$1~/Donald_Trump/{sum+=$2} END {print sum}' output
}

q4() {
  # (4 points) search word with grep
  #
  # Question:
  # How many articles are there in the filtered dataset with titles that include
  # "cloud" as a word instead of a substring (case insensitive)?
  #
  # A "cloud" substring must meet two requirements at the same time to be
  # qualified as a word:
  # 1. word boundary before "cloud":
  # "cloud" is at the beginning of the line, or preceded by a non-word
  # constituent character.
  # 2. word boundary after "cloud":
  # Similarly, "cloud" must be either at the end of the line or followed by
  # a non-word constituent character.
  #
  # Word-constituent characters are letters, digits, and the underscore,
  # i.e. [a-zA-Z_0-9]
  #
  # To understand the concept of word boundary, please read:
  # http://www.regular-expressions.info/wordboundaries.html
  #
  # Valid examples:
  # Cloud	45
  # Asperitas_(cloud)	9
  # Cloud-based_networking	4
  #
  # Invalid examples:
  # Cloud_computing	14
  # SoundCloud 43
  # Cloud9_(team)	1
  #
  # This question can be solved in a hard way:
  # 1. read the lines
  # 2. convert the lines to lowercase or set the regex engine to
  # case-insensitive mode
  # 3. implement the regex
  # 4. count the line
  #
  # With grep, however, the solution will be much more concise.
  #
  # Search the options of GNU grep that:
  # 1. suppress normal output which will print the matched lines, and print a
  # count of matching lines instead
  # 2. select lines containing matches that form whole words instead of
  # substrings
  # 3. search in a case-insensitive way
  #
  # Solve the question using:
  # grep options "cloud" input_filename
  #
  # Standard output format:
  # <number>
  grep -i -w -c 'cloud' output
}

# Again, when you face a common problem, there are often tools to help you.
# It is important to have the intelligence and courage to recognize, explore and
# simplify the problems with correct tools and documentations in our course.
#
# We recommend you to use the "pandas" library in Python to solve the questions
# below, even if you are new to Python.

q5() {
  # (2 points) convert list to JSON array
  #
  # Question:
  # What were the 3 most popular articles in the filtered output?
  # Print the titles of the 3 articles in descending order of pageviews as a
  # JSON array.
  #
  # A JSON array is an ordered collection of values.
  # An array begins with `[` and ends with `]`.
  # Values are separated by `,`.
  #
  # No matter how tempting it seems, DO NOT implement your own JSON parser.
  # When you face a common problem, there are often libraries to solve it.
  #
  # Recommended libraries:
  # e.g. json lib in Python 2/3
  # These libraries can translate a list to a JSON array (and vice versa)
  # directly through simple method calling.
  #
  # JSON grading criteria:
  # 1. The output can be in compressed or human-readable format.
  # 2. The output must follow the JSON standard specified by RFC 4627.
  # e.g. Strings must be double quoted. Unquoted or single quoted strings
  # are not allowed.
  # Therefore, an output in Python list format will be rejected, e.g.:
  # ['ABC','DEF','GHI']
  # 3. This criteria also applies to other questions.
  #
  # Read the Python starter code `q5.py`, which reads the file into a
  # Series.
  #
  # Standard output format:
  # ["ABC","DEF","GHI"]
  PYTHONIOENCODING=UTF-8 python3 q5.py
}

q6() {
  # (3 points) convert dict/map to JSON object
  #
  # Question:
  # `senators.txt` lists the articles about United States senators and
  # senators-elect.
  # Rank the list based on the hourly pageviews in descending order.
  # Print the ranked result as a JSON object.
  #
  # Use "standard competition ranking" to deal with ties, a.k.a "1224" ranking.
  # If A ranks ahead of B and C (which compare equal) and both ranked ahead of
  # D, then A gets ranking number 1 ("first"), B gets ranking number 2
  # ("joint second"), C also gets ranking number 2 ("joint second") and D gets
  # ranking number 4 ("fourth").
  # Reference: https://en.wikipedia.org/wiki/Ranking
  #
  # A JSON object is an unordered set of name/value pairs.
  # A JSON object begins with `{` and ends with `}`.
  # Each name is followed by `:` and the name/value pairs are separated by `,`.
  # For further information: http://www.json.org/
  #
  # The keys of the JSON object are the articles, and the values are the
  # rankings (not pageviews).
  #
  # Standard output format:
  # {"Tim_Kaine":1,...,"Martin_Heinrich":102,"Roger_Wicker":102,
  # "Mike_Rounds":104,...,"Ron_Johnson":107}
  PYTHONIOENCODING=UTF-8 python3 q6.py
}

q7() {
  # (4 points) read, join and write csv
  #
  # Question:
  # `races.csv` has a list of articles corresponding to the United States
  # presidential races by state.
  # You can get the page views in your `output` file using the article title of
  # a state in `races.csv`.
  # Your task is to join the column named "Pageviews" into the csv on "Article",
  # and print the merged data to StdOut along with the header.
  #
  # In `races.csv`, there are commas enclosed in double-quotes.
  # Please use libraries and do not just split fields with commas as delimiters.
  # In addition, performing a database-style join operation by columns or
  # indexes seems a non-trivial task, and again there are libraries to solve it:
  # pandas lib in Python 2/3
  #
  # A possible solution can be no more than 5 lines with 4 method calls.
  #
  # Standard output format:
  # State/District,Article,Seats,Pageviews
  # Alabama,"United_States_presidential_election_in_Alabama,_2016",9,109
  # Alaska,"United_States_presidential_election_in_Alaska,_2016",3,34
  # Arizona,"United_States_presidential_election_in_Arizona,_2016",11,67
  # ...
  PYTHONIOENCODING=UTF-8 python3 q7.py
}

################################################################################
##                   Head first regular expression                            ##
################################################################################

q8() {
  # (4 points) revisit the concept of word
  #
  # Question:
  # How many articles are there in the filtered dataset with titles that include
  # "cloud" as a "Wikipedia word" instead of a substring (case insensitive)?
  #
  # The commonly used definition of "word" is "a sequence of alphanumeric or
  # underscore characters" i.e. [a-zA-Z_0-9]
  # However, Wikipedia URLs replace spaces with underscores ("_") and this rule
  # also applies to our pageview data, and the common definition of a "word"
  # is no longer suitable.
  # For example, you may notice that grep word search does not match
  # "Cloud_computing".
  #
  # To meet Wikipedia conventions and explore the concept of word boundary,
  # we define a "Wikipedia word" as a group of [a-zA-Z0-9] characters instead.
  #
  # The full definition of word boundary can be replaced by the combination of
  # positive/negative lookahead and lookbehind.
  # To "match whole words only", a subset of a word boundary pattern is adequate
  # which can be replaced by
  # only negative lookahead/lookbehind. Try to figure out the solution and adopt
  # the "Wikipedia word" definition.
  # Reference: http://www.regular-expressions.info/lookaround.html
  #
  # DO NOT use error-prone approaches such as indexOf, lastIndexOf, etc.
  #
  # Valid examples:
  # Cloud	45
  # Asperitas_(cloud)	9
  # Cloud-based_networking	4
  # Cloud_computing	14
  #
  # Invalid examples:
  # SoundCloud 43
  # Cloud9_(team)	1
  # A_Walk_in_the_Clouds   14
  # No_More_Cloudy_Days    1
  #
  # This question can also be solved using GNU grep.
  # Before you write the regex, search the additional option of GNU grep that:
  # 1. interprets the pattern as a Perl regex for additional functionality
  #
  # Now you can give it a try:
  # grep options pattern input_file
  #
  # Standard output format:
  # <number>
  :
  grep -P -i -c '(?<![0-9a-zA-Z])cloud(?![0-9a-zA-Z])' output
}

q9() {
  # (4 points) regex capturing groups
  #
  # Question:
  # Rank the years by the sum of pageviews of the films released in each year.
  # Print the result as a JSON object.
  # The keys of the JSON object are the articles.
  # The values are the rankings (not pageviews).
  #
  # Only consider page titles ending with "_(yyyy_film)" when counting pageviews
  # for the year yyyy.
  # Note the underscore in front of the left parenthesis.
  # If a year has no film articles, do not include it in the ranking.
  #
  # Examples of valid cases:
  # Concussion_(2015_film)
  #
  # Examples of invalid cases:
  # Concussion_(film)
  # 2015_film
  #
  # Capturing groups can be used to retrieve the matched unit(s).
  # DO NOT use error-prone approaches such as split, indexOf, etc.
  #
  # Standard output format:
  # {"2017":2,"2016":1,"2015":2,...,"1776":251}
  PYTHONIOENCODING=UTF-8 python3 q9.py
}


################################################################################
##                    DO NOT MODIFY ANYTHING BELOW                            ##
################################################################################
declare -ar questions=( "json" "filter" "q1" "q2" "q3" "q4" "q5" "q6" "q7" "q8" "q9" )

readonly usage="This program is used to execute your solution.
Usage:
./runner.sh to run all the questions
./runner.sh -r <question_id> to run one single question
./runner.sh -s to run setup() function
./runner.sh -c to run cleanup() function
Example:
./runner.sh -r q1 to run q1"

contains() {
  local e
  for e in "${@:2}"; do
    [[ "$e" == "$1" ]] && return 0;
  done
  return 1
}

while getopts ":hr:sc" opt; do
  case $opt in
    h)
      echo "$usage" >&2
      exit
    ;;
    s)
      setup
      echo "setup() function executed" >&2
      exit
    ;;
    c)
      cleanup
      echo "cleanup() function executed" >&2
      exit
    ;;
    r)
      question=$OPTARG
      if contains "$question" "${questions[@]}"; then
        answer=$("$question")
        echo -n "$answer"
      else
        echo "Invalid question id" >&2
        echo "$usage" >&2
        exit 2
      fi
      exit
    ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "$usage" >&2
      exit 2
    ;;
  esac
done

if [ -z "$1" ]; then
  setup
  echo "setup() function executed" >&2
  echo "The answers generated by executing your solution are: " >&2

  for question in "${questions[@]}"; do
    echo "$question:"
    result="$("$question")"
    if [[ "$result" ]]; then
      echo "$result"
    else
      echo ""
    fi
  done
  cleanup
  echo "cleanup() function executed" >&2
  echo "If you feel these values are correct please run:" >&2
  echo "./submitter" >&2
else
  echo "Invalid usage" >&2
  echo "$usage" >&2
  exit 2
fi
