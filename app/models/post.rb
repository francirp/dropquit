class Post < ActiveRecord::Base

  belongs_to :user
  acts_as_commentable
  paginates_per 30

  scope :todays_posts, ->{ where("created_at>=? AND created_at<=?", AppSettings.central_time.beginning_of_day, AppSettings.central_time.end_of_day) }
  scope :sprays_within_date_range, ->(course_id,start_date,end_date,state) { where('course_id=? AND date>=? AND date<=? AND spray_state=?', course_id, start_date, end_date, state) }

  def checkpoint?
    self.type == 'Checkpoint'
  end

  def self.test
    model_name.name
  end

  def self.count_today
    todays_posts.count
  end

  def type_text
    "Post"
  end

  def self.count_days_freedom_earned
    model_name.name.constantize.count
  end

  def self.group_by_date(posts)
    posts.group_by(&:group_by_date_criteria)
  end

  def group_by_date_criteria
    created_at.to_date.to_s(:db)
  end

end
