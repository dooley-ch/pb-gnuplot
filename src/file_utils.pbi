;╔═════════════════════════════════════════════════════════════════════════════════════════════════
;║     file_utils.pbi                                                                           
;╠═════════════════════════════════════════════════════════════════════════════════════════════════
;║     Created: 29-06-2025 
;║
;║     Copyright (c) 2025 James Dooley <james@dooley.ch>
;║
;║     History:
;║     29-06-2025: Initial version
;╚═════════════════════════════════════════════════════════════════════════════════════════════════
DeclareModule FileUtils
  
  Declare.s MakePath(basePart$, value$) ; Constructs a file or folder path from the supplied parts using the system path separator
  Declare.b FileExists(value$)          ; Checks if a file exists
  Declare.b FileEmpty(value$)           ; Checks if a file exists
  Declare.b FolderExists(value$)        ; Checks if a folder exists
  
EndDeclareModule

Module FileUtils
  EnableExplicit
  
  ; Sets the path separator for the given operating system
  CompilerIf (#PB_Compiler_OS = #PB_OS_Windows) 
    #PATH_SEPARATPR = "\"
  CompilerElse
    #PATH_SEPARATPR = "/"
  CompilerEndIf
  
  ; Flags for checking the return value of the FileSize function
  #FileSize_Empty     = -1
  #FileSize_Directory = -2
  
  ;┌───────────────────────────────────────────────────────────────────────────────────────────────
  ;│     Public     
  ;└───────────────────────────────────────────────────────────────────────────────────────────────
  
  ; Constructs a file or folder path from the supplied parts using the system path separator
  Procedure.s MakePath(basePart$, value$) 
    ProcedureReturn basePart$ + #PATH_SEPARATPR + value$
  EndProcedure
  
  ; Checks if a file exists
  Procedure.b FileExists(value$)          
    ProcedureReturn (Bool(FileSize(value$) >= #FileSize_Empty))
  EndProcedure
  
  ; Checks if a file exists
  Procedure.b FileEmpty(value$)   
    ProcedureReturn (Bool(FileSize(value$) = #FileSize_Empty))
  EndProcedure
  
  ; Checks if a folder exists
  Procedure.b FolderExists(value$)  
    ProcedureReturn (Bool(FileSize(value$) = #FileSize_Directory))
  EndProcedure
  
EndModule
; IDE Options = PureBasic 6.21 - C Backend (MacOS X - arm64)
; ExecutableFormat = Console
; CursorPosition = 31
; FirstLine = 14
; Folding = --
; EnableXP
; DPIAware