m_DialogMaster.DialogMaster_DestroyDialog Repository_Manager_Rollout

rcmenu RC_Repository_Manager_RightClick_ListViewEmpty(
	menuItem mi_NewRepository "New Repository..."
		seperator s2
		menuItem mi_Refresh "Refresh"
	
	on mi_Refresh picked do(
		Repository_Manager_Rollout.HandleRefresh()
	)
	on mi_NewRepository picked do(
		Repository_Manager_Rollout.HandleNewRepository()
	)
)
rcmenu RC_Repository_Manager_RightClick_ListViewItem(
	menuItem mi_PropertiesRepository "Properties..."
	menuItem mi_Publish "Publish Repository"
	
	seperator s1
	menuItem mi_DeleteRepository "Delete..."
	on mi_PropertiesRepository picked do(
		Repository_Manager_Rollout.HandlePropertiesRepository()
	)
	on mi_DeleteRepository picked do(
		Repository_Manager_Rollout.HandleDeleteRepository()
	)
	
	on mi_Publish picked do(
		Repository_Manager_Rollout.HandlePublish()
	)
	
	
	
)

rcmenu RC_Repository_Manager_Menu(
	submenu "File"(
		menuItem mi_NewRepository "New Repository..."
		menuItem mi_DownloadRepository "Download Repository..."
		seperator s2
		menuItem mi_Refresh "Refresh"
	)
	submenu "Edit"(
		menuItem mi_PropertiesRepository "Properties..."
		menuItem mi_Publish "Publish Repository"
		seperator s1
		menuItem mi_DeleteRepository "Delete..."
	)
	
	on mi_DownloadRepository picked do(
		Repository_Manager_Rollout.HandleDownloadRepository()
	)
	
	on mi_Publish picked do(
		Repository_Manager_Rollout.HandlePublish()
	)
	
	on mi_Refresh picked do(
		Repository_Manager_Rollout.HandleRefresh()
	)
	
	on mi_PropertiesRepository picked do(
		Repository_Manager_Rollout.HandlePropertiesRepository()
	)
	
	on mi_DeleteRepository picked do(
		Repository_Manager_Rollout.HandleDeleteRepository()
	)
	on mi_NewRepository picked do(
		Repository_Manager_Rollout.HandleNewRepository()
	)
	
	fn RC_Repository_Manager_Menu_Refresh _selectionCount=(
		if(_selectionCount == 0)then(
			mi_PropertiesRepository.enabled = false
			mi_Publish.enabled = false
			mi_DeleteRepository.enabled = false
			return false
		)
		
		mi_PropertiesRepository.enabled = true
		mi_Publish.enabled = true
		mi_DeleteRepository.enabled = true
		return true
	)
	
)





