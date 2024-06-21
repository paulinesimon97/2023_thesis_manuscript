\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{memoire_these}[2023/08/16]

\LoadClass[
        a4paper,        %Type de papier
        12pt,           %Taille de police
        twoside,        %Format book (recto-verso)
        ]{book}

\pdfobjcompresslevel 0

%Packages
\RequirePackage{xparse}         %Utilisation de NewDocumentCommand 
\RequirePackage{graphicx}       %Insertion d'image
\RequirePackage{wrapfig}        %Images insérées dans le texte
\RequirePackage{subcaption}     %Multi figures et légendes
\RequirePackage[colaction]{multicol}    %Texte sur plusieurs colonnes
\RequirePackage{pdfpages}       %Ajout de pdf
\pdfminorversion=7              %Supprime les warnings de version de pdf
\RequirePackage{multirow}       %Retour à la ligne dans les tableaux
\RequirePackage{cprotect}       %Ajout de code source 

%Encoding
\RequirePackage[utf8]{inputenc} %Utilisation des accents
\RequirePackage[T1]{fontenc}    %Utilisation de \bf, \it, \sc
\RequirePackage[french]{babel}  %Symboles spéciaux français
\RequirePackage{ragged2e}       %Justification du texte
\RequirePackage{bm}             %Utilisation de \boldsymbol dans l'environnement math
\RequirePackage{amsmath,amssymb}        %Utilisation de l'environnement math et des symboles associés
\RequirePackage{color}          %Mise en couleur du texte
\RequirePackage{sistyle}        %Formatage des nombres et unités dans le format du système international
%\RequirePackage{bold-extra}


%Configuration des marges
\RequirePackage{geometry}   
\geometry{
        left=25mm,
        right=25mm, 
        top=25mm,
        bottom=25mm}
\RequirePackage[singlespacing]{setspace}

%Entetes et pieds de pages
\setlength{\headheight}{14.49998pt}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand\headrulewidth{1.5pt}
\fancyhead[LE,RO]{\thepage}
\newcommand\partie{ }
\fancyhead[RE]{\partie}
\newcommand\LOdef{Section {\thesection}}
\fancyhead[LO]{\LOdef}
\fancyfoot{}
\RequirePackage{footmisc}

%Entetes chapitres
\RequirePackage[Glenn]{fncychap}
\ChRuleWidth{5pt}       %Largeur bord du cadre 
\RequirePackage{etoolbox}
\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{\vspace*{0\p@}}{}{}
\patchcmd{\@makeschapterhead}{\vspace*{50\p@}}{\vspace*{0\p@}}{}{}
\patchcmd{\DOTI}{\vskip 80\p@}{\vskip 40\p@}{}{}
\patchcmd{\DOTIS}{\vskip 40\p@}{\vskip 40\p@}{}{}

