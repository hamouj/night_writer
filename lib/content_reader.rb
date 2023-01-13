class ContentReader
  attr_reader :english_text,  
              :braille_text

  def initialize(locations)
    @english_text = File.open(locations[:english_text], "r")
    @braille_text = File.open(locations[:braille_text], "w")
    @character_count = @english_text.size
  end

  def confirmation_message
    "Created #{ARGV[1]} containing #{@character_count} characters"
  end
end