# Factory girl config
require 'factory_girl'
Dir["#{RAILS_ROOT}/spec/factories/*.rb"].each {|f| require f}
