class ContentReader
  attr_reader :english_text, :braille_text

  def initialize(locations)
    @english_text = File.open(locations[:english_text], "r")
    @braille_text = File.open(locations[:braille_text], "w")
  end
end