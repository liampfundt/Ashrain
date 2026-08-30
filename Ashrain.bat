@ECHO OFF
CHCP 65001 >NUL

:: LIAM PFUNDT SOFTWARE IS NOT RESPONSIBLE FOR ANY DAMAGE TO YOUR PC NOR ACCIDENTAL LOSS OF FILES.
:: DON'T TAMPER WITH THE SOURCE FILES OF ASHRAIN AND FOLLOW THE LICENSE (..\copabanana_vbtxlicense.txt).
:: USE ASHRAIN WITH CAUTION ON YOUR OWN RISK.

:: Ashrain partly uses third-party software, here is what software and it's license are used and can be found:
:: bin\aria2c.exe -> ..\licenses\COPYING & ..\licenses\LICENSE.OpenSSL

:: About 98% is written by hand and about 2% of error correction and solving was done by ChatGPT.
:: Accurate percentages, for if you were wondering...

:BOF

CALL :Function.clearscreen

:: Set basic variables
SET "Ashrain.Github=https://github.com/liampfundt/Ashrain"
SET "Ashrain.support=liampfundtsoftware@gmail.com"
SET "Ashrain.version=Ashrain Twux 1.0"
SET "Ashrain.author=Liam Pfundt"
SET "Ashrain.user=%username%"
TITLE %Ashrain.version%

:: Set macOS download links
SET "Download.MountainLion10,8=https://dn720604.ca.archive.org/0/items/macOS-X-images/Mountain%%20Lion%%2010.8.iso"
SET "Download.HighSierra10,13=https://dn720604.ca.archive.org/0/items/macOS-X-images/High%%20Sierra%%2010.13.iso"
SET "Download.ElCapitan10,11=https://dn720604.ca.archive.org/0/items/macOS-X-images/El%%20Capitan%%2010.11.iso"
SET "Download.Yosemite10,10=https://dn720604.ca.archive.org/0/items/macOS-X-images/Yosemite%%2010.10.iso"
SET "Download.Catalina10,15=https://dn720604.ca.archive.org/0/items/macOS-X-images/Catalina%%2010.15.iso"
SET "Download.Sierra10,12=https://dn720604.ca.archive.org/0/items/macOS-X-images/Sierra%%2010.12.iso"
SET "Download.Mojave10,14=https://dn720604.ca.archive.org/0/items/macOS-X-images/Mojave%%2010.14.iso"
SET "Download.Monterey12=https://dn720604.ca.archive.org/0/items/macOS-X-images/Monterey%%2012.iso"
SET "Download.BigSur11=https://dn720604.ca.archive.org/0/items/macOS-X-images/Big%%20Sur%%2011.iso"
SET "Download.Ventura13=https://dn720604.ca.archive.org/0/items/macOS-X-images/Ventura%%2013.iso"
SET "Download.Lion10,7=https://dn720604.ca.archive.org/0/items/macOS-X-images/Lion%%2010.7.iso"
SET "Download.Sonoma14=https://ia800104.us.archive.org/1/items/macOS-X-images/Sonoma%%2014.iso"
:: Images range from "Mac OS X Lion 10.7" to "macOS Sonoma 14"
:: All these downloads are provided by @dinmik_ler on archive.org, thanks for that.

:: Set paths
SET "Path.aria2c=bin\aria2c.exe"
SET "Path.scripts=scripts\"
SET "Path.images=images\"
SET "Path.bin=bin\"
IF NOT DEFINED Path.VBoxManage (
    SET "Path.VBoxManage=%ProgramFiles%\Oracle\VirtualBox\VBoxManage.exe"
) ELSE (
    BREAK
)

GOTO :Ashrain.menu

:: Display the main menu
:Ashrain.menu
CALL :Function.clearscreen
CALL :Function.banner
ECHO ┌────────────────────┐                                                            
ECHO │  1. Guided Setup   │                                                            
ECHO │                    │                                                            
ECHO │  2. Manual Setup   │                                                            
ECHO │                    │                                                            
ECHO │  3. Install .ISO   │                                                            
ECHO │                    │                                                            
ECHO │  4. Exit Ashrain   │                                                            
ECHO │────────────────────│                                                            
ECHO │  5. Ashrain Info   │                                                            
ECHO │                    │                                                            
ECHO │   6. Licensing     │                                                            
ECHO │────────────────────┘ 
CHOICE /N /C 1234567 /M "└───── Choice: "

:: Check the users choice
IF %ERRORLEVEL% == 1 GOTO :Setup.guided
IF %ERRORLEVEL% == 2 GOTO :Setup.manual
IF %ERRORLEVEL% == 3 GOTO :Setup.installiso
IF %ERRORLEVEL% == 4 GOTO :Ashrain.exit
IF %ERRORLEVEL% == 5 GOTO :Ashrain.info
IF %ERRORLEVEL% == 6 GOTO :Ashrain.licensing
IF %ERRORLEVEL% == 7 GOTO :Ashrain.shell
GOTO :Error.setup

