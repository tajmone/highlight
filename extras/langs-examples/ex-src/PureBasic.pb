; ==============================================================================
;                   PureBasic 5.62 - Syntax Highlighting Test                   
; ==============================================================================
; by Tristano Ajmone (2018/10/04), public domain: http://unlicense.org

Declare.i CountdownDialog(text.s)

Macro IsEven(num)
  (num & 1 = 0)  
EndMacro

For i=5 To 1 Step -1
  If isEven(i) : Debug Str(i) +" is even." : EndIf
  TEXT$ = "Iteration number: " + Str(i) + ~"\n\nDo you wish to continue?"
  If CountdownDialog(TEXT$) : Break : EndIf
Next

MyVar = %1011 << 1
EnableASM
INC MyVar ; Mix ASM keywords with PureBasic variable
DisableASM
Debug "MyVar: "+Str(MyVar)

Procedure.i CountdownDialog(text.s)
  UserChoice = MessageRequester("Countdown Dialog", text, #PB_MessageRequester_YesNo |
                                                          #PB_MessageRequester_Info)
  If UserChoice = #PB_MessageRequester_No
    CompilerIf #PB_Compiler_Processor = #PB_Processor_x64
      !mov rax,1
    CompilerElse
      !mov eax,1
    CompilerEndIf
  Else
    ProcedureReturn 0
  EndIf
  ProcedureReturn ; RAX/EAX will be the implicit return value
EndProcedure