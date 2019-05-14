function [data, total, coverRate, dataLev, levMean, levStd, levTimeLen, levellingIndex] = process_levelling(input,openCurrent,thdLevellingWidth,thdMax)
     
levellingSignal = zeros(length(input) , 1);
indexTotal = 5000;
amp = 999999;
levellingIndex = amp * ones(indexTotal , 1);
levellingIndex(1) = 1;
levellingIndex(2) = length(input);

%thdMax = 0.01/3;
%thdMax = 0.025/3;
% thdLevellingWidth = 20;
flag = 0;
while(1)
    cnt = 1;
    loopCnt = find(levellingIndex ~= amp);
    for n = 1 : length(loopCnt) - 1
        levellingFindMax = natureBioFunc(input(levellingIndex(n) : levellingIndex(n + 1)));
        [v,idx] = max(levellingFindMax);
        if(v > thdMax)
            levellingIndex(length(loopCnt) + n) = levellingIndex(n) + idx;
            cnt = cnt + 1;
        end
    end
    
    if(cnt == 1)
        flag = 1;
    end
    levellingIndex = sort(levellingIndex);
    if(flag == 1)
        break;
    end
end
levellingTotal = length(find(levellingIndex ~= amp));
for n = 1 : levellingTotal - 1
    if(levellingIndex(n + 1) - levellingIndex(n) < thdLevellingWidth)
        levellingIndex(n) = amp;
    end
end
% disp(thdMax);
% disp(thdLevellingWidth);
levellingIndex = sort(levellingIndex);
levellingTotal = length(find(levellingIndex ~= amp));
levellGap = 10;
levellingSignalNormalization = zeros(levellingTotal * levellGap, 1);
levMean = zeros(length(levellingTotal) - 1 , 1);
levStd= zeros(length(levellingTotal) - 1 , 1);
levTimeLen = zeros(length(levellingTotal) - 1 , 1);

for n = 1 : levellingTotal - 1
    levellingSignal(levellingIndex(n) : levellingIndex(n + 1)) = mean(input(levellingIndex(n) : levellingIndex(n + 1)));
    levellingSignalNormalization((n - 1) * levellGap + 1 : n * levellGap) = mean(input(levellingIndex(n) : levellingIndex(n + 1)));
    
    levMean(n) = mean((input(levellingIndex(n) : levellingIndex(n + 1))) * openCurrent);
    levStd(n) = std((input(levellingIndex(n) : levellingIndex(n + 1))) * openCurrent,1);
    levTimeLen(n) = (levellingIndex(n + 1) - levellingIndex(n)) / 25000;
end

levellingCoverRate = unique(levellingSignal);
coverRateMax = length(find(levellingSignal == levellingCoverRate(1)));
for n = 2 : length(levellingCoverRate)
    if(coverRateMax < length(find(levellingSignal == levellingCoverRate(n))))
        coverRateMax = length(find(levellingSignal == levellingCoverRate(n)));
    end
end

coverRate = coverRateMax / length(levellingSignal);
data = levellingSignal;
total = levellingTotal-1;
dataLev = levellingSignalNormalization;
