# devtools::install_github("timelyportfolio/d3vennR")

library("d3vennR")

## Simple layout from venn.js Readme.md
d3vennR(
  data = list(
    list( sets = list("A"), size = 12 )
    , list( sets = list("B"), size = 12 )
    , list( sets = c("A", "B"), size = 2)
  )
)

## Changing the Style from venn.js Readme.md
styled_venn <- d3vennR(
  # data from venn.js examples
  #   https://github.com/benfred/venn.js/blob/master/examples/medical.jsonp
  data = list(
    list(sets = list(0), label = 'SE', size = 28),
     list(sets = list(1), label = 'Treat', size= 35),
     list(sets = list(2), label = 'Anti-CCP', size = 108),
     list(sets = list(3), label = 'DAS28', size=106),
     list(sets = c(0,1), size=1),
     list(sets = c(0,2), size=1),
     list(sets = c(0,3), size=14),
     list(sets = c(1,2), size=6),
     list(sets = c(1,3), size=0),
     list(sets = c(2,3), size=1),
     list(sets = c(0,2,3), size=1),
     list(sets = c(0,1,2), size=0),
     list(sets = c(0,1,3), size=0),
     list(sets = c(1,2,3), size=0),
     list(sets = c(0,1,2,3), size=0)
  )
  , tasks = list(
    htmlwidgets::JS('
function(){

var colours = ["black", "red", "blue", "green"];

d3.select(this).selectAll(".venn-circle path")
  .style("fill-opacity", 0)
  .style("stroke-width", 10)
  .style("stroke-opacity", .5)
  .style("stroke", function(d,i) { return colours[i]; });
d3.select(this).selectAll(".venn-circle text")
  .style("fill", function(d,i) { return colours[i]})
  .style("font-size", "24px")
  .style("font-weight", "100");
}
    ')
  )
)
styled_venn

styled_venn_inverted <- styled_venn
styled_venn_inverted$x$tasks <- list(
  htmlwidgets::JS('
function(){
d3.select(this).selectAll(".venn-circle path")
  .style("fill-opacity",0.8);

d3.select(this).selectAll("text")
  .style("fill","white");
}
  ')
)
styled_venn_inverted

styled_venn_mono <- styled_venn
styled_venn_mono$x$tasks <- list(
  htmlwidgets::JS('
function(){
  d3.select(this).selectAll(".venn-circle path")
    .style("fill-opacity", 0)
    .style("stroke-width", 2)
    .style("stroke", "#444");

  d3.select(this).selectAll("text")
    .style("fill", "#444");
}
  ')
)
styled_venn_mono

styled_venn_dropshadow <- styled_venn
styled_venn_dropshadow$x$tasks <- list(
  htmlwidgets::JS('
function(){
  var colours = d3.scale.category10();
  var areas = d3.select(this).selectAll("g")
  areas.select("path")
  .filter(function(d) { return d.sets.length == 1; })
  .style("fill-opacity", .1)
  .style("stroke-width", 5)
  .style("stroke-opacity", .8)
  .style("fill", function(d,i) { return colours(i); })
  .style("stroke", function(d,i) { return colours(i); });
  areas.select("text").style("fill", "#444")
  .style("font-family", "Shadows Into Light")
  .style("font-size", "22px");
  var defs = d3.select(this).select("svg").append("defs");
  // from http://stackoverflow.com/questions/12277776/how-to-add-drop-shadow-to-d3-js-pie-or-donut-chart
  var filter = defs.append("filter")
  .attr("id", "dropshadow")
  filter.append("feGaussianBlur")
  .attr("in", "SourceAlpha")
  .attr("stdDeviation", 4)
  .attr("result", "blur");
  filter.append("feOffset")
  .attr("in", "blur")
  .attr("dx", 5)
  .attr("dy", 5)
  .attr("result", "offsetBlur");
  var feMerge = filter.append("feMerge");
  feMerge.append("feMergeNode")
  .attr("in", "offsetBlur")
  feMerge.append("feMergeNode")
  .attr("in", "SourceGraphic");
  areas.attr("filter", "url(#dropshadow)");
}
  ')
)
styled_venn_dropshadow


## Adding tooltips from venn.js Readme.md
d3vennR(
  # data from venn.js examples
  #   https://github.com/benfred/venn.js/blob/master/examples/lastfm.jsonp
  data = list(
    list("sets"= list(0), "label"= "Radiohead", "size"= 77348),
    list("sets"= list(1), "label"= "Thom Yorke", "size"= 5621),
    list("sets"= list(2), "label"= "John Lennon", "size"= 7773),
    list("sets"= list(3), "label"= "Kanye West", "size"= 27053),
    list("sets"= list(4), "label"= "Eminem", "size"= 19056),
    list("sets"= list(5), "label"= "Elvis Presley", "size"= 15839),
    list("sets"= list(6), "label"= "Explosions in the Sky", "size"= 10813),
    list("sets"= list(7), "label"= "Bach", "size"= 9264),
    list("sets"= list(8), "label"= "Mozart", "size"= 3959),
    list("sets"= list(9), "label"= "Philip Glass", "size"= 4793),
    list("sets"= list(10), "label"= "St. Germain", "size"= 4136),
    list("sets"= list(11), "label"= "Morrissey", "size"= 10945),
    list("sets"= list(12), "label"= "Outkast", "size"= 8444),
    list("sets"= list(0, 1), "size"= 4832),
    list("sets"= list(0, 2), "size"= 2602),
    list("sets"= list(0, 3), "size"= 6141),
    list("sets"= list(0, 4), "size"= 2723),
    list("sets"= list(0, 5), "size"= 3177),
    list("sets"= list(0, 6), "size"= 5384),
    list("sets"= list(0, 7), "size"= 2252),
    list("sets"= list(0, 8), "size"= 877),
    list("sets"= list(0, 9), "size"= 1663),
    list("sets"= list(0, 10), "size"= 899),
    list("sets"= list(0, 11), "size"= 4557),
    list("sets"= list(0, 12), "size"= 2332),
    list("sets"= list(1, 2), "size"= 162),
    list("sets"= list(1, 3), "size"= 396),
    list("sets"= list(1, 4), "size"= 133),
    list("sets"= list(1, 5), "size"= 135),
    list("sets"= list(1, 6), "size"= 511),
    list("sets"= list(1, 7), "size"= 159),
    list("sets"= list(1, 8), "size"= 47),
    list("sets"= list(1, 9), "size"= 168),
    list("sets"= list(1, 10), "size"= 68),
    list("sets"= list(1, 11), "size"= 336),
    list("sets"= list(1, 12), "size"= 172),
    list("sets"= list(2, 3), "size"= 406),
    list("sets"= list(2, 4), "size"= 350),
    list("sets"= list(2, 5), "size"= 1335),
    list("sets"= list(2, 6), "size"= 145),
    list("sets"= list(2, 7), "size"= 347),
    list("sets"= list(2, 8), "size"= 176),
    list("sets"= list(2, 9), "size"= 119),
    list("sets"= list(2, 10), "size"= 46),
    list("sets"= list(2, 11), "size"= 418),
    list("sets"= list(2, 12), "size"= 146),
    list("sets"= list(3, 4), "size"= 5465),
    list("sets"= list(3, 5), "size"= 849),
    list("sets"= list(3, 6), "size"= 724),
    list("sets"= list(3, 7), "size"= 273),
    list("sets"= list(3, 8), "size"= 143),
    list("sets"= list(3, 9), "size"= 180),
    list("sets"= list(3, 10), "size"= 218),
    list("sets"= list(3, 11), "size"= 599),
    list("sets"= list(3, 12), "size"= 3453),
    list("sets"= list(4, 5), "size"= 977),
    list("sets"= list(4, 6), "size"= 232),
    list("sets"= list(4, 7), "size"= 250),
    list("sets"= list(4, 8), "size"= 166),
    list("sets"= list(4, 9), "size"= 97),
    list("sets"= list(4, 10), "size"= 106),
    list("sets"= list(4, 11), "size"= 225),
    list("sets"= list(4, 12), "size"= 1807),
    list("sets"= list(5, 6), "size"= 196),
    list("sets"= list(5, 7), "size"= 642),
    list("sets"= list(5, 8), "size"= 336),
    list("sets"= list(5, 9), "size"= 165),
    list("sets"= list(5, 10), "size"= 143),
    list("sets"= list(5, 11), "size"= 782),
    list("sets"= list(5, 12), "size"= 332),
    list("sets"= list(6, 7), "size"= 262),
    list("sets"= list(6, 8), "size"= 85),
    list("sets"= list(6, 9), "size"= 284),
    list("sets"= list(6, 10), "size"= 68),
    list("sets"= list(6, 11), "size"= 363),
    list("sets"= list(6, 12), "size"= 218),
    list("sets"= list(7, 8), "size"= 1581),
    list("sets"= list(7, 9), "size"= 716),
    list("sets"= list(7, 10), "size"= 133),
    list("sets"= list(7, 11), "size"= 254),
    list("sets"= list(7, 12), "size"= 132),
    list("sets"= list(8, 9), "size"= 280),
    list("sets"= list(8, 10), "size"= 53),
    list("sets"= list(8, 11), "size"= 117),
    list("sets"= list(8, 12), "size"= 67),
    list("sets"= list(9, 10), "size"= 57),
    list("sets"= list(9, 11), "size"= 184),
    list("sets"= list(9, 12), "size"= 89),
    list("sets"= list(10, 11), "size"= 51),
    list("sets"= list(10, 12), "size"= 115),
    list("sets"= list(11, 12), "size"= 162),
    list("sets"= list(0, 1, 6), "size"= 480),
    list("sets"= list(0, 1, 9), "size"= 152),
    list("sets"= list(0, 2, 7), "size"= 112),
    list("sets"= list(0, 3, 4), "size"= 715),
    list("sets"= list(0, 3, 12), "size"= 822),
    list("sets"= list(0, 4, 5), "size"= 160),
    list("sets"= list(0, 5, 11), "size"= 292),
    list("sets"= list(0, 6, 12), "size"= 122),
    list("sets"= list(0, 7, 11), "size"= 118),
    list("sets"= list(0, 9, 10), "size" =13),
    list("sets"= list(2, 7, 8), "size"= 72)
  )
  , tasks = list(
      htmlwidgets::JS('
function(){
var div = d3.select(this);

// add a tooltip
var tooltip = d3.select("body").append("div")
  .attr("class", "venntooltip");

// add listeners to all the groups to display tooltip on mousover
div.selectAll("g")
.on("mouseover", function(d, i) {

  // sort all the areas relative to the current item
  venn.sortAreas(div, d);

  // Display a tooltip with the current size
  tooltip.transition().duration(400).style("opacity", .9);
  tooltip.text(d.size + " users");

  // highlight the current path
  var selection = d3.select(this).transition("tooltip").duration(400);
  selection.select("path")
  .style("stroke-width", 3)
  .style("fill-opacity", d.sets.length == 1 ? .4 : .1)
  .style("stroke-opacity", 1);
})

.on("mousemove", function() {
  tooltip.style("left", (d3.event.pageX) + "px")
  .style("top", (d3.event.pageY - 28) + "px");
})

.on("mouseout", function(d, i) {
  tooltip.transition().duration(400).style("opacity", 0);
  var selection = d3.select(this).transition("tooltip").duration(400);
  selection.select("path")
  .style("stroke-width", 0)
  .style("fill-opacity", d.sets.length == 1 ? .25 : .0)
  .style("stroke-opacity", 0);
});
}
      ')
  )
)


## MDS Layout from venn.js Readme.md

d3vennR(
  data = list(
    list(sets= list('A'), size= 9),
    list(sets= list('B'), size= 15),
    list(sets= list('C'), size= 8),
    list(sets= list('D'), size= 6),
    list(sets= list('E'), size= 9),
    list(sets= list('F'), size= 9),
    list(sets= list('A','B'), size= 3),
    list(sets= list('A','C'), size= 0),
    list(sets= list('A','D'), size= 0),
    list(sets= list('A','E'), size= 0),
    list(sets= list('A','F'), size= 3),
    list(sets= list('B','C'), size= 3),
    list(sets= list('B','D'), size= 2),
    list(sets= list('B','E'), size= 0),
    list(sets= list('B','F'), size= 3),
    list(sets= list('C','D'), size= 2),
    list(sets= list('C','E'), size= 0),
    list(sets= list('C','F'), size= 0),
    list(sets= list('D','E'), size= 1),
    list(sets= list('D','F'), size= 0),
    list(sets= list('E','F'), size= 1)
  )
  ,layoutFunction = '
function(d) { return venn.venn(d, { initialLayout: venn.classicMDSLayout });}
  '
)
