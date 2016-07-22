@echo off

rem Configure Powershell Remoting

powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
powershell E:\ConfigureRemotingForAnsible.ps1
powershell Set-ExecutionPolicy -ExecutionPolicy Default -Force

rem Install VMware Tools

start /wait E:\vmware-tools-setup64.exe /s /v "/qn REBOOT=ReallySuppress"

rem Set IP address
call E:\SetIpAddress.bat

rem reboot
shutdown /r /t 0

