m_DialogMaster.DialogMaster_DestroyDialog Project_Publish_Rollout

struct Project_Publish_System(
	function Initiate=(
		
	),
	function ShowPublishOfProject _project=(
		m_DialogMaster.DialogMaster_CreateDialog Project_Publish_Rollout
		Project_Publish_Rollout.SelectProjectInDropdownProjectByName (_project.GetProjectName())
		
	)
)



rollout Project_Publish_Rollout "Publish Project" width:500(
	local m_WindowSaver
	local m_MSFilesArr
	local m_ImgFilesArr
	local m_Project
	local m_HasMPMBool
	
	local m_UIMessage_Text_Message
	local m_NeedNewRepository

	dotNetControl Text_Message "system.windows.forms.label"
	
	dotNetControl Text_Project "system.windows.forms.label" text:"Project"
	dropdownlist dropdown_Project ""
	
	dotNetControl Text_Author "system.windows.forms.label" text:"Author Properties"
	button btn_Author "Author Properties" across:2 height:25
	label lbl_Author "" align:#left offset:[-50,3]
	label lbl_spcr2 ""
	local columnWidth = 200
	dotNetControl Text_ProjectProperties "system.windows.forms.label" text:"Project Properties"
	button btn_Project "Project Properties" across:2 height:25
	label lbl_Project "" align:#left offset:[-50,3]
	
	label lbl_spcr ""
	dotNetControl Text_InstallProperties "system.windows.forms.label" text:"Install Properties"
	dropdownlist dropdown_InstallerMS "Post Install Script" width:columnWidth
	
	dropdownlist dropdown_UninstallMS "Uninstall Script" width:columnWidth
	
	dropdownlist dropdown_InstallerImage "Installer Image" width:columnWidth
	label lbl_a ""
	button btn_Publish "Publish" width:100 height:40 across:3
	
	button btn_OpenFolder "Open Dir" width:30 height:40 images:#("images\\Totex_OpenFolder.bmp", undefined, 1,1,1,1,1 ) offset:[-90,0]

	button btn_Save "Close" width:100 height:40
	label lbl_l ""
	
	
	dotnetcontrol pictureBox_MPM_Logo "system.windows.forms.picturebox" pos:[0,0]
	
	checkbox ch_Enable_MSM "Enable MaxScript Manager"
	dotNetControl Text_MPM_Message "system.windows.forms.label" pos:[0,0] width:0 height:0 visible:false
	
	dropdownlist dropdown_MPM_Repository "" width:150 pos:[0,0]
	button btn_AddRepository "+" pos:[0,0]
	dropdownlist dropdown_MPM_Version "Version" width:70 pos:[0,0]
	
	button btn_AddUpgrade "+" pos:[0,0]
	
	
-- 	button btn_PublishFolder "Publish Folder"
	
-- 	dotNetControl TreeView_Project "system.windows.forms.treeView" height:600 across:2 width:200
	fn EnableMSMControls _state=(
		dropdown_MPM_Repository.enabled = _state
		if(dropdown_MPM_Version.items.count != 0)then(
			dropdown_MPM_Version.enabled = _state	
		)
		
		btn_AddRepository.enabled = _state
		btn_AddUpgrade.enabled = _state
	)
	
	fn FillInVersionDropdown=(
		repoObj = m_Repository_System.GetRepositoryBySlotInArr (dropdown_MPM_Repository.selection)
		if(repoObj == undefined)then(
			return false
		)
		versionArr = repoObj.GetScriptsVersionStrArr filter:m_Project
		dropdown_MPM_Version.items = versionArr
		if(versionArr.Count == 0)then(
			dropdown_MPM_Version.enabled = false
		)else(
			dropdown_MPM_Version.enabled = true
		)
		publishRepoVersion = m_Project.GetPublishRepositoryVersion()
		
		for i = 1 to dropdown_MPM_Version.items.count do(
			
			if(dropdown_MPM_Version.items[i] == publishRepoVersion)then(
				dropdown_MPM_Version.selection = i
			)	
		)
		if(dropdown_MPM_Version.items.count == 0)then(
			
		)
		
	)
	fn handleScriptItemEdit _args=(
		FillInVersionDropdown()
	)
	fn HandleNewScriptItem _args=(
		FillInVersionDropdown()
	)
	
	fn enableMPMControls _state=(
		
		dropdown_MPM_Repository.enabled = _state
		dropdown_MPM_Version.enabled = _state
		btn_AddUpgrade.enabled = _state
		btn_AddRepository.enabled = _state
	)
	
	fn FillInMaxScriptManagerSection=(
		publishRepositoryBool =  m_Project.GetPublishRepository()
		
		
		repoItems = m_Repository_System.GetRepositoriesAsNameStrArr()
		dropdown_MPM_Repository.items = repoItems
		
		publishRepoName = m_Project.GetPublishRepositoryName()
		for i = 1 to dropdown_MPM_Repository.items.count do(
			
			if(dropdown_MPM_Repository.items[i] == publishRepoName)then(
				dropdown_MPM_Repository.selection = i
			)
			
		)
		
		
		
		
		if(repoItems.Count == 0)then(
			dropdown_MPM_Repository.enabled = false
		)else(
			dropdown_MPM_Repository.enabled = true
		)
		
		FillInVersionDropdown()
		
		if(publishRepositoryBool == "true")then(
-- 			enableMPMControls true
			
		)else(
-- 			enableMPMControls false
		)
		if(dropdown_MPM_Version.items.count == 0)then(
			dropdown_MPM_Version.enabled = false
		)
		
		compatibleState = m_Project.GetMSMCompatible()
		if(compatibleState == "true")then(
			ch_Enable_MSM.checked = true
			EnableMSMControls true
		)else(
			ch_Enable_MSM.checked = false
			EnableMSMControls false
		)
		
	)
	fn UpdateMPMPart _arg=(
		FillInMaxScriptManagerSection()
	)
	fn FillInDropdownInstallerMS=(
		dropdown_Project.items = (m_MSPM_System.GetProjectsNameArr())
		proj = m_MSPM_System.GetProjectByName dropdown_Project.selected
		
		if(proj == undefined)then(
			return false
		)
		m_Project = proj
			
		FillInMaxScriptManagerSection()
		
		m_MSFilesArr = proj.GetProjectFilesFilePathAsArr Type:".ms"
		m_ImgFilesArr = proj.GetProjectFilesFilePathAsArr Type:#(".bmp",".png",".jpeg",".jpg")
		
		if(m_MSFilesArr.count == 0)then(
			btn_Publish.enabled = false
		)else(
			btn_Publish.enabled = true
		)
		
		wantedSlot = 1
		for i = 1 to m_MSFilesArr.count do(
			pathStr = m_MSFilesArr[i]
			if(pathStr == m_Project.GetInstallerMS() )then(
				wantedSlot = i
			)
		)
		
		wantedSlotImage = 1
		
		for i = 1 to m_ImgFilesArr.count do(
			pathStr = m_ImgFilesArr[i]
			if(pathStr == m_Project.GetInstallerImage() )then(
				wantedSlotImage = (i+1)
			)
		)
		
		wantedUninstallSlot = 1
		
		for i = 1 to m_MSFilesArr.count do(
			pathStr = m_MSFilesArr[i]
			if(pathStr == m_Project.GetUninstallMS() )then(
				wantedUninstallSlot = (i + 1)
			)
		)
		
		InstallerImageItemsArr = #("<Default Template Image>")
		join InstallerImageItemsArr (m_MSPM_System.GetFileNameFromPathArrStringAsArray m_ImgFilesArr)
		
		dropdown_InstallerImage.items = InstallerImageItemsArr
		dropdown_InstallerImage.selection = wantedSlotImage
		dropdown_InstallerMS.items = (m_MSPM_System.GetFileNameFromPathArrStringAsArray m_MSFilesArr)
		dropdown_InstallerMS.selection = wantedSlot
		
		UninstallMSItemsArr = #("<Default Template Uninstall>")
		join UninstallMSItemsArr (m_MSPM_System.GetFileNameFromPathArrStringAsArray m_MSFilesArr)
		dropdown_UninstallMS.items = UninstallMSItemsArr
		dropdown_UninstallMS.selection = wantedUninstallSlot
		
		
		UpdateMPMPart ""
	)
	
	on btn_OpenFolder pressed do(
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		PublishDirectory = userScriptFolder + @"MaxScriptProjectManager\publish\"
		m_MSPM_System.ShowInExplorer PublishDirectory
	)
	
	on btn_Author pressed do(
		m_DialogMaster.DialogMaster_CreateDialog Author_Rollout
	)
	
	on Text_Message mouseClick _args do(
		m_UIMessage_Text_Message.onMouseClick _args
	)
	
	on btn_Project pressed do(
		m_Project_Properties_System.ShowPropertiesOfProject (m_MSPM_System.GetProjectByName dropdown_Project.items[dropdown_Project.selection])
	)
	
	on ch_Enable_MSM changed _state do(
		EnableMSMControls _state
	)

	function StartPublishProjectMSMCompatible=(
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		if((dropdown_MPM_Repository.selection != 0) and (dropdown_MPM_Version.selection != 0))then(
			--GetRepository
			repoObj = (m_Repository_System.GetRepositoryBySlotInArr dropdown_MPM_Repository.selection)
			--GetScriptObj
			
			scriptObj = repoObj.GetScriptFromNameVersion (m_Project.GetProjectName()) (dropdown_MPM_Version.selected)
				
			--Transferring Data to ScriptItemObject
			scriptObj.FetchDataFromProject m_Project
			scriptObj.FetchDownloadURLFromRepositoryObject repoObj
			--Save Data
			repoObj.Save()
			--Create the MZP
			md5Hash = m_MZP_System.CreateMZP (m_Project.GetPath()) (userScriptFolder + @"MaxScriptProjectManager\publish\") version:(dropdown_MPM_Version.selected) repositoryUrl:(repoObj.GetURL()) scriptID:(scriptObj.GetID())
			scriptObj.SetMD5 md5Hash	
			repoObj.Save()
			--Create the Repository
			if(ch_Enable_MSM.checked == true)then(
				m_Repository_System.PublishRepository repoObj (userScriptFolder + @"MaxScriptProjectManager\publish\")
			)
			
			return true
		)else(
			return false
-- 			m_MZP_System.CreateMZP (m_Project.GetPath()) (userScriptFolder + @"MaxScriptProjectManager\publish\")
		)
	)
	
	function StartPublishProjectNoMSM=(
		md5Hash = m_MZP_System.CreateMZP (m_Project.GetPath()) (userScriptFolder + @"MaxScriptProjectManager\publish\") version:undefined repositoryUrl:undefined scriptID:undefined
		return true
	)
	
	function StartPublishProjectFromSelectedProject=(
		isMSMCompatible = ch_Enable_MSM.checked
		
		if(isMSMCompatible)then(
			res = StartPublishProjectMSMCompatible()
			return res
		)else(
			res = StartPublishProjectNoMSM()
			return res
		)
-- 			m_MZP_System.CreateMZP (m_Project.GetPath()) (userScriptFolder + @"MaxScriptProjectManager\publish\")
		
		
	)
	
	function SaveSettings=(
		if((dropdown_InstallerImage.selection) == 1)then(
			m_Project.SetInstallerImage ""
		)else(
			m_Project.SetInstallerImage (m_ImgFilesArr[(dropdown_InstallerImage.selection) - 1])
		)
		
		if((dropdown_UninstallMS.selection) == 1)then(
			m_Project.SetUninstallMS ""
		)else(
			m_Project.SetUninstallMS (m_MSFilesArr[(dropdown_UninstallMS.selection) - 1])
		)
		m_Project.SetPublishRepositoryVersion(dropdown_MPM_Version.selected)
		
		m_Project.SetPublishRepositoryName(dropdown_MPM_Repository.selected)
		
		m_Project.SetMSMCompatible(ch_Enable_MSM.checked as string)
-- 		m_Project.SetPublishRepository(checkbox_PublishRepository.checked as string)
		
		m_Project.SetInstallerMS m_MSFilesArr[dropdown_InstallerMS.selection]
	)
	
	on btn_Save pressed do(
		SaveSettings()
		m_UIMessage_Text_Message.SetMessage ("'"+(dropdown_Project.items[dropdown_Project.selection])+"' Settings Are Saved") style:true	
		destroydialog Project_Publish_Rollout
	)
	
	on btn_Publish pressed do(
		SaveSettings()
		
		
		res = StartPublishProjectFromSelectedProject()
		
		if(res == true)then(
			userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
			m_UIMessage_Text_Message.SetMessage ("'"+(dropdown_Project.items[dropdown_Project.selection])+"' Has Been Published Successful To MZP") style:true	
			m_MSPM_System.ShowInExplorer (userScriptFolder + @"MaxScriptProjectManager\publish\")	
		)else(
			m_UIMessage_Text_Message.SetMessage ("'"+(dropdown_Project.items[dropdown_Project.selection])+"' could not be published. Make a version slot in the Repository") style:false
		)
		
	)
	
	fn UpdateAuthorLabel _eventArg=(
		lbl_Author.text = m_Author_System.GetAsShortString()
		
	)
	fn UpdateProjectLabel _eventArg=(
		lbl_Project.text = m_Project.GetProjectName() + " - " + m_Project.GetProjectLocation()
	)
	
	fn HandleMSPMExit _args=(
		destroyDialog Project_Publish_Rollout
	)
	
	on Project_Publish_Rollout open do(
		
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		
		btn_Author.pos.y = btn_Author.pos.y + 3
		lbl_Author.pos.y = lbl_Author.pos.y + 5
		
		btn_Project.pos.y = btn_Project.pos.y + 3
		lbl_Project.pos.y = lbl_Project.pos.y + 5
		
		MPM_Offset_X = 5
		MPM_Offset_Y = 17
		
		
		
		imageClass = dotnetclass "System.Drawing.Image"
		imageObj = imageClass.FromFile (userScriptFolder + @"MaxScriptProjectManager\src\images\MSPM_Publish.png")
		pictureBox_MPM_Logo.image = imageObj
		
		pictureBox_MPM_Logo.width = 189
		pictureBox_MPM_Logo.height=27
		pictureBox_MPM_Logo.pos = [270+MPM_Offset_X,220+MPM_Offset_Y]
		

		
		
		
		
		
		ch_Enable_MSM.pos = [270+MPM_Offset_X,250+MPM_Offset_Y]
		
		
		
		
		
		
		dropdown_MPM_Repository.pos = [270+MPM_Offset_X,270+MPM_Offset_Y]
		btn_AddRepository.pos = [430+MPM_Offset_X,270+MPM_Offset_Y]
		dropdown_MPM_Version.pos = [270+MPM_Offset_X,315+MPM_Offset_Y]
		btn_AddUpgrade.pos = [350+MPM_Offset_X,315+MPM_Offset_Y]
		
		
		(m_UIMaster.StyleLabelAsHeader Text_Project)
		(m_UIMaster.StyleLabelAsHeader Text_Author)
		(m_UIMaster.StyleLabelAsHeader Text_ProjectProperties)
		(m_UIMaster.StyleLabelAsHeader Text_InstallProperties)
		
		
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		(m_UIMaster.StyleLabelAsMessage Text_Message)
		
		m_MSFilesArr = #()
		
		origPos = getdialogpos Project_Publish_Rollout
		origSize = getdialogsize Project_Publish_Rollout	
		
		m_WindowSaver = WindowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Project_Publish_Rollout applySize:false applyPosition:true	
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Project_Publish_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Project_Publish_Rollout.height/2)]
		setdialogpos Project_Publish_Rollout newPos
		
		FillInDropdownInstallerMS()
		
		if(dropdown_Project.items.count == 0)then(
			btn_Publish.enabled = false
		)
		
		UpdateAuthorLabel 0
		UpdateProjectLabel 0
		m_Repository_System.addEventListener "ScriptItemEdit" handleScriptItemEdit
		m_Repository_System.AddEventListener "NewScriptItem" HandleNewScriptItem
		m_Repository_System.AddEventListener "DeleteScriptItem" HandleNewScriptItem
		m_MSPM_System.AddEventListener "ProjectEditRepositoryXMLDocument" UpdateMPMPart
		m_MSPM_System.AddEventListener "ProjectEditVersion" UpdateProjectLabel
		m_MSPM_System.AddEventListener "AuthorEdit" UpdateAuthorLabel
	)
-- 	
	on Project_Publish_Rollout close do(
		m_Repository_System.RemoveEventListener "ScriptItemEdit" handleScriptItemEdit
		m_Repository_System.RemoveEventListener "NewScriptItem" HandleNewScriptItem
		m_Repository_System.RemoveEventListener "DeleteScriptItem" HandleNewScriptItem
		m_MSPM_System.RemoveEventListener "ProjectEditRepositoryXMLDocument" UpdateMPMPart
		m_MSPM_System.RemoveEventListener "ProjectEditVersion" HandleProjectEditVersion
		m_MSPM_System.RemoveEventListener "AuthorEdit" UpdateAuthorLabel
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
		m_WindowSaver.onClose()
	)
	on dropdown_Project selected _arg do(
		
		FillInDropdownInstallerMS()
		UpdateProjectLabel 0
	)
	
	on btn_AddRepository pressed do(
		m_Repository_Manager_System.CreateDialog()
	)
	
	on pictureBox_MPM_Logo Click _args do(
		processClass = (dotnetclass "System.Diagnostics.Process")
		processClass.Start("http://www.norman3d.com/MaxScriptManager/");
	)
	
	on pictureBox_MPM_Logo MouseMove _args do(

		cursor = dotnetclass "system.windows.forms.cursors"
		
		pictureBox_MPM_Logo.Cursor.Current = cursor.hand
	)
	
	on btn_AddUpgrade pressed do(
		
		repoObj = m_Repository_System.GetRepositoryBySlotInArr (dropdown_MPM_Repository.selection)
		
		m_Repository_Properties_System.ShowRepository (repoObj.GetFilePath()) filter:m_Project
		
-- 		m_Repository_Properties.ShowRepositoriesOfProject m_Project new:m_NeedNewRepository
	)
	
	on dropdown_MPM_Repository selected  _arg do(
		FillInVersionDropdown()
	)
	
	fn SelectProjectInDropdownProjectByName _name=(
		for i = 1 to dropdown_Project.Items.count do(
			
			if(dropdown_Project.Items[i] == _name)then(
				dropdown_Project.selection = i
				FillInDropdownInstallerMS()
				UpdateAuthorLabel 0
				UpdateProjectLabel 0
				exit
			)
		)
		
	)
	
)



m_Project_Publish_System = Project_Publish_System()
Project_Publish_System.Initiate()


-- m_DialogMaster.DialogMaster_CreateDialog Project_Publish_Rollout