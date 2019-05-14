function [dataFile, indexStart, indexEnd,openCurrentArray]=GuiExtractOpenCurrent(input,flagChain,sampling)
% load lowpassfilter0.1_0.3.mat;

data = input;
dataFileInterp = data(1:sampling:end) + 1;
disp(sampling);
dataFile = dataFileInterp;
% figure;plot(data);
% dataFile = data;
% +++ solve to extract accurate open current for normalization +++ %
dataFilePure = dataFile;
% +++ solve to extract accurate open current for normalization +++ %

%------------------------- amplitud filter ------------------------%
% filt the large amplitude signal
filterOneThdCeil = 250;
filterOneThdFloor = 0;
for m = 1 : length(dataFile)
    if(dataFile(m) < filterOneThdFloor)
        dataFile(m) = 0; 
    end
    if(dataFile(m) > filterOneThdCeil)
        dataFile(m) = 0; 
    end
end
dataFileOneTmp = zeros(length(dataFile) , 1);
movingWin = 100;
for n = 1 : floor(length(dataFile) / movingWin)
    dataFileOneTmp((n - 1) * movingWin + 1 : n * movingWin) = min(dataFile((n - 1) * movingWin + 1 : n * movingWin));
end

% +++ solve the ______|-|____________ problem +++ %
movingWinMax = 100000;
dataFileOneMaxTmp = [];
for n = 1 : floor(length(dataFileOneTmp) / movingWinMax)
    dataFileOneMaxTmp((n - 1) * movingWinMax + 1 : n * movingWinMax) = max(dataFileOneTmp((n - 1) * movingWinMax + 1 : n * movingWinMax));
end
openCurrent = mean(dataFileOneMaxTmp);
% +++ solve the ______|-|____________ problem +++ %

for m = 1 : length(dataFile)
    if(dataFile(m) > openCurrent * 0.9)
        dataFile(m) = 0;
    end
end
dataFile = dataFile / openCurrent;
%------------------------- amplitud filter ------------------------%

%----------------------- zeros detect filter ----------------------%
% filt the peak which last a few time
filterTwoWinLen = 500;
for m = 1 : floor(length(dataFile) / filterTwoWinLen) - 1
    dataFileWin = dataFile((m - 1) * filterTwoWinLen + 1 : m * filterTwoWinLen);
    dataFileWinCnt = length(find(dataFileWin == 0));
    if(dataFileWinCnt > filterTwoWinLen / 3)
        dataFile((m - 1) * filterTwoWinLen + 1 : m * filterTwoWinLen) = 0;
    end
end
%----------------------- zeros detect filter ----------------------%

%-------------------------- median filter -------------------------%
% filt the peak
filterThreeMedLen = 5;
filterThreeRange = 100;
dataFile = medfilt1(dataFile , filterThreeMedLen);
%-------------------------- median filter -------------------------%

%----------------------- time window filter ----------------------%
% filt the rectangle wave
dataFile(1) = 0;
dataFile(end) = 0;
filterFourTimeRange = 200;
filterFourTimeRangeThd = 800;
filterFourTimeWin = 64;
filterFourTimeThd = 5000 / openCurrent;
indexStart = [];
indexEnd = [];
m1 = 1;
m2 = 1;
for m = 1 : length(dataFile) - 1
    if(dataFile(m) == 0 && dataFile(m + 1) > 0)
        indexStart(m1) = m;
        m1 = m1 + 1;
    elseif(dataFile(m) > 0 && dataFile(m + 1) == 0)
        indexEnd(m2) = m;
        m2 = m2 + 1;
    end
