function varargout = ABasicMark(varargin)
% ABASICMARK MATLAB code for ABasicMark.fig
%      ABASICMARK, by itself, creates a new ABASICMARK or raises the existing
%      singleton*.
%
%      H = ABASICMARK returns the handle to a new ABASICMARK or the handle to
%      the existing singleton*.
%
%      ABASICMARK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABASICMARK.M with the given input arguments.
%
%      ABASICMARK('Property','Value',...) creates a new ABASICMARK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ABasicMark_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ABasicMark_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ABasicMark

% Last Modified by GUIDE v2.5 28-Feb-2019 17:37:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ABasicMark_OpeningFcn, ...
                   'gui_OutputFcn',  @ABasicMark_OutputFcn, ...
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


% --- Executes just before ABasicMark is made visible.
function ABasicMark_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ABasicMark (see VARARGIN)

% Choose default command line output for ABasicMark
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ABasicMark wait for user response (see UIRESUME)
% uiwait(handles.StatisticsPic);
global fileMarkArray;
global markSignalArray;
global flagFile;
global levTimeLenTmp;
global levMeanTmp ;
global levStdTmp;
global NorTimeLenTmp;
global NorMeanLmp;
global NorStdTmp;

if flagFile==1
    MarkLen = length(markSignalArray);
    set(handles.Marknum,'String',[num2str(MarkLen) ' 条']);
    axes(handles.axes1);
    TimeLenCnt = 80;
    MeanCnt = 150;
    levStdCnt = 80;
end
if flagFile==2
    MarkLen = length(find(fileMarkArray~=-1));
    set(handles.Marknum,'String',[num2str(MarkLen) ' 条']);
    axes(handles.axes1);
    TimeLenCnt = 100;
    MeanCnt = 300;
    levStdCnt = 100;
end

hist(handles.axes1, levTimeLenTmp,TimeLenCnt);
hist(handles.axes4, NorTimeLenTmp,TimeLenCnt);
hist(handles.axes2, levMeanTmp,MeanCnt);
hist(handles.axes5, NorMeanLmp,MeanCnt);
hist(handles.axes3, levStdTmp,levStdCnt);
hist(handles.axes6, NorStdTmp,levStdCnt);



% --- Outputs from this function are returned to the command line.
function varargout = ABasicMark_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ExportData.
function ExportData_Callback(hObject, eventdata, handles)
% hObject    handle to ExportData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Data;
global rowname;

Data(Data==0)=nan;
header={'FileName','Level','TimeLen','Mean','Std'};
xlswrite('ABasicData.xlsx',header,1,'A1')
xlswrite('ABasicData.xlsx',rowname,1,'A2');
xlswrite('ABasicData.xlsx',Data,1,'B2');
helpdlg('文件已生成请查看','提示');
