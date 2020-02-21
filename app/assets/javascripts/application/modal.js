window.asyncModal = function(path) {
  document.getElementById("async_modal").checked = true;
  var container = document.getElementById("async_modal_container");
  container.innerHTML = "";
  document.body.classList.add("no-scroll")
  $(container).load(path, function() {
    $(document).trigger("turbolinks:load");
  });
};

window.renderModal = function(content) {
  diff.innerHTML(document.getElementById("async_modal_container"), content);
  $(document).trigger("turbolinks:load");
}

window.closeModal = function() {
  document.body.classList.remove("no-scroll")
  document.getElementById("async_modal").checked = false;
};

window.refreshData = function() {
  $.get(document.location, function(data) {
    diff.innerHTML(document.getElementById("main"), data);
  });
}
