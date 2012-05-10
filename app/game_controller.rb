class GameController < UIViewController
  def init
    super
    self.view.backgroundColor = UIColor.whiteColor
    return self
  end

  def viewDidLoad
    @quizzes = Quiz.new
    @quizzes.load

    margin = 20

    @state = UILabel.new
    @state.font = UIFont.systemFontOfSize(40)
    @state.text = 'OtaQ'
    @state.textAlignment = UITextAlignmentCenter
    @state.textColor = UIColor.yellowColor
    @state.backgroundColor = UIColor.clearColor
    @state.frame = [[margin, 200], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@state)

    @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerFired', userInfo:nil, repeats:true)

  end

  def timerFired
    @state.text = if @quizzes.loaded?
                    "YES"
                  else
                    "Now loading..."
                  end
  end
end
