{MEDIUM, FAST} = require "./animation_speeds.coffee"

fitText = (text, container, maxPercentage=0.7) ->
  if text.attr("text").length
    while text.getBBox().width < container.getBBox().width * maxPercentage
      currentSize = text.attr("font-size")

      text.attr
        "font-size": currentSize + 1
  else
    text.attr
      "font-size": 0

module.exports = ({paper, x, y, radius, title, actions}) ->
  longestAction = ->
    actions.reduce (memo, action) ->
      memo = action if action?.length > memo.length
      memo
    , ""

  autosize = ->
    fitText(menuLabel, center)

    actionLabel.attr
      text: longestAction()

    fitText(actionLabel, center)

  center = paper.circle(x, y, radius * 0.5).attr
    fill: "#fff"
    stroke: "none"
    transform: "s3.3"
  .animate {transform: "s1.3"}, MEDIUM, "backOut", autosize

  clipRect = ->
    "#{x - radius / 2} #{y - radius / 2} #{radius} #{radius}"

  labelAttrs =
    fill: "#000"
    stroke: "none"
    "font-size": 0
    "clip-rect": clipRect()

  menuLabel = paper.text(x, y, title || "")
    .attr(labelAttrs)

  actionLabel = paper.text(x, y, "")
    .attr(labelAttrs)
    .attr { transform: "t100 0" }

  animate = (label, {x, opacity}) ->
    attrs =
      transform: "t#{x} 0"
      opacity: opacity

    label.stop()
      .animate(attrs, FAST, "linear")

  self =
    color: (color) ->
      center.stop()
        .animate {fill: color}, FAST, "linear"
    actionName: (actionName) ->
      animate menuLabel,
        x: -radius * 2
        opacity: 0

      actionLabel.attr
        text: actionName

      animate actionLabel,
        x: 0
        opacity: 1
    title: ->
      animate menuLabel,
        x: 0
        opacity: 1

      animate actionLabel,
        x: radius * 2
        opacity: 0
