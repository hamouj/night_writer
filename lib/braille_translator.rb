require './lib/content_reader'
require './lib/module/dictionary'

class BrailleTranslator < ContentReader
  include Dictionary

  def initialize(locations)
    super(locations)
    @lowercase_dictionary = lowercase_braille_to_english_dictionary
    @number_dictionary = number_braille_to_english_dictionary
    @uppercase_dictionary = uppercase_braille_to_english_dictionary
  end

  def translate_a_line(line)
    line_translation = []
    index_condition = [nil, "......"]
   
    index = 0
    line.each do |character|
      if character == ".0.000"
        index += 1
        while !index_condition.include?(line[index])
          line_translation << @number_dictionary[line[index]]
          line[index].clear
          index += 1
        end
      elsif character == ".....0"
        index += 1
        line_translation << @uppercase_dictionary[line[index]]
        line[index].clear
      elsif @lowercase_dictionary.include?(character)
        line_translation << @lowercase_dictionary[character]
      else
        next
      end
    index += 1
    end
    line_translation.join
  end

  def translate
    split_content = split_braille_text_content

    message = ""
    split_content.each do |line|
      message = translate_a_line(line)
      @english_text.write("#{message}\n")
    end
    message
  end
end