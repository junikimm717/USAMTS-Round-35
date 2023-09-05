% Juni's (Customized) USAMTS Style Sheet
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usamts}[2023/09/05]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\usepackage[utf8]{inputenc}
\usepackage[english]{babel}

\newcounter{qnumber}

\usepackage{fancyhdr}
\pagestyle{fancy}
\usepackage{cancel}
\usepackage{amsmath,amssymb,amsthm}
\usepackage[pdftex]{graphicx}

\usepackage{mathptmx}
\usepackage{lmodern}

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
\lhead{Student: \printrealname\ \\Username: \printusername\ \\ID\#: \printusamtsid}
\chead{\Large USA Mathematical Talent Search}
\rhead{\begin{tabular}[b]{|c|c|c|}\hline Year&Round&Problem\\\hline\printyear & \printround    
   &\theqnumber\\\hline\end{tabular}}
\lfoot{}
\cfoot{}
\rfoot{Page \thepage\ of Problem \theqnumber}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0.3pt}
\setlength{\textwidth}{6.5in}

%% Print solutions
\newenvironment{solution}[1]{\setcounter{qnumber}{#1}\setcounter{page}{1}}{\eject}

\renewcommand{\qedsymbol}{$\blacksquare$}
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

\newtheorem{claim}{Claim}[qnumber]
\numberwithin{equation}{qnumber}