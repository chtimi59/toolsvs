:: --------------------------------------------------------------------------------------- 
:: Copy ressources script
::
:: The idea is to copy dll, ressources after build process (if necessary)
:: The copy is base on xcopy '/D' option which check date before copying
:: Note: The batch file don't use any third parties (like CMake) 
::
:: 
:: Usage:
:: In your visual project "Build Events" > "Post-Build Event"
:: add the following line
::
:: copyres.bat "$(ProjectName)" "$(Configuration)" "$(Platform)" "$(OutDir)"
::
:: ---------------------------------------------------------------------------------------

@echo off
@setlocal
@set PROJECT=%~1
@set CONFIGURATION=%~2
@set PLATFORM=%~3
@set OUTDIR=%~dpnx4
@echo ------ Copy Ressources: Project: %PROJECT%, Configuration: %CONFIGURATION% %PLATFORM% ------
@echo Output Directory : %OUTDIR%

:: ---------------------------------------------------------------------------------------
:: Add your ressource files here!
:: Note: current working directory is where the batch file is
:: ---------------------------------------------------------------------------------------
@set ATFDIR=..\..\atf\lib\Release_x64
@call:cpy   "%ATFDIR%\atf_processor.dll"
@call:cpy   "%ATFDIR%\atf_api.dll"
@call:cpy   "%ATFDIR%\atf_extension_data.dll"
@call:cpy   "%ATFDIR%\atf_asm_interface.dll"
:: ---------------------------------------------------------------------------------------

@del copy.tmp /F/Q 2>nul
@endlocal
@goto:eof

:cpy - internal wrapper on xcopy function
@set src=%~1
xcopy "%src%" "%OUTDIR%" /D/Y/Q > copy.tmp
@for /F "delims=" %%a in (copy.tmp) do (
   if "%%a" == "1 File(s) copied" (echo copied: %src%)
)
@goto:eof