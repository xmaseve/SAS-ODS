data sat_scores;
   input Test $ Gender $ Year SATscore @@;
   datalines;
Verbal m 1972 531  Verbal f 1972 529
Verbal m 1973 523  Verbal f 1973 521
Verbal m 1974 524  Verbal f 1974 520
Verbal m 1975 515  Verbal f 1975 509
Verbal m 1976 511  Verbal f 1976 508
Verbal m 1977 509  Verbal f 1977 505
Verbal m 1978 511  Verbal f 1978 503
Verbal m 1979 509  Verbal f 1979 501
Verbal m 1980 506  Verbal f 1980 498
Verbal m 1981 508  Verbal f 1981 496
Verbal m 1982 509  Verbal f 1982 499
Verbal m 1983 508  Verbal f 1983 498
Verbal m 1984 511  Verbal f 1984 498
Verbal m 1985 514  Verbal f 1985 503
Verbal m 1986 515  Verbal f 1986 504
Verbal m 1987 512  Verbal f 1987 502
Verbal m 1988 512  Verbal f 1988 499
Verbal m 1989 510  Verbal f 1989 498
Verbal m 1990 505  Verbal f 1990 496
Verbal m 1991 503  Verbal f 1991 495
Verbal m 1992 504  Verbal f 1992 496
Verbal m 1993 504  Verbal f 1993 497
Verbal m 1994 501  Verbal f 1994 497
Verbal m 1995 505  Verbal f 1995 502
Verbal m 1996 507  Verbal f 1996 503
Verbal m 1997 507  Verbal f 1997 503
Verbal m 1998 509  Verbal f 1998 502
Math   m 1972 527  Math   f 1972 489
Math   m 1973 525  Math   f 1973 489
Math   m 1974 524  Math   f 1974 488
Math   m 1975 518  Math   f 1975 479
Math   m 1976 520  Math   f 1976 475
Math   m 1977 520  Math   f 1977 474
Math   m 1978 517  Math   f 1978 474
Math   m 1979 516  Math   f 1979 473
Math   m 1980 515  Math   f 1980 473
Math   m 1981 516  Math   f 1981 473
Math   m 1982 516  Math   f 1982 473
Math   m 1983 516  Math   f 1983 474
Math   m 1984 518  Math   f 1984 478
Math   m 1985 522  Math   f 1985 480
Math   m 1986 523  Math   f 1986 479
Math   m 1987 523  Math   f 1987 481
Math   m 1988 521  Math   f 1988 483
Math   m 1989 523  Math   f 1989 482
Math   m 1990 521  Math   f 1990 483
Math   m 1991 520  Math   f 1991 482
Math   m 1992 521  Math   f 1992 484
Math   m 1993 524  Math   f 1993 484
Math   m 1994 523  Math   f 1994 487
Math   m 1995 525  Math   f 1995 490
Math   m 1996 527  Math   f 1996 492
Math   m 1997 530  Math   f 1997 494
Math   m 1998 531  Math   f 1998 496
;
run;

/*Creating HTML Output: The Simplest Case*/
ods listing close;
ods html file='C:\Users\QI_YI\Desktop\Yi\test.html';

proc means data=sat_scores fw=8; 
   var SATscore;
   class Test Gender;
   title1 'Average SAT Scores Entering College Classes, 1972-1998*';
   footnote1 '* Recentered Scale for 1987-1995';
run;

ods html close;
title;
footnote;

/*Creating HTML Output: Linking Results with a Table of Contents*/
proc sort data=sat_scores out=sorted_scores;
   by Test;
run;

%let file=C:\Users\QI_YI\Desktop\Yi;
ods listing close;  
ods html file="&file\body.html" 
         contents="&file\contents.html" 
         page="&file\page.html" 
         frame="&file\frame.html"; 
proc univariate data=sorted_scores;  
   var SATscore;
   class Gender;
   by Test;
   title1 'Average SAT Scores Entering College Classes, 1972-1998*';
   footnote1 '* Recentered Scale for 1987-1995';
run;

ods html close; 
ods listing;
title;
footnote;

/*Creating RTF Output for Microsoft Word*/
ods listing close; 
ods rtf file="&file\output.rtf"; 

proc univariate data=sat_scores;  
   var SATscore;
   class Gender;
   title1 'Average SAT Scores Entering College Classes, 1972-1998*';
   footnote1 '* Recentered Scale for 1987-1995';
run;

ods rtf close; 
ods listing; 
title;
footnote;

/*Selecting and Excluding Program Output*/
ods listing close;
ods html file='odsselect-body.htm'  
         contents='odsselect-contents.htm'
         page='odsselect-page.htm'
         frame='odsselect-frame.htm';
ods printer file='odsprinter-select.ps';

ods select BasicMeasures TestsForLocation; /*use the name component in the trace records*/
proc univariate data=sat_scores;
   var SATscore;
   class Gender; 
run;

ods html close;
ods printer close;
ods listing;

/*Creating a SAS Data Set*/
ods listing close;  
ods output BasicMeasures=measures; 

proc univariate data=sat_scores;  
   var SATscore;
   class Gender; 
run;

ods output close;  
ods listing; 
