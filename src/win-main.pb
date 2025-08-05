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
XIncludeFile "navigation_panel.pbi"
XIncludeFile "display_panel.pbi"
XIncludeFile "about_dlg.pbi"
XIncludeFile "file_utils.pbi"
XIncludeFile "setup.pbi"

UseModule AppConstants
UseModule ToolbarModule
UseModule StatusBarModule
UseModule MenuModule
UseModule NavigationPanelModule
UseModule DisplayPanelModule
UseModule AboutDlgModule
UseModule SetupModule

Define hMainWindow.i
Define mainWinInfo.WindowInfo

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

Procedure OnResizeMainWindow()
  #Navitation_Panel_Width = 150
  Shared hMainWindow
  Protected.i innerHeight, innerWidth, displayPanel_X, displayPanelWidth, panelHeight
  
  innerHeight = WindowHeight(hMainWindow, #PB_Window_InnerCoordinate)
  innerWidth = WindowWidth(hMainWindow, #PB_Window_InnerCoordinate)
  
  displayPanel_X = #Navitation_Panel_Width + (#CONTROL_OFFSET * 2)
  displayPanelWidth = innerWidth - displayPanel_X - #CONTROL_OFFSET
  
  panelHeight = innerHeight - (#CONTROL_OFFSET * 2) - GetAppStatusBarHeight()
  
  ResizeGadget(GetNavigationPanelId(), #CONTROL_OFFSET, #CONTROL_OFFSET, #Navitation_Panel_Width, panelHeight)
  ResizeGadget(GetDisplayPanelId(), displayPanel_X, #CONTROL_OFFSET, displayPanelWidth, panelHeight)
EndProcedure

;┌───────────────────────────────────────────────────────────────────────────────────────────────
;│     Main Loop     
;└───────────────────────────────────────────────────────────────────────────────────────────────
#MainWindowFlags = #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget | #PB_Window_SizeGadget | #PB_Window_TitleBar

GetMainWindowInfo(@mainWinInfo)

hMainWindow = OpenWindow(#PB_Any, mainWinInfo\X, mainWinInfo\Y, mainWinInfo\Width, mainWinInfo\Height, #APP_Title + " (" + #APP_Version_Number + ")", #MainWindowFlags)
If IsWindow(hMainWindow)
  WindowBounds(hMainWindow, #MainWindow_Min_Width, #MainWindow_Min_Height, #PB_Ignore, #PB_Ignore)
  
  ; Create the window gadgets
  CreateNavigationPanel(hMainWindow)
  CreateDisplayPanel(hMainWindow)
  
  CreateAppToolBar(hMainWindow)
  CreateAppStatusBar(hMainWindow)
  CreateAppMenu(hMainWindow)
  
  ; Enter the message procession loop
  Define event.i, shouldExit.b = #False, shouldProcessLoop.b = #True
  
  Repeat
    event = WaitWindowEvent()
    
    If event = #APP_Event_StopMainLoop
      shouldProcessLoop = #False
    EndIf
    
    If event = #App_Event_StartMainLoop          
      shouldProcessLoop = #True
    EndIf
    
    If Not shouldProcessLoop
      Continue
    EndIf
        
    Select event
      Case #APP_Event_CreateAreaChart
        CreateAreaChart()
      Case #APP_Event_Create3DBarChart
        Create3DBarChart()
      Case #APP_Event_CreateDoughnutChart
        CreateDoughnutChart()
      Case #APP_Event_CreateHorizontalBarChart
        CreateHorizontalBarChart()
      Case #APP_Event_CreateLineChart
        CreateLineChart()
      Case #APP_Event_CreatePieChart
        CreatePieChart()
      Case #APP_Event_CreateVerticalBarChart
        CreateVerticalBarChart()
      Case #APP_Event_About
        ShowAboutDialog(hMainWindow)
      Case #PB_Event_SizeWindow
        OnResizeMainWindow()
      Case #PB_Event_CloseWindow, #APP_Event_Quit
        shouldExit = ConfirmActionMessage(hMainWindow, "Are you sure you wish to quit the application?") 
    EndSelect
    
  Until shouldExit
  
  With mainWinInfo
    \x = WindowX(hMainWindow, #PB_Window_FrameCoordinate)
    \y = WindowY(hMainWindow, #PB_Window_FrameCoordinate)
    \width = WindowWidth(hMainWindow, #PB_Window_InnerCoordinate)
    \height = WindowHeight(hMainWindow, #PB_Window_InnerCoordinate)
  EndWith
  
  SetMainWindowInfo(@mainWinInfo)
  CloseWindow(hMainWindow)
EndIf

;┌───────────────────────────────────────────────────────────────────────────────────────────────
;│     Clean up & Exit     
;└───────────────────────────────────────────────────────────────────────────────────────────────

End 0
; IDE Options = PureBasic 6.21 - C Backend (MacOS X - arm64)
; ExecutableFormat = Console
; CursorPosition = 87
; FirstLine = 64
; Folding = -
; EnableXP
; DPIAware