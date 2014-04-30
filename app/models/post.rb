class Post < ActiveRecord::Base

  belongs_to :user
  acts_as_commentable
  scope :daily_posts, ->(type, datetime) { where('type=? AND created_at>=? AND created_at<=?', type, datetime.beginning_of_day, datetime.end_of_day) }
  scope :sprays_within_date_range, ->(course_id,start_date,end_date,state) { where('course_id=? AND date>=? AND date<=? AND spray_state=?', course_id, start_date, end_date, state) }
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

  def self.todays_posts(type)
    Post.daily_posts(type, AppSettings.central_time)
  end

  def self.group_by_date(posts)
    posts.group_by(&:group_by_date_criteria)
  end

  def group_by_date_criteria
    created_at.to_date.to_s(:db)
  end

end
