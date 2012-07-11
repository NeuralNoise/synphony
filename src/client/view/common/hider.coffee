define ['view/common/base'], (BaseView) ->
  # Hides something when rendered, and shows it again
  # when destroyed.
  class HiderView extends BaseView
    constructor: (options) ->
      super options
      @selector = options.selector

    render: ->
      ($ @selector).hide()

    destroy: ->
      ($ @selector).show()
      super()
