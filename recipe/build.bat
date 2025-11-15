@echo on
setlocal enabledelayedexpansion

REM Convert MESON_ARGS="--foo bar" to "-Csetup-args=--foo -Csetup-args=bar"
set "MESON_SETUP_ARGS="
if not "%MESON_ARGS%"=="" (
    for %%A in (%MESON_ARGS%) do (
        set "MESON_SETUP_ARGS=!MESON_SETUP_ARGS! -Csetup-args=%%A"
    )
)

"%PYTHON%" -m pip install . --no-deps -vv %MESON_SETUP_ARGS%

