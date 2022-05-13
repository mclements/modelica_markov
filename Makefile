.PHONY: clean weibull

weibull: weibull.mo weibull.mos
	omc weibull.mos

SHELL := /bin/bash -O extglob

clean:
	rm -f Markov1*.?(c|h|makefile|json|xml|o|libs|log|mat|csv)
	rm -f Test*.?(c|h|makefile|json|xml|o|libs|log|mat|csv) Test
