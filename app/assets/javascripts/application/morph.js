Turbolinks.SnapshotRenderer.prototype.assignNewBody = function() {
  if (this.newBody.classList.contains("noMorph")) {
    document.body = this.newBody;
  } else {
    diff.outerHTML(
      document.querySelector(".workspace"),
      this.newBody.querySelector(".workspace").outerHTML
    );
    document.getElementById("menu").checked = false;
    document
      .querySelectorAll(".popover__toggle")
      .forEach(e => (e.checked = false));
  }
};
