YoutubePaneView = require './youtube-pane-view'


{CompositeDisposable} = require 'atom'

module.exports = YoutubePane =
  youtubePaneView: null
  modalPanel: null
  subscriptions: null
  enlarged : false
  youtubePane: null

  activate: (state) ->
    @youtubePaneView = new YoutubePaneView(state.youtubePaneViewState)
    @modalPanel = atom.workspace.addRightPanel(item: @youtubePaneView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'youtube-pane:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'youtube-pane:enlarge': => @enlarge()

    #Create the Youtube Webview
    webview = document.createElement("webview");
    webview.setAttribute("src", "http://www.youtube.com/")
    webview.setAttribute("id", "youtube-pane")

    #Append it to the right panel
    @youtubePane = document.getElementsByClassName("youtube")[0]
    @youtubePane.appendChild(webview)

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
    console.log(@youtubePane)

    if @enlarged == false
      #@youtubePane.setAttribute('width', width * 2)
      #@youtubePane.setAttribute('height', height * 2)
      @enlarged = true
    else
      #@youtubePane.setAttribute('width', width / 2)
      #@youtubePane.setAttribute('height', height / 2)
      @enlarged = false