rollout Repository_Manager_Rollout "Repository Manager" height:500 width:500(
	local m_WindowSaver

	local m_TreeViewBrowser
	local m_UIMessage_Text_Message
	
	dotNetControl Text_Message "system.windows.forms.label"
	
	
	
	dotNetControl listView_Projects "System.Windows.Forms.ListView" height:420
	
	button btn_Close "Close"  width:120 height:40
	
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
		listView_Projects.Columns.add "Url" 200
	)
	
	
	fn AddProjectsToListView =(
		
		theRange=#()
-- 		theRange2=#()
		
		ProjectListviewDataArr = m_Repository_System.GetRepositoriesListviewArr()
		for ProjectListviewData in ProjectListviewDataArr do(
			
			listviewItemObj = dotNetObject "System.Windows.Forms.ListViewItem" ProjectListviewData
			append theRange listviewItemObj
-- 			append theRange2 listviewItemObj
		)
		
		listView_Projects.Items.Clear()
		listView_Projects.Items.AddRange theRange
		
		RC_Repository_Manager_Menu.RC_Repository_Manager_Menu_Refresh (listView_Projects.selectedItems.Count)
	)
	fn HandleMSPMProjectChange _eventArgs=(
		
		AddProjectsToListView()
	)
	
	fn RefreshUIContent=(
		
	)
	
	
	
	fn GetSelectedRepositoryUrlArr=(
		returnArr = #()
		numSelected = listView_Projects.selectedItems.Count
		for i = 0 to (numSelected - 1) do(
			selectedItem = listView_Projects.selectedItems.Item[i]
			append returnArr (selectedItem.SubItems.Item[2].text)
		)
		return returnArr
	)
	
	fn HandleRefresh=(
		AddProjectsToListView()
	)
	
	fn HandlePropertiesRepository=(
		repoUrlArr = GetSelectedRepositoryUrlArr()
		for repoUrl in repoUrlArr do(
			m_Repository_Properties_System.ShowRepository repoUrl
			exit
		)
	)
	
	fn HandleDeleteRepository=(
		repoUrlArr = GetSelectedRepositoryUrlArr()
		for repoUrl in repoUrlArr do(
			m_Repository_System.DeleteRepository repoUrl
		)
		AddProjectsToListView()
	)
	
	fn HandleNewRepository=(
		res = m_Repository_System.NewRepository()
		if(res != undefined)then(
			m_UIMessage_Text_Message.SetMessage "Repository Created" style:true
		)
		AddProjectsToListView()
	)
	
	fn PublishSelectedRepositories=(
		repoUrlArr = GetSelectedRepositoryUrlArr()
		
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		savePath = (userScriptFolder + @"MaxScriptProjectManager\publish\")
		
		for repoUrl in repoUrlArr do(
			
			repoObj = m_Repository_System.GetRepositoryByPath repoUrl
			m_Repository_System.PublishRepository repoObj savePath
		)
		
		m_MSPM_System.ShowInExplorer savePath
	)
	
	fn HandleDownloadRepository=(
		m_DialogMaster.DialogMaster_CreateDialog Repository_Download
		AddProjectsToListView()
	)
	
	fn HandlePublish=(
		PublishSelectedRepositories()
	)
	
	
	fn RefreshUIControls=(
		Text_Message.width = Repository_Manager_Rollout.width - 20
		listView_Projects.width = Repository_Manager_Rollout.width - 20
		listView_Projects.height = Repository_Manager_Rollout.height - listView_Projects.pos.y - 60
		btn_Close.pos.y = Repository_Manager_Rollout.height - 50
		btn_Close.pos.x = Repository_Manager_Rollout.width - 130
	)
	
	fn handleRepositoryEdit _args=(
		
		AddProjectsToListView()
		
	)
	
	on btn_Close pressed do(
		destroydialog Repository_Manager_Rollout
	)
	
	fn HandleMSPMExit _args=(
		destroyDialog Repository_Manager_Rollout
	)
	
	on Repository_Manager_Rollout open do(
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		m_Repository_System.addEventListener "RepositoryNew" handleRepositoryEdit
		m_Repository_System.addEventListener "RepositoryEdit" handleRepositoryEdit
		SetupListView()
		AddProjectsToListView()
-- 		messagebox ((m_MSPM_System.GetProjectsListviewArr()) as string)
		
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		(m_UIMaster.StyleLabelAsMessage Text_Message)
		
		
		origPos = getdialogpos Repository_Manager_Rollout
		origSize = getdialogsize Repository_Manager_Rollout
		
		m_WindowSaver = windowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Repository_Manager_Rollout applySize:true applyPosition:true
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Repository_Manager_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Repository_Manager_Rollout.height/2)]
		
		setdialogpos Repository_Manager_Rollout newPos
		
		
		RC_Repository_Manager_Menu.RC_Repository_Manager_Menu_Refresh (listView_Projects.selectedItems.Count)

	)
	
	on listView_Projects mouseUp _args do(
		if(_args.Button == _args.Button.Right)then(
			if(listView_Projects.selectedItems.Count == 0)then(
				popupmenu RC_Repository_Manager_RightClick_ListViewEmpty	
			)
			
		)
		
		RC_Repository_Manager_Menu.RC_Repository_Manager_Menu_Refresh (listView_Projects.selectedItems.Count)
		
	)
	
	on listView_Projects mouseClick _args do(
		if(_args.Button == _args.Button.Right)then(
			popupmenu RC_Repository_Manager_RightClick_ListViewItem			
		)
	)
	
	on listView_Projects doubleclick do(
		HandlePropertiesRepository()
	)
	
	on Repository_Manager_Rollout resized _arg do(
		RefreshUIControls()
	)
	on Repository_Manager_Rollout close do(
		m_MSPM_System.removeEventListener "ExitMSPM" HandleMSPMExit
		m_Repository_System.removeEventListener "RepositoryEdit" handleRepositoryEdit
		m_Repository_System.removeEventListener "RepositoryNew" handleRepositoryEdit
		m_WindowSaver.onClose()
	)
)

struct Repository_Manager_System(
	function Initiate=(
		
	),
	function CreateDialog=(
		m_DialogMaster.DialogMaster_CreateDialog Repository_Manager_Rollout menu:RC_Repository_Manager_Menu style_resizing:true
	)
)
m_Repository_Manager_System = Repository_Manager_System()
m_Repository_Manager_System.Initiate()
-- m_Repository_Manager_System.CreateDialog()


