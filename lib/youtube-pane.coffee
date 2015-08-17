window.$ = window.jQuery = require('../node_modules/jquery')
YoutubePaneView = require './youtube-pane-view'


{CompositeDisposable} = require 'atom'

module.exports = YoutubePane =
  youtubePaneView: null
  modalPanel: null
  subscriptions: null
  enlarged : false

  activate: (state) ->
    @youtubePaneView = new YoutubePaneView(state.youtubePaneViewState)
    @modalPanel = atom.workspace.addRightPanel(item: @youtubePaneView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'youtube-pane:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'youtube-pane:enlarge': => @enlarge()

    $(document).ready ->
      height = $(window).height()
      console.log height
      width = $(window).width()
      $('.youtube').width(width / 3)
      $('.youtube').append('<webview id="youtube-pane" src="https:/m.youtube.com/" style="display:inline-block; float: right; width:' + width / 3 +'px; height:' + height + 'px;"></webview>')
      $(window).on 'resize' , ->
        height = $(window).height()
        width = $(window).width()
        $('.youtube').width(width / 3)
        $('.youtube').height(height)
        $('#youtube-pane').width(width / 3)
        $('#youtube-pane').height(height)



  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @youtubePaneView.destroy()

  serialize: ->
    youtubePaneViewState: @youtubePaneView.serialize()

  toggle: ->
    console.log 'YoutubePane was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  enlarge: ->
    if @enlarged == false
      $('#youtube-pane').width($(window).width() / 2)
      $('.youtube').width($(window).width() / 2)
      @enlarged = true
    else
      $('#youtube-pane').width($(window).width() / 3)
      $('.youtube').width($(window).width() / 3)
      @enlarged = false
