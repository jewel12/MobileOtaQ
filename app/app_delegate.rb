class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @kuma = "sss"
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = GameNavController.alloc.initWithRootViewController(UIViewController.new )
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    return true
  end
end
