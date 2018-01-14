#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#SingleInstance Force

#Persistent

MsgBox, 4,, Run Setup...?
ifMsgBox Yes
GoTo, Setup
else
GoTo, Execute
return


Setup:
MsgBox, 0,, Set Default Flask Keys In Game...
ifMsgBox OK
{
FileDelete, flask.ini
FileDelete, timer.ini
FileDelete, health.ini
FileDelete, mana.ini
}

Tooltip, Press Z Over Health to get Health Trigger..., 1,1
KeyWait, z, D
KeyWait, z
if Errorlevel = 0
{
MouseGetPos, XX, YY
PixelGetColor, VarH, %XX%, %YY%, RGB
}
Tooltip, Press Z Over Mana to get Mana Trigger..., 1,1
KeyWait, z, D
KeyWait, z
If Errorlevel = 0
{
MouseGetPos, XXM, YYM
PixelGetColor, VarM, %XXM%, %YYM%, RGB
}

Iniwrite, %VarH%, health.ini, Colortone
Iniwrite, %XX%, health.ini, XPosition
Iniwrite, %YY%, health.ini, YPosition
iniWrite, %VarM%, mana.ini, ColortoneM
iniwrite, %XXM%, mana.ini, XMPosition
iniwrite, %YYM%, mana.ini, YMPosition

Gui, Add, Text,, Choose Wisely...
Gui, Add, Text,, (Setup Flasks Trigger)
Gui, Add, Checkbox,  checked vFlask1,  Set HP As Trigger?(flask1)
Gui, Add, Checkbox,  checked vFlask2,  Set HP As Trigger?(flask2)
Gui, Add, Checkbox,  checked vFlask3,  Set HP As Trigger?(flask3)
Gui, Add, Checkbox,  checked vFlask4,  Set HP As Trigger?(flask4)
Gui, Add, Checkbox,  checked vFlask5,  Set HP As Trigger?(flask5)
Gui, Add, Text,, (Flask Duration in miliseconds)
Gui, Add, Edit, vTimer1, Flask1Duration
Gui, Add, Edit, vTimer2, Flask2Duration
Gui, Add, Edit, vTimer3, Flask3Duration
Gui, Add, Edit, vTimer4, Flask4Duration
Gui, Add, Edit, vTimer5, Flask5Duration
Gui, Add, Text,, ( Script Interval in miliseconds)
Gui, Add, Edit, vTimer,  ScriptRefreshTimer
Gui, Add, Button, gLabel, Save
Gui, Show, Autosize Center
return

Label:
Gui, Submit, NoHide
IniWrite, %Flask1%, flask.ini, FlaskOne, Value
IniWrite, %Flask2%, flask.ini, FlaskTwo, Value
IniWrite, %Flask3%, flask.ini, FlaskThree, Value
iniWrite, %Flask4%, flask.ini, FlaskFour, Value
Iniwrite, %Flask5%, flask.ini, FlaskFive, Value
IniWrite, %Timer1%, timer.ini, TimerOne, Value
IniWrite, %Timer2%, timer.ini, TimerTwo, Value
IniWrite, %Timer3%, timer.ini, TimerThree, Value
IniWrite, %Timer4%, timer.ini, TimerFour, Value
IniWrite, %TImer5%, timer.ini, TimerFive, Value
IniWrite, %Timer%, timer.ini, TimerSleep, Value
Gui, Destroy
GoTo, Execute
Return

Execute:
IniRead, FlaskOne, flask.ini, FlaskOne, Value
IniRead, FlaskTwo, flask.ini, FlaskTwo, Value
IniRead, FlaskThree, flask.ini, FlaskThree, Value
iniRead, FlaskFour, flask.ini, FlaskFour, Value
IniRead, FlaskFive, flask.ini, FlaskFive, Value
IniRead, Mana, mana.ini, ColortoneM
IniRead, Mana_posX, mana.ini, XMPosition
IniRead, Mana_posY, mana.ini, YMPosition
IniRead, Health, health.ini, Colortone
IniRead, Health_posX, health.ini, XPosition
IniRead, Health_posY, health.ini, YPosition
IniRead, tf1, timer.ini, TimerOne, Value
iniread, tf2, timer.ini, TimerTwo, Value
iniread, tf3, timer.ini, TimerThree, Value
iniread, tf4, timer.ini, TimerFour, Value
iniread, tf5, timer.ini, TimerFive, Value
iniread, t, timer.ini, TimerSleep, Value

Loop
{
WatchDog:
PixelGetColor, CMS, %Mana_posX%, %Mana_posY%, RGB
if (CMS = Mana)
{
Tooltip, MP GOOD..., 1, 50, 2
sleep, %t%
}
else
{
if (FlaskOne = 0)
{
Send, 1
Tooltip, FLASK 1 USED..., 1, 50, 2
Sleep, %tf1%
}
if (Flasktwo = 0)
{ 
Send, 2
Tooltip, FLASK 2 USED..., 1, 50, 2
Sleep, %tf2%
}
if (FlaskThree =0)
{
Send, 3
Tooltip, FLASK 3 USED..., 1, 50, 2
Sleep, %tf3%
}
if (FlaskFour =0)
{
Send, 4
Tooltip, FLASK 4 USED..., 1, 50, 2
Sleep, %tf4%
}
if (FlaskFive =0)
{
Send, 5
Tooltip, FLASK 5 USED..., 1, 50, 2
sleep, %tf5%
}
}

PixelGetColor, CHS, %Health_posX%, %Health_posY%, RGB
if (CHS = Health)
{
Tooltip, HP GOOD..., 1, 1 ,1
sleep, %t%
}
else
{
if (FlaskOne = 1)
{
Send, 1
Tooltip, FLASK 1 USED..., 1, 1, 1
Sleep, %tf1%
}
if (Flasktwo = 1)
{ 
Send, 2
Tooltip, FLASK 2 USED..., 1, 1, 1
Sleep, %tf2%
}
if (FlaskThree =1)
{
Send, 3
Tooltip, FLASK 3 USED..., 1, 1, 1
Sleep, %tf3%
}
if (FlaskFour =1)
{
Send, 4
Tooltip, FLASK 4 USED..., 1, 1, 1
Sleep, %tf4%
}
if (FlaskFive =1)
{
Send, 5
Tooltip, FLASK 5 USED..., 1, 1, 1
sleep, %tf5%
}
}
}
return

F12::ExitApp