function baseband = compileChannels(data, totalChannels, dataChannels, driverChannels)
 % Row vector for using vector concentration
 data = data';

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
 
 %Add driver channels
 driver = [cones(fDriverChannels_2) data cones(fDriverChannels_2)];
 for j=fliplr(1:fDriverChannels_2)
     for i=1:(fDeltaChannel+1)*j
         % Flip vector elements
        driver([i i+1]) = driver([i+1 i]);
        driver([usedChannels-i+1 usedChannels-i]) = driver([usedChannels-i usedChannels-i+1]);
     end
 end
  
 % Add null channels
 baseband = czeros(totalChannels);
 baseband(1:fUsedChannels_2) = driver(1:fUsedChannels_2);
 baseband(totalChannels-fUsedChannels_2+1:end) = driver(fUsedChannels_2+1:end);
 
 % Column vector for simulink
 baseband = baseband';
end
