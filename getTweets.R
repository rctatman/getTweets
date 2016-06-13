# This script is an improved version, with more through documentation, of the 
# one I used in the paper on scoiophonetic variation in variant spellings. If
# you do use this script for your resaech, I'd apprecite it if you cited that
# paper.
# 
# Citation:
# 
# Tatman, R. (2015). # go awn: Sociophonetic Variation in Variant Spellings on 
# Twitter. Working Papers of the Linguistics Circle, 25(2), 97-108.
# 
# Please feel free to contact me with any questions/concerns at rctatman@uw.edu.
# Work supported by NSF Grant DGE-1256082/

#### Install Packages ####

# Install necessary packages. Uncomment these lines and run them to install. You will only need to do
# this once per computer.

# install.packages("twitteR")
# install.packages("plyr")
# install.packages(c("devtools", "rjson", "bit64", "httr"))

# If you installed these packages, you'll now need to restart R. You can close 
# and open your R session, or, in RStudio, hit ctrl+shift+0. After restarting R,
# you'll need to install these additional packages:

# install.packages("pacman")
# pacman::p_load(twitteR, sentiment, plyr, ggplot2, wordcloud, RColorBrewer, httpuv, RCurl, base64enc)
# options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

##### Load libraries, sign in to Twitter ####

# From here on, you will need to run this code every R session. Load in libraries:
library(twitteR)
library(plyr)

# Sign in to Twitter. You will need your own Twitter accoutn and API keys for 
# this. You can get these by following the instruions here:
# https://dev.twitter.com/oauth/overview/application-owner-access-tokens

api_key <- "YOUR_API_KEY"
api_secret <- "YOUR_API_SECRET"
access_token <- "YOUR_ACCESS_TOKEN"
access_token_secret <- "YOUR_ACCESS_TOKEN_SECRET"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

#### Search Twitter ####

# The function to search for Tweets is "searchTwitter". It retuns a pretty 
# unweildly matrix, so we're going to transform it into a dataframe instead. For
# more info on the function:
?searchTwitter

# This query gets up to 10 tweets, in English, that include the string "language".
# Note that quarying a large number of tweets will take a while. 
TwitterTweets <- searchTwitter(searchString = "language", n=10, lang = "en") 
TwitterTweets.df = do.call("rbind",lapply(TwitterTweets,as.data.frame))

# the Twitter search API (documentation: https://dev.twitter.com/rest/public/search)
# is pretty sophisiticated. Some functionality that might be useful (this would
# be put in the searchString argument):

# - '"no dice"' will return tweets with the exact string "no dice"
# - adding "filter:native_video" will return only tweets with videos
# - including ":)" or ":(" will return tweets with postive or negative sentiment 
# - including "?" will get you tweets with a question

# finally, save our data to a CSV so we can analyze it later
write.csv(TwitterTweets.df, "directory/to/save/to/TwitterTweets.csv")