:: Run the guided setup
:Setup.guided
CALL :Function.clearscreen
CALL :Function.banner
ECHO ┌────────────────────┐ Welcome to the Ashrain Guided Setup!                                              
ECHO │    Guided Setup    │ Firstly, you must select a macOS version.                       
ECHO └────────────────────┘ Choose a macOS from the list to your liking!                  
CALL :Function.oslist
SET /P "Choice.os=└─────── Please enter the version number: "

IF "%Choice.os%"=="10.7"  SET "Choice.os.selected=[92mMac OS X Lion 10.7[0m" &&           SET "Setup.os.download=10,7"
IF "%Choice.os%"=="10.8"  SET "Choice.os.selected=[92mOS X Mountain Lion 10.8[0m" &&      SET "Setup.os.download=10,8"
IF "%Choice.os%"=="10.10" SET "Choice.os.selected=[92mOS X Yosemite 10.10[0m" &&          SET "Setup.os.download=10,10"
IF "%Choice.os%"=="10.11" SET "Choice.os.selected=[92mOS X El Capitan 10.11[0m" &&        SET "Setup.os.download=10,11"
IF "%Choice.os%"=="10.12" SET "Choice.os.selected=[38;5;46mmacOS Sierra 10.12[0m" &&      SET "Setup.os.download=10,12"
IF "%Choice.os%"=="10.13" SET "Choice.os.selected=[38;5;46mmacOS High Sierra 10.13[0m" && SET "Setup.os.download=10,13"
IF "%Choice.os%"=="10.14" SET "Choice.os.selected=[38;5;46mmacOS Mojave 10.14[0m" &&      SET "Setup.os.download=10,14"
IF "%Choice.os%"=="10.15" SET "Choice.os.selected=[32mmacOS Catalina 10.15[0m" &&         SET "Setup.os.download=10,15"
IF "%Choice.os%"=="11"    SET "Choice.os.selected=[33mmacOS Big Sur 11[0m" &&             SET "Setup.os.download=11"
IF "%Choice.os%"=="12"    SET "Choice.os.selected=[38;5;208mmacOS Monterey 12[0m" &&      SET "Setup.os.download=12"
IF "%Choice.os%"=="13"    SET "Choice.os.selected=[31mmacOS Ventura 13[0m" &&             SET "Setup.os.download=13"
IF "%Choice.os%"=="14"    SET "Choice.os.selected=[91mmacOS Sonoma 14[0m" &&              SET "Setup.os.download=14"
CHOICE /N /C YN /M "└─────── Are you sure to download %Choice.os.selected% (Y/n): "

IF %ERRORLEVEL% == 1 GOTO :Setup.guided.download
IF %ERRORLEVEL% == 2 GOTO :Setup.guided