end
dataMeanIdx = zeros(filterFourTimeWin,1);
if(length(indexStart) == length(indexEnd))
    calcMeanCmp = zeros(filterFourTimeWin , 1);
    for m = 1 : length(indexStart)
        calcMeanSum = 0;
        dataTimeWin = dataFile(indexStart(m) : indexEnd(m));
        timeWinLen = floor(length(dataTimeWin) / filterFourTimeWin);
        for n = 1 : filterFourTimeWin
          calcMeanCmp(n) = mean(dataTimeWin((n - 1) * timeWinLen + 1 : n * timeWinLen));
        end
        for i = 1 : filterFourTimeWin
            for j = 1 : filterFourTimeWin
                calcMeanSum = abs(calcMeanCmp(i) - calcMeanCmp(j)) + calcMeanSum;
            end
        end
        if(calcMeanSum < filterFourTimeThd)
            dataFile(indexStart(m) : indexEnd(m)) = 0;
        end
        if(indexEnd(m) - indexStart(m) < filterFourTimeRangeThd)
            dataFile(indexStart(m) : indexEnd(m)) = 0;
        else
            dataFile(indexStart(m) : indexStart(m) + filterFourTimeRange) = 0;
            dataFile(indexEnd(m) - filterFourTimeRange : indexEnd(m)) = 0;
        end
    end
end
%----------------------- time window filter ----------------------%

%---------------------- remove max unsatisfy ---------------------%
indexStartMax = [];
indexEndMax = [];
m1 = 1;
m2 = 1;
for m = 1 : length(dataFile) - 1
    if(dataFile(m) == 0 && dataFile(m + 1) > 0)
        indexStartMax(m1) = m;
        m1 = m1 + 1;
    elseif(dataFile(m) > 0 && dataFile(m + 1) == 0)
        indexEndMax(m2) = m;
        m2 = m2 + 1;
    end
end

m = 1;
maxThd = 0.6;
for n = 1 : length(indexStartMax)
    if(max(dataFile(indexStartMax(n) : indexEndMax(n))) < maxThd)
        dataFile(indexStartMax(n) : indexEndMax(n)) = 0;
    end
end
%---------------------- remove max unsatisfy ---------------------%

%------------------ remove samples less than Thd -----------------%
if(flagChain==1)
    sampleThd = 20000;
else
    sampleThd = 200;
end
if(length(indexStart) == length(indexEnd))
    for m = 1 : length(indexStart)
        if(indexEnd(m) - indexStart(m) < sampleThd)
            dataFile(indexStart(m) : indexEnd(m)) = 0;
        end
    end
end
%------------------ remove samples less than Thd -----------------%

%----------------------- index re-calculate ----------------------%
indexStart = [];
indexEnd = [];
m1 = 1;
m2 = 1;
for m = 1 : length(dataFile) - 1
    if(dataFile(m) == 0 && dataFile(m + 1) > 0)
        indexStart(m1) = m + 1;
        m1 = m1 + 1;
    elseif(dataFile(m) > 0 && dataFile(m + 1) == 0)
        indexEnd(m2) = m - 1;
        m2 = m2 + 1;
    end
end
%----------------------- index re-calculate ----------------------%
%+++ add bessel filter +++%
cutOffFrq = 1000;
filterOrder = 24;
[b,a] = besself(filterOrder,cutOffFrq);
[num,den] = bilinear(b,a,cutOffFrq);
dataFile = filter(num,den,dataFile);
dataFilePure = filter(num,den,dataFilePure);

indexStart = indexStart + filterOrder * 5 / 4;
indexEnd = indexEnd + filterOrder / 3;
%+++ add bessel filter +++%

% +++ solve to extract accurate open current for normalization +++ %
openCurrentArray = zeros(length(indexStart) + 1, 1);
for n = 1 : length(indexStart) + 1
    if(n == 1)
        openCurrentTmp = dataFilePure(1 : indexStart(1));
    elseif(n == length(indexStart) + 1)
        openCurrentTmp = dataFilePure(indexEnd(end) : end);
    else
    	openCurrentTmp = dataFilePure(indexEnd(n - 1) : indexStart(n));
    end
    
    ocZerosFirst = openCurrentTmp > openCurrent * 1.05;
    openCurrentTmp(ocZerosFirst) = 0;
    ocZeros = openCurrentTmp > openCurrent * 0.95;
    
%     figure;plot(openCurrentTmp(ocZeros));
%     close all;
    openCurrentArray(n) = mean(openCurrentTmp(ocZeros));
    if  isnan(openCurrentArray(n))
        if (n==1)
            openCurrentArray(n) = openCurrent;
        else
            openCurrentArray(n) = openCurrentArray(n-1);
        end
    end
    openCurrentTmp = [];
end
% +++ solve to extract accurate open current for normalization +++ %

disp('extract finished!');