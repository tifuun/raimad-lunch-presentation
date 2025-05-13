#import "@preview/plotst:0.2.0": *
#import "@preview/touying:0.6.1": *
//#import themes.simple: *
#import themes.stargazer: *

// Change font size of code blocks
#show raw: set text(12pt)

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-colors(
    primary: rgb("#f00"),
    primary-dark: rgb("#222"),
    secondary: rgb("#ffffff"),
    tertiary: rgb("#222"),
    neutral-lightest: rgb("#ffffff"),
    neutral-darkest: rgb("#000000"),
  ),
)

#let highlight_lines(codeblock, lines) = {
  let lineno = 1
  let lang = none
  let color = gray
  for line in codeblock.text.split("\n") {
    lineno = lineno + 1
    if lines == none or lineno in lines {
      lang = codeblock.lang
      color = black
    } else {
      lang = none
      color = gray
    }
    text(color)[
      #raw(
        line,
        block: true,
        lang: lang
      )
    ]
    v(-4pt)
  }
}

#let overlay(img, color) = layout(bounds => {
  let size = measure(img, ..bounds)
  img
  place(top + left, block(..size, fill: color))
})

#page(background: overlay(image("img/toydeshima2.png", height: 100%), white.transparentize(40%)))[
  #align(center)[
    #image("img/raimad-banner.svg", width: 90%)
    #box(fill: white, inset: 5pt)[
      RAIMAD: Collaborative Development of On-Chip Astronomical Instruments
    ]
  ]
]

== Context: DESHIMA2 and PyCleWin

#slide[
  #image("img/deshima2.png", width: 100%)
][
  #image("img/pyclewin.png", width: 100%)
]

== What does it look like?


#slide[

```python
import raimad as rai

class IShapedFilter(rai.Compo):
    def _make(self, beam_length: float = 10.5):
        beam = rai.RectLW(2, beam_length).proxy()
        coup_top = rai.RectLW(10, 2).proxy()
        coup_bot = rai.RectLW(12, 2).proxy()

        coup_top.snap_above(beam)
        coup_bot.snap_below(beam)

        self.subcompos.beam = beam
        self.subcompos.coup_top = coup_top
        self.subcompos.coup_bot = coup_bot

my_filter = IShapedFilter()
rai.show(my_filter)
```
][

#pause
#image("img/filter.png", width: 100%)

]

== We don't have to do tedious arithmetic

#slide[

#highlight_lines(
```python
import raimad as rai

class IShapedFilter(rai.Compo):
    def _make(self, beam_length: float = 10.5):
        beam = rai.RectLW(2, beam_length).proxy()
        coup_top = rai.RectLW(10, 2).proxy()
        coup_bot = rai.RectLW(12, 2).proxy()

        coup_top.snap_above(beam)
        coup_bot.snap_below(beam)

        self.subcompos.beam = beam
        self.subcompos.coup_top = coup_top
        self.subcompos.coup_bot = coup_bot

my_filter = IShapedFilter()
rai.show(my_filter)
```,
(10, 11)
)

][

#pause

#image("img/magnetic-blocks.jpg", width: 90%)

]

== Subcomponenets let us define complex things

#slide(composer: (1.4fr, 1fr))[

```python
import raimad as rai
from .filter import IShapedFilter

class FilterBank(rai.Compo):
    def _make(self):
      for pos, length in ((0, 10), (20, 12), (40, 16)):

          filt = IShapedFilter(beam_length=length).proxy()
          filt.movex(pos)

          self.subcompos.append(filt)

filterbank = FilterBank()
rai.show(filterbank)
```

][

#pause
#image("img/filterbank.png", width: 100%)

]

== ...very complex things

#align(center)[
  #image("img/toydeshima2.png", width: 80%)
]

== Real-world usage

#align(center)[
  #image("img/T7011.png", height: 80%)
]

== Component Browser

#link("https://tifuun.github.io/raidex/")

#image("img/browser.png", width: 100%)

== Transmission line routing

#slide[
```python
path = (
    tl.StartAt((-10, -10),
      straight=StraightA,
      bend=Bend,
      radius=20),

    tl.StraightTo((10, 10), radius=5),

    tl.StraightTo((30, 10)),
    tl.StraightTo((50, -10)),
    tl.StraightTo((50, 20)),

    tl.StraightTo((0, 22),
      straight=TaperAB, bend=BendB),

    tl.StraightTo((60, 40),
      straight=StraightB),
    tl.StraightTo((60, 0))
    )
```
][
  #image("img/tl.png", width: 90%)
]

== It's fast and it's only gonna get faster

#slide[
  #align(center)[
    #image("img/plots/speed.svg", fit: "cover")
  ]
][
]

#slide[
  #align(center)[
    #image("img/plots/speed2.svg", fit: "cover")
  ]
][
  #align(center)[
    #image("img/megadeshima.png", height: 80%)
  ]
]

/*
Toydeshima2:
real    0m 7.43s
user    0m 6.85s
sys     0m 0.27s

MEGADESHIMA:
real    0m 30.39s
user    0m 28.54s
sys     0m 1.47s

original deshima2:
real    2m 20.39s
user    0m 42.68s
sys     1m 36.42s
*/

== And we wrote a paper!

#box(height: 90%)[
  #box(
    width: 1fr,
    image("img/paper/paper-0.png", fit: "cover")
  )
  #box(
    width: 1fr,
    image("img/paper/paper-1.png", fit: "cover")
  )
  #box(
    width: 1fr,
    image("img/paper/paper-2.png", fit: "cover")
  )
]

== Thanks for listening!

- Github: #link("https://github.com/tifuun/raimad")
- Documentation: #link("https://tifuun.github.io/raidoc/")
- Component Browser: #link("https://tifuun.github.io/raidex/")

