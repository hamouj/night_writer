require './lib/content_reader'
require './lib/braille_translator'

english_text = File.open(ARGV[1], "w")
braille_text = File.open(ARGV[o], "r")

files = {
  english_text: english_text,
  braille_text: braille_text
}

content_reader = ContentReader.new(files)
braille_translator = BrailleTranslator.new(files)

braille_translator.translate

p content_reader.night_reader_confirmation_message