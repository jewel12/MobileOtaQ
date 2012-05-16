class TitleController < UIViewController
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
    @action.addTarget(self,
                      action:'actionTapped',
                      forControlEvents:UIControlEventTouchUpInside)
    @action.frame = [[margin, 260], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@action)
  end

  def actionTapped
    @game_controller = GameController.new
    self.navigationController.pushViewController(@game_controller,animated:true)
  end
end
