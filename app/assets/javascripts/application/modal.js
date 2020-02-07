window.asyncModal = function(path) {
  document.getElementById("async_modal").checked = true;
  var container = document.getElementById("async_modal_container");
  container.innerHTML = "";
  $(container).load(path, function() {
    $(document).trigger("turbolinks:load");
  });
};

window.closeModal = function() {
  document.getElementById("async_modal").checked = false;
};
