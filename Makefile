.PHONY: clean weibull

weibull: weibull.mo weibull.mos
	omc weibull.mos

delta_method: delta_method.mo delta_method.mos
	omc delta_method.mos

SHELL := /bin/bash -O extglob

clean:
	rm -f Markov1*.?(c|h|makefile|json|xml|o|libs|log|mat|csv)
	rm -f Test*.?(c|h|makefile|json|xml|o|libs|log|mat|csv) Test
