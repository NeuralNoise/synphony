# This is a hack to generate the data for the guiding test of the tangerine export
# feature. As such no effort was made to make this code pretty. Sorry.

require 'yajl'
require 'pp'

MAX_WORDS_PER_LESSON = 20
GPCS_PER_LESSON = 3
CURRICULUM_ID = "test_curriculum_id"

path = File.join(File.dirname(__FILE__), '..', 'data')
jsonp = File.read(File.join(path, 'tok_pisin.jsonp'))
# remove the javascript part so we just have pure json
jsonp.gsub! /\AbootstrapData\('DB',|\)\s*\Z/, ""

db = Yajl.load jsonp

gpc_sequence = db['sequences'][0]['elements'].map {|element| element['gpc']}

# getFocusItems: (focusGPCs, list = @models) ->
#   _.filter list, (model) ->
#     modelGPCs = model.gpcs()
#     _.any modelGPCs, (modelGPC) ->
#       _.any focusGPCs, (focusGPC) ->
#         focusGPC.id == modelGPC.id
def get_focus_words(focus_list, words)
  words.select do |word|
    focus_list.any? do |focus|
      word['gpcs'].include? focus
    end
  end
end

# getKnownItems: (knownGPCs, list = @models) ->
#   _.filter list, (model) ->
#     modelGPCs = model.gpcs()
#     _.all modelGPCs, (modelGPC) ->
#       _.any knownGPCs, (knownGPC) ->
#         knownGPC.id == modelGPC.id
def get_known_words(known_list, words)
  words.select do |word|
    word['gpcs'].all? do |gpc|
      known_list.include? gpc
    end
  end
end

# getKnownFocusItems: (knownGPCs, focusGPCs, list = @models) ->
#   models = @getFocusItems focusGPCs, list
#   @getKnownItems knownGPCs, models
def get_known_focus_words(known_list, focus_list, db)
  words = get_focus_words(focus_list, db['words'])
  get_known_words(known_list, words)
end

known_gpcs = []
sequence_words = []
subtests = []
number = 0
gpc_sequence.each_slice(GPCS_PER_LESSON) do |focus_gpcs|
  number += 1
  known_gpcs.concat focus_gpcs
  words = get_known_focus_words(known_gpcs, focus_gpcs, db)

  # words sorted by most frequent then shortest length
  words.sort_by! {|word| [word['frequency'] || 0, -word['name'].length]}
  words.reverse!

  # then only take the first 20 words
  words = words[0...MAX_WORDS_PER_LESSON].map {|word| word['name']}

  # convert focus_gpcs into grapheme names
  graphemes = focus_gpcs.map do |gpc_id|
    gpc = db['gpcs'].find {|gpc| gpc['_id'] == gpc_id}
    grapheme = db['graphemes'].find {|grapheme| grapheme['_id'] == gpc['grapheme']}
    grapheme['name']
  end

  puts "\nSpelling Patterns: #{graphemes.join ', '}"
  puts "Words: #{words.join ', '}"

  subtests << {
    "collection" => "subtest",
    "prototype" => "grid",
    "curriculumID" => CURRICULUM_ID,
    "lesson" => number,
    "variableName" => "spellingPatterns",
    "name" => "Spelling Patterns",
    "items" => graphemes
  }

  subtests << {
    "collection" => "subtest",
    "prototype" => "grid",
    "curriculumID" => CURRICULUM_ID,
    "lesson" => number,
    "variableName" => "familiarWords",
    "name" => "Familiar Words",
    "items" => words
  }
end

File.open(File.join(path, 'tangerine_subtests.jsonp'), "w") do |fp|
  json = Yajl.dump subtests, :pretty => true
  fp.write "bootstrapData('TANGERINE_SUBTESTS',#{json})"
end
