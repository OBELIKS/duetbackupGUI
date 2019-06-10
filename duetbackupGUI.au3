#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;*****************************************
;duetbackupGUI.au3 by OBELIKS
;Created with ISN AutoIt Studio v. 1.09
;*****************************************
#include "Forms\main.isf"

GUISetState(@SW_SHOW, $main)

While 1
	$nMsg = GUIGetMsg()
	Select
		Case $nMsg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $nMsg = $knofdir
			If GUICtrlRead($mapa) = "" Then
				$Input1n = FileSelectFolder("Point to backup directory!", @ScriptDir)
			Else
				$Input1n = FileSelectFolder("Point to backup directory!", GUICtrlRead($mapa))
			EndIf
			GUICtrlSetData($mapa, $Input1n)
		Case $nMsg = $zagon
			IniWrite(@ScriptDir & "\duetbackupGUI.ini", "General", "naslov", GUICtrlRead($naslov))
			IniWrite(@ScriptDir & "\duetbackupGUI.ini", "General", "vrata", GUICtrlRead($vrata))
			IniWrite(@ScriptDir & "\duetbackupGUI.ini", "General", "geslo", GUICtrlRead($geslo))
			IniWrite(@ScriptDir & "\duetbackupGUI.ini", "General", "odmet", GUICtrlRead($odmet))
			IniWrite(@ScriptDir & "\duetbackupGUI.ini", "General", "mapa", GUICtrlRead($mapa))
			IniWrite(@ScriptDir & "\duetbackupGUI.ini", "General", "bmapa", GUICtrlRead($bmapa))
			IniWrite(@ScriptDir & "\duetbackupGUI.ini", "General", "local", GUICtrlRead($local))
			
			Local $runcommand = '-domain "' & GUICtrlRead($naslov) & '" -outDir "' & GUICtrlRead($mapa) & '"'
			If GUICtrlRead($bmapa) <> "0:/" Then
				$runcommand = $runcommand & ' -dirToBackup "' & GUICtrlRead($bmapa) & '"'
			EndIf
			If GUICtrlRead($vrata) <> 80 Then
				$runcommand = $runcommand & ' -port "' & GUICtrlRead($vrata) & '"'
			EndIf
			If GUICtrlRead($geslo) <> "" Then
				$runcommand = $runcommand & ' -password "' & GUICtrlRead($geslo) & '"'
			EndIf
			If GUICtrlRead($local) = True Then
				$runcommand = $runcommand & ' -removeLocal '
			EndIf
			;MsgBox($MB_SYSTEMMODAL, "", 'duetbackup.exe ' &  $runcommand)
			$iReturn = RunWait(@ComSpec & ' /c duetbackup.exe ' & $runcommand, '', @SW_HIDE, $RUN_CREATE_NEW_CONSOLE)
			MsgBox($MB_SYSTEMMODAL, "", "Backup done, check the output directory." & $iReturn)
	EndSelect
WEnd
