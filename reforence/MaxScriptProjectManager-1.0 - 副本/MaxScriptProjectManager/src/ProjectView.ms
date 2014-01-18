m_DialogMaster.DialogMaster_DestroyDialog MSPM_ProjectView_Rollout

rcmenu rc_ProjectView(
	
	subMenu "File"
	(
		menuItem mi_NewProject "New Project..."
		menuItem mi_AddProject "Open Project..."
		seperator mi_Seperator
		menuItem mi_ManageProjects "Manage Projects..."
		seperator mi_Seperator2
		menuItem mi_Exit "Exit MSPM"
	)
	subMenu "Edit"
	(
		menuItem mi_ProjectProperties "Project Properties..."
		seperator sep7
		menuItem mi_AuthorProperties "Author Profile..."
		seperator sep5
		menuItem mi_Templates "Templates"
		
	)
	subMenu "Publish"
	(
		menuItem mi_PublishProject "Publish Project..."
		menuItem mi_OpenPublishFolder "Open Publish Folder..."
	)
	subMenu "Tools"
	(
		menuItem mi_RepositoryManager "Repositories..."
		seperator sep6
		menuItem mi_MaxScriptListener "MaxScript Listener..."
		menuItem mi_MaxScriptEditor "MaxScript Editor..."
		
	)
	subMenu "Help"
	(
		menuItem mi_AboutMSPM "About MSPM..."
-- 		menuItem mi_ShowProjectfiles "Show MSPM Core Files"
	)
	
	on mi_RepositoryManager picked do(
		m_Repository_Manager_System.CreateDialog()
	)
	
	on mi_MaxScriptListener picked do(
		m_MaxScriptListenerMaster.Open()
	)
	
	on mi_MaxScriptEditor picked do(
		actionMan.executeAction 0 "40839"  -- MAX Script: MAXScript Editor
	)
	
	on mi_Templates picked do(
		_path = ((symbolicPaths.getPathValue("$userScripts")+"\\") + "MaxscriptProjectManager\\template\\")
		m_MSPM_System.ShowInExplorer _path
	)
	
	on mi_OpenPublishFolder picked do(
		_path = ((symbolicPaths.getPathValue("$userScripts")+"\\") + "MaxscriptProjectManager\\publish\\")
		m_MSPM_System.ShowInExplorer _path
	)
	
	
	on mi_Exit picked do(
		m_MSPM_System.ExitMSPM()
-- 		destroydialog MSPM_ProjectView_Rollout
	)
	
	on mi_AboutMSPM picked do(
-- 		m_MSPM_System.ShowInExplorer "http://sven.fraeys.be/"
		m_DialogMaster.DialogMaster_CreateDialog About_Rollout
	)
	
	on mi_ProjectProperties picked do(
		
		if(m_MSPM_SelectedPath == undefined or m_MSPM_SelectedPath == "")then(
			proj = m_MSPM_System.GetProjectFirstInArray()
			if(proj == undefined)then(
				return false
			)
			m_Project_Properties_System.ShowPropertiesOfProject proj
			return true
		)
		projectToOpen = m_MSPM_System.GetProjectByPath m_MSPM_SelectedPath
		if(projectToOpen == undefined)then(
			proj = m_MSPM_System.GetProjectFirstInArray()
			if(proj == undefined)then(
				return false
			)
			m_Project_Properties_System.ShowPropertiesOfProject proj
			return true
		)
		m_Project_Properties_System.ShowPropertiesOfProject (m_MSPM_System.GetProjectByPath m_MSPM_SelectedPath)
	)
	
	on mi_AuthorProperties picked do(
		m_DialogMaster.DialogMaster_CreateDialog Author_Rollout
	)
	
	on mi_AddProject picked do(
		m_Project_Add_System.CreateDialog_Project_Add_Rollout()
	)
	
	on mi_ManageProjects picked do(
		Project_Manager_System.CreateDialog()
	)
	
	on mi_NewProject picked do(
		m_DialogMaster.DialogMaster_CreateDialog Project_New_Rollout
	)
	
	on mi_PublishProject picked  do(
		if(m_MSPM_SelectedPath == undefined or m_MSPM_SelectedPath == "")then(
			proj = m_MSPM_System.GetProjectFirstInArray()
			if(proj == undefined)then(
				return false
			)
			
			m_Project_Publish_System.ShowPublishOfProject proj
			return true
		)
		projectToOpen = m_MSPM_System.GetProjectByPath m_MSPM_SelectedPath
		if(projectToOpen == undefined)then(
			proj = m_MSPM_System.GetProjectFirstInArray()
			if(proj == undefined)then(
				return false
			)
			m_Project_Publish_System.ShowPublishOfProject proj
			return true
		)
		m_Project_Publish_System.ShowPublishOfProject (m_MSPM_System.GetProjectByPath m_MSPM_SelectedPath)
		
		
-- 		m_DialogMaster.DialogMaster_CreateDialog Project_Publish_Rollout
	)
	
	fn rc_ProjectView_Refresh _count=(
		if(_count == 0)then(
			mi_ProjectProperties.enabled = false
			mi_PublishProject.enabled = false
			return false
		)
		mi_PublishProject.enabled = true
		mi_ProjectProperties.enabled = true
		return true
	)
)

