# Directories
SRC_DIR := src
OBJ_DIR := bin
LIBS := lib/mingw/x64

# Obtain names of source files and generate object file names
SRC_FILES := $(shell find . -name '*.cpp') #$(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst ./$(SRC_DIR)/%.cpp,./$(OBJ_DIR)/%.o,$(SRC_FILES))

# Compile Flags
CPPFLAGS := -Iinclude -std=c++17

# Linking Flags
TERMINALLESS := -Wl,--subsystem,windows
OPENGLFLAGS := -L"$(LIBS)" -lmingw32 -lSDL2main -lSDL2 -lSDL2_image -lkernel32 -ladvapi32 -lgdi32 -limm32 -lmsvcrt -lole32 -loleaut32 -lsetupapi -lshell32 -luser32 -lversion -lwinmm $(TERMINALLESS)
STATICFLAGS := -static-libgcc -static-libstdc++ -static -s

INFOFILE := executable_info

all:	clear generateInfoFile compileMain postCompile

generateInfoFile:
	windres $(INFOFILE).rc -O coff -o $(INFOFILE).res

compileMain:	main.exe

main.exe:	$(OBJ_FILES)
	g++ -o $@ $^ $(OPENGLFLAGS) $(STATICFLAGS) $(INFOFILE).res

$(OBJ_DIR)/%.o:	$(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	g++ $(CPPFLAGS) -c -o $@ $<

clear:
	rm -r -f bin/*

postCompile:
	rm -r $(INFOFILE).res