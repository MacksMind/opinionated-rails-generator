class User < ActiveRecord::Base
  has_and_belongs_to_many :roles

  acts_as_authentic do |c|
    c.perishable_token_valid_for = 240.minutes
  end

  attr_accessible :email, :name, :password, :password_confirmation, :time_zone

  validates_presence_of :name

  after_create :deliver_account_confirmation_instructions!

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver
  end

  def deliver_account_confirmation_instructions!
    reset_perishable_token!
    Notifier.account_confirmation_instructions(self).deliver
  end

  def confirmed?
    self.confirmed_at || false
  end
end
