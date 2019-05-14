function varargout = Gui(varargin)
% GUI MATLAB code for Gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui

% Last Modified by GUIDE v2.5 28-Feb-2019 17:18:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_OutputFcn, ...
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


% --- Executes just before Gui is made visible.
function Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui (see VARARGIN)

% Choose default command line output for Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global figCnt;
global markSignalArray;

figCnt = 0;
markSignalArray = [];
set(handles.chainChooseShort,'value',0);
set(handles.chainChooseLong,'value',1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in plotDNAPassHoleCurrent.
function plotDNAPassHoleCurrent_Callback(hObject, eventdata, handles)
% hObject    handle to plotDNAPassHoleCurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figCnt;
global dataFile;
global indexStart;
global indexEnd;
global markSignalArray;
global fileNameList;
global fileNameCnt;
global flagChain;
global fileMarkArray;
global flagFile;
global openCurrentArray;
global sampling;
flagMark = 0;
for n = 1 : length(markSignalArray)
    if(markSignalArray(n) == figCnt + 1)
        flagMark = 1;
        break;
    end
end

if flagFile==1
    if(figCnt < length(indexStart))
        figCnt = figCnt + 1;     
        openCurrent = openCurrentArray(figCnt);
        plot(handles.axes1, dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);
        set(handles.axes1,'YLim',[0 10 + max(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent)]);
        
%         interp_20 = data(1:20:end);
%         plot(handles.axes2, interp_20 * openCurrent);
%         set(handles.axes2,'YLim',[0 10 + max(interp_20 * openCurrent)]); 
        
        set(handles.openCurrent,'String',[num2str(openCurrent , 5) ' pA']);
        set(handles.totalTime,'String',[num2str(length(dataFile(indexStart(figCnt):indexEnd(figCnt))) * 1/25000,3) ' 秒']);
        set(handles.currentOpenCurrent,'String',num2str(figCnt));
        if(flagMark == 1)
            set(handles.markSignal,'Enable','off');
            set(handles.markSignal,'String','已标记');
         else
            set(handles.markSignal,'Enable','on');
            set(handles.markSignal,'String','标记');
        end
    end
end


if flagFile==2
    if(figCnt < length(indexStart))
        figCnt = figCnt + 1;
        openCurrent = openCurrentArray(figCnt);
        plot(handles.axes1, dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);
        set(handles.axes1,'YLim',[0 10 + max(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent)]);       
        set(handles.openCurrent,'String',[num2str(openCurrent , 5) ' pA']);
        set(handles.totalTime,'String',[num2str(length(dataFile(indexStart(figCnt):indexEnd(figCnt))) * 1/25000,3) ' 秒']);
        set(handles.currentOpenCurrent,'String',num2str(figCnt));
%         indexLen = indexEnd(figCnt)-indexStart(figCnt);
%         disp(indexLen);
        if(flagMark == 1)
            set(handles.markSignal,'Enable','off');
            set(handles.markSignal,'String','已标记');
        else
            set(handles.markSignal,'Enable','on');
            set(handles.markSignal,'String','标记');
        end
    else
        if(fileNameCnt > length(fileNameList) - 3)

        else
            figCnt = 1;
            markSignalArray = [];
            fileNameCnt = fileNameCnt + 1;

            lenThdFlag = length(find(fileMarkArray(fileNameCnt, :) ~= -1));
            if(lenThdFlag > 0)
                for n = 1 : lenThdFlag;
                    markSignalArray(n) = fileMarkArray(fileNameCnt, n);
                end
            end

            set(handles.loadFile,'Enable','off');
            set(handles.loadFileBatch,'Enable','off');
            set(handles.plotDNAPassHoleCurrent,'Enable','off');
            set(handles.plotDNAPassHoleCurrentPre,'Enable','off');
            set(handles.levelling,'Enable','off');
            set(handles.abasicAnalyse,'Enable','off');
            set(handles.dataPlotAnalyse,'Enable','off');
            set(handles.markSignal,'Enable','off');
            set(handles.eventsStatisticsAnalyse,'Enable','off');
            set(handles.markSignalABasicAnalyse,'Enable','off');
            set(handles.markSignalAllAnalyse,'Enable','off');
            set(handles.saveLevellingdata,'Enable','off');
            
            h = waitbar(0,'正在提取...请稍后');

            fileName = fileNameList(fileNameCnt).name;

            data=GuiConvertTDMS(0, ['data/' fileName]);
            if isempty(sampling)
                sampling = 4;
            end
            [dataFile, indexStart, indexEnd, openCurrentArray] = GuiExtractOpenCurrent(data.Data.MeasuredData(4).Data, flagChain, sampling);
            openCurrent = openCurrentArray(1);
            if(isempty(indexStart))
                waitbar(1,h);
                errordlg('没有提取到过孔电流','警告','modal');
                set(handles.loadFile,'Enable','on');
                set(handles.fileTotalCurrent,'String',num2str(fileNameCnt));
            else
                set(handles.openCurrent,'String',[num2str(openCurrent , 5) ' pA']);
                set(handles.totalOpenCurrent,'String',num2str(length(indexStart)));
                set(handles.totalTime,'String',[num2str(length(dataFile(indexStart(figCnt):indexEnd(figCnt))) * 1/25000,3) ' 秒']);

                plot(handles.axes1, dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);
                set(handles.axes1,'YLim',[0 10 + max(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent)]);
                
                
                set(handles.currentOpenCurrent,'String',num2str(figCnt));
                set(handles.fileTotalNum,'String',num2str(length(fileNameList) - 2));
                set(handles.fileTotalCurrent,'String',num2str(fileNameCnt));
            end

            waitbar(1,h);
            pause(0.5);
            close(h);

            set(handles.loadFile,'Enable','on');
            set(handles.loadFileBatch,'Enable','on');
            set(handles.plotDNAPassHoleCurrent,'Enable','on');
            set(handles.plotDNAPassHoleCurrentPre,'Enable','on');
            set(handles.levelling,'Enable','on');
            set(handles.abasicAnalyse,'Enable','on');
            set(handles.dataPlotAnalyse,'Enable','on');
            set(handles.markSignal,'Enable','on');
            set(handles.eventsStatisticsAnalyse,'Enable','on');
            set(handles.markSignalABasicAnalyse,'Enable','on');
            set(handles.markSignalAllAnalyse,'Enable','on');
            set(handles.saveLevellingdata,'Enable','on');
            flagMark = 0;
            for n = 1 : length(markSignalArray)
                if(markSignalArray(n) == figCnt)
                    flagMark = 1;
                    break;
                end
            end
            if(flagMark == 1)
                set(handles.markSignal,'Enable','off');
                set(handles.markSignal,'String','已标记');
            else
                set(handles.markSignal,'Enable','on');
                set(handles.markSignal,'String','标记');
            end
        end
    end
end


% --- Executes on button press in plotDNAPassHoleCurrentPre.
function plotDNAPassHoleCurrentPre_Callback(hObject, eventdata, handles)
% hObject    handle to plotDNAPassHoleCurrentPre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figCnt;
global dataFile;
global indexStart;
global indexEnd;
global markSignalArray;
global fileNameList;
global fileNameCnt;
global flagChain;
global fileMarkArray;
global flagFile;
global openCurrent;
global openCurrentArray;
global sampling;

flagMark = 0;
for n = 1 : length(markSignalArray)
    if(markSignalArray(n) == figCnt - 1)
        flagMark = 1;
        break;
    end
end

if flagFile==1;
    if(figCnt > 1)
        figCnt = figCnt - 1;
        openCurrent = openCurrentArray(figCnt);
        plot(handles.axes1, dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);
        set(handles.axes1,'YLim',[0 10 + max(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent)]);
%         data = dataFile(indexStart(figCnt):indexEnd(figCnt));
%         interp_20 = data(1:20:end);
%         plot(handles.axes2, interp_20 * openCurrent);
%         set(handles.axes2,'YLim',[0 10 + max(interp_20 * openCurrent)]); 
        
        set(handles.openCurrent,'String',[num2str(openCurrent , 5) ' pA']);
        set(handles.totalTime,'String',[num2str(length(dataFile(indexStart(figCnt):indexEnd(figCnt))) * 1/25000,3) ' 秒']);
        set(handles.currentOpenCurrent,'String',num2str(figCnt));
        if(flagMark == 1)
            set(handles.markSignal,'Enable','off');
            set(handles.markSignal,'String','已标记');
        else
            set(handles.markSignal,'Enable','on');
            set(handles.markSignal,'String','标记');
        end
    end
end

if flagFile==2;
    if(figCnt > 1)
        figCnt = figCnt - 1;
        openCurrent = openCurrentArray(figCnt);
        plot(handles.axes1, dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);
        set(handles.axes1,'YLim',[0 10 + max(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent)]);
       
        set(handles.openCurrent,'String',[num2str(openCurrent , 5) ' pA']);
        set(handles.totalTime,'String',[num2str(length(dataFile(indexStart(figCnt):indexEnd(figCnt))) * 1/25000,3) ' 秒']);
        set(handles.currentOpenCurrent,'String',num2str(figCnt));

        if(flagMark == 1)
            set(handles.markSignal,'Enable','off');
            set(handles.markSignal,'String','已标记');
        else
            set(handles.markSignal,'Enable','on');
            set(handles.markSignal,'String','标记');
        end
    else
        if(fileNameCnt < 2)

        else
            figCnt = 1;
            markSignalArray = [];
            fileNameCnt = fileNameCnt - 1;

            lenThdFlag = length(find(fileMarkArray(fileNameCnt, :) ~= -1));
            if(lenThdFlag > 0)
                for n = 1 : lenThdFlag;
                    markSignalArray(n) = fileMarkArray(fileNameCnt, n);
                end
            end

            set(handles.loadFile,'Enable','off');
            set(handles.loadFileBatch,'Enable','off');
            set(handles.plotDNAPassHoleCurrent,'Enable','off');
            set(handles.plotDNAPassHoleCurrentPre,'Enable','off');
            set(handles.levelling,'Enable','off');
            set(handles.abasicAnalyse,'Enable','off');
            set(handles.dataPlotAnalyse,'Enable','off');
            set(handles.markSignal,'Enable','off');
            set(handles.eventsStatisticsAnalyse,'Enable','off');
            set(handles.markSignalABasicAnalyse,'Enable','off');
            set(handles.markSignalAllAnalyse,'Enable','off');
            set(handles.saveLevellingdata,'Enable','off');
            
            h = waitbar(0,'正在提取...请稍后');

            fileName = fileNameList(fileNameCnt).name;

            data=GuiConvertTDMS(0, ['data/' fileName]);
            if isempty(sampling)
                sampling = 4;
            end
            [dataFile, indexStart, indexEnd, openCurrentArray] = GuiExtractOpenCurrent(data.Data.MeasuredData(4).Data, flagChain, sampling);
            openCurrent = openCurrentArray(1);
            if(isempty(indexStart))
                waitbar(1,h);
                errordlg('没有提取到过孔电流','警告','modal');
                set(handles.loadFile,'Enable','on');
                set(handles.fileTotalCurrent,'String',num2str(fileNameCnt));
            else
                set(handles.openCurrent,'String',[num2str(openCurrent , 5) ' pA']);
                set(handles.totalOpenCurrent,'String',num2str(length(indexStart)));
                set(handles.totalTime,'String',[num2str(length(dataFile(indexStart(figCnt):indexEnd(figCnt))) * 1/25000,3) ' 秒']);

                plot(handles.axes1, dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);
                set(handles.axes1,'YLim',[0 10 + max(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent)]);
               
                set(handles.currentOpenCurrent,'String',num2str(figCnt));
                set(handles.fileTotalNum,'String',num2str(length(fileNameList) - 2));
                set(handles.fileTotalCurrent,'String',num2str(fileNameCnt));
            end

            waitbar(1,h);
            pause(0.5);
            close(h);

            set(handles.loadFile,'Enable','on');
            set(handles.loadFileBatch,'Enable','on');
            set(handles.plotDNAPassHoleCurrent,'Enable','on');
            set(handles.plotDNAPassHoleCurrentPre,'Enable','on');
            set(handles.levelling,'Enable','on');
            set(handles.abasicAnalyse,'Enable','on');
            set(handles.dataPlotAnalyse,'Enable','on');
            set(handles.markSignal,'Enable','on');
            set(handles.eventsStatisticsAnalyse,'Enable','on');
            set(handles.markSignalABasicAnalyse,'Enable','on');
            set(handles.markSignalAllAnalyse,'Enable','on');
            set(handles.saveLevellingdata,'Enable','on');
            
            flagMark = 0;
            for n = 1 : length(markSignalArray)
                if(markSignalArray(n) == figCnt)
                    flagMark = 1;
                    break;
                end
            end
            if(flagMark == 1)
                set(handles.markSignal,'Enable','off');
                set(handles.markSignal,'String','已标记');
            else
                set(handles.markSignal,'Enable','on');
                set(handles.markSignal,'String','标记');
            end
        end
    end
end


% --- Executes on button press in levelling.
function levelling_Callback(hObject, eventdata, handles)
% hObject    handle to levelling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataFile;
global indexStart;
global indexEnd;
global figCnt;
global levellingData;
global levellingNormalization;
global levellingCnt;
global levMean;
global levStd;
global levTimeLen;
global levIndex;
global flagChain;
global thdLevellingWidth;
global openCurrentArray;
global thdMax;
global dataTmp;

dataTmp = dataFile(indexStart(figCnt):indexEnd(figCnt));
openCurrent = openCurrentArray(figCnt);
h = waitbar(10,'正在处理...请稍后');
if isempty(thdLevellingWidth)
    thdLevellingWidth = 20;
end
if isempty(thdMax)
    thdMax = 0.0083;
end 
[levellingData, levellingCnt, levellingCoverRate, levellingNormalization, levMean, levStd, levTimeLen, levIndex] = process_levelling(dataTmp, openCurrent,thdLevellingWidth,thdMax);

plot(handles.axes2, levellingData * openCurrent);
set(handles.axes2,'YLim',[0 10 + max(levellingData * openCurrent)]);
% disp(levellingCnt);
% disp(openCurrent);
% --------------------------------------------------------------- %
levellingDataDiff = diff(levellingData);
levellingDataDiffIndex = find(levellingDataDiff ~= 0);
lddnz = levellingData(levellingDataDiffIndex);
ABasicextractData = zeros(length(levellingNormalization),1);
AGAAextractData = zeros(length(levellingNormalization),1);
% figure;
% plot(levellingNormalization(1:end-20) * openCurrent);

% --- looking for ABasic --- %
[V,I] = max(lddnz);
ABasicextractData(I * 10-5) = V * openCurrent;

data_len = length(lddnz);
ABindex_end = ceil(data_len*0.4);
ABdata = lddnz(1:ABindex_end);
[V,I] = max(ABdata);
% disp(V*openCurrent);
ABasicextractData(I * 10-5) = V * openCurrent;

% --- looking for AGAA --- %
if(flagChain == 1)
    AGAAindex_end = ceil(data_len *(1-0.05));
    AGAA_data = lddnz(I+10:AGAAindex_end);
    AGAA_num= sort(AGAA_data,'descend');

    for n = 1:15
        index_n = find(lddnz==AGAA_num(n));
        for m=1:6
            if (lddnz(index_n-m)<(40 / openCurrent)||lddnz(index_n+m)<(40 / openCurrent))
                AGAAextractData(index_n * 10-5) = lddnz(index_n) * openCurrent;
                break
            end
        end 
    end
    %total_len = length(levellingNormalization);
    for n =1:3
        index_notzero = find(AGAAextractData~=0);
        for i=1:length(index_notzero)-1
            if abs(index_notzero(i)-index_notzero(i+1))<250
                a = index_notzero(i);
                b = index_notzero(i+1);
                if AGAAextractData(a)-AGAAextractData(b)>0
                    AGAAextractData(b)=0;
                else
                    AGAAextractData(a)=0;            
                end       
            end
        end
    end  

    index_notzero_two = find(AGAAextractData~=0);
    if length(index_notzero_two)>4
        for n =0:length(index_notzero_two)-2
            index_old = (index_notzero_two(end-n)+5)/10;
            index_new = index_notzero_two(end-n);
            sign= 0;
            for m = 1:6
                if lddnz(index_old-m)<(40 / openCurrent)
                    sign = sign+1;
                    break
                end
            end
            for m = 1:5
                if lddnz(index_old+m)<(40 / openCurrent)
                    sign = sign+1;
                    break
                end        
            end
            if sign~=2
                %disp(sign);
                AGAAextractData(index_new)=0;     
            end
        end
    end

    axes(handles.axes3)
    cla reset
    plot(handles.axes3, ABasicextractData,'m');
    hold( handles.axes3, 'on' )
    plot(handles.axes3, AGAAextractData,'r');
    hold( handles.axes3, 'on' )
    % --------------------------------------------------------------- %
end
plot(handles.axes3, levellingNormalization(1:end-20) * openCurrent);
set(handles.axes3,'YLim',[0 10 + max(levellingNormalization * openCurrent)]);
set(handles.totalEvent,'String',num2str(levellingCnt));
waitbar(100,h);
pause(1.5);
close(h);


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global markSignalArray;
    
markSignalArray = [];

set(handles.plotDNAPassHoleCurrent,'Enable','off');
set(handles.plotDNAPassHoleCurrentPre,'Enable','off');
set(handles.levelling,'Enable','off');
set(handles.abasicAnalyse,'Enable','off');
set(handles.saveLevellingdata,'Enable','off');
set(handles.markSignal,'Enable','off');
set(handles.eventsStatisticsAnalyse,'Enable','off');
set(handles.markSignalAllAnalyse,'Enable','off');
set(handles.markSignalABasicAnalyse,'Enable','off');

axes(handles.axes1)
cla reset
axes(handles.axes2)
cla reset
axes(handles.axes3)
cla reset
set(handles.openCurrent,'String',[num2str(0 , 4) ' pA']);
set(handles.marklen,'String',[num2str(0 , 4) ' pA']);
set(handles.totalOpenCurrent,'String',num2str(0));
set(handles.totalTime,'String',[num2str(0) ' 秒']);
set(handles.currentOpenCurrent,'String',num2str(0));
set(handles.totalEvent,'String',num2str(0));


% --- Executes on button press in loadFile.
function loadFile_Callback(hObject, eventdata, handles)
% hObject    handle to loadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% dir1=uigetdir('data/','浏览');
global sampling;
global dataFile;
global indexStart;
global indexEnd;
global figCnt;
global flagChain;
global markSignalArray;
global flagFile;
global fileName;
global openCurrentArray;
global flipDataFinal;

flagFile=1;
markSignalArray = [];
axes(handles.axes1)
cla reset
axes(handles.axes2)
cla reset
axes(handles.axes3)
cla reset
%axes(handles.axes4)
cla reset
set(handles.openCurrent,'String',[num2str(0 , 4) ' pA']);
set(handles.totalOpenCurrent,'String',num2str(0));
set(handles.totalTime,'String',[num2str(0) ' 秒']);
set(handles.currentOpenCurrent,'String',num2str(0));
set(handles.totalEvent,'String',num2str(0));
set(handles.fileTotalNum,'String',num2str(0));
set(handles.fileTotalCurrent,'String',num2str(0));
set(handles.marklen,'String',[num2str(0 , 4) ' pA']);

fileName = uigetfile('*.tdms','选择文件');

if(fileName == 0)
    disp('取消');
else
    figCnt = 1;

    h = waitbar(0,'正在提取...请稍后');

    set(handles.loadFile,'Enable','off');
    set(handles.plotDNAPassHoleCurrent,'Enable','off');
    set(handles.plotDNAPassHoleCurrentPre,'Enable','off');
    set(handles.levelling,'Enable','off');
    set(handles.abasicAnalyse,'Enable','off');
    set(handles.dataPlotAnalyse,'Enable','off');
    set(handles.markSignal,'Enable','off');
    set(handles.eventsStatisticsAnalyse,'Enable','off');
    set(handles.markSignalABasicAnalyse,'Enable','off');
    set(handles.markSignalAllAnalyse,'Enable','off');
    set(handles.saveLevellingdata,'Enable','off');
    
    data=GuiConvertTDMS(0, ['data/' fileName]);

    flagChain = 1;
    if get(handles.chainChooseLong,'value')
        flagChain=1;
    elseif get(handles.chainChooseShort,'value')
        flagChain=2;
    end
    
    if isempty(sampling)
        sampling = 4;
    end
    waitbar(20,h);
    if isempty(sampling)
        sampling = 4;
    end
    [dataFile, indexStart, indexEnd, openCurrentArray] = GuiExtractOpenCurrent(data.Data.MeasuredData(4).Data, flagChain, sampling);
%     figure;
%     plot(dataFile);
%     indexLen = indexEnd(figCnt)-indexStart(figCnt);
%     disp(indexLen);
    openCurrent = openCurrentArray(1);
    if(isempty(indexStart))
        waitbar(100,h);
        close(h);
        errordlg('没有提取到过孔电流','警告','modal');
        set(handles.loadFile,'Enable','on');
    else
        set(handles.openCurrent,'String',[num2str(openCurrent , 5) ' pA']);
        set(handles.totalOpenCurrent,'String',num2str(length(indexStart)));
        set(handles.totalTime,'String',[num2str(length(dataFile(indexStart(figCnt):indexEnd(figCnt))) * 1/25000,3) ' 秒']);

        plot(handles.axes1, dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);
        set(handles.axes1,'YLim',[0 10 + max(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent)]);
%         data =  dataFile(indexStart(figCnt):indexEnd(figCnt));
%         interp_20 = data(1:20:end);
%         plot(handles.axes2, interp_20 * openCurrent);
%         set(handles.axes2,'YLim',[0 10 + max(interp_20) * openCurrent]);
        
        set(handles.currentOpenCurrent,'String',num2str(figCnt));

        waitbar(100,h);
        pause(1.5);
        close(h);
        set(handles.loadFile,'Enable','on');
        set(handles.plotDNAPassHoleCurrent,'Enable','on');
        set(handles.plotDNAPassHoleCurrentPre,'Enable','on');
        set(handles.levelling,'Enable','on');
        set(handles.abasicAnalyse,'Enable','on');
        set(handles.dataPlotAnalyse,'Enable','on');
        set(handles.markSignal,'Enable','on');
        set(handles.eventsStatisticsAnalyse,'Enable','on');
        set(handles.markSignalABasicAnalyse,'Enable','on');
        set(handles.markSignalAllAnalyse,'Enable','on');
        set(handles.saveLevellingdata,'Enable','on');
    end
    dataMapFile = importdata('ACGT_V1X.txt');
    dataSimFile = importdata('X2_Seq.txt');
    dataCur = dataMapFile.data;
    dataSeq = dataMapFile.textdata;

    flagRev = 0;            % 0：正序    1：逆序
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
    gap = 10;
    for n = 1 : length(dataFigure)
        dataFinal(gap*(n-1) + 1: gap*n) = dataFigure(n);
    end

    if(flagChain == 1)
        currentDefault = 110;
        flipDataFinal = dataFinal * openCurrent / currentDefault;
%         plot(handles.axes4, flipDataFinal);
%         hold( handles.axes4, 'on' );
        flipDataFinalFlagAGAA = zeros(length(flipDataFinal), 1);
        flipDataFinalFlagABasic = zeros(length(flipDataFinal), 1);
        flipDataFinalFlagABasic(615) = flipDataFinal(615) - 5;
        flipDataFinalFlagAGAA(1245) = flipDataFinal(1245) - 5;
        flipDataFinalFlagAGAA(2085) = flipDataFinal(2085) - 5;
        flipDataFinalFlagAGAA(2925) = flipDataFinal(2925) - 5;
        flipDataFinalFlagAGAA(3825) = flipDataFinal(3825) - 5;
%         plot(handles.axes4, flipDataFinalFlagABasic,'m');
%         hold( handles.axes4, 'on' );
%         plot(handles.axes4, flipDataFinalFlagAGAA,'r');
%         set(handles.axes4,'YLim',[0 10 + max(flipDataFinal)]);
    end
end


% --- Executes on button press in abasicAnalyse.
function abasicAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to abasicAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% figure;
global levMean;
global levStd;
global levTimeLen;
global levMeanLeft;
global levVarLeft;
global levTimeLenLeft;
global levMeanRight;
global levVarRight;
global levTimeLenRight;
global abasicIndex;
global abasicIndexLeft;
global abasicIndexRight;

dis = 15;
levMeanLeft = zeros(dis, 1);
levVarLeft = zeros(dis, 1);
levTimeLenLeft = zeros(dis, 1);
levMeanRight = zeros(dis, 1);
levVarRight = zeros(dis, 1);
levTimeLenRight = zeros(dis, 1);
[M,I] = max(levMean);
abasicIndex = I;
m = 1;
for n = I : -1 : I - dis + 1
    if(n == 0)
        break;
    else
        levMeanLeft(m) = levMean(n);
        levVarLeft(m) = levStd(n);
        levTimeLenLeft(m) = levTimeLen(n);
        m = m + 1;
    end
end
abasicIndexLeft = m - 1;
m = 1;
for n = I : I + dis - 1
    if(n == length(levMean))
        break;
    else
        levMeanRight(m) = levMean(n);
        levVarRight(m) = levStd(n);
        levTimeLenRight(m) = levTimeLen(n);
        m = m + 1;
    end
end
abasicIndexRight = m - 1;
ABasic;


% --- Executes on button press in dataPlotAnalyse.
function dataPlotAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to dataPlotAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataFile;
global indexStart;
global indexEnd;
global figCnt;
global openCurrent;
figure;
plot(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);


% --- Executes on button press in eventsStatisticsAnalyse.
function eventsStatisticsAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to eventsStatisticsAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

eventsStatistics;


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


% --- Executes on button press in markSignal.
function markSignal_Callback(hObject, eventdata, handles)
% hObject    handle to markSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figCnt;
global markSignalArray;
global fileMarkArray;
global fileNameCnt;
global flagFile;

flagMark = 0;
if(isempty(markSignalArray))
    markSignalArray = figCnt;
else
    for n = 1 : length(markSignalArray)
        if(markSignalArray(n) == figCnt)
            flagMark = 1;
            warndlg('已经标注过该信号','警告','modal');
            break;
        end
    end
    if(flagMark == 0)
%         markSignalArray = [markSignalArray;figCnt];
        markSignalArray(length(markSignalArray) + 1) = figCnt;
    end
end

for markIdx = 1 : length(markSignalArray)
    fileMarkArray(fileNameCnt, markIdx) = markSignalArray(markIdx);
end
if flagFile==1
    MarkLen = length(markSignalArray);
end
if flagFile==2
    MarkLen = length(find(fileMarkArray~=-1));
end
set(handles.marklen,'String',[num2str(MarkLen) ' 条']);
set(handles.markSignal,'Enable','off');
set(handles.markSignal,'String','已标记');


% --- Executes on button press in markSignalABasicAnalyse.
function markSignalABasicAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to markSignalABasicAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global indexStart;
global indexEnd;
global dataFile;
global openCurrentArray;
global fileNameList;
global fileMarkArray;
global markSignalArray;
global fileName;
global flagFile;
global mark;
global Data;
global rowname;
global levTimeLenTmp;
global levMeanTmp ;
global levStdTmp;
global NorTimeLenTmp;
global NorMeanLmp;
global NorStdTmp;
global sampling;
global thdLevellingWidth;
global thdMax;
h = waitbar(0,'正在处理...请稍后');
levTimeLenTmp = [];
levMeanTmp = [];
levStdTmp = [];
NorTimeLenTmp = [];
NorMeanLmp = [];
NorStdTmp = [];
Data = zeros(100000,4);
rowname=cell(100000,1);
rownum =1;

flagChain = 2;
if get(handles.chainChooseLong,'value')
    flagChain =1;
elseif get(handles.chainChooseShort,'value')
    flagChain = 2;
end
if flagFile==1
    for markCnt = 1 : length(markSignalArray)
        dataTmp = dataFile(indexStart(markSignalArray(markCnt)):indexEnd(markSignalArray(markCnt)));
        openCurrent =openCurrentArray(markSignalArray(markCnt));
        
        if isempty(thdLevellingWidth)
            thdLevellingWidth = 20;
        end
        if isempty(thdMax)
            thdMax = 0.0083;
        end 
        [leftindex,rightindex,LeftStep,RightStep,levTimeLen, levMean, levStd] = ABasicExtract(dataTmp,openCurrent,thdLevellingWidth,thdMax);         
        s = length(find(Data(:,3)~=0))+1;
        Name = [fileName(1:end-4),num2str(markSignalArray(markCnt))];
        rowname(rownum)={Name};
        Data(s,1)=LeftStep;

        for m=1:rightindex-leftindex+1
            rowdata = [levTimeLen(m),levMean(m),levStd(m)];
            Data(s+m-1,2:4)=rowdata; 
        end
        rightstart = s+LeftStep-1;
        Data(rightstart,1)=RightStep;
        rownum = LeftStep+RightStep + rownum-1;

        levTimeLenTmp =[levTimeLen levTimeLenTmp];
        levMeanTmp =[levMean levMeanTmp];
        levStdTmp =[levStd levStdTmp];
        
        NorTimeLenTmp = [NorTimeLenTmp levTimeLen/openCurrent];
        NorMeanLmp = [NorMeanLmp levMean/openCurrent];
        NorStdTmp = [NorStdTmp levStd/openCurrent];
        waitbar(markCnt / length(markSignalArray),h)
    end
end
if flagFile==2
    fileStart = find(fileMarkArray(:,1)~=-1);
    for n=1:length(fileStart)
        list_idx = fileStart(n);
        fileName = fileNameList(list_idx).name;
        data=GuiConvertTDMS(0, ['data/' fileName]);
        if isempty(sampling)
            sampling = 4;
        end
        [dataFile, indexStart, indexEnd, openCurrentArray] = GuiExtractOpenCurrent(data.Data.MeasuredData(4).Data, flagChain, sampling);
        if isempty(indexStart)
            disp('没有提取到开孔电流');
        else
            marknum = find(fileMarkArray(list_idx,:)~=-1);
            for i=1:length(marknum)
                a = fileMarkArray(list_idx,i);
                dataTmp = dataFile(indexStart(a):indexEnd(a));
                openCurrent = openCurrentArray(a);
                if isempty(thdLevellingWidth)
                    thdLevellingWidth = 20;
                end
                if isempty(thdMax)
                    thdMax = 0.0083;
                end 
                [leftindex,rightindex,LeftStep,RightStep,levTimeLen, levMean, levStd] = ABasicExtract(dataTmp,openCurrent,thdLevellingWidth,thdMax );
                if leftindex ==0
                    disp('无效信号');
                else
                    s = length(find(Data(:,3)~=0))+1;
                    Name = [fileName(1:end-4),num2str(a)];
                    rowname(rownum)={Name};
                    Data(s,1)=LeftStep;
                    for m=1:rightindex-leftindex+1
                        rowdata = [levTimeLen(m),levMean(m),levStd(m)];
                        Data(s+m-1,2:4)=rowdata; 
                    end
                    rightstart = s+LeftStep-1;
                    Data(rightstart,1)=RightStep;
                    rownum = LeftStep+RightStep + rownum-1;
                    levTimeLenTmp =[levTimeLen levTimeLenTmp];
                    levMeanTmp =[levMean levMeanTmp];
                    levStdTmp =[levStd levStdTmp];
                    
                    NorTimeLenTmp = [NorTimeLenTmp levTimeLen/openCurrent];
                    NorMeanLmp = [NorMeanLmp levMean/openCurrent];
                    NorStdTmp = [NorStdTmp levStd/openCurrent];
                end
            end
        end
        waitbar(n / length(fileStart),h)
    end
end

waitbar(100,h);
pause(1.5);
close(h);
mark =1;
ABasicMark;

% --- Executes on button press in markSignalAllAnalyse.
function markSignalAllAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to markSignalAllAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global indexStart;
global indexEnd;
global dataFile;
global markSignalArray;
global fileMarkArray;
global fileNameList;
global mark;
global flagFile;
global openCurrentArray;
global levellingCntTotal;
global sampling;
global thdLevellingWidth;
global Data;
global rowname;
global thdMax;

h = waitbar(0,'正在处理...请稍后');
levTimeLenTmp = [];
levMeanTmp = [];
levStdTmp = [];
NorTimeLenTmp = [];
NorMeanLmp = [];
NorStdTmp = [];
Data = zeros(100000,2);
rowname=cell(100000,1);
levellingCntTotal = [];
fileStart = find(fileMarkArray(:,1)~=-1);

flagChain = 2;
if get(handles.chainChooseLong,'value')
    flagChain =1;
elseif get(handles.chainChooseShort,'value')
    flagChain = 2;
end
if flagFile==1
    for markCnt = 1 : length(markSignalArray)
        dataTmp = dataFile(indexStart(markSignalArray(markCnt)):indexEnd(markSignalArray(markCnt)));
        openCurrent =openCurrentArray(markSignalArray(markCnt));
        if isempty(thdLevellingWidth)
            thdLevellingWidth = 20;
        end
        if isempty(thdMax)
            thdMax = 0.0083;
        end 
        [levellingData, levellingCnt, levellingCoverRate, levellingNormalization, levMean, levStd, levTimeLen, levIndex] = process_levelling(dataTmp, openCurrent,thdLevellingWidth,thdMax);        
        levTimeLenTmp =[levTimeLen levTimeLenTmp];
        levMeanTmp =[levMean levMeanTmp];
        levStdTmp =[levStd levStdTmp];
        
        NorTimeLenTmp = [NorTimeLenTmp levTimeLen/openCurrent];
        NorMeanLmp = [NorMeanLmp levMean/openCurrent];
        NorStdTmp = [NorStdTmp levStd/openCurrent];
        waitbar(markCnt / length(markSignalArray),h)
    end
end
rownum =1;
if flagFile==2
    for n=1:length(fileStart)
        list_idx = fileStart(n);
        fileName = fileNameList(list_idx).name;
        data=GuiConvertTDMS(0, ['data/' fileName]);
        if isempty(sampling)
            sampling = 4;
        end
        [dataFile, indexStart, indexEnd, openCurrentArray] = GuiExtractOpenCurrent(data.Data.MeasuredData(4).Data, flagChain, sampling);
        if isempty(indexStart)
            disp('没有提取到开孔电流');
        else
            marknum = find(fileMarkArray(list_idx,:)~=-1);
            for i=1:length(marknum)
                a = fileMarkArray(list_idx,i);
                dataTmp = dataFile(indexStart(a):indexEnd(a));
                openCurrent = openCurrentArray(a);
                if isempty(thdMax)
                    thdMax = 0.0083;
                end 
                if isempty(thdLevellingWidth)
                    thdLevellingWidth = 20;
                end 
                [levellingData, levellingCnt, levellingCoverRate, levellingNormalization, levMeanMark, levStdMark, levTimeLenMark, levIndex] = process_levelling(dataTmp, openCurrent,thdLevellingWidth,thdMax);
                levellingCntTotal = [levellingCntTotal levellingCnt];
                Name = [fileName(1:end-5) '-' num2str(a)]; 
                rowname(rownum)={Name};
                complete_step = 50;
                miss_step = complete_step- levellingCnt;
                Data(rownum,1:2)=[levellingCnt,miss_step];
                rownum = rownum+1;
            end
        end
        waitbar(n / length(fileStart),h)
    end
end

waitbar(100,h);
pause(1.5);
close(h);
mark=2;
AllsignalMark;


% --- Executes on button press in loadFileBatch.
function loadFileBatch_Callback(hObject, eventdata, handles)
% hObject    handle to loadFileBatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sampling;
global dataFile;
global indexStart;
global indexEnd;
global figCnt;
global flagChain;
global markSignalArray;
global fileNameList;
global fileNameCnt;
global fileMarkArray;
global flagFile;
global openCurrent;
global openCurrentArray;
global flipDataFinal;

flagFile=2;
axes(handles.axes1)
cla reset
axes(handles.axes2)
cla reset
axes(handles.axes3)
cla reset
% axes(handles.axes4)
cla reset
set(handles.openCurrent,'String',[num2str(0 , 4) ' pA']);
set(handles.totalOpenCurrent,'String',num2str(0));
set(handles.totalTime,'String',[num2str(0) ' 秒']);
set(handles.currentOpenCurrent,'String',num2str(0));
set(handles.totalEvent,'String',num2str(0));
set(handles.marklen,'String',[num2str(0 , 4) ' pA']);
fileFolder = uigetdir('*.tdms','选择文件夹');

fileNameList = dir(fileFolder);
fileMarkArray = zeros(length(fileNameList) - 2, 500) - 1;
markSignalArray = [];
fileName = fileNameList(1).name;

if(fileName == 0)
    disp('取消');
else
    figCnt = 1;
    h = waitbar(0,'正在提取...请稍后');
    
    set(handles.loadFile,'Enable','off');
    set(handles.loadFileBatch,'Enable','off');
    set(handles.plotDNAPassHoleCurrent,'Enable','off');
    set(handles.plotDNAPassHoleCurrentPre,'Enable','off');
    set(handles.levelling,'Enable','off');
    set(handles.abasicAnalyse,'Enable','off');
    set(handles.dataPlotAnalyse,'Enable','off');
    set(handles.markSignal,'Enable','off');
    set(handles.eventsStatisticsAnalyse,'Enable','off');
    set(handles.markSignalABasicAnalyse,'Enable','off');
    set(handles.markSignalAllAnalyse,'Enable','off');
    set(handles.saveLevellingdata,'Enable','off');
    
    flagChain = 1;
    if get(handles.chainChooseLong,'value')
        flagChain=1;
    elseif get(handles.chainChooseShort,'value')
        flagChain=2;
    end
    
    data=GuiConvertTDMS(0, ['data/' fileName]);
    if isempty(sampling)
        sampling = 4;
    end
    [dataFile, indexStart, indexEnd, openCurrentArray] = GuiExtractOpenCurrent(data.Data.MeasuredData(4).Data, flagChain, sampling);
    openCurrent = openCurrentArray(1);
    if(isempty(indexStart))
        waitbar(1,h);
        errordlg('没有提取到过孔电流','警告','modal');
        set(handles.loadFile,'Enable','on');
    else
        set(handles.openCurrent,'String',[num2str(openCurrent , 5) ' pA']);
        set(handles.totalOpenCurrent,'String',num2str(length(indexStart)));
        set(handles.totalTime,'String',[num2str(length(dataFile(indexStart(figCnt):indexEnd(figCnt))) * 1/25000,3) ' 秒']);

        plot(handles.axes1, dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent);
        set(handles.axes1,'YLim',[0 10 + max(dataFile(indexStart(figCnt):indexEnd(figCnt)) * openCurrent)]);
%         indexLen = indexEnd(figCnt)-indexStart(figCnt);
%         disp(indexLen);
        set(handles.currentOpenCurrent,'String',num2str(figCnt));
        set(handles.fileTotalNum,'String',num2str(length(fileNameList) - 2));
        set(handles.fileTotalCurrent,'String',num2str(1));

        fileNameCnt = 1;
    end
    waitbar(1,h);
    pause(0.5);
    close(h);
    
    set(handles.loadFile,'Enable','on');
    set(handles.loadFileBatch,'Enable','on');
    set(handles.plotDNAPassHoleCurrent,'Enable','on');
    set(handles.plotDNAPassHoleCurrentPre,'Enable','on');
    set(handles.levelling,'Enable','on');
    set(handles.abasicAnalyse,'Enable','on');
    set(handles.dataPlotAnalyse,'Enable','on');
    set(handles.markSignal,'Enable','on');
    set(handles.eventsStatisticsAnalyse,'Enable','on');
    set(handles.markSignalABasicAnalyse,'Enable','on');
    set(handles.markSignalAllAnalyse,'Enable','on');
    set(handles.saveLevellingdata,'Enable','on');
    
    dataMapFile = importdata('ACGT_V1X.txt');
    dataSimFile = importdata('X2_Seq.txt');
    dataCur = dataMapFile.data;
    dataSeq = dataMapFile.textdata;

    flagRev = 0;            % 0：正序    1：逆序
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
    gap = 10;
    for n = 1 : length(dataFigure)
        dataFinal(gap*(n-1) + 1: gap*n) = dataFigure(n);
    end
    if(flagChain == 1)
        currentDefault = 110;
        flipDataFinal = dataFinal * openCurrent / currentDefault;
%         plot(handles.axes4, flipDataFinal);
%         hold( handles.axes4, 'on' );
        flipDataFinalFlagAGAA = zeros(length(flipDataFinal), 1);
        flipDataFinalFlagABasic = zeros(length(flipDataFinal), 1);
        flipDataFinalFlagABasic(615) = flipDataFinal(615) - 5;
        flipDataFinalFlagAGAA(1245) = flipDataFinal(1245) - 5;
        flipDataFinalFlagAGAA(2085) = flipDataFinal(2085) - 5;
        flipDataFinalFlagAGAA(2925) = flipDataFinal(2925) - 5;
        flipDataFinalFlagAGAA(3825) = flipDataFinal(3825) - 5;
%         plot(handles.axes4, flipDataFinalFlagABasic,'m');
%         hold( handles.axes4, 'on' );
%         plot(handles.axes4, flipDataFinalFlagAGAA,'r');
%         set(handles.axes4,'YLim',[0 10 + max(flipDataFinal)]);
    end
end

function edit1_Callback(hObject, eventdata, handles)
global sampling;

% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
sampling= str2double(get(hObject,'String'));
% if (sampling<0 || sampling>5)  
%     helpdlg('只能填写1-5之间的整数','提示');
%     sampling = 4;
% end



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string','4');

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global thdLevellingWidth;

thdLevellingWidth= str2double(get(hObject,'String'));
handles.thdLevellingWidth = thdLevellingWidth;
disp(thdLevellingWidth);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string','20');


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
global thdMax;

thdMax= str2double(get(hObject,'String'));
handles.thdMax = thdMax;
disp(thdMax);

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string','0.0083');

% --- Executes on button press in saveLevellingdata.
function saveLevellingdata_Callback(hObject, eventdata, handles)
% hObject    handle to saveLevellingdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global levellingData;
global levellingNormalization;
global figCnt;
global fileName;
global openCurrentArray;
global fileNameList;
global fileNameCnt;
global flagFile;
global dataTmp;
global levIndex;

index = levIndex(levIndex ~= 999999);
dataOrg = dataTmp;

data = ones(500,15000)*99;
for n =1: length(index)-1
    col = index(n+1)-index(n);
    data(n,1:col) = dataOrg(index(n):index(n+1)-1)';    
end
data(data==99)=nan;
if flagFile==1;
    FileName = char([fileName(1:end-5) '-' num2str(figCnt) '.xlsx']);
end
if flagFile==2
    Name = fileNameList(fileNameCnt).name;
    FileName = char([Name(1:end-5) '-' num2str(figCnt) '.xlsx']);
end
openCurrent = openCurrentArray(figCnt);
Data = data*openCurrent;
% disp(openCurrent);
levelling = levellingData * openCurrent;
Normalization =levellingNormalization* openCurrent;
header={'levellingData','levellingNormalization'};
headerTwo ={'Data'};
xlswrite(FileName,header,2,'A1');
xlswrite(FileName,levelling,2,'A2');
xlswrite(FileName,Normalization,2,'B2');
xlswrite(FileName,headerTwo,1,'A1');
xlswrite(FileName,Data,1,'A2');
helpdlg('文件已生成请查看','提示');
