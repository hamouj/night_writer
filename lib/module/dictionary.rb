module Dictionary 
  def lowercase_english_to_braille_dictionary
    b1 = ".."
    b2 = "0."
    b3 = ".0"
    b4 = "00"

    lowercase_dictionary = {
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
    }
  end

  def lowercase_braille_to_english_dictionary
    lowercase_braille_to_english_dictionary = {}
    lowercase_english_to_braille_dictionary.invert.each {|braille, letter| lowercase_braille_to_english_dictionary[braille.join] = letter}
    lowercase_braille_to_english_dictionary
  end

  def number_english_to_braille_dictionary
    b1 = ".."
    b2 = "0."
    b3 = ".0"
    b4 = "00"

    number_dictionary = {
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

  def number_braille_to_english_dictionary
    number_braille_to_english_dictionary = {}
    number_english_to_braille_dictionary.invert.each {|braille, number| number_braille_to_english_dictionary[braille.join] = number}
    number_braille_to_english_dictionary
  end

  def uppercase_english_to_braille_dictionary
    b1 = ".."
    b2 = "0."
    b3 = ".0"
    b4 = "00"

    uppercase_dictionary = {
      "A" => [b2, b1,b1],
      "B" => [b2, b2, b1],
      "C" => [b4, b1, b1],
      "D" => [b4, b3, b1],
      "E" => [b2, b3, b1],
      "F" => [b4, b2, b1],
      "G" => [b4, b4, b1],
      "H" => [b2, b4, b1],
      "I" => [b3, b2, b1],
      "J" => [b3, b4, b1],
      "K" => [b2, b1, b2],
      "L" => [b2, b2, b2],
      "M" => [b4, b1, b2],
      "N" => [b4, b3, b2],
      "O" => [b2, b3, b2],
      "P" => [b4, b2, b2],
      "Q" => [b4, b4, b2],
      "R" => [b2, b4, b2],
      "S" => [b3, b2, b2],
      "T" => [b3, b4, b2],
      "U" => [b2, b1, b4],
      "V" => [b2, b2, b4],
      "W" => [b3, b4, b3],
      "X" => [b4, b1, b4],
      "Y" => [b4, b3, b4],
      "Z" => [b2, b3, b4],
      "capital" => [b1, b1, b3]
    }
  end

  def uppercase_braille_to_english_dictionary
    uppercase_braille_to_english_dictionary = {}
    uppercase_english_to_braille_dictionary.invert.each {|braille, letter| uppercase_braille_to_english_dictionary[braille.join] = letter}
    uppercase_braille_to_english_dictionary
  end
end