require './lib/content_reader'
require './lib/english_translator'


file_paths = {
  english_text: ARGV[0],
  braille_text: ARGV[1]
}

content_reader = ContentReader.new(file_paths)
english_translator = EnglishTranslator.new(file_paths)

english_translator.translate

p content_reader.night_writer_confirmation_message