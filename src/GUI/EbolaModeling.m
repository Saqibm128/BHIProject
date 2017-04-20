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

% Last Modified by GUIDE v2.5 18-Apr-2017 16:45:54

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
hObject.UserData.nCountry = 11.75 * 10 ^ 6;
hObject.UserData.legend = {};




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
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fitCases, fitDeaths);
if (h.UserData.useEntirePop)
    init = [h.UserData.nCountry, 0, 0];
    [alphaBetaVal, error] = findOptAlphaBeta(trueInfected, trueRecovered, init);
else
    pop = str2double(get(handles.TotalPopulation, 'String'));
    init = [pop, 1, 0];
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(h.UserData.transformedCases, h.UserData.transformedDeaths);
    [alphaBetaVal, error] = findOptAlphaBeta(trueInfected, trueRecovered, init);
end
[t, x] = instantiateSIR(alphaBetaVal(1),alphaBetaVal(2), init, length(fitCases));
integratedExpectedInfected = zeros(length(x(:,2)), 1); %% initialize
for i =  1:length(x)
    integratedExpectedInfected(i) = trapz(x(1:i,2)); %%get a slowly expanding integration
end
plot(handles.axes1, t, integratedExpectedInfected);
hold on;
h.UserData.legend = [h.UserData.legend, {'Cummulative SIR Modeled Infected'}];
legend(handles.axes1, h.UserData.legend);

set(handles.Alpha, 'String', ['SIR Alpha:', num2str(alphaBetaVal(1))]);
set(handles.Beta, 'String', ['SIR Beta:', num2str(alphaBetaVal(2))]);
set(handles.Error, 'String', ['SIR Error:', num2str(error)]);



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
    plot(handles.axes1, h.UserData.DaysSinceStart, h.UserData.rawCases);
    hold on;
    plot(handles.axes1, h.UserData.DaysSinceStart, h.UserData.rawDeaths);
    xlabel(handles.axes1, 'Days Since Start');
    ylabel(handles.axes1, 'Individuals');
    h.UserData.legend = [h.UserData.legend, {'Raw Cases', 'Raw Deaths'}];
    legend(h.UserData.legend);
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
legend(handles.axes1, {});
h.UserData.legend = {};
if (strcmp(newCountry, 'Guinea'))
    h.UserData.rawCases = h.UserData.TotalCasesGuinea;
    h.UserData.rawDeaths = h.UserData.TotalDeathsGuinea;
    h.UserData.nCountry = h.UserData.nGuinea;
end
if (strcmp(newCountry, 'Sierra Leone'))
    h.UserData.rawCases = h.UserData.TotalCasesSierraLeone;
    h.UserData.rawDeaths = h.UserData.TotalDeathsSierraLeone;
    h.UserData.nCountry = h.UserData.nSierraLeone;
end
if (strcmp(newCountry, 'Liberia'))
    h.UserData.rawCases = h.UserData.TotalCasesLiberia;
    h.UserData.rawDeaths = h.UserData.TotalDeathsLiberia;
    h.UserData.nCountry = h.UserData.nLiberia;
end
[fitCases, fitDeaths] = fitData(h.UserData.rawCases, h.UserData.rawDeaths, h.UserData.DaysSinceStart);
h.UserData.transformedCases = fitCases;
h.UserData.transformedDeaths = fitDeaths;
    


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



function TotalPopulation_Callback(hObject, eventdata, handles)
% hObject    handle to TotalPopulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TotalPopulation as text
%        str2double(get(hObject,'String')) returns contents of TotalPopulation as a double


% --- Executes during object creation, after setting all properties.
function TotalPopulation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotalPopulation (see GCBO)
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
h = handles.output;
plot(handles.axes1, h.UserData.transformedCases);
plot(handles.axes1, h.UserData.transformedDeaths);


