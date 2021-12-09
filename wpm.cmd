@echo off
echo Windows Package Manager version 0.1.5
echo Warning: Alpha State
if "%1"=="/i" goto install
if "%1"=="/install" goto install
if "%1"=="-i" goto install
if "%1"=="-install" goto install
if "%1"=="--i" goto install
if "%1"=="--install" goto install
if "%1"=="/r" goto remove
if "%1"=="/remove" goto remove
if "%1"=="-r" goto remove
if "%1"=="-remove" goto remove
if "%1"=="--r" goto remove
if "%1"=="--remove" goto remove
if "%1"=="/ri" goto reinstall
if "%1"=="/reinstall" goto reinstall
if "%1"=="-ri" goto reinstall
if "%1"=="-reinstall" goto reinstall
if "%1"=="--ri" goto reinstall
if "%1"=="--reinstall" goto reinstall
if "%1"=="/us" goto usage
if "%1"=="/usage" goto usage
if "%1"=="-us" goto usage
if "%1"=="-usage" goto usage
if "%1"=="--us" goto usage
if "%1"=="--usage" goto usage
if "%1"=="/?" goto usage
if "%1"=="-?" goto usage
if "%1"=="--?" goto usage
rem ADMIN COMMANDS: No appearance on usage
if "%1"=="/rel" goto release
if "%1"=="/release" goto release
if "%1"=="-rel" goto release
if "%1"=="-release" goto release
if "%1"=="--rel" goto release
if "%1"=="--release" goto release
if "%1"=="/push" goto push
if "%1"=="-push" goto push
if "%1"=="--push" goto push
goto usage

:usage
echo Usage:
echo /i: Install Packages
echo /r: Remove Packages
echo /ri: Reinstall Packages
echo /us or /?: Show Usage
echo You can use - or -- instead of /, or use full parameters like /install.
echo Example: wpm /i /us - Show usage of wpm /i
echo wpm /i gnumake - Install package gnumake
goto exit

:install
if "%2"=="" goto installusage
if "%2"=="/us" goto installusage
if "%2"=="/usage" goto installusage
if "%2"=="-us" goto installusage
if "%2"=="--usage" goto installusage
if "%2"=="/?" goto installusage
if "%2"=="-?" goto installusage
if "%2"=="--?" goto installusage
if "%3"=="" goto installlatest
goto installv

:installlatest
if exist C:\wpm\%2 goto alreadyexists
echo Downloading latest version of package %2
start /wait /min wget -P C:\wpm\%2 https://hye0ngit.github.io/wpm/packages/%2/%2-latest.tgz
echo Installing latest version of package %2
set wonlaedir=%cd%
cd C:\wpm\%2
tar -xzf C:\wpm\%2\%2-latest.tgz
del C:\wpm\%2\%2-latest.tgz
start /wait /min C:\wpm\%2\postscript.exe
echo Finished installing package %2
cd %wonlaedir%
goto exit

:installv
if exist C:\wpm\%2 goto alreadyexists
echo Downloading %3 version of package %2
start /wait /min wget -P C:\wpm\%2 https://hye0ngit.github.io/wpm/packages/%2/%2-%3.tgz
echo Installing %3 version of package %2
set wonlaedir=%cd%
cd C:\wpm\%2
tar -xzf C:\wpm\%2\%2-%3.tgz
del C:\wpm\%2\%2-%3.tgz
start /wait /min C:\wpm\%2\postscript.exe
echo Finished installing package %2 (version %3)
cd %wonlaedir%
goto exit

:installusage
echo Usage:
echo (package name): Install latest version of (package name) on your system
echo (package name) (version): Install (version) version of (package name) on your system
echo /us or /?: Show Usage
echo Example: wpm /i gnumake - Install package gnumake
echo wpm /i gnumake 4.3 - Install package gnumake (version 4.3)
goto exit

:alreadyexists
echo Package %2 already exists, skipping
echo Did you want to update the package? Use reinstall.
goto exit

:remove
if not exist C:\wpm\%2 goto nonexistent
if "%2"=="" goto removeusage
if "%2"=="/us" goto removeusage
if "%2"=="/usage" goto removeusage
if "%2"=="-us" goto removeusage
if "%2"=="--usage" goto removeusage
if "%2"=="/?" goto removeusage
if "%2"=="-?" goto removeusage
if "%2"=="--?" goto removeusage
echo Removing package %2
start /wait /min C:\wpm\%2\rmscript.exe
rd /s /q C:\wpm\%2
echo Finished removing package %2
goto exit

