// bestiary.js

var bMenuItemList = new Array(0);
var bContent;
var bMonsters;
var bxsl;

var newstyle = document.createElement("link"); // Create a new link Tag
newstyle.setAttribute("rel", "stylesheet");
newstyle.setAttribute("type", "text/css");
newstyle.setAttribute("href", "/modules/bestiary/statblock.css");
document.getElementsByTagName("head")[0].appendChild(newstyle);

newstyle = document.createElement("link"); // Create a new link Tag
newstyle.setAttribute("rel", "stylesheet");
newstyle.setAttribute("type", "text/css");
newstyle.setAttribute("href", "https://fonts.googleapis.com/css?family=Libre+Baskerville:700");
document.getElementsByTagName("head")[0].appendChild(newstyle);

newstyle = document.createElement("link"); // Create a new link Tag
newstyle.setAttribute("rel", "stylesheet");
newstyle.setAttribute("type", "text/css");
newstyle.setAttribute("href", "https://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic,700italic");
document.getElementsByTagName("head")[0].appendChild(newstyle);

getTextFile("/modules/bestiary/bestiary.html",processBestiaryHtml);


function processBestiaryHtml(myFile) {
  bMenuItemList.push("Choose Filters");
  let htmlDoc = xmlParser.parseFromString(myFile, "text/html");
  bMonsters = htmlDoc.getElementsByClassName("monster");
  for (let i = 0; i < bMonsters.length; i++) {
    bMenuItemList.push(bMonsters[i].getElementsByTagName("h1")[0].innerText);
  }
}

function processBestiaryXsl(xsl) {
  bxsl = xmlParser.parseFromString(xsl, "application/xml");
}

export function load(content){
  bContent=content;
  bContent.innerText="Bestiary loading...";
  loadMenu(bMenuItemList);
  bContent.innerText="Bestiary loaded! Click a monster!";
}

export function menuClick(index) {
  bContent.innerText = "";
  if(index==0){
    bContent.innerHTML = "<h2>Filters Here.</h2> There will be some, but there aren't any yet. <h6>Ignore me: continue on</h6>";
  }
  else {
    bContent.appendChild(bMonsters[index-1].cloneNode(true));
    let box=bContent.getElementsByClassName("stat-block")[0]
    if(box.clientHeight > 1000) {
      box.classList.add("wide");
    }
  }
}
