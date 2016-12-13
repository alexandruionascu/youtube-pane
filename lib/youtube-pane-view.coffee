{View} = require '../node_modules/atom-space-pen-views'

module.exports =
class YoutubePaneView extends View
  @content: ->
    @div class:'styleguide padded pane-item native-key-bindings' , =>
      @div class: 'youtube' 

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
