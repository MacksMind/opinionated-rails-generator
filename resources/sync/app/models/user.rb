class User < ActiveRecord::Base
  belongs_to :country
  belongs_to :state

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

  def state_code_matches_country
    allowed_values = self.country.try(:state_codes)

    if allowed_values.blank?
      errors.add(:state_id, "not permitted for #{self.country.try(:name)}") if state_id
    else
      errors.add(:state_id, "must be one of #{allowed_values.sort.join(" ")}") if !allowed_values.include?(self.state.try(:code))
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

  scope :with_role, lambda { |role| {conditions: "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  def name
    "#{first_name} #{last_name}"
  end

  def cancel
    self.active = false
    self.save!
  end

  def country_code
    self.country.try(:code)
  end

  def country_code=(code)
    self.country = Country.find_by_code(code)
  end

  def state_code
    self.state.try(:code)
  end

  def state_code=(code)
    self.state = State.find_by_code(code)
  end
end
