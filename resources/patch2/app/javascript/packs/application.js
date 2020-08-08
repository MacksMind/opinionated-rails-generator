diff --git a/app/javascript/packs/application.js b/app/javascript/packs/application.js
index 9cd55d4..0135fe3 100644
--- a/app/javascript/packs/application.js
+++ b/app/javascript/packs/application.js
@@ -8,6 +8,9 @@ require("turbolinks").start()
 require("@rails/activestorage").start()
 require("channels")
 
+import { Dropdown } from "bootstrap";
+require("../clear_form");
+require("../font_awesome");
 
 // Uncomment to copy all static images under ../images to the output folder and reference
 // them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
