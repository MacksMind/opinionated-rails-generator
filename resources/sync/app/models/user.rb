# frozen_string_literal: true

class User < ActiveRecord::Base
  belongs_to :country, optional: true, primary_key: :code, foreign_key: :country_code
  belongs_to :state, optional: true

  validates_presence_of \
    :first_name,
    :last_name,
    :time_zone

  validate :state_code_matches_country

  before_validation :set_time_zone, on: :create

  scope :active, -> { where(active: true) }

  def set_time_zone
    self.time_zone ||= "Eastern Time (US & Canada)"
  end

  def state_code_matches_country
    return if country_code.blank? && state_id.blank?
    return if country_code.present? && country_code == state_id&.[](0, 2)

    allowed_values = self.country&.state_codes

    if allowed_values.blank?
      errors.add(:state_id, "not permitted for #{self.country&.name}") if state_id.present?
    else
      errors.add(:state_id, "must be one of #{allowed_values.sort.join(" ")}") if !allowed_values.include?(self.state_code)
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

  def state_code
    self.state_id&.[](2, 2)
  end

  def state_code=(code)
    self.state = State.find_by_code(code)
  end
end
