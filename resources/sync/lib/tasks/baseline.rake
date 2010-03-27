namespace :baseline do
  namespace :rcov do
    desc "Delete aggregate coverage data."
    task (:clean) { rm_f "coverage.data" }
  end
  
  desc "Combined rcov data for RSpec and Cucumber"
  task :rcov => ['spec:rcov', 'cucumber:rcov:aggregate']
end

namespace :spec do
  task :rcov => ['baseline:rcov:clean']
end
