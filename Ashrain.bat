@ECHO OFF
CHCP 65001 >NUL
CLS
COLOR 0F

:: LIAM PFUNDT SOFTWARE IS NOT RESPONSIBLE FOR ANY DAMAGE TO YOUR PC NOR ACCIDENTAL LOSS OF FILES.
:: DON'T TAMPER WITH THE SOURCE FILES OF ASHRAIN AND FOLLOW THE LICENSE (..\copabanana_vbtxlicense.txt).
:: USE ASHRAIN WITH CAUTION ON YOUR OWN RISK.

:: Ashrain partly uses third-party software, here is what software and it's license are used an can be found:
:: bin\aria2c.exe -> ..\licenses\COPYING & ..\licenses\LICENSE.OpenSSL

:: Set basic variables
SET "Ashrain.Github=https://github.com/liampfundt/Ashrain"
SET "Ashrain.author=Liam Pfundt @ Liam Pfundt Software"
SET "Ashrain.support=liampfundtsoftware@gmail.com"
SET "Ashrain.version=Ashrain Twux 1.0"
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
SET "Path.VBoxManage=bin\VBoxManage.exe"
SET "Path.aria2c=bin\aria2c.exe"
SET "Path.scripts=scripts\"
SET "Path.images=images\"
SET "Path.bin=bin\"

GOTO :Ashrain.menu

:Ashrain.menu                                                                          
ECHO [38;2;255;0;0m┌[38;2;255;56;0m─[38;2;255;113;0m─[38;2;255;169;0m─[38;2;255;225;0m─[38;2;228;255;0m─[38;2;172;255;0m─[38;2;116;255;0m─[38;2;60;255;0m─[38;2;3;255;0m─[38;2;0;255;53m─[38;2;0;255;109m─[38;2;0;255;166m─[38;2;0;255;222m─[38;2;0;232;255m─[38;2;0;175;255m─[38;2;0;119;255m─[38;2;0;63;255m─[38;2;0;7;255m─[38;2;50;0;255m─[38;2;106;0;255m─[38;2;162;0;255m┐[0m
ECHO [38;2;255;56;0m│[38;2;255;113;0m [38;2;255;169;0m [38;2;255;225;0m [38;2;228;255;0m [38;2;172;255;0m [38;2;116;255;0m [38;2;60;255;0m [38;2;3;255;0m [38;2;0;255;53m [38;2;0;255;109m [38;2;0;255;166m [38;2;0;255;222m [38;2;0;232;255m [38;2;0;175;255m [38;2;0;119;255m [38;2;0;63;255m [38;2;0;7;255m [38;2;50;0;255m [38;2;106;0;255m [38;2;162;255m [38;2;219;0;255m│[0m
ECHO [38;2;255;113;0m│[38;2;255;169;0m [0;1m %Ashrain.version% [38;2;162;0;255m [38;2;255;0;235m│[0m
ECHO [38;2;255;169;0m│[38;2;255;225;0m [38;2;228;255;0m [38;2;172;255;0m [38;2;116;255;0m [38;2;60;255;0m [38;2;3;255;0m [38;2;0;255;53m [38;2;0;255;109m [38;2;0;255;166m [38;2;0;255;222m [38;2;0;232;255m [38;2;0;175;255m [38;2;0;119;255m [38;2;0;63;255m [38;2;0;7;255m [38;2;50;0;255m [38;2;106;0;255m [38;2;162;0;255m [38;2;219;0;255m [38;2;255;0;235m [38;2;255;0;179m│[0m
ECHO [38;2;255;225;0m└[38;2;228;255;0m─[38;2;172;255;0m─[38;2;116;255;0m─[38;2;60;255;0m─[38;2;3;255;0m─[38;2;0;255;53m─[38;2;0;255;109m─[38;2;0;255;166m─[38;2;0;255;222m─[38;2;0;232;255m─[38;2;0;175;255m─[38;2;0;119;255m─[38;2;0;63;255m─[38;2;0;7;255m─[38;2;50;0;255m─[38;2;106;0;255m─[38;2;162;0;255m─[38;2;219;0;255m─[38;2;255;0;235m─[38;2;255;0;179m─[38;2;255;0;122m┘[0m
pause>NUL







































:Guided_setup











Pause
exit /b