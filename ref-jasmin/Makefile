JASMINC ?= jasminc # point to your jasminc
CC = gcc

BJ = build/jasmin
SRC = src

OUT_DIR = build $(BJ)

.PHONY: dirs

${OUT_DIR}:
	mkdir -p ${OUT_DIR}

dirs: ${OUT_DIR}


$(BJ)/util.s: $(SRC)/util.jazz
	$(JASMINC) $< -o $@

$(BJ)/main: $(BJ)/util.s $(SRC)/main.c
	$(CC) -Wall $^ -o $@

build: $(BJ)/main

all: dirs build
