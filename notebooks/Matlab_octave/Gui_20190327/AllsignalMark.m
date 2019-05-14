function varargout = AllsignalMark(varargin)
% ALLSIGNALMARK MATLAB code for AllsignalMark.fig
%      ALLSIGNALMARK, by itself, creates a new ALLSIGNALMARK or raises the existing
%      singleton*.
%
%      H = ALLSIGNALMARK returns the handle to a new ALLSIGNALMARK or the handle to
%      the existing singleton*.
%
%      ALLSIGNALMARK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALLSIGNALMARK.M with the given input arguments.
%
%      ALLSIGNALMARK('Property','Value',...) creates a new ALLSIGNALMARK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AllsignalMark_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AllsignalMark_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AllsignalMark

% Last Modified by GUIDE v2.5 19-Feb-2019 14:11:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AllsignalMark_OpeningFcn, ...
                   'gui_OutputFcn',  @AllsignalMark_OutputFcn, ...
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


% --- Executes just before AllsignalMark is made visible.
function AllsignalMark_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AllsignalMark (see VARARGIN)

% Choose default command line output for AllsignalMark
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AllsignalMark wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AllsignalMark_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global fileMarkArray;
global markSignalArray;
global flagFile;
global levellingCntTotal;

if flagFile==1
    MarkLen = length(markSignalArray);
    set(handles.Marknum,'String',[num2str(MarkLen) ' 条']);
    axes(handles.axes1);
    Cnt = 20;
    
end
if flagFile==2
    MarkLen = length(find(fileMarkArray~=-1));
    set(handles.Marknum,'String',[num2str(MarkLen) ' 条']);
    axes(handles.axes1);
    Cnt = 40;
end
histogram(handles.axes1, levellingCntTotal,Cnt);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Data;
global rowname;

Data(Data==0)=nan;
header={'FileName','LevelCnt','MissCnt'};
xlswrite('LevellingCnt.xlsx',header,1,'A1')
xlswrite('LevellingCnt.xlsx',rowname,1,'A2');
xlswrite('LevellingCnt.xlsx',Data,1,'B2');
helpdlg('文件已生成请查看','提示');