rollout MSPM_ProjectView_Rollout "MSPM"(
	local m_ControlMaster
	local m_WindowSaver
	local m_UIMessage_Text_Message
	local m_TreeViewBrowser
	local m_RightClickEventArguments		-- TreeviewEventArguments 	:	Last node that has been rightclicked on, needed for rename
	
	local buttonWidth = 25
	button btn_ManageProjects "Manage" width:buttonWidth height:buttonWidth across:4 align:#left
	button btn_Listener "List" width:buttonWidth height:buttonWidth
	button btn_Editor "Edit" width:buttonWidth height:buttonWidth
	dotNetControl Text_Message "system.windows.forms.label" offset:[-8,5]
	
	dotNetControl TreeView_Project "system.windows.forms.treeView"
	dotNetControl TextBox_SearchField "system.windows.forms.textBox" visible:false
	
	fn RefreshUIControls=(
		Text_Message.width = MSPM_ProjectView_Rollout.width - 114
		TextBox_SearchField.width = MSPM_ProjectView_Rollout.width - 20
		
		TreeView_Project.width = MSPM_ProjectView_Rollout.width - 20
		TreeView_Project.height = MSPM_ProjectView_Rollout.height - TreeView_Project.pos.y - 20
	)
	
	fn SetMessageNewFolder _folderPath=(
		folderPiecesArr = (filterstring _folderPath "\\")
		lastDir = folderPiecesArr[folderPiecesArr.count]
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("New Folder Created In '"+lastDir+"'") style:true	
	)
	fn SetMessageNewMS _folderPath=(
		folderPiecesArr = (filterstring _folderPath "\\")
		lastDir = folderPiecesArr[folderPiecesArr.count]
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("File Created In '"+lastDir+"'") style:true	
	)	
	
	fn HandleCreateRefresh=(
		if(m_RightClickEventArguments.TreeViewBrowser_Location.m_Type == "DIR")then(
			m_RightClickEventArguments.TreeViewBrowser_Location.Refresh expandState:true
		)else(
			m_RightClickEventArguments.TreeViewBrowser_Location.RefreshParentNode expandState:true
		)
		
		
		
	)
	
	fn HandleCreateScriptFile=(
		m_MSPM_System.CreateNewMaxScriptFile (getFilenamePath MSPM_ProjectView_Rollout.m_RightClickEventArguments.FullPath) editFile:true
		HandleCreateRefresh()
		SetMessageNewMS (getFilenamePath MSPM_ProjectView_Rollout.m_RightClickEventArguments.FullPath)		
	)
	
	fn HandleCreateFolder=(
		m_MSPM_System.CreateNewFolder (getFilenamePath MSPM_ProjectView_Rollout.m_RightClickEventArguments.FullPath) editFile:true
		HandleCreateRefresh()
		SetMessageNewMS (getFilenamePath MSPM_ProjectView_Rollout.m_RightClickEventArguments.FullPath)
	)
	
	fn HandleCreateIniFile=(
		m_MSPM_System.CreateNewIni (getFilenamePath MSPM_ProjectView_Rollout.m_RightClickEventArguments.FullPath) editFile:true
		HandleCreateRefresh()
		SetMessageNewFolder (getFilenamePath MSPM_ProjectView_Rollout.m_RightClickEventArguments.FullPath)		
	)
	
	fn HandleCreateXMLFile=(
		m_MSPM_System.CreateNewXml (getFilenamePath MSPM_ProjectView_Rollout.m_RightClickEventArguments.FullPath) editFile:true
		HandleCreateRefresh()
		SetMessageNewMS (getFilenamePath MSPM_ProjectView_Rollout.m_RightClickEventArguments.FullPath)
	)
	
	fn HandleRightClickOnTreeViewWindow _args=(
		RCMenu rc_ProjectTreeviewWindow(
			menuItem mi_NewProject "New Project..."
			menuItem mi_AddProject "Open Project..."
			menuItem mi_ManageProjects "Manage Projects..."
			seperator sep1
			menuItem mi_Publish "Publish Project..."
			menuItem mi_Author "Author Profile..."
			
			on mi_AddProject picked do(
				m_Project_Add_System.CreateDialog_Project_Add_Rollout()
			)
	
			on mi_ManageProjects picked do(
				Project_Manager_System.CreateDialog()
			)
			
			on mi_NewProject picked do(
				m_DialogMaster.DialogMaster_CreateDialog Project_New_Rollout
			)
			
			on mi_Publish picked do(
				m_DialogMaster.DialogMaster_CreateDialog Project_Publish_Rollout
			)
			
			on mi_Author picked  do(
				m_DialogMaster.DialogMaster_CreateDialog Author_Rollout
			)
		)
		popUpMenu rc_ProjectTreeviewWindow
	)
	fn HandleRightClickOnNode _args=(
		m_RightClickEventArguments = _args
		global m_MSPM_SelectedPath = _args.FullPath
		if(_args.Type == "FILE")then(
			fileType = (getFilenameType m_MSPM_SelectedPath)
			if(fileType == ".ms")then(
				RCMenu locationRC(
					
					menuItem mi_NewMS "New Script"
					on mi_NewMS picked do(
						MSPM_ProjectView_Rollout.HandleCreateScriptFile()
					)
					menuItem mi_NewFolder "New Folder"
					on mi_NewFolder picked do(
						MSPM_ProjectView_Rollout.HandleCreateIniFile()
					)
					submenu "New"
					(
						menuItem mi_NewIni "New Ini"
						menuItem mi_NewXML "New Xml"
					)
					on mi_NewIni picked do(
						MSPM_ProjectView_Rollout.HandleCreateIniFile()
					)
					
					on mi_NewXML picked do(
						MSPM_ProjectView_Rollout.HandleCreateXMLFile()
					)
					seperator sep2
					menuItem mi_Edit "Edit"
					
					menuItem mi_Run "Run"
					menuItem mi_ShowInExplorer "Show In Explorer"
					seperator sep1
					menuItem mi_Rename "Rename"
					
					on mi_Rename picked do(
						(MSPM_ProjectView_Rollout.m_RightClickEventArguments.Node).BeginEdit()
					)
					
					menuItem mi_Delete "Delete"
					on mi_Delete picked do(
						(MSPM_ProjectView_Rollout.m_RightClickEventArguments.TreeViewBrowser_Location).Delete()
					)
					
					on mi_ShowInExplorer picked do(
						m_MSPM_System.ShowInExplorer (getFilenamePath  m_MSPM_SelectedPath)
					)
					
					on mi_Edit picked do(
						m_MSPM_System.EditMaxScriptFile m_MSPM_SelectedPath
					)
					
					
					
					on mi_Run picked do(
						m_MSPM_System.RunMaxScriptFile m_MSPM_SelectedPath
					)
				)
				popUpMenu locationRC
			)else(
				RCMenu locationRC(
					menuItem mi_NewMS "New Script"
					on mi_NewMS picked do(
						MSPM_ProjectView_Rollout.HandleCreateScriptFile()
					)
					menuItem mi_NewFolder "New Folder"
					on mi_NewFolder picked do(
						MSPM_ProjectView_Rollout.HandleCreateFolder()
					)
					submenu "New"
					(
						menuItem mi_NewIni "New Ini"
						menuItem mi_NewXML "New Xml"
					)
					on mi_NewIni picked do(
						MSPM_ProjectView_Rollout.HandleCreateIniFile()
					)
					
					on mi_NewXML picked do(
						MSPM_ProjectView_Rollout.HandleCreateXMLFile()
					)
					seperator sep2
					menuItem mi_Open "Open"
					menuItem mi_ShowInExplorer "Show In Explorer"
					separator sep1
					menuItem mi_Rename "Rename"
					
					on mi_Rename picked do(
						(MSPM_ProjectView_Rollout.m_RightClickEventArguments.Node).BeginEdit()
					)
					on mi_ShowInExplorer picked do(
						m_MSPM_System.ShowInExplorer (getFilenamePath  m_MSPM_SelectedPath)
					)
					
					on mi_Open picked do(
						m_MSPM_System.OpenFilePath (m_MSPM_SelectedPath)
					)
					
					menuItem mi_Delete "Delete"
					on mi_Delete picked do(
						(MSPM_ProjectView_Rollout.m_RightClickEventArguments.TreeViewBrowser_Location).Delete()
					)
				)
				popUpMenu locationRC
				
			)
			
			
		)
		if(_args.Type == "ROOT")then(
			RCMenu locationRC(
				menuItem mi_NewMS "New Script"
				on mi_NewMS picked do(
					MSPM_ProjectView_Rollout.HandleCreateScriptFile()
				)
				menuItem mi_NewFolder "New Folder"
					on mi_NewFolder picked do(
						MSPM_ProjectView_Rollout.HandleCreateFolder()
					)
					
					submenu "New"
					(
						menuItem mi_NewIni "New Ini"
						menuItem mi_NewXML "New Xml"
					)
					on mi_NewIni picked do(
						MSPM_ProjectView_Rollout.HandleCreateIniFile()
					)
					
					on mi_NewXML picked do(
						MSPM_ProjectView_Rollout.HandleCreateXMLFile()
					)
				seperator sep2
				
				menuItem mi_Properties "Properties"
				menuItem mi_PublishProject "Publish"
					
				
					
				menuItem mi_ShowInExplorer "Show In Explorer"
					on mi_ShowInExplorer picked do(
						m_MSPM_System.ShowInExplorer (getFilenamePath  m_MSPM_SelectedPath)
					)
				seperator sep1
				menuItem mi_RemoveProject "Remove From List"
				on mi_Properties picked do(
					m_Project_Properties_System.ShowPropertiesOfProject (m_MSPM_System.GetProjectByPath m_MSPM_SelectedPath)
				)
				on mi_PublishProject picked do(
					m_Project_Publish_System.ShowPublishOfProject (m_MSPM_System.GetProjectByPath m_MSPM_SelectedPath)
				)
				
				
				on mi_RemoveProject picked do(
					m_MSPM_SelectedPath
					
					m_MSPM_System.RemoveProjectByPath m_MSPM_SelectedPath
					
					stringArr = (filterstring m_MSPM_SelectedPath "\\")
					labelString = stringArr[stringArr.count]
					
					MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("'"+(labelString)+"' Succesfully Removed From List") style:true	
				)
			)
			popUpMenu locationRC			
		)
		if(_args.Type == "DIR")then(
			RCMenu locationRC(
				menuItem mi_NewMS "New Script"
				on mi_NewMS picked do(
					MSPM_ProjectView_Rollout.HandleCreateScriptFile()
				)
				menuItem mi_NewFolder "New Folder"
					on mi_NewFolder picked do(
						MSPM_ProjectView_Rollout.HandleCreateFolder()
					)
				submenu "New"
					(
						menuItem mi_NewIni "New Ini"
						menuItem mi_NewXML "New Xml"
					)
					on mi_NewIni picked do(
						MSPM_ProjectView_Rollout.HandleCreateIniFile()
					)
					
					on mi_NewXML picked do(
						MSPM_ProjectView_Rollout.HandleCreateXMLFile()
					)
				seperator sep2
				menuItem mi_ShowInExplorer "Show In Explorer"
					
				on mi_ShowInExplorer picked do(
					m_MSPM_System.ShowInExplorer m_MSPM_SelectedPath
				)
				seperator sep3
				menuItem mi_Rename "Rename"
					
					on mi_Rename picked do(
						(MSPM_ProjectView_Rollout.m_RightClickEventArguments.Node).BeginEdit()
					)
				menuItem mi_Delete "Delete"
					on mi_Delete picked do(
						(MSPM_ProjectView_Rollout.m_RightClickEventArguments.TreeViewBrowser_Location).Delete()
					)
			)	
			popUpMenu locationRC			
		)
		
		
		
	)
	fn HandleLeftClickOnNode _args=(
		m_RightClickEventArguments = _args
		global m_MSPM_SelectedPath = _args.FullPath
	)
	fn HandleRenameSuccess _args=(
		_args
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("'"+_args.Label+"' renamed") style:true
	)
	fn HandleRenameError _args=(
		_args
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("Could not Rename '"+_args.Label+"'") style:false	
	)
	fn HandleMouseUp _args=(
-- 		showproperties _args
		_nodeHitByMouse= TreeView_Project.GetNodeAt _args.X _args.Y
		
		if (_args.Button == _args.Button.Right )then(
			if(_nodeHitByMouse == undefined)then(
			HandleRightClickOnTreeViewWindow _args				
			)

		)
		
	)
	fn HandleMSPMNodeClick _args=(
		if (_args.OriginalEventArgument.Button == _args.OriginalEventArgument.Button.Right )then(
			HandleRightClickOnNode _args
		)
		if (_args.OriginalEventArgument.Button == _args.OriginalEventArgument.Button.Left )then(
			HandleLeftClickOnNode _args
		)
		
		
	)
	
	fn InitiateTreeview=(
		m_TreeViewBrowser = TreeViewBrowser()
		m_TreeViewBrowser.Initiate m_TreeViewBrowser TreeView_Project SaveExpandState:(symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\src\\expandState3.xml") EnableDoubleClickActions:true EnableRightClickActions:false EnableLabelEdit:true
		"$userScripts\\MaxScriptProjectManager\\src\\expandState.ini"
		
		url = (symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\src\\icons\\")
		m_TreeViewBrowser.AddImageList (url+"Icon_Folder.bmp") #(".")
		m_TreeViewBrowser.AddImageList (url+"Icon_Project.gif") #("ROOT")
		m_TreeViewBrowser.AddImageList (url+"Icon_MaxScript.gif") #(".ms",".mse")
		m_TreeViewBrowser.AddImageList (url+"mzp.png") #(".mzp")
		m_TreeViewBrowser.AddImageList (url+"xml.png") #(".xml")
		m_TreeViewBrowser.AddImageList (url+"ai.png") #(".ai")
		m_TreeViewBrowser.AddImageList (url+"psd.png") #(".psd")
		m_TreeViewBrowser.AddImageList (url+"xml.png") #(".xml")
		m_TreeViewBrowser.AddImageList (url+"ini.png") #(".ini")
		m_TreeViewBrowser.AddImageList (url+"img.png") #(".jpg",".jpeg",".png",".bmp",".gif",".jpe", ".tif")
		m_TreeViewBrowser.AddImageList (url+"pdf.png") #(".pdf")
		m_TreeViewBrowser.AddImageList (url+"msr.png") #(".msr")
		
		m_TreeViewBrowser.AddImageList (url+"Icon_Unknown.gif") #(".*")
		
		m_TreeViewBrowser.AddEventListener "NodeMouseClick" HandleMSPMNodeClick
		m_TreeViewBrowser.AddEventListener "RenameError" HandleRenameError
		m_TreeViewBrowser.AddEventListener "RenameSuccess" HandleRenameSuccess
		m_TreeViewBrowser.AddEventListener "MouseUp" HandleMouseUp
	)
	
	
	
	fn RefreshUIContent=(
		m_TreeViewBrowser.Clear()
		
		for pathStr in m_MSPM_System.GetProjectPathStringArr() do(
			m_TreeViewBrowser.AddLocation pathStr
		)
		
		m_TreeViewBrowser.Refresh()
		
		rc_ProjectView.rc_ProjectView_Refresh (TreeView_Project.Nodes.Count)
		
	)
	
	fn HandleMSPMAuthorEdit _args=(
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("Author Profile Edited") style:true	
	)
	
	fn HandleMSPMProjectEdit _args=(
		m_TreeViewBrowser.Save()
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("Project Properties Edited") style:true	
		RefreshUIContent()
	)
	
	fn HandleMSPMProjectAdd _args=(
		m_TreeViewBrowser.Save()
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("Project Added To List") style:true	
		RefreshUIContent()
		
		
		
	)
	fn HandleMSPMProjectRemove _args=(
		m_TreeViewBrowser.Save()
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("Project Removed") style:true	
		RefreshUIContent()
		
		
		
	)
	fn HandleMSPMProjectNew _args=(
		MSPM_ProjectView_Rollout.m_UIMessage_Text_Message.SetMessage ("Project Added") style:true	
		RefreshUIContent()
		
	)
	

	
	fn StyleTreeview=(
-- 		showproperties TreeView_Project
		TreeView_Project.ItemHeight = 17
	)
	
	fn HandleMSPMExit _args=(
		destroyDialog MSPM_ProjectView_Rollout
	)
	
	on MSPM_ProjectView_Rollout open do(
		
		m_UIMaster.ArrangeInRow #(btn_ManageProjects,btn_Editor,btn_Listener) distanceX:30 doX:true
		btn_ManageProjects.images = #("images/Icon_Project.gif", undefined, 1,1,1,1,1 )
		btn_Editor.images = #("images/Editor.bmp", undefined, 1,1,1,1,1 )
		btn_Listener.images = #("images/Listener.bmp", undefined, 1,1,1,1,1 )

		StyleTreeview()
		
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		m_MSPM_System.AddEventListener "ProjectAdd" HandleMSPMProjectAdd
		m_MSPM_System.AddEventListener "ProjectRemove" HandleMSPMProjectRemove
		m_MSPM_System.AddEventListener "ProjectNew" HandleMSPMProjectNew
		m_MSPM_System.AddEventListener "AuthorEdit" HandleMSPMAuthorEdit
		m_MSPM_System.AddEventListener "ProjectEdit" HandleMSPMProjectEdit
		
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		
		(m_UIMaster.StyleLabelAsMessage Text_Message)
		
		m_WindowSaver = WindowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") MSPM_ProjectView_Rollout
		InitiateTreeview()
		
		RefreshUIControls()
		RefreshUIContent()
		
		rc_ProjectView.rc_ProjectView_Refresh (TreeView_Project.Nodes.Count)
	)
	
	on Text_Message mouseClick _args do(
		m_UIMessage_Text_Message.onMouseClick _args
	)
	on btn_ManageProjects pressed do(
		Project_Manager_System.CreateDialog()
		
	)
	on btn_Listener pressed do(
		m_MaxScriptListenerMaster.Open()
	)
	
	on btn_Editor pressed do(
		actionMan.executeAction 0 "40839"  -- MAX Script: MAXScript Editor
	)
	
	on TextBox_SearchField KeyUp _e do(
		m_TreeViewBrowser.SearchNode_string TextBox_SearchField.text
	)
	
	on MSPM_ProjectView_Rollout resized _args do(
		RefreshUIControls()
	)
	
	on MSPM_ProjectView_Rollout close do(
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
		m_MSPM_System.RemoveEventListener "ProjectRemove" HandleMSPMProjectAdd
		m_MSPM_System.RemoveEventListener "ProjectAdd" HandleMSPMProjectAdd
		m_MSPM_System.RemoveEventListener "AuthorEdit" HandleMSPMAuthorEdit
		m_MSPM_System.RemoveEventListener "NodeMouseClick" HandleMSPMNodeClick
		m_MSPM_System.RemoveEventListener "ProjectEdit" HandleMSPMProjectEdit
		
		m_MSPM_System.RemoveEventListener "MouseUp" HandleMouseUp
		
		
		m_MSPM_System.ExitMSPM()
		
		m_WindowSaver.onClose()
		m_TreeViewBrowser.onClose()
	)
	
	on TreeView_Project AfterExpand _args do(
		m_TreeViewBrowser.AfterExpand _args
-- 		m_TreeViewBrowser.Close()
	)
	on TreeView_Project AfterCollapse _args do(
		m_TreeViewBrowser.AfterCollapse _args
	)
	on TreeView_Project DoubleClick _args do(
		
		m_TreeViewBrowser.DoubleClick _args
	)
	
	on TreeView_Project MouseUp _args do(
		
		m_TreeViewBrowser.MouseUp _args
-- 		m_TreeViewBrowser.NodeMouseClick _args
		
		rc_ProjectView.rc_ProjectView_Refresh (TreeView_Project.Nodes.Count)
	)
	
	on TreeView_Project NodeMouseClick _args do(
		m_TreeViewBrowser.NodeMouseClick _args
	)
	on TreeView_Project AfterLabelEdit _args do(
		m_TreeViewBrowser.AfterLabelEdit _args
	)
)

struct MSPM_ProjectView_System(
	function Initiate=(
		
	)
)




m_MSPM_ProjectView_System = MSPM_ProjectView_System()
m_MSPM_ProjectView_System.Initiate()

-- m_DialogMaster.DialogMaster_CreateDialog MSPM_ProjectView_Rollout menu:rc_ProjectView style_resizing:true