function loc = natureBioFunc(Data)

lgP = zeros(length(Data),1);
for n = 2 : 10 : length(Data) - 10
    It1 = Data(1:n);
    testT1M = mean(It1);
    testT1D = var(It1);
    bia = -1;
    lgP12 = ( (1/sqrt(2*pi)) * exp( (It1 - testT1M).^2 ./ (2*testT1D^2 + bia) ) );
    
    It2 = Data(n+1:end);
    testT2M = mean(It2);
    testT2D = var(It2);
    lgP23 = ( (1/sqrt(2*pi)) * exp( (It2 - testT2M).^2 ./ (2*testT2D^2 + bia) ) );
    
    It3 = Data(1:end);
    testT3M = mean(It3);
    testT3D = var(It3);
    lgP13 = ( (1/sqrt(2*pi)) * exp( (It3 - testT3M).^2 ./ (2*testT3D^2 + bia) ) );
    
    lgP(n) = sum(lgP12) + sum(lgP23) - sum(lgP13);
end

loc = lgP;