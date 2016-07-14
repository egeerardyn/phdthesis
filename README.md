# PhD thesis
This folder contains my PhD thesis.

## Compilation
Compilation happens with [arara](https://www.ctan.org/pkg/arara) using a custom configuration.
Put 

```yaml
!config
paths:
 - .
```

in your arara configuration file (`${HOME}/araraconfig.yaml`) such that the configuration files in this repository are loaded.
Afterwards, you should be able to run

```shell
arara phdthesis.tex
```

to fully compile the thesis.
It is recommended to use a Unix-like system (Mac OS X or Linux), since Windows has not been tested at all.

### Remark

Getting the compilation process started can be troublesome, since it heavily relies on temporary files being created.
During a first compilation, it is possible that you get a slew of errors in pgfplots.
Currently, the work-around for this is to:
 - remove all temp files (also `.aux` files in the subfolders, all contents of `tikz` folders, ...)
 - turn off `morewrites` if possible,
 - first compile every chapter by itself using the `\includeonly` at the top level,
 - once each chapter compiles on itself, you can try running the whole document.

I suspect the problems are due to many TikZ files being externalized but they still have to be parsed and it seems there might be a slight memory/resource leak. By compiling in smaller increments, that leak doesn't get triggered as easily.
