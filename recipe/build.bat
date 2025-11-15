@echo on
setlocal enabledelayedexpansion

echo [properties]> nativefile.ini
echo umfpack-libdir = '%PREFIX%\Library\lib'>> nativefile.ini
echo umfpack-includedir = '%PREFIX%\Library\include\suitesparse'>> nativefile.ini

REM Now build with pip, passing the Meson native file via config-settings
"%PYTHON%" -m pip install . --no-deps -vv -Csetup-args=--native-file=%CD%\nativefile.ini

