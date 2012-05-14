class ListCell < UITableViewCell
  CellID = 'CellIdentifier'
  TopicFontSize = 14

  def self.cellForList(list, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(ListCell::CellID) || ListCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CellID)
    cell.fillWithList(list, inTableView:tableView)
    cell
  end

  def initWithStyle(style, reuseIdentifier:cellid)
    if super
      self.textLabel.numberOfLines = 0
      self.textLabel.font = UIFont.systemFontOfSize(TopicFontSize)
    end
    self
  end

  def fillWithList(list, inTableView:tableView)
    self.textLabel.text = list.topic

    unless list.profile_image
      self.imageView.image = nil
      Dispatch::Queue.concurrent.async do
        profile_image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(list.profile_image_url))
        if profile_image_data
          list.profile_image = UIImage.alloc.initWithData(profile_image_data)
          Dispatch::Queue.main.sync do
            self.imageView.image = list.profile_image
            tableView.delegate.reloadRowForList(list)
          end
        end
      end
    else
      self.imageView.image = list.profile_image
    end
  end

  def self.heightForList(list, width)
    constrain = CGSize.new(width - 57, 1000)
    size = list.topic.sizeWithFont(UIFont.systemFontOfSize(TopicFontSize), constrainedToSize:constrain)
    [57, size.height + 8].max
  end

  def layoutSubviews
    super
    self.imageView.frame = CGRectMake(2, 2, 49, 49)
    label_size = self.frame.size
    self.textLabel.frame = CGRectMake(57, 0, label_size.width - 59, label_size.height)
  end
end
