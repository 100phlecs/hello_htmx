import topbar from "topbar"
import * as htmx from "htmx.org"

topbar.config({
  barColors: { 0: "#29d" },
  shadowColor: "rgba(0, 0, 0, .3)",
  containerId: "topbar-container",
})

// usually 500ms, using 20ms to demonstrate it's working
window.addEventListener("htmx:before-request", (_info) => topbar.show(20))
window.addEventListener("htmx:after-request", (_info) => topbar.hide())

// handle flash
window.addEventListener("htmx:after-settle", (_info) => {
  let flashGroup = document.querySelector("#flash-group")
  setTimeout(() => {
    flashGroup.classList.add("transition", "opacity-0", "duration-500", "ease-out")
  }, 1000)
})

window.addEventListener("htmx:config-request", (event) => {
  let csrfToken = document.querySelector("meta[name='csrf-token']")?.getAttribute("content")
  event.detail.headers["x-csrf-token"] = csrfToken
})