:removeusage
echo Usage:
echo (package name): Remove latest version of (package name) on your system
echo /us or /?: Show Usage
echo Example: wpm /r gnumake - Remove package gnumake
goto exit

:nonexistent
echo Package %2 not exists, skipping
goto exit

:reinstall
if "%2"=="" goto reinstallusage
if "%2"=="/us" goto reinstallusage
if "%2"=="/usage" goto reinstallusage
if "%2"=="-us" goto reinstallusage
if "%2"=="--usage" goto reinstallusage
if "%2"=="/?" goto reinstallusage
if "%2"=="-?" goto reinstallusage
if "%2"=="--?" goto reinstallusage
if "%3"=="" goto reinstalllatest
goto reinstallv

:reinstalllatest
echo Reinstalling package %2 to latest version
echo Removing package %2
start /wait /min C:\wpm\%2\rmscript.exe
rd /s /q C:\wpm\%2
echo Finished removing package %2
echo Downloading latest version of package %2
start /wait /min wget -P C:\wpm\%2 https://hye0ngit.github.io/wpm/packages/%2/%2-latest.tgz
echo Installing latest version of package %2
set wonlaedir=%cd%
cd C:\wpm\%2
tar -xzf C:\wpm\%2\%2-latest.tgz
del C:\wpm\%2\%2-latest.tgz
start C:\wpm\%2\postscript.exe
echo Finished installing package %2
cd %wonlaedir%
goto exit

:reinstallv
echo Reinstalling package %2 to version %3
echo Removing package %2
start /wait /min C:\wpm\%2\rmscript.exe
rd /s /q C:\wpm\%2
echo Finished removing package %2
echo Downloading %3 version of package %2
start /wait /min wget -P C:\wpm\%2 https://hye0ngit.github.io/wpm/packages/%2/%2-%3.tgz
echo Installing %3 version of package %2
set wonlaedir=%cd%
cd C:\wpm\%2
tar -xzf C:\wpm\%2\%2-%3.tgz
del C:\wpm\%2\%2-%3.tgz
start C:\wpm\%2\postscript.exe
echo Finished installing package %2 (version %3)
cd %wonlaedir%
goto exit

:reinstallusage
echo Usage:
echo (package name) (version): Reinstall (package name) to (version) version on your system
echo /us or /?: Show Usage
echo Example: wpm /ri gnumake 4.3 - Reinstall package gnumake to 4.3 version
goto exit

:release
if "%2"=="" goto releaseusage
if "%2"=="/us" goto releaseusage
if "%2"=="/usage" goto releaseusage
if "%2"=="-us" goto releaseusage
if "%2"=="--usage" goto releaseusage
if "%2"=="/?" goto releaseusage
if "%2"=="-?" goto releaseusage
if "%2"=="--?" goto releaseusage
if "%3"=="" goto releaseusage
if "%4"=="" goto releaseusage
set wonlaedir=%cd%
cd %userprofile%\Documents\GitHub\wpm
gh release create %3 -F %4 %5
cd %wonlaedir%
goto exit

:releaseusage
echo Usage:
echo (version) (release notes) (files): Create a release tagged (version) with (release notes) and (files)
echo Example: wpm /rel 0.0.0 relnotes-0.0.0.md wpm-0.0.0.tgz - Create a release tagged 0.0.0 with relnotes-0.0.0.md and wpm-0.0.0.tgz
goto exit

:push
if "%2"=="/us" goto pushusage
if "%2"=="/usage" goto pushusage
if "%2"=="-us" goto pushusage
if "%2"=="--usage" goto pushusage
if "%2"=="/?" goto pushusage
if "%2"=="-?" goto pushusage
if "%2"=="--?" goto pushusage
set wonlaedir=%cd%
cd %userprofile%\Documents\GitHub\wpm
git add *
git commit
git push origin main
cd %wonlaedir%
goto exit

:pushusage
echo Usage:
echo Just type wpm /push.
echo Example: wpm /push - Git pushes wpm
goto exit

:exit