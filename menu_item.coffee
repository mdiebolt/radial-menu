{hsb} = require "raphael"

module.exports = ({name, icon}) ->
  {
    name: name
    icon: icon
    action: ->
      console.log "clicked on #{name}"
    color: (index, collection) ->
      hue = index / collection.length
      hsb(hue, 0.5, 1)
  }