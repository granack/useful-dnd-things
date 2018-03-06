// script store

var xmlParser= new DOMParser();

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

function loadModules(data){
  var modulesXML = xmlParser.parseFromString(data, "text/xml");
  console.log(modulesXML);
  var moduleList=modulesXML.getElementsByTagName("module");
  console.log("length:",moduleList.length);
  var modules = [];
  for (let i=0;i<moduleList.length;i++){
    let name=moduleList[i].getElementsByTagName("name")[0].childNodes[0].nodeValue;
    let desc=moduleList[i].getElementsByTagName("description")[0].childNodes[0].nodeValue;
    let settings=moduleList[i].getElementsByTagName("settings-file")[0].childNodes[0].nodeValue;
    let module ={name: name, description: desc, settings:settings};
    console.log("module.name:",module.name);
    console.log("module.desc:",module.description);
    console.log("module.settings:",module.settings);
    modules.push(module);
  }
  console.log(modules[1].name);
  var navMenu = document.getElementsByClassName('nav-menu');
  let menuItemTemplate=document.createElement("DIV");
  menuItemTemplate.classList.add("nav-menu-item");
  menuItemTemplate.appendChild(document.createElement("P"));
  navMenu[0].innerHTML=""
  for (let mod of modules){
    let node = menuItemTemplate.cloneNode(true);
    node.children[0].appendChild(document.createTextNode(mod.name));
    navMenu[0].appendChild(node);
  }
}

function loadData(data){
  // alert(data); // works
}

document.addEventListener("DOMContentLoaded", function(){
    // function can go here, runs after DOM is parsed before images and css are downlaoded
    // in other words, use this place to load menus or whatever

  fetch('../settings/modules.xml')
  .then(fetchStatus)
  .then(fetchText)
  .then(loadModules)
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
