;╔═════════════════════════════════════════════════════════════════════════════════════════════════
;║     win-main.pb                                                                           
;╠═════════════════════════════════════════════════════════════════════════════════════════════════
;║     Created: 05-08-2025 
;║
;║     Copyright (c) 2025 James Dooley <james@dooley.ch>
;║
;║     History:
;║     05-08-2025 : Initial version
;╚═════════════════════════════════════════════════════════════════════════════════════════════════
EnableExplicit

;-------- Modules --------
XIncludeFile "app_constants.pbi"
XIncludeFile "toolbar.pbi"
XIncludeFile "statusbar.pbi"
XIncludeFile "menu.pbi"

UseModule AppConstants
UseModule ToolbarModule
UseModule StatusBarModule
UseModule MenuModule

;-------- Support Routines --------

; Ask the user to confirm that requested action before carried out
;
Procedure.b ConfirmActionMessage(hWindow.i, message$)
  Protected result.i
  
  result = MessageRequester(#APP_Title, message$, #PB_MessageRequester_YesNo | #PB_MessageRequester_Info, WindowID(hWindow))
  
  If result = #PB_MessageRequester_Yes
    ProcedureReturn #True
  EndIf
  
  ProcedureReturn #False
EndProcedure

;┌───────────────────────────────────────────────────────────────────────────────────────────────
;│     Main Loop     
;└───────────────────────────────────────────────────────────────────────────────────────────────
#MainWindowFlags = #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget | #PB_Window_SizeGadget | #PB_Window_TitleBar

Define hMainWindow.i

hMainWindow = OpenWindow(#PB_Any, 50, 50, #MainWindow_Min_Width, #MainWindow_Min_Height, #APP_Title + " (" + #APP_Version_Number + ")", #MainWindowFlags)
If IsWindow(hMainWindow)
  WindowBounds(hMainWindow, #MainWindow_Min_Width, #MainWindow_Min_Height, #PB_Ignore, #PB_Ignore)
  
  ; Create the window gadgets
  CreateAppToolBar(hMainWindow)
  CreateAppStatusBar(hMainWindow)
  CreateAppMenu(hMainWindow)
  
  ; Enter the message procession loop
  Define event.i, shouldExit.b = #False
  
  Repeat
    event = WaitWindowEvent()
    
    Select event
      Case #APP_Event_About
        Debug "Display About Dialog"
      Case #PB_Event_CloseWindow, #APP_Event_Quit
        shouldExit = ConfirmActionMessage(hMainWindow, "Are you sure you wish to quit the application?") 
    EndSelect
    
  Until shouldExit
EndIf

;┌───────────────────────────────────────────────────────────────────────────────────────────────
;│     Clean up & Exit     
;└───────────────────────────────────────────────────────────────────────────────────────────────

End 0

; IDE Options = PureBasic 6.21 - C Backend (MacOS X - arm64)
; ExecutableFormat = Console
; CursorPosition = 53
; FirstLine = 19
; Folding = -
; EnableXP
; DPIAware