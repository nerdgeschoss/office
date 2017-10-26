const submit = event => setTimeout(() => $(event.target).closest("form").submit(), 50);

$(document).on("change", ".js-autosubmit", submit);
$(document).on("change", "[data-autosubmit]", submit);
