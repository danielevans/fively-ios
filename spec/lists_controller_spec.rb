describe ListsController do
  before do
    @lists_controller = ListsController.alloc.initWithStyle(UITableViewStylePlain)
  end

  it "sets the view data source to self" do
    @lists_controller.viewDidLoad
    @lists_controller.view.dataSource.should == @lists_controller
  end
end
