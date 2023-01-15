require './lib/content_reader'
require './lib/braille_translator'

file_paths = {
  english_text: ARGV[1],
  braille_text: ARGV[0]
}

content_reader = ContentReader.new(file_paths)
braille_translator = BrailleTranslator.new(file_paths)

braille_translator.translate

p content_reader.night_reader_confirmation_message