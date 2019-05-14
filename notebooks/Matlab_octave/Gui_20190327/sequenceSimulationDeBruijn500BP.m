clear;
clc;
close all;
dataMapFile = importdata('4-mer_Map/ACGT_V1X.txt');
dataSimFile = importdata('4-mer_Map/X2_Seq.txt');
dataCur = dataMapFile.data;
dataSeq = dataMapFile.textdata;

flagRev = 0;            % 0£ºÕýÐò    1£ºÄæÐò
dataSimSeqRev = dataSimFile{1,1};
if(flagRev == 1)
    dataSimSeq = dataSimSeqRev(end :-1:1);
else
    dataSimSeq = dataSimSeqRev(1:1:end);
end
dataFigure = zeros(length(dataSimSeq) - 4,1);

for n = 1 : length(dataSimSeq) - 4
    dataComp = dataSimSeq(n:n + 3);
    for m = 1 : length(dataSeq)
        if(strcmp(dataComp,dataSeq{m,1}))
            dataFigure(n) = dataCur(m);
            break;
        end
    end
end

dataFinal = [];
gap = 50;
for n = 1 : length(dataFigure)
    dataFinal(gap*(n-1) + 1: gap*n) = dataFigure(n);
end

currentOpen = 165;
currentDefault = 110;
flipDataFigure = dataFigure * currentOpen / currentDefault;
flipDataFinal = dataFinal * currentOpen / currentDefault;
figure;
plot(flipDataFigure);
figure;
plot(flipDataFinal);

