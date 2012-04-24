# all? unicode whitespace characters
WHITESPACE = ///
  [
    \u0009\u000A\u000B\u000C\u000D\u0020\u0085\u00A0\u1680
    \u180E\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007
    \u2008\u2009\u200A\u2028\u2029\u202F\u205F\u3000
  ]+
///

class Wordlist extends Backbone.Model
  initialize: ->
    console.log "wordlist hai"

  toList: ->
    _.unique (@get 'wordlist').split WHITESPACE

  clean: ->
    @set wordlist: (@toList().join '\n')+'\n'

KEY_DEBOUNCE_WAIT = 300

class WordlistView extends TemplateView
  template: 'segmenter/wordlist'
  events:
    "keyup #wordlist": "onKeyUp"
    "click #wordlist-clean": "onClickClean"

  initialize: ->
    @onKeyUp = _.debounce @onKeyUp, KEY_DEBOUNCE_WAIT

    @model.bind 'change', @onChange, @

  onRawKeyUp: ->
    @onKeyUp()

  onKeyUp: ->
    console.log "hai here"
    @model.set wordlist: (@$ '#wordlist').val()

  onChange: ->
    (@$ '#wordlist').val @model.get 'wordlist'
    console.log "updated"

  onClickClean: ->
    @model.clean()


class WordlistPageView extends Backbone.View
  initialize: ->
    @wordlistView = new WordlistView { @model }

  render: ->
    ($ @el).append @wordlistView.render().el
    @
