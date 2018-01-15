SetWorkingDir %A_ScriptDir%
#NoEnv  
#Warn  
#Persistent
#SingleInstance Force
SendMode Input


ifWinExist, Path of Exile
{
Gui, Add, Text,, Welcome to Flasker...
Gui, Add, Text,, F12 Pauses the Script...
Gui, Add, Text,, F10 Exits the Script...
Gui, Add, Button, gSetup, Settings
Gui, Add, Button, gRun, Run
Gui, Font, s32, Verdana
Gui, Show, Center
}
else
{
MsgBox, 0,, Run Path of Exile Client and Re-Run Program
ifMsgBox OK
ExitApp
}
return

Setup:
Gui, Destroy
FileDelete, settings.ini

WinGetPos, XP, YP, WidthP, HeightP, Path of Exile
Iniwrite, %WidthP%, settings.ini, WidthPoE
IniWrite, %HeightP%, settings.ini, HeightPoE

Tooltip, Aim your HP at desired Pixel and Press Space..., 1, 1
KeyWait, Space, D
KeyWait, Space
if Errorlevel = 0
{
MouseGetPos, XXH, YYH
PixelGetColor, VarH, %XXH%, %YYH%, RGB
}
Tooltip, Aim your MP at desired Pixel and Press Space..., 1, 1
KeyWait, Space, D
KeyWait, Space
If Errorlevel = 0
{
MouseGetPos, XXM, YYM
PixelGetColor, VarM, %XXM%, %YYM%, RGB
}
Tooltip, Press Space to Save Settings..., 1, 1
KeyWait, Space, D
Keywait, Space
if ErrorLevel = 0
{
Iniwrite, %VarH%, settings.ini, ColortoneH
Iniwrite, %XXH%, settings.ini, XHPosition
Iniwrite, %YYH%, settings.ini, YHPosition
iniWrite, %VarM%, settings.ini, ColortoneM
iniwrite, %XXM%, settings.ini, XMPosition
iniwrite, %YYM%, settings.ini, YMPosition
}
Gui, Add, Text,, Flask Trigger Settings
Gui, Add, Text,, Flask One
Gui, Add, DDL, vFlask1Trigger, Health|Mana|Null
Gui, Add, Text,, Flask Two
Gui, Add, DDL, vFlask2Trigger, Health|Mana|Null
Gui, Add, Text,, Flask Three
Gui, Add, DDL, vFlask3Trigger, Health|Mana|Null
Gui, Add, Text,, Flask Four
Gui, Add, DDL, vFlask4Trigger, Health|Mana|Null
Gui, Add, Text,, Flask Five
Gui, Add, DDL, vFlask5Trigger, Health|Mana|Null
Gui, Add, Text,, Remove Debuff Settings
Gui, Add, Text,, Flask One
Gui, Add, DDL, vDebufferFlask1, Grounding|Staunching|Heat|Dousing|Curing|Null
Gui, Add, Text,, Flask Two
Gui, Add, DDL, vDebufferFlask2, Grounding|Staunching|Heat|Dousing|Curing|Null
Gui, Add, Text,, Flask Three
Gui, Add, DDL, vDebufferFlask3, Grounding|Staunching|Heat|Dousing|Curing|Null
Gui, Add, Text,, Flask Four
Gui, Add, DDL, vDebufferFlask4, Grounding|Staunching|Heat|Dousing|Curing|Null
Gui, Add, Text,, Flask Five
Gui, Add, DDL, vDebufferFlask5, Grounding|Staunching|Heat|Dousing|Curing|Null
Gui, Add, Button, gSave, Save
Gui, Add, Button, gRun, Run
Gui, Font, s32, Verdana
Gui, Show, Center
return

