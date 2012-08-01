describe AppDelegate do
  before do
    @delegate = UIApplication.sharedApplication.delegate
  end

  it "has a navController" do
    @delegate.respond_to?(:navController).should == true
    @delegate.navController.is_a?(UINavigationController).should == true
  end

  it "has a window" do
    @delegate.respond_to?(:window).should == true
    @delegate.window.is_a?(UIWindow).should == true
  end

  it "should assign the rootViewController for the window" do
    @delegate.window.rootViewController.should == @delegate.navController
  end
end
