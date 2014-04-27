class Quit < ActiveRecord::Base
  include Workflow
  belongs_to :user

  validates :investment, presence: true, if: :active?

  module Groups
    SMOKER = "smoker"
    DIPPER = "dipper"
  end

  module Lengths
    # in days
    DEFAULT = 7
  end

  FORMATTED_STATES = { pending_activation: 'Not Activated', active: 'Activated' }.with_indifferent_access

  workflow do

    state :pending_activation do
      event :activate, :transitions_to => :active
    end
    state :active do
      event :pause, :transition_to => :paused
      event :retract, :transition_to => :pending_activation
    end
  end

  def state
    FORMATTED_STATES[workflow_state]
  end

end
