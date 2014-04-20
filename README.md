# Topographical map of Slovenia

## Why?

I wanted to see topographic map on my phone. [Geopedia](http://www.geopedia.si/?params=T130_vT_b4#T130_x499072_y112072_s9_b4)'s UI/UX is terrible. It doesn't work on phones or tablets, it doesn't support touch input, it lacks any device location knowledge, it's very slow,… It just sucks, to say the least.

## How?

There is no official way to get topo maps of Slovenia, unless you're willing to pay [€500+](http://www.e-prostor.gov.si/fileadmin/narocanje/Tabela_stevila_enot_in_tock.pdf). Talk about open public data, huh?

Luckily I found [a website](http://mapy.mk.cvut.cz/) that hosts a bunchload of maps. And the [topo map of Slovenia](http://mapy.mk.cvut.cz/list/data/Slovinsko-Slovenia/Slovenia) was hiding amongst them. Unfortunatelly files were in a very cryptic `Oziexplorer` format.

## Now what

It took quite a lot of googling of what to do with `.map` extension and how I'd display all those in a browser. Amazingly I found a [very fresh article](http://www.normis.info/blog/2014/4/2/how-to-calibrate-maps) by [@trakais](https://github.com/trakais) who basically did the exact same thing a couple of weeks ago.

So this were the steps:
- `brew install gdal`
- download [tilers-tools](https://code.google.com/p/tilers-tools/)
- `./gdal_tiler.py --cut --release ../Slovenia/*.map`
- `./tiles_merge.py ../Slovenia/*.zyx ../Slovenia/final`
- `brew install pngquant`
- `find . -name '*.png' -print0 | xargs -0 -P4 pngquant --ext .png --force 256`
- while all this is being processed write a simple [leaflet](http://leafletjs.com/) [map display](js/map.js)
- copy images to [Dropbox](http://dropbox.com/) public folder
- publish this on [GitHub](http://github.com/)
- grab a :beer: 'cause it was a great hack day :tada:

## Thanks

First I have to thank [The Surveying and Mapping Authority of the Republic of Slovenia](http://www.gu.gov.si/en/) for making this maps in the first place. Even though they're stuck in the 90s mentality, producing maps is no walk in a park.

Next whoever made and uploaded those maps.

Of course [@trakais](https://github.com/trakais) - it would take me hours of searching for what his article so nicely explained and made it a breeze.

Next come all the people working in the open source making all of this even possible. [Homebrew](http://brew.sh/), [GDAL](http://www.gdal.org/), [tilers-tools](https://code.google.com/p/tilers-tools/), [leaflet](http://leafletjs.com/),… there are so many tools we depend on every day. We should really be more thankful. So if anyone of you reads this, have a :tropical_drink: on me.

**Thank you!**

## OK, fineeee, I don't careeee just give me the link

Here: [topo](http://mrfoto.github.io/topo)
