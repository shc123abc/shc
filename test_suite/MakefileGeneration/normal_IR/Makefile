CC=clang
LINKER=/home/smz/shc/llvm-project/build/bin/llvm-link
OUTPUT=sad.bc
CFLAGS=-w -emit-llvm -fno-use-cxa-atexit -g -c
LINKER_FLAGS=-o $(OUTPUT)
SRCDIR_OBJS=file.bc image.bc main.bc parboil.bc sad_cpu.bc 

build:$(SRCDIR_OBJS)
	$(LINKER) $(LINKER_FLAGS) $(SRCDIR_OBJS)

file.bc: file.c
	$(CC) $(CFLAGS) file.c

image.bc: image.c
	$(CC) $(CFLAGS) image.c

main.bc: main.c
	$(CC) $(CFLAGS) main.c

parboil.bc: parboil.c
	$(CC) $(CFLAGS) parboil.c

sad_cpu.bc: sad_cpu.c
	$(CC) $(CFLAGS) sad_cpu.c

clean:
	rm -rf *.ll *.bc llfi* sad.bc

