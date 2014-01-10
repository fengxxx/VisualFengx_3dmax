
/*
Author Sven Fraeys
*/

macroScript ExternalMaxScriptIDE_Connect
buttonText:"ExternalMaxScriptIDE_Connect"
category:"ExternalMaxScriptIDE"
(
	global EMSIDEFunctions
	if(ExternalMaxScriptIDE_Settings_Rollout == undefined)then(
		filein(@"$userScripts\ExternalMaxScriptIDE\ExternalMaxScriptIDE.ms")
	)
	EMSIDEFunctions.RestartConnection()	
	
)

macroScript ExternalMaxScriptIDE_Settings
buttonText:"ExternalMaxScriptIDE_Settings"
category:"ExternalMaxScriptIDE"
(
	
	global ExternalMaxScriptIDE_Settings_Rollout
	if(ExternalMaxScriptIDE_Settings_Rollout == undefined)then(
		filein(@"$userScripts\ExternalMaxScriptIDE\ExternalMaxScriptIDE.ms")
	)
	createdialog ExternalMaxScriptIDE_Settings_Rollout
)


filein("$userScripts\\ExternalMaxScriptIDE\\ExternalMaxScriptIDE_system.ms")
filein("$userScripts\\ExternalMaxScriptIDE\\ExternalMaxScriptIDE_rollouts.ms")