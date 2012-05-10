class QuizController < UIViewController
  attr_accessor :quizzes

  def viewDidLoad
    margin = 20
    @state = UILabel.new
    @state.font = UIFont.systemFontOfSize(40)
    @state.text = @quizzes.next['show_name']
    @state.textAlignment = UITextAlignmentCenter
    @state.textColor = UIColor.blueColor
    @state.backgroundColor = UIColor.clearColor
    @state.frame = [[margin, 200], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@state)

    @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @action.setTitle('Start', forState:UIControlStateNormal)
    @action.addTarget(self,
                      action:'actionTapped',
                      forControlEvents:UIControlEventTouchUpInside)
    @action.frame = [[margin, 260], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@action)
  end

  def actionTapped
    @state.text = @quizzes.next['show_name']
    rescue StopIteration
  end
end







