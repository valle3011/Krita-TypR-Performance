@echo off
rem === TypeR Performance - Update fuer Krita (Windows) ===
rem Kopiert die neuesten Plugin-Dateien ueber eine bestehende Installation.
rem Einstellungen bleiben erhalten. Einfach doppelklicken.
setlocal enableextensions
chcp 65001 >nul

set "SRC=%~dp0"
set "DEST=%APPDATA%\krita\pykrita"

echo ============================================
echo   TypeR Performance - Update
echo ============================================
echo.
echo Ziel: %DEST%
echo.

if not exist "%SRC%typer_perf.desktop" (
  echo [FEHLER] typer_perf.desktop nicht gefunden.
  goto :fail
)
if not exist "%SRC%typer_perf\" (
  echo [FEHLER] Ordner "typer_perf" nicht gefunden.
  goto :fail
)
if not exist "%DEST%\typer_perf\" (
  echo Noch nicht installiert - starte stattdessen INSTALL.bat ...
  call "%SRC%INSTALL.bat"
  goto :eof
)

echo Kopiere typer_perf.desktop ...
copy /Y "%SRC%typer_perf.desktop" "%DEST%\" >nul
if errorlevel 1 goto :fail

echo Kopiere Ordner typer_perf ...
xcopy /E /I /Y "%SRC%typer_perf" "%DEST%\typer_perf\" >nul
if errorlevel 1 goto :fail

echo.
echo ============================================
echo   FERTIG - Update eingespielt.
echo ============================================
echo.
echo Starte Krita neu, damit die Aenderungen wirken.
echo.
goto :done

:fail
echo.
echo [ABBRUCH] Update fehlgeschlagen. Krita vorher schliessen und erneut versuchen.
echo.

:done
pause
endlocal
