class Introduction < Post

  def self.count_today
    todays_posts(model_name.name).count
  end

  def content_label
    "Introduce Yourself"
  end

  def type_text
    "Introduction"
  end

end
