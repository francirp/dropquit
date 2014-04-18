json.array!(@quits) do |quit|
  json.extract! quit, :id, :user_id, :length, :start_date, :substance, :investment
  json.url quit_url(quit, format: :json)
end
