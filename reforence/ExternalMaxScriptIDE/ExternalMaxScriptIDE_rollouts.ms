/*
Author Sven Fraeys
*/

try ( destroydialog ExternalMaxScriptIDE_Settings_Rollout) catch ( )
rollout ExternalMaxScriptIDE_Settings_Rollout "External MaxScript Settings" width:300(
	group "Options"(
		checkbox ch_OpenListenerOnError "Open Listener On Error"
		checkbox ch_ShowReceiverDialog "Show Receiver Dialog"
		button btn_Restart "Restart"
	)
	group "Message"(
		label lbl_message "" align:#left
	)
	on ch_ShowReceiverDialog changed _arg do(
		EMSIDEFunctions.ShowForm _arg
		EMSIDESettings.ShowReceiverDialog = ch_ShowReceiverDialog.checked
		lbl_message.text = "EMSIDESettings.ShowReceiverDialog = "+ (_arg as string)
	)
	on ch_OpenListenerOnError changed _arg do(
		lbl_message.text = "EMSIDESettings.OpenListenerOnError = "+ (_arg as string)
		EMSIDESettings.OpenListenerOnError = ch_OpenListenerOnError.checked
	)
	
	on ExternalMaxScriptIDE_Settings_Rollout open do (
		ch_OpenListenerOnError.checked = EMSIDESettings.OpenListenerOnError
		ch_ShowReceiverDialog.checked =  EMSIDESettings.ShowReceiverDialog
	)
	on ExternalMaxScriptIDE_Settings_Rollout close do (
		EMSIDEFunctions.SaveSettings()
	)
	on btn_Restart pressed do(
		
		EMSIDEFunctions.SaveSettings()
		EMSIDEFunctions.RestartConnection()
		lbl_message.text = "EMSIDEFunctions.RestartConnection()"
	)
)





