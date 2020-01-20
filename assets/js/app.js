import "../scss/app.scss";
import "phoenix_html";
import tippy from "tippy.js";

document.addEventListener("DOMContentLoaded", () => {
  tippy("[data-toggle]", {
    placement: "right"
  });
});
