m_DialogMaster.DialogMaster_DestroyDialog Repository_Download

rollout Repository_Download "Repository Download" height:60 width:400(
	local m_UIMessage_Text_Message
	dotNetControl Text_Message "system.windows.forms.label"
	label l1 "" offset:[-100,-15]
	edittext txt_url "URL" across:2 width:300 text:""
	button btn_Download "Download" align:#right
	
	on btn_Download pressed do(
		
		res = m_Repository_System.DownloadRepository txt_url.text
		if(res == undefined)then(
			m_UIMessage_Text_Message.SetMessage "Error : Could Not Find Repository" style:false
		)else(
			destroydialog Repository_Download
		)
	)
	
	fn HandleMSPMExit _args=(
		destroyDialog Repository_Download
	)
	
	on Repository_Download open do(
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		(m_UIMaster.StyleLabelAsMessage Text_Message)
		
		clipStr = getclipboardtext()
		hasHttp = findstring clipStr "http://"
		if(hasHttp != undefined)then(
			txt_url.text = clipStr
		)
		
	)
	
	on Repository_Download close do(
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
	)
)


