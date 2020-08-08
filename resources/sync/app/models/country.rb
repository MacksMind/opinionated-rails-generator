# frozen_string_literal: true

class Country < ApplicationRecord
  validates :code, :name, uniqueness: { case_sensitive: false }
  validates :code, :name, presence: true

  def state_codes
    State.where(country_code: code).map(&:code)
  end
end
