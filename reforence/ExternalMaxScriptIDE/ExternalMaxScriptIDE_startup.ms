try(EMSIDEFunctions.CloseConnection())catch()
filein("$userScripts\\ExternalMaxScriptIDE\\ExternalMaxScriptIDE.ms")
EMSIDEFunctions.LoadSettings()
if(EMSIDESettings.RunOnStartUp == true)then(
	EMSIDEFunctions.OpenConnection()
)