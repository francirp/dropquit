class Lead

  attr_reader :amount, :group, :roll_call

  def initialize(options = {})
    @amount = options[:amount]
    @group = options[:group]
    @roll_call = options[:roll_call]
  end

end
