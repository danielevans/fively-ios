class ListsController < UITableViewController
  def viewDidLoad
    @lists = []
    view.dataSource = view.delegate = self
    loadLists
  end

  def loadLists
    url = "http://lab.five.ly/?format=json"

    @lists.clear
    Dispatch::Queue.concurrent.async do 
      error_ptr = Pointer.new(:object)
      data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(url), options:NSDataReadingUncached, error:error_ptr)
      unless data
        presentError error_ptr[0]
        return
      end
      json = NSJSONSerialization.JSONObjectWithData(data, options:0, error:error_ptr)
      unless json
        presentError error_ptr[0]
        return
      end

      new_lists = []
      json.each do |dict|
        new_lists << List.new(dict)
      end

      Dispatch::Queue.main.sync { load_lists(new_lists) }
    end
  end

  def load_lists(lists)
    @lists = lists
    view.reloadData
  end
 
  def presentError(error)
    $stderr.puts error.description
  end
 
  def tableView(tableView, numberOfRowsInSection:section)
    @lists.size
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    ListCell.heightForList(@lists[indexPath.row], tableView.frame.size.width)
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    list = @lists[indexPath.row]
    ListCell.cellForList(list, inTableView:tableView)
  end
  
  def reloadRowForList(list)
    row = @lists.index(list)
    if row
      view.reloadRowsAtIndexPaths([NSIndexPath.indexPathForRow(row, inSection:0)], withRowAnimation:false)
    end
  end
end
