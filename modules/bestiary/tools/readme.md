## Tools for Bestiary, the Useful D&D Thing module by Granack

These tools assist in creating the `bestiary.html` file that contains
all the monster data. They use Python3.

here's how it works:

I have a spreadsheet I probably won't share. I get data for it using a
Kobold Fight Club csv file. that file contains some stats for almost all
monsters from many sources, but not *all* stats so I need more than that.
All I actually use from it though is environment, a 'unique' flag (meaning
the name is a Proper Name), and a list of sources where the monster came
from. I also add some of my own stuff to it, like I can write descriptions
for monsters, but mostly what I add is an "alt sort"... so I can sort on
that instead of name. this way, for instance, all the Dragons are lumped
together, with the chromatics first, separated by color, youngest to oldest.
I can also put demons together, or dinaosaurs or whatever. The file is
exported to csv, then I run `csv2xml.py` to convert it to xml calling it
`extra.xml`. (i did not write the `csv2xml.py` script, copyright is in the file)

There is another set of xml files of monster data I found for all official
WOTC sources and Kobold Press' Tome of Beasts. I doubt they are legal, so
I'm not sharing which GitHub project is sharing the files. Anyway, each
source is its own xml file, so I run `merge_compendium.py` to combine them
into a single file, `allsources.xml`. I **have** included the *Tome of
Beasts* file (`tob.xml`) as those monsters are released as Open Game Content
as well as a file with monsters, beasts and NPCs from the Source Refernce
Document tha twere extracted fr other files. The final `bestiary.html`file
also includes all monsters from both of those.

Now, we merge our `extra.xml` into `allsources.xml` using `merge_extra.py`.
This won't create new monsters, it only adds the 'extra' data to the
monsters already in allsources. it also create an error log listng monsters
that have no 'extra' data so it's possible to go back and add those monsters
to the spreadsheet and start over.' this creates `bestiary.xml`.

###### Note, I actually merged `allsources.xml` into `extra.xml` as extra.xml only contains Open content monsters, and that's all I can share.

ok, last step. run `xml2html.py`. this converts `bestiary.xml` to `bestiary.html`.
It needs to end up in the modules/bestiary folder, and it will as the
default output location.

In all steps, filenames should be specified, so use a command line. you
can use folder names with the file names, and relative paths work fine.
There are some defaults built in if you don't specify names, but they might
be weird. `merge_compendium.py` can use a list of files for the input. All
the scripts will open in a text editor if you want to see the defaults first.

### Command lines I use:

Run from the `tools` folder. `tools` folder contains folders named `extra`,
`input`, `output`, `source-xml`, and `complete`. The files called `empty file`
are only there to create the folders. They may be deleted or ignored.


```

$ python3 csv2xml.py --header -t compendium -r monster -x -o extra/extra.xml input/extra.csv

$ python3 merge_compendium.py -b source-xml/srd.xml -a source-xml/tob.xml [source-xml/data3.xml ...] -o output/allsource.xml

$ python3 merge_extra.py -c output/allsource.xml -e extra/extra.xml -o complete/bestiary.xml -r complete/exterr.txt

$ python xml2html.py

```

Notes:

- `merge_compendium.py` can use any number of additional files behind the single `-a` flag (represented by brackets above). I've done it with 5 additional files.
- `merge_extra.py` output exacxtly the monsters listed in the `-c` file. If yo uhave more monsters in `allsources.xml` than you do in `extra.xml`, include those monsters with extra data by using `-c allsources.xml -e extra.xml` or include only those monsters with extra data by switching which is `-c` and `-e`. Monster names must be an exact match, but ignors capitalization.
