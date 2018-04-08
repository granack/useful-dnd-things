# useful-dnd-things
eventually, some useful things for D&amp;D 5e

- Bestiary - first view, then auto adjust (change size), then maybe, someday, full editor

- Spell List - just what it sound slike. ya, there are a million of them out there already, so what?

- Spell Book - save specific spells to custom lists (like a characater's spell book) for easy reference at the table

- would be nice if it looks nice on a phone as well as desktop. but since it's running locally, that's a low priority.

requires a web server: if you have python installed, run python -m SimpleHTTPServer in the repo's root directory

so far:
basic site is a header that has a 'module menu.' modules are loaded from folders in the '/modules/' directory. module names are taken from the directory names then Capitalized. an attempt is made to import a *modulename*.js file. This file needs to export a function *load(content)*, where content is a div representing the main content area. The load() function should call *loadMenu(Array)* where Array is an array of strings to populate the side menu. When a side menu item is clicked, it will call the exported function *menuClick(index)*, index being the index of the Array used to build the menu.

If you are creating a module:

module names MUST NOT contain spaces, and must only use characters in a valid file name.

modules MUST export:
- load(content) - content is main content div
- menuClick(index) - called when side menu item is clicked. Only required if there is a side menu.

modules MAY call:
- loadMenu(Array) - build or rebuild side menu from string array. If not called at all, the side bar remains blank.

content div is entirely in the control of the module. do the stuff there.


--- notices
### Bestiary is using the CSS for statbocks from https://codepen.io/retractedhack/pen/gPLpWe, which in turn is absed on https://valloric.github.io/statblock5e/

### Monster data in the Bestiary come from Wizards of the Coast's System Reference Document (SRD) 5.1 and Kobold Press' Tome of Beasts, both under the Open Game License version 1.0a. This applies to `srd.xml`, `tob.xml`, respecgtivley, and their derivitive `bestiary.html`. A small amount of data (specifically: environments and publication sources) come from Kobold Fight Club data. I noted whether monsters are from the SRD or not myself, so if any SRD monsters are found that I either missed or accidentally included, please let me know so I can correct it.

### Unless otherwise noted within the file, all other data or files are copyright me, granack@gmail.com, and released using [LGPL-3.0](https://github.com/granack/useful-dnd-things/blob/master/LICENSE)


