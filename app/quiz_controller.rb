# -*- coding: utf-8 -*-
class QuizController < UIViewController
  attr_accessor :quizzes

  def init
    super
    @choice_num = 4
    return self
  end

  def init_view
    @state = UILabel.new
    @state.font = UIFont.systemFontOfSize(40)
    @state.textAlignment = UITextAlignmentCenter
    @state.textColor = UIColor.blueColor
    @state.backgroundColor = UIColor.clearColor
    @state.frame = [[20, 200], [view.frame.size.width - 20 * 2, 40]]
    view.addSubview(@state)

    @res = UILabel.new
    @res.font = UIFont.systemFontOfSize(40)
    @res.textAlignment = UITextAlignmentCenter
    @res.textColor = UIColor.blueColor
    @res.backgroundColor = UIColor.clearColor
    @res.frame = [[20, 100], [view.frame.size.width - 20 * 2, 40]]
    view.addSubview(@res)

    @choice_buttons = []
    button_height = 40
    choice_area_start_y = view.frame.size.height - button_height*@choice_num
    @choice_num.times do |i|
      button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
      button.frame = CGRectMake( 0, choice_area_start_y+button_height*i,
                                 view.frame.size.width, button_height )
      @choice_buttons << button
    end

    @choice_buttons.each{|b| view.addSubview(b)}
  end

  def show_quiz( quiz )
    show_name = quiz['show_name']

    @state.text = show_name

    @choice_buttons.zip( quiz['choices'] ).each do |button,choice|
      button.setTitle( choice, forState:UIControlStateNormal)
      button.addTarget(self,
                        action: show_name == choice ? 'show_correct' : 'show_wrong',
                        forControlEvents:UIControlEventTouchUpInside)
    end
  end

  def viewDidLoad
    init_view
    show_quiz( @quizzes.next )
  end

  def show_correct
    show_result( '正解!' )
  end

  def show_wrong
    show_result( '不正解!' )
  end

  def show_result( result )
    @res.text = result
    show_quiz( @quizzes.next )
    rescue StopIteration
  end
end







