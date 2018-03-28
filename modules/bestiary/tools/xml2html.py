#! /usr/bin/python3

import sys
import lxml.etree as ET
import argparse

parser = argparse.ArgumentParser(description='Converts bestiary XML to bestiary HTML, with some options available.')
parser.add_argument(
        '-i','--infile',
        nargs='?',
        help="Input file. Expects XML. If not specified, uses 'input.xml'",
        default="bestiary.xml",
        metavar="input_file"
        )
parser.add_argument(
        '-o', '--outfile',
        nargs='?',
        help='Output file. If not specified, uses output.txt',
        default="../bestiary.html",
        metavar="output_file"
        )

group_xml = parser.add_argument_group("XML Options","These options only apply to xml output.")
group_xml.add_argument(
        '--altsort',
        action = 'store_true',
        help='output sorted by "alt_sort" element. not yet implemented: it always does this',
        )
args = parser.parse_args()

print(args)

xml_filename = args.infile
output_filename = args.outfile
alt_sort = str(args.altsort)
xsl_filename = "bestiary.xsl"

dom = ET.parse(xml_filename)
xslt = ET.parse(xsl_filename)
transform = ET.XSLT(xslt)
result = transform(dom)

print("Creating output file: %s" % output_filename)

with open(output_filename, "w") as f:
    f.write(str(result))

print("All done! File %s written!" % output_filename)

