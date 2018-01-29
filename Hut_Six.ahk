#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include C:\Software\Autohotkey\Library\Classmemory.ahk
#SingleInstance Force
DetectHiddenWindows, On
DetectHiddenText, On
CoordMode, Tooltip, Screen


if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
}

; Settings Gui
Settings:
{
Gui Add, Text, x20 y35 w120 h18 +0x200, Flask 1
Gui Add, Text, x20 y70 w120 h18 +0x200, Flask 2
Gui Add, Text, x20 y105 w120 h18 +0x200, Flask 3
Gui Add, Text, x20 y140 w120 h18 +0x200, Flask 4
Gui Add, Text, x20 y175 w120 h18 +0x200, Flask 5
Gui Add, Button, x20 y300 w120 h50 gSave, Save
Gui Add, Button, x180 y300 w160 h50 gRun, Run
Gui Add, Button, x380 y300 w80 h50 gExit, Exit
Gui Add, DropDownList, x180 y35 w120 vTrigger1,  Health|Energy|Mana|Disabled
Gui Add, DropDownList, x180 y70 w120 vTrigger2,  Health|Energy|Mana|Disabled
Gui Add, DropDownList, x180 y105 w120 vTrigger3, Health|Energy|Mana|Disabled
Gui Add, DropDownList, x180 y140 w120 vTrigger4, Health|Energy|Mana|Disabled
Gui Add, DropDownList, x180 y175 w120 vTrigger5, Health|Energy|Mana|Disabled
Gui Add, Slider, x340 y35 w120 h18  Range0-100 ToolTiptop vPercentage1, 50
Gui Add, Slider, x340 y70 w120 h18 Range0-100 ToolTiptop  vPercentage2, 50
Gui Add, Slider, x340 y105 w120 h18 Range0-100 ToolTiptop  vPercentage3, 50
Gui Add, Slider, x340 y140 w120 h18 Range0-100 ToolTiptop vPercentage4, 50
Gui Add, Slider, x340 y175 w120 h18 Range0-100 ToolTiptop  vPercentage5, 50
Gui Add, Text, x200 y2 w120 h18 +0x200, Flask Trigger
Gui Add, Text, x340 y2 w120 h18 +0x200, Percent To Trigger
Gui Add, Text, x380 y350 w120 h18 +0x200, by Archangel_77
Gui Show, w480 h380, Hut Six
}
Return

; BUTTON SAVE ON SETTINGS LABEL
Save:
{
FileDelete, settings.ini
Gui submit, nohide
iniwrite, %Trigger1%, settings.ini, Flask1, Trigger
iniwrite, %Percentage1%, settings.ini, Flask1, Percentage
iniwrite, %Trigger2%, settings.ini, Flask2, Trigger
iniwrite, %Percentage2%, settings.ini, Flask2, Percentage
iniwrite, %Trigger3%, settings.ini, Flask3, Trigger
iniwrite, %Percentage3%, settings.ini, Flask3, Percentage
iniwrite, %Trigger4%, settings.ini, Flask4, Trigger
iniwrite, %Percentage4%, settings.ini, Flask4, Percentage
iniwrite, %Trigger5%, settings.ini, Flask5, Trigger
iniwrite, %Percentage5%, settings.ini, Flask5, Percentage
TrayTip, Hut Six, The settings window is minimized, 10
Menu, Tray, Add
Menu, Tray, add, Settings, Maximize
}
return

; Maximize Settings Window
Maximize:
{
Gui Show, Restore
}
return

; Button Exit on Settings Label
Exit:
ExitApp
return

; Button Run on settings label
Run:
Gui, Hide
Goto Launch
return

; Launch Label 
Launch:
{
poe_ClassMemory.setSeDebugPrivilege()

IfWinExist, Path of Exile
{
Process Exist, PathOfExile_x64Steam.exe
PID := ErrorLevel
WinActivate, Path of Exile
}
else
{
MsgBox, Please Run Path of Exile in Windowed Mode or Fullscreen Windowed
WinWait, Path of Exile
}

; Monitoring Stats Watchdog


poe_ClassMemory.setSeDebugPrivilege(enable)
poe := new _ClassMemory("ahk_class POEWindowClass", "PROCESS_ALL_ACCESS", hProcessCopy) 
poe.isTargetProcess64bit(PID)
	
 Setformat, Integer, H
 Base := poe.BaseAddress
 SetFormat, Integer, D
 i = 1
  Loop
 {
 CHealth := poe.read(Base + 0x01442A90, "UInt", 0x2B0, 0x8, 0x18, 0xB0, 0x54) ; Current Health
 sleep, 20
 CEnergy := poe.read(Base + 0x01442A90, "UInt", 0x50, 0x1A8, 0x8, 0x18, 0xBC) ; Current Energy
 sleep, 20
 CMana := poe.read(Base + 0x01442A90, "UInt", 0x2B0, 0x8, 0x18, 0x48, 0x8C) ; Current Mana
 sleep, 20
 ResHealth := poe.read(Base + 0x016096F0, "UInt", 0x1A8, 0xA18, 0x728, 0x0, 0x310, 0x6E0) ; Reserved Health
 sleep, 20
 ResMana := poe.read(Base + 0x013FBFE8, "UInt", 0xA20, 0x710, 0x0, 0x10, 0x9E0) ; Reserved Mana
 sleep, 20
 MHealth := poe.read(Base+ 0x013FBFE8, "UInt", 0xA18, 0x710, 0x0, 0x510, 0x4C0) ; Max Health
 sleep, 20
 MMana := poe.read(Base + 0x013FBFE8, "UInt", 0xA20, 0x9A0, 0x310, 0x278, 0x440) ; Max Mana
 sleep, 20
 MEnergy := poe.read(Base + 0x013FBFE8, "UInt", 0xA18, 0x690, 0x308, 0x708, 0x9EC) ; Max Energy
 sleep, 20

         iniread, Trigger, settings.ini, Flask%i%, Trigger
         iniread, Percent, settings.ini, Flask%i%, Percentage
	if (Trigger = "Health") and CHealth < ((MHealth -ResHealth)*Percent)/100
	{
	SendInput, {%i%}
	Sleep, 150
	}
	if (Trigger = "Energy") and CEnergy < (MEnergy * Percent)/100
	{
	SendInput, {%i%}
	Sleep, 150
	}
	if (Trigger = "Mana") and CMana < ((MMana -ResMana)*Percent)/100
	{
	SendInput, {%i%}
	Sleep, 150
    }
	i++
	if i = 6
	{
	i = 1
	}
  }
  }
return

F12::ExitApp
F10::Pause
