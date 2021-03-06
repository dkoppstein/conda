@SET "_CONDA_EXE=%~dp0..\..\Scripts\conda.exe"

@IF "%1"=="activate" GOTO :DO_ACTIVATE
@IF "%1"=="deactivate" GOTO :DO_DEACTIVATE

@CALL %_CONDA_EXE% %*

@IF "%1"=="install" GOTO :DO_DEACTIVATE
@IF "%1"=="update" GOTO :DO_DEACTIVATE
@IF "%1"=="remove" GOTO :DO_DEACTIVATE
@IF "%1"=="uninstall" GOTO :DO_DEACTIVATE

@GOTO :End


:DO_ACTIVATE
@IF "%CONDA_PROMPT_MODIFIER%" == "" GOTO skip_prompt_set_activate
    @CALL SET PROMPT=%%PROMPT:%CONDA_PROMPT_MODIFIER%=%replacement%%%
:skip_prompt_set_activate
@FOR /F "delims=" %%i IN ('@call %_CONDA_EXE% shell.activate cmd.exe %2') DO @SET "_TEMP_SCRIPT_PATH=%%i"
@CALL "%_TEMP_SCRIPT_PATH%"
@DEL /F /Q "%_TEMP_SCRIPT_PATH%"
@SET _TEMP_SCRIPT_PATH=
@SET "PROMPT=%CONDA_PROMPT_MODIFIER%%PROMPT%"
@GOTO :End

:DO_DEACTIVATE
@IF "%CONDA_PROMPT_MODIFIER%" == "" GOTO skip_prompt_set_deactivate
    @CALL SET PROMPT=%%PROMPT:%CONDA_PROMPT_MODIFIER%=%replacement%%%
:skip_prompt_set_deactivate
@FOR /F "delims=" %%i IN ('@call %_CONDA_EXE% shell.deactivate cmd.exe') DO @SET "_TEMP_SCRIPT_PATH=%%i"
@CALL "%_TEMP_SCRIPT_PATH%"
@DEL /F /Q "%_TEMP_SCRIPT_PATH%"
@SET _TEMP_SCRIPT_PATH=
@SET "PROMPT=%CONDA_PROMPT_MODIFIER%%PROMPT%"
@GOTO :End

:DO_REACTIVATE
@FOR /F "delims=" %%i IN ('@call %_CONDA_EXE% shell.reactivate cmd.exe') DO @SET "_TEMP_SCRIPT_PATH=%%i"
@CALL "%_TEMP_SCRIPT_PATH%"
@DEL /F /Q "%_TEMP_SCRIPT_PATH%"
@SET _TEMP_SCRIPT_PATH=
@GOTO :End

:End
@SET _CONDA_EXE=
@GOTO :eof
