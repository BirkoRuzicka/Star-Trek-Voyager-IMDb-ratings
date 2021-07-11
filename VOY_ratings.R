library(readr)
library(tidyverse)
library(colorspace)
library(ggfx)
library(ggtext)
library(ragg)
library(cowplot)
library(showtext)
library(trekfont)
library(trekcolors)

setwd("~/Weiterbildung_Data_Science/Projektarbeit_StarTrek/Ratings_vs_Viewers")

# read in the data
title_basics <- read_tsv('title.basics.tsv')
title_episode <- read_tsv('title.episode.tsv')
title_ratings <- read_tsv('title.ratings.tsv')

# get basic title information
basics_VOY <- title_basics %>% 
  filter(primaryTitle == "Star Trek: Voyager", titleType == "tvSeries")

# parent title ID
parent_title_id <- head(basics_VOY, 1)  %>% 
  pull(tconst)
parent_title_id

# title IDs for episodes
episodes_VOY <- title_episode %>% 
  filter(parentTconst == parent_title_id) %>% 
  inner_join(title_ratings, by = "tconst") %>% 
  inner_join(title_basics, by = "tconst") %>%
  collect() %>% 
  mutate(across(c(seasonNumber, episodeNumber), as.numeric))
episodes_VOY <- arrange(episodes_VOY, seasonNumber, episodeNumber)


# create df
df_VOY <- data.frame(episodes_VOY['seasonNumber'],
                     episodes_VOY['episodeNumber'],
                     episodes_VOY['primaryTitle'],
                     episodes_VOY['averageRating'],
                     episodes_VOY['numVotes'])


names(df_VOY) <- c('season', 'episode', 'title', 'imdb_rating', 'total_votes')


# plot prep

df_VOY_avg <-
  df_VOY %>% 
  arrange(season, episode) %>% 
  mutate(episode_id = row_number()) %>% 
  group_by(season) %>% 
  mutate(
    avg = mean(imdb_rating),
    episode_mod = episode_id + (7 * season),
    mid = mean(episode_mod)
  ) %>% 
  ungroup() %>% 
  mutate(season = factor(season))

df_lines <-
  df_VOY_avg %>% 
  group_by(season) %>% 
  summarize(
    start_x = min(episode_mod) - 4,
    end_x = max(episode_mod) + 4,
    y = unique(avg)
  ) %>% 
  pivot_longer(
    cols = c(start_x, end_x),
    names_to = "type",
    values_to = "x"
  ) %>% 
  mutate(
    x_group = if_else(type == "start_x", x + .1, x - .1),
    x_group = if_else(type == "start_x" & x == min(x), x_group - .1, x_group),
    x_group = if_else(type == "end_x" & x == max(x), x_group + .1, x_group)
  )



font <- c("Khan", "StarNext", "FederationDS9Title", "Federation", "Klingon", 
          "ModernVulcan", "TNGcast", "FederationStarfleet")
path <- system.file(paste0("fonts/", font, ".ttf"), package = "trekfont")

annotate_richtext <- function(label, ...) {
  annotate("richtext", size = 4, fill = NA, 
           label = label, label.color = NA, 
           label.padding = unit(0.05, "mm"),
           hjust = 0,
           ...)
}

geom_curve2 <- function(..., curvature = 0.2) {
  geom_curve(curvature = curvature, size = 0.03,
             arrow = arrow(length = unit(1.0, "mm"), type = "closed"),
             ...) 
}
      
# plot
ggplot(data = df_VOY_avg, aes(episode_mod, imdb_rating)) + 
  theme_minimal() +
  theme(plot.background = element_rect(color = NA, fill = '#080A0D'),
        panel.grid = element_blank(),
        panel.grid.major.y = element_line(size = 0.2, color = lighten('#080A0D', 0.2)),
        text = element_text(color = '#e3e3e3'),
        plot.title = element_markdown(color = '#9BC6DA', family = font[3],
                                      size = 30, margin = margin(t = 8, b = 14)),
        plot.subtitle = element_markdown(color = '#9BC6DA', 
                                         size = 16, margin = margin(t = 6)),
        plot.caption = element_markdown(color = '#9BC6DA', size = 11),
        legend.position = c(.5, .085), 
        legend.key.width = unit(2, "lines"),
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y =element_text(size=12), # y-numbers
        axis.title.y =element_text(size=12, color='#9BC6DA')
        ) +
  geom_hline(data = tibble(y = 6:9),
             aes(yintercept = y),
             color = lighten('#080A0D', 0.35),
             size = .5) +
  geom_segment(aes(xend = episode_mod,
                   yend = avg, 
                   color = season)) +
  geom_line(data = df_lines,
            aes(x_group, y, color = season),
            size = 2.5) +
  geom_point(aes(size = total_votes, color = season)) +
  geom_label(aes(mid, 9.65,
                 label = glue::glue(" Season {season} "),
                 color = season),
             fill = NA,
             size=5,
             label.padding = unit(.5, "lines"),
             label.r = unit(.25, "lines"),
             label.size = .8) +
  scale_x_continuous(expand = c(.015, .015)) +
  scale_y_continuous(expand = c(.03, .03),
                     limits = c(5, 10),
                     breaks = seq(5.0, 9.5, by = .5),
                     sec.axis = dup_axis(name = NULL)) +
  scale_color_trek(palette = 'tholian') +
  scale_size_binned(name = "Votes per Episode",
                    range = c(.5, 3)) +
  labs(x = NULL, y = "Average IMDb Rating", size=20,
       subtitle = "Each \u2022 represents one episode, size is proportional to the number of votes. Horizontal bars indicate average season ratings.",
       caption = "Visualization by Birko-Katarina Ruzicka (@lets_boldly_go)  •  Data by IMDb via data.world and Wikipedia  •  Inspired by @CedScherer and @_ansgar") +
  guides(size = 'none', color = 'none') +
  ggtitle("'Star Trek: Voyager' episode ratings (IMDb)") +
  # Annotations
  annotate_richtext(label = "S6 E12 is the best<br>rated episode (9.1)",
                  x = 180, y = 9.2, color = '#D9D3BE') +
  geom_curve2(aes(x = 179, xend = 172.6, y = 9.3, yend = 9.17), color = '#D9D3BE',
              curvature = 0.3) +
  
  annotate_richtext(label = "S5 E18 has the<br>lowest rating (5.1)",
                    x = 151, y = 5.5, color = '#E1E1E1') +
  geom_curve2(aes(x = 153, xend = 147, y = 5.3, yend = 5.1), color = '#E1E1E1', 
              curvature = -0.3)

  
        
