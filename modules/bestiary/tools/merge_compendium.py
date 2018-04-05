#! /usr/bin/python3

# I think this one will work for adding data to existing monsters, but not for combining separate monsters.

# re-working now to address that.

# try something like python3 merge_compendium.py -b source-xml/manual.xml -a source-xml/volo.xml source-xml/player.xml source-xml/tftyp.xml source-xml/phandelver.xml source-xml/tob.xml -o output/allsource.xml

import lxml.etree
import sys
import argparse

parser = argparse.ArgumentParser(description='Merges extra monster info xml into existing monsters in a compendium xml file.')
parser.add_argument(
        '-b','--base',
        nargs='?',
        help='Base XML file. Monsters wil be apended to the end of it. If not specified, uses "base.xml"',
        default="base.xml",
        metavar="base_file"
        )
parser.add_argument(
        '-a', '--additional',
        nargs='*',
        help='Additional monsters file. Any monsters in here not already in the Base file will be appended to the Base file. If not specified, uses "additional.xml"',
        default=["additional.xml"],
        metavar="add_file"
        )
parser.add_argument(
        '-o', '--output',
        nargs='?',
        help='Output file. If not specified, uses "combined.xml"',
        default="combined.xml",
        metavar="output_file"
        )
args = parser.parse_args()
print(args)

tree_base = lxml.etree.parse(args.base)
# tree_add = lxml.etree.parse(args.additional)

for additional in args.additional:  # index the first catalog
  tree_add = lxml.etree.parse(additional)
  a_index = {}
  for catalog in tree_add.xpath('/compendium/*'):
    name = catalog.find('name').text
    found = False
    print("Looking for %s..." % name)
    for b_cat in tree_base.xpath('/compendium/*'):
      if b_cat.find('name').text == name:
        found = True
        print(" --> %s is already in the file, skipping!" % name)
        break
    if found==False:
      print(" --> %s was not found, so adding it!" % name)
      tree_base.getroot().append(catalog)

print("Phew, done with that part!")
print("="*40)
# print("What's in here now? Look and see:")
# for monster in tree_base.xpath('/compendium/*'):
#   print(monster.find('name').text)

# print(lxml.etree.tostring(tree_base))
tree_base.write(args.output,encoding='utf-8', xml_declaration=True)
