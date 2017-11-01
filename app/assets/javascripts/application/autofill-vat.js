function round(number, precision) {
  var magnitude = Math.pow(10, precision);
  return parseInt(number * magnitude) / magnitude;
}

$(document).on("change", "#product_price", function(event){
  var price = parseFloat(event.currentTarget.value);
  var vat_rate = parseFloat(event.currentTarget.form["product[vat_rate]"].value);
  var vat_field = event.currentTarget.form["product[vat]"];
  var vat = vat_field.value;
  if(vat_rate && price && vat === "") {
    vat_field.value = round(price * vat_rate * 0.01, 2);
    vat_field.classList.add("has-content");
  }
});
