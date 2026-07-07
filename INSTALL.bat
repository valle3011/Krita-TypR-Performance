@echo off
rem === TypeR Performance - Installer fuer Krita (Windows) ===
rem Kopiert das Plugin in Kritas pykrita-Ordner. Einfach doppelklicken.
setlocal enableextensions
chcp 65001 >nul

set "SRC=%~dp0"
set "DEST=%APPDATA%\krita\pykrita"

echo ============================================
echo   TypeR Performance - Installation
echo ============================================
echo.
echo Quelle: %SRC%
echo Ziel:   %DEST%
echo.

rem --- Pruefen, ob die Quelldateien da sind ---
if not exist "%SRC%typer_perf.desktop" (
  echo [FEHLER] typer_perf.desktop nicht gefunden.
  echo Diese Datei muss im selben Ordner wie das Plugin liegen.
  goto :fail
)
if not exist "%SRC%typer_perf\" (
  echo [FEHLER] Ordner "typer_perf" nicht gefunden.
  goto :fail
)

rem --- Zielordner anlegen, falls noetig ---
if not exist "%DEST%" (
  echo Erstelle Ordner: %DEST%
  mkdir "%DEST%"
  if errorlevel 1 goto :fail
)

rem --- Kopieren ---
echo Kopiere typer_perf.desktop ...
copy /Y "%SRC%typer_perf.desktop" "%DEST%\" >nul
if errorlevel 1 goto :fail

echo Kopiere Ordner typer_perf ...
xcopy /E /I /Y "%SRC%typer_perf" "%DEST%\typer_perf\" >nul
if errorlevel 1 goto :fail

echo.
echo ============================================
echo   FERTIG - Plugin ist installiert.
echo ============================================
echo.
echo Naechste Schritte in Krita:
echo   1. Krita starten (oder neu starten, falls offen).
echo   2. Einstellungen - Krita einrichten - Python-Plugin-Manager
echo   3. Haken bei "TypeR Performance (test)" setzen.
echo   4. Krita neu starten.
echo   5. Docker oeffnen: Einstellungen - Andockbare Dialoge -
echo      "TypeR ... Performance".
echo.
echo Die normale TypeR bleibt unveraendert daneben bestehen.
echo.
goto :done

:fail
echo.
echo [ABBRUCH] Installation fehlgeschlagen.
echo Tipp: Krita vorher schliessen und die BAT erneut ausfuehren.
echo Falls Krita einen eigenen Ressourcen-Ordner nutzt, kopiere
echo "typer_perf.desktop" und den Ordner "typer_perf" manuell in den
echo "pykrita"-Unterordner dieses Ressourcen-Ordners
echo (in Krita: Einstellungen - Ressourcen verwalten - Ordner oeffnen).
echo.

:done
pause
endlocal
