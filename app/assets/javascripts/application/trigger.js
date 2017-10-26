$(document).on('turbolinks:load', function() {
  document.querySelectorAll('[data-trigger]').forEach(function(trigger){
    const active = trigger.classList.contains('active');
    if (!active) {
      $(trigger.dataset.trigger).slideUp({duration: 0});
    }
  });
});

$(document).on('click', '[data-trigger]', function(event){
  event.preventDefault();
  const trigger = event.target;
  const active = !trigger.classList.contains('active');
  const target = $(trigger.dataset.trigger);
  if (active) {
    trigger.classList.add('active');
    target.slideDown()
  } else {
    trigger.classList.remove('active');
    target.slideUp()
  }
});
