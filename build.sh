#!/bin/sh
# Builds both response and PhD thesis

arara -v response.tex && arara -v phdthesis.tex
