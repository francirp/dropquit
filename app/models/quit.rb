class Quit < ActiveRecord::Base

  belongs_to :user


  module Groups
    SMOKER = "smoker"
    DIPPER = "dipper"
  end

  module Lengths
    # in days
    DEFAULT = 7
  end

end
