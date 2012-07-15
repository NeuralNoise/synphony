define [], ()->
  # CURRENTLY NOT USED.

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
      "click #wordlist-clean-uppercase": "onClickCleanUpperCase"
      "click #wordlist-clean-debris": "onClickCleanDebris"

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

    # when someone clicks the clean uppercase button, call cleanUpperCase() on the model
    onClickCleanUpperCase: ->
      @model.cleanUpperCase()

    onClickCleanDebris: ->
      @model.cleanDebris()

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
