pkgname <- "fivethirtyeight"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('fivethirtyeight')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("ahca_polls")
### * ahca_polls

flush(stderr()); flush(stdout())

### Name: ahca_polls
### Title: American Health Care Act Polls
### Aliases: ahca_polls
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
ahca_polls_tidy <- ahca_polls %>%
  gather(opinion, count, -c(start, end, pollster, text, url))



cleanEx()
nameEx("airline_safety")
### * airline_safety

flush(stderr()); flush(stdout())

### Name: airline_safety
### Title: Should Travelers Avoid Flying Airlines That Have Had Crashes in
###   the Past?
### Aliases: airline_safety
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
airline_safety_tidy <- airline_safety %>%
  gather(type, count, -c(airline, incl_reg_subsidiaries, avail_seat_km_per_week)) %>%
  mutate(
    period = str_sub(type, start=-5),
    period = str_replace_all(period, "_", "-"),
    type = str_sub(type, end=-7)
  )



cleanEx()
nameEx("bob_ross")
### * bob_ross

flush(stderr()); flush(stdout())

### Name: bob_ross
### Title: A Statistical Analysis of the Work of Bob Ross
### Aliases: bob_ross
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
bob_ross_tidy <- bob_ross %>%
  gather(object, present, -c(episode, season, episode_num, title)) %>%
  mutate(present = as.logical(present)) %>%
  arrange(episode, object)



cleanEx()
nameEx("candy_rankings")
### * candy_rankings

flush(stderr()); flush(stdout())

### Name: candy_rankings
### Title: Candy Power Ranking
### Aliases: candy_rankings
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
candy_rankings_tidy <- candy_rankings %>%
  gather(characteristics, present, -c(competitorname, sugarpercent, pricepercent, winpercent)) %>%
  mutate(present = as.logical(present)) %>%
  arrange(competitorname)



cleanEx()
nameEx("drinks")
### * drinks

flush(stderr()); flush(stdout())

### Name: drinks
### Title: Dear Mona Followup: Where Do People Drink The Most Beer, Wine
###   And Spirits?
### Aliases: drinks
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
drinks_tidy <- drinks %>%
  gather(type, servings, -c(country, total_litres_of_pure_alcohol)) %>%
  mutate(
    type = str_sub(type, start=1, end=-10)
  ) %>%
  arrange(country, type)



cleanEx()
nameEx("drug_use")
### * drug_use

flush(stderr()); flush(stdout())

### Name: drug_use
### Title: How Baby Boomers Get High
### Aliases: drug_use
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
use <- drug_use %>%
  select(age, n, ends_with("_use")) %>%
  gather(drug, use, -c(age, n)) %>%
  mutate(drug = str_sub(drug, start=1, end=-5))
freq <- drug_use %>%
  select(age, n, ends_with("_freq")) %>%
  gather(drug, freq, -c(age, n)) %>%
  mutate(drug = str_sub(drug, start=1, end=-6))
drug_use_tidy <- left_join(x=use, y=freq, by = c("age", "n", "drug")) %>%
  arrange(age)



cleanEx()
nameEx("fifa_audience")
### * fifa_audience

flush(stderr()); flush(stdout())

### Name: fifa_audience
### Title: How To Break FIFA
### Aliases: fifa_audience
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
fifa_audience_tidy <- fifa_audience %>%
  gather(type, share, -c(country, confederation)) %>%
  mutate(type = str_sub(type, start=1, end=-7)) %>%
  arrange(country)



cleanEx()
nameEx("fivethirtyeight")
### * fivethirtyeight

flush(stderr()); flush(stdout())

### Name: fivethirtyeight
### Title: fivethirtyeight: Data and Code Behind the Stories and
###   Interactives at 'FiveThirtyEight'
### Aliases: fivethirtyeight fivethirtyeight-package

### ** Examples

# Example usage:
library(fivethirtyeight)
head(bechdel)

# All information about any data set can be found in the help file:
?bechdel

# To view a list of all data sets:
data(package = "fivethirtyeight")

# To view a detailed list of all data sets:
vignette("fivethirtyeight", package = "fivethirtyeight")

# Some data sets include vignettes with an example analysis:
vignette("bechdel", package = "fivethirtyeight")

# To browse all vignettes:
browseVignettes(package = "fivethirtyeight")



cleanEx()
nameEx("love_actually_appearance")
### * love_actually_appearance

flush(stderr()); flush(stdout())

### Name: love_actually_appearance
### Title: The Definitive Analysis Of 'Love Actually,' The Greatest
###   Christmas Movie Of Our Time
### Aliases: love_actually_appearance
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
love_actually_appearance_tidy <- love_actually_appearance %>%
  gather(actor, appears, -c(scenes)) %>%
  arrange(scenes)



cleanEx()
nameEx("mayweather_mcgregor_tweets")
### * mayweather_mcgregor_tweets

flush(stderr()); flush(stdout())

### Name: mayweather_mcgregor_tweets
### Title: Mayweather Vs McGregor Tweets
### Aliases: mayweather_mcgregor_tweets
### Keywords: datasets

### ** Examples

# To obtain the entire dataset, run the code inside the following if statement:
if(FALSE){
  library(tidyverse)
  url <-
   "https://raw.githubusercontent.com/fivethirtyeight/data/master/mayweather-mcgregor/tweets.csv"
  mayweather_mcgregor_tweets <- read_csv(url) %>%
    mutate(
      emojis = as.logical(emojis),
      retweeted = as.logical(retweeted),
      id = as.character(id)
    )
}



cleanEx()
nameEx("mlb_elo")
### * mlb_elo

flush(stderr()); flush(stdout())

### Name: mlb_elo
### Title: MLB Elo
### Aliases: mlb_elo
### Keywords: datasets

