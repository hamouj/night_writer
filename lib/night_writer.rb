require './lib/content_reader'
require './lib/english_translator'

content_reader = ContentReader.new({
  english_text: ARGV[0],
  braille_text: ARGV[1]
})

english_translator = EnglishTranslator.new({  
  english_text: ARGV[0],
  braille_text: ARGV[1]
})

english_translator.translate

p content_reader.night_writer_confirmation_message