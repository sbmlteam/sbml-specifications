\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jib}[2016/11/11 v3.0 by Stephan Weise and Bjorn Sommer]
\DeclareOption*{%
   \PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
%  article.cls Version: 2004/02/16 v1.4f
%  jib.cls Version: 2016/11/11 v3.0f for de Gruyter
\LoadClass[12pt]{article}
% calc -> Tools Package
% textcomp -> base Package
% url -> ltxmisc Package
\RequirePackage{calc}[1998/07/07 v4.1b Infix arithmetic (KKT,FJ)]
\RequirePackage{url}[2004/03/15 ver 3.1 Verb mode for urls, etc.]
\RequirePackage{listings}[2004/09/07 1.3 Carsten Heinz]
\RequirePackage{caption}[2004/07/16 v3.0c Customising captions (AS)]
\RequirePackage{textcomp}[2004/02/22 v1.99f Standard LaTeX package]
\RequirePackage{helvet}[2004/02/22 v1.99f Standard LaTeX package]
% graphicx -> graphics Package
% epsfig -> graphics Package
\RequirePackage{graphicx}[1999/02/16 v1.0f  Enhanced LaTeX Graphics (DPC,SPQR)]
\RequirePackage{epsfig}[1999/02/16 v1.7a (e)psfig emulation (SPQR)]
% vmargin Package
\RequirePackage{vmargin}[2004/07/15 V2.5 set document margins (VK)]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In Case of using latex compiler (Standard)
%\RequirePackage[dvipdfm]{hyperref}[2003/11/30 v6.74m Hypertext links for LaTeX]

% Set default font to Helvetica (Arial)
\usepackage{helvet}
\renewcommand{\familydefault}{\sfdefault}

% In Case of using pdflatex compiler
\RequirePackage{hyperref}[2003/11/30 v6.74m Hypertext links for LaTeX]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Required for tabulator support for section titles
\usepackage{titlesec}



%\usepackage[scaled]{helvet}

\hypersetup{
  naturalnames=true,
  hypertexnames=false,
  pageanchor=false,
  plainpages=false,
  breaklinks=true,
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  filecolor=black,
  bookmarks=true,
  bookmarksopen=true,
}

\RequirePackage{eso-pic}

\pagenumbering{gobble}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Titelseitendefinition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{jibtitlepage}{%
  \sffamily% 
  \newcounter{institution}
  \renewcommand{\theinstitution}{\arabic{institution}}
  \newcommand{\addjibinstitution}{%
    \@ifstar{\@addjibinstitution}
            {\@addjibinstitutionwithreference}}
  \newcommand{\@addjibinstitution}[1]{
    \begin{center}{\small ##1}\end{center}}
  \newcommand{\@addjibinstitutionwithreference}[2]{%
    \begin{center}%
    \refstepcounter{institution}\label{##1}%
    \textsuperscript{\scriptsize{\theinstitution}}{\small ##2}%
    \end{center}}
    
  \newcommand{\jibtitle}[1]{\begin{center}\large\bfseries ##1\end{center}}
  \newcommand{\iref}[2][]{\textsuperscript{\scriptsize{\ref{##2}##1}}}
  \newcommand{\jibauthor}[1]{\begin{center}\small\bfseries ##1\end{center}}
  
  \newcommand{\jibfootnotemark}{}
  \newcommand{\jibfurtherfootnotes}{}
  \renewcommand{\@makefnmark}{\textsuperscript{\scriptsize{\jibfootnotemark\jibfurtherfootnotes}}}%
  \renewcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\textsuperscript{\scriptsize{\jibfootnotemark}}}##1}
  \newcommand{\jibauthorfootnote}[3][]{%
    \renewcommand{\jibfurtherfootnotes}{##1}%
    \renewcommand{\jibfootnotemark}{##2}%
    \footnote{##3}}
}
{\setcounter{footnote}{0}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Definition des Satzspiegels und Seitenlayouts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setpapersize{A4}
%\setlength{\paperwidth}{210mm}
%\setlength{\paperheight}{297mm}
\setmarginsrb{2.5cm}%{1in}%Rand links
             {2.5cm}%{12.5mm}%Rand oben
             {2.5cm}%{1in}%Rand rechts
             {1.25cm}%{12.5mm}%Rand unten
             {0cm}%Kopfhoehe
             {0cm}%Kopfabstand
             {1.25cm}%{2cm}%Fusshoehe
             {1.25cm}%{2.25cm}%Fussabstand
             
\setlength{\parindent}{0pt}
\setlength{\parskip}{1.5ex plus.2ex minus.2ex}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	URL-Definitionen und Anpassungen
%%  Infos: Package url
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\url@emailstyle{%
 \@ifundefined{selectfont}{\def\UrlFont{\sf}}{\def\UrlFont{\sffamily}}}
\DeclareUrlCommand\email{\urlstyle{email}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Header/Footer-Definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\jibvolume#1{\gdef\@jibvolume{#1}}\jibvolume{00}
\def\jibissue#1{\gdef\@jibissue{#1}}\jibissue{00}
\def\jibpages#1{\gdef\@jibpages{#1}}\jibpages{0000}
\def\jibyear#1{\def\@jibyear{#1}}\jibyear{0000}

\def\jibfooter{\footnotesize\sffamily doi:10.2390/biecoll-jib-\@jibyear-\@jibpages \hfil \thepage}

\def\ps@jibheadings{%
%     \renewcommand{\@oddfoot}{\jibfooter}%
% 	\renewcommand{\@evenfoot}{\jibfooter}%
%     \renewcommand{\@evenhead}{\leftmark\hfil\rightmark}%
%     \renewcommand{\@oddhead}{\leftmark\hfil\rightmark}%
    }

\newcommand{\makeHeaderFooter}[1]{
\markboth{\footnotesize\sffamily Journal of Integrative Bioinformatics,
\@jibvolume(\@jibissue):\@jibpages, \@jibyear}{\href{http://journal.imbio.de/}{\footnotesize\sffamily http://journal.imbio.de/}}}
\makeHeaderFooter{}
\pagestyle{jibheadings}

% Copyright
% \AddToShipoutPictureFG{%
%    \put(635,60){%
%       \rotatebox{90}{\scriptsize{
%         \begin{minipage}[t]{200mm}
%             \textcolor[rgb]{0.67,0.67,0.67}{Copyright \@jibyear~The Author(s). Published by Journal of Integrative Bioinformatics. \\
%           This article is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License (http://creativecommons.org/licenses/by-nc-nd/3.0/).}
%         \end{minipage}
%       }}%
%    }%
% }



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Abstract ohne Indent
%%  - nutzt intern die Quotation-Umgebung zum Erzeugen des Abstracts
%%    (im notitlepage und onecolumn Modus)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \renewcommand{\abstractname}{Summary}
% \renewenvironment{quotation}
%                {\list{}{\listparindent 0em%
%                         \itemindent    \listparindent
%                         \rightmargin   \leftmargin
%                         \parsep        \z@ \@plus\p@}%
%                 \item\relax}
%                {\endlist}

\newcounter{abstract}
\setcounter{abstract}{-1}
\renewcommand\abstract{

%\setlength{\rightskip}{1cm}

% The \@startsection{⟨name ⟩}{⟨level ⟩}{ ⟨indent ⟩}{⟨beforeskip ⟩}
% {⟨afterskip⟩}{⟨style⟩}*[⟨altheading⟩ ]{⟨heading⟩} command is the mother of all
% the user level sectioning commands. The part after the *, including the * is optional.
\@startsection {abstract}{0}	{\z@}
								{1ex}                                    
                                {0.8ex}%
                                {\normalfont\sffamily\large\bfseries}*{Abstract}}
                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Font-Anpassung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% \renewcommand\section{			\def\@seccntformat##1{\csname
% the##1\endcsname\hspace{1.02cm \@minus.2ex}} \@startsection {section}{1}{\z@}%
% 									{1ex}
%                                    	{0.8ex}%
%                                     {\normalfont\sffamily\large\bfseries}}
% \renewcommand\subsection{		\def\@seccntformat##1{\csname the##1\endcsname\hspace{0.71cm \@minus.2ex}} 
% 								\@startsection{subsection}{2}{\z@}%
% 									 {-3.25ex\@plus -1ex \@minus -.2ex}%
%                                      {1.5ex \@plus .2ex}%
%                                      {\normalfont\sffamily\normalsize\bfseries}}
% \renewcommand\subsubsection{	\def\@seccntformat##1{\csname the##1\endcsname\hspace{0.35cm \@minus.2ex}} 
% 								\@startsection{subsubsection}{3}{\z@}%
% 									{-3.25ex\@plus -1ex \@minus -.2ex}%
%                                    	{1.5ex \@plus .2ex}%
%                                     {\normalfont\sffamily\normalsize}}
% \renewcommand\paragraph{		\def\@seccntformat##1{\csname the##1\endcsname\hspace{1.0cm \@minus.2ex}} 
% 								\@startsection {paragraph}{4}{\z@}%
% 									{3.25ex \@plus1ex \@minus.2ex}%
%                                    	{-1em}%
%                                     {\normalfont\sffamily\normalsize\bfseries}}
% \renewcommand\subparagraph{ 	\def\@seccntformat##1{\csname the##1\endcsname\hspace{1.0cm \@minus.2ex}} 
% 								\@startsection {subparagraph}{5}{\z@}%
% 									{3.25ex \@plus1ex \@minus .2ex}%
%                                    	{-1em}%
%                                     {\normalfont\sffamily\normalsize\bfseries}} 

 
% \renewcommand\section{\@startsection{section}{1}{\z@}%
% 										{-3.5ex \@plus -1ex \@minus -.2ex}%
% 										{2.3ex \@plus.2ex}%
% 										{\normalfont\sffamily\large\bfseries}}



% \renewcommand\section{\@startsection{section}										% name
% 										{1}		 									% level
% 										{\z@}										% indent
% 										{-3.5ex \@plus -1ex \@minus -.2ex}			% beforeskip
% 										{2.3ex \@plus.2ex}							% afterskip
% 										{\normalfont\sffamily\large\bfseries}}		% font type
% \renewcommand\subsection{\@startsection{subsection}{2}{\z@}
% 										{-3.25ex\@plus -1ex \@minus -.2ex}
% 										{1.5ex \@plus .2ex}
% 										{\normalfont\sffamily\normalsize\bfseries}}
% \renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}
% 										{-3.25ex\@plus -1ex \@minus -.2ex}
% 										{1.5ex \@plus .2ex}
% 										{\normalfont\sffamily\normalsize}}
% \renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}
% 										{3.25ex \@plus1ex \@minus.2ex}
% 										{-1em}
% 										{\normalfont\sffamily\normalsize\bfseries}}
% \renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}
% 										{3.25ex \@plus1ex \@minus .2ex}
% 										{-1em}
% 										{\normalfont\sffamily\normalsize\bfseries}}

\titleformat{\section}{\normalfont\large\bfseries}{\makebox[40pt][l]{\thesection}}{0pt}{} 
\titleformat{\subsection}{\normalfont\large\bfseries}{\makebox[40pt][l]{\thesubsection}}{0pt}{}
\titleformat{\subsubsection}{\normalfont\large\mdseries}{\makebox[40pt][l]{\thesubsubsection}}{0pt}{}

\linespread{2}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Caption Anpassung fuer Bild- und Tabellenunterschriften
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\captionsetup{font={footnotesize,bf},%
              margin=0.7cm,%
              parskip=5pt,%
              aboveskip=0pt,%
              belowskip=0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Sonderzeichenanpassung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \texorpdfstring{...}, weil z.B. \textreg eventuell in section, subsection etc. genutzt wird
%% und hyperref bzw. in bookmarks Probleme mit Sonderzeichen auftreten
%% werden die originalen Befehle, wie \textregistered etc., verwendet, treten keine Probleme auf
\newcommand{\textreg}{\texorpdfstring{\textsuperscript{\textregistered}}{\textregistered}}
\newcommand{\textcright}{\texorpdfstring{\textsuperscript{\textcopyright}}{\textcopyright}}
