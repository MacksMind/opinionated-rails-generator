# frozen_string_literal: true

class State < ApplicationRecord
  validates :code, :name, uniqueness: { within: :country_code, case_sensitive: false }
  validates :code, :name, presence: true
  validates :country_code, inclusion: { in: %w[CA US MX] }
end
