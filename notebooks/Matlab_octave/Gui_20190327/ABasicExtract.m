function [leftindex,rightindex,LeftStep,RightStep,levTimeLenTmp, levMeanTmp, levVarTmp] = ABasicExtract(input,openCurrent,thdLevellingWidth,thdMax)
%Step = [];
[levellingData, levellingCnt, levellingCoverRate, levellingNormalization, levMeanMark, levVarMark, levTimeLenMark, levIndex] = process_levelling(input, openCurrent,thdLevellingWidth,thdMax);
levellingDataDiff = diff(levellingData);
levellingDataDiffIndex = find(levellingDataDiff ~= 0);
lddnz = levellingData(levellingDataDiffIndex);
[V,I] = max(lddnz);

if (I>2)&length(lddnz)-I>5  
    if lddnz(1)==0
        lddnz(1)=lddnz(2);
    end
    if I>11
        leftdata = lddnz(I-10:I);
    else
        leftdata = lddnz(1:I);
    end
    leftV= min(leftdata);
    if length(lddnz)-I>10
        rightdata = lddnz(I:I+10);    
        rightV=min(rightdata);    
    else
        rightdata = lddnz(I:I+5);    
        rightV=min(rightdata);
    end
    leftindex = find(lddnz ==leftV);
    if length(leftindex)>1
        leftindex = leftindex(2);
    end
    rightindex = find(lddnz==rightV);

    LeftStep = I-leftindex+1;
    RightStep = rightindex - I+1;
    %Step = [LeftStep RightStep;Step];
    levTimeLenTmp =levTimeLenMark(leftindex:rightindex);
    levMeanTmp =levMeanMark(leftindex:rightindex);
    levVarTmp =levVarMark(leftindex:rightindex);
else
    leftindex=0;
    rightindex=0;
    LeftStep=0;
    RightStep=0;
    levTimeLenTmp =0;
    levMeanTmp =0;
    levVarTmp =0;
end             

