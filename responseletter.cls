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
\RequirePackage[colorlinks=true,urlcolor=TangoSkyBlue2,breaklinks=true,urlbordercolor=TangoSkyBlue1]{hyperref}

% http://tex.stackexchange.com/questions/26071/how-can-i-have-colored-and-underlined-links-with-hyperref
\makeatletter
\Hy@AtBeginDocument{%
  \def\@pdfborder{0 0 1}% Overrides border definition set with colorlinks=true
  \def\@pdfborderstyle{/S/U}% Overrides border style set with colorlinks=true
                                % Hyperlink border style will be underline of width 1pt
}
\makeatother

\definecolor{quote}{named}{TangoAluminium4}
\definecolor{light}{named}{TangoAluminium4}
\definecolor{verylight}{named}{TangoAluminium3}
\definecolor{old}{named}{TangoScarletRed3}
\definecolor{new}{named}{TangoChameleon3}
\definecolor{saying}{named}{TangoPlum3}
\definecolor{action}{named}{TangoOrange3}

\newcommand{\shortname}[1]{{\scshape\MakeLowercase{#1}}}
\newcommand{\showinitial}[1]{{\color{verylight}(\shortname{#1})}}

\addtokomafont{addressee}{\color{light}\sffamily}
\addtokomafont{placeanddate}{\color{light}\sffamily}
\addtokomafont{fromname}{\color{light}\sffamily}
\addtokomafont{fromaddress}{\color{light}\sffamily}
\addtokomafont{pagenumber}{\color{light}\sffamily}

\newcommand{\TODO}[1]{{\color{red} \textbf{TODO:} #1}}

\newcommand{\replace}[2]{#2} % from  Koen Tiels

\newenvironment{answer}{\noindent\ignorespaces\color{blue}}{\noindent\ignorespacesafterend}

\newcommand{\question}[1]{#1}
\newcommand{\ans}[1]{\begin{answer}#1\end{answer}}
\newcommand{\action}[1]{\par{\color{action}\textbf{Action:} #1}}

\newcommand{\oldnew}[3][]{\marginpar{\footnotesize\textsf{{\color{verylight}#1 {\color{old}#2} | {\color{new}#3}}}}}
\newcommand{\oldnewpage}[2]{\oldnew[p.]{#1}{#2}}
\newcommand{\oldnewsection}[2]{\oldnew[§]{#1}{#2}}

\newcommand{\says}[2]{\par{\color{saying}{\shortname{{#1}}:} #2}\par}

\newcommand{\section}[1]{\par{\sffamily\Large\textbf{#1}}\par}
\newcommand{\subsection}[1]{\par{\sffamily\large\textbf{#1}}\par}

\newenvironment{quoteold}{\begin{quote}\color{old}}{\normalcolor \end{environment}}
\newenvironment{quotenew}{\begin{quote}\color{new}}{\normalcolor \end{environment}}

\setkomavar{fromlogo}{\includegraphics[height=1.5cm]{VUB_logo}}
\setkomavar{enclseparator}[Attached]{:\,}
\setkomavar{firstfoot}{}
