function updateMenu() {
  const menu = document.querySelector(".menu");
  if(!menu) return;
  if(window.innerHeight < menu.querySelector(".menu__item:last-child").getBoundingClientRect().bottom) {
    menu.classList.add("menu--overflow");
  } else {
    menu.classList.remove("menu--overflow");
  }
}

$(window).on("resize", updateMenu);
$(document).on("turbolinks:load", updateMenu);
