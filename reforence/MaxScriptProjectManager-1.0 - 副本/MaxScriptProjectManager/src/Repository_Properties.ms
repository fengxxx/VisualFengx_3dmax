
m_DialogMaster.DialogMaster_DestroyDialog Repository_Properties_Rollout

struct Repository_Properties_System(
	m_Path,
	m_Repository_Object,
	m_FilterProjectObj,
	m_FilterBool,
	fn GetRepository_Object=(
		return m_Repository_Object
	),
	fn Initiate=(
		m_FilterBool = false
	),
	fn ShowRepository _url filter:undefined=(
		
		m_FilterProjectObj = filter
		
		
		m_Repository_Object = m_Repository_System.GetRepositoryByPath _url
		
		m_DialogMaster.DialogMaster_CreateDialog Repository_Properties_Rollout menu:RC_Repository_Properties_Menu style_resizing:true
	)
)

rcmenu RC_Repository_Properties_RightClick_ScriptListViewEmpty(
	
	menuItem mi_Refresh "Refresh"
	on mi_Refresh picked do(
		Repository_Properties_Rollout.HandleRefresh()
	)
)

rcmenu RC_Repository_Properties_RightClick_ScriptListViewItem(
	
	menuItem mi_ShowProperties "Properties..."
	seperator s5
	on mi_ShowProperties picked do(
		Repository_Properties_Rollout.HandleShowPropertiesSelectedScript()
	)
	
	menuItem mi_ConnectToMZP "Connect To MZP File..."
	on mi_ConnectToMZP picked do(
		Repository_Properties_Rollout.ConnectToMZP()
	)
	seperator s1
	menuItem mi_DeleteRepository "Delete..."
	
	on mi_DeleteRepository picked do(
		Repository_Properties_Rollout.HandleDeleteScript()
	)
	
	
	
	
	
)

rcmenu RC_Repository_Properties_Menu(
	submenu "File"(
		menuItem mi_Publish "Publish Repository"
		seperator s1
		menuItem mi_Refresh "Refresh"
	)
	submenu "Edit"(
		menuItem mi_ShowProperties "Properties..."
		seperator s3
		menuItem mi_ConnectToMZP "Connect To MZP File"
		seperator s2
		menuItem mi_DeleteRepository "Delete..."
	)
	
	on mi_ShowProperties picked do(
		Repository_Properties_Rollout.HandleShowPropertiesSelectedScript()
	)
	
	on mi_ConnectToMZP picked do(
		Repository_Properties_Rollout.ConnectToMZP()
	)
	on mi_Refresh picked do(
		Repository_Properties_Rollout.HandleRefresh()
	)
	

	on mi_DeleteRepository picked do(
		Repository_Properties_Rollout.HandleDeleteScript()
	)
	on mi_Publish picked do(
		Repository_Properties_Rollout.HandlePublish()
	)
	
	fn RC_Repository_Properties_Menu_Refresh _selectionCount=(
		if(_selectionCount == 0)then(
			mi_ConnectToMZP.enabled = false
			mi_DeleteRepository.enabled = false
			return false
		)
		mi_ConnectToMZP.enabled = true
		mi_DeleteRepository.enabled = true
		return true
	)
	
)
m_Repository_Properties_System = Repository_Properties_System()