### ** Examples

# To obtain the entire dataset, run the code inside the following if statement:
if(FALSE){
  library(tidyverse)
  mlb_elo <- read_csv("https://projects.fivethirtyeight.com/mlb-api/mlb_elo.csv") %>%
    mutate(
      playoff = as.factor(playoff),
      playoff = ifelse(playoff == "<NA>", NA, playoff),
      neutral = as.logical(neutral)
    )
}



cleanEx()
nameEx("nba_carmelo")
### * nba_carmelo

flush(stderr()); flush(stdout())

### Name: nba_carmelo
### Title: The Complete History Of The NBA 2017-18 NBA Predictions
### Aliases: nba_carmelo
### Keywords: datasets

### ** Examples

# To obtain the entire dataset, run the following code:
library(tidyverse)
library(janitor)
nba_carmelo <- read_csv("https://projects.fivethirtyeight.com/nba-model/nba_elo.csv") %>%
  clean_names() %>%
  mutate(
    team1 = as.factor(team1),
    team2 = as.factor(team2),
    playoff = ifelse(playoff == "t", TRUE, FALSE),
    playoff = ifelse(is.na(playoff), FALSE, TRUE),
    neutral = ifelse(neutral == 1, TRUE, FALSE)
  )



cleanEx()
nameEx("nfl_fandom_google")
### * nfl_fandom_google

flush(stderr()); flush(stdout())

### Name: nfl_fandom_google
### Title: How Every NFL Team<e2><80><99>s Fans Lean Politically
### Aliases: nfl_fandom_google
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
nfl_fandom_google_tidy <- nfl_fandom_google %>%
  gather(sport, search_traffic, -c("dma", "trump_2016_vote")) %>%
  arrange(dma)



cleanEx()
nameEx("nfl_fandom_surveymonkey")
### * nfl_fandom_surveymonkey

flush(stderr()); flush(stdout())

### Name: nfl_fandom_surveymonkey
### Title: How Every NFL Team<e2><80><99>s Fans Lean Politically
### Aliases: nfl_fandom_surveymonkey
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
nfl_fandom_surveymonkey_tidy <- nfl_fandom_surveymonkey %>%
  gather(key = race_party, value = percent,
         -c("team", "total_respondents", "gop_percent", "dem_percent",
            "ind_percent", "white_percent", "nonwhite_percent")) %>%
  arrange(team)



cleanEx()
nameEx("police_locals")
### * police_locals

flush(stderr()); flush(stdout())

### Name: police_locals
### Title: Most Police Don't Live In The Cities They Serve
### Aliases: police_locals
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
police_locals_tidy <- police_locals %>%
   gather(key = "race", value = "perc_in", all:asian)



cleanEx()
nameEx("ratings")
### * ratings

flush(stderr()); flush(stdout())

### Name: ratings
### Title: An Inconvenient Sequel
### Aliases: ratings
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
library(stringr)
ratings_tidy <- ratings %>%
  gather(votes, count, -c(timestamp, respondents, category, link, average, mean, median)) %>%
  arrange(timestamp)



cleanEx()
nameEx("riddler_castles")
### * riddler_castles

flush(stderr()); flush(stdout())

### Name: riddler_castles
### Title: Can You Rule Riddler Nation?
### Aliases: riddler_castles
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run
library(tidyverse)
library(stringr)
riddler_castles_tidy<-riddler_castles %>%
   gather(key = castle , value = soldiers, castle1:castle10) %>%
   mutate(castle = as.numeric(str_replace(castle, "castle","")))



cleanEx()
nameEx("riddler_castles2")
### * riddler_castles2

flush(stderr()); flush(stdout())

### Name: riddler_castles2
### Title: The Battle For Riddler Nation, Round 2
### Aliases: riddler_castles2
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run
library(tidyverse)
library(stringr)
riddler_castles_tidy<-riddler_castles2 %>%
   gather(key = castle , value = soldiers, castle1:castle10) %>%
   mutate(castle = as.numeric(str_replace(castle, "castle","")))



cleanEx()
nameEx("sandy_311")
### * sandy_311

flush(stderr()); flush(stdout())

### Name: sandy_311
### Title: The (Very) Long Tail Of Hurricane Recovery
### Aliases: sandy_311
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
sandy_311_tidy <- sandy_311 %>%
  gather(agency, num_calls, -c("date", "total")) %>%
  arrange(date) %>%
  select(date, agency, num_calls, total) %>%
  rename(total_calls = total) %>%
  mutate(agency = as.factor(agency))



cleanEx()
nameEx("senators")
### * senators

flush(stderr()); flush(stdout())

### Name: senators
### Title: Senator Dataset
### Aliases: senators
### Keywords: datasets

### ** Examples

# To obtain the entire dataset, run the code inside the following if statement:
if(FALSE){
  library(tidyverse)
  url <- "https://raw.githubusercontent.com/fivethirtyeight/data/master/twitter-ratio/senators.csv"
  senators <- read_csv(url) %>%
    mutate(
      party = as.factor(party),
      state = as.factor(state),
      created_at = as.POSIXct(created_at, tz = "GMT", format = "%m/%d/%Y %H:%M"),
      text =  gsub("[^\x01-\x7F]", "", text)
    ) %>%
    select(created_at, user, everything())
}



cleanEx()
nameEx("trumpworld_polls")
### * trumpworld_polls

flush(stderr()); flush(stdout())

### Name: trumpworld_polls
### Title: What the World Thinks of Trump
### Aliases: trumpworld_polls
### Keywords: datasets

### ** Examples

# To convert data frame to tidy data (long) format, run:
library(tidyverse)
trumpworld_polls_tidy <- trumpworld_polls %>%
  gather(country, percent_positive, -c("year", "avg", "question"))



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
