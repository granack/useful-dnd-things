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
  bContent.innerText="Bestiary loaded.";
  loadMenu(bMenuItemList);


}

export function menuClick(index) {
  // alert("Menu item" + index + "clicked!.");
  /*let xsltProcessor = new XSLTProcessor();
  xsltProcessor.importStylesheet(bxsl);
  let resultDocument = xsltProcessor.transformToFragment(bMonsters[index], document);
  if(resultDocument==null){
    bContent.innerText="result Doc null: transform completed but result was invalid HTML";
  } else if(resultDocument.childElementCount==0) {
    bContent.innerText = bxsl.childNodes[1].textContent;
  } else {
    bContent.innerText = "";
    bContent.appendChild(resultDocument);
  } */
  bContent.innerText = "";
  bContent.appendChild(bMonsters[index]);
}
