%% Filename    : sbmlpkgspec.cls
%% Description : LaTeX style file for SBML Level 3 package specifications
%% Author(s)   : Michael Hucka <mhucka@caltech.edu>
%% Organization: California Institute of Technology
%% Created     : 2011-08-11
%%
%% Copyright 2007-2011 California Institute of Technology
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

\def\filedate{2011/10/03}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{sbmlpkgspec}[\filedate\space SBML Level 3 Package Specification Style]

%% ----------------------------------------------------------------------------
%% Package references and options.
%% ----------------------------------------------------------------------------

%% Keep in mind that hyperref needs to be almost the last package loaded.

\newif\if@draftspec
\DeclareOption{draftspec}{\global\let\if@draftspec\iftrue}
\DeclareOption{finalspec}{\global\let\if@draftspec\iffalse}

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

\RequirePackage{lastpage}
\RequirePackage{ifpdf}
\RequirePackage{booktabs}
\RequirePackage{multicol}
\RequirePackage{array}
\RequirePackage[round]{natbib}
\RequirePackage{xspace}
\RequirePackage{scalefnt}
\RequirePackage{pifont}
\RequirePackage[pagewise,mathlines,edtable,right]{lineno}
\RequirePackage{calc}
\RequirePackage{fancyhdr}
\RequirePackage{amssymb}
\RequirePackage{wasysym}
\RequirePackage{enumitem}

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

% \RequirePackage{html}

