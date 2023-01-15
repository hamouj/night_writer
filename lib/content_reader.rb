class ContentReader
  attr_reader :english_text,  
              :braille_text,
              :english_text_content,
              :braille_text_content

  def initialize(locations)
    @english_text = File.new(locations[:english_text], "a+")
    @braille_text = File.new(locations[:braille_text], "a+")
    @english_text_character_count = @english_text.size
    @english_text_content = File.readlines(@english_text,40)
    @braille_text_character_count = @braille_text.size / 6
    @braille_text_content = File.readlines(@braille_text,80)
  end

  def night_writer_confirmation_message
    "Created #{File.basename(@braille_text)} containing #{@english_text_character_count} characters"
  end

  def split_english_text_content
    english_text_split_content = english_text_content.map {|line| line.split(//)}
  end

  def night_reader_confirmation_message
    "Created #{File.basename(@english_text)} containing #{@braille_text_character_count} characters"
  end

  def split_braille_text_content
    set_of_twos = braille_text_content.map {|line| line.scan(/../)}
    split_letters = set_of_twos[0].zip(set_of_twos[1], set_of_twos[2])
    braille_split_content = split_letters.map {|letter| letter.join}
  end
end