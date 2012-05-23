Handlebars.registerHelper 'link_to', (context) ->
  "<a href='#{context.url}'>#{context.body}</a>"

Handlebars.registerHelper 'each_pair', (context, options) ->
  (_.map context, (value,key) -> (options.fn {key, value})).join ""

# Handlebars.registerHelper 'each', (context, options) ->
#   (_.map context, (value) -> (options.fn {value})).join ""