% \latexhtml{
%begin{latexonly}
  \RequirePackage[american]{varioref}
%end{latexonly}
% }{
%  \newcommand{\vref}[1]{\ref{#1}}
% }

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
    pdfhighlight=/O,linkcolor={sbmlblue},citecolor={sbmlblue},
    urlcolor={sbmlblue},bookmarksnumbered]{hyperref}
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
  % \latexhtml{
    % For latex.
    \RequirePackage[breaklinks]{hyperref}
  % }{
    % For latex2html.
    % \RequirePackage[latex2html,breaklinks]{hyperref}
  % }
  \RequirePackage[rgb,dvipsnames,svgnames,hyperref,table]{xcolor}
\fi

% The following is best loaded after hyperref.
\RequirePackage{nameref}

% Load listings package & set some values.
\RequirePackage{listings}
\lstloadlanguages{Java,[Visual]C++,csh,Matlab,make,Perl,Python}

% Load draftwatermark if this document is a draft version.
\if@draftspec
  \RequirePackage[firstpage]{draftwatermark}
  \SetWatermarkLightness{0.92}
\fi


%% ----------------------------------------------------------------------------
%% Font selection.
%% ----------------------------------------------------------------------------

% This sets up Helvetica for headings and TX Typewriter for the tt font.
% The font scaling is because the default Helvetica size is too big.

\RequirePackage[T1]{fontenc}
\RequirePackage{fourier}
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
\DeclareMathAlphabet{\mathtt}{T1}{txtt}{m}{n}
\SetMathAlphabet{\mathtt}{bold}{T1}{txtt}{b}{n}

% The next bit is an adaption of code from ot1phv.fd and adapted to the txtt
% fonts.  The txtt fonts are just a tad too big, so this tries to rescale
% them down a tiny bit.  This isn't completely right because I couldn't
% figure out the right syntax when the DeclareFontShape uses ssub below.
% (Notice how the ones with ssub don't have the \Txtt@@scale factor.)

\def\Txtt@scale{0.97}
\edef\Txtt@@scale{s*[\csname Txtt@scale\endcsname]}%

\DeclareFontFamily{T1}{txtt}{\hyphenchar \font\m@ne}
\DeclareFontShape{T1}{txtt}{m}{n}{	%rebular
     <-> \Txtt@@scale txtt%
}{}
\DeclareFontShape{T1}{txtt}{m}{sc}{	%cap & small cap
     <-> \Txtt@@scale txttsc%
}{}
\DeclareFontShape{T1}{txtt}{m}{sl}{	%slanted
     <-> \Txtt@@scale txttsl%
}{}
\DeclareFontShape{T1}{txtt}{m}{it}{	%italic
     <-> ssub * txtt/m/sl%
}{}
\DeclareFontShape{T1}{txtt}{m}{ui}{	%unslanted italic
     <-> ssub * txtt/m/sl%
}{}
\DeclareFontShape{T1}{txtt}{b}{n}{	%bold
     <-> \Txtt@@scale txbtt%
}{}
\DeclareFontShape{T1}{txtt}{b}{sc}{	%bold cap & small cap
     <-> \Txtt@@scale txbttsc%
}{}
\DeclareFontShape{T1}{txtt}{b}{sl}{	%bold slanted
     <-> \Txtt@@scale txbttsl%
}{}
\DeclareFontShape{T1}{txtt}{b}{it}{	%bold italic
     <-> ssub * txtt/b/sl%
}{}
\DeclareFontShape{T1}{txtt}{b}{ui}{	%bold unslanted italic
     <-> ssub * txtt/b/sl%
}{}
\DeclareFontShape{T1}{txtt}{bx}{n}{	%bold extended
     <-> ssub * txtt/b/n%
}{}
\DeclareFontShape{T1}{txtt}{bx}{sc}{	%bold extended cap & small cap
     <-> ssub * txtt/b/sc%
}{}
\DeclareFontShape{T1}{txtt}{bx}{sl}{	%bold extended slanted
     <-> ssub * txtt/b/sl%
}{}
\DeclareFontShape{T1}{txtt}{bx}{it}{	%bold extended italic
     <-> ssub * txtt/b/sl%
}{}
\DeclareFontShape{T1}{txtt}{bx}{ui}{	%bold extended unslanted italic
     <-> ssub * txtt/b/sl%
}{}


%% ----------------------------------------------------------------------------
%% Main code.
%% ----------------------------------------------------------------------------

\raggedbottom

% Local color definitions.

\definecolor{sbmlblue}{rgb}{0.08,0.51,0.77}
\definecolor{sbmlgray}{gray}{0.7}
\definecolor{sbmlrowgray}{gray}{0.94}
\definecolor{extremelylightgray}{gray}{0.97}
\definecolor{verylightgray}{gray}{0.9}
\definecolor{lightgray}{gray}{0.8}
\definecolor{mediumgray}{gray}{0.5}
\definecolor{darkgray}{gray}{0.3}
\definecolor{almostblack}{gray}{0.20}
\definecolor{lightyellow}{rgb}{0.995,0.97,0.93}
\definecolor{darkblue}{rgb}{0.1,0.4,0.55}
\definecolor{mediumgreen}{rgb}{0.1,0.6,0.3}

% Color for marking changed text, conditional on whether gray scale mode is on.

\ifgrayscalespec
  \newcommand{\sbmlchangedcolor}{\normaltextcolor}
\else
  \definecolor{sbmlchangedcolor}{rgb}{0.69,0.19,0.376}
  \newcommand{\sbmlchangedcolor}{Maroon}
\fi


% Macros for making consistent font, color, and other selections.

\newcommand{\normaltextcolor}{almostblack}

\newcommand{\changed}[1]{\textcolor{\sbmlchangedcolor}{#1}}
\newenvironment{blockChanged}{\color{\sbmlchangedcolor}}{\color{\normaltextcolor}}

\newcommand{\figureFont}[1]{\textsf{\textbf{#1}}}

\newcommand{\literalFont}[1]{\textcolor{black}{\textup{\texttt{#1}}}}
\newcommand{\literalFontNC}[1]{\textup{\texttt{#1}}}

\newcommand{\tightspacing}{\renewcommand{\baselinestretch}{0.85}}
\newcommand{\regularspacing}{\renewcommand{\baselinestretch}{1.0}}

\ifgrayscalespec
  \newcommand{\defRef}[2]{\textbf{\class{#1}}\xspace}
  \newcommand{\absDefRef}[2]{\textbf{\abstractclass{#1}}\xspace}
\else
  \newcommand{\defRef}[2]{\class{\hyperref[#2]{#1}}\xspace}
  \newcommand{\absDefRef}[2]{\abstractclass{\hyperref[#2]{#1}}\xspace}
\fi

% Hyperref extras.

\newcommand{\link}[2]{\literalFont{\href{#1}{#2}}}
\newcommand{\mailto}[1]{\link{mailto:#1}{#1}}

% 'lineno' package adjustments.

\setlength{\linenumbersep}{2.2em}
\renewcommand{\thelinenumber}{\textcolor{mediumgray}{\parbox[b][\height+1.5pt][c]{10pt}{\arabic{linenumber}}}}

% 'booktabs' package adjustments.

\setlength{\cmidrulewidth}{0.3 pt}
\setlength{\lightrulewidth}{0.3 pt}
\setlength{\heavyrulewidth}{0.9 pt}

% Fix placement of figures & tables.  This keeps latex from shoving big
% floats to the end of a document when they are somewhat big, which it will
% do even if you put [htb] as the argument.

\setcounter{topnumber}{2}
\renewcommand\topfraction{1.0}
\setcounter{bottomnumber}{2}
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

\setlength{\marginparwidth}{0.77in}
\setlength{\marginparsep}{3pt}

\setlength{\oddsidemargin}{0 pt}
\setlength{\evensidemargin}{0 pt}
\setlength{\topmargin}{-8 ex}
\setlength{\voffset}{0 in}
\setlength{\hoffset}{0 in}
\setlength{\textwidth}{6.5 in}
\setlength{\textheight}{9 in}

% Set the table of contents depth

\setcounter{tocdepth}{3}

% Title page macros.  Severly hacked from originals in LaTeX's article.cls.

\def\packageTitle#1{\title{#1}\gdef\@packageTitle{#1}}
\def\@packageTitle{\@empty}

\def\packageGeneralURL#1{\gdef\@packageGeneralURL{#1}}

\def\packageThisVersionURL#1{\gdef\@packageThisVersionURL{#1}}
\def\@packageThisVersionURL{\@empty}

\def\packageVersion#1{\gdef\@packageVersion{#1}}
\def\@packageVersion{\@empty}

\def\packageVersionDate#1{\gdef\@packageVersionDate{#1}}
\def\@packageVersionDate{\@empty}

\def\notice#1{\gdef\@notice{#1}}
\def\@notice{\@empty}

\def\@puttitle{%
  \ifx\@packageGeneralURL\undefined
  \relax
  \else
  {\large SBML Level 3 Package Specification}\\[2em]
  \fi
  \scalebox{1}[0.9]{%
    \fcolorbox{black}{mediumgray}{%
      \begin{minipage}{\textwidth - 7pt}%
        \vspace*{6pt}%
        \centering%
        \textcolor{white}{\sffamily\bfseries\huge \ifx\@title\@empty\@packageTitle\else\@title\fi}
      \vspace*{4pt}%
    \end{minipage}}}}

\def\@putauthorinfo{%
  \large
  \renewcommand{\arraystretch}{0.95}%
  {\begin{tabular}[t]{c}%
   \@author
  \end{tabular}}}

\def\maketableofcontents{%
  \if@notoc
  \else
    \begingroup
      \small%
      % Tighten spacing between lines within an entry.
      % This assumes 10 pt font!
      \setlength{\baselineskip}{10pt}%
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
    \clearpage
  \fi%
  \linenumbers}

% Need redefine \tableofcontents to counter effects of hacking \section below.

\renewcommand\tableofcontents{%
  \@startsection{section}{0}{0pt}{-1.8ex \@plus -1ex \@minus -.2ex}%
  {0.8ex}{\normalfont\Large\bfseries\sffamily}*% The star fakes a \section*
  \contentsname%
  \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
  \@starttoc{toc}%
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
  \centering%
  \begin{minipage}{5.45in}\color{DarkRed}\@notice\end{minipage}%
  \vfill
  \ifx\@packageGeneralURL\undefined
  \relax
  \else
    The latest release, past releases, and other materials related to this specification are available at\\
    {\small\url{\@packageGeneralURL}}\\[2em]
    \emph{This} release of the specification is available at\\
    {\small\url{\@packageThisVersionURL}}\\
    \vfill
  \fi
  \centerline{\includegraphics[width=1in]{\SBMLbadge}}
  \clearpage
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
    \vskip 3em%
    {\lineskip .5em%
      \@putauthorinfo
      }%
    \vskip 3em%
    {\large\@packageVersionDate}%
    \vskip 2em%
    {\large\fbox{\@packageVersion}}%
  \end{center}%
  \par%
  \vskip 1.5em%
  \ifpdf
    \hypersetup{pdftitle={\@title}}
  \fi%
  }


% Including the logo on the front page.  We switch which copy of the logo
% file we use, depending on various factors, and we switch which file format
% is used depending on the output we're producing. 

\ifgrayscalespec
  \newcommand{\badgebasefile}{sbml-badge-gray}
\else
  \newcommand{\badgebasefile}{sbml-badge}
\fi

\ifpdf
  % Request the JPG format specifically, because the resulting
  % quality in the final output is best.
  \newcommand{\SBMLbadge}{\badgebasefile.jpg}%
\else%
  \newcommand{\SBMLbadge}{\badgebasefile.eps}%
\fi


% Graphics adjustments.  The path setup is so that the \includegraphics
% in the @puttile definition can find the logo file no matter where the
% document is located (but obviously, it only works for certain path
% combinations -- it's a total hack).

\graphicspath{{./logos/}{../tex/logos/}{../project/tex/logos/}{../../project/tex/logos/}{../../../project/tex/logos/}{../../../../project/tex/logos/}}


% Set the page footers.
% Must do this after setting the document title.

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrule}{}
\cfoot{\small{Page \thepage\ of \pageref*{LastPage}}}
\if@draftspec
  \lfoot{\small{SBML Level 3 Package Specification (DRAFT)}}
\else
  \lfoot{\small{SBML Level 3 Package Specification}}
\fi
\rfoot{\small{\@packageTitle}}


% Definition of paragraph style.

\setlength{\parindent}{0 pt}            % Unindented paragraphs, separated ...
\setlength{\parskip}{1.3 ex}            % ... by roughly one blank line.
\setlength{\partopsep}{-1ex plus 0.1ex minus -0.2ex}
\setlength{\itemsep}{-0.25ex plus 0.15ex}

% \topsep is supposed to affect list environments like itemize,
% but does nothing there.  Instead, it affects environments like tabular.

\setlength{\topsep}{0.3ex plus 0.1ex minus -0.2ex}


% Definition of section heading style.

\newlength{\headingwidth}
\setlength{\headingwidth}{\textwidth}
\addtolength{\headingwidth}{33pt}

\renewcommand{\section}{\@startsection%
  {section}{1}{0pt \@plus 1ex}{-3ex \@plus -1ex \@minus -.2ex}%
  {1.2ex}{\clearpage\hspace*{-24.25pt}\color{sbmlgray}{\rule[1.8em]{6.84in}{0.6em}}\color{\normaltextcolor}%
    \hspace*{-6.84in}\color{sbmlgray}{\rule[-0.8em]{6.84in}{0.1em}}\color{\normaltextcolor}%
    \noindent\normalfont\LARGE\bfseries\sffamily\hspace*{-6.84in}}}

\renewcommand{\subsection}{\@startsection%
  {subsection}{2}{0pt}{-2ex \@plus 1ex \@minus -.2ex}%
  {0.1ex}{\Large\bfseries\sffamily}}

\renewcommand{\subsubsection}{\@startsection%
  {subsubsection}{3}{0pt}{-1.5ex \@plus 1ex \@minus -.2ex}%
  {0.4ex}{\large\bfseries\sffamily\slshape}}

\renewcommand{\paragraph}{\@startsection%
  {paragraph}{4}{0pt}{-1.25ex \@plus 1ex \@minus -.2ex}%
  {0.4ex}{\normalsize\bfseries\sffamily\slshape}}

% The References heading needs to be fixed up to account for shift
% we apply to section headings.  These defs are modified from article.cls.

\bibliographystyle{apalike}

\renewenvironment{thebibliography}[1]%
{\section*{References}%
  \addcontentsline{toc}{section}{\protect\numberline{\refname}}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
  {\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}
{\def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}

\newcommand{\sectionspecial}{\@startsection%
  {section}{1}{0pt}{-1.8ex \@plus -1ex \@minus -.2ex}%
  {0.8ex}{\hspace*{-41.1pt}\colorbox{sbmlgray}{\hspace*{6.99in}}\nopagebreak\\%
  \hspace*{-20pt}\normalfont\Large\bfseries\sffamily}}

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

% The following is modified from natbib.sty, version 1999/05/28 7.0.
% This ensures that the References section gets a TOC entry.

\renewcommand{\bibsection}{%
  \addcontentsline{toc}{section}{\protect\textbf{\textsf{\refname}}}%
  \section*{\refname}}


% Redefine table & figure to use smaller font, sans serif,
% and to center contents by default.

\renewenvironment{table}[1][]  {\@float{table}[#1]\small\sffamily\centering}    {\end@float}
\renewenvironment{table*}[1][] {\@dblfloat{table}[#1]\small\sffamily\centering} {\end@dblfloat}
\renewenvironment{figure}[1][] {\@float{figure}[#1]\small\sffamily\centering}   {\end@float}
\renewenvironment{figure*}[1][]{\@dblfloat{figure}[#1]\small\sffamily\centering}{\end@dblfloat}


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
  \renewcommand{\baselinestretch}{0.9}
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

\newcommand{\class}[1]{\figureFont{#1}}     % only SBML UML classes
\newcommand{\abstractclass}[1]{\textsl{\figureFont{#1}}} % abstract classes
\newcommand{\primtype}[1]{\literalFont{#1}} % double, SId, SBOTerm, IDREF, etc.
\newcommand{\primtypeNC}[1]{\literalFontNC{#1}} % same, but without coloring
\newcommand{\token}[1]{\literalFont{#1}}    % everything else
\newcommand{\val}[1]{``\token{#1}''}        % a value in XML

% Macros used for defining validation rules.
% First, preliminary internal macros.

\newcommand{\vSymbol}{\textcolor{red}{$\Box\mkern-12mu\checkmark$}}
\newcommand{\vSymbolName}{checked box\xspace}
\newcommand{\cSymbol}{\textcolor{Goldenrod}{\scalefont{0.9}\ding{115}}}
\newcommand{\cSymbolName}{triangle\xspace}
\newcommand{\mSymbol}{\textcolor{Green}{$\bigstar$}}
\newcommand{\mSymbolName}{star\xspace}

\newcommand{\vsp}{\hspace*{4pt}}
\newcommand{\csp}{\hspace*{6.25pt}}
\newcommand{\msp}{\hspace*{4.9pt}}

% A list with wider left margins.  Don't ask me to explain the
% combination of arguments because this isn't what I get by reading
% p. 145 of the laTeX Companion 2nd ed.  I found this by trial and
% error.

\newenvironment{sbmlenum}
 {\begin{list}{}
   {\addtolength{\leftmargin}{5.25em}
    \addtolength{\itemindent}{-5.25em}}}
 {\end{list}}

% Now the actual user commands for validation rules.

\newcommand{\validRule}          [2]{\item[\textbf{\textsf{#1}}. \vSymbol\vsp] #2}
\newcommand{\consistencyRule}    [2]{\item[\textbf{\textsf{#1}}. \cSymbol\csp] #2}
\newcommand{\modelingRule}       [2]{\item[\textbf{\textsf{#1}}. \mSymbol\msp] #2}

% Code examples.
% First set the properties we use for all calls to the listing environment.

\lstset{escapechar=|,%
    language=XML,%
    columns=fullflexible,%
    keepspaces=true,%
    backgroundcolor=\color{extremelylightgray},%
    rulecolor=\color{sbmlgray},%
    frame=single,%
    basicstyle=\small\ttfamily,%
    xleftmargin=3.5pt,%
    xrightmargin=3.5pt,%
    aboveskip=1\baselineskip,%
    belowskip=0.4\baselineskip,%
    commentstyle=\footnotesize\itshape,%
    tabsize=2,%
    keywordstyle=\ttfamily}

\newcommand{\examplespacing}{\renewcommand{\baselinestretch}{0.88}}

\lstnewenvironment{example}
  {\examplespacing \csname lst@SetFirstLabel\endcsname}
  {\regularspacing \csname lst@SaveFirstLabel\endcsname}

\newcommand{\exampleFile}[1]{\examplespacing\lstinputlisting{#1}\regularspacing}


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


% Putting to-do's and questions into the document.

\newcommand{\todo}[2]{\mbox{}\marginpar%
  {\hspace{0pt}\colorbox{yellow}{\footnotesize%
      \begin{minipage}[t]{0.675in}\raggedright\fbox{#1}
        \textit{#2}\end{minipage}}}}

\newcommand{\question}[1]{\mbox{}\marginpar%
  {\hspace{0pt}\colorbox{GreenYellow}{\footnotesize%
      \begin{minipage}[t]{0.675in}Q: \raggedright\textit{#1}\end{minipage}}}}


% Line numbered environments.

\newenvironment{larray}{%
  \begin{linenomath}\setlength{\arraycolsep}{1.5pt}\begin{eqnarray}}%
  {\end{eqnarray}\end{linenomath}\par\vspace*{-0.7em}}

\newenvironment{larray*}{%
  \begin{linenomath}\setlength{\arraycolsep}{1.5pt}\begin{eqnarray*}}%
  {\end{eqnarray*}\end{linenomath}\par\vspace*{-0.7em}}


% Figure and table references.

\newcommand{\fig}[1]{Figure~\vref{#1}\xspace}
\newcommand{\tab}[1]{Table~\vref{#1}\xspace}
\newcommand{\sect}[1]{Section~\ref{#1}\xspace}


% Misc.

\newcommand{\dblquote}    {\verb|"|}


% Here we list common SBML entities, to get consistent font & appearance.

\newcommand{\AlgebraicRule}{\textbf{\class{AlgebraicRule}}\xspace}
\newcommand{\Annotation}{\textbf{\class{Annotation}}\xspace}
\newcommand{\AssignmentRule}{\textbf{\class{AssignmentRule}}\xspace}
\newcommand{\Compartment}{\textbf{\class{Compartment}}\xspace}
\newcommand{\Constraint}{\textbf{\class{Constraint}}\xspace}
\newcommand{\Delay}{\textbf{\class{Delay}}\xspace}
\newcommand{\EventAssignment}{\textbf{\class{EventAssignment}}\xspace}
\newcommand{\Event}{\textbf{\class{Event}}\xspace}
\newcommand{\FunctionDefinition}{\textbf{\class{FunctionDefinition}}\xspace}
\newcommand{\InitialAssignment}{\textbf{\class{InitialAssignment}}\xspace}
\newcommand{\KineticLaw}{\textbf{\class{KineticLaw}}\xspace}
\newcommand{\ListOfCompartments}{\textbf{\class{ListOfCompartments}}\xspace}
\newcommand{\ListOfConstraints}{\textbf{\class{ListOfConstraints}}\xspace}
\newcommand{\ListOfEventAssignments}{\textbf{\class{ListOfEventAssignments}}\xspace}
\newcommand{\ListOfEvents}{\textbf{\class{ListOfEvents}}\xspace}
\newcommand{\ListOfFunctionDefinitions}{\textbf{\class{ListOfFunctionDefinitions}}\xspace}
\newcommand{\ListOfInitialAssignments}{\textbf{\class{ListOfInitialAssignments}}\xspace}
\newcommand{\ListOfLocalParameters}{\textbf{\class{ListOfLocalParameters}}\xspace}
\newcommand{\ListOfModifierSpeciesReferences}{\textbf{\class{ListOfModifierSpeciesReferences}}\xspace}
\newcommand{\ListOfPackages}{\textbf{\class{ListOfPackages}}\xspace}
\newcommand{\ListOfParameters}{\textbf{\class{ListOfParameters}}\xspace}
\newcommand{\ListOfReactions}{\textbf{\class{ListOfReactions}}\xspace}
\newcommand{\ListOfRules}{\textbf{\class{ListOfRules}}\xspace}
\newcommand{\ListOfSpeciesReferences}{\textbf{\class{ListOfSpeciesReferences}}\xspace}
\newcommand{\ListOfSpecies}{\textbf{\class{ListOfSpecies}}\xspace}
\newcommand{\ListOfUnitDefinitions}{\textbf{\class{ListOfUnitDefinitions}}\xspace}
\newcommand{\ListOfUnits}{\textbf{\class{ListOfUnits}}\xspace}
\newcommand{\ListOf}{\class{ListOf\rule{0.3in}{0.5pt}}\xspace}
\newcommand{\LocalParameter}{\textbf{\class{LocalParameter}}\xspace}
\newcommand{\Message}{\textbf{\class{Message}}\xspace}
\newcommand{\Model}{\textbf{\class{Model}}\xspace}
\newcommand{\ModifierSpeciesReference}{\textbf{\class{ModifierSpeciesReference}}\xspace}
\newcommand{\Notes}{\textbf{\class{Notes}}\xspace}
\newcommand{\Package}{\textbf{\class{Package}}\xspace}
\newcommand{\Parameter}{\textbf{\class{Parameter}}\xspace}
\newcommand{\Priority}{\textbf{\class{Priority}}\xspace}
\newcommand{\RateRule}{\textbf{\class{RateRule}}\xspace}
\newcommand{\Reaction}{\textbf{\class{Reaction}}\xspace}
\newcommand{\Rule}{\textbf{\class{Rule}}\xspace}
\newcommand{\SBML}{\textbf{\class{SBML}}\xspace}
\newcommand{\SBase}{\textbf{\abstractclass{SBase}}\xspace}
\newcommand{\SimpleSpeciesReference}{\textbf{\class{SimpleSpeciesReference}}\xspace}
\newcommand{\SpeciesReference}{\textbf{\class{SpeciesReference}}\xspace}
\newcommand{\Species}{\textbf{\class{Species}}\xspace}
\newcommand{\StoichiometryMath}{\textbf{\class{StoichiometryMath}}\xspace}
\newcommand{\Trigger}{\textbf{\class{Trigger}}\xspace}
\newcommand{\UnitDefinition}{\textbf{\class{UnitDefinition}}\xspace}
\newcommand{\Unit}{\textbf{\class{Unit}}\xspace}


% 
% Final settings before the body begins.
%

\color{\normaltextcolor}                % Default body font color.

%% -----------------------------------------------------------------------------
%% End of file `cekarticle.cls'.
%% -----------------------------------------------------------------------------
