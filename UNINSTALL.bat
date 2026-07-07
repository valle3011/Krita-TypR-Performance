@echo off
rem === TypeR Performance - Deinstallieren ===
rem Entfernt nur die Performance-Version. Die normale TypeR bleibt bestehen.
setlocal enableextensions
chcp 65001 >nul

set "DEST=%APPDATA%\krita\pykrita"

echo ============================================
echo   TypeR Performance - Deinstallation
echo ============================================
echo.
echo Ordner: %DEST%
echo.

if exist "%DEST%\typer_perf.desktop" (
  del /F /Q "%DEST%\typer_perf.desktop"
  echo Entfernt: typer_perf.desktop
) else (
  echo typer_perf.desktop war nicht vorhanden.
)

if exist "%DEST%\typer_perf\" (
  rmdir /S /Q "%DEST%\typer_perf"
  echo Entfernt: Ordner typer_perf
) else (
  echo Ordner typer_perf war nicht vorhanden.
)

echo.
echo Fertig. Krita neu starten, damit die Aenderung wirkt.
echo.
pause
endlocal
