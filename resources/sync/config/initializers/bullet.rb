# frozen_string_literal: true

if Object.const_defined?(:Bullet)
  Rails.application.configure do
    config.after_initialize do
      Bullet.enable        = true
      Bullet.bullet_logger = true

      if Rails.env.development?
        Bullet.alert         = true
        Bullet.console       = true
        Bullet.rails_logger  = true
        Bullet.add_footer    = true
      elsif Rails.env.test?
        Bullet.raise         = true
      end
    end
  end
end
