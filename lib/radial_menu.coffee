Arc = require "./arc.coffee"
Description = require "./description.coffee"

{MEDIUM} = require "./animation_speeds.coffee"

module.exports = ({radius, paper, items, title}) ->
  x = paper.width / 2
  y = paper.height / 2

  labelPercentage = 1 / items.length
  incrementAngleBy = 360 * labelPercentage

  createWedge = (label, index) ->
    startAngle = incrementAngleBy * index
    endAngle = startAngle + incrementAngleBy

    wedgeSet = paper.set()

    arc = Arc
      x: x
      y: y
      radius: radius
      start: startAngle
      end: endAngle

    wedge = paper.path(arc.path()).attr
      stroke: label.color?(index, items) || "#000"
      "stroke-width": 0

    wedgeSet.push(wedge)
    wedgeSet.animate {"stroke-width": radius}, MEDIUM, "backOut"

    [midX, midY] = arc.midpoint(1.05)

    icon = new Image
    icon.src = label.icon if label.icon

    icon.addEventListener "load", ->
      imageX = midX - (icon.width / 2)
      imageY = midY - (icon.height / 2)

      icon = paper.image(label.icon, imageX, imageY, icon.width, icon.height)
      icon.node.setAttribute("pointer-events", "none")
      wedgeSet.push(icon)

    wedge.mouseover ->
      wedgeSet.stop()
        .animate({transform: "s1.1 1.1 #{x} #{y}"}, MEDIUM, "elastic")

      description.color(wedge.attr("stroke"))
      description.actionName(label.name) if label.name

    wedge.click(label.action)

    wedge.mouseout ->
      wedgeSet.stop()
        .animate({transform: ""}, MEDIUM, "elastic")

      description.color("#fff")
      description.title()

  items.forEach(createWedge)

  description = Description
    paper: paper
    x: x
    y: y
    radius: radius
    title: title
    actions: items.map (menuItem) -> menuItem.name