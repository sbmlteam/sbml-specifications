%% Filename    : sbmlspec.cls
%% Description : SBML Team
%% Author(s)   : Michael Hucka <mhucka@caltech.edu>
%% Organization: Biological Network Modeling Center, Caltech
%% Created     : 2006-03-15
%% Revision    : $Id: sbmlspec.cls 20232 2014-04-18 21:55:30Z luciansmith $
%% $Source$
%%
%% Copyright 2007 California Institute of Technology
%% 
%% This file is free software; you can redistribute it and/or modify it
%% under the terms of the GNU Lesser General Public License as published
%% by the Free Software Foundation; either version 2.1 of the License, or
%% any later version.
%% 
%% This library is distributed in the hope that it will be useful, but
%% WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%% MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%% documentation provided hereunder is on an "as is" basis, and the
%% California Institute of Technology has no obligations to provide
%% maintenance, support, updates, enhancements or modifications.  In no
%% event shall the California Institute of Technology be liable to any
%% party for direct, indirect, special, incidental or consequential
%% damages, including lost profits, arising out of the use of this software
%% and its documentation, even if the California Institute of Technology
%% has been advised of the possibility of such damage.  See the
%% GNU Lesser General Public License for more details.
%% 
%% You should have received a copy of the GNU Lesser General Public License
%% along with this library; if not, write to the Free Software Foundation,
%% Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.

%% ----------------------------------------------------------------------------
%% Identification.
%% ----------------------------------------------------------------------------

%% It would be so nice to be able to put the CVS/RCS 'Date' tag in the
%% \filedate below.  Unfortunately, LaTeX will barf on the resulting string.

\def\filedate{2014/08/15}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{sbmlspec}[\filedate\space SBML Specification LaTeX Style]

%% ----------------------------------------------------------------------------
%% Package references and options.
%% ----------------------------------------------------------------------------

%% Keep in mind that hyperref needs to be almost the last package loaded.

\newif\if@notoc
\DeclareOption{toc}{\global\let\if@notoc\iffalse}
\DeclareOption{notoc}{\global\let\if@notoc\iftrue}

\newif\if@twocolumntoc
\DeclareOption{twocolumntoc}{\global\let\if@twocolumntoc\iftrue}
\DeclareOption{singlecolumntoc}{\global\let\if@twocolumntoc\iffalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ExecuteOptions{toc,twoside}
\ExecuteOptions{singlecolumntoc}
\ProcessOptions
\LoadClass{article}

%% ----------------------------------------------------------------------------
%% Dependencies on other packages.
%% ----------------------------------------------------------------------------

\RequirePackage{ifpdf}
\RequirePackage{alltt}
\RequirePackage{verbatim}
\RequirePackage{booktabs}
\RequirePackage{multicol}
\RequirePackage{array}
\RequirePackage[round]{natbib}
\RequirePackage{html}
\RequirePackage{xspace}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amscd}
\RequirePackage{dchem}
\RequirePackage[version=3]{mhchem}
\RequirePackage{wrapfig}
\RequirePackage{nameref}
\RequirePackage[pagewise,mathlines,edtable]{lineno}
\RequirePackage{accsupp}

% We use the "optional" package to indicate whether to generate a grayscale
% vs a color version of the document without having to alter the .tex file
% itself.  Unfortunately, the "optional" package doesn't offer an "or" type
% switch or a way to set a default, so we have to go through some
% contortions here.  Also, it needs *something* in the optional argument
% to RequirePackage or UsePackage, hence the "dummyoption" thing below.
%
% To produce grayscale output without modifying the source file, invoke
% latex with a command of the following form:
%
%  pdflatex "\newcommand\UseOption{grayscale}\input{sbml-level-2-version-2}"

\newif\ifgrayscalespec
\global\let\ifgrayscalespec\iffalse
\RequirePackage[dummyoption]{optional}
\opt{grayscale}{\global\let\ifgrayscalespec\iftrue}

% Load varioref only if not generating HTML, because on HTML
% pages it doesn't make sense to use varioref.

