path = require 'path'
http = require 'http'
url = require 'url'
fs = require 'fs'

CODE_CATEGORIES =
  "Cc": ["Other", "Control"]
  "Cf": ["Other", "Format"]
  "Cn": ["Other", "Not Assigned"]
  "Co": ["Other", "Private Use"]
  "Cs": ["Other", "Surrogate"]
  "LC": ["Letter", "Cased"]
  "Ll": ["Letter", "Lowercase"]
  "Lm": ["Letter", "Modifier"]
  "Lo": ["Letter", "Other"]
  "Lt": ["Letter", "Titlecase"]
  "Lu": ["Letter", "Uppercase"]
  "Mc": ["Mark", "Spacing Combining"]
  "Me": ["Mark", "Enclosing"]
  "Mn": ["Mark", "Nonspacing"]
  "Nd": ["Number", "Decimal Digit"]
  "Nl": ["Number", "Letter"]
  "No": ["Number", "Other"]
  "Pc": ["Punctuation", "Connector"]
  "Pd": ["Punctuation", "Dash"]
  "Pe": ["Punctuation", "Close"]
  "Pf": ["Punctuation", "Final quote"]
  "Pi": ["Punctuation", "Initial quote"]
  "Po": ["Punctuation", "Other"]
  "Ps": ["Punctuation", "Open"]
  "Sc": ["Symbol", "Currency"]
  "Sk": ["Symbol", "Modifier"]
  "Sm": ["Symbol", "Math"]
  "So": ["Symbol", "Other"]
  "Zl": ["Separator", "Line"]
  "Zp": ["Separator", "Paragraph"]
  "Zs": ["Separator", "Space"]

CATEGORY_CODES = {}

for own code, [supercategory, subcategory] of CATEGORY_CODES
  CATEGORY_CODES[supercategory] or= {}
  CATEGORY_CODES[supercategory][subcategory] = code

UNICODE_DATA_URL = "http://www.unicode.org/Public/UNIDATA/UCD.zip"
UNICODE_DATA_FILE = path.normalize "#{__dirname}/../../data/UnicodeData.txt"

# Taken from node-unicode, which was taken from:
# http://www.ksu.ru/eng/departments/ktk/test/perl/lib/unicode/UCDFF301.html
# camelCased by me
UNICODE_DATA_COLUMNS = ['value', 'name', 'category', 'class',
    'bidirectionalCategory', 'mapping', 'decimalDigitValue', 'digitValue',
    'numericValue', 'mirrored', 'unicodeName', 'comment', 'uppercaseMapping',
    'lowercaseMapping', 'titlecaseMapping']

parse = (text, callback) ->
  for line in text.split "\n"
    columns = line.split ";"
    data = {}
    for [key, value] in _.zip UNICODE_DATA_COLUMNS, columns
      data[key] = value
    data.category_code = data.category
    data.category = CODE_CATEGORIES[data.category]
    



module.exports.run = (callback) ->
  if path.existsSync UNICODE_DATA_FILE
    fs.readFile UNICODE_DATA_FILE, 'utf8', (err, text) ->
      if err?
        callback new Error "Error reading file: #{err}: #{UNICODE_DATA_FILE}"
      else
        parse text, callback
  else
    console.log "Downloading #{UNICODE_DATA_URL} (could take a while)..."
    req = http.get (url.parse UNICODE_DATA_URL), (res) ->
      if res.statusCode isnt 200
        callback new Error "HTTP ERROR: #{res.statusCode} fetching #{UNICODE_DATA_URL}"
      else
        res.setEncoding 'utf8'
        text = ""
        res.on 'data', (data) ->
          text += data
        res.on 'end', ->
          fs.writeFile UNICODE_DATA_FILE, text, 'utf8', (err) ->
            if err?
              console.log "Warning: #{err}: unable to write to: #{UNICODE_DATA_FILE}"
            parse text, callback
    req.on 'error', (err) ->
      callback new Error "HTTP ERROR: #{res.statusCode} fetching #{UNICODE_DATA_URL}"




