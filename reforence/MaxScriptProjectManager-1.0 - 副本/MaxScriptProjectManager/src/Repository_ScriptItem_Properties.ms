m_DialogMaster.DialogMaster_DestroyDialog Project_Properties_Rollout
struct Repository_ScriptItem_Properties_System(
	m_ScriptItem,
	m_Repository,
	function Initiate=(
		
	),
	function ShowPropertiesOfScriptItem _repository _scriptItem=(
		m_ScriptItem = _scriptItem
		m_Repository = _repository
		m_DialogMaster.DialogMaster_CreateDialog Repository_ScriptItem_Properties_Rollout menu:RC_Repository_ScriptItem_Properties_Menu
		
	)
)
--PreDefine
m_Repository_ScriptItem_Properties_System = Repository_ScriptItem_Properties_System()


rcmenu RC_Repository_ScriptItem_Properties_Menu(
	submenu "File"(
		menuItem mi_Publish "Connect To MZP File..."
	)
	on mi_Publish picked do(
		Repository_ScriptItem_Properties_Rollout.HandleConnectToMZP()
	)
	
)

rollout Repository_ScriptItem_Properties_Rollout "Script Properties" width:400 height:300(
	local m_WindowSaver
	local m_UIMessage_Text_Message
	
	dotNetControl Text_Message "system.windows.forms.label"
	label lbl_Project_Name  ""
	dotNetControl Text_Properties "system.windows.forms.label" text:"Properties"
	edittext txt_name "Name" readonly:true
	edittext txt_version "Version"
	edittext txt_id "ID"
	edittext txt_md5 "MD5"
	edittext txt_changeList "Changelist"
	edittext txt_download "Download"
	
	label l6
	button btn_Save "Save" width:100 height:40 align:#right
	
	
	fn RefreshUIContent=(
		scriptItem = m_Repository_ScriptItem_Properties_System.m_ScriptItem
		txt_name.text = scriptItem.GetName()
		txt_version.text = scriptItem.GetVersion()
		txt_id.text = scriptItem.GetID()
		txt_md5.text = scriptItem.GetMD5()
		txt_changeList.text = scriptItem.GetChangeList()
		txt_download.text = scriptItem.GetDownload()
	)
	fn HandleMSPMExit _args=(
		destroyDialog Repository_ScriptItem_Properties_Rollout
	)
	
	on Repository_ScriptItem_Properties_Rollout open do(
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		(m_UIMaster.StyleLabelAsHeader Text_Properties)
		
		origPos = getdialogpos Repository_ScriptItem_Properties_Rollout
		origSize = getdialogsize Repository_ScriptItem_Properties_Rollout	
		
		m_WindowSaver = WindowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Repository_ScriptItem_Properties_Rollout applySize:false applyPosition:true	
		
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Repository_ScriptItem_Properties_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Repository_ScriptItem_Properties_Rollout.height/2)]
		setdialogpos Repository_ScriptItem_Properties_Rollout newPos
		
		
		project = m_Repository_ScriptItem_Properties_System.m_ScriptItem
		
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		(m_UIMaster.StyleLabelAsMessage Text_Message)
		
		RefreshUIContent()
		
	)
	on Repository_ScriptItem_Properties_Rollout close do(
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
		m_WindowSaver.onClose()
	)
	on Text_Message mouseClick _args do(
		m_UIMessage_Text_Message.onMouseClick _args
	)
	
	fn SaveData=(
		scriptItem = m_Repository_ScriptItem_Properties_System.m_ScriptItem
		
		scriptItem.SetName txt_name.text
		scriptItem.SetVersion txt_version.text
		scriptItem.SetID txt_id.text
		scriptItem.SetMD5 txt_md5.text
		scriptItem.SetChangeList txt_changeList.text
		scriptItem.SetDownload txt_download.text
		
		m_Repository_ScriptItem_Properties_System.m_Repository.Save()
		
-- 		m_UIMessage_Text_Message.SetMessage ("Project Properties Are Saved") style:true	
	)
	
	
	
	on btn_Save pressed do(
		SaveData()
		m_Repository_System.SendEvent "ScriptItemEdit"
		destroydialog Repository_ScriptItem_Properties_Rollout
	)
	
	fn HandleConnectToMZP=(
		scriptObj = m_Repository_ScriptItem_Properties_System.m_ScriptItem
			userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
			
			mzpPath = getOpenFileName caption:"Select MZP File:" types:"MZP (*.MZP)|*.mzp|All (*.*)|*.*|" filename:(userScriptFolder + @"MaxScriptProjectManager\publish\")
			if(mzpPath == undefined)then(
				return false
			)
			
			md5number = m_MZP_System.GetMd5FromMZPFilePath mzpPath
			scriptObj.SetMD5 md5number
-- 			m_Repository_Properties_System.m_Repository_Object.DeleteScriptItem scriptData[1] scriptData[2] scriptData[3]
		
			
			RefreshUIContent()	
	)
	
)

m_Repository_ScriptItem_Properties_System = Repository_ScriptItem_Properties_System()
m_Repository_ScriptItem_Properties_System.Initiate()

-- m_Repository_ScriptItem_Properties_System.ShowPropertiesOfScriptItem (m_MSPM_System.GetProjectByName "MaxScriptManager")
