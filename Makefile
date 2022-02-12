SRC_DIR := src
OBJ_DIR := bin
SRC_FILES := $(shell find . -name '*.cpp') #$(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst ./$(SRC_DIR)/%.cpp,./$(OBJ_DIR)/%.o,$(SRC_FILES))
LDFLAGS := 
CPPFLAGS := -std=c++17
CXXFLAGS := -Iinclude
TERMINALLESS := -Wl,--subsystem,windows
OPENGLFLAGS := -L"lib/mingw/x64" -lmingw32 -lSDL2main -lSDL2 -lkernel32 -ladvapi32 -lgdi32 -limm32 -lmsvcrt -lole32 -loleaut32 -lsetupapi -lshell32 -luser32 -lversion -lwinmm #$(TERMINALLESS)
STATICFLAGS := -static-libgcc -static-libstdc++ -static
SDLLIBS=`sdl2-config --libs`

all:	clear compileMain

compileMain:	main.exe

main.exe:	$(OBJ_FILES)
	g++ -o $@ $^ $(OPENGLFLAGS) $(STATICFLAGS)

$(OBJ_DIR)/%.o:	$(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	g++ $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

clear:
	rm -r -f bin/*