class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :quits, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :checkpoints, dependent: :destroy

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :email, :handle, presence: true, uniqueness: true

  after_create :send_notification_to_admin

  scope :todays_new_members, -> { where("created_at>=? AND created_at<=?", DateTime.now.beginning_of_day, DateTime.now.end_of_day) }

  User::FREE_TRIAL_DAYS

  def self.count_todays_new_members
    todays_new_members.count
  end

  def has_not_posted_roll_call_today?
    Checkpoint.todays_user_posts(self).blank?
  end

  def streak
    checkpoints.count
  end

  def quit
    quits.last
  end

  def new_card(args = {})
    customer = stripe_customer_token.present? ? retrieve_stripe_customer : create_stripe_customer
    if customer.cards.any?
      customer.cards.first.delete()
    end
    customer.cards.create(card: args[:token])
  end

  def create_stripe_customer(args = {})
    customer = Stripe::Customer.create(
      :email => email
    )
    self.stripe_customer_token = customer.id
    self.save
    return customer
  end

  def retrieve_stripe_customer
    Stripe::Customer.retrieve(stripe_customer_token)
  end

  def has_stripe_token?
    stripe_customer_token.present?
  end

  def retrieve_last_four
    if has_stripe_token?
      customer = retrieve_stripe_customer
      card = customer.cards.first
      card["last4"] if card
    end
  end

  def self.daily_roll_call
    User.all.each do |user|
      if user.has_not_posted_roll_call_today? && Rails.env.production?
        SiteMailer.roll_call_reminder(user).deliver
      end
    end
  end

  private

    def send_notification_to_admin
      SiteMailer.notify_admin_of_new_user(self).deliver
    end

end