\latexhtml{
%begin{latexonly}
  \RequirePackage[american]{varioref}
%end{latexonly}
}{
  \newcommand{\vref}[1]{\ref{#1}}
}

% Hyperref, xcolor, graphicx and possibly others have a flag "pdftex"
% that needs to be used if pdflatex is being used.  The following puts
% these inside a conditional for that situation.

\ifpdf
  % Case: using pdflatex

  \RequirePackage[pdftex]{graphicx}

  % Options get even more complicated.  If we're producing grayscale output,
  % we don't want to bother with coloring links, but we still want to load
  % hyperref so that its macros are defined (and we don't have to redefine
  % everything that uses hyperref).  So:

  \ifgrayscalespec
    \RequirePackage[pdftex,breaklinks=true,colorlinks=false,
    bookmarksnumbered=true]{hyperref}
  \else
    \RequirePackage[pdftex,breaklinks=true,colorlinks=true,
    bookmarks=true,bookmarksopen=true,bookmarksopenlevel=2,
    pdfhighlight=/O,linkcolor={RoyalBlue},citecolor={RoyalBlue},
    urlcolor={RoyalBlue},bookmarksnumbered]{hyperref}
  \fi

  % Although it may seem like we wouldn't need to load xcolor if
  % the grayscale option is given, in fact it doesn't affect anything
  % to load this and it avoids having to conditionalize other things.
  % (The colors aren't actually invoked if grayscale is being used.)

  \RequirePackage[pdftex,rgb,dvipsnames,svgnames,hyperref,table]{xcolor}
\else
  % Case: not using pdflatex

  \RequirePackage{graphicx}
  % Test whether we're being run from latex or latex2html
  \latexhtml{
    % For latex.
    \RequirePackage[breaklinks]{hyperref}
  }{
    % For latex2html.
    \RequirePackage[latex2html,breaklinks]{hyperref}
  }
  \RequirePackage[rgb,dvipsnames,svgnames,hyperref,table]{xcolor}
\fi

% The following packages must be loaded after loading xcolor.

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\usetikzlibrary{trees}

% The following is best loaded after hyperref.
\RequirePackage{nameref}


%% ----------------------------------------------------------------------------
%% Font selection.
%% ----------------------------------------------------------------------------

% This sets up Helvetica for headings and TX Typewriter for the tt font.
% The font scaling is because the default Helvetica size is too big.

\RequirePackage{helvet}
\ifgrayscalespec
  % In the grayscale version of the spec, Helvetica bold is used for class
  % names in the text, and the width of the words then is too big unless
  % we scale down the font even more compared to the regular case below.
  \def\Hv@scale{0.814}
\else
  \def\Hv@scale{0.87}
\fi

% The following sets up txtt for the typewriter font.

\renewcommand{\ttdefault}{txtt}
\DeclareMathAlphabet{\mathtt}{OT1}{txtt}{m}{n}
\SetMathAlphabet{\mathtt}{bold}{OT1}{txtt}{b}{n}

% The next bit is an adaption of code from ot1phv.fd and adapted to the txtt
% fonts.  The txtt fonts are just a tad too big, so this tries to rescale
% them down a tiny bit.  This isn't completely right because I couldn't
% figure out the right syntax when the DeclareFontShape uses ssub below.
% (Notice how the ones with ssub don't have the \Txtt@@scale factor.)

\def\Txtt@scale{0.97}
\edef\Txtt@@scale{s*[\csname Txtt@scale\endcsname]}%

\DeclareFontFamily{OT1}{txtt}{\hyphenchar \font\m@ne}
\DeclareFontShape{OT1}{txtt}{m}{n}{	%rebular
     <-> \Txtt@@scale txtt%
}{}
\DeclareFontShape{OT1}{txtt}{m}{sc}{	%cap & small cap
     <-> \Txtt@@scale txttsc%
}{}
\DeclareFontShape{OT1}{txtt}{m}{sl}{	%slanted
     <-> \Txtt@@scale txttsl%
}{}
\DeclareFontShape{OT1}{txtt}{m}{it}{	%italic
     <-> ssub * txtt/m/sl%
}{}
\DeclareFontShape{OT1}{txtt}{m}{ui}{	%unslanted italic
     <-> ssub * txtt/m/sl%
}{}
\DeclareFontShape{OT1}{txtt}{b}{n}{	%bold
     <-> \Txtt@@scale txbtt%
}{}
\DeclareFontShape{OT1}{txtt}{b}{sc}{	%bold cap & small cap
     <-> \Txtt@@scale txbttsc%
}{}
\DeclareFontShape{OT1}{txtt}{b}{sl}{	%bold slanted
     <-> \Txtt@@scale txbttsl%
}{}
\DeclareFontShape{OT1}{txtt}{b}{it}{	%bold italic
     <-> ssub * txtt/b/sl%
}{}
\DeclareFontShape{OT1}{txtt}{b}{ui}{	%bold unslanted italic
     <-> ssub * txtt/b/sl%
}{}
\DeclareFontShape{OT1}{txtt}{bx}{n}{	%bold extended
     <-> ssub * txtt/b/n%
}{}
\DeclareFontShape{OT1}{txtt}{bx}{sc}{	%bold extended cap & small cap
     <-> ssub * txtt/b/sc%
}{}
\DeclareFontShape{OT1}{txtt}{bx}{sl}{	%bold extended slanted
     <-> ssub * txtt/b/sl%
}{}
\DeclareFontShape{OT1}{txtt}{bx}{it}{	%bold extended italic
     <-> ssub * txtt/b/sl%
}{}
\DeclareFontShape{OT1}{txtt}{bx}{ui}{	%bold extended unslanted italic
     <-> ssub * txtt/b/sl%
}{}


%% ----------------------------------------------------------------------------
%% Main code.
%% ----------------------------------------------------------------------------

% Local color definitions.

\definecolor{sbmlblue}{rgb}{0.07,0.50,0.78}
\definecolor{sbmlgray}{gray}{0.7}
\definecolor{sbmlrowgray}{gray}{0.96}
\definecolor{extremelylightgray}{gray}{0.97}
\definecolor{veryverylightgray}{gray}{0.95}
\definecolor{verylightgray}{gray}{0.9}
\definecolor{lightgray}{gray}{0.8}
\definecolor{mediumgray}{gray}{0.5}
\definecolor{darkgray}{gray}{0.3}
\definecolor{almostblack}{gray}{0.23}
\definecolor{lightyellow}{rgb}{0.98,0.94,0.7}
\definecolor{verylightyellow}{rgb}{0.97,0.95,0.85}
\definecolor{darkblue}{rgb}{0.1,0.4,0.55}
\definecolor{mediumgreen}{rgb}{0.1,0.6,0.3}

\definecolor{normaltextcolor}{gray}{0.25} % Synonym for 'almostblack'
\definecolor{normalliteralcolor}{gray}{0}
\definecolor{linenumbercolor}{gray}{0.65}
\definecolor{sbmlchangedcolor}{rgb}{0.69,0.19,0.376}

% Macros and settings for making consistent font, color, and other
% selections.
%
% If we're outputting grayscale, we don't use the red changed color because
% the result on most printers is text that a hard-to-read light gray color.

\ifgrayscalespec
  \colorlet{@sbmlchangedcolor}{normaltextcolor}
\else
  \colorlet{@sbmlchangedcolor}{sbmlchangedcolor}
\fi
\colorlet{@sectionnumcolor}{normaltextcolor}
\colorlet{@literalcolor}{normalliteralcolor}

\newcommand{\changed}[1]{%
  \protect\colorlet{@currentliteralcolor}{@literalcolor}%
  \protect\colorlet{@currentsectionnumcolor}{@sectionnumcolor}%
  \protect\colorlet{@literalcolor}{sbmlchangedcolor}%
  \protect\colorlet{@sectionnumcolor}{sbmlchangedcolor}%
  \textcolor{sbmlchangedcolor}{#1}%
  \protect\colorlet{@literalcolor}{@currentliteralcolor}%
  \protect\colorlet{@sectionnumcolor}{@currentsectionnumcolor}}

\newenvironment{blockChanged}{%
  \colorlet{@currentliteralcolor}{@literalcolor}%
  \colorlet{@currentsectionnumcolor}{@sectionnumcolor}%
  \colorlet{@literalcolor}{sbmlchangedcolor}%
  \colorlet{@sectionnumcolor}{sbmlchangedcolor}%
  \color{sbmlchangedcolor}%
}{%
  \color{normaltextcolor}%
  \colorlet{@literalcolor}{@currentliteralcolor}%
  \colorlet{@sectionnumcolor}{@currentsectionnumcolor}}

\newcommand{\figureFont}[1]{\textsf{\textbf{#1}}}

\newcommand{\literalFont}[1]{\textcolor{@literalcolor}{\textup{\ttfamily{#1}}}}
\newcommand{\literalFontNC}[1]{\textup{\ttfamily{#1}}}

\newcommand{\normalbaselinestretch}{1.0}
\newcommand{\tightspacing}{\renewcommand{\baselinestretch}{0.85}}
\newcommand{\regularspacing}{\renewcommand{\baselinestretch}{\normalbaselinestretch}}

\ifgrayscalespec
  \newcommand{\defRef}[2]{\textbf{\class{#1}}\xspace}
  \newcommand{\absDefRef}[2]{\textbf{\abstractclass{#1}}\xspace}
\else
  \newcommand{\defRef}[2]{\class{\hyperref[#2]{#1}}\xspace}
  \newcommand{\absDefRef}[2]{\abstractclass{\hyperref[#2]{#1}}\xspace}
  \newcommand{\absDefRefUpright}[2]{\abstractclassUpright{\hyperref[#2]{#1}}\xspace}
\fi

\renewcommand{\texttt}[1]{\textcolor{@literalcolor}{\ttfamily #1}}

% Hyperref extras.

\newcommand{\link}[2]{\literalFontNC{\href{#1}{#2}}}
\newcommand{\mailto}[1]{\link{mailto:#1}{#1}}

% Lineno options.
% The BeginAccSupp business causes the line numbers to be ignored for
% copy-paste operations in the PDF output, at least in Acrobat.

\setlength{\linenumbersep}{2.6em}
\renewcommand{\linenumberfont}{\tiny\sffamily}
\renewcommand{\thelinenumber}{%
  \BeginAccSupp{ActualText={}}%
  \textcolor{linenumbercolor}{\parbox[b][\height+1.5pt][c]{10pt}{\arabic{linenumber}}}%
  \EndAccSupp{}%
}

% Adjustments to package 'booktabs'.

\setlength{\cmidrulewidth}{0.3 pt}
\setlength{\lightrulewidth}{0.3 pt}
\setlength{\heavyrulewidth}{0.9 pt}

% 'PGF' package adjustments.

\pgfsetshortenstart{-3.25pt}
\pgfsetshortenend{-4pt}

% Fix placement of figures & tables.  This keeps latex from shoving big
% floats to the end of a document when they are somewhat big, which it will
% do even if you put [htb] as the argument.

\setcounter{topnumber}{2}
\renewcommand\topfraction{1.0}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{1.0}
\renewcommand\textfraction{0.0}
\renewcommand\floatpagefraction{0.9}

% Spacing of floats.

\setlength{\intextsep}{17pt plus 6pt minus 4pt}

% Make floats that appear alone on a page appear at the top, rather than
% (as is the LaTeX default) appearing centered vertically on the page.

\setlength{\@fptop}{5pt}

% Margin adjustments. I've tried using vmargin.sty, but it interacts badly
% with page numbers at the bottom of the page, so I've resorted to hardcoding
% the dimensions like this.

\setlength{\marginparwidth}{0 pt}
\setlength{\oddsidemargin}{0 pt}
\setlength{\evensidemargin}{0 pt}
\setlength{\marginparsep}{0 pt}
\setlength{\topmargin}{-8 ex}
\setlength{\voffset}{0 in}
\setlength{\hoffset}{0 in}
\setlength{\textwidth}{6.5 in}
\setlength{\textheight}{9 in}

% Set the table of contents depth

\setcounter{tocdepth}{2}

% Title style.  This is severely hacked from the orginal article.cls code.

\def\address#1{\gdef\@address{#1}}
\def\@address{\@latex@warning@no@line{No \noexpand\address given}}

\def\authoremail#1{\gdef\@authoremail{#1}}
\def\@authoremail{}

\def\acknowledge#1{\gdef\@acknowledge{#1}}
\def\@acknowledge{}

\def\@puttitle{%
  \rule{\textwidth}{0.01in}\\[\medskipamount]
  {\sffamily\bfseries\LARGE \@title \par}%
  \vskip -2pt%
  \rule{\textwidth}{0.01in}}

\def\@putauthorinfo{%
  \large
  \renewcommand{\arraystretch}{0.95}%
  \begin{tabular}[t]{c}%
    \@author
  \end{tabular}}

\def\sbmltableofcontents{%
  \if@notoc
  \else
    \begingroup
      \small%
      % Tighten spacing between lines within an entry.
      % This assumes 10 pt font!
      \setlength{\baselineskip}{9pt}%
      % Now adjust inter-entry spacing.
      \addtolength{\parskip}{-1.35 ex}%
      \if@twocolumntoc
        \setlength{\columnsep}{16pt}%
        \begin{multicols}{2}
      \fi
      \tableofcontents%
      \if@twocolumntoc
        \end{multicols}
      \fi
      \normalsize%
      \addtolength{\parskip}{1.45 ex}%
    \endgroup
  \fi}

\def\ps@myheadings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\thepage\hfil\slshape\leftmark}%
  \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
  \let\@mkboth\@gobbletwo
  \let\sectionmark\@gobble
  \let\subsectionmark\@gobble
  }

\renewcommand\maketitle{\par
  \begingroup
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
  \long\def\@makefntext##1{\parindent 1em\noindent
    \hb@xt@1.8em{%
      \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
  \if@twocolumn
    \ifnum \col@number=\@ne
      \@maketitle
    \else
      \twocolumn[\@maketitle]%
    \fi
  \else
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
  \fi
  \thispagestyle{empty}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\@authoremail\@empty
  \global\let\@address\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  }

\newcommand\maketitlepage{\par
  \begingroup
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
  \long\def\@makefntext##1{\parindent 1em\noindent
    \hb@xt@1.8em{%
      \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
  \vskip 2em%
  \if@twocolumn
    \ifnum \col@number=\@ne
      \@maketitle
    \else
      \twocolumn[\@maketitle]%
    \fi
  \else
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
  \fi
  \thispagestyle{empty}\@thanks
  \vfill
  \sbmltableofcontents
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\@authoremail\@empty
  \global\let\@address\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  }

\def\@maketitle{%
  \newpage
  \null
  \begin{center}%
    \let \footnote \thanks
    \@puttitle
    \vskip 2em%
    {\lineskip .5em%
      \@putauthorinfo
      }%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par%
  \vskip 1.5em%
%  \ifpdf
%    \hypersetup{pdftitle={\@title},pdfauthor={\@author}}
%  \fi%
  }

% Definition of paragraph style.

\setlength{\parindent}{0 pt}            % Unindented paragraphs, separated ...
\setlength{\parskip}{1.3 ex}            % ... by roughly one blank line.
\setlength{\partopsep}{-1ex plus 0.1ex minus -0.2ex}
\setlength{\itemsep}{-0.25ex plus 0.15ex}

% \topsep is supposed to affect list environments like itemize,
% but does nothing there.  Instead, it affects environments like tabular.

\setlength{\topsep}{0.3ex plus 0.1ex minus -0.2ex}

% Definition of section heading style.
% The "changed" versions put the numbers in red, to indicate a change
% in section numbers.

\renewcommand\@seccntformat[1]{%
  \color{@sectionnumcolor}{\csname the#1\endcsname}\hspace{0.5em}}

\renewcommand{\section}{%
  \@startsection{section}{1}{0pt}{-1.8ex \@plus -1ex \@minus -.2ex}%
  {0.8ex}{\clearpage\normalfont\Large\bfseries\sffamily}}

\newcommand{\sectionChanged}[1]{%
  \colorlet{@currentsectionnumcolor}{@sectionnumcolor}%
  \colorlet{@sectionnumcolor}{sbmlchangedcolor}%
  \section{#1}%
  \colorlet{@sectionnumcolor}{@currentsectionnumcolor}}

\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{0pt}{-2ex \@plus 1ex \@minus -.2ex}%
  {0.8ex}{\large\bfseries\sffamily}}

\newcommand{\subsectionChanged}[1]{%
  \colorlet{@currentsectionnumcolor}{@sectionnumcolor}%
  \colorlet{@sectionnumcolor}{sbmlchangedcolor}%
  \subsection{#1}%
  \colorlet{@sectionnumcolor}{@currentsectionnumcolor}}

\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{0pt}{-1.5ex \@plus 1ex \@minus -.2ex}%
  {0.5ex}{\slshape\normalsize\bfseries\sffamily}}

\newcommand{\subsubsectionChanged}[1]{%
  \colorlet{@currentsectionnumcolor}{@sectionnumcolor}%
  \colorlet{@sectionnumcolor}{sbmlchangedcolor}%
  \subsubsection{#1}%
  \colorlet{@sectionnumcolor}{@currentsectionnumcolor}}

\renewcommand{\paragraph}{%
  \@startsection{paragraph}{4}{0pt}{-1.25ex \@plus 1ex \@minus -.2ex}%
  {0.5ex}{\slshape\normalsize\sffamily}}

\newcommand{\paragraphChanged}[1]{%
  \colorlet{@currentsectionnumcolor}{@sectionnumcolor}%
  \colorlet{@sectionnumcolor}{sbmlchangedcolor}%
  \paragraph{#1}%
  \colorlet{@sectionnumcolor}{@currentsectionnumcolor}}

% The following is a modified version of the macro from article.cls.
% It adjusts the vertical spacing in TOC for section lines.

\renewcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{0.2ex \@plus\p@}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries\sffamily
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}

\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\if@twocolumntoc\else
      \leftskip #2
     \fi
     \relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \if@twocolumntoc\else
       \parindent #2
     \fi
     \relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {\sffamily #4}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont\sffamily #5}%
     \par}%
  \fi}

% The following is a hacked version of @trivlist from latex.ltx
% to try to fix initial spacing problems (\topsep doesn't seem to
% do anything.)

\newlength{\listSpaceAdjustment}
\setlength{\listSpaceAdjustment}{0.9ex}

\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{\hss\llap{##1}}}%
  \fi
  \vspace*{-\listSpaceAdjustment}}

\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}}%
  \fi
  \vspace*{-\listSpaceAdjustment}}

% The following is modified from natbib.sty, version 1999/05/28 7.0.
% This ensures that the References section gets a TOC entry.

\renewcommand{\bibsection}{%
  \addcontentsline{toc}{section}{\protect\textbf{\textsf{\refname}}}%
  \section*{\refname}}

% The following was ripped out of caption.sty, version 1.4b.
% Copyright (C) 1994-95 Harald Axel Sommerfeldt
% The first few lines set up the parameters for the layout created
% by this style file.

\newcommand{\captionsize}{\small}
\newcommand{\captionfont}{\captionsize\sffamily\slshape}
\newcommand{\captionlabelfont}{\captionsize\bfseries\slshape}
\newlength{\captionmargin}
\setlength{\captionmargin}{6ex}

\newsavebox{\as@captionbox}
\newlength{\as@captionwidth}
\newcommand{\as@normalcaption}[2]{%
  #1 #2\par}
\let\as@caption\as@normalcaption
\newcommand{\as@centercaption}[2]{%
  \parbox[t]{\as@captionwidth}{{\centering#1 #2\par}}}
\let\as@shortcaption\as@centercaption
\newcommand{\as@makecaption}[2]{%
  \setlength{\leftskip}{\captionmargin}%
  \setlength{\rightskip}{\captionmargin}%
  \addtolength{\as@captionwidth}{-2\captionmargin}%
  \renewcommand{\baselinestretch}{0.9}%
  \captionfont%
  \sbox{\as@captionbox}{{\captionlabelfont #1:} #2}%
  \ifdim \wd\as@captionbox >\as@captionwidth
    \as@caption{{\captionlabelfont #1:}}{#2}%
  \else%
    \as@shortcaption{{\captionlabelfont #1:}}{#2}%
  \fi}
\renewcommand{\@makecaption}[2]{%
  \vskip\abovecaptionskip%
  \setlength{\as@captionwidth}{\linewidth}%
  \as@makecaption{#1}{#2}%
  \vskip\belowcaptionskip}
\ifx\@makerotcaption\undefined
\else
  \typeout{\space\space\space\space\space\space\space\space\space
           `rotating' package detected}
  \renewcommand{\@makerotcaption}[2]{%
    \renewcommand{\baselinestretch}{0.9}
    \captionfont%
    \sbox{\as@captionbox}{{\captionlabelfont #1:} #2}%
    \ifdim \wd\as@captionbox > .8\vsize
      \rotatebox{90}{%
        \setlength{\as@captionwidth}{.8\textheight}%
        \begin{minipage}{\as@captionwidth}%
          \as@caption{{\captionlabelfont #1:}}{#2}%
        \end{minipage}}\par
    \else%
      \rotatebox{90}{\usebox{\as@captionbox}}%
    \fi
    \hspace{12pt}}
\fi
\ifx\floatc@plain\undefined
\else
  \typeout{\space\space\space\space\space\space\space\space\space
           `float' package detected}
  \renewcommand\floatc@plain[2]{%
    \setlength{\as@captionwidth}{\linewidth}%
    \as@makecaption{#1}{#2}}
  \ifx\as@ruled\undefined
  \else
    \renewcommand\floatc@ruled[2]{%
      \setlength{\as@captionwidth}{\linewidth}%
      \renewcommand{\baselinestretch}{0.9}
      \captionfont%
      \as@caption{{\captionlabelfont #1:}}{#2}}
  \fi
\fi

%
% Additional new commands.
%

% Class and data type formatting macros.

\newcommand{\class}[1]{\figureFont{#1}}  % only SBML UML classes
\newcommand{\abstractclass}[1]{\textsl{\figureFont{#1}}} % abstract classes
\newcommand{\abstractclassUpright}[1]{\textup{\figureFont{#1}}} % abstract classes
\newcommand{\primtype}[1]{\literalFont{#1}} % double, SId, SBOTerm, IDREF, etc.
\newcommand{\primtypeNC}[1]{\literalFontNC{#1}} % same, but without coloring
\newcommand{\token}[1]{\literalFont{#1}}    % everything else
\newcommand{\tokenNC}[1]{\literalFontNC{#1}}    % everything else, no color
\newcommand{\val}[1]{``\token{#1}''}        % a value in XML
\newcommand{\uri}[1]{\literalFont{#1}}      % URIs instead of URLs

% Code examples.

\newenvironment{example}{%
  \begin{quote}%
    \begin{small}%
      \tightspacing%
      \begin{alltt}}
    {\end{alltt}%
  \end{small}%
\end{quote}}

\newenvironment{exampleTight}{%
  \begin{quote}%
    \begin{small}%
      \tightspacing%
      \renewcommand{\baselinestretch}{0.7}%
      \begin{alltt}}
    {\end{alltt}%
  \end{small}%
\end{quote}}

% A list with wider left margins.  Don't ask me to explain the
% combination of arguments because this isn't what I get by reading
% p. 145 of the laTeX Companion 2nd ed.  I found this by trial and
% error.

\newenvironment{sbmlenum}
 {\begin{list}{}
   {\addtolength{\leftmargin}{2ex}
    \addtolength{\itemindent}{-1.85ex}}}
 {\end{list}}

% The font adjustments on the hline's below are very dependent on the
% font in use.  Use 1.2em for Helvetica, 0.98em (1st) 0.95 (2nd) for
% the default Latex sans serif.

\newenvironment{classbox}[1]{%
  \sffamily%
  \small%
  \setlength{\arrayrulewidth}{0.5pt}
  \begin{tabular}[t]{|l|}
    \hline \\[-1.2em]
    \multicolumn{1}{|c|}{\textbf{#1}}\\
    \hline \\[-1.2em]}
{\hline\end{tabular}}

\newcommand{\emptyClassbox}[1]{%
  \sffamily%
  \small%
  \setlength{\arrayrulewidth}{0.5pt}%
  \begin{tabular}[t]{|l|}%
    \hline \\[-1.2em]
    \multicolumn{1}{|c|}{\textbf{#1}}\\
    \hline
  \end{tabular}}

% Including the logo on the front page.  We switch which copy of the logo
% file we use, depending on various factors, and we switch which file format
% is used depending on the output we're producing. 

\ifgrayscalespec
  \newcommand{\logofilebasename}{sbml-logo-gray}
\else
  \newcommand{\logofilebasename}{sbml-logo}
\fi

\ifpdf
  % Request the JPG format specifically, because the resulting
  % quality in the final output is best.
  \newcommand{\SBMLLogoFile}{\logofilebasename.jpg}%
\else%
  \newcommand{\SBMLLogoFile}{\logofilebasename.eps}%
\fi

% Graphics adjustments.  The path setup is so that the \includegraphics
% in the @puttile definition can find the logo file no matter where the
% document is located (but obviously, it only works for certain path
% combinations -- it's a total hack).

\graphicspath{{./logos/}
  {../tex/logos/}
  {../project/tex/logos/}
  {../../project/tex/logos/}
  {../../../project/tex/logos/}
  {../../../../project/tex/logos/}}

% Miscellaneous macros for convenience.

\newcommand{\D}           {\displaystyle}
\newcommand{\tm}          {\textsuperscript{\tiny{\texttrademark}}}

\newcommand{\eg}          {e.g.,\xspace}
\newcommand{\ie}          {i.e.,\xspace}

\newcommand{\quantity}[1] {\emph{#1}}

\newcommand{\sbmlone}     {SBML Level~1\xspace}
\newcommand{\sbmltwo}     {SBML Level~2\xspace}
\newcommand{\sbmlthree}   {SBML Level~3\xspace}

\newcommand{\twoone}      {Level~2 Version~1\xspace}
\newcommand{\twotwo}      {Level~2 Version~2\xspace}
\newcommand{\twothree}    {Level~2 Version~3\xspace}
\newcommand{\twofour}     {Level~2 Version~4\xspace}

\newcommand{\sbmlonetwo}  {SBML Level~1 Version~2\xspace}
\newcommand{\sbmltwoone}  {SBML \twoone}
\newcommand{\sbmltwotwo}  {SBML \twotwo}
\newcommand{\sbmltwothree}{SBML \twothree}
\newcommand{\sbmltwofour} {SBML \twofour}

\newcommand{\xmlschema}   {XML~Schema\xspace}
\newcommand{\xmlschemaone}{XML Schema~1.0\xspace}
\newcommand{\mathml}      {MathML\xspace}
\newcommand{\mathmltwo}   {MathML~2.0\xspace}

\newcommand{\lenov}       {Le~Nov\`{e}re\xspace}

\newcommand{\dblquote}{\verb|"|}

% 
% Final settings before the body begins.
%

\raggedbottom
\color{normaltextcolor}                % Default body text color.

%% -----------------------------------------------------------------------------
%% End of file `cekarticle.cls'.
%% -----------------------------------------------------------------------------

