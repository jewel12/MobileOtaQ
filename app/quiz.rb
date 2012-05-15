class QuizLoader
  attr_reader :quizzes

  def initialize
    @pointer = -1
    @quizzes = []
  end

  def next
    raise StopIteration if (@pointer += 1) == @quizzes.length
    return current
  end

  def current
    return @quizzes[ @pointer ]
  end

  def loaded?
    return @loaded_flg
  end

  def load
    @loaded_flg = false
    url = "http://otaq.jewelve.com/quizzes.json"
    BubbleWrap::HTTP.get( url ) do |response|
      begin
        @quizzes = BubbleWrap::JSON.parse( response.body.to_str )
      rescue => e
        alert = UIAlertView.new
        alert.message = "Sorry, an error occured during quiz loading. : " + e.to_s
        alert.addButtonWithTitle "OK"
        alert.show
      ensure
        @loaded_flg = true
      end
    end
  end
end
