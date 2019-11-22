CC = g++
CFLAGS = -Wall -W -I include
LFLAGS = #-L lib -lsomelib

EXT = cpp
EXEC = exec
OBJDIR = obj
TRGDIR = target
SRCDIR = src

SRC = $(wildcard src/*.$(EXT))
OBJ = $(SRC:.$(EXT)=.o) 
OBJ := $(subst $(SRCDIR),$(OBJDIR),$(OBJ)) 

all:
	@make $(TRGDIR)/$(EXEC)

$(TRGDIR)/$(EXEC): $(OBJ)
	@$(CC) -o $@ $^ $(LFLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%.$(EXT)
	@$(CC) -o $@ -c $< $(CFLAGS)

clean:
	@rm -rf $(OBJDIR)/*.o
	@rm $(TRGDIR)/$(EXEC)