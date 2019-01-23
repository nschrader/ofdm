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
    "channel.txt" u 2:($3/2) w lines axes x1y2 t "Throughput"
