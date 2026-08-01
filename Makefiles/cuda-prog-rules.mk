# Given a cuda program, we may want to do many things to it,
# such as
# 1. dump its PTX or SASS via cudaobjdump
# 2. profile it with ncu
# 3. profile it with nsys

# This makefile provides a template to generate rules to do these things to a
# CUDA program.
#
# Suppose there is a rule using the program's path as its name.
# The template will generate the following rules
# 1. NCU profile report of various sets
# 2. NSYS profiling runs
# 3. PTX dump
# 4. SASS dump
#
# How to use:
# 	In the makefile where there's a rule to make a program,
# 	include this makefile, and then
# 	$(eval $(call PROG_template,program))
#
# Limitations
# 1. there must be a rule to make the program. If the program is made using
# another make system, then we need to write a rule to invoke that system,
# e.g., cmake
# 2. the profiling rules assumes that the program takes no argument. 
# 3. the rules dumps the result files where the program is, which might not
# always be desireable.
# 4. THE PROFILING RULES MUST NOT BE EXECUTED IN PARALLEL, in order for stable
# results.

# template to define profiling and benchmark rules
define PROG_template

$1-full.ncu-rep: $1
	ncu --set full -fo $1-full.ncu-rep $1
$1-detailed.ncu-rep: $1
	ncu --set detailed -fo $1-detailed.ncu-rep $1
$1-run1.nsys-rep: $1
	nsys profile -f true -o $1-run1.nsys-rep $1
$1-run2.nsys-rep: $1
	nsys profile -f true -o $1-run2.nsys-rep $1
$1-run3.nsys-rep: $1
	nsys profile -f true -o $1-run3.nsys-rep $1
$1-run4.nsys-rep: $1
	nsys profile -f true -o $1-run4.nsys-rep $1
$1-run5.nsys-rep: $1
	nsys profile -f true -o $1-run5.nsys-rep $1

$1-nsys-all: $(foreach i,1 2 3 4 5,$1-run$i.nsys-rep )
.PHONY: $1-nsys-all
.NOTPARALLEL: $1-nsys-all

$1.ptx: $1
	cuobjdump --dump-ptx $1 >$1.ptx
$1.sass: $1
	cuobjdump --dump-sass $1 >$1.sass

$1-all : $1-full.ncu-rep $1-detailed.ncu-rep $1-nsys-all $1.ptx $1.sass
.PHONY: $1-all
.NOTPARALLEL: $1-all

endef


