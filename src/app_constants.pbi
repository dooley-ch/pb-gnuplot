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
  
  #APP_Version_Number="1.0.1"
  #APP_Title="PureBasic -> GNU Plot Example"
  
  #MainWindow_Min_Width = 900
  #MainWindow_Min_Height = 600
  
  Enumeration ApplicationEvents  #PB_Event_FirstCustomValue + 1000
    #APP_Event_About
    #APP_Event_Quit
  EndEnumeration
  
EndDeclareModule

Module AppConstants
EndModule
; IDE Options = PureBasic 6.21 - C Backend (MacOS X - arm64)
; ExecutableFormat = Console
; CursorPosition = 26
; Folding = -
; EnableXP
; DPIAware