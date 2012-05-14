class ItemCell < UITableViewCell
  CellID = 'ItemCellIdentifier'
  LabelFontSize = 14

  def self.cellForItem(item, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(ItemCell::CellID) || ItemCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CellID)
    cell.fillWithItem(item, inTableView:tableView)
    cell
  end
 
  def initWithStyle(style, reuseIdentifier:cellid)
    if super
      self.textLabel.numberOfLines = 0
      self.textLabel.font = UIFont.systemFontOfSize(LabelFontSize)
    end
    self
  end
 
  def fillWithItem(item, inTableView:tableView)
    self.textLabel.text = item['label']
  end

  def self.heightForItem(item, width)
    constrain = CGSize.new(width - 50, 1000)
    size = (item['label'] || '').sizeWithFont(UIFont.systemFontOfSize(LabelFontSize), constrainedToSize:constrain)
    [57, size.height + 8].max
  end

  def layoutSubviews
    super
    self.imageView.frame = CGRectMake(2, 2, 49, 49)
    label_size = self.frame.size
    self.textLabel.frame = CGRectMake(25, 0, label_size.width - 50, label_size.height)
  end
end
