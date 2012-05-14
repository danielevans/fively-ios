class AppDelegate
  attr_accessor :navController, :window
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    @navController = UINavigationController.alloc.initWithRootViewController ListsController.alloc.initWithStyle(UITableViewStylePlain)
    @navController.navigationBar.topItem.title = "Fively"
    @window.rootViewController = @navController
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    true
  end
end
