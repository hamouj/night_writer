class ContentReader
  attr_reader :english_text,  
              :braille_text,
              :content

  def initialize(locations)
    @english_text = locations[:english_text]
    @braille_text = locations[:braille_text]
    @character_count = @english_text.size
    @content = IO.readlines(@english_text,40)
  end

  def confirmation_message
    "Created #{ARGV[1]} containing #{@character_count} characters"
  end

  def split_content
    split_content = []
    content.each do |line|
      split_content << line.split(//)
    end
    split_content
  end
end