class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    nav = UINavigationController.alloc.initWithRootViewController(TitleController.new )
    nav.navigationBarHidden = true

    @window.rootViewController = nav
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    return true
  end
end
