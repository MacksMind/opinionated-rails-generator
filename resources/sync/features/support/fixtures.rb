# frozen_string_literal: true

Before do
  ActiveRecord::FixtureSet.reset_cache
  base_dir = ENV['FIXTURES_PATH'] ? Rails.root.join(ENV['FIXTURES_PATH']) : Rails.root.join('spec/fixtures')
  fixtures_dir = ENV['FIXTURES_DIR'] ? File.join(base_dir, ENV['FIXTURES_DIR']) : base_dir

  if ENV['FIXTURES']
    ENV['FIXTURES'].split(/,/).map { |f| File.join(fixtures_dir, f) }
  else
    Dir.glob(File.join(fixtures_dir, '*.{yml,csv}'))
  end.each do |fixture_file|
    ActiveRecord::FixtureSet.create_fixtures(File.dirname(fixture_file), File.basename(fixture_file, '.*'))
  end
end
