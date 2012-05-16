class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @title_controller = TitleController.new
    nav = UINavigationController.alloc.initWithRootViewController( @title_controller )
    nav.navigationBarHidden = true

    @window.rootViewController = nav
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    return true
  end
end
