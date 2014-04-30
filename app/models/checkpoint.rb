class Checkpoint < Post

  scope :todays_user_posts, ->(user) { where("user_id=? AND type=? AND created_at>=? AND created_at<=?", user.id, model_name.name, AppSettings.central_time.beginning_of_day, AppSettings.central_time.end_of_day) }
  scope :todays_posts, ->{ where("type=? AND created_at>=? AND created_at<=?", model_name.name, AppSettings.central_time.beginning_of_day, AppSettings.central_time.end_of_day) }

  def self.percent_roll_call_achievement
    user_count = User.all.count
    todays_checkpoint_count = Checkpoint.count_today
    fraction = (todays_checkpoint_count.to_f / user_count.to_f) * 100
    rounded_percent = fraction.round
    "#{rounded_percent}%"
  end

  def form_label
    "Post Roll Call"
  end

  def type_text
    "Roll Call"
  end

  def example
    "Another day dip free. Hell yeah. Lets go kick Wednesday's ass!"
  end

end
