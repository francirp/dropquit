class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :quits
  has_many :posts
  has_many :checkpoints

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :handle, presence: true, uniqueness: true

  scope :todays_new_members, where("created_at>=? AND created_at<=?", DateTime.now.beginning_of_day, DateTime.now.end_of_day)

  def self.count_todays_new_members
    todays_new_members.count
  end

  def has_not_posted_roll_call_today?
    Checkpoint.user_daily_roll_call(self).blank?
  end

  def streak
    checkpoints.count
  end

  def quit
    quits.last
  end

end
