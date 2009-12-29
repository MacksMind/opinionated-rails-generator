unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks

  vendored_cucumber_bin = Dir["#{RAILS_ROOT}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first

  begin
    namespace :cucumber do
      Cucumber::Rake::Task.new({:rcov => 'db:test:prepare'}, 'Run features that should pass with RCov') do |t|
        t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
        t.rcov = true
        t.profile = 'default'
      end
    end
  end
end
