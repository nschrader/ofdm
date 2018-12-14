function data = decompileChannels(baseband, totalChannels, dataChannels, driverChannels)
 % Row vector for using vector concentration
 baseband = baseband';
 
 % Useful variables
 usedChannels = dataChannels + driverChannels;
 deltaChannel = dataChannels/driverChannels/2;
 
 % Fix variables for indices 
 fDeltaChannel = fix(deltaChannel);
 fUsedChannels_2 = fix(usedChannels/2);
 fDriverChannels_2 = fix(driverChannels/2);
 
 % Helper function
 cones = @(n) complex(ones(1, n));
 czeros = @(n) complex(zeros(1, n));
 
 % Remove null channels
 driver = czeros(usedChannels);
 driver(1:fUsedChannels_2) = baseband(1:fUsedChannels_2);
 driver(fUsedChannels_2+1:end) = baseband(totalChannels-fUsedChannels_2+1:end);
 
 %Extract driver channels
 for j=1:fDriverChannels_2
     for i=fliplr(1:(fDeltaChannel+1)*j)
        % Flip vector elements
        driver([i i+1]) = driver([i+1 i]);
        driver([usedChannels-i+1 usedChannels-i]) = driver([usedChannels-i usedChannels-i+1]);
     end
 end
 d = czeros(dataChannels);
 d(1:dataChannels) = driver(fDriverChannels_2+1:fDriverChannels_2+dataChannels);
 
 % Column vector for simulink
 data = d';
end