%Définition des chapitres
\NewDocumentCommand\Chapter{o m }{
\let\Oldchaptername\chaptername
\let\Oldthechapter\thechapter
\renewcommand{\chaptername}{\IfValueT{#1}{#1}}
\renewcommand{\thechapter}{}
\chapter{#2}
\renewcommand{\chaptername}{\Oldchaptername}
\renewcommand{\thechapter}{\Oldthechapter}
\setcounter{chapter}{0}
}
\newcommand{\annexe}[2]{
        \chapter{#1}
        \renewcommand\partie{\Partie\ Annexe \thechapter}
        \label{#2}
        \minitoc
        \bigskip}
\newcommand{\chapitre}[2]{
        \chapter{#1}
        \renewcommand\partie{\Partie\ Chapitre \thechapter}
        \label{#2}
        \minitoc
        \bigskip}
\newcommand{\chapitrestar}[3]{
        \chapter*{#1}
        \addcontentsline{toc}{chapter}{#1}
        \adjustmtc
        \renewcommand\partie{\Partie\ #2}
        \label{#3}}

%Objets géométriques
\newcommand{\linia}{\rule{\linewidth}{0.5pt}\\} %Ligne horizontale

%Page vide
\newcommand\pagevide{ %auteur citation
\thispagestyle{empty}\vfill\null}


% \RequirePackage[acronym]{glossaries}
% \setacronymstyle{short-long-desc}

%Counters and ref
\RequirePackage{chngcntr}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\newcommand{\figref}[1]{\textsc{Figure} \ref{#1}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}
\newcommand{\tabref}[1]{\textsc{Table} \ref{#1}}

%Formatage des citations
\NewDocumentCommand\personne{ o m o }{\textbf{\IfValueT{#1}{#1} \IfValueT{#3}{#3} {\textsc{#2}}}}   %titre nom prénom
\NewDocumentCommand\Dedicace{m m}{\textit{#2} \\ {#1}}   %auteur citation
\newcommand\quotechapt[2]{
        \begin{flushright}
        \Dedicace{#1}{#2}
        \end{flushright}}

%Définition des parties
\newcommand\Partie{ }
\newcommand{\extraPartText}[1]{\def\@extraPartText{#1}}
\pretocmd{\@endpart}{\vspace{8ex}\begingroup\centering\@extraPartText\par\endgroup\let\@extraPartText\relax}{}{}
%Titre / Label / Indication sur l'entete des chapitre / Indication haut de page / Texte supplémentaire
\newcommand{\pagepart}[5]{      
\extraPartText{#5}
\part*{\linia
        \bigskip
        #1
        \bigskip
        \linia}
   \addtocontents{toc}{\protect\vspace{2ex}\textbf{#1}\par}    
\refstepcounter{part}\label{#2}
\renewcommand{\chaptername}{#3}
\renewcommand\Partie{#4}
}

%Bibliographie
\RequirePackage{csquotes}
\RequirePackage[
   backend=biber,        % compilateur par défaut pour biblatex
   sorting=nyt,          % trier par nom, année, titre
   citestyle=authoryear-comp, % style de citation auteur-année
   bibstyle=science,
   %bibstyle=vancouver,  % style de bibliographie alphabétique
   isbn=false, url=false, doi=false, eprint=false,
   uniquename=false,
   maxcitenames=2,
   mincitenames = 1,
   date=year,
]{biblatex}
\DefineBibliographyStrings{french}{%
  pages = {pp\adddot},
  in ={\emph{in}},
  volume={vol\adddot\addspace},
  number={\no}}
\AtEveryBibitem{%
  \clearfield{note}}
\DeclareFieldFormat{no}{\bibsstring{number}#1}
\DeclareFieldFormat{vol}{\bibsstring{volume}#1}
\renewbibmacro*{volume+number+eid}{%
  \addcomma\addspace%
  \printfield[vol]{volume}%
  \setunit{\addcomma\addspace}%
  \printfield[no]{number}%
  \setunit{\addcomma\addspace}%
  \printfield{eid}}
% \AtEveryCitekey% for every citation
%     {%
%         \ifnumgreater{\value{labelname}}{2}% if there are >2 authors
%             %{%
%                 %\ifciteseen% and if citation has been seen before
%                     {\setcounter{maxnames}{1}}% then cite only one author
%                     %{\setcounter{maxnames}{\value{labelname}}}% otherwise cite all authors
%             %}
%             {\setcounter{maxnames}{\value{labelname}}}% otherwise cite ≤2 authors
%     }
    
\RequirePackage{hyperref}       %Liens hypertextes dans le document

%Acronymes 
\RequirePackage[nohyperlinks]{acronym} %,printonlyused,withpage
\newcommand{\defacro}[4]{\acro{#1}[#2]{#3\acroextra{. #4}} }%\label{#1}}
\newcommand{\sacro}[1]{\hyperlink{list:ac}{\acs{#1}} } %\hyperref[#1]
\newcommand{\cacro}[1]{\expandafter\ifx\csname ac@#1\endcsname\relax
 {\acl{#1} (\hyperlink{list:ac}{\acs{#1}})}%
 \global\expandafter\let\csname ac@#1\endcsname\@empty
 \else
 \hyperlink{list:ac}{\acs{#1}}%
 \fi}
\newcommand{\lacro}[1]{\acl{#1}}


%Sommaires
\RequirePackage{shorttoc}
\RequirePackage[french]{minitoc}
\RequirePackage{silence}
\WarningFilter{minitoc(hints)}{W0023}
\WarningFilter{minitoc(hints)}{W0024}
\WarningFilter{minitoc(hints)}{W0028}
\WarningFilter{minitoc(hints)}{W0030}
\WarningFilter{minitoc(hints)}{W0078}
\dominitoc

%Nomenclature
\RequirePackage{nomencl}
\makenomenclature


%Math commands
\renewcommand{\dj}{\ensuremath{\rlap{\textrm{d}}{\bar{\phantom{w}}}}}
