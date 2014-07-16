Raphael = require "raphael"
CoffeeScript = require "coffee-script"

RadialMenu = require "../lib/radial_menu.coffee"
MenuItem = require "./menu_item.coffee"

liveExample = (selector, sourceCode) ->
  execute = (source) ->
    $(".errors").text("").addClass("hidden")

    try
      compiledCode = CoffeeScript.compile(source, {bare: true})
      eval(compiledCode)
    catch e
      position = ""
      if l = e.location
        position = "on line #{l.first_line}, character #{l.first_column}"

      message = "#{e.message} #{position}"

      $(".errors").text(message).removeClass("hidden")

  $textarea = $("#{selector} textarea")

  $textarea.val(sourceCode)
  $textarea.keyup ->
    $("#{selector} .output").empty()
    execute $textarea.val()

  execute(sourceCode)

liveExample ".no-label", """
  canvas = Raphael("colors", 220, 220)
  RadialMenu
    radius: 65
    items: [0...8].map(MenuItem)
    paper: canvas
"""

liveExample ".labelled", """
  canvas = Raphael("commands", 220, 220)
  RadialMenu
    radius: 65
    items: ["Undo", "Redo", "Save"].map (command) ->
      MenuItem
        name: command
    title: "Commands"
    paper: canvas
"""

liveExample ".icons", """
  canvas = Raphael("languages", 220, 220)
  RadialMenu
    radius: 65
    items: ["Ruby", "CoffeeScript", "Python", "Go", "Haskell"].map (name) ->
      MenuItem
        name: name
        icon: "images/" + name + ".png"
    title: "Languages"
    paper: canvas
"""
