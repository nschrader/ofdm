set terminal png
set datafile separator ","

set output "ber.png"
set title "Losses vs. Pilot Channels for 16-QAM and SNR=20dB (4096 Channels)"
set xlabel "Pilot Channels"
set y2label "BER (%)"
set ylabel "Throughput (MBaud/s)"
set y2tics nomirror
set ytics nomirror
plot "channel.txt" u 2:($4*100) w lines axes x1y2 t "BER", \
    "channel.txt" u 2:($3/2) w lines axes x1y1 t "Throughput"
