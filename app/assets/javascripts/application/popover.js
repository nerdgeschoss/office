$(document).on("turbolinks:load", () =>
  document.querySelectorAll(".popover").forEach((popover) => (popover.style.top = `${popover.parentElement.clientHeight}px`))
);
