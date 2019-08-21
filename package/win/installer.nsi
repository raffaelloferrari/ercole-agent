; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Ercole Agent"
!define PRODUCT_VERSION "ERCOLE_VERSION"
!define PRODUCT_PUBLISHER "Sorint Lab"
!define PRODUCT_WEB_SITE "https://www.sorint.it"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "..\..\ercole-agent-setup-${PRODUCT_VERSION}.exe"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
#LoadPlugin "SimpleSC.dll"
InstallDir "C:\ErcoleAgent"
DirText "Setup will install $(^Name) in the following folder.$\r$\n$\r$\nTo install in a different folder, click Browse and select another folder."
LicenseText "If you accept all the terms of the agreement, choose I Agree to continue. You must accept the agreement to install $(^Name)."
LicenseData "..\..\LICENSE"
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "..\..\ercole-agent.exe"
  File "..\..\config.json"
  File /r "..\..\sql"
  SetOutPath "$INSTDIR\fetch"
  File /r "..\..\fetch\win.ps1"
  SimpleSC::InstallService "ErcoleAgent" "Ercole Agent" "16" "2" "$INSTDIR\ercole-agent.exe" "" "" ""
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
SectionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  SimpleSC::StopService "ErcoleAgent" 1 30
  SimpleSC::RemoveService "ErcoleAgent"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\ercole-agent.exe"
  Delete "$INSTDIR\config.json"
  Delete "$INSTDIR\sql\*.sql"
  Delete "$INSTDIR\fetch\win.ps1"
  RMDir "$INSTDIR\fetch"
  RMDir "$INSTDIR\sql"
  RMDir "$INSTDIR"
  SetAutoClose true
SectionEnd