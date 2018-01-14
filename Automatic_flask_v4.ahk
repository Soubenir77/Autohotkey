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
FileDelete, settings.ini
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

Iniwrite, %VarH%, settings.ini, Colortone
Iniwrite, %XX%, settings.ini, XPosition
Iniwrite, %YY%, settings.ini, YPosition
iniWrite, %VarM%, settings.ini, ColortoneM
iniwrite, %XXM%, settings.ini, XMPosition
iniwrite, %YYM%, settings.ini, YMPosition

Gui, Add, Text,, Choose Wisely...
Gui, Add, Text,, (Setup Flasks Trigger)
Gui, Add, Checkbox,  checked vFlask1,  Set HP As Trigger?(flask1)
Gui, Add, Checkbox,  checked vFlask2,  Set HP As Trigger?(flask2)
Gui, Add, Checkbox,  checked vFlask3,  Set HP As Trigger?(flask3)
Gui, Add, Checkbox,  checked vFlask4,  Set HP As Trigger?(flask4)
Gui, Add, Checkbox,  checked vFlask5,  Set HP As Trigger?(flask5)
Gui, Add, Text,, (Flask Delay On Trigger in miliseconds)
Gui, Add, Edit, vTimer1, Flask1Duration
Gui, Add, Edit, vTimer2, Flask2Duration
Gui, Add, Edit, vTimer3, Flask3Duration
Gui, Add, Edit, vTimer4, Flask4Duration
Gui, Add, Edit, vTimer5, Flask5Duration
Gui, Add, Text,, ( Script  Refresh Interval in miliseconds)
Gui, Add, Edit, vTimer,  ScriptRefreshTimer
Gui, Add, Button, gLabel, Save
Gui, Show, Autosize Center
return

Label:
Gui, Submit, NoHide
IniWrite, %Flask1%, settings.ini, FlaskOne, Value
IniWrite, %Flask2%, settings.ini, FlaskTwo, Value
IniWrite, %Flask3%, settings.ini, FlaskThree, Value
iniWrite, %Flask4%, settings.ini, FlaskFour, Value
Iniwrite, %Flask5%, settings.ini, FlaskFive, Value
IniWrite, %Timer1%, settings.ini, TimerOne, Value
IniWrite, %Timer2%, settings.ini, TimerTwo, Value
IniWrite, %Timer3%, settings.ini, TimerThree, Value
IniWrite, %Timer4%, settings.ini, TimerFour, Value
IniWrite, %TImer5%, settings.ini, TimerFive, Value
IniWrite, %Timer%, settings.ini, TimerSleep, Value
Gui, Destroy
GoTo, Execute
Return

Execute:
IniRead, FlaskOne, settings.ini, FlaskOne, Value
IniRead, FlaskTwo, settings.ini, FlaskTwo, Value
IniRead, FlaskThree, settings.ini, FlaskThree, Value
iniRead, FlaskFour, setttings.ini, FlaskFour, Value
IniRead, FlaskFive, settings.ini, FlaskFive, Value
IniRead, Mana, settings.ini, ColortoneM
IniRead, Mana_posX, settings.ini, XMPosition
IniRead, Mana_posY, settings.ini, YMPosition
IniRead, Health, settings.ini, Colortone
IniRead, Health_posX, settings.ini, XPosition
IniRead, Health_posY, settings.ini, YPosition
IniRead, tf1, settings.ini, TimerOne, Value
iniread, tf2, settings.ini, TimerTwo, Value
iniread, tf3, settings.ini, TimerThree, Value
iniread, tf4, settings.ini, TimerFour, Value
iniread, tf5, settings.ini, TimerFive, Value
iniread, t, settings.ini, TimerSleep, Value

Loop
{
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