src = $(wildcard src/*.c)
obj = $(src:.c=.o)

# On linux you may need to install editline beforehand
# sudo apt-get install libedit-dev
#
# On Fedora you can use
# su -c "yum install libedit-dev*"

# On Linux you will also have to link to the maths library with -lm flag
LDFLAGS = -ledit -lm

lithpy: $(obj)
	$(CC) -o $@ $^ $(LDFLAGS) -std=c99 -Wall

.PHONY: clean clean-dep
clean:
	rm -f $(obj) lispy

clean-dep:
	rm src/mpc.*

debug:
	gdb lithpy

setup:
	[ -f "src/mpc.h" ] || curl https://raw.githubusercontent.com/orangeduck/mpc/0.9.0/mpc.h > src/mpc.h
	[ -f "src/mpc.c" ] || curl https://raw.githubusercontent.com/orangeduck/mpc/0.9.0/mpc.c > src/mpc.c
