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
