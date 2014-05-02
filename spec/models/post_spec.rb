require 'spec_helper'

describe 'Post' do

  it "is valid with required fields" do
    post = build(:post)
    expect(post).to be_valid
  end

  context "when required fields are ommitted" do
    [:content, :user_id].each do |required_attr|
      it "is invalid without #{required_attr}" do
        post = build(:post, required_attr => nil)
        expect(post).to be_invalid
      end
    end
  end

end
