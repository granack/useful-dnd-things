// bestiary.js

var bMenuItemList = new Array(0);
var bContent;
var monsters;

// bMenuItemList= ["Beast 1","Beast 2"];

 getTextFile("/modules/bestiary/bestiary.xml",processBestiaryXml);

function processBestiaryXml(xml) {
  let monName;
  var xmlDoc = xmlParser.parseFromString(xml, "application/xml");

  monsters = xmlDoc.getElementsByTagName("monster");
  for (let i = 0; i < monsters.length; i++) {
    bMenuItemList.push(monsters[i].children[0].textContent);
  }

}


export function load(content){
  bContent=content;
  bContent.innerText="Bestiary loaded.";
  loadMenu(bMenuItemList);

}

export function menuClick(index) {
  // alert("Menu item" + index + "clicked!.");
  bContent.innerText = monsters[index].children[0].textContent;
}
