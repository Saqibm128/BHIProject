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

% Last Modified by GUIDE v2.5 17-Apr-2017 15:27:44

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
hObject.UserData.currentCountry = 'Guinea';
hObject.UserData.useEntirePop = true;
hObject.UserData.nGuinea = 11.75 * 10 ^ 6;
hObject.UserData.nLiberia = 4.3 * 10 ^ 6;
hObject.UserData.nSierraLeone = 6.092 * 10 ^ 6;




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
h = handles.output;
fitCases = h.UserData.transformedCases;
fitDeaths = h.UserData.transformedDeaths;
alphaBetaVal = [];
init = [];
if (h.UserData.useEntirePop)
    initGuinea = [h.UserData.nGuinea, fitCases(1), 0];
    [alphaBetaVal, error] = findOptAlphaBeta(fittedCasesGuinea, initGuinea);
else
    pop = str2double(get(handles.TotalPopulation, 'String'));
    initGuinea = [pop, fitCases(1), 0];
    [alphaBetaVal, error] = findOptAlphaBeta(fittedCasesGuinea, initGuinea);
end
[t, x] = instantiateSIR(alphaBetaVal(1),alphaBetaVal(2), init, length(dataInfected));


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
h = handles.output;
currAxes = findobj('Tag', 'axes1');

    disp(length(h.UserData.DaysSinceStart));
    disp(length(h.UserData.rawCases));
    hold off;
    plot(handles.axes1, h.UserData.DaysSinceStart, h.UserData.rawCases);
    hold on;
    plot(handles.axes1, h.UserData.DaysSinceStart, h.UserData.rawDeaths);
    xlabel(handles.axes1, 'Days Since Start');
    ylabel(handles.axes1, 'Individuals');
    legend('Raw Cases', 'Raw Deaths');
    title(['Current Country:' h.UserData.currentCountry]);


% --- Executes when selected object is changed in CountryChoice.
function CountryChoice_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in CountryChoice 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newCountry = get(hObject, 'String');
h = handles.output;
h.UserData.currentCountry = newCountry;
disp(newCountry);
cla(findobj('Tag','axes1'));
if (strcmp(newCountry, 'Guinea'))
    h.UserData.rawCases = h.UserData.TotalCasesGuinea;
    h.UserData.rawDeaths = h.UserData.TotalDeathsGuinea;
end
if (strcmp(newCountry, 'Sierra Leone'))
    h.UserData.rawCases = h.UserData.TotalCasesSierraLeone;
    h.UserData.rawDeaths = h.UserData.TotalDeathsSierraLeone;
end
if (strcmp(newCountry, 'Liberia'))
    h.UserData.rawCases = h.UserData.TotalCasesLiberia;
    h.UserData.rawDeaths = h.UserData.TotalDeathsLiberia;
end
    [fitCases, fitDeaths] = fitData(h.UserData.rawCases, h.UserData.rawDeaths, h.UserData.DaysSinceStart);
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


% --- Executes on button press in GraphFitData.
function GraphFitData_Callback(hObject, eventdata, handles)
% hObject    handle to GraphFitData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = EbolaModeling;
plot(handles.axes1, h.UserData.transformedCases);
plot(handles.axes1, h.UserData.transformedDeaths);


% --- Executes on button press in ClearGraph.
function ClearGraph_Callback(hObject, eventdata, handles)
% hObject    handle to ClearGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1);


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
h = EbolaModeling;
h.UserData.useEntirePop = get(hObject, 'Value');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
