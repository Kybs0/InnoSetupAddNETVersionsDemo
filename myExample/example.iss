; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "WpfApp1"
#define MyAppVersion "1.5"
#define MyAppPublisher "My Company, Inc."
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "WpfApp1.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A0562DC0-AA9D-4387-A9E7-1C4D873925CC}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=output
OutputBaseFilename=mysetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern

//import dependency for .net
//isxdl operation  
#include "dependency\isxdl.iss"
//;TYPES AND VARIABLES
#include "dependency\products.pas"
//about .net versions
#include "dependency\dotnetfxversion.iss"

//add .net4.5
#include "dependency\.net versions installation\dotnetfx45.iss" 
#include "dependency\.net versions installation\dotnetfx46.iss"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "dependency\isxdl.dll"; Flags: dontcopy noencryption
Source: "myProgram\WpfApp1.exe"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[CustomMessages]
DependenciesDir=MyProgramDependencies
WindowsServicePack=Windows %1 Service Pack %2
//固定英文安装语言
lcid=1033
depdownload_memo_title=Download dependencies
depinstall_memo_title=Install dependencies
depinstall_title=Installing dependencies
depinstall_description=Please wait while Setup installs dependencies on your computer.
depinstall_status=Installing %1...
depinstall_missing=%1 must be installed before setup can continue. Please install %1 and run Setup again.
depinstall_error=An error occured while installing the dependencies. Please restart the computer and run the setup again or install the following dependencies manually:%n
isxdl_langfile=""

[Code]
function InitializeSetup(): Boolean;
begin
	dotnetfx45(50); // install if version < 4.5.0
	dotnetfx46(60); // install if version < 4.6.0
	Result := true;
end;