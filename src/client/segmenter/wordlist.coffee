# all? unicode whitespace characters
WHITESPACE = ///
  [
    \u0009\u000A\u000B\u000C\u000D\u0020\u0085\u00A0\u1680
    \u180E\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007
    \u2008\u2009\u200A\u2028\u2029\u202F\u205F\u3000
  ]+
///

# Wordlist is a free-form list of words which has not (yet)
# been converted into a collection of Words. This corresponds
# to the wordlist entered into the wordlist form.
class Wordlist extends Backbone.Model
  url: '/api/v1/wordlist/1'

  defaults:
    id: 1 # only one

  initialize: ->
    console.log "wordlist hai"

  toList: ->
    words = (@get 'wordlist').split WHITESPACE
    words = _.unique words
    _.reject words, (word) -> word is ''

  clean: ->
    @set wordlist: @toList().join '\n'

# amount of time to wait for keystrokes to stop coming in before we
# update the model
KEY_DEBOUNCE_WAIT = 400

# amount of time to wait for save requests to stop coming in before
# we ask the model to save
SAVE_DEBOUNCE_WAIT = 1000

# View for the wordlist form.
class WordlistView extends TemplateView
  template: 'segmenter/wordlist'

  events:
    "keyup #wordlist": "onKeyUp"
    "click #wordlist-clean": "onClickClean"

  initialize: ->
    # debounce keyup messages so as not to spam the model with updates
    @onKeyUp = _.debounce @onKeyUp, KEY_DEBOUNCE_WAIT

    # debounce save so as not to spam server with requests
    @save = _.debounce @save, SAVE_DEBOUNCE_WAIT

    @model.on 'change', @onModelChange, @
    @model.on 'sync', @onModelSaved, @

  # when the form is updated, set the wordlist on the model to the
  # text box contents
  onKeyUp: ->
    newValue = (@$ '#wordlist').val()
    oldValue = @model.get 'wordlist'
    @model.set wordlist: newValue
    if newValue isnt oldValue
      @save()

  # When the model changes update the text box contents to match
  onModelChange: ->
    oldValue = (@$ '#wordlist').val()
    newValue = @model.get 'wordlist'
    (@$ '#wordlist').val newValue
    if oldValue isnt newValue and oldValue isnt ''
      @save()

  # when someone clicks the clean button, call clean() on the model
  onClickClean: ->
    @model.clean()

  # save the model
  save: ->
    @model.save()

  # when model is saved briefly flash a message to the user
  onModelSaved: ->
    ($ '#wordlist-saved').fadeIn(50).delay(1000).fadeOut(500)
    console.log "Wordlist saved"


# View for the wordlist page
class WordlistPageView extends Backbone.View
  initialize: ->
    @wordlistView = new WordlistView { @model }

  render: ->
    ($ @el).append @wordlistView.render().el
    @
