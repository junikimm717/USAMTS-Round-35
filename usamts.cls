% Juni's (Customized) USAMTS Style Sheet
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usamts}[2023/09/05]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[english]{babel}

\usepackage{amsmath,amssymb,amsthm}

\usepackage{Alegreya}
\usepackage[cmintegrals,cmbraces]{newtxmath}
\usepackage{ebgaramond-maths}

\DeclareRobustCommand\Alegreya{\fontfamily{Alegreya-LF}\selectfont}
\DeclareRobustCommand\AlegreyaMedium{\fontfamily{Alegreya-LF}\fontseries{sb}\fontshape{n}\selectfont}

\newcounter{qnumber}

\usepackage{fancyhdr}
\pagestyle{fancy}
\usepackage{cancel}
\usepackage[pdftex]{graphicx}


%% Student and Year/Round data
\newcommand{\realname}[1]{\newcommand{\printrealname}{#1}}
\newcommand{\username}[1]{\newcommand{\printusername}{#1}}
\newcommand{\usamtsid}[1]{\newcommand{\printusamtsid}{#1}}
\newcommand{\usamtsyear}[1]{\newcommand{\printyear}{#1}}
\newcommand{\usamtsround}[1]{\newcommand{\printround}{#1}}

%% Pagestyle setup
\setlength{\headheight}{0.75in}
\setlength{\oddsidemargin}{0in}
\setlength{\evensidemargin}{0in}
\setlength{\voffset}{-.5in}
\setlength{\headsep}{10pt}
\setlength{\textwidth}{6.5in}
\setlength{\headwidth}{6.5in}
\setlength{\textheight}{8in}
\lhead{\Alegreya \printrealname\ (\printusername) \\ID\printusamtsid}
\chead{\Alegreya\Large USA Mathematical Talent Search}
\rhead{\Alegreya \Large Problem \theqnumber/\printround/\printyear}
%\rhead{\Alegreya\begin{tabular}[b]{|c|c|c|}\hline Year&Round&Problem\\\hline\printyear & \printround     &\theqnumber\\\hline\end{tabular}}
\lfoot{}
\cfoot{}
\rfoot{\Alegreya Page \thepage\ of Problem \theqnumber}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0.3pt}
\setlength{\textwidth}{6.5in}

%% Print solutions
\newenvironment{solution}{
\stepcounter{qnumber}
\setcounter{page}{1}
\setcounter{equation}0
}{\eject}

\renewcommand{\qedsymbol}{$\blacksquare$}
\renewcommand{\qed}{\hfill$\blacksquare$}

\newcommand{\NN}{\mathbb{N}}
\newcommand{\ZZ}{\mathbb{Z}}
\newcommand{\QQ}{\mathbb{Q}}
\newcommand{\RR}{\mathbb{R}}

\newcommand{\paren}[1]{\left( #1 \right)}
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}
\newcommand{\ceil}[1]{\left\lceil #1 \right\rceil}
\newcommand{\abs}[1]{\left| #1 \right|}

\theoremstyle{definition}
\newtheorem{definition}{Definition}[qnumber]
\numberwithin{equation}{qnumber}
\newtheorem{claim}{\ebgaramond Claim}[qnumber]

\PassOptionsToPackage{usenames,svgnames,dvipsnames,table}{xcolor}
\usepackage[table]{xcolor}
\usepackage[colorlinks=true,pdfusetitle,pagebackref]{hyperref}
  

\usepackage{listings}

\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstdefinestyle{mystyle}{
    backgroundcolor=\color{backcolour},   
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2,
}
\lstset{style=mystyle}