rollout Repository_Properties_Rollout "Repository Properties" width:450 height:200(
	local m_WindowSaver
	local offsetHeaderTop = -5
	local offsetHeaderBottom = -13
	label spacer3 "" visible:false offset:[0,offsetHeaderTop + -10]
	dotNetControl Text_Properties "system.windows.forms.label" text:"Properties"
	label spacer2 "" visible:false offset:[0,offsetHeaderBottom]
	
	edittext txt_Name "Name"
	edittext txt_Url "Url"
	edittext txt_DownloadURL "Download" readonly:true
	
	label spacer1 "" visible:false offset:[0,offsetHeaderTop]
	dotNetControl Text_Scripts "system.windows.forms.label" text:"Scripts"
	label spacer4 "" visible:false offset:[0,offsetHeaderBottom]
	
	dropdownlist dropdown_Projects across:4 width:150
	checkbox ch_filter "Filter" align:#right offset:[-10, 2]
	edittext txt_VersionLabel "Version" text:"0.0" offset:[0, 2]
	button btn_AddVersion "Add Version" offset:[0,0]
	
	dotNetControl listView_Projects "System.Windows.Forms.ListView" height:420
	button btn_Save "Save" width:100 height:40 align:#right
	
	fn SaveRepositoryProperties=(
		repoObj = m_Repository_Properties_System.GetRepository_Object()
		repoObj.SetName txt_Name.text
		repoObj.SetDownloadUrlFolder txt_Url.text
		repoObj.SetUrl txt_DownloadURL.text
		repoObj.Save()
	)
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
		listView_Projects.Columns.add "Version" 80
		listView_Projects.Columns.add "ID" 80
		listView_Projects.Columns.add "MD5" 60
		listView_Projects.Columns.add "Changelist" 80
		listView_Projects.Columns.add "Download" 290
		
		
		
	)	
	
	fn HandlePublish=(
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		repoObj = m_Repository_Properties_System.m_Repository_Object
		SaveRepositoryProperties()
		savePath = (userScriptFolder + @"MaxScriptProjectManager\publish\")
		m_Repository_System.PublishRepository repoObj savePath
		m_MSPM_System.ShowInExplorer savePath
	)
	
	fn UpdateFullDownloadUrl=(
		txt_DownloadURL.text = txt_Url.text + txt_Name.text + ".msr"
	)

	
	

	
	fn RefreshUIContent_ScriptListView=(
		repoObj = m_Repository_Properties_System.GetRepository_Object()
		filterBool = m_Repository_Properties_System.m_FilterBool
		
		
		filterObj
		if(filterBool == true)then(
			
			filterObj = m_Repository_Properties_System.m_FilterProjectObj
		)else(
			filterObj = undefined
		)
		listViewArr = repoObj.GetScriptAsListviewArr filter:filterObj
		theRange= #()
		for listViewData in listViewArr do(
			listviewItemObj = dotNetObject "System.Windows.Forms.ListViewItem" listViewData
			append theRange listviewItemObj
		)
		listView_Projects.Items.Clear()
		listView_Projects.Items.AddRange theRange
		
	)
	
	fn RefreshUIContent=(
		repoObj = m_Repository_Properties_System.GetRepository_Object()
		txt_Name.text = repoObj.GetName()
		txt_Url.text = repoObj.GetDownloadUrlFolder()
		RefreshUIContent_ScriptListView()
		
	)
	
	on btn_AddVersion pressed do(
		repoObj = m_Repository_Properties_System.m_Repository_Object
		res = repoObj.ApplyScriptItem (m_Repository_Properties_System.m_FilterProjectObj) txt_VersionLabel.text
		
		repoObj.Save()
		RefreshUIContent()
		(m_Repository_Properties_System.m_FilterProjectObj.SetProjectVersion txt_VersionLabel.text)
		
	)
	
	on ch_filter changed _state do(
		
		m_Repository_Properties_System.m_FilterBool = _state
		
		RefreshUIContent_ScriptListView()
	)
	
	fn RefreshUIControls=(
		
		btn_Save.pos.y = Repository_Properties_Rollout.height - 30 - 20
		btn_Save.pos.x = Repository_Properties_Rollout.Width - 100 - 20
		
		
		
		
		listView_Projects.width = (Repository_Properties_Rollout.width - 20)
		listView_Projects.height = (( (Repository_Properties_Rollout.height - listView_Projects.pos.y) - 60))
		
		
		Text_Properties.width =  (Repository_Properties_Rollout.width - 20)
		Text_Scripts.width = (Repository_Properties_Rollout.width - 20)
		
		txt_Name.width = (Repository_Properties_Rollout.width - 55)
		txt_Url.width = (Repository_Properties_Rollout.width - 40)
		txt_DownloadURL.width = (Repository_Properties_Rollout.width - 74)
	)
	
	on txt_Url changed _arg do(
		UpdateFullDownloadUrl()
	)
	
	on txt_Name changed  _arg do(
		UpdateFullDownloadUrl()
	)
	
	fn handleScriptItemEdit _args=(
		RefreshUIContent_ScriptListView()
	)
	
	fn HandleMSPMExit _args=(
		destroyDialog Repository_Properties_Rollout
	)
	
	on Repository_Properties_Rollout open do(
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		m_Repository_System.addEventListener "ScriptItemEdit" handleScriptItemEdit
		(m_UIMaster.StyleLabelAsHeader Text_Properties)
		(m_UIMaster.StyleLabelAsHeader Text_Scripts)
		dropdown_Projects.Items = m_MSPM_System.GetProjectsNameArr()
		
		
		if(m_Repository_Properties_System.m_FilterProjectObj == undefined)then(
			m_Repository_Properties_System.m_FilterProjectObj = (m_MSPM_System.GetProjectByName dropdown_Projects.selected)
		)else(
			projName = m_Repository_Properties_System.m_FilterProjectObj.GetProjectName()
			
			for i=1 to dropdown_Projects.Items.count do(
				projItem = dropdown_Projects.Items[i]
				if( projName == projItem)then(
					dropdown_Projects.selection = i
				)
				
			)
			
		)
		
		origPos = getdialogpos Repository_Properties_Rollout
		origSize = getdialogsize Repository_Properties_Rollout
		
		SetupListView()
		m_WindowSaver = WindowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Repository_Properties_Rollout applySize:true applyPosition:true
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Repository_Properties_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Repository_Properties_Rollout.height/2)]
		setdialogpos Repository_Properties_Rollout newPos
			
		RefreshUIControls()
		RefreshUIContent()
		
		UpdateFullDownloadUrl()
		
		RC_Repository_Properties_Menu.RC_Repository_Properties_Menu_Refresh (listView_Projects.selectedItems.count)
		
	)
	
	fn GetSelectedScriptsItemArr=(
		returnArr = #()
		numSelected = listView_Projects.selectedItems.Count
		for i = 0 to (numSelected - 1) do(
			dataArr =#()
			selectedItem = listView_Projects.selectedItems.Item[i]
			scriptName  = (selectedItem.SubItems.Item[0].text)
			scriptVersion = (selectedItem.SubItems.Item[1].text)
			scriptID = (selectedItem.SubItems.Item[2].text)
			
			scriptItemObj = m_Repository_Properties_System.m_Repository_Object.GetScriptItemFromNameVersionScriptID scriptName scriptVersion scriptID
			append returnArr scriptItemObj
		)
		return returnArr
	)
	
	fn GetSelectedScriptsDataArr=(
		returnArr = #()
		numSelected = listView_Projects.selectedItems.Count
		for i = 0 to (numSelected - 1) do(
			dataArr =#()
			selectedItem = listView_Projects.selectedItems.Item[i]
			append dataArr  (selectedItem.SubItems.Item[0].text)
			append dataArr  (selectedItem.SubItems.Item[1].text)
			append dataArr  (selectedItem.SubItems.Item[2].text)
			
			append returnArr dataArr
		)
		return returnArr
	)
	
	fn HandleDeleteScript=(
		scriptDataArr = GetSelectedScriptsDataArr()
		for scriptData in scriptDataArr do(
			m_Repository_Properties_System.m_Repository_Object.DeleteScriptItem scriptData[1] scriptData[2] scriptData[3]
		)
		RefreshUIContent()
	)
	
	fn ConnectToMZP=(
		scriptDataArr = GetSelectedScriptsItemArr()
		for scriptObj in scriptDataArr do(
			userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
			
			mzpPath = getOpenFileName caption:"Select MZP File:" types:"MZP (*.MZP)|*.mzp|All (*.*)|*.*|" filename:(userScriptFolder + @"MaxScriptProjectManager\publish\")
			if(mzpPath == undefined)then(
				return false
			)
			
			md5number = m_MZP_System.GetMd5FromMZPFilePath mzpPath
			scriptObj.SetMD5 md5number
			
			m_Repository_Properties_System.m_Repository_Object.Save()
-- 			m_Repository_Properties_System.m_Repository_Object.DeleteScriptItem scriptData[1] scriptData[2] scriptData[3]
			continue
		)
		RefreshUIContent()		
	)
	
	fn HandleRefresh=(
		RefreshUIContent()
	)
	
	on Repository_Properties_Rollout close do(
		m_WindowSaver.onClose()
		m_MSPM_System.removeEventListener "ExitMSPM" HandleMSPMExit
		m_Repository_System.removeEventListener "ScriptItemEdit" handleScriptItemEdit
	)
	on Repository_Properties_Rollout resized _args do(
		RefreshUIControls()
	)
	
	
	on btn_Save pressed do(
		SaveRepositoryProperties()
		m_DialogMaster.DialogMaster_DestroyDialog Repository_Properties_Rollout
	)
	
	on dropdown_Projects selected _arg do(
		m_Repository_Properties_System.m_FilterProjectObj = (m_MSPM_System.GetProjectByName dropdown_Projects.selected)
		RefreshUIContent_ScriptListView()
	)
	
	on listView_Projects mouseup _args do(
		if(_args.Button == _args.Button.Right)then(
			if(listView_Projects.selectedItems.Count== 0)then(
				popupmenu RC_Repository_Properties_RightClick_ScriptListViewEmpty	
			)
		)
		RC_Repository_Properties_Menu.RC_Repository_Properties_Menu_Refresh (listView_Projects.selectedItems.count)
	)
	
	on listView_Projects mouseClick _args do(
		if(_args.Button == _args.Button.Right)then(
			popupmenu RC_Repository_Properties_RightClick_ScriptListViewItem
		)
	)
	
	fn HandleShowPropertiesSelectedScript=(
		scriptItemArr = GetSelectedScriptsItemArr()
		for scriptItem in scriptItemArr do(
			m_Repository_ScriptItem_Properties_System.ShowPropertiesOfScriptItem m_Repository_Properties_System.m_Repository_Object scriptItem	
			exit
		)	
	)
	
	on listView_Projects doubleclick _args do(
		HandleShowPropertiesSelectedScript()
		
	)
	
	
)

m_Repository_Properties_System = Repository_Properties_System()
m_Repository_Properties_System.Initiate()
-- m_Repository_Properties_System.ShowRepository @"C:\Users\sven\AppData\Local\Autodesk\3dsMax\2011 - 64bit\enu\scripts\MaxScriptProjectManager\data\repository_xml\repo_1.xml"
-- m_DialogMaster.DialogMaster_CreateDialog MPM_Repository_Rollout style_resizing:true
