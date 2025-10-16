#let article(
  title: none,
  date: none,
  created-by: none,
  created-by-company: none,
  prepared-for: none,
  prepared-for-company: none,
  doc,
) = {
  let darkblue = rgb("#404E6B")
  let lightblue = rgb("#449CE1")

  set page(
    paper: "us-letter",
    margin: (x: 0.7in, y: 0.9in),
  )
  set text(lang: "en", region: "US", font: "Inter", size: 12pt, top-edge: 0.9em, fill: darkblue)
  set enum(indent: 10pt, body-indent: 15pt, number-align: center)
  set table(stroke: none)
  show link: set text(fill: lightblue, weight: "medium")
  show link: underline

  show heading: it => {
    let sizes = (
      "1": 20pt,
      "2": 18pt,
      "3": 16pt,
      "4": 14pt,
      "5": 13pt,
      "6": 12pt,
    )
    let level_str = str(it.level)
    let size = if level_str in sizes { sizes.at(level_str) } else { 10pt }
    let heading_color = if level_str == "1" {
      lightblue
    } else {
      darkblue
    }

    set text(fill: heading_color, size: size, weight: "bold")

    if level_str == "1" {
      pagebreak()
      block(inset: (y: 4pt))[#it]
    } else {
      block(inset: (y: 4pt))[#it]
    }
  }

  // cover page
  page(background: image(
    "asset-background.png",
    width: 107%,
    height: 103%,
    alt: "R for the rest of us background blue pattern",
  ))[
    #place(
      right,
      image("rfortherestofus-logo.png", width: 1.5in, alt: "R for the rest of us logo"),
    )
    #align(left + horizon)[
      #text(fill: white, size: 40pt, weight: "bold")[#title]
      \
      \
      \
      #text(fill: white)[#date]
      \
      \
      #place(bottom)[#grid(
          align: top + left,
          columns: (2fr, 0.5fr, auto),
          text(fill: white)[#text(weight: "bold", size: 11pt)[Created by:]\ #text(
              size: 11pt,
              top-edge: 0.75em,
            )[#created-by \ #created-by-company]],
          linebreak(),
          text(fill: white)[#text(weight: "bold", size: 11pt)[Prepared for:]\ #text(
              size: 11pt,
            )[#prepared-for \ #prepared-for-company]],
        )
      ]]
  ]

  pagebreak()
  doc
}
