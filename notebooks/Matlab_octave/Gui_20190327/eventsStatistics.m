function varargout = eventsStatistics(varargin)
% EVENTSSTATISTICS MATLAB code for eventsStatistics.fig
%      EVENTSSTATISTICS, by itself, creates a new EVENTSSTATISTICS or raises the existing
%      singleton*.
%
%      H = EVENTSSTATISTICS returns the handle to a new EVENTSSTATISTICS or the handle to
%      the existing singleton*.
%
%      EVENTSSTATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EVENTSSTATISTICS.M with the given input arguments.
%
%      EVENTSSTATISTICS('Property','Value',...) creates a new EVENTSSTATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eventsStatistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eventsStatistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eventsStatistics

% Last Modified by GUIDE v2.5 16-Jan-2019 16:28:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eventsStatistics_OpeningFcn, ...
                   'gui_OutputFcn',  @eventsStatistics_OutputFcn, ...
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


% --- Executes just before eventsStatistics is made visible.
function eventsStatistics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eventsStatistics (see VARARGIN)

% Choose default command line output for eventsStatistics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes eventsStatistics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eventsStatistics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global levMean;
global levStd;
global levTimeLen;

hist(handles.axes1, levTimeLen,50);
hist(handles.axes2, levMean,100);
hist(handles.axes3, levStd,50);
