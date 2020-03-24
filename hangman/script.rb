class Hangman
  GAME_OVER_ERROR = 'game over, restart play'.freeze
  NO_LIVES_CATCH_ERROR = 'whomp! whomp!!, start another game'.freeze
  CHAR_NOT_FOUND = 'char not found'.freeze
  SUCCESS_MESSAGE = 'you guessed the word correctly, play again'
  MUST_ENTER_LIVES = 'you must enter number of lives'

  def initialize(lives:)
    print MUST_ENTER_LIVES unless lives > 0 && lives
    @lives = lives
  end

  def randomize
    words = ["stuff", "widget", "ruby", "goodies", "java", "emerald", "etc", "we are home" ]
    @word = words.sample
  end

  def guess(char)
    return NO_LIVES_CATCH_ERROR if @lives < 1

    if @word.include?(char)
      reveal_char(char)
    else
      game_over
    end
    print SUCCESS_MESSAGE unless @shown_word.include?('#')
    @shown_word
  end

  def start
    return NO_LIVES_CATCH_ERROR if @lives < 1
    randomize
    print @word, 'word'
    @shown_word = []
    @word.size.times do |c|
      if @word[c] == ' '
        @shown_word << ' '
      else
        @shown_word << "#"
      end
    end
    @shown_word
  end

  private
    def game_over
      @lives -= 1
      GAME_OVER_ERROR if @lives < 1
      print "#{CHAR_NOT_FOUND}, #{@lives} lives(s) left"
    end

    def find_indices(char)
      (0 ... @word.size).find_all do |i|
        @word[i,1] == char
      end
    end

    def reveal_char(char)
      find_indices(char).each do |index|
        @shown_word[index] = char
      end
    end
end