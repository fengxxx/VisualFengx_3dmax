@echo off
color 0A
rem ���³����ʵ�ֵĲ�������������EXPLORER.EXE����
:killexpl
TASKKILL /F /IM EXPLORER.EXE

tasklist|find "explorer.exe"
if errorlevel 1 goto nofind
echo ����explorerʧ��,explorer��Ȼ������,����ִ��
echo.
goto killexpl
exit

:nofind

echo û�в��ҵ�explorer.exe����
echo.
echo ����������EXPLORER������
start explorer.exe
exit
