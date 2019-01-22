set terminal png
set datafile separator ","

set output "ber.png"
set title "BER vs. Pilot Channels for 16-QAM and SNR=20dB"
set xlabel "Pilot Channels"
set ylabel "%"
set y2label "MBaud/s"
set y2tics nomirror
set ytics nomirror
plot "channel.txt" u 2:($4*100) w lines axes x1y1 t "BER", \
    "channel.txt" u 2:($3/4) w lines axes x1y2 t "Throughput"

set output "throughput.png"
set title "Throughput vs. Channels for QPSK and infinite SNR"
set xlabel "Channels"
set logscale x
set key top left
unset y2label
unset y2tics
set ylabel "MBaud/s"
f(x)=(2**floor(log(x)/log(2)))
plot "result.txt" u 1:($3/2) w lines axes x1y1 t "Throughput", \
    [1:60000] f(x)*log(f(x)) w lines axes x1y2 t "FFT complexity"

set output "pilots.png"
set title "Necessary Pilot Channels vs. Channels for QPSK and infinite SNR"
set ylabel "Pilot Channels"
set parametric
set trange [0:45]
plot "result.txt" u 1:2 w lines notitle, \
    50000, t notitle lc black, \
    2, t notitle lc black