Save:
Gui, Submit, NoHide
IniWrite, %Flask1Trigger%, settings.ini, Trigger1
IniWrite, %Flask2Trigger%, settings.ini, Trigger2
IniWrite, %Flask3Trigger%, settings.ini, Trigger3
IniWrite, %Flask4Trigger%, settings.ini, Trigger4
IniWrite, %Flask5Trigger%, settings.ini, Trigger5
IniWrite, %DebufferFlask1%, settings.ini, TriggerD1
IniWrite, %DebufferFlask2%, settings.ini, TriggerD2
IniWrite, %DebufferFlask3%, settings.ini, TriggerD3
IniWrite, %DebufferFlask4%, settings.ini, TriggerD4
IniWrite, %DebufferFlask5%, settings.ini, TriggerD5
return

Run:
Gui, Destroy
Iniread PixelH, settings.ini, ColorToneH
Iniread PixelM, settings.ini, ColorToneM
Iniread, H_PosX, settings.ini, XHPosition
Iniread, H_PosY, settings.ini, YHPosition
Iniread, M_PosX, settings.ini, XMPosition
Iniread, M_PosY, settings.ini, YMPosition
Iniread, Flask1, settings.ini, Trigger1
Iniread, Flask2, settings.ini, Trigger2
Iniread, Flask3, settings.ini, Trigger3
Iniread, Flask4, settings.ini, Trigger4
Iniread, Flask5, settings.ini, Trigger5
Iniread, DFlask1, settings.ini, TriggerD1
Iniread, DFlask2, settings.ini, TriggerD2
Iniread, DFlask3, settings.ini, TriggerD3
Iniread, DFlask4, settings.ini, TriggerD4
Iniread, DFlask5, settings.ini, TriggerD5
Iniread, PWidth, settings.ini, WidthPoE
Iniread, PHeight, settings.ini, HeightPoE

