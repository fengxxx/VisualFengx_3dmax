m_DialogMaster.DialogMaster_DestroyDialog About_Rollout

rollout About_Rollout "About MSPM" width:300 height:145(
	label l3
	label l2 "MaxScript Project Manager 1.0 BETA" align:#center
	label l1 "by Sven Fraeys" align:#center
	hyperlink link_Home "http://sven.fraeys.be/" address:"http://sven.fraeys.be/" align:#center color: (color 0 0 255)
	label l4
	button btn_Close "Close" width:100 height:40 align:#right
	on btn_Close pressed do(
		destroydialog About_Rollout
	)
	fn HandleMSPMExit _args=(
		destroyDialog About_Rollout
	)
	on About_Rollout open do(
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
	)
	
	on About_Rollout close do(
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
	)
)
-- m_DialogMaster.DialogMaster_CreateDialog About_Rollout