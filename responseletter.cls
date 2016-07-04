\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{responseletter}[2016/06/21 v1.0]

% https://www.sharelatex.com/blog/2011/03/27/how-to-write-a-latex-class-file-and-design-your-own-cv.html
% https://www.sharelatex.com/blog/2013/06/28/how-to-write-a-latex-class-file-and-design-your-own-cv.html
\LoadClass[a4paper,
               backaddress=false,
               fromalign=right,
               fromemail,
               foldmarks=false,
               foldmarks=blmtP,
               fromlogo,
               parskip=full]{scrlttr2}

\RequirePackage{iftex}
\input{config/font.inc.tex}

\RequirePackage{tangocolors}
\RequirePackage{xcolor}
% http://tex.stackexchange.com/questions/26071/how-can-i-have-colored-and-underlined-links-with-hyperref

\colorlet{linkcolor}{TangoAluminium4}
\RequirePackage[colorlinks=false,allbordercolors=linkcolor,breaklinks=true]{hyperref}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{braket}

% http://tex.stackexchange.com/questions/26071/how-can-i-have-colored-and-underlined-links-with-hyperref
\makeatletter
\Hy@AtBeginDocument{%
  \def\@pdfborder{0 0 1}% Overrides border definition set with colorlinks=true
  \def\@pdfborderstyle{/S/U}% Overrides border style set with colorlinks=true
                                % Hyperlink border style will be underline of width 1pt
}
\makeatother

\input{config/definitions.tex}
\input{config/bib.inc.tex}

\definecolor{quote}{named}{TangoAluminium4}
\definecolor{light}{named}{TangoAluminium4}
\definecolor{verylight}{named}{TangoAluminium3}
\definecolor{old}{named}{TangoScarletRed3}
\definecolor{answer}{named}{TangoSkyBlue2}
\definecolor{new}{named}{TangoChameleon3}
\definecolor{saying}{named}{TangoAluminium6}
\definecolor{action}{named}{TangoSkyBlue3}

\newcommand{\shortname}[1]{{\scshape\MakeLowercase{#1}}}
\newcommand{\showinitial}[1]{{\color{verylight}(\shortname{#1})}}

\addtokomafont{addressee}{\color{light}\sffamily}
\addtokomafont{placeanddate}{\color{light}\sffamily}
\addtokomafont{fromname}{\color{light}\sffamily}
\addtokomafont{fromaddress}{\color{light}\sffamily}
\addtokomafont{pagenumber}{\color{light}\sffamily}

\renewcommand{\TODO}[1]{{\color{red} \textbf{TODO:} #1}}

\newcommand{\replace}[2]{#2} % from  Koen Tiels


\newcommand{\answer}[1]{{\color{answer}\shortname{EG:} #1\\}}
\newcommand{\question}[1]{#1}
\newcommand{\ans}[1]{\begin{answer}#1\end{answer}}
\newcommand{\action}[1]{{\color{action}\textbf{Action:} #1}}

\newcommand{\old}[1]{{\color{old}#1}}
\newcommand{\new}[1]{{\color{new}#1}}
\newcommand{\replacedBy}{{\large\ensuremath{\;\to\;}}}

% http://tex.stackexchange.com/questions/16141/align-marginpar-with-beginning-of-paragraph
\newcommand{\ifBothFilled}[3]{\notblank{#1}{\notblank{#2}{#3}{}}{}}

\newcommand{\oldnew}[3][]{\leavevmode\marginpar{\footnotesize\textsf{{\color{verylight}#1 {\color{old}#2}\ifBothFilled{#2}{#3}{ | }{\color{new}#3}}}}}
\newcommand{\oldnewpage}[2]{\oldnew[p.]{#1}{#2}}
\newcommand{\oldnewsection}[2]{\oldnew[§]{#1}{#2}}

\newcommand{\says}[2]{{\color{saying}{\shortname{{#1}}:} #2}\newline}

\makeatletter
% http://tex.stackexchange.com/questions/98740/if-i-redefine-a-command-that-has-a-starred-variant-will-that-always-disable-the
\newcommand{\section}{\@ifstar\@ssection\@ssection}
\newcommand{\@ssection}[1]{\par{\sffamily\Large\textbf{#1}}\par}
\newcommand{\subsection}[1]{\par{\sffamily\large\textbf{#1}}\par}
\makeatother

\newenvironment{oldquote}{\begin{quote}\color{old}}{\normalcolor \end{quote}}
\newenvironment{newquote}{\begin{quote}\color{new}}{\normalcolor \end{quote}}

\newcommand{\gls}[1]{#1}
\newcommand{\glspl}[1]{#1s}

\setkomavar{fromlogo}{\includegraphics[height=1.5cm]{VUB_logo}}
\setkomavar{enclseparator}[Attached]{:\,}
\setkomavar{firstfoot}{}
