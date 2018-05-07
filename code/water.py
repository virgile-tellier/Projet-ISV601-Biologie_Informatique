#!/usr/bin/python3
from subprocess import call
from subprocess import check_output
import datetime


family = "VANDAL14"

file = open(family+".txt",'r')
temp = open("t.tmp",'w')

zones = check_output(["grep",family,"TAIR10_Transposable_Elements.txt"]).decode("utf-8").split('\n')

now = datetime.datetime.now()

while True:
	header = file.readline()
	seq = file.readline()
	if not header:
		break
	


file.close()
temp.close()