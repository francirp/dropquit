FactoryGirl.define do
  factory :post do
    user_id 1
    type "Checkpoint"
    content "Just another day without Tobacco"
    stayed_clean true
  end
end
