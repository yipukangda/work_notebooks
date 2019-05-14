function varargout = task(varargin)
% TASK MATLAB code for task.fig
%      TASK, by itself, creates a new TASK or raises the existing
%      singleton*.
%
%      H = TASK returns the handle to a new TASK or the handle to
%      the existing singleton*.
%
%      TASK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TASK.M with the given input arguments.
%
%      TASK('Property','Value',...) creates a new TASK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before task_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to task_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help task

% Last Modified by GUIDE v2.5 30-Nov-2018 16:55:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @task_OpeningFcn, ...
                   'gui_OutputFcn',  @task_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before task is made visible.
function task_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to task (see VARARGIN)

% Choose default command line output for task
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes task wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = task_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in abasicAnalyse.
function abasicAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to abasicAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

levTimeLenTmp = handles.levTimeLenTmp;
levMeanTmp = handles.levMeanTmp;
levVarTmp =  handles.levVarTmp;

TimeLenpCnt_2 = 20;
MeanCnt_2 = 40;
VarCnt_2 = 20;

levTimeLen_2 = levTimeLenTmp(levTimeLenTmp~=0);
pTimeLen_2 = zeros(TimeLenpCnt_2, 1);
maxTimeLen_2 = max(levTimeLen_2);
minTimeLen_2 = min(levTimeLen_2);
thdTimeLen_2 = (maxTimeLen_2 - minTimeLen_2) / TimeLenpCnt_2;
for n = 1 : length(levTimeLen_2)
    if(levTimeLen_2(n) ~= minTimeLen_2)
        pTimeLen_2(ceil((levTimeLen_2(n) - minTimeLen_2) / thdTimeLen_2)) = pTimeLen_2(ceil((levTimeLen_2(n) - minTimeLen_2) / thdTimeLen_2)) + 1;
    else
        pTimeLen_2(1) = pTimeLen_2(1) + 1;
    end
end
pTimeLen_2 = pTimeLen_2 / length(levTimeLen_2);
idx = 1;
xLabels(idx,1) = round(minTimeLen_2);
idx = idx + 1;
for n = TimeLenpCnt_2-4 : -2 : 1
    xLabels(idx,1) = round(((maxTimeLen_2 - minTimeLen_2) / n + minTimeLen_2 )* 1000) + round(minTimeLen_2 * 1000);
    idx = idx + 1;
end
xLabels(idx,1) = round(((maxTimeLen_2 - minTimeLen_2) / 1 + minTimeLen_2 )* 1000) + round(minTimeLen_2 * 1000);

bar(handles.axes1, pTimeLen_2);
set(handles.axes1,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/5 : xLabels(end));
set(handles.axes1,'YLim',[0 1.1 * max(pTimeLen_2)]);


levMean_2 = levMeanTmp(levMeanTmp~=0);
pMean_2 = zeros(MeanCnt_2, 1);
maxMean_2 = max(levMean_2);
minMean_2 = min(levMean_2);
thdMean_2 = (maxMean_2 - minMean_2) / MeanCnt_2;
for n = 1 : length(levMean_2)
    if(levMean_2(n) ~= minMean_2)
        pMean_2(ceil((levMean_2(n) - minMean_2) / thdMean_2)) = pMean_2(ceil((levMean_2(n) - minMean_2) / thdMean_2)) + 1;
    else
        pMean_2(1) = pMean_2(1) + 1;
    end
end
pMean_2 = pMean_2 / length(levMean_2);
idx = 1;
xLabels(idx,1) = round(minMean_2);
idx = idx + 1;
for n =MeanCnt_2-4 : -2 : 1
    xLabels(idx,1) = round((maxMean_2 - minMean_2) / n + minMean_2);
    idx = idx + 1;
end
xLabels(idx,1) = round((maxMean_2 - minMean_2) / 1 + minMean_2);
bar(handles.axes2, pMean_2);
set(handles.axes2,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/10 : xLabels(end));
set(handles.axes2,'YLim',[0 1.1 * max(pMean_2)]);

levVar_2 = levVarTmp(levVarTmp~=0);
pVar_2 = zeros(VarCnt_2, 1);
maxVar_2 = max(levVar_2);
minVar_2 = min(levVar_2);
thdVar_2 = (maxVar_2 - minVar_2) / VarCnt_2;
for n = 1 : length(levVar_2)
    if(levVar_2(n) ~= minVar_2)
        pVar_2(ceil((levVar_2(n) - minVar_2) / thdVar_2)) = pVar_2(ceil((levVar_2(n) - minVar_2) / thdVar_2)) + 1;
    else
        pVar_2(1) = pVar_2(1) + 1;
    end
end
pVar_2 = pVar_2 / length(levVar_2);
idx = 1;
xLabels(idx,1) = round(minVar_2);
idx = idx + 1;
for n = VarCnt_2-4 : -2 : 1
    xLabels(idx,1) = round((maxVar_2 - minVar_2) / n + minVar_2);
    idx = idx + 1;
