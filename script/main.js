// script store

var xmlParser= new DOMParser();
var moduleList = new Array(0);

function getTextFile(textfile, callback){
    fetch(textfile)
    .then(fetchStatus)
    .then(fetchText)
    .then(callback)
    .catch(function(err) {
      console.log('Fetch Error :-S', err);
  });
}

function getModuleList(){

}

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

function loadModules(){
      getTextFile("/modules/", function(text){
        let result = new DOMParser().parseFromString(text, "text/html");
        mods = result.getElementsByTagName("li");
        for (let i=0;i<mods.length;i++) {
          let mod = {};
          mod.name = mods[i].innerText.split('/', 1)[0];
          mod.number = i;
          mod.path = "/modules/" + mod.name + "/" + mod.name + ".js";
          moduleList.push(mod);

        }
        var modMenu = document.getElementById('mod-menu');
        let menuItemTemplate=document.createElement("DIV");
        menuItemTemplate.classList.add("mod-menu-item");
        menuItemTemplate.appendChild(document.createElement("P"));
        modMenu.innerHTML=""
        for (let mod of moduleList){
          let node = menuItemTemplate.cloneNode(true);
          node.addEventListener("click", function(){
            if(!this.classList.contains("mod-active")){
              for (let off of document.getElementsByClassName("mod-active")){
                off.classList.remove("mod-active");
              }
              this.classList.add("mod-active");
              loadMod(this.getAttribute("number"));
            }
            // TODO: load the module... maybe unload previous somehow.
          });
          node.children[0].appendChild(document.createTextNode(mod.name));
          node.setAttribute("number", mod.number);
          modMenu.appendChild(node);
        }
    });


}

function loadMod(modnum){
  document.getElementById("content").innerText = modnum;
}

function loadData(data){
  // alert(data); // works
}

document.addEventListener("DOMContentLoaded",  function(){
    // functions can go here, runs after DOM is parsed before images and css are downlaoded
    // in other words, use this place to load menus or whatever

    loadModules();



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
