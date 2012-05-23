# all? unicode whitespace characters
WHITESPACE = ///
  [
    \u0009\u000A\u000B\u000C\u000D\u0020\u0085\u00A0\u1680
    \u180E\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007
    \u2008\u2009\u200A\u2028\u2029\u202F\u205F\u3000
  ]+
///

DEBRIS = new XRegExp("[\\p{P}\\p{Sm}\\p{Sc}\\p{So}\\p{N}]", "g")
HYPHEN_APOSTROPHE = "'`-\u2018\u2019\u2010"

# Wordlist is a free-form list of words which has not (yet)
# been converted into a collection of Words. This corresponds
# to the wordlist entered into the wordlist form.
class Wordlist extends Backbone.Model
  url: '/api/v1/wordlist/1'

  defaults:
    id: 1 # only one

  initialize: ->

  toList: ->
    words = (@get 'wordlist').split WHITESPACE
    words = _.unique words
    _.reject words, (word) -> word is ''

  clean: ->
    @fromArray @toList().sort()

  fromArray: (ary) ->
    @set wordlist: ary.join '\n'

  cleanUpperCase: ->
    list = @toList()
    list = _.reject list, (word) ->
      hasUpperCase(word) and _.include list, word.toLowerCase()
    @fromArray list

  cleanDebris: ->
    wordlist = XRegExp.replace (@get 'wordlist'), DEBRIS, (match) ->
      if HYPHEN_APOSTROPHE.indexOf(match[0]) >= 0
        match[0]
      else
        ''
    @set {wordlist}
    @clean()

  resetWords: (words) ->
    list = _.map @toList(), (word) ->
      { name: word }
    words.reset(list)
