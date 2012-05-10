class GameNavController < UINavigationController
  def init
    super
    self.navigationBarHidden = true
    return self
  end

  def viewDidLoad
    margin = 20
    @state = UILabel.new
    @state.font = UIFont.systemFontOfSize(40)
    @state.text = 'OtaQ'
    @state.textAlignment = UITextAlignmentCenter
    @state.textColor = UIColor.whiteColor
    @state.backgroundColor = UIColor.clearColor
    @state.frame = [[margin, 200], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@state)

    @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @action.setTitle('Start', forState:UIControlStateNormal)
    @action.addTarget(self, action:'actionTapped', forControlEvents:UIControlEventTouchUpInside)
    @action.frame = [[margin, 260], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@action)
  end

  def actionTapped
    self.pushViewController(GameController.alloc.init, animated:true)
  end
end
