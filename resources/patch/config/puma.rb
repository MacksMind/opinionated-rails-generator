diff --git a/config/puma.rb b/config/puma.rb
index 1e19380..ad5d755 100644
--- a/config/puma.rb
+++ b/config/puma.rb
@@ -21,7 +21,7 @@ environment ENV.fetch("RAILS_ENV") { "development" }
 # Workers do not work on JRuby or Windows (both of which do not support
 # processes).
 #
-# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
+workers ENV.fetch("WEB_CONCURRENCY") { 2 }
 
 # Use the `preload_app!` method when specifying a `workers` number.
 # This directive tells Puma to first boot the application and load code
@@ -30,15 +30,15 @@ environment ENV.fetch("RAILS_ENV") { "development" }
 # you need to make sure to reconnect any threads in the `on_worker_boot`
 # block.
 #
-# preload_app!
+preload_app!
 
 # If you are preloading your application and using Active Record, it's
 # recommended that you close any connections to the database before workers
 # are forked to prevent connection leakage.
 #
-# before_fork do
-#   ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
-# end
+before_fork do
+  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
+end
 
 # The code in the `on_worker_boot` will be called if you are using
 # clustered mode by specifying a number of `workers`. After each worker
@@ -47,9 +47,9 @@ environment ENV.fetch("RAILS_ENV") { "development" }
 # or connections that may have been created at application boot, as Ruby
 # cannot share connections between processes.
 #
-# on_worker_boot do
-#   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
-# end
+on_worker_boot do
+  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
+end
 #
 
 # Allow puma to be restarted by `rails restart` command.
