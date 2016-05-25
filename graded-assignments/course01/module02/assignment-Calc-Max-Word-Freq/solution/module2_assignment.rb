class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = []
    self.calculate_word_frequency
  end

  def calculate_word_frequency
    counter = Hash.new(0)
    @content.split().each do |word|
      counter[word] += 1
      if counter[word] > @highest_wf_count
        @highest_wf_count = counter[word]
        @highest_wf_words = [word]
      elsif counter[word] == @highest_wf_count
        @highest_wf_words += [word]
      end
    end
  end
end

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end

  def analyze_file
    File.open("test.txt", 'r').each do |line|
      @analyzers.push(LineAnalyzer.new(line.downcase, @analyzers.length))
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_across_lines = 0
    @analyzers.each do |analyzer|
      @highest_count_across_lines = [@highest_count_across_lines, analyzer.highest_wf_count].max
    end
    @highest_count_words_across_lines = @analyzers.select {|analyzer| analyzer.highest_wf_count == @highest_count_across_lines}
  end

  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each do |analyzer|
      puts "#{analyzer.highest_wf_words} (appear in line #{analyzer.line_number})"
    end
  end
end
