function varargout = ABasic(varargin)
% ABASIC MATLAB code for ABasic.fig
%      ABASIC, by itself, creates a new ABASIC or raises the existing
%      singleton*.
%
%      H = ABASIC returns the handle to a new ABASIC or the handle to
%      the existing singleton*.
%
%      ABASIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABASIC.M with the given input arguments.
%
%      ABASIC('Property','Value',...) creates a new ABASIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ABasic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ABasic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ABasic

% Last Modified by GUIDE v2.5 06-Nov-2018 11:08:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ABasic_OpeningFcn, ...
                   'gui_OutputFcn',  @ABasic_OutputFcn, ...
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


% --- Executes just before ABasic is made visible.
function ABasic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ABasic (see VARARGIN)

% Choose default command line output for ABasic
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ABasic wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global dataFile;
global indexStart;
global indexEnd;
global figCnt;
global levellingData;
global levIndex;
global openCurrent;

global abasicIndex;
global abasicIndexLeft;
global abasicIndexRight;

global levMeanLeft;
global levVarLeft;
global levTimeLenLeft;
global levMeanRight;
global levVarRight;
global levTimeLenRight;

axes(handles.axes1)
cla reset
plot(handles.axes1, levellingData(levIndex(abasicIndex - abasicIndexLeft + 1) : levIndex(abasicIndex + abasicIndexRight)) * openCurrent,'r');
hold on;
rawDataTmp = dataFile(indexStart(figCnt):indexEnd(figCnt));
plot(handles.axes1, rawDataTmp(levIndex(abasicIndex - abasicIndexLeft + 1) : levIndex(abasicIndex + abasicIndexRight)) * openCurrent,'g');
ylabel('pA');
dis = 15;
tableLeft = cell(dis,3);
tableRight = cell(dis,3);
for row = 1 : 3
    for col = 1 : dis
        if(row == 1)
            tableLeft{col, row} = levMeanLeft(col);
        elseif(row == 2)
            tableLeft{col, row} = levVarLeft(col);
        elseif(row == 3)
            tableLeft{col, row} = levTimeLenLeft(col);
        end
    end
end
for row = 1 : 3
    for col = 1 : dis
        if(row == 1)
            tableRight{col, row} = levMeanRight(col);
        elseif(row == 2)
            tableRight{col, row} = levVarRight(col);
        elseif(row == 3)
            tableRight{col, row} = levTimeLenRight(col);
        end
    end
end
set(handles.tableLeft,'Data', tableLeft);
set(handles.tableRight,'Data', tableRight);

levTimeLenTmp = [levTimeLenLeft;levTimeLenRight];
levTimeLen = levTimeLenTmp(levTimeLenTmp~=0);
pCnt = 20;
pTimeLen = zeros(pCnt, 1);
maxTimeLen = max(levTimeLen);
minTimeLen = min(levTimeLen);
thdTimeLen = (maxTimeLen - minTimeLen) / pCnt;
for n = 1 : length(levTimeLen)
    if(levTimeLen(n) ~= minTimeLen)
        pTimeLen(ceil((levTimeLen(n) - minTimeLen) / thdTimeLen)) = pTimeLen(ceil((levTimeLen(n) - minTimeLen) / thdTimeLen)) + 1;
    else
        pTimeLen(1) = pTimeLen(1) + 1;
    end
end
pTimeLen = pTimeLen / length(levTimeLen);
xLabels = [];
idx = 1;
xLabels(idx,1) = round(minTimeLen);
idx = idx + 1;
for n = pCnt-4 : -2 : 1
    xLabels(idx,1) = round(((maxTimeLen - minTimeLen) / n + minTimeLen )* 1000) + round(minTimeLen * 1000);
    idx = idx + 1;
end
xLabels(idx,1) = round(((maxTimeLen - minTimeLen) / 1 + minTimeLen )* 1000) + round(minTimeLen * 1000);
axes(handles.axes2);
bar(handles.axes2, pTimeLen);
set(handles.axes2,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/5 : xLabels(end));
set(handles.axes2,'YLim',[0 1.1 * max(pTimeLen)]);

levMeanTmp = [levMeanLeft;levMeanRight];
levMean = levMeanTmp(levMeanTmp~=0);
pMean = zeros(pCnt, 1);
maxMean = max(levMean);
minMean = min(levMean);
thdMean = (maxMean - minMean) / pCnt;
for n = 1 : length(levMean)
    if(levMean(n) ~= minMean)
        pMean(ceil((levMean(n) - minMean) / thdMean)) = pMean(ceil((levMean(n) - minMean) / thdMean)) + 1;
    else
        pMean(1) = pMean(1) + 1;
    end
end
pMean = pMean / length(levMean);
xLabels = [];
idx = 1;
xLabels(idx,1) = round(minMean);
idx = idx + 1;
for n = pCnt-4 : -2 : 1
    xLabels(idx,1) = round((maxMean - minMean) / n + minMean);
    idx = idx + 1;
end
xLabels(idx,1) = round((maxMean - minMean) / 1 + minMean);
bar(handles.axes3,pMean);
set(handles.axes3,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/5 : xLabels(end));
set(handles.axes3,'YLim',[0 1.1 * max(pMean)]);

levVarTmp = [levVarLeft;levVarRight];
levVar = levVarTmp(levVarTmp~=0);
pVar = zeros(pCnt, 1);
maxVar = max(levVar);
minVar = min(levVar);
thdVar = (maxVar - minVar) / pCnt;
for n = 1 : length(levVar)
    if(levVar(n) ~= minVar)
        pVar(ceil((levVar(n) - minVar) / thdVar)) = pVar(ceil((levVar(n) - minVar) / thdVar)) + 1;
    else
        pVar(1) = pVar(1) + 1;
    end
end
pVar = pVar / length(levVar);
xLabels = [];
idx = 1;
xLabels(idx,1) = round(minVar);
idx = idx + 1;
for n = pCnt-4 : -2 : 1
    xLabels(idx,1) = round((maxVar - minVar) / n + minVar);
    idx = idx + 1;
end
xLabels(idx,1) = round((maxVar - minVar) / 1 + minVar);
bar(handles.axes4,pVar);
set(handles.axes4,'XTickLabels',xLabels(1) : (xLabels(end) - xLabels(1))/5 : xLabels(end));
set(handles.axes4,'YLim',[0 1.1 * max(pVar)]);


% --- Outputs from this function are returned to the command line.
function varargout = ABasic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
