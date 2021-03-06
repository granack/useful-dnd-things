// script store

var xmlParser= new DOMParser();
var moduleList = new Array(0);
var modules = new Array(0);
var currentModuleIndex;
var modMenu = document.getElementById('mod-menu');

function getTextFile(textfile, callback){
    fetch(textfile)
    .then(fetchStatus)
    .then(fetchText)
    .then(callback)
    .catch(function(err) {
      console.log('Fetch Error :-S', err);
  });
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

function processModuleList(text){
  createModList(text);
  createModMenu();
}

function createModList(text){
  let result = new DOMParser().parseFromString(text, "text/html");
  mods = result.getElementsByTagName("li");
  for (let i=0;i<mods.length;i++) {
    let mod = {};
    mod.name = mods[i].innerText.split('/', 1)[0];
    mod.number = i;
    mod.path = "/modules/" + mod.name + "/" + mod.name + ".js";
    moduleList.push(mod);
  }
}

function createModMenu(){

  let menuItemTemplate=document.createElement("DIV");
  menuItemTemplate.classList.add("mod-menu-item");
  menuItemTemplate.classList.add("hidden");
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
    initMod(mod.number);
  }
}

function loadModules(){
      getTextFile("/modules/", processModuleList);
}

function initMod(modnum){
  import(moduleList[modnum].path)
    .then((module) => {
      modules[modnum]=module;
      for (let item of modMenu.children){
        if (item.getAttribute("number")==modnum) {
          item.classList.remove("hidden");
        }
      }
    });
}

function loadMod(modnum){
  document.getElementById("content").innerText = modnum;
  currentModuleIndex=modnum;
  clearMenu();
  modules[currentModuleIndex].load(document.getElementById("content"));
}

function loadData(data){
  // alert(data); // works
}

function clearMenu(){
  document.getElementById('side-menu').innerHTML="";
  document.getElementById("side-menu").classList.add("no-menu") ;
  document.getElementById("content").classList.add("no-menu");
}

function loadMenu(menuItemList){

  let menuItemTemplate=document.createElement("DIV");
  menuItemTemplate.classList.add("side-menu-item");
  for (let i=0; i<menuItemList.length; i++){
    let node = menuItemTemplate.cloneNode(true);
    node.addEventListener("click", function(){
      if(!this.classList.contains("side-active")){
        for (let off of document.getElementsByClassName("side-active")){
          off.classList.remove("side-active");
        }
        this.classList.add("side-active");
        modules[currentModuleIndex].menuClick(this.getAttribute("number")); // do something when it's clicked, basically let the module know
      }
    });
    node.innerText=menuItemList[i];
    node.setAttribute("number", i);
    document.getElementById('side-menu').appendChild(node);
  }
  if(menuItemList.length==0) {
    document.getElementById("side-menu").classList.add("no-menu") ;
    document.getElementById("content").classList.add("no-menu");
  }
  else {
    document.getElementById("side-menu").classList.remove("no-menu") ;
    document.getElementById("content").classList.remove("no-menu");
  }
}

document.addEventListener("DOMContentLoaded",  function(){
    // functions can go here, runs after DOM is parsed before images and css are downlaoded
    // in other words, use this place to load menus or whatever
    loadModules();
});


