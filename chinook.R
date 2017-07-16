library(dbplyr)
library(dplyr)
library(RSQLite)

con <- src_sqlite("~/Downloads/chinook.db")

albums <- con %>% tbl("albums")
artists <- con %>% tbl("artists")
genres <- con %>% tbl("genres")
tracks <- con %>% tbl("tracks")
media_types <- con %>% tbl("media_types")

data <- tracks %>%
  inner_join(albums, by = "AlbumId") %>%
  inner_join(genres, by = "GenreId") %>%
  inner_join(artists, by = "ArtistId")

tracks %>%
  inner_join(genres, by = "GenreId") %>%
  rename(genre = Name.y) %>%

  group_by(genre) %>%
  summarize(time = mean(milliseconds)/1000/60) %>%
  arrange(time) %>%
  View

summarize(mean(milliseconds)/1000/60)
data %>% arrange(-milliseconds) %>% head(10)

size <- tracks %>%
  inner_join(genres, by = "GenreId") %>%
  inner_join(media_types, by = "MediaTypeId") %>%
  select(Milliseconds, Bytes, genre = Name.y, media = Name) %>%
  collect

size %>%
  filter(Milliseconds < 2000000 & Bytes < 100000000) %>%
  ggplot() +
  aes(x = Milliseconds, y = Bytes, color = media) +
  geom_point()
