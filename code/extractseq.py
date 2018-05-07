#!/usr/bin/python3
from subprocess import call
from subprocess import check_output
import datetime


family = "ATLINE1_2"

f = open(family+"v2.txt",'w')


zones = check_output(["grep",family,"TAIR10_Transposable_Elements.txt"]).decode("utf-8").split('\n')

now = datetime.datetime.now()


for i in zones:
	if len(i) < 1:
		break
	i = i.split("\t")
	start = i[2]
	stop = i[3]
	X = i[0][2]
	ref = i[0]
	command = []
	command.append("extractseq")
	filename = "".join(["sequence",i[0][2],".fasta"])
	command.append(filename)
	command.append("-r")
	region = "".join([start,"-",stop])
	command.append(region)
	command.append("t.tmp")
	command.append("-sid1")
	command.append(ref + " "+family+ " "+str(i[1]) +" " + str(now))
	call(command)
	call(["cat","t.tmp"], stdout = f)

call(["rm","t.tmp"])
f.close()

# mkdb = "formatdb -i "+