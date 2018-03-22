// bestiary.js

var bMenuItemList = new Array(0);
var bContent;
var bMonsters;
var bxsl;

var newstyle = document.createElement("link"); // Create a new link Tag
newstyle.setAttribute("rel", "import");
// newstyle.setAttribute("type", "text/html");
newstyle.setAttribute("href", "/modules/bestiary/statblock.html");
document.getElementsByTagName("head")[0].appendChild(newstyle);

getTextFile("/modules/bestiary/bestiary.xml",processBestiaryXml);
getTextFile("/modules/bestiary/bestiary.xsl",processBestiaryXsl);

function processBestiaryXml(xml) {
  let xmlDoc = xmlParser.parseFromString(xml, "application/xml");
  bMonsters = xmlDoc.getElementsByTagName("monster");
  for (let i = 0; i < bMonsters.length; i++) {
    bMenuItemList.push(bMonsters[i].children[0].textContent);
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
  let xsltProcessor = new XSLTProcessor();
  xsltProcessor.importStylesheet(bxsl);
  let resultDocument = xsltProcessor.transformToFragment(bMonsters[index], document);
  bContent.innerText = resultDocument.textContent;
  refreshDisplay(window, document);

}
