class EnglishTranslator < ContentReader
  attr_reader  :line_1,
                :line_2,
                :line_3

  def initialize(locations)
    super(locations)
    @line_1 = []
    @line_2 = []
    @line_3 = []
  end

  def dictionary
    b1 = ".."
    b2 = "0."
    b3 = ".0"
    b4 = "00"

    dictionary = {
      "a" => [b2, b1,b1],
      "b" => [b2, b2, b1],
      "c" => [b4, b1, b1],
      "d" => [b4, b3, b1],
      "e" => [b2, b3, b1],
      "f" => [b4, b2, b1],
      "g" => [b4, b4, b1],
      "h" => [b2, b4, b1],
      "i" => [b3, b2, b1],
      "j" => [b3, b4, b1],
      "k" => [b2, b1, b2],
      "l" => [b2, b2, b2],
      "m" => [b4, b1, b2],
      "n" => [b4, b3, b2],
      "o" => [b2, b3, b2],
      "p" => [b4, b2, b2],
      "q" => [b4, b4, b2],
      "r" => [b2, b4, b2],
      "s" => [b3, b2, b2],
      "t" => [b3, b4, b2],
      "u" => [b2, b1, b4],
      "v" => [b2, b2, b4],
      "w" => [b3, b4, b3],
      "x" => [b4, b1, b4],
      "y" => [b4, b3, b4],
      "z" => [b2, b3, b4],
      " " => [b1, b1, b1],
      "1" => [b2, b1, b1],
      "2" => [b2, b2, b1],
      "3" => [b4, b1, b1],
      "4" => [b4, b3, b1],
      "5" => [b2, b3, b1],
      "6" => [b4, b2, b1],
      "7" => [b4, b4, b1],
      "8" => [b2, b4, b1],
      "9" => [b3, b2, b1],
      "0" => [b3, b4, b1],
      "#" => [b3, b3, b4]
    }
  end

  def translate_entire_text
    numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    braille_content = []

    split_english_text_content.each_with_index do |character, i|
      if numbers.include?(character) && numbers.include?(split_english_text_content[i-1])
        braille_content << dictionary[character]
      elsif numbers.include?(character) && !numbers.include?(split_english_text_content[i-1])
        braille_content << dictionary["#"]
        braille_content << dictionary[character]
      elsif dictionary.keys.include?(character)
        braille_content << dictionary[character]
      else
        next
      end
    end

    @line_1 = braille_content.transpose[0]
    @line_2 = braille_content.transpose[1]
    @line_3 = braille_content.transpose[2]
  end

  def translate
    translate_entire_text

    line_1 = @line_1.each_slice(40).to_a
    line_2 = @line_2.each_slice(40).to_a
    line_3 = @line_3.each_slice(40).to_a
    number_of_lines = line_1.size
    
    index = 0
    while index != number_of_lines
      braille_translation = "#{line_1[index].join}\n#{line_2[index].join}\n#{line_3[index].join}\n"
      braille_text.write(braille_translation)
      index += 1
    end
    braille_translation
  end
end