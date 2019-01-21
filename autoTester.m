warning('off', 'all');

result = zeros(10,4);
j = 4096;
idx = 1;
for i=[10 16 24 32 48 64 96 128 196 256]
    config = "Ts = ";
    config = config + (0.05e-6*j);
    config = config + "; driverChannels =";
    config = config + (i);
    config = config + "; dataChannels = ";
    config = config + (j-i);
    config = config + "; totalChannels = ";
    config = config + 2^ceil(log2(j));
    config = config + "; tau = 100e-9; SNR=20; M=16;";
    set_param('ofdm', 'InitFcn', config);
    sim('ofdm');
    result(idx, 1) = j;
    result(idx, 2) = i;
    result(idx, 3) = 2*(j-i)/(0.05e-6*j)/1e6;
    result(idx, 4) = ber.data(end, 1);
    save('result', 'result');
    idx = idx + 1;
end
result(idx,:)

