const selector = ".input > input, .input > textarea";
const areas = ".input--textarea textarea";
const updateInput = input => input.toggleClass("has-content", input.val().length > 0);
const updateTextArea = area => {
  $(area).height(area.scrollHeight - 28);
};

$(document).on("turbolinks:load", function() {
  for (let input of Array.from($(selector))) { updateInput($(input)) }
  document.querySelectorAll(areas).forEach(updateTextArea);

  flatpickr(".input--date input", { allowInput: true });

  flatpickr(".input--datetime input", { allowInput: true, enableTime: true, time_24hr: true });

  flatpickr(".input--time input", { allowInput: true, enableTime: true, noCalendar: true, time_24hr: true });
})

$(document).on("input change", selector, event => updateInput($(event.target)));

$(document).on("input change", areas, event => updateTextArea(event.target));


const findClosest = function(element, selector){
  const inside = element.find(selector);
  if (inside.length) { return inside; }
  return findClosest(element.parent(), selector);
};


$(document).on("change", "input[type='file'][data-preview]", function(e){
  const url = URL.createObjectURL(e.target.files[0]);
  const selector = $(e.target).data("preview");
  const destination = findClosest($(this), selector);
  destination.attr("src", url);
});

$(document).on("turbolinks:load", function() {
  $("[data-fuzzy]").select2();
  $("[data-tagging]").select2({
    tags: true,
    tokenSeparators: [","]});
});
