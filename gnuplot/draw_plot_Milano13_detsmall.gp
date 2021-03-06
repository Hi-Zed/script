issue = "Milano13_nomag_mep"

set terminal postscript eps color enhanced "Helvetica" 18
set output issue."_detsmall.eps"

set size ratio -1 0.34, 0.5
set lmargin 4.5
set rmargin 0.5
 
set border linewidth 2

set nokey

set ylabel "N[m]" offset 3.8, 12 norotate
set xlabel "E[m]" offset 17.7, 1.6

set xrange [-67:-54]  
set yrange [3:17] 

set xtics -65, 4, -57
set ytics 5, 5, 15  

#set style line 1 lt 1 lw 3 lc rgb "blue"
#set style line 2 lt 1 lw 3 lc rgb "red"
set style line 3 lt 2 lw 2 lc rgb "black"

plot issue."-gps.gpdata" using 1:2 with points lc rgb "red" lt 1 lw 0.5 title "GPS", \
issue."-trj.gpdata" using 1:2 with lines ls 3 title "path"

