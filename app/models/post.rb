class Post < ActiveRecord::Base

  scope :todays_posts, ->(type) {Post.where(date: Date.today, type: type)}

  def checkpoint?
    self.type == 'Checkpoint'
  end

  def self.count_today
    Post.where(date: Date.today).count
  end

  def content_label
    "Post Content"
  end

  def type_text
    "Post"
  end

end
