json.array!(@checkpoints) do |checkpoint|
  json.extract! checkpoint, :id, :submitted_roll_call, :roll_call, :stayed_clean, :date
  json.url checkpoint_url(checkpoint, format: :json)
end
