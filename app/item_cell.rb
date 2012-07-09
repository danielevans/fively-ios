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
    self.textLabel.text = List.get_label_for_item(item)
    image_url = List.get_image_for_item(item, 'tiny')
    unless @image_url == image_url && @image
      @image_url = image_url
      self.imageView.image = nil
      @image = nil

      Dispatch::Queue.concurrent.async do
        image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(@image_url))
        if image_data
          @image = UIImage.alloc.initWithData(image_data)
          Dispatch::Queue.main.sync do
            self.imageView.image = @image
            tableView.delegate.reloadRowForItem(item)
          end
        end
      end
    else
      self.imageView.image = @image
    end
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
    self.textLabel.frame = CGRectMake(57, 0, label_size.width - 60, label_size.height)
  end
end
