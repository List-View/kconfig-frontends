#
# kconfig-mconf makefile
# Yuanhui He <list_view_321@163.com>
# Date 2021/06/25
#

TOP_DIR = ${shell pwd}

CC ?= gcc

TARGET ?= kconfig-mconf
OBJ_DIR = $(TOP_DIR)/obj

DEFINES = -DCURSES_LOC=\"ncurses.h\" \
			-DHAVE_CONFIG_H \
			-DROOTMENU=\"Configuration\" \
			-DCONFIG_=\"CONFIG_\" \
			-DKBUILD_NO_NLS \
			"-DGPERF_LEN_TYPE=unsigned int"

CSRCS = libs/lxdialog/checklist.c \
	   libs/lxdialog/inputbox.c \
	   libs/lxdialog/menubox.c \
	   libs/lxdialog/textbox.c \
	   libs/lxdialog/util.c \
	   libs/lxdialog/yesno.c \
	   libs/parser/yconf.c \
	   frontends/mconf/mconf.c

OBJEXT ?= .o

COBJS = $(CSRCS:.c=$(OBJEXT))


LIBS = -Ilibs/parser -Ilibs

CFLAGS = $(DEFINES) $(LIBS)
LDFLAGS = -lncurses

all: prepare target


.PHONY: clean target prepare

%.o: %.c
	@$(CC) -o $@  -c $(CFLAGS) $<
	@echo "CC $<"

target: prepare $(COBJS)
	@$(CC) -o $(TARGET) $(COBJS) $(LDFLAGS)
	@echo "Link $(TARGET)"

clean:
	$(foreach c, $(COBJS),${shell test -e $(c) && rm $(c) || exit 0})
	@test -e $(TARGET) && rm $(TARGET) || exit 0

