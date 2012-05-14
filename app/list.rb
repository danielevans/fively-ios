class List
  attr_reader :author, :topic, :profile_image_url
  attr_accessor :profile_image
  
  def initialize(dict)
    @author = "#{dict['user']['first_name']} #{dict['user']['last_name']}"
    @topic = dict['topic']
    @profile_image_url = dict['user']['avatar']['small']['url']
    @profile_image = nil
  end
end
