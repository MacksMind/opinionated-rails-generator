diff --git a/config/puma.rb b/config/puma.rb
index daaf036..e381397 100644
--- a/config/puma.rb
+++ b/config/puma.rb
@@ -30,14 +30,19 @@
 # Workers do not work on JRuby or Windows (both of which do not support
 # processes).
 #
-# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
+workers ENV.fetch('WEB_CONCURRENCY') { 2 }
 
 # Use the `preload_app!` method when specifying a `workers` number.
 # This directive tells Puma to first boot the application and load code
 # before forking the application. This takes advantage of Copy On Write
 # process behavior so workers use less memory.
 #
-# preload_app!
+preload_app!
+
+# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
+on_worker_boot do
+  ::ActiveRecord::Base.establish_connection if defined?(::ActiveRecord)
+end
 
 # Allow puma to be restarted by `bin/rails restart` command.
 plugin :tmp_restart
