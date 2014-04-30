class AppSettings

  def self.central_time
    central_time = DateTime.now.utc - 5.hours
  end

end
