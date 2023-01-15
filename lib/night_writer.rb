require './lib/content_reader'
require './lib/english_translator'

if File.exist?(ARGV[0])
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
else 
  p "That file doesn't exist. Type in the name of an existing file for translation."
end