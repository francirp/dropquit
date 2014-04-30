class Introduction < Post

  scope :todays_posts, ->{ where("type=? AND created_at>=? AND created_at<=?", model_name.name, AppSettings.central_time.beginning_of_day, AppSettings.central_time.end_of_day) }

  def form_label
    "Introduce Yourself"
  end

  def type_text
    "Introduction"
  end

  def example
    '<p>Hey everyone,</p><p>My name is Nate and I chewed for over 5 years. After a meal with my friend Ryan, I never chewed again. It has been exactly 112 days since my last chew. I am proud of what I achieved, but I know this is not something that can be conquered without a commitment EVERY day saying "I will never dip again".</p>'
  end

end
