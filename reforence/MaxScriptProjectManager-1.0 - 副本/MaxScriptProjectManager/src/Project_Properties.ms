m_DialogMaster.DialogMaster_DestroyDialog Project_Properties_Rollout
struct Project_Properties_System(
	m_Project,
	function Initiate=(
		
	),
	function ShowPropertiesOfProject _project=(
		m_Project = _project
		m_DialogMaster.DialogMaster_CreateDialog Project_Properties_Rollout
		
	)
)
--PreDefine
m_Project_Properties_System = Project_Properties_System()


rollout Project_Properties_Rollout "Project Properties" width:400 height:380(
	local m_WindowSaver
	local m_UIMessage_Text_Message
	
	dotNetControl Text_Message "system.windows.forms.label"
	label lbl_Project_Name  ""
	dotNetControl Text_Properties "system.windows.forms.label" text:"Properties"
	edittext txt_name "Name" readOnly:true
	edittext txt_path "Path" readOnly:true
	edittext txt_location "Location" readOnly:true
	
	label l3 ""
	dotNetControl Text_AdditionalInformation "system.windows.forms.label" text:"Additional Information"
	
	edittext txt_category "Category"
	edittext txt_site "Site URL"
	edittext txt_donate "Donate URL"
	
	label l2 ""
	dotNetControl Text_AuthorProperties "system.windows.forms.label" text:"Author Properties"
	
	button btn_Author "Author Profile" across:2 height:30 align:#left offset:[15,5]
	label lbl_Author "" align:#left offset:[-80,13] 
	label l6
	button btn_Save "Save" width:100 height:40 align:#right
	
	on btn_Author pressed do(
		m_DialogMaster.DialogMaster_CreateDialog Author_Rollout
	)
	fn UpdateAuthorLabel _eventArg=(
		lbl_Author.text = m_Author_System.GetAsShortString()
	)
	
	fn HandleMSPMExit _args=(
		destroyDialog Project_Properties_Rollout
	)
	
	on Project_Properties_Rollout open do(
		
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		
		(m_UIMaster.StyleLabelAsHeader Text_AdditionalInformation)
		(m_UIMaster.StyleLabelAsHeader Text_AuthorProperties)
		(m_UIMaster.StyleLabelAsHeader Text_Properties)
		
		origPos = getdialogpos Project_Properties_Rollout
		origSize = getdialogsize Project_Properties_Rollout	
		
			
		m_WindowSaver = WindowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Project_Properties_Rollout applySize:false applyPosition:true	
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Project_Properties_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Project_Properties_Rollout.height/2)]
		setdialogpos Project_Properties_Rollout newPos
			
		project = m_Project_Properties_System.m_Project
		
		lbl_Project_Name.text = project.GetProjectName()
		
		txt_name.text = project.GetProjectName()
		txt_location.text  = project.GetProjectLocation()
		txt_path.text = project.GetPath()
		
		txt_site.text = project.GetSite()
		txt_donate.text = project.GetDonate()
		txt_category.text = project.GetCategory()
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		(m_UIMaster.StyleLabelAsMessage Text_Message)
		
		UpdateAuthorLabel 0
	)
	on Project_Properties_Rollout close do(
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
		m_WindowSaver.onClose()
	)
	on Text_Message mouseClick _args do(
		m_UIMessage_Text_Message.onMouseClick _args
	)
	fn SaveData=(
		project = m_Project_Properties_System.m_Project
		
		project.SetSite txt_site.text
		project.SetDonate txt_donate.text
		project.SetCategory txt_category.text
		
-- 		m_UIMessage_Text_Message.SetMessage ("Project Properties Are Saved") style:true	
	)
	
	on btn_Save pressed do(
		SaveData()
		m_MSPM_System.SendEventListener "ProjectEdit"
		destroydialog Project_Properties_Rollout
	)
	
	on btn_Publish pressed do(
		SaveData()
		_project = m_Project_Properties_System.m_Project
		m_Project_Publish_System.ShowPublishOfProject _project
	)
)

m_Project_Properties_System = Project_Properties_System()
m_Project_Properties_System.Initiate()

-- m_Project_Properties_System.ShowPropertiesOfProject (m_MSPM_System.GetProjectByName "MaxScriptManager")