Loop 
{
PixelGetColor, Health_Current, H_PosX, H_PosY, RGB
Sleep, 50
PixelGetColor, Mana_Current, M_PosX, M_PosY, RGB
Sleep, 50
Tooltip Scanning HP...MP..., 1, 1

If (Flask1 = "Health") And (Health_Current != PixelH)
{
SendInput, 1
Sleep, 100
Tooltip, Flask One Used..., 1, 1
}
if (Flask1 = "Mana") And (Mana_Current != PixelM)
{
SendInput, 1
Sleep, 100
Tooltip, Flask One Used..., 1, 1
}
If (Flask2 = "Health") And (Health_Current != PixelH)
{
SendInput, 2
Sleep, 100
Tooltip, Flask Two Used..., 1, 1
}
if (Flask2 = "Mana") And (Mana_Current != PixelM)
{
SendInput, 2
Sleep, 100
Tooltip, Flask Two Used..., 1, 1
}
If (Flask3 = "Health") And (Health_Current != PixelH)
{
SendInput, 3
Sleep, 100
Tooltip, Flask Three Used..., 1, 1
}
if (Flask3 = "Mana") And (Mana_Current != PixelM)
{
SendInput, 3
Sleep, 100
Tooltip, Flask Three Used..., 1, 1
}
If (Flask4 = "Health") And (Health_Current != PixelH)
{
SendInput, 4
Sleep, 100
Tooltip, Flask Four Used..., 1, 1
}
if (Flask4 = "Mana") And (Mana_Current != PixelM)
{
SendInput, 4
Sleep, 100
Tooltip, Flask Four Used..., 1, 1
}
If (Flask5 = "Health") And (Health_Current != PixelH)
{
SendInput, 5
Sleep, 100
Tooltip, Flask Five Used..., 1, 1
}
if (Flask5 = "Mana") And (Mana_Current != PixelM)
{
SendInput, 5
Sleep, 100
Tooltip, Flask Five Used..., 1, 1
}
ImageSearch, FoundX, FoundY, 0, 0, %PWidth%, %PHeight%, Bleed.png
if ErrorLevel = 0
{
if (DFlask1 = "Staunching")
{
SendInput, 1
Sleep, 100
Tooltip, Bleed Detected Flask Used..., 1, 1
}
if (DFlask2 = "Staunching")
{
SendInput, 2
Sleep, 100
Tooltip, Bleed Detected Flask Used..., 1, 1
}
if (DFlask3 = "Staunching")
{
SendInput, 3
Sleep, 100
Tooltip, Bleed Detected Flask Used..., 1, 1
}
if (DFlask4 = "Staunching")
{
SendInput, 4
Sleep, 100
Tooltip, Bleed Detected Flask Used..., 1, 1
}
if (DFlask5 = "Staunching")
{
SendInput, 5
Sleep, 100
Tooltip, Bleed Detected Flask Used..., 1, 1
}
}
ImageSearch, FoundX, FoundY, 0, 0, %PWidth%, %PHeight%, Freeze.png
if ErrorLevel = 0
{
if (DFLask1 = "Heat")
{
SendInput, 1
Sleep, 100
Tooltip, Freeze Detected Flask Used..., 1, 1
}
if (DFLask2 = "Heat")
{
SendInput, 2
Sleep, 100
Tooltip, Freeze Detected Flask Used..., 1, 1
}
if (DFLask3 = "Heat")
{
SendInput, 3
Sleep, 100
Tooltip, Freeze Detected Flask Used..., 1, 1
}
if (DFLask4 = "Heat")
{
SendInput, 4
Sleep, 100
Tooltip, Freeze Detected Flask Used..., 1, 1
}
if (DFLask5 = "Heat")
{
SendInput, 5
Sleep, 100
Tooltip, Freeze Detected Flask Used..., 1, 1
}
}
ImageSearch, FoundX, FoundY, 0, 0, %PWidth%, %PHeight%, Shock.png
if ErrorLevel = 0
{
if (DFLask1 = "Grounding")
{
SendInput, 1
Sleep, 100
Tooltip, Shock Detected Flask Used..., 1, 1
}
if (DFLask2 = "Grounding")
{
SendInput, 2
Sleep, 100
Tooltip, Shock Detected Flask Used..., 1, 1
}
if (DFLask3 = "Grounding")
{
SendInput, 3
Sleep, 100
Tooltip, Shock Detected Flask Used..., 1, 1
}
if (DFLask4 = "Grounding")
{
SendInput, 4
Sleep, 100
Tooltip, Shock Detected Flask Used..., 1, 1
}
if (DFLask5 = "Grounding")
{
SendInput, 5
Sleep, 100
Tooltip, Shock Detected Flask Used..., 1, 1
}
}
ImageSearch, FoundX, FoundY, 0, 0, %PWidth%, %PHeight%, Poison.png
if ErrorLevel = 0
{
if (DFlask1 = "Curing")
{
SendInput, 1
Sleep, 100
Tooltip, Poison Detected Flask Used..., 1, 1
}
if (DFlask2 = "Curing")
{
SendInput, 2
Sleep, 100
Tooltip, Poison Detected Flask Used..., 1, 1
}
if (DFlask3 = "Curing")
{
SendInput, 3
Sleep, 100
Tooltip, Poison Detected Flask Used..., 1, 1
}
if (DFlask4 = "Curing")
{
SendInput, 4
Sleep, 100
Tooltip, Poison Detected Flask Used..., 1, 1
}
if (DFlask5 = "Curing")
{
SendInput, 5
Sleep, 100
Tooltip, Poison Detected Flask Used..., 1, 1
}
}
ImageSearch, FoundX, FoundY, 0, 0, %Pwidth%, %PHeight%, Ignite.png
if ErrorLevel = 0
{
if (DFlask1 = "Dousing")
{
SendInput, 1
Sleep, 100
Tooltip, Dousing Detected Flask Used..., 1, 1
}
if (DFlask2 = "Dousing")
{
SendInput, 2
Sleep, 100
Tooltip, Dousing Detected Flask Used..., 1, 1
}
if (DFlask3 = "Dousing")
{
SendInput, 3
Sleep, 100
Tooltip, Dousing Detected Flask Used..., 1, 1
}
if (DFlask4 = "Dousing")
{
SendInput, 4
Sleep, 100
Tooltip, Dousing Detected Flask Used..., 1, 1
}
if (DFlask5 = "Dousing")
{
SendInput, 5
Sleep, 100
Tooltip, Dousing Detected Flask Used..., 1, 1
}

}

}
return

F12::Pause
F10::ExitApp


