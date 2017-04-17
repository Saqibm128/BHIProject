function varargout = EbolaModeling(varargin)

% EBOLAMODELING MATLAB code for EbolaModeling.fig
%      EBOLAMODELING, by itself, creates a new EBOLAMODELING or raises the existing
%      singleton*.
%
%      H = EBOLAMODELING returns the handle to a new EBOLAMODELING or the handle to
%      the existing singleton*.
%
%      EBOLAMODELING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EBOLAMODELING.M with the given input arguments.
%
%      EBOLAMODELING('Property','Value',...) creates a new EBOLAMODELING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EbolaModeling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EbolaModeling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EbolaModeling

% Last Modified by GUIDE v2.5 17-Apr-2017 02:27:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EbolaModeling_OpeningFcn, ...
                   'gui_OutputFcn',  @EbolaModeling_OutputFcn, ...
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


% --- Executes just before EbolaModeling is made visible.
function EbolaModeling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EbolaModeling (see VARARGIN)
hObject.UserData = struct;
hObject.UserData.currentCountry='Guinea';
load('EbolaDataFiles.mat');
hObject.UserData.TotalCasesGuinea = TotalCasesGuinea;
hObject.UserData.TotalCasesLiberia = TotalCasesLiberia;
hObject.UserData.TotalCasesSierraLeone = TotalCasesSierraLeone;
hObject.UserData.TotalDeathsGuinea = TotalDeathsGuinea;
hObject.UserData.TotalDeathsLiberia = TotalDeathsLiberia;
hObject.UserData.TotalDeathsSierraLeone = TotalDeathsSierraLeone;
hObject.UserData.DaysSinceStart = DaysSinceStart;
hObject.UserData.rawCases = TotalCasesGuinea;
hObject.UserData.rawDeaths = TotalDeathsGuinea;
[fitCases, fitDeaths] = fitData(TotalCasesGuinea, TotalDeathsGuinea, DaysSinceStart);
hObject.UserData.transformedCases = fitCases;
hObject.UserData.transformedDeaths = fitDeaths;



% Choose default command line output for EbolaModeling
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EbolaModeling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EbolaModeling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function SIRAlpha_Callback(hObject, eventdata, handles)
% hObject    handle to SIRAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SIRAlpha as text
%        str2double(get(hObject,'String')) returns contents of SIRAlpha as a double


% --- Executes during object creation, after setting all properties.
function SIRAlpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SIRAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GraphSIR.
function GraphSIR_Callback(hObject, eventdata, handles)

% hObject    handle to GraphSIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on GraphSIR and none of its controls.
function GraphSIR_KeyPressFcn(hObject, eventdata, handles)

% hObject    handle to GraphSIR (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in GraphRawData.
function GraphRawData_Callback(hObject, eventdata, handles)
% hObject    handle to GraphRawData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handle = EbolaModeling;
currAxes = findobj('Tag', 'axes1');

    disp(length(handle.UserData.DaysSinceStart));
    disp(length(handle.UserData.rawCases));
    hold off;
    plot(handles.axes1, handle.UserData.DaysSinceStart, handle.UserData.rawCases);
    hold on;
    plot(handles.axes1, handle.UserData.DaysSinceStart, handle.UserData.rawDeaths);
    xlabel(handles.axes1, 'Days Since Start');
    ylabel(handles.axes1, 'Individuals');
    legend('Raw Cases', 'Raw Deaths');


% --- Executes when selected object is changed in CountryChoice.
function CountryChoice_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in CountryChoice 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newCountry = get(hObject, 'String');
handle = EbolaModeling;
handle.UserData.currentCountry = newCountry;
disp(newCountry);
cla(findobj('Tag','axes1'));
%%change data references
currentCountry = handle.UserData.currentCountry;
disp('changed to:');
disp(currentCountry);
if (strcmp(currentCountry, 'Guinea'))
    handle.UserData.rawCases = handle.UserData.TotalCasesGuinea;
    handle.UserData.rawDeaths = handle.UserData.TotalDeathsGuinea;
end
if (strcmp(currentCountry, 'Sierra Leone'))
    handle.UserData.rawCases = handle.UserData.TotalCasesSierraLeone;
    handle.UserData.rawDeaths = handle.UserData.TotalDeathsSierraLeone;
end
if (strcmp(currentCountry, 'Liberia'))
    handle.UserData.rawCases = handle.UserData.TotalCasesLiberia;
    handle.UserData.rawDeaths = handle.UserData.TotalDeathsLiberia;
end
    [fitCases, fitDeaths] = fitData(handle.UserData.rawCases, handle.UserData.rawDeaths, handle.UserData.DaysSinceStart);
    hObject.UserData.transformedCases = fitCases;
    hObject.UserData.transformedDeaths = fitDeaths;


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


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


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
