class User < ActiveRecord::Base
  has_and_belongs_to_many :roles

  acts_as_authentic do |c|
    c.perishable_token_valid_for = 240.minutes
  end

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :time_zone

  validates_presence_of :first_name, :last_name

  after_create :deliver_account_confirmation_instructions!

  def deliver_account_confirmation_instructions!
    reset_perishable_token!
    Notifier.account_confirmation_instructions(self).deliver
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver
  end

  def confirmed?
    self.confirmed_at
  end

  def has_role?(role)
    self.roles.map{|r| r.title}.include?(role.to_s)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def cancel
    self.update_attribute(:active, false)
  end
end
