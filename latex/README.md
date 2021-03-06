# Compiling LaTeX Project #

## Configuration ##

To use `build_latex.sh` to compile LaTeX project, the following environment variables are compulsory to configure in the driver script. 

- `TEX_NAME`: Name of the main .tex file for compilation. By default, the script will look for `main.tex` or `ms.tex` if this variable is not set. 
- `TGT_BIB_NAME`: Name of the .bib file used as the parameter to `\bibliography{}` stated in the the .tex file. 
- `FAIRY_HOME`: Path of the root of the cloned Fairy project. This must be set in order to properly resolved dependencies required in `build_latex.sh`. 

Moreover, the following line must be placed at the end of the driver script. 

```bash
source "${FAIRY_HOME}/latex/build_latex.sh"
```

Here is a minimum example: 

```bash
#!/usr/bin/env bash

# Name of the main .tex file
export TEX_NAME="main"

# Name of the .bib file used as the parameter to \bibliography{}
export TGT_BIB_NAME="references"

# Path of the fairy project
export FAIRY_HOME="/path/to/fairy"

# Run build_latex.sh with the above settings
source "${FAIRY_HOME}/latex/build_latex.sh"
```

Save the above snippet as `build.sh` and put it in your LaTeX project, where the main TeX file `main.tex` and the bibliography file `references.bib` are both placed in the same level of directory. 

## Customization ##

The following environment variables can be optionally configured for purposed customization. 

- `PDF_NAME`: Name of the output .pdf file.
- `SRC_BIB_NAME`: Name of the source .bib file to be formatted by `trimbib`.
- `CMD_LATEX`: The LaTeX command, choosing from `latex`, `pdflatex` and `xelatex`.
- `CMD_BIBTEX`: Set it to empty string will bypass the compilation of bibliography. 
- `TRIMBIB_HOME`: Path of the root of the cloned trimbib project.
- `TRIMBIB_ARGS`: Argument list for the invocation of `trimbib`.
- `TRIMBIB_LOG`: Name of the `trimbib` log file. 
- `WORK_DIR`: Path of the working directory.
- `BUILD_DIR`: Path of the build directory.
