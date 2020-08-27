@echo off
set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
rem set CUR_YYYY=2020
rem set CUR_MM=09
rem set CUR_DD=25

set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set CUR_MS=%time:~9,2%

rem Calcular dia anterior
if %CUR_DD% lss 10 (set /a BFR_DD=%CUR_DD:~-1%-1) else (set /a BFR_DD=%CUR_DD%-1)
if %CUR_MM% lss 10 (set BFR_MM=%CUR_MM:~-1%) else (set BFR_MM=%CUR_MM%)
set BFR_YYYY=%CUR_YYYY%
if %BFR_DD% equ 0 (set /a BFR_MM=%BFR_MM%-1)
if %BFR_MM% lss 10 (set BFR_MM=0%BFR_MM%)
if %BFR_MM% equ 0 (set /a BFR_YYYY=%CUR_YYYY%-1)
if %BFR_MM% equ 0 (set BFR_MM=12)
set MES_IMPAR=01 03 05 07 08 10 12
set MES_PAR=04 06 09 11

rem Calcular bisiesto (leap)
set /A "leap=!(CUR_YYYY%%4) + (!!(CUR_YYYY%%100)-!!(CUR_YYYY%%400))"
rem %leap% = 1 indica que es bisiesto

rem rectificar dia anterior si pertenece al mes anterior
if %BFR_DD% equ 0 (
	if %CUR_MM% equ 03 (if %leap% equ 1 (set BFR_DD=29) else (set BFR_DD=28)) else (
		rem meses con 31 dias
		if %BFR_DD% equ 0 (for %%i in (%MES_IMPAR%) do (if %%i==%BFR_MM% (set BFR_DD=31)))
		rem meses con 30 dias
		if %BFR_DD% equ 0 (for %%i in (%MES_PAR%) do (if %%i==%BFR_MM% (set BFR_DD=30)))
	)
)

if %BFR_DD% lss 10 (set BFR_DD=0%BFR_DD%)

echo .\%BFR_YYYY%%BFR_MM%%BFR_DD%

rem crear estructura de carpetas 
if not exist ".\%BFR_YYYY%" mkdir .\%BFR_YYYY%
if not exist ".\%BFR_YYYY%\%BFR_MM%" mkdir .\%BFR_YYYY%\%BFR_MM%
if not exist ".\%BFR_YYYY%\%BFR_MM%\%BFR_DD%" mkdir .\%BFR_YYYY%\%BFR_MM%\%BFR_DD%

set SUBFILENAME=%CUR_YYYY%%CUR_MM%%CUR_DD%-%CUR_HH%%CUR_NN%%CUR_SS%
set filedatetimef=Resultado_%SUBFILENAME%.txt
echo .\%BFR_YYYY%\%BFR_MM%\%BFR_DD%\%filedatetimef%
echo prova > .\%BFR_YYYY%\%BFR_MM%\%BFR_DD%\%filedatetimef%
