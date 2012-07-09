class List
  attr_reader :author, :topic, :profile_image_url, :items
  attr_accessor :profile_image
  def initialize(dict)
    @author = "#{dict['user']['first_name']} #{dict['user']['last_name']}"
    @topic = dict['topic']
    @items = dict['items']
    @profile_image_url = dict['user']['avatar']['small']['url']
    @profile_image_url = "http://popfive.com#{@profile_image_url}" if @profile_image_url.start_with?('/')
    @profile_image = nil
  end

  def self.get_mediums_for_item(item)
    [item['itunes_medium'], item['tmdb_medium'], item['url_medium'], item['youtube_medium']].compact
  end

  def self.get_image_for_item(item, size='tiny')
    return unless item
    medium = self.get_mediums_for_item(item).select do |medium|
      medium['normalized_payload'] && medium['normalized_payload']['artwork'] && medium['normalized_payload']['artwork'][size]
    end.first

    medium['normalized_payload']['artwork'][size] if medium
  end

  def self.get_label_for_item(item)
    return unless item
    medium = self.get_mediums_for_item(item).select do |medium|
      medium['normalized_payload'] && medium['normalized_payload']['name']
    end.first

    medium['normalized_payload']['name'] if medium
  end
end
