OBJDIR = obj
TRGDIR = target
SRCDIR = src
LIBDIR = lib
INCLUDEDIR = include

CC = g++
CFLAGS = -Wall -W -I $(INCLUDEDIR)
LFLAGS = #-L $(LIBDIR) -lsomelib

EXT_HEAD = hpp
EXT_SRC = cpp

EXEC = exec
MAIN_FILE = Main

HEADERS = $(wildcard $(SRCDIR)/*.$(EXT_HEAD))
SRC = $(HEADERS:.$(EXT_HEAD)=$(EXT_SRC))
OBJ = $(SRC:.$(EXT_SRC)=.o) 
OBJ := $(subst $(SRCDIR),$(OBJDIR),$(OBJ)) 

all:
	@make $(TRGDIR)/$(EXEC)

$(TRGDIR)/$(EXEC): $(OBJDIR)/$(MAIN_FILE).o $(OBJ)
	@$(CC) -o $@ $^ $(LFLAGS)

$(OBJDIR)/$(MAIN_FILE).o: $(SRCDIR)/$(MAIN_FILE).$(EXT_SRC) $(HEADERS)
	@$(CC) -o $@ -c $< $(CFLAGS)

$(OBJDIR)/%.o: $(HEADERS)
	@$(CC) -o $@ -c $< $(CFLAGS)

clean:
	@rm -rf $(OBJDIR)/*.o
	@rm $(TRGDIR)/$(EXEC)

prepare: 
	@mkdir $(OBJDIR)
	@mkdir $(TRGDIR)
	@mkdir $(SRCDIR)
	@mkdir $(LIBDIR)
	@mkdir $(INCLUDEDIR)

run:
	$(TRGDIR)/$(EXEC)