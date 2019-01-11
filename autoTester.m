w = warning('query','last');
id=w.identifier;
warning('off',id);

result = zeros(80,3);
for j=200:10:1000
    for i=2:4:100
        config = "Ts = ";
        config = config + (0.05e-6*j);
        config = config + "; dataChannels = ";
        config = config + (j-i);
        config = config + "; totalChannels = 1024; driverChannels =";
        config = config + (i);
        config = config + "; tau = 100e-9;";
        set_param('ofdm', 'InitFcn', config);
        sim('ofdm');
        if ber.data(end, 1) < 0.02
            result((j-200)/10+1, 1) = i;
            result((j-200)/10+1, 2) = 2*(j-i)/(0.05e-6*j)/1e6;
            result((j-200)/10+1, 3) = ber.data(end, 1);
            break;
        end
    end
    result((j-200)/10+1,:)
    save('result', 'result');
end
result
