#!/usr/bin/env ruby
# frozen_string_literal: true

# Copyright 2020 Mack Earnhardt

unless ::ARGV.size == 1
  puts "Usage: #{::File.basename($PROGRAM_NAME)} APP_PATH"
  exit(1)
end

require 'pathname'
::ENV['BUNDLE_GEMFILE'] ||= ::File.expand_path('../../Gemfile', ::Pathname.new(__FILE__).realpath)

require 'rubygems'
require 'bundler/setup'

require_relative '../lib/opinionated'
::Opinionated.new(
  app_path: ::ARGV[0]
).generate!
