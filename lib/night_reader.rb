require './lib/content_reader'

content_reader = ContentReader.new({
  english_text: ARGV[1],
  braille_text: ARGV[0]
})