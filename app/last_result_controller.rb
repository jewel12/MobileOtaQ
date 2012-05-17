# -*- coding: utf-8 -*-
class LastResultController < UIViewController
  attr_accessor :quizzes, :total_point

  def viewDidLoad
    @state = UILabel.new
    @state.font = UIFont.systemFontOfSize(40)
    @state.textAlignment = UITextAlignmentCenter
    @state.textColor = UIColor.blueColor
    @state.text = @total_point.to_s + "点です!"
    @state.backgroundColor = UIColor.clearColor
    @state.frame = [[20, 200], [view.frame.size.width - 20 * 2, 40]]
    view.addSubview(@state)

    @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @action.setTitle('Go to title', forState:UIControlStateNormal)
    @action.addTarget(self,
                      action:'actionTapped',
                      forControlEvents:UIControlEventTouchUpInside)
    margin = 20
    @action.frame = [[margin, 260], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@action)
  end

  def actionTapped
    self.navigationController.popToRootViewControllerAnimated( true )
  end
end
