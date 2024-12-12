### Description
Cut based on the UNIX program cuts out the selected portions from each line in a file.

### Requirements
* Ruby 3.2.2

### Installation
`bundle install`

### Usage

To open the provided tab separated file and print out the second field (-f2) from each line. The result should look something like this:
```
./cut -f2 sample.tsv
f1
1
6
11
16
21
```

The `-d` option to allow the user to specify what character to use as the delimiter between fields. 
If no delimiter is provided then tab should still be used, we can test this first with a comma as the delimiter:

```
./cut -f1 -d, fourchords.csv | head -n5
Song title
"10000 Reasons (Bless the Lord)"
"20 Good Reasons"
"Adore You"
"Africa"
```

The `-f` option. This option specifies a list of fields to be printed out. Output fields are separated by a single occurrence of the field delimiter character.

The field list is a comma or whitespace separated list of fields, i.e. -f1,2 or -f “1 2”. The first field is field number 1.

Here’s how it would look:
```
./cut -f1,2 sample.tsv
f0      f1
0       1
5       6
10      11
15      16
20      21
```

and
```
./cut -d, -f"1 2" fourchords.csv | head -n5
Song title,Artist
"10000 Reasons (Bless the Lord)",Matt Redman and Jonas Myrin
"20 Good Reasons",Thirsty Merc
"Adore You",Harry Styles
"Africa",Toto
```
It supports reading from the standard input stream if no filename is provided or if the single dash is provided ‘-’.

```
tail -n5 fourchords.csv | ./cut -d, -f"1 2"
"Young Volcanoes",Fall Out Boy
"You Found Me",The Fray
"You'll Think Of Me",Keith Urban
"You're Not Sorry",Taylor Swift
"Zombie",The Cranberries
```
or 

```
tail -n5 fourchords.csv| ./cut -d, -f"1 2" -
"Young Volcanoes",Fall Out Boy
"You Found Me",The Fray
"You'll Think Of Me",Keith Urban
"You're Not Sorry",Taylor Swift
"Zombie",The Cranberries
```








