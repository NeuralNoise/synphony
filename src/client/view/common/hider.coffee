define ['view/common/base'], (BaseView) ->
  # Hides something when rendered, and shows it again
  # when destroyed. Useful for hiding parts of the page
  # that aren't needed in the current interface.
  class HiderView extends BaseView
    constructor: (options) ->
      super options
      @selector = options.selector

    render: ->
      ($ @selector).hide()

    destroy: ->
      ($ @selector).show()
      super()
