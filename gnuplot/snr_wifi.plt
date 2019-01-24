set terminal png
set datafile separator ","

set output "snr_wifi.png"
set title "Modulation Performances vs. SNR (4096 Channels with 64 Pilots)"
set xlabel "SNR (dB)"
set xrange [30:10]
set ylabel "MBit/s"
set yrange [0:200]
set y2label "BER (%)"
set y2tics nomirror
set ytics nomirror
set key bottom left

set label "128-QAM" at 29.7,130
set label "64-QAM" at 29,111
set label "32-QAM" at 26,94
set label "16-QAM" at 23,78
set label "8-QAM" at 20,60
set label "QPSK" at 18,43
set label "BPSK" at 14,24
f(x)=20*log(1+10**(x/10))/log(2)
plot f(x) t "Channel Capacity", \
    "snr.txt" u 1:($3*0.9) w linespoints axes x1y1 t "Throughput", \
    "snr.txt" u 1:4 w lines axes x1y2 t "BER"
