.PHONY: all clean

OS:=$(shell uname -s)
ifeq ($(OS), Darwin)
	parsejson_TARGET = parsejson.dylib
	CCFLAGS = -dynamiclib
else
	parsejson_TARGET = libparsejson.so
	CCFLAGS = -shared
endif

all: $(parsejson_TARGET)

parsejson.core parsejson.c parsejson.h parsejson.py: src/*.lisp
	sbcl --dynamic-space-size 100000 --load "src/build-image.lisp"

$(parsejson_TARGET): parsejson.core parsejson.c
	gcc $(CCFLAGS) -o $@ parsejson.c -lsbcl

clean:
	rm -f parsejson.so parsejson.c parsejson.h parsejson.core parsejson.py parsejson.dylib example

test:
	gcc test-parse.c -o test-parse -lsbcl -lparsejson -L. -I.