:: Download the image file
:Setup.guided.download
CALL :Function.clearscreen
CALL :Function.banner
ECHO ┌────────────────────┐  Please wait while Ashrain is downloading the required image file.
ECHO │    Guided Setup    │  The rest of the process is automated by Ashrain.                  
ECHO └────────────────────┘  Note: This might take a while depending on your internet and storage speed.                                   
ECHO ┌──────────────────────────────────────────────┐                                                                  
ECHO │            Ashrain Process Log               │                                                                  
ECHO └──────────────────────────────────────────────┘                                                                  
:: Check internet connection
ECHO [[38;5;46mEXECUTE[0m] PING archive.org -n 5
PING archive.org -n 5 >NUL
IF %ERRORLEVEL% NEQ 0 CALL :Error.internetconnection
ECHO.
ECHO [[94mINFO[0m] Internet connection test successful
ECHO.

:: Download the wanted OS using aria2c
ECHO [[38;5;46mEXECUTE[0m] Downloading required image...
ECHO.
IF "%Setup.os.download%" == "10,7" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%MacOSXLion10,7.iso" "%Download.Lion10,7%"   
IF "%Setup.os.download%" == "10,8" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%OSXMountainLion10,8.iso" "%Download.MountainLion10,8%"
IF "%Setup.os.download%" == "10,10" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%OSXYoseMite10,10.iso" "%Download.Yosemite10,10%"
IF "%Setup.os.download%" == "10,11" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%OSXElCapitan10,11.iso" "%Download.ElCapitan10,11%"
IF "%Setup.os.download%" == "10,12" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%macOSSierra10,12.iso" "%Download.Sierra10,12%"
IF "%Setup.os.download%" == "10,13" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%macOSHighSierra10,13.iso" "%Download.HighSierra10,13%"
IF "%Setup.os.download%" == "10,14" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%macOSMojave10,14.iso" "%Download.Mojave10,14%"
IF "%Setup.os.download%" == "10,15" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%macOSCatalina10,15.iso" "%Download.Catalina10,15%"
IF "%Setup.os.download%" == "11" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%macOSBigSur11.iso" "%Download.BigSur11%"
IF "%Setup.os.download%" == "12" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%macOSMonterey12.iso" "%Download.Monterey12%"
IF "%Setup.os.download%" == "13" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%macOSVentura13.iso" "%Download.Ventura13%"
IF "%Setup.os.download%" == "14" "%Path.aria2c%" -x 16 -s 16 --check-certificate=false -o "%Path.images%macOSSonoma14.iso" "%Download.Sonoma14%"

:: -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:: Function block (Put all functions in this section)
:Function.banner
ECHO [38;2;255;0;0m┌[38;2;255;56;0m─[38;2;255;113;0m─[38;2;255;169;0m─[38;2;255;225;0m─[38;2;228;255;0m─[38;2;172;255;0m─[38;2;116;255;0m─[38;2;60;255;0m─[38;2;3;255;0m─[38;2;0;255;53m─[38;2;0;255;109m─[38;2;0;255;166m─[38;2;0;255;222m─[38;2;0;232;255m─[38;2;0;175;255m─[38;2;0;119;255m─[38;2;0;63;255m─[38;2;0;7;255m─[38;2;50;0;255m─[38;2;106;0;255m─[38;2;162;0;255m┐[0m ┌──────────────────────┐ 
ECHO [38;2;255;56;0m│[38;2;255;113;0m [38;2;255;169;0m [38;2;255;225;0m [38;2;228;255;0m [38;2;172;255;0m [38;2;116;255;0m [38;2;60;255;0m [38;2;3;255;0m [38;2;0;255;53m [38;2;0;255;109m [38;2;0;255;166m [38;2;0;255;222m [38;2;0;232;255m [38;2;0;175;255m [38;2;0;119;255m [38;2;0;63;255m [38;2;0;7;255m [38;2;50;0;255m [38;2;106;0;255m [38;2;162;255m [38;2;219;0;255m│[0m │                      │      
ECHO [38;2;255;113;0m│[38;2;255;169;0m [0;1m %Ashrain.version% [38;2;162;0;255m [38;2;255;0;235m│[0m │ (C) 2026 %Ashrain.author% │  
ECHO [38;2;255;169;0m│[38;2;255;225;0m [38;2;228;255;0m [38;2;172;255;0m [38;2;116;255;0m [38;2;60;255;0m [38;2;3;255;0m [38;2;0;255;53m [38;2;0;255;109m [38;2;0;255;166m [38;2;0;255;222m [38;2;0;232;255m [38;2;0;175;255m [38;2;0;119;255m [38;2;0;63;255m [38;2;0;7;255m [38;2;50;0;255m [38;2;106;0;255m [38;2;162;0;255m [38;2;219;0;255m [38;2;255;0;235m [38;2;255;0;179m│[0m │                      │   
ECHO [38;2;255;225;0m└[38;2;228;255;0m─[38;2;172;255;0m─[38;2;116;255;0m─[38;2;60;255;0m─[38;2;3;255;0m─[38;2;0;255;53m─[38;2;0;255;109m─[38;2;0;255;166m─[38;2;0;255;222m─[38;2;0;232;255m─[38;2;0;175;255m─[38;2;0;119;255m─[38;2;0;63;255m─[38;2;0;7;255m─[38;2;50;0;255m─[38;2;106;0;255m─[38;2;162;0;255m─[38;2;219;0;255m─[38;2;255;0;235m─[38;2;255;0;179m─[38;2;255;0;122m┘[0m └──────────────────────┘   
GOTO :EOF

:Function.oslist
TYPE "%Path.bin%oslist.txt"
GOTO :EOF

:Function.clearscreen
CLS
COLOR 0F
PING LOCALHOST -n 2 >NUL
GOTO :EOF             

:: Shell block (Put all shell functions in this section)
:Ashrain.shell
ECHO.
SET /P "Shell.input= %ashrain.user%/ashrain-# "
CALL :Shell.function.%Shell.input%
GOTO :Ashrain.shell

:Shell.function.Debug.variables
SET | findstr /L /B "Ashrain."
SET | findstr /L /B "Download."
SET | findstr /L /B "Path."
GOTO :EOF

:Shell.function.Setpath
SET /P "Shell.function.Setpath.Input=Variable: "
SET /P "Shell.function.Setpath.Output=%Shell.function.Setpath.Input% = "
SET "%Shell.function.Setpath.Input%=%Shell.function.Setpath.Output%"
GOTO :EOF

:Shell.function.Return
CALL :Function.clearscreen
GOTO :Ashrain.menu

:: GIT TEST

:: Error block (Put all errors in this section)