m_DialogMaster.DialogMaster_DestroyDialog Project_Manager_Rollout

rcmenu RC_Project_Manager_Menu(
	submenu "File"(
		menuItem mi_NewProject "New Project..."
		menuItem mi_OpenProject "Open Project..."
	)
	submenu "Edit"(
		menuItem mi_Properties "Properties..."
		menuItem mi_Publish "Publish..."
		menuItem mi_ShowInExplorer "Show In Explorer"
		separator sep1
		menuItem mi_Remove "Remove From List"
	)
	
	
	
	on mi_NewProject picked do(
		m_DialogMaster.DialogMaster_CreateDialog Project_New_Rollout 
	)
	on mi_OpenProject picked do(
		m_DialogMaster.DialogMaster_CreateDialog Project_Add_Rollout 
	)
	
	on mi_ShowInExplorer picked do(
		Project_Manager_Rollout.ShowInExplorerOfSelectedProjectsInListView()
	)
	on mi_Properties picked do(
		Project_Manager_Rollout.ShowPropertiesOfSelectedProjectsInListView()
	)
	
	on mi_Remove picked do(
		Project_Manager_Rollout.RemoveProjectOfSelectedProjectsInListView()
	)
	
	on mi_Publish picked do(
		Project_Manager_Rollout.PublishProjectOfSelectedProjectsInListView()
	)
	
	on RC_Project_Manager_Menu open do(
		
	)
	
	fn RC_Project_Manager_Menu_Refresh _selectionCount=(
		if(_selectionCount == 0)then(
			mi_Properties.enabled = false
			mi_Publish.enabled = false
			mi_ShowInExplorer.enabled = false
			mi_Remove.enabled = false
			return false
		)
			mi_Properties.enabled = true
			mi_Publish.enabled = true
			mi_ShowInExplorer.enabled = true
			mi_Remove.enabled = true
			return true
	)
	
)

rcmenu RC_ProjectManager_ListviewWindow(
	
	menuItem mi_NewProject "New Project..."
	menuItem mi_OpenProject "Open Project..."
		
	
	
	on mi_NewProject picked do(
		m_DialogMaster.DialogMaster_CreateDialog Project_New_Rollout 
	)
	on mi_OpenProject picked do(
		m_DialogMaster.DialogMaster_CreateDialog Project_Add_Rollout 
	)
)

RCMenu RC_ProjectManager_ListviewItem(
	
	menuItem mi_Properties "Properties..."
	menuItem mi_Publish "Publish..."
	menuItem mi_ShowInExplorer "Show In Explorer"
	seperator sep1
	menuItem mi_Remove "Remove From List"
	
	
	on mi_ShowInExplorer picked do(
		Project_Manager_Rollout.ShowInExplorerOfSelectedProjectsInListView()
	)
	on mi_Properties picked do(
		Project_Manager_Rollout.ShowPropertiesOfSelectedProjectsInListView()
	)
	
	on mi_Remove picked do(
		Project_Manager_Rollout.RemoveProjectOfSelectedProjectsInListView()
	)
	
	on mi_Publish picked do(
		Project_Manager_Rollout.PublishProjectOfSelectedProjectsInListView()
	)
	
)

