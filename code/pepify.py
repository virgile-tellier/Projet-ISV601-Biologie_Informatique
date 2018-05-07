#!/usr/bin/python3

pepfile = "TAIR10_pep_20101214_updated.txt"

f = open(pepfile,'r')

gene = {}

line = f.readline()

while line:
	if line[0] is not ">":
		line = f.readline()
		continue
	line = line.split("|")
	name = line[0]
	name = name.split(">")[1]
	name = name.split(".")[0]

	info = line[3]
	info = info.split(":")[1]
	forw = info.split(" ")[1]
	info = info.split(" ")[0]	
	info = info.split("-")
	first = int(info[0])
	last = int(info[1])
	print(info)
	

	if name not in gene:
		gene[name] = (first,last,forw)
	else:
		if forw is "FORWARD":
			if gene[name][0]>first:
				gene[name] = (first,gene[name][1],forw)
			if gene[name][1]<last:
				gene[name] = (gene[name][0],last,forw)
		else:
			if gene[name][0]<first:
				gene[name] = (first,gene[name][1],forw)
			if gene[name][1]>last:
				gene[name] = (gene[name][0],last,forw)
	
	line = f.readline()

f.close()

w = open("dico2.tsv",'w')

for ent in gene:
	w.write("\t".join([ent,str(ent[2]),str(gene[ent][0]),str(gene[ent][1]),str(gene[ent][2])])+"\n")
