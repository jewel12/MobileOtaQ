class GameController < UIViewController
  def init
    super
    self.view.backgroundColor = UIColor.whiteColor
    return self
  end

  def viewDidLoad
    @quiz_loader = QuizLoader.new
    @quiz_loader.load

    margin = 20

    @state = UILabel.new
    @state.font = UIFont.systemFontOfSize(40)
    @state.text = 'Now loading...'
    @state.textAlignment = UITextAlignmentCenter
    @state.textColor = UIColor.blueColor
    @state.backgroundColor = UIColor.clearColor
    @state.frame = [[margin, 200], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@state)

    @timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector:'timerFired', userInfo:nil, repeats:true)
  end

  def timerFired
    if @quiz_loader.loaded?
      @timer.invalidate

      if @quiz_loader.quizzes.empty?
        # Return Title
        self.navigationController.popToRootViewControllerAnimated( true )
      else
        # Show quiz
        @quiz_controller = QuizController.new
        @quiz_controller.quizzes = @quiz_loader
        self.navigationController.pushViewController(@quiz_controller, animated:true)
      end
    end
  end
end







