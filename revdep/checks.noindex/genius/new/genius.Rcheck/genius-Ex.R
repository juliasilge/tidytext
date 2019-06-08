pkgname <- "genius"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('genius')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("add_genius")
### * add_genius

flush(stderr()); flush(stdout())

### Name: add_genius
### Title: Add lyrics to a data frame
### Aliases: add_genius

### ** Examples





cleanEx()
nameEx("calc_self_sim")
### * calc_self_sim

flush(stderr()); flush(stdout())

### Name: calc_self_sim
### Title: Calculate a self-similarity matrix
### Aliases: calc_self_sim

### ** Examples


## Not run: 
##D bad_habits <- genius_lyrics("Alix", "Bad Habits")
##D self_sim <- calc_self_sim(bad_habits, lyric)
## End(Not run)




cleanEx()
nameEx("gen_album_url")
### * gen_album_url

flush(stderr()); flush(stdout())

### Name: gen_album_url
### Title: Create Genius Album url
### Aliases: gen_album_url

### ** Examples


gen_album_url(artist = "Pinegrove", album = "Cardinal")




cleanEx()
nameEx("gen_song_url")
### * gen_song_url

flush(stderr()); flush(stdout())

### Name: gen_song_url
### Title: Create Genius url
### Aliases: gen_song_url

### ** Examples

gen_song_url(artist = "Kendrick Lamar", song = "HUMBLE")
gen_song_url("Margaret glaspy", "Memory Street")




cleanEx()
nameEx("genius_album")
### * genius_album

flush(stderr()); flush(stdout())

### Name: genius_album
### Title: Retrieve song lyrics for an album
### Aliases: genius_album

### ** Examples


## Not run: 
##D genius_album(artist = "Petal", album = "Comfort EP")
##D genius_album(artist = "Fit For A King", album = "Deathgrip")
## End(Not run)




cleanEx()
nameEx("genius_lyrics")
### * genius_lyrics

flush(stderr()); flush(stdout())

### Name: genius_lyrics
### Title: Retrieve song lyrics from Genius.com
### Aliases: genius_lyrics

### ** Examples

genius_lyrics(artist = "Margaret Glaspy", song = "Memory Street")
genius_lyrics(artist = "Kendrick Lamar", song = "Money Trees")
genius_lyrics("JMSN", "Drinkin'")




cleanEx()
nameEx("genius_tracklist")
### * genius_tracklist

flush(stderr()); flush(stdout())

### Name: genius_tracklist
### Title: Create a tracklist of an album
### Aliases: genius_tracklist

### ** Examples


genius_tracklist(artist = "Andrew Bird", album = "Noble Beast")




cleanEx()
nameEx("genius_url")
### * genius_url

flush(stderr()); flush(stdout())

### Name: genius_url
### Title: Use Genius url to retrieve lyrics
### Aliases: genius_url

### ** Examples

url <- gen_song_url(artist = "Kendrick Lamar", song = "HUMBLE")
genius_url(url)

genius_url("https://genius.com/Head-north-in-the-water-lyrics", info = "all")




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