end
xLabels(idx,1) = round((maxVar_2 - minVar_2) / 1 + minVar_2);
bar(handles.axes3, pVar_2);
set(handles.axes3,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/5 : xLabels(end));
set(handles.axes3,'YLim',[0 1.1 * max(pVar_2)]);






% --- Executes on button press in eventsStatisticsAnalyse.
function eventsStatisticsAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to eventsStatisticsAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

levMean = handles.levMean;
levVar = handles.levVar;
levTimeLen =handles.levTimeLen;

TimeLenCnt = 50;
MeanCnt = 80;
VarCnt = 50;

pTimeLen = zeros(TimeLenCnt, 1);
maxTimeLen = max(levTimeLen);
minTimeLen = min(levTimeLen);
thdTimeLen = (maxTimeLen - minTimeLen) / TimeLenCnt;
for n = 1 : length(levTimeLen)
    if(levTimeLen(n) ~= minTimeLen)
        pTimeLen(ceil((levTimeLen(n) - minTimeLen) / thdTimeLen)) = pTimeLen(ceil((levTimeLen(n) - minTimeLen) / thdTimeLen)) + 1;
    else
        pTimeLen(1) = pTimeLen(1) + 1;
    end
end
pTimeLen = pTimeLen / length(levTimeLen);
idx = 1;
xLabels(idx,1) = round(minTimeLen);
idx = idx + 1;
for n = TimeLenCnt - 6 : -4 : 1
    xLabels(idx,1) = round(((maxTimeLen - minTimeLen) / n + minTimeLen )* 1000) + round(minTimeLen * 1000);
    idx = idx + 1;
end
xLabels(idx,1) = round(((maxTimeLen - minTimeLen) / 1 + minTimeLen )* 1000) + round(minTimeLen * 1000);
axes(handles.axes2);
bar(handles.axes4, pTimeLen);
set(handles.axes4,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/10 : xLabels(end));
set(handles.axes4,'YLim',[0 1.1 * max(pTimeLen)]);

pMean = zeros(MeanCnt, 1);
maxMean = max(levMean);
minMean = min(levMean);
thdMean = (maxMean - minMean) / MeanCnt;
for n = 1 : length(levMean)
    if(levMean(n) ~= minMean)
        pMean(ceil((levMean(n) - minMean) / thdMean)) = pMean(ceil((levMean(n) - minMean) / thdMean)) + 1;
    else
        pMean(1) = pMean(1) + 1;
    end
end
pMean = pMean / length(levMean);
idx = 1;
xLabels(idx,1) = round(minMean);
idx = idx + 1;
for n = MeanCnt - 8 : -4 : 1
    xLabels(idx,1) = round((maxMean - minMean) / n + minMean);
    idx = idx + 1;
end
xLabels(idx,1) = round((maxMean - minMean) / 1 + minMean);
bar(handles.axes5, pMean);
set(handles.axes5,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/10 : xLabels(end));
set(handles.axes5,'YLim',[0 1.1 * max(pMean)]);


pVar = zeros(VarCnt, 1);
maxVar = max(levVar);
minVar = min(levVar);  
thdVar = (maxVar - minVar) / VarCnt;
for n = 1 : length(levVar)
    if(levVar(n) ~= minVar)
        pVar(ceil((levVar(n) - minVar) / thdVar)) = pVar(ceil((levVar(n) - minVar) / thdVar)) + 1;
    else
        pVar(1) = pVar(1) + 1;
    end
end
pVar = pVar / length(levVar);
idx = 1;
xLabels(idx,1) = round(minVar);
idx = idx + 1;
for n = VarCnt - 6 : -4 : 1
    xLabels(idx,1) = round((maxVar - minVar) / n + minVar);
    idx = idx + 1;
end
xLabels(idx,1) = round((maxVar - minVar) / 1 + minVar);
bar(handles.axes6, pVar);
set(handles.axes6,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/10 : xLabels(end));
set(handles.axes6,'YLim',[0 1.1 * max(pVar)]);



% --- Executes on button press in loadFile.
function loadFile_Callback(hObject, eventdata, handles)
% hObject    handle to loadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla reset
axes(handles.axes2)
cla reset
axes(handles.axes3)
cla reset
axes(handles.axes4)
cla reset
axes(handles.axes5)
cla reset
axes(handles.axes6)
cla reset
set(handles.FileNum,'String',[num2str(0) ' 个']);
set(handles.totalTimeLen,'String',[num2str(0) ' 秒']);

%[FileName,PathName] = uigetfile('*.*','选择文件');
tr_dir=uigetdir({},'选择文件夹');  
FilePath =tr_dir;
%'D:\matlab\Gui\Gui_20181129\data\*.tdms';
list=dir(FilePath);
fileNum=size(list,1)-2;
set(handles.FileNum,'String',[num2str(fileNum) ' 个']);
%-------event--------%
levMean = [];
levVar = [];
levTimeLen = [];
%-------abasic------%
levTimeLenTmp = [];
levMeanTmp = [];
levVarTmp = [];
totallen = [];

Data = zeros(100000,4);
rowname=cell(100000,1);
rownum =1;

