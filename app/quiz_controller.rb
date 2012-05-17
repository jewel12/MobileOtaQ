# -*- coding: utf-8 -*-
class QuizController < UIViewController
  attr_accessor :quizzes

  def init
    super
    @choice_num = 4 # Number of chocies
    @interval_time = 1.5 # Between quizzes
    @total_time = 15 # Number of chocies
    @total_point = 0
    @sentence_num = -1
    return self
  end

  def generate_label( opt )
    label = UILabel.new
    label.font = UIFont.systemFontOfSize( opt[:font_size] )
    label.textColor = opt[:text_color]
    label.backgroundColor = opt[:bg_color]
    label.numberOfLines = opt[:line_num] || 1
    label.textAlignment = opt[:alignment] || UITextAlignmentCenter
    label.adjustsFontSizeToFitWidth = true
    label.minimumFontSize = 10
    label.textAlignment = UITextAlignmentCenter
    label.font = UIFont.systemFontOfSize( opt[:font_size] )
    label.textColor = opt[:text_color]
    label.backgroundColor = opt[:bg_color]
    label.lineBreakMode = UILineBreakModeWordWrap
    frame = opt[:frame]
    label.frame = CGRectMake( frame[:x], frame[:y],
                              frame[:width], frame[:height] )
    return label
  end

  def init_view
    button_height = 40 # choice button
    choice_area_start_y = view.frame.size.height - button_height*@choice_num
    state_height = 40
    sentence_area_start_y = state_height
    sentence_area_height = choice_area_start_y - state_height

    @res = generate_label(
                          font_size: 40,
                          text_color: UIColor.redColor,
                          bg_color: UIColor.clearColor,
                          frame: {
                            x: 0,
                            y: 100,
                            width: view.frame.size.width,
                            height: 40
                          })

    @correct_choice_label = generate_label(
                          font_size: 40,
                          text_color: UIColor.yellowColor,
                          bg_color: UIColor.clearColor,
                          frame: {
                            x: 0,
                            y: 150,
                            width: view.frame.size.width,
                            height: 40
                          })

    @state = generate_label(
                            font_size: 10,
                            text_color: UIColor.blackColor,
                            bg_color: UIColor.whiteColor,
                            frame: {
                              x: 0,
                              y: 0,
                              width: view.frame.size.width,
                              height: state_height
                            })

    @sentence_area = generate_label(
                                    font_size: 30,
                                    text_color: UIColor.whiteColor,
                                    bg_color: UIColor.clearColor,
                                    line_num: 0,
                                    alignment: UITextAlignmentLeft,
                                    font_size: 40,
                                    text_color: UIColor.whiteColor,
                                    bg_color: UIColor.clearColor,
                                    frame: {
                                      x: 0,
                                      y: sentence_area_start_y,
                                      width: view.frame.size.width,
                                      height: sentence_area_height
                                    })

    view.addSubview(@res)
    view.addSubview(@correct_choice_label)
    view.addSubview(@state)
    view.addSubview(@sentence_area)
  end

  def show_quiz
    clear_main_area

    begin
      quiz = @quizzes.next
    rescue StopIteration # End of the quiz
      show_last_result
      return
    end

    @sentence_num = -1
    show_name = quiz['show_name']

    choice_buttons = []
    button_height = 40
    choice_area_start_y = view.frame.size.height - button_height*@choice_num
    @choice_num.times do |i|
      button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
      button.frame = CGRectMake( 0, choice_area_start_y+button_height*i,
                                 view.frame.size.width, button_height )
      choice_buttons << button
    end

    choice_buttons.each{|b| view.addSubview(b)}

    choice_buttons.zip( quiz['choices'].shuffle ).each do |button,choice|
      button.setTitle( choice, forState:UIControlStateNormal)
      button.addTarget(self,
                       action: show_name == choice ? 'show_correct' : 'show_wrong',
                       forControlEvents:UIControlEventTouchUpInside)
    end

    @timer = NSTimer.scheduledTimerWithTimeInterval(
                                                    @total_time/@quizzes.current[:sentences].size,
                                                    target:self, selector:'show_next_hint',
                                                    userInfo:nil, repeats:true
                                                    )
    show_next_hint
  end

  def show_next_hint
    sentences = @quizzes.current[:sentences]
    @sentence_num += 1

    if sentences.size == @sentence_num
      @sentence_area.text = sentences.last
    elsif sentences.size < @sentence_num
      show_wrong
      return
    else
      @sentence_area.text = sentences[@sentence_num]
    end
  end

  def show_last_result
    clear_main_area
    @last_result_controller = LastResultController.new
    @last_result_controller.quizzes = @quiz_loader
    @last_result_controller.total_point = @total_point
    self.navigationController.pushViewController(@last_result_controller, animated:true)
  end

  def viewDidLoad
    init_view
    show_quiz
  end

  def show_correct
    @total_point += 1
    show_result( '正解!' )
  end

  def show_wrong
    show_result( '不正解!' )
  end

  def clear_main_area
    @res.text =''
    @correct_choice_label.text =''
  end

  def show_result( result )
      if @timer
        @timer.invalidate
        @timer = nil
      end

      @sentence_area.text = ''
      @res.text = result
      @correct_choice_label.text = @quizzes.current['show_name']

      NSTimer.scheduledTimerWithTimeInterval(
                                             @interval_time,
                                             target:self, selector:'show_quiz',
                                             userInfo:nil, repeats:false
                                             )
  end
end
