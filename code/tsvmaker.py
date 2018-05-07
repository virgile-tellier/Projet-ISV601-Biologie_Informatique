#!/usr/bin/python3

inputfile = "copie_2.tsv"
outputfile = "copie_3.tsv"

f = open(inputfile,'r')

line = f.readline()

buff = []

while line:

	buff.append(line[:-1])

	line = f.readline()


f.close()


w = open(outputfile, 'w')

for line in buff:

	string = line.split("\t")
	if len(string) == 7:
		string.append("")
	string[6] = string[6][:-1]
	w.write("\t".join(string)+"\n")


w.close()