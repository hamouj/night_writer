require './lib/content_reader'
require './lib/english_translator'

english_text = File.open(ARGV[0], "r")
braille_text = File.open(ARGV[1], "w")

content_reader = ContentReader.new({
  english_text: english_text,
  braille_text: braille_text
})

english_translator = EnglishTranslator.new({  
  english_text: english_text,
  braille_text: braille_text
})

english_translator.translate

p content_reader.night_writer_confirmation_message