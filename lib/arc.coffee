{cos, sin} = Math
{rad} = require "raphael"

orientAngle = (angle) ->
  rad(90 - angle)

module.exports = ({x, y, radius, start, end}) ->
  pointOnArc = (angle, distance) ->
    [
      x + distance * cos(angle)
      y - distance * sin(angle)
    ]

  startAngle = orientAngle(start)
  endAngle = orientAngle(end)

  from = pointOnArc(startAngle, radius)
  to = pointOnArc(endAngle, radius)

  self =
    midpoint: (scale) ->
      midAngle = (startAngle + endAngle) / 2
      pointOnArc(midAngle, radius * scale)

    path: ->
      [
        "M #{from}"
        "A #{radius} #{radius} 0 0 1 #{to}"
      ]
