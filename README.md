# IMDb ratings for all episodes of 'Star Trek: Voyager'

![](https://github.com/BirkoRuzicka/Star-Trek-Voyager-IMDb-ratings/blob/main/VOY_ratings.png)

## Background

My first project in R! I saw the graphs linked in the section below and realized: I can do this too! <br>
Come say hi <a href="https://twitter.com/lets_boldly_go/status/1414333053590179841">on Twitter</a> and let me know what you think!

## Inspiration

Cedric Scherer’s visualization of the ratings for “The Office”:
<blockquote class="twitter-tweet">

<p lang="en" dir="ltr">

<a href="https://twitter.com/hashtag/TidyTuesday?src=hash&amp;ref_src=twsrc%5Etfw">\#TidyTuesday</a>
Week 2020/12 - The Office on
<a href="https://twitter.com/IMDb?ref_src=twsrc%5Etfw">@IMDb</a>
👨‍💼<br><br>A simple one since I have to catch up on a few weeks.
And guess it's my first waterfall chart ever
🤷‍♂️<a href="https://twitter.com/hashtag/r4ds?src=hash&amp;ref_src=twsrc%5Etfw">\#r4ds</a>
<a href="https://twitter.com/hashtag/ggplot2?src=hash&amp;ref_src=twsrc%5Etfw">\#ggplot2</a>
<a href="https://twitter.com/hashtag/tidyverse?src=hash&amp;ref_src=twsrc%5Etfw">\#tidyverse</a>
<a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">\#rstats</a>
<a href="https://twitter.com/hashtag/dataviz?src=hash&amp;ref_src=twsrc%5Etfw">\#dataviz</a>
<a href="https://t.co/YV9NqO85aw">pic.twitter.com/YV9NqO85aw</a>

</p>

— Cédric Scherer 💉 (@CedScherer)
<a href="https://twitter.com/CedScherer/status/1242229041488433152?ref_src=twsrc%5Etfw">March
23, 2020</a>

</blockquote>
<br>
as well as Ansgar Wolsing's visualization of the ratings for "24" (which was in turn inspired by Cedric's work):

<blockquote class="twitter-tweet">

<p lang="en" dir="ltr">

I completed all 8 seasons of 24 just recently (yes, very late to the party).

How has each episode been rated on <a href="https://twitter.com/IMDb?ref_src=twsrc%5Etfw">@IMDb</a>?
<br><br>
<a href="https://twitter.com/hashtag/TidyTuesday?src=hash&amp;ref_src=twsrc%5Etfw">\#TidyTuesday</a>
<a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">\#rstats</a>

<a href="https://t.co/MvwZC9prcB">pic.twitter.com/MvwZC9prcB</a>

</p>

— Ansgar Wolsing (@_ansgar)
<a href="https://twitter.com/_ansgar/status/1411721833804664836?ref_src=twsrc%5Etfw">July 4, 2021</a>
</blockquote>

## Data

Ratings are averaged ratings from IMDb users:

  - Datasets: <https://datasets.imdbws.com/>
  - Documentation: <https://www.imdb.com/interfaces/>

## Packages worth mentioning
I used these two packages and highly recommend them:
<div class="row">

<div class="col-sm-2">

<a href="https://github.com/leonawicz/trekcolors"><img src="https://raw.githubusercontent.com/leonawicz/trekcolors/master/man/figures/logo.png" style="margin-right:20px;margin-bottom:0;" width="60" align="left"></a>

</div>

<div class="col-sm-10">

<h4 style="padding:30px 0 0 0;margin-top:5px;margin-bottom:5px;">

<a href="https://github.com/leonawicz/trekcolors">trekcolors</a>: A
color palette package

</h4>

Predefined and customizable Star Trek themed color palettes and related functions.

</div>
</div>

<br>

<div class="row">

<div class="col-sm-2">

<a href="https://github.com/leonawicz/trekfont"><img src="https://raw.githubusercontent.com/leonawicz/trekfont/master/man/figures/logo.png" style="margin-right:20px;margin-bottom:0;" width="60" align="left"></a>

</div>

<div class="col-sm-10">

<h4 style="padding:30px 0 0 0;margin-top:5px;margin-bottom:5px;">

<a href="https://github.com/leonawicz/trekfont">trekfont</a>: A fonts
package

</h4>

True (Trek) type fonts to style your Star Trek themed graphics text.

</div>

</div>

<br>