% --- Executes on button press in ClearGraph.
function ClearGraph_Callback(hObject, eventdata, handles)
% hObject    handle to ClearGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1);
h.UserData.legend = {};


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
h = handles.output;
h.UserData.useEntirePop = get(hObject, 'Value');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function GraphSIR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GraphSIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in GraphInterpolatedData.
function GraphInterpolatedData_Callback(hObject, eventdata, handles)
% hObject    handle to GraphInterpolatedData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = handles.output;
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(h.UserData.transformedCases, h.UserData.transformedDeaths);
plot(handles.axes1, trueInfected);
hold on;
plot(handles.axes1, trueRecovered);
h.UserData.legend = [h.UserData.legend, {'Infected at Single Time Point', 'Recovered by Single Time Point'}];
legend(h.UserData.legend);


% --- Executes on button press in GraphSEIR.
function GraphSEIR_Callback(hObject, eventdata, handles)
% hObject    handle to GraphSEIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = handles.output;
fitCases = h.UserData.transformedCases;
fitDeaths = h.UserData.transformedDeaths;
betaEpsGamVal = [];
init = [];
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fitCases, fitDeaths);
if (h.UserData.useEntirePop)
    init = [h.UserData.nCountry, 0, 0, 0];
    [betaEpsGamVal, error] = findOptBetaEpsilGamma(trueInfected, trueExposed, trueRecovered, init);
else
    pop = str2double(get(handles.TotalPopulation, 'String'));
    init = [pop, pop/1000, 1, 0];
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(h.UserData.transformedCases, h.UserData.transformedDeaths);
    [betaEpsGamVal, error] = findOptBetaEpsilGamma(trueInfected, trueExposed, trueRecovered, init);
end
[t, x] = instantiateSEIR(betaEpsGamVal(1),betaEpsGamVal(2),betaEpsGamVal(3), init, length(fitCases));
integratedExpectedInfected = zeros(length(x(:,3)), 1); %% initialize
for i =  1:length(x)
    integratedExpectedInfected(i) = trapz(x(1:i,3)); %%get a slowly expanding integration
end
plot(handles.axes1, t, integratedExpectedInfected);
hold on;
h.UserData.legend = [h.UserData.legend, {'Cummulative SEIR Modeled Infected'}];
legend(handles.axes1, h.UserData.legend);

set(handles.SEIRBeta, 'String', ['SEIR Beta:', num2str(betaEpsGamVal(1))]);
set(handles.SEIREpsilon, 'String', ['SEIR Epsilon:', num2str(betaEpsGamVal(2))]);
set(handles.SEIRGamma, 'String', ['SEIR Gamma:', num2str(betaEpsGamVal(3))]);
set(handles.Error, 'String', ['SEIR Error:', num2str(error)]);



% --- Executes on button press in GraphAgentBasedModel.
function GraphAgentBasedModel_Callback(hObject, eventdata, handles)
% hObject    handle to GraphAgentBasedModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = handles.output;
fitCases = h.UserData.transformedCases;
fitDeaths = h.UserData.transformedDeaths;
resVal = [];
init = [];
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fitCases, fitDeaths);
if (h.UserData.useEntirePop)
    init = [1, h.UserData.nCountry, 1, 10];
    [resVal, error] = findOptAgentBased(trueInfected, trueRecovered, init);
else
    pop = str2double(get(handles.TotalPopulation, 'String'));
    init = [1, pop, pop/1000, 10];
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(h.UserData.transformedCases, h.UserData.transformedDeaths);
    [resVal, error] = findOptAgentBased(trueInfected, trueRecovered, init);
end
[infected, recovered] = AgentBasedGraph(init(1), init(2), init(3), init(4), length(h.UserData.transformedCases), resVal(1), resVal(2));
plot(handles.axes1, infected);
h.UserData.legend = [h.UserData.legend, {'Agent Modeled Infected'}];
set(handles.Error, 'String', ['Agent-Based Error:', num2str(error)]);

