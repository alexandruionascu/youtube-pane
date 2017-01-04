{View} = require '../node_modules/atom-space-pen-views'

module.exports =
class YoutubePanelView extends View
  @content: ->
    @div class: 'youtube-panel', =>
      @span id: 'youtube-panel'

  getElement: ->
    @element

  updatePanel: (name) ->
    panel = document.getElementById 'youtube-panel'
    panel.innerText = name
