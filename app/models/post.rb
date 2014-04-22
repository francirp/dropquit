class Post < ActiveRecord::Base

  def checkpoint?
    self.type == 'Checkpoint'
  end

  def content_label
    "Post Content"
  end

end
