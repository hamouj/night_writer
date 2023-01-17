class ContentReader
  attr_reader :english_text,  
              :braille_text,
              :english_text_content,
              :braille_text_content

  def initialize(files)
    @english_text = files[:english_text]
    @braille_text = files[:braille_text]
    @english_text_character_count = @english_text.size
    @english_text_content = File.read(@english_text)
    @braille_text_character_count = @braille_text.size / 6
    @braille_text_content = File.readlines(@braille_text,80)
  end

  def night_writer_confirmation_message
    "Created #{File.basename(@braille_text)} containing #{@english_text_character_count} characters"
  end

  def split_english_text_content
    english_text_content.split(//)
  end

  def night_reader_confirmation_message
    "Created #{File.basename(@english_text)} containing #{@braille_text_character_count} characters"
  end

  def split_braille_letters
    set_of_twos = braille_text_content.map {|line| line.scan(/../)}.compact
    set_of_twos = set_of_twos.reject{|element| element.empty?}

    number_of_arrays = set_of_twos.size
    split_letters = []
    n = 0
    while n != number_of_arrays
      split_letters << set_of_twos[n].zip(set_of_twos[n+=1], set_of_twos[n+=1])
      n+=1
    end
    split_letters
  end

  def split_braille_text_content
    braille_split_content = split_braille_letters.map do |line|
      line.map do |letter|
        letter.join
      end
    end
    braille_split_content
  end
end