issue = "Milano13_3_mep"

set terminal postscript eps color enhanced "Helvetica" 18
set output issue.".eps"

set size ratio -1 1, 0.75
set lmargin 4.5
set rmargin 0.5
 
set border linewidth 2

set nokey

set ylabel "N[m]" offset 3.8, 7.8 norotate
set xlabel "E[m]" offset 29.2, 1.6

set xrange [-160:10]  
set yrange [-10:65]  

set xtics -140, 20, -10 
set ytics 10, 20, 60  

#set style line 1 lt 1 lw 3 lc rgb "blue"
#set style line 2 lt 1 lw 3 lc rgb "red"
set style line 3 lt 2 lw 2 lc rgb "black"

plot issue."-gps.gpdata" using 1:2 with points lc rgb "red" lt 1 lw 1 title "GPS", \
issue."-trj.gpdata" using 1:2 with lines ls 3 title "path"

