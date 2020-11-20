%% Vorlage für Monographien
%% nach den Vorgaben des KIT Scientific Publishing
%%
%% %% Dr.-Ing. Erik Burger
%% burger@kit.edu
%%
%% Siehe https://sdqweb.ipd.kit.edu/wiki/Dokumentvorlagen

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdqdiss-ksp}[2020/05/29 SDQ Dissertation KSP Monography]

\newif\ifsmalldiss
\newif\ifmediumdiss
\newif\iflargediss

\newif\ifdinformat
\newif\ifscientificformat

\DeclareOption{smalldiss}{
    \smalldisstrue
}
\DeclareOption{mediumdiss}{
    \mediumdisstrue
}
\DeclareOption{largediss}{
    \largedisstrue
}

\DeclareOption{a5format}{
    \dinformattrue
}

\DeclareOption{17x24format}{
    \scientificformattrue
}

% Standard
\ExecuteOptions{mediumdiss,a5format}

% Optionen an scrbook durchreichen
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

\ProcessOptions\relax

\LoadClass{scrbook}

%%%%%%%%%%
% DIN A5 %
%%%%%%%%%%

\ifdinformat

    \KOMAoptions{paper=a5}

% Satzspiegel und Ränder 
%
% +------------+----------------+---------------------+
% | Seitenzahl | Bindekorrektur | Seitenteilung (DIV) |
% +------------+----------------+---------------------+
% | < 200      | 11.5mm         | 16                  |
% | 200–399    | 14.5mm         | 16                  |
% | > 400      | 17.5mm         | 17                  |
% +------------+----------------+---------------------+

    \ifsmalldiss\typearea[11.5mm]{16}\fi
    \ifmediumdiss\typearea[14.5mm]{16}\fi
    \iflargediss\typearea[17.5mm]{17}\fi
\fi

%%%%%%%%%%%%%%%%%
% 17 cm × 24 cm %
%%%%%%%%%%%%%%%%%

\ifscientificformat

    \KOMAoptions{paper=17cm:24cm}

% Satzspiegel und Ränder 
%
% +------------+----------------+---------------------+
% | Seitenzahl | Bindekorrektur | Seitenteilung (DIV) |
% +------------+----------------+---------------------+
% | < 200      | 13mm           | 16                  |
% | 200–399    | 17.5mm         | 16                  |
% | > 400      | 20mm           | 17                  |
% +------------+----------------+---------------------+

    \ifsmalldiss\typearea[13mm]{16}\fi
    \ifmediumdiss\typearea[17.5mm]{16}\fi
    \iflargediss\typearea[20mm]{17}\fi
\fi

% Daraus ergeben sich die gewünschten Werte auf https://www.bibliothek.kit.edu/cms/downloads/KSP/KSP-Grundregeln-Gestaltung.pdf, Seite 4 

\KOMAoptions{
    pagesize,
    headlines=1.1, 
    fontsize=10pt, 
    parskip=half,
    headsepline,
    headinclude=true,
    footinclude=false,
    bibliography=totoc,	
    %listof=totoc,
    headings=optiontoheadandtoc,
    toc=chapterentrywithdots,
}

\raggedbottom

\recalctypearea

% Seitenzahlen nach KSP-Vorgabe
\setlength{\footskip}{3\baselineskip}

% Titelseite
\setkomafont{subtitle}{\normalfont\large}

% Schrifttypen

% serif type: Linux Libertine
\RequirePackage{libertine}
% Linux Libertine in math mode
\RequirePackage[libertine]{newtxmath}

% grotesque type: Adobe Source Sans Pro
\RequirePackage[scaled=.92]{sourcesanspro}

% monospace type: Bera Mono
\RequirePackage[scaled=.78]{beramono}

% Microtype für schöneren Textsatz
\RequirePackage[protrusion=true,expansion=true]{microtype}

% keine Seitenzahl auf Kapiteltrennblättern
\renewcommand*{\partpagestyle}{empty}

% Numerierte Subsubsections
\setcounter{secnumdepth}{3}

% Größe der Titelzeile 
\setkomafont{pageheadfoot}{\footnotesize\usekomafont{pagenumber}}

%% Einzug der Überschriften einheitlich (Vorgabe KSP)

\newlength{\headingindent}
\setlength{\headingindent}{36pt}
\renewcommand*{\chapterformat}{%
  \makebox[\headingindent][l]{\thechapter\autodot}%
}
\renewcommand*{\sectionformat}{%
  \makebox[\headingindent][l]{\thesection\autodot}%
}
\renewcommand*{\subsectionformat}{%
 \makebox[\headingindent][l]{\thesubsection\autodot}%
} 
\renewcommand*{\subsubsectionformat}{%
 \makebox[\headingindent][l]{\thesubsubsection\autodot}%
} 

%% /Einzug Überschriften

% Vermeidet leere rechte Kopfzeilen bei langen Einleitungtexten
% in Kapiteln vor der ersten Section
\renewcommand*\chaptermark[1]{%
  \markboth
    {\MakeMarkcase{\chaptermarkformat#1}}
    {\MakeMarkcase{\chaptermarkformat#1}}}

% Beschriftungen von Schaubildern
\setkomafont{caption}{\footnotesize} 							% Vorgabe KSP: 8 pt
\setkomafont{captionlabel}{\sffamily\bfseries\footnotesize} 	% seriflos fett, 8 pt
\setcapindent{0em}                             					% keinen Einzug ab der 2. Zeile

% Hurenkinder und Schusterjungen verhindern
\clubpenalty10000
\widowpenalty10000
\displaywidowpenalty10000
% Fußnoten über mehrere Seiten verhindern
\interfootnotelinepenalty10000

%Fußnotentext bündig
\deffootnote[1em]{1em}{0em}{%
  \makebox[1em][l]{% linksbündig in dem angegebenen Markenbreich
    \textsuperscript{\thefootnotemark}}%
}
% Abstand Fußnotentrennliie laut KSP
\setlength{\skip\footins}{20pt}

%% Flattersatz in Aufzählungen
\usepackage{enumitem}
\setlist[itemize]{%before=\csname par\endcsname\raggedright,
partopsep=0pt}
\setlist[enumerate]{%before=\csname par\endcsname\raggedright,
partopsep=0pt}


%%
%% Vollere Seiten erlauben
%%

\renewcommand{\topfraction}{0.9}	% max fraction of floats at top
\renewcommand{\bottomfraction}{0.8}	% max fraction of floats at bottom
\renewcommand{\textfraction}{0.07}	% allow minimal text w. figs
%   Parameters for FLOAT pages (not text pages):
\renewcommand{\floatpagefraction}{0.85}	% require fuller float pages
% N.B.: floatpagefraction MUST be less than topfraction !!
\renewcommand{\dblfloatpagefraction}{0.85}	% require fuller float pages

% Formatierung der Inhalts-/Abbildungs-Verzeichnisse
%\RequirePackage{tocstyle}
%\usetocstyle{allwithdot}
%\settocstylefeature[-1]{pagenumberhook}{\normalsize\normalfont}
%\settocstylefeature[-1]{dothook}{\normalsize\normalfont}
%\settocstylefeature{pagenumberbox}{\hbox}



% Verzeichnisse Figure/Table/Listing ohne linken Rand
\renewcommand\l@figure{\@dottedtocline{1}{0em}{2.3em}}
\renewcommand\l@table{\@dottedtocline{1}{0em}{2.3em}}

% Gleiche Größe und Ausrichtung von Part und Chapter
\setkomafont{partentry}{\usekomafont{chapterentry}}
\RedeclareSectionCommand[tocnumwidth=1.5em]{part}
