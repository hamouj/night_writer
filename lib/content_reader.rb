class ContentReader
  attr_reader :english_text,  
              :braille_text,
              :english_text_content

  def initialize(locations)
    @english_text = File.open(locations[:english_text], "r+")
    @braille_text = File.open(locations[:braille_text], "r+")
    @english_text_character_count = @english_text.size
    @english_text_content = IO.readlines(@english_text,40)
    @braille_text_character_count = @braille_text.size / 6
  end

  def night_writer_confirmation_message
    "Created #{ARGV[1]} containing #{@english_text_character_count} characters"
  end

  def split_english_text_content
    english_text_split_content = []
    english_text_content.each do |line|
      english_text_split_content << line.split(//)
    end
    english_text_split_content
  end

  def night_reader_confirmation_message
    "Created #{ARGV[1]} containing #{@braille_text_character_count} characters"
  end
end