class QuizLoader
  attr_reader :quizzes

  def initialize
    @pointer = -1
    @quizzes = []
  end

  def next
    raise StopIteration if (@pointer += 1) == @quizzes.length
    return @quizzes[ @pointer ]
  end

  def loaded?
    return !@quizzes.empty?
  end

  def load
    url = "http://otaq.jewelve.com/quizzes.json"
    BubbleWrap::HTTP.get( url ) do |response|
      @quizzes = BubbleWrap::JSON.parse( response.body.to_str )
    end
  end
end
