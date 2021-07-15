function varargout = StartGUI(varargin)
% STARTGUI MATLAB code for StartGUI.fig
%      STARTGUI, by itself, creates a new STARTGUI or raises the existing
%      singleton*.
%
%      H = STARTGUI returns the handle to a new STARTGUI or the handle to
%      the existing singleton*.
%
%      STARTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTGUI.M with the given input arguments.
%
%      STARTGUI('Property','Value',...) creates a new STARTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StartGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StartGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StartGUI

% Last Modified by GUIDE v2.5 21-Jan-2019 07:46:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StartGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @StartGUI_OutputFcn, ...
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


% --- Executes just before StartGUI is made visible.
function StartGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StartGUI (see VARARGIN)

% Choose default command line output for StartGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes StartGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

delete(instrfind('port','COM9'));
global a;
a = arduino('COM9');

% --- Outputs from this function are returned to the command line.
function varargout = StartGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnStart.
function btnStart_Callback(hObject, eventdata, handles)
% hObject    handle to btnStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a;
round = 1;
points = 0;
btn_diff = 0;
initialPattern(a);
screenShow(a,0,0);
winningSound = [5 10 20 30 200 180 170 160 150 100 110 120 130 140 50 40 30 20 10 5];
looseSound = [225 200 175 150 125 100 75 50 25 0];
mac_sequence = 0;
user_sequence = 0;
btnDiffRead = 0;
btnConfigRead = 0;
diff_level = 0; %Difficult


while 1
    btnDiffRead = analogRead(a,4);
    btnConfigRead = analogRead(a,5);
    fprintf('%d  %d\n',btnDiffRead,btnConfigRead);
    
    if btnDiffRead < 700
        pause(1);
        fprintf('%d  %d\n',btnDiffRead,btnConfigRead);
        diff_level = diff_level+1;
        if diff_level < 1 || diff_level > 3
            diff_level = 1;
            tonePlay(a,0.02);
            screenShow(a,0,diff_level);
        end
        screenShow(a,0,diff_level);
        
    end
    
    if btnConfigRead < 700
        tonePlay(a,0.02);
        break;
    end
end


if diff_level == 1 
   pause_seq = 2;   %Easy Level
   screenShow(a,'E',diff_level);
elseif diff_level == 2 
   pause_seq = 1;   %Moderate Level
   screenShow(a,'U',diff_level);
else
   pause_seq = 0.5; %Difficult level
   screenShow(a,'H',3);
end

pause(4);
    


while round<9
    
    for k=1:2
        screenShow(a,round,0);
        pause(1);
        screenShow(a,'OFF',0);
        pause(1);
    end
    level = 1;
    while level<4
        
        screenShow(a,round,level);
        pause(1);
        
        mac_sequence = show_pattern(a,round+3,pause_seq);
        disp(mac_sequence);        
        
        tonePlay(a,0.1);
        user_sequence = pattern_LDR(a,round+3);
        
        
        if mac_sequence == user_sequence
           soundTrack(a,winningSound,0.05);
           level = level + 1;
        else
           soundTrack(a,looseSound,0.25);
           break;
        end    
        
        pause(2);
        
    end
    
    if isequal(mac_sequence , user_sequence)
            
        round = round + 1;

        points = points + 1;
    else
        break;
    end  

    
end
 
disp(points);
screenShow(a,0,points);
set(handles.txtFinalScore,'String','Final Score');
set(handles.txtScore,'String',num2str(points));
pause(2);

set(handles.msgConfirm,'String','Do you want to play again ?');
set(handles.btnPlayAgain,'String','PLAY AGAIN');
set(handles.btnNo,'String','NO');


function msgConfirm_Callback(hObject, eventdata, handles)
% hObject    handle to msgConfirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msgConfirm as text
%        str2double(get(hObject,'String')) returns contents of msgConfirm as a double


% --- Executes during object creation, after setting all properties.
function msgConfirm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msgConfirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnPlayAgain.
function btnPlayAgain_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlayAgain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.txtFinalScore,'String','');
set(handles.txtScore,'String','');
set(handles.msgConfirm,'String','');
set(handles.btnPlayAgain,'String','');
set(handles.btnNo,'String','');

global a;
round = 1;
points = 0;
btn_diff = 0;
initialPattern(a);
screenShow(a,0,0);
winningSound = [5 10 20 30 200 180 170 160 150 100 110 120 130 140 50 40 30 20 10 5];
looseSound = [225 200 175 150 125 100 75 50 25 0];
mac_sequence = 0;
user_sequence = 0;
btnDiffRead = 0;
btnConfigRead = 0;
diff_level = 0; %Difficult


while 1
    btnDiffRead = analogRead(a,4);
    btnConfigRead = analogRead(a,5);
    fprintf('%d  %d\n',btnDiffRead,btnConfigRead);
    
    if btnDiffRead < 700
        pause(1);
        fprintf('%d  %d\n',btnDiffRead,btnConfigRead);
        diff_level = diff_level+1;
        if diff_level < 1 || diff_level > 3
            diff_level = 1;
            tonePlay(a,0.02);
            screenShow(a,0,diff_level);
        end
        screenShow(a,0,diff_level);
        
    end
    
    if btnConfigRead < 700
        tonePlay(a,0.02);
        break;
    end
end


if diff_level == 1 
   pause_seq = 2;   %Easy Level
   screenShow(a,'E',diff_level);
elseif diff_level == 2 
   pause_seq = 1;   %Moderate Level
   screenShow(a,'U',diff_level);
else
   pause_seq = 0.5; %Difficult level
   screenShow(a,'H',3);
end

pause(4);
    


while round<5
    
    tonePlay(a,1.5);

    for k=1:2
        screenShow(a,round,0);
        pause(1);
        screenShow(a,'OFF',0);
        pause(1);
    end
    level = 1;
    while level<4
        
        screenShow(a,round,level);
        pause(1);
        
        mac_sequence = show_pattern(a,round+3,pause_seq);
        disp(mac_sequence);        
        
        tonePlay(a,0.1);
        user_sequence = pattern_LDR(a,round+3);
        
        
        if mac_sequence == user_sequence
           soundTrack(a,winningSound,0.05);
           level = level + 1;
        else
           soundTrack(a,looseSound,0.25);
           break;
        end    
        
        pause(2);
        
    end
    
    if isequal(mac_sequence , user_sequence)
            
        round = round + 1;

        points = points + 1;
    else
        break;
    end

    
end
 
disp(points);
screenShow(a,0,points);
set(handles.txtFinalScore,'String','Final Score');
set(handles.txtScore,'String',num2str(points));
pause(2);

set(handles.msgConfirm,'String','Do you want to play again ?');
set(handles.btnPlayAgain,'String','PLAY AGAIN');
set(handles.btnNo,'String','NO');

% --- Executes on button press in btnNo.
function btnNo_Callback(hObject, eventdata, handles)
% hObject    handle to btnNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a;

set(handles.txtFinalScore,'String','');
set(handles.txtScore,'String','');
set(handles.msgConfirm,'String','');
set(handles.btnPlayAgain,'String','');
set(handles.btnNo,'String','');

screenShow(a,'OFF','OFF');
endingPattern(a);
