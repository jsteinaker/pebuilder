; AutoIt Version 3.0.103
; Language:       Spanish
; Author:         Javier Steinaker
; Email:          jsteinaker@gmail.com
; Date: September 10, 2015

#include <GuiConstantsEx.au3>
#include <ButtonConstants.au3>
#include <MsgBoxConstants.au3>

_Main()

Func _Main()
	Local $iMsg

	; Create the GUI window and controls
	GUICreate("Copia de archivos", 500, 200, (@DesktopWidth - 500) / 2, (@DesktopHeight - 500) / 2)
	GUICtrlCreateLabel("Origen", 30, 20, 131, 21)
	GUICtrlCreateLabel("Destino", 30, 50, 131, 21)
	$txtOrigin = GUiCtrlCreateEdit("", 80, 20, 300, 21)
	$txtDestination = GUiCtrlCreateEdit("", 80, 50, 300, 21)
	$broken = GUICtrlCreateCheckbox("Saltar archivos dañados", 30, 80, 131, 21)
	$overwrite = GUICtrlCreateCheckbox("No sobreescribir archivos existentes", 30, 102, 190, 21)
	$selectOrigin = GUICtrlCreateButton("...", 390, 20, 21, 21)
	$selectDestination = GUICtrlCreateButton("...", 390, 50, 21, 21)
	$startCopy = GUICtrlCreateButton("Iniciar copia", 420, 20, 60, 51, $BS_MULTILINE)
	GuiCtrlCreateLabel("Línea de comandos:", 30, 130, 131, 21)
	$commandLine = GUICtrlCreateLabel("", 170, 130, 300, 42)
	$about = GuiCtrlCreateButton("Acerca de...", 30, 160, 80, 21)

	; Run the GUI until it is closed
	GUISetState()
	While 1
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
			   ExitLoop
			Case $iMsg = $selectOrigin
			   GuiCtrlSetData($txtOrigin, FileSelectFolder("Seleccione carpeta de origen", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"))
			Case $iMsg = $selectDestination
			   GuiCtrlSetData($txtDestination, FileSelectFolder("Seleccione carpeta de destino", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"))
			Case $iMsg = $startCopy
			   $args = @ComSpec & " /k " & "robocopy /E " & Chr(34) & GuiCtrlRead($txtOrigin) & Chr(34) & " " & Chr(34) & GuiCtrlRead($txtDestination) & Chr(34) & " /eta"
			   If GuiCtrlRead($broken) = $GUI_CHECKED Then
				  $args &= " /R:0 /W:0"
			   EndIf
			   If GuiCtrlRead($overwrite) = $GUI_CHECKED Then
				  $args &= " /XO"
			   EndIf
			   GuiCtrlSetData($commandLine, $args)
			   RunWait($args)
			Case $iMsg = $about
			   MsgBox($MB_SYSTEMMODAL, "Acerca de Copia de archivos", "Copia de archivos versión 0.1" & @CRLF & "Interfaz gráfica para Robocopy")
		 EndSelect
	WEnd
	Exit
 EndFunc   ;==>_Main

 Func _Copy()

