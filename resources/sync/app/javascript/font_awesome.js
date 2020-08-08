import { dom, library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";

document.addEventListener("turbolinks:load", function () {
  library.add(fas);
  dom.i2svg();
});
