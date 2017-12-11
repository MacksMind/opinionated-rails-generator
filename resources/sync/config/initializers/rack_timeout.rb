# frozen_string_literal: true

Rack::Timeout::Logger.disable if Rails.env.development?
