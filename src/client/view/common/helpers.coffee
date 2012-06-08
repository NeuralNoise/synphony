define ['underscore', 'handlebars'], (_, Handlebars) ->
  helpers =
    link_to: (context) ->
      "<a href='#{context.url}'>#{context.body}</a>"

    each_pair: (context, options) ->
      (_.map context, (value,key) -> (options.fn {key, value})).join ""

  for name, func of helpers
    Handlebars.registerHelper name, func

  helpers
