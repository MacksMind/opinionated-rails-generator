# frozen_string_literal: true

class User < ActiveRecord::Base
  belongs_to :country
  belongs_to :state, optional: true

  validates_presence_of \
    :first_name,
    :last_name,
    :time_zone,
    :phone_number,
    :company_name,
    :address_line_1,
    :city,
    :postal_code,
    :country_id

  validate :state_code_matches_country

  scope :active, -> { where(active: true) }

  def state_code_matches_country
    allowed_values = self.country&.state_codes

    if allowed_values.blank?
      errors.add(:state_id, "not permitted for #{self.country&.name}") if state_id
    else
      errors.add(:state_id, "must be one of #{allowed_values.sort.join(" ")}") if !allowed_values.include?(self.state&.code)
    end
  end

  ROLES = %w{admin}

  def roles=(roles)
    self.roles_mask = ((roles || []) & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    self.roles.include?(role.to_s)
  end

  scope :with_role, lambda { |role| { conditions: "roles_mask & #{2**ROLES.index(role.to_s)} > 0" } }

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def active_for_authentication?
    super && self.active?
  end

  def inactive_message
    self.active? ? super : "Sorry, this account has been canceled. Please contact support to reactivate."
  end

  def cancel
    self.update_attribute(:active, false)
  end

  def country_code
    self.country&.code
  end

  def country_code=(code)
    self.country = Country.find_by_code(code)
  end

  def state_code
    self.state&.code
  end

  def state_code=(code)
    self.state = State.find_by_code(code)
  end
end
