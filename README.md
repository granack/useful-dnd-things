# useful-dnd-things
eventually, some useful things for D&amp;D 5e

- Bestiary - first view, then auto adjust (change size), then maybe, someday, full editor

- Spell List - just what it sound slike. ya, there are a million of them out there already, so what?

- Spell Book - save specific spells to custom lists (like a characater's spell book) for easy reference at the table

- would be nice if it looks nice on a phone as well as desktop. but since it's running locally, that's a low priority.

requires a web server: if you have python installed, run python -m SimpleHTTPServer in the repo's root directory

so far:
basic site is a header tha thas a 'module menu' modules are loaded from folders in the '/modules/' directory. module names are taken from the directory names. an atempt is made to import a *modulename*.js file. This file needs to export a function *load(content)*, where content is a div represeting hte main content area. The load() function should call *loadMenu(Array)* where Array is an array of strings to populate the side menu. When a side menu item is clicked, it will call the exported function *menuClick(index)*, index being the index o fhte Array used to build the menu.

modules MUST export:
- load(content) - content is main content div
- menuClick(index) - called when side menu item is clicked.

modules MAY call:
- loadMenu(Array) - build or rebuild side menu from string array. If not called at all, the side bar remains blank.

content div is entirely in the control of the module. do the stuff there.
