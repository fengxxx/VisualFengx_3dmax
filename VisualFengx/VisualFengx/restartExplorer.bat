@echo off
color 0A
rem 以下程序段实现的操作是重新启动EXPLORER.EXE进程
:killexpl
TASKKILL /F /IM EXPLORER.EXE

tasklist|find "explorer.exe"
if errorlevel 1 goto nofind
echo 结束explorer失败,explorer仍然在运行,重新执行
echo.
goto killexpl
exit

:nofind

echo 没有查找到explorer.exe进程
echo.
echo 本程序将启动EXPLORER主程序
start explorer.exe
exit