%Rownum=num2str(rownum);
header={'FileName','Level','TimeLen','Mean','Var'};
xlswrite('ABasicData.xlsx',header,1,'A1')

if(fileNum==0)
    disp('取消');
else
    disp(fileNum);
    h = waitbar(0,'正在提取...请稍后');
    for k=1:fileNum
        data=GuiConvertTDMS(0, ['data/' list(k).name]);
        
        flagChain = 2;
        if get(handles.chainChooseLong,'value')
            flagChain =1;
        elseif get(handles.chainChooseShort,'value')
            flagChain = 2;
        end  
        [dataFile, indexStart, indexEnd, openCurrent] = GuiExtractOpenCurrent(data.Data.MeasuredData(4).Data, flagChain);
        if isempty(indexStart)
            disp('没有提取到开孔电流');
        else
            dataLen = length(indexStart);
            for i=1:dataLen 
                dataTmp = dataFile(indexStart(i):indexEnd(i));
                len = length(dataTmp) * 1/25000;
                totallen(end+1) = len;
                [levellingData, levellingCnt, levellingCoverRate, levellingNormalization, levMean_1, levVar_1, levTimeLen_1, levIndex] = process_levelling(dataTmp, openCurrent);        
               %------------levellingdata-----------------------%
                levMean =[levMean levMean_1];
                levVar =[levVar levVar_1];
                levTimeLen =[levTimeLen levTimeLen_1];
               %------------abasicdata-------------------------%
                levellingDataDiff = diff(levellingData);
                levellingDataDiffIndex = find(levellingDataDiff ~= 0);
                lddnz = levellingData(levellingDataDiffIndex);
                [V,I] = max(lddnz);
               
                if (I>2)&length(lddnz)-I>11
                    if lddnz(1)==0
                        lddnz(1)=lddnz(2);
                    end
                    if I>11
                        leftdata = lddnz(I-10:I);
                    else
                        leftdata = lddnz(1:I);
                    end
                    leftV= min(leftdata);
                    if length(leftV)>1
                        leftV=leftV(2);
                    end
                    for n=1:10
                        rightdata = lddnz(I:I+n);    
                        rightV=min(rightdata);
                    end
                    %if abs(rightV-leftV)*openCurrent<10
                    s = length(find(Data(:,3)~=0))+1;
                    Name = [list(k).name(1:end-4),num2str(i)];
                    rowname(rownum)={Name};
                    leftindex = find(lddnz ==leftV);
                    if length(leftindex)>1
                        leftindex=leftindex(2);
                    end
                    rightindex = find(lddnz==rightV);

                    LeftStep = I-leftindex+1;
                    RightStep = rightindex - I+1;
                    rownum = LeftStep+RightStep + rownum-1;
                    %Rownum =  num2str(rownum);

                    Data(s,1)=LeftStep;
                    for m=0:rightindex-leftindex
                        rowdata = [levTimeLen_1(leftindex+m),levMean_1(leftindex+m),levVar_1(leftindex+m)];
                        Data(s+m,2:4)=rowdata; 
                    end
                    rightstart = s+LeftStep-1;
                    Data(rightstart,1)=RightStep;
                 
                    levTimeLenTmp =[levTimeLenTmp levTimeLen_1(leftindex:rightindex)];
                    levMeanTmp =[levMeanTmp levMean_1(leftindex:rightindex)];
                    levVarTmp =[levVarTmp levVar_1(leftindex:rightindex)];
                end             
            end
        end
        PerStr=floor(100*(k/fileNum));
        str=['正在运行中',num2str(PerStr),'%'];
        waitbar(k/fileNum,h,str);
    end
    handles.levMean= levMean;
    handles.levVar= levVar;
    handles.levTimeLen= levTimeLen;
    
    handles.levTimeLenTmp= levTimeLenTmp;
    handles.levMeanTmp= levMeanTmp;
    handles.levVarTmp= levVarTmp;
    handles.Data = Data;
    handles.rowname = rowname;
    close(h);
    set(handles.totalTimeLen,'String',[num2str(sum(totallen),3) ' 秒']);
    disp('可以画图了');
end
guidata(hObject,handles);


% --- Executes on button press in chainChooseShort.
function chainChooseShort_Callback(hObject, eventdata, handles)
% hObject    handle to chainChooseShort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chainChooseShort
set(handles.chainChooseShort,'value',1);
set(handles.chainChooseLong,'value',0);

% --- Executes on button press in chainChooseLong.
function chainChooseLong_Callback(hObject, eventdata, handles)
% hObject    handle to chainChooseLong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chainChooseLong
set(handles.chainChooseShort,'value',0);
set(handles.chainChooseLong,'value',1);


% --- Executes on button press in GenerateFile.
function GenerateFile_Callback(hObject, eventdata, handles)
% hObject    handle to GenerateFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = handles.Data;
rowname = handles.rowname ;
Data(Data==0)=nan;
xlswrite('ABasicData.xlsx',rowname,1,'A2');
xlswrite('ABasicData.xlsx',Data,1,'B2');
helpdlg('文件已生成请查看','提示');

