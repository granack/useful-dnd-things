#! /usr/bin/python3

# try running python3 merge_extra.py -c output/allsource.xml -e extra.xml -o complete/bestiary.xml -r complete/exterr.txt

import lxml.etree
import sys
import argparse

# This one will work for adding data to existing monsters, but not
#   for combining separate monsters.

# reads and writes the files specified in command line

parser = argparse.ArgumentParser(description='Merges extra monster info xml into existing monsters in a compendium xml file.')
parser.add_argument(
        '-c','--compendium',
        nargs='?',
        help='Compendium file. If not specified, uses \'compendium.xml\'. Expects XML.',
        default="compendium.xml",
        metavar="base_file"
        )
parser.add_argument(
        '-e', '--extra',
        nargs='?',
        help='Extras file. If not specified, uses \'extra.xml\' not yet.',
        default="extra.xml",
        metavar="extras_file"
        )
parser.add_argument(
        '-o', '--output',
        nargs='?',
        help='Output file. If not specified, uses \'extrafied.xml\'',
        default="extrafied.xml",
        metavar="output_file"
        )
parser.add_argument(
        '-r', '--errfile',
        nargs='?',
        help='Error file. Lists monsters not in the \'extra\' file. If not specified, uses "extraerr.txt"',
        default="extraerr.txt",
        metavar="output_file"
        )
args = parser.parse_args()

tree_base = lxml.etree.parse(args.compendium)
tree_add = lxml.etree.parse(args.extra)

# index the first catalog
print("Loading extras: %s..." % args.extra)
a_index = {}
for catalog in tree_add.xpath('/compendium/*'):
  a_index[catalog.find('name').text.lower()] = catalog

missing=[]

print("Inserting extras into the main compendium: %s..." % args.compendium)
# find catalog entries in english and merge the japanese
for catalog in tree_base.xpath('/compendium/*'):
    try:
      a_catalog = a_index[catalog.find('name').text.lower()]
      # print(a_catalog.find('name').text)
      if a_catalog is not None:
        #print('found match')
        for child in a_catalog:
          if child.tag != "name": # avoid duplicating the 'name' element
            #print(child.tag)
            catalog.append(child)
    except: missing.append(catalog.find('name').text + ': ' + catalog.find('sources').text)

print("Writing exception report: %s..." % args.errfile)
with open(args.errfile, "w") as f:
  f.write("The following monsters did not have extra data to merge:\n")
  f.writelines('\n'.join(missing))

print("Saving to file: %s..." % args.output)
# print(lxml.etree.tostring(tree_base))
tree_base.write(args.output, encoding='utf-8', xml_declaration=True)

print("Done!")
