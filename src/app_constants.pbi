;╔═════════════════════════════════════════════════════════════════════════════════════════════════
;║     app_constants.bpi                                                                           
;╠═════════════════════════════════════════════════════════════════════════════════════════════════
;║     Created: 05-08-2025 
;║
;║     Copyright (c) 2025 James Dooley <james@dooley.ch>
;║
;║     History:
;║     05-08-2025: Initial version
;╚═════════════════════════════════════════════════════════════════════════════════════════════════
DeclareModule AppConstants
  
  #CONTROL_OFFSET = 5
  
  #APP_Version_Number = "1.0.1"
  #APP_Title = "PureBasic -> GNU Plot Example"
  
  #ORGANISATION = "dooley.ch"
  #APPLICATION = "pb-gnuplot"
  
  #MainWindow_Min_Width = 900
  #MainWindow_Min_Height = 600
  #MainWindow_X = 50
  #MainWindow_Y = 50  
  
  Enumeration ApplicationEvents  #PB_Event_FirstCustomValue + 1000
    #APP_Event_CreateAreaChart
    #APP_Event_Create3DBarChart
    #APP_Event_CreateDoughnutChart
    #APP_Event_CreateHorizontalBarChart
    #APP_Event_CreateLineChart
    #APP_Event_CreatePieChart
    #APP_Event_CreateVerticalBarChart
    #APP_Event_About
    #APP_Event_Quit
  EndEnumeration
  
  Enumeration MessageLoopControl #PB_Event_FirstCustomValue + 2000
    #APP_Event_StopMainLoop
    #App_Event_StartMainLoop
  EndEnumeration
EndDeclareModule

Module AppConstants
EndModule
; IDE Options = PureBasic 6.21 - C Backend (MacOS X - arm64)
; ExecutableFormat = Console
; CursorPosition = 18
; Folding = -
; EnableXP
; DPIAware