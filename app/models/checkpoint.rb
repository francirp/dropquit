class Checkpoint < Post

  scope :user_daily_roll_call, ->(user) { where("user_id=? AND date=?", user.id, Date.today) }

  def self.count_today
    todays_posts(model_name.name).count
  end

  def self.percent_roll_call_achievement
    user_count = User.all.count
    todays_checkpoint_count = Checkpoint.count_today
    fraction = (todays_checkpoint_count.to_f / user_count.to_f) * 100
    rounded_percent = fraction.round
    "#{rounded_percent}%"
  end

  def content_label
    "Roll Call Message"
  end

  def self.count_days_freedom_earned
    Checkpoint.count
  end

  def type_text
    "Roll Call"
  end


end
