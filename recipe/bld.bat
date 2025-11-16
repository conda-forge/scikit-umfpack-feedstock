@echo off
setlocal

REM Debug the env just so you can see it in Azure logs
echo SRC_DIR=%SRC_DIR%
echo PREFIX=%PREFIX%
echo LIBRARY_LIB=%LIBRARY_LIB%
echo LIBRARY_INC=%LIBRARY_INC%

echo ===== DIR LIBRARY_LIB =====
dir "%LIBRARY_LIB%"
echo ===== DIR LIBRARY_INC\suitesparse =====
dir "%LIBRARY_INC%\suitesparse"

REM Create Meson native file
set "NATIVE_FILE=%SRC_DIR%\nativefile.ini"
if exist "%NATIVE_FILE%" del "%NATIVE_FILE%"

echo [properties]> "%NATIVE_FILE%"

REM Escape backslashes for Meson
set "UMF_LIBDIR=%LIBRARY_LIB%"
set "UMF_LIBDIR=%UMF_LIBDIR:\=\\%"
echo umfpack-libdir = '%UMF_LIBDIR%'>> "%NATIVE_FILE%"

set "UMF_INCDIR=%LIBRARY_INC%\suitesparse"
set "UMF_INCDIR=%UMF_INCDIR:\=\\%"
echo umfpack-includedir = '%UMF_INCDIR%'>> "%NATIVE_FILE%"

echo ===== nativefile.ini =====
type "%NATIVE_FILE%"
echo ==========================

REM Build & install using pip/meson
"%PYTHON%" -m pip install . -vv ^
  --no-build-isolation ^
  --config-settings=setup-args="--native-file=%NATIVE_FILE%"

if errorlevel 1 (
  echo Pip/Meson build failed
  exit 1
)

REM Quick smoke-test *inside build env* to make sure API is present
"%PYTHON%" -c "import scikits.umfpack as um; \
print('has spsolve:', hasattr(um, 'spsolve')); \
print('has splu:', hasattr(um, 'splu')); \
print('has UmfpackContext:', hasattr(um, 'UmfpackContext'))"

if errorlevel 1 (
  echo scikits.umfpack smoke-test failed
  exit 1
)

endlocal
