require './lib/module/dictionary'
class EnglishTranslator < ContentReader
  include Dictionary

  attr_reader  :line_1,
                :line_2,
                :line_3

  def initialize(locations)
    super(locations)
    @line_1 = []
    @line_2 = []
    @line_3 = []
    @lowercase_dictionary = lowercase_english_to_braille_dictionary
    @number_dictionary = number_english_to_braille_dictionary
  end

  def translate_entire_text
    numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    braille_content = []

    split_english_text_content.each_with_index do |character, i|
      if numbers.include?(character) && numbers.include?(split_english_text_content[i-1])
        braille_content << @number_dictionary[character]
      elsif numbers.include?(character) && !numbers.include?(split_english_text_content[i-1])
        braille_content << @number_dictionary["#"]
        braille_content << @number_dictionary[character]
      elsif @lowercase_dictionary.keys.include?(character)
        braille_content << @lowercase_dictionary[character]
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