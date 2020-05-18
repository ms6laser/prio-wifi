:: Programme créé par Ms6Laser et disponible sur github ( https://github.com/ms6laser/prio-wifi )
:: Pour information ce programme est créé en Batch.

@echo off

color 02

title Prio-Wifi

:: Permet de passer la console en mode admin 

echo Bonjour et merci d'avoir telecharge ce fichier.
echo.
echo Nous allons vous demander les droits administrateur car ceux-ci sont obligatoires pour etre prioritaire sur votre WIFI
echo Vous pouvez tout a fait refuser mais vous ne serez pas prioritaire :D .
echo.
echo Appuyez sur une touche pour etre administrateur puis une nouvelle fois pour continuer.
echo.

pause

::clear de l'écran

cls

:-------------------------------------
REM  -->  Verification des permissions admin
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> Si refus des droits admin
if '%errorlevel%' NEQ '0' (
    echo Verification des privileges administrateur en cours...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:: confirme la decision de l'utilisateur
echo.
echo Voulez vous vraiment passer en mode prioritaire sur votre connection  ?
echo.
echo Si oui appuyez sur une touche.
echo Sinon fermez cette fenetre.
echo.

pause

:: clear de l'écran

cls

:: Permet de passer en mode prioritaire sur la connection WIFI
netsh interface tcp set global autotuning=restricted
set supplemental congestionprovider=ctcp

cls

echo.
echo C'est bon vous etes prioritaire ! Bonne journee.
echo.
echo Appuyez sur une touche pour quitter.
echo.

pause

:: Fin du programme
z
exit 
