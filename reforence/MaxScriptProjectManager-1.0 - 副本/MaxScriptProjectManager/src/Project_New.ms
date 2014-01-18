m_DialogMaster.DialogMaster_DestroyDialog Project_New_Rollout

struct Project_New_System(
	function Initiate=(
		
	)
)

rollout Project_New_Rollout "Project New" width:400 height:150(
	local m_WindowSaver
	local m_UIMessage_Text_Message
	
	dotNetControl Text_Message "system.windows.forms.label"
	
	dropdownlist dropdown_Locations "" 
	edittext txt_Name "Name"
	label l1
	button btn_Create "Create" width:120 height:40 across:2
	button btn_EditTemplate "Edit Template" width:120 height:40 
	
	fn HandleMSPMExit _args=(
		destroyDialog Project_New_Rollout
	)
	
	on Project_New_Rollout open do(
		setFocus txt_Name
		
		origPos = getdialogpos Project_New_Rollout
		origSize = getdialogsize Project_New_Rollout
		
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		
		m_WindowSaver = WindowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Project_New_Rollout applySize:false applyPosition:true
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Project_New_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Project_New_Rollout.height/2)]
		setdialogpos Project_New_Rollout newPos
		
		dropdown_Locations.items = #("$UserScripts","$Scripts")
		
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		(m_UIMaster.StyleLabelAsMessage Text_Message)
	)
	
	on Project_New_Rollout close do(
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
		m_WindowSaver.onClose()
	)
	on btn_EditTemplate pressed do(
		_path = ((symbolicPaths.getPathValue("$userScripts")+"\\") + "MaxscriptProjectManager\\template\\PROJECT_Template\\")
		m_MSPM_System.ShowInExplorer _path
	)
	on btn_Create pressed do(
		
		newProjectPath = (symbolicPaths.getPathValue(dropdown_Locations.selected))+"\\"+txt_Name.text+"\\"
		if(txt_Name.text == "" or txt_Name.text == " " or txt_Name.text == "  ")then(
			m_UIMessage_Text_Message.SetMessage ("Could Not Create Project, No 'Project Name' Given") style:false	
			return false
		)
			
		res = (m_MSPM_System.NewProject newProjectPath)
		if(res == false)then(
			m_UIMessage_Text_Message.SetMessage ("Could Not Create Project, '"+txt_Name.text+"' Already Exists") style:false
			return false
		)
		
		destroydialog Project_New_Rollout
-- 		m_UIMessage_Text_Message.SetMessage ("Project '"+txt_Name.text+"' Created And Added To MSPM") style:true	
		
		
	)
	on Text_Message mouseClick _args do(
		m_UIMessage_Text_Message.onMouseClick _args
	)
	
	
	
)

-- m_DialogMaster.DialogMaster_CreateDialog Project_New_Rollout