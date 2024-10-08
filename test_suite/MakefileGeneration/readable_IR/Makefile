CC=clang
LINKER=/home/smz/shc/llvm-project/build/bin/llvm-link
OUTPUT=mcf.ll
CFLAGS=-w -emit-llvm -fno-use-cxa-atexit -g -S
LINKER_FLAGS=-o $(OUTPUT) -S
SRCDIR_OBJS=implicit.ll mcf.ll mcfutil.ll output.ll pbeampp.ll pbla.ll pflowup.ll psimplex.ll pstart.ll readmin.ll treeup.ll 

build:$(SRCDIR_OBJS)
	$(LINKER) $(LINKER_FLAGS) $(SRCDIR_OBJS)

implicit.ll: implicit.c
	$(CC) $(CFLAGS) implicit.c

mcf.ll: mcf.c
	$(CC) $(CFLAGS) mcf.c

mcfutil.ll: mcfutil.c
	$(CC) $(CFLAGS) mcfutil.c

output.ll: output.c
	$(CC) $(CFLAGS) output.c

pbeampp.ll: pbeampp.c
	$(CC) $(CFLAGS) pbeampp.c

pbla.ll: pbla.c
	$(CC) $(CFLAGS) pbla.c

pflowup.ll: pflowup.c
	$(CC) $(CFLAGS) pflowup.c

psimplex.ll: psimplex.c
	$(CC) $(CFLAGS) psimplex.c

pstart.ll: pstart.c
	$(CC) $(CFLAGS) pstart.c

readmin.ll: readmin.c
	$(CC) $(CFLAGS) readmin.c

treeup.ll: treeup.c
	$(CC) $(CFLAGS) treeup.c

clean:
	rm -rf *.ll *.bc llfi* mcf.ll

