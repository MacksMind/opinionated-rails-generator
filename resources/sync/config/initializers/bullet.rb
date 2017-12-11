# frozen_string_literal: true

if Object.const_defined?(:Bullet)
  Rails.application.configure do
    config.after_initialize do
      Bullet.enable = true
      Bullet.raise = true if Rails.env.test?
      Bullet.rails_logger = true
      Bullet.bullet_logger = true
    end
  end
end
