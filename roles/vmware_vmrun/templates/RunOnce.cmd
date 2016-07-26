@echo off

rem Configure Powershell Remoting

powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
powershell E:\ConfigureRemotingForAnsible.ps1

rem Install 7zip
start /wait E:\7z1602-x64.exe /S /D=="C:\Program Files\7-Zip"

rem Install Chocolatey
c:
cd \Windows\Temp
mkdir chocolatey
cd chocolatey
"C:\Program Files\7-Zip\7z" x E:\chocolatey.0.9.10.3.nupkg
powershell tools\chocolateyInstall.ps1
cd ..
del /s /q chocolatey

rem Install VMware Tools

start /wait E:\vmware-tools-setup64.exe /s /v "/qn REBOOT=ReallySuppress"

rem Set IP address
call E:\SetIpAddress.bat

rem reboot
shutdown /r /t 0

