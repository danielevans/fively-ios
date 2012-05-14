class ListController < UITableViewController
  LIST_ITEMS = 5
  def initialize(list)
    @list = list
    @items = list.items
    @items.push {} until @items.length >= 5
    view.dataSource = self
    view.delegate = self
    view.reloadData
  end

  def presentError(error)
    $stderr.puts error.description
  end

  def tableView(tableView, numberOfRowsInSection:section)
    LIST_ITEMS
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    ItemCell.heightForItem(@items[indexPath.row], tableView.frame.size.width)
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    item = @items[indexPath.row]
    ItemCell.cellForItem(item, inTableView:tableView)
  end

  def reloadRowForItem(item)
    row = @items.index(item)
    if row
      view.reloadRowsAtIndexPaths([NSIndexPath.indexPathForRow(row, inSection:0)], withRowAnimation:false)
    end
  end
end
