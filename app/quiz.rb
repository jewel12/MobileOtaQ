class Quiz
  include Enumerable

  def initialize
    @quizzes = []
  end

  def each
    @quizzes.each{|quiz| yield quiz}
  end

  def loaded?
    return !@quizzes.empty?
  end

  def load
    BubbleWrap::HTTP.get("http://otaq.jewelve.com/quizzes.json") do |response|
      @quizzes = BubbleWrap::JSON.parse( response.body.to_str )
    end
  end
end
