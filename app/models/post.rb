class Post < ActiveRecord::Base

  belongs_to :user
  acts_as_commentable
  scope :todays_posts, ->(type) {Post.where(date: Date.today, type: type)}
  paginates_per 30

  def checkpoint?
    self.type == 'Checkpoint'
  end

  def self.count_today
    Post.where(date: Date.today).count
  end

  def type_text
    "Post"
  end

end
