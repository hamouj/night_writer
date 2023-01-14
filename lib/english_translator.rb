class EnglishTranslator < ContentReader

  def initialize(locations)
    super(locations)
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
      " " => [b1, b1, b1]
    }
  end

  def translate
    number_of_lines = content.size
    english_text_split_content = split_content

    line_1 = []
    line_2 = []
    line_3 = []
    
    n=0
    while n != number_of_lines
    english_text_split_content[n].each do |character|
      dictionary.each do |letter, braille|
        if character == letter
          line_1 << "#{braille[0]}"
          line_2 << "#{braille[1]}"
          line_3 << "#{braille[2]}"
        end
      end
    end
    braille_translation = "#{line_1.join}\n#{line_2.join}\n#{line_3.join}\n"
    braille_text.write(braille_translation)
    line_1.clear
    line_2.clear
    line_3.clear
    n+=1
    end
    braille_translation
  end
end