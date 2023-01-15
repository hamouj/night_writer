require './lib/content_reader'
require './lib/english_translator'

english_text = File.open(ARGV[0], "r")
braille_text = File.open(ARGV[1], "w")

files = {
  english_text: english_text,
  braille_text: braille_text
}

content_reader = ContentReader.new(files)
english_translator = EnglishTranslator.new(files)

english_translator.translate

p content_reader.night_writer_confirmation_message