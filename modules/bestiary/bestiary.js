// bestiary.js

var bestMenuItemList = new Array(0);

bestMenuItemList= ["Beast 1","Beast 2"];

export function load(content){
    content.innerText="Bestiary loaded.";
    loadMenu(bestMenuItemList);
}

export function menuClick(index) {
  alert("Menu item" + index + "clicked!.");
}
