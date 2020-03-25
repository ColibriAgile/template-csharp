#ifndef AppVersion
  ; Parametros enviados no fechamento atraves do fabfile.py
  #define AppVersion "0.1"
  #define FileVersion "0.1.0.0"
  #define Year "2020"
#endif

#define ProjectName "%projeto%"
#define ncr_colibri "..\..\ncr-colibri\"
#define CommomISSDir ncr_colibri + "_build\"
#include CommomISSDir + "uninstall_reg.iss"  
#include CommomISSDir + "desinstalacao_controlada.iss"  
#include CommomISSDir + "pasta_ncrsolution.iss"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={code:GetAppId}
AppName={#ProjectName}
AppVersion={#AppVersion}
VersionInfoVersion={#FileVersion} 
AppPublisher=NCR Hospitality
AppCopyright=Copyright {#Year}
UninstallDisplayName=%projeto%
DefaultDirName={code:PastaNCRSolution|c:\NCR Solution}
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputDir=.\pacote
OutputBaseFilename={#ProjectName +'_'+ FileVersion}
Compression=lzma
SolidCompression=yes
CloseApplications=force
Uninstallable=false
UninstallFilesDir={app}\bin
UsePreviousLanguage=no
PrivilegesRequired=admin

[Languages]
Name: "br"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "es"; MessagesFile: "compiler:Languages\Spanish.isl"

[Files]
;Client
Source: "..\{#ProjectName}\bin\Release\*.*"; DestDir: "{app}\client\{#ProjectName}"; Flags: ignoreversion recursesubdirs; Excludes: "*.pdb"
;Server
;Source: "..\{#ProjectName}.Api\bin\Release\*.*"; DestDir: "{app}\nis\extensions\{#ProjectName}"; Flags: ignoreversion recursesubdirs; Excludes: "*.pdb"

[Code]
const
  APP_ID = '%app_id%';
{------------------------------------------------------------------------------}
function GetAppID(const X: string): string;
begin
  Result := APP_ID;
end;
{------------------------------------------------------------------------------}
function GetUninstallString: string;
begin
  Result := FindUninstallString ('{' + APP_ID + '_is1');
end;
{------------------------------------------------------------------------------}
function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  iResultCode: integer;
  sUnInstallString: string;
begin
  sUnInstallString := GetUninstallString();
  if sUnInstallString <> '' then
  begin
    sUnInstallString :=  RemoveQuotes(sUnInstallString);
    Exec(sUnInstallString, '/REMOVER /SILENT /VERYSILENT /SUPPRESSMSGBOXES /NORESTART', '', SW_HIDE, ewWaitUntilTerminated, iResultCode);
  end;
end;
{
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode : Integer;
begin
  if (CurStep = ssInstall)  then
  begin
    Log('** Parando Servico do NIS **');
    Exec('net', 'stop ncr_integration_service /y', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);    
  end
  else if (CurStep = ssDone) then
  begin
    Log('** Iniciando Servico do NIS **');
    Exec('net', 'start ncr_integration_service /y', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  end;
end;
}