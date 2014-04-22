class Quit < ActiveRecord::Base
  include Workflow
  belongs_to :user

  module Groups
    SMOKER = "smoker"
    DIPPER = "dipper"
  end

  module Lengths
    # in days
    DEFAULT = 7
  end

  workflow do
    state :pending_activation do
      event :activate, :transitions_to => :active
    end
    state :active do
      event :fail, :transitions_to => :failed
      event :pause, :transition_to => :paused
    end
  end
end
