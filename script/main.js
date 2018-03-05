// script store

function fetchStatus(response) {
  if (response.status >= 200 && response.status < 300) {
    return Promise.resolve(response)
  } else {
    return Promise.reject(new Error(response.statusText))
  }
}

function fetchText(response) {
  return response.text()
}

function loadData(data){
  // alert(data); // works
}

document.addEventListener("DOMContentLoaded", function(){
    // function can go here, runs after DOM is parsed before images and css are downlaoded
    // in other words, use this place to load menus or whatever

  fetch('../data/gbestiary.xml')
  .then(fetchStatus)
  .then(fetchText)
  .then(loadData)
  .catch(function(err) {
    console.log('Fetch Error :-S', err);
  });

});

var menuItems = document.getElementsByClassName("side-menu-item");
for (let item of menuItems){
  item.addEventListener("click", function(){
    for (let off of document.getElementsByClassName("side-active")){
      off.classList.remove("side-active");
    }
    this.classList.add("side-active");
    // placeholder for function to load appropriate data
  });
}