rollout Project_Manager_Rollout "Project Manager" height:500 width:500(
	local m_WindowSaver

	local m_TreeViewBrowser
	local m_UIMessage_Text_Message
	
	dotNetControl Text_Message "system.windows.forms.label"
	
	
	
	dotNetControl listView_Projects "System.Windows.Forms.ListView" height:420
	button btn_Close "Close" width:100 height:40 align:#right
	
	
	fn SetupListView=(
		listView_Projects.Clear()
-- 		listView_Projects.Clear()
		listView_Projects.fullRowSelect = true -- When item is clicked, all columns in that item are selected
		listView_Projects.gridLines = false-- turn off the grid lines
		listView_Projects.HideSelection=false -- When this ListView loses the focus, it will still show what's selected
		listView_Projects.BorderStyle=listView_Projects.BorderStyle.FixedSingle -- make the border a flat solid color instead of the Windows 3D look
		listView_Projects.HeaderStyle=listView_Projects.HeaderStyle.Nonclickable -- Flattens the headers a bit (although they're still somewhat 3D) and keeps them from being clickable 
		listView_Projects.backColor=listView_Projects.backColor.FromArgb 225 225 225 -- Soften the background intensity a bit
		
		listView_Projects.View = (dotNetClass "System.Windows.Forms.View").Details -- this is what allows the grid-like format to be used
		
		listView_Projects.Columns.add "Name" 150 -- create a couple of columns and optionally specify their width
		listView_Projects.Columns.add "Location" 80
		listView_Projects.Columns.add "Path" 240
		
	)
	
	
	fn AddProjectsToListView =(
		
		theRange=#()
-- 		theRange2=#()
		
		ProjectListviewDataArr = (m_MSPM_System.GetProjectsListviewArr() )
		for ProjectListviewData in ProjectListviewDataArr do(
			
			listviewItemObj = dotNetObject "System.Windows.Forms.ListViewItem" ProjectListviewData
			append theRange listviewItemObj
-- 			append theRange2 listviewItemObj
		)
		
		listView_Projects.Items.Clear()
		listView_Projects.Items.AddRange theRange
	)
	fn HandleMSPMProjectChange _eventArgs=(
		
		AddProjectsToListView()
	)
	
	fn PublishProjectOfSelectedProjectsInListView=(
		if(listView_Projects.selectedItems.Count == 0)then(
			return false
		)
		pathArrStr = #()
		
		for i = 0 to listView_Projects.selectedItems.Count-1 do(
			listViewItem = listView_Projects.selectedItems.Item[i]
			
			append pathArrStr (listViewItem.SubItems.Item[2].Text)

		)
		
		pathStr
-- 		m_DialogMaster.DialogMaster_CreateDialog Project_Publish_Rollout
		
		
		
		for projectPath in pathArrStr do(
			m_Project_Publish_System.ShowPublishOfProject (m_MSPM_System.GetProjectByPath projectPath)
			exit
		)
	)
	
	fn RemoveProjectOfSelectedProjectsInListView=(
		if(listView_Projects.selectedItems.Count == 0)then(
			return false
		)
		pathArrStr = #()
		
		for i = 0 to listView_Projects.selectedItems.Count-1 do(
			listViewItem = listView_Projects.selectedItems.Item[i]
			
			append pathArrStr (listViewItem.SubItems.Item[2].Text)
			-- path remove
		)
		
		pathStr
		for projectPath in pathArrStr do(
			m_MSPM_System.RemoveProjectByPath projectPath
			pathStr = projectPath
		)
		numProjects = pathArrStr.count
		if(numProjects == 1)then(
			stringArr = (filterstring pathStr "\\")
			labelString = stringArr[stringArr.count]
			
			m_UIMessage_Text_Message.SetMessage ("'"+(labelString)+"' Succesfully Removed From List") style:true	
		)
		if(numProjects > 1)then(
			m_UIMessage_Text_Message.SetMessage (""+(numProjects as string)+" Projects Succesfully Removed From List") style:true	
		)
	)
	
	on Text_Message mouseClick _args do(
		m_UIMessage_Text_Message.onMouseClick _args
	)
	
	fn ShowPopUpMenu=(
		if(listView_Projects.selectedItems.Count != 0)then(
			popupMenu RC_ProjectManager_ListviewItem	
		)else(
			popupMenu RC_ProjectManager_ListviewWindow	
		)
		
	)
	
	on listView_Projects MouseUp _args do(
		
		RC_Project_Manager_Menu.RC_Project_Manager_Menu_Refresh(listView_Projects.selectedItems.Count)
		
		if(_args.Button == _args.Button.Right)then(
			ShowPopUpMenu()
		)
	)
	
	fn ShowInExplorerOfSelectedProjectsInListView=(
		for i = 0 to listView_Projects.selectedItems.Count-1 do(
			listViewItem = listView_Projects.selectedItems.Item[i]
			
			projectPath = (listViewItem.SubItems.Item[2].Text)
			m_MSPM_System.ShowInExplorer projectPath
		)
	)
	
	fn ShowPropertiesOfSelectedProjectsInListView=(
		for i = 0 to listView_Projects.selectedItems.Count-1 do(
			listViewItem = listView_Projects.selectedItems.Item[i]
			
			projectPath = (listViewItem.SubItems.Item[2].Text)
			m_Project_Properties_System.ShowPropertiesOfProject (m_MSPM_System.GetProjectByPath projectPath)
			-- path remove
		)
	)
	
	on listView_Projects doubleclick _args do(
		ShowPropertiesOfSelectedProjectsInListView()
		
	)
	
	on btn_Close pressed do(
		destroydialog Project_Manager_Rollout
	)
	
	fn HandleProjectEditVersion _e=(
		AddProjectsToListView()
	)
	
	fn RefreshUIControls=(
		Text_Message.width = Project_Manager_Rollout.width - 20
		listView_Projects.width = Project_Manager_Rollout.width - 20
		listView_Projects.height = Project_Manager_Rollout.height - listView_Projects.pos.y - 60
		btn_Close.pos.y = Project_Manager_Rollout.height - 50
		btn_Close.pos.x = Project_Manager_Rollout.width - 110
	)
	
	fn HandleMSPMExit _args=(
		destroyDialog Project_Manager_Rollout
	)
	
	on Project_Manager_Rollout open do(
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		m_MSPM_System.AddEventListener "ProjectNew" HandleMSPMProjectChange
		m_MSPM_System.AddEventListener "ProjectAdd" HandleMSPMProjectChange
		m_MSPM_System.AddEventListener "ProjectRemove" HandleMSPMProjectChange
		SetupListView()
		AddProjectsToListView()
-- 		messagebox ((m_MSPM_System.GetProjectsListviewArr()) as string)
		
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		(m_UIMaster.StyleLabelAsMessage Text_Message)
		
		origPos = getdialogpos Project_Manager_Rollout
		origSize = getdialogsize Project_Manager_Rollout
		
		m_WindowSaver = windowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Project_Manager_Rollout applySize:true applyPosition:true
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Project_Manager_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Project_Manager_Rollout.height/2)]
		setdialogpos Project_Manager_Rollout newPos
		
		m_MSPM_System.AddEventListener "ProjectEditVersion" HandleProjectEditVersion
		
		RC_Project_Manager_Menu.RC_Project_Manager_Menu_Refresh(listView_Projects.selectedItems.Count)
	)

	on Project_Manager_Rollout resized _arg do(
		RefreshUIControls()
	)
	on Project_Manager_Rollout close do(
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
		m_MSPM_System.RemoveEventListener "ProjectNew" HandleMSPMProjectChange
		m_MSPM_System.RemoveEventListener "ProjectAdd" HandleMSPMProjectChange
		m_MSPM_System.RemoveEventListener "ProjectRemove" HandleMSPMProjectChange
		m_MSPM_System.RemoveEventListener "ProjectEditVersion" HandleProjectEditVersion
		m_WindowSaver.onClose()
	)
)

struct Project_Manager_System(
	function Initiate=(
		
	),
	function CreateDialog=(
		m_DialogMaster.DialogMaster_CreateDialog Project_Manager_Rollout menu:RC_Project_Manager_Menu style_resizing:true
	)
)
m_Project_Manager_System = Project_Manager_System()
m_Project_Manager_System.Initiate()
-- Project_Manager_System.CreateDialog()


