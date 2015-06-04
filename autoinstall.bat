@echo off
cd /d %~dp0

::字体后缀
set fontExtensions=(ttf otf)
for %%x in %fontExtensions% do (
	echo A|xcopy %cd%\*.%%x %windir%\fonts\
) 
for /f "delims=" %%i in ('dir /ad/b/s "%cd%"') do (
	for %%x in %fontExtensions% do (
		echo A|xcopy %%i\*.%%x %windir%\fonts\
	) 
)
::注册字体，单纯的拷贝不会安装成功
echo "registering font"
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT START "FontReg" %cd%\FontRegx86.exe
if %OS%==64BIT START "FontReg" %cd%\FontRegx64.exe
pause