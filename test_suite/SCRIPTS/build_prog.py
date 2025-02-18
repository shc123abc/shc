#! /usr/bin/env python3

import os
import sys
import shutil
import yaml
import subprocess

def build_prog(*prog_list):
	r = 0
	suite = {}
	script_dir = os.path.dirname(os.path.realpath(__file__))
	testsuite_dir = os.path.join(script_dir, os.pardir)
	with open(os.path.join(testsuite_dir, "test_suite.yaml")) as f:
		try:
			suite = yaml.load(f)
		except:
			print("ERROR: Unable to load yaml file: test_suite.yaml", file=sys.stderr)
			return -1

	if len(prog_list) == 0:
		## build all programs
		cwd = os.path.abspath(os.path.curdir)
		os.chdir(os.path.join(testsuite_dir, "PROGRAMS"))
		p = subprocess.Popen(["make"])
		p.wait()
		if p.returncode != 0:
			print ("ERROR: Failed in building all programs\n", file=sys.stderr)
			r = p.returncode
		os.chdir(cwd)
	else:
		cwd = os.path.abspath(os.path.curdir)
		for prog in prog_list:
			print("proglist",prog_list)
			## build prog
			if prog not in list(suite["PROGRAMS"].keys()):
				print("WARNING: program:", prog, "not defined in test_suite.yaml\n", file=sys.stderr)
				print("PROG:",prog)
				print("SUITE:",suite)
				continue
			pd = os.path.join(testsuite_dir, "PROGRAMS", prog)
			os.chdir(pd)
			p = subprocess.Popen(["make"])
			p.wait()
			if p.returncode != 0:
				print ("ERROR: Failed in building program:", prog, file=sys.stderr)
				r = p.returncode
		
		os.chdir(cwd)

	return r

if __name__ == "__main__":
	r = build_prog(*sys.argv[1:])
	sys.exit(r)