%% Vorlage für SDQ-Dissertationen und Monographien
%% nach den Vorgaben des KIT Scientific Publishing
%%
%% %% Dr.-Ing. Erik Burger
%% burger@kit.edu
%%
%% Siehe https://sdqweb.ipd.kit.edu/wiki/Dokumentvorlagen

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdqdiss}[2021/01/25 SDQ Dissertation]

\usepackage{xkeyval}

%%
%% OPTIONEN
%%

%% SDQ- und KSP-Formatoptionen
\newif\ifdinafourformatsdq
\newif\ifdinafiveformatksp
\newif\ifdinafourformatksp
\newif\ifscientificformatksp
\newif\ifscaletoafiveksp
\newif\ifsmalldiss
\newif\ifmediumdiss
\newif\iflargediss

\define@choicekey*{sdqdiss.cls}{format}[\val\nr]{a4-sdq,a4-ksp,a5-ksp,17x24-ksp}[a5-ksp]{%
    \ifcase\nr\relax
        \dinafourformatsdqtrue%
    \or
        \dinafourformatksptrue%
    \or
        \dinafiveformatksptrue%
    \or
        \scientificformatksptrue%
    \fi
}

\define@choicekey*{sdqdiss.cls}{scaleto}[\val\nr]{a5,none}[none]{%
    \ifcase\nr\relax
        \scaletoafiveksptrue%
    \fi
}

\define@choicekey*{sdqdiss.cls}{length}[\val\nr]{small,medium,large}[medium]{%
    \ifcase\nr\relax
        \smalldisstrue%
    \or
        \mediumdisstrue%
    \or
        \largedisstrue%
    \fi
}

%% Listen im Flattersatz
\define@boolkey{sdqdiss.cls}[]{raggedlists}[true]{}

%% Listings verwenden (damit auch dafür die Einrückung in der List of Listings korrigiert wird)
\newif\ifuselistings
\define@key{sdqdiss.cls}{listings}[]{
    \uselistingstrue
    \def\listingsoptions{#1}
}

%% Passt die Breite der Nummerierung an, falls Figures/Tables/Listings mit hoher Nummerierung (vierstellig) verwendet werden
\define@boolkey{sdqdiss.cls}[]{highlistnumbers}[true]{}

%% Standard
\ExecuteOptionsX{length=medium,format=a5-ksp}

%% Optionen an scrbook durchreichen
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

\ProcessOptionsX\relax

%% Skalierung funktioniert nur für KSP-Formate, daher bei SDQ-Format einen Error ausgeben
\ifdinafourformatsdq
    \ifscaletoafiveksp
        \PackageError{sdqdiss.cls}{Scaling not available for a4-sdq format}%
    \fi
\fi

\LoadClass{scrbook}


%%
%% KONFIGURATION
%%

\def\difftoafiveimage{0mm}
%% Seitenformat
\ifdinafiveformatksp
    \KOMAoptions{paper=a5, fontsize=10pt}
\fi
\ifscientificformatksp
    \KOMAoptions{paper=17cm:24cm, fontsize=10pt}
\fi
\ifdinafourformatksp
    \KOMAoptions{paper=a4, fontsize=11pt}
\fi
\ifdinafourformatsdq
    \KOMAoptions{paper=a4, fontsize=12pt}
    \def\difftoafiveimage{22mm}
\fi

%% Satzspiegel

% Berechnung für KSP-Format:
% DIV gibt Anzahl Spalten an, in die Seitebreite abzüglich Bindekorrektur aufgeteilt wird. Rand besteht dann standardmäßig außen aus 2 Spalten, innen aus einer Spalte + Bindekorrektur.
% Es handelt sich also um ein ganzzahliges Problem, dessen Lösung wir nur approximieren können.
% Um die KSP-Maße zu approximieren, zunächst optimales DIV errechnen, indem Bindekorrektur approximiert wird durch: Approxmierte Bindekorrektur = Innenrand - (Außenrand/2)
% Dann optimales DIV berechnen als: DIV = (Seitenbreite - Approxmierte Bindekorrektur) / (Außenrand/2)
% Dann mit dem errechneten DIV die exakte Bindekorrektur berechnen: Bindekorrektur = (DIV/(DIV-1) * Innenrand) - (Seitenbreite / (DIV-1))
% Im Ergebnis wird der vorgebenene Innenrand exakt erreicht und der Außenrand sowie die Textbreite angenähert.
% Bei den Außenrändern gibt KSP Bereiche an, hier haben wir für die Berechnung den Mittelwert des Bereichs gewählt.
%
% Relevante Maße:
% "ohne Skalierung", d.h. es wird in dem Format geschrieben, in dem später gedruckt wird.
% "17x24cm zu DIN A5", d.h. es wird in 17x24cm geschrieben, aber auf A5 gedruckt.
% "A4 zu DIN A5", d.h. es wird in A4 geschrieben, aber auf A5 gedruckt.

% SDQ-Format: Einheitlicher Satzspiegel für A4
\ifdinafourformatsdq
    \typearea[20mm]{15}
\else
% KSP: Standardwerte ohne Skalierung
% +------------+----------------+---------------------+
% | Seitenzahl | Bindekorrektur | Seitenteilung (DIV) |
% +------------+----------------+---------------------+
% | < 200      | 11.5mm         | 16                  |
% | 200–399    | 14.7mm         | 16                  |
% | > 400      | 17.3mm         | 17                  |
% +------------+----------------+---------------------+
    \ifsmalldiss\typearea[11.5mm]{16}\fi
    \ifmediumdiss\typearea[14.7mm]{16}\fi
    \iflargediss\typearea[17.3mm]{17}\fi
\fi

% Skalierung für KSP-Formate
\ifscaletoafiveksp
    % A4 geschrieben, A5 gedruckt
    \ifdinafourformatksp
% +------------+----------------+---------------------+
% | Seitenzahl | Bindekorrektur | Seitenteilung (DIV) |
% +------------+----------------+---------------------+
% | < 200      | 15.9mm         | 16                  |
% | 200–399    | 20.1mm         | 16                  |
% | > 400      | 24.0mm         | 17                  |
% +------------+----------------+---------------------+
        \ifsmalldiss\typearea[15.9mm]{16}\fi
        \ifmediumdiss\typearea[20.1mm]{16}\fi
        \iflargediss\typearea[24.0mm]{17}\fi
        \KOMAoptions{fontsize=14pt}
    \fi
    % 17×24cm geschrieben, A5 gedruckt
    \ifscientificformatksp
% +------------+----------------+---------------------+
% | Seitenzahl | Bindekorrektur | Seitenteilung (DIV) |
% +------------+----------------+---------------------+
% | < 200      | 13.2mm         | 16                  |
% | 200–399    | 17.5mm         | 16                  |
% | > 400      | 20.2mm         | 17                  |
% +------------+----------------+---------------------+
        \ifsmalldiss\typearea[13.2mm]{16}\fi
        \ifmediumdiss\typearea[17.5mm]{16}\fi
        \iflargediss\typearea[20.2mm]{17}\fi
        \KOMAoptions{fontsize=11pt}
    \fi
\fi
% Damit ergeben sich (in etwa) die gewünschten Werte auf https://www.bibliothek.kit.edu/cms/downloads/KSP/KSP-Grundregeln-Gestaltung.pdf, Seite 5

%% Standardoptionen
\KOMAoptions{
    pagesize,
    headlines=1.1, 
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

%% Seitenzahlen nach KSP-Vorgabe
\setlength{\footskip}{3\baselineskip}

%% Titelseite
\setkomafont{subtitle}{\normalfont\large}

%% Schrifttypen
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

%% Keine Seitenzahl auf Kapiteltrennblättern
\renewcommand*{\partpagestyle}{empty}

%% Numerierte Subsubsections
\setcounter{secnumdepth}{3}

%% Größe der Titelzeile
\setkomafont{pageheadfoot}{\footnotesize\usekomafont{pagenumber}}

%% Einzug der Überschriften einheitlich (Vorgabe KSP)
\newlength{\headingindent}
\setlength{\headingindent}{3.6em}
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

%% Vermeidet leere rechte Kopfzeilen bei langen Einleitungtexten in Kapiteln vor der ersten Section
\renewcommand*\chaptermark[1]{%
  \markboth
    {\MakeMarkcase{\chaptermarkformat#1}}
    {\MakeMarkcase{\chaptermarkformat#1}}}

%% Beschriftungen von Schaubildern
\setkomafont{caption}{\footnotesize} 							% Vorgabe KSP: 8 pt
\setkomafont{captionlabel}{\sffamily\bfseries\footnotesize} 	% seriflos fett, 8 pt
\setcapindent{0em}                             					% keinen Einzug ab der 2. Zeile

%% Hurenkinder und Schusterjungen verhindern
\clubpenalty10000
\widowpenalty10000
\displaywidowpenalty10000

%% Fußnoten
% Fußnoten über mehrere Seiten verhindern
\interfootnotelinepenalty10000
% Fußnotentext bündig
\deffootnote[1em]{1em}{0em}{%
  \makebox[1em][l]{% linksbündig in dem angegebenen Markenbreich
    \textsuperscript{\thefootnotemark}}%
}
% Abstand Fußnotentrennlinie laut KSP
\setlength{\skip\footins}{20pt}

%% Formatierung von Aufzählungen
\usepackage{enumitem}
\setlist[itemize]{partopsep=0pt}
\setlist[enumerate]{partopsep=0pt}
% Flattersatz in Aufzählungen, falls gewünscht
\ifraggedlists
    \setlist[itemize]{before=\csname par\endcsname\raggedright,partopsep=0pt}
    \setlist[enumerate]{before=\csname par\endcsname\raggedright,partopsep=0pt}
\fi

%% Vollere Seiten erlauben
\renewcommand{\topfraction}{0.9}	% max fraction of floats at top
\renewcommand{\bottomfraction}{0.8}	% max fraction of floats at bottom
\renewcommand{\textfraction}{0.07}	% allow minimal text w. figs
% Parameters for FLOAT pages (not text pages):
\renewcommand{\floatpagefraction}{0.85}	% require fuller float pages
% N.B.: floatpagefraction MUST be less than topfraction !!
\renewcommand{\dblfloatpagefraction}{0.85}	% require fuller float pages

%% Figures, Tables, Listings
% Verzeichnisse Figure/Table/Listing ohne linken Rand
\renewcommand\l@figure{\@dottedtocline{1}{0em}{2.3em}}
\renewcommand\l@table{\@dottedtocline{1}{0em}{2.3em}}
\ifuselistings
    \usepackage[\listingsoptions]{listings}%
    \renewcommand\l@lstlisting{\@dottedtocline{1}{0em}{2.3em}}%
\fi
\ifhighlistnumbers
    \renewcommand\l@figure{\@dottedtocline{1}{0em}{2.6em}}%
    \renewcommand\l@table{\@dottedtocline{1}{0em}{2.6em}}%
    \ifuselistings
        \renewcommand\l@lstlisting{\@dottedtocline{1}{0em}{2.6em}}%
    \fi
\fi

%% Gleiche Größe und Ausrichtung von Part und Chapter
\setkomafont{partentry}{\usekomafont{chapterentry}}
\RedeclareSectionCommand[tocnumwidth=1.5em]{part}
