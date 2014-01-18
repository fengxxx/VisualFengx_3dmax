m_DialogMaster.DialogMaster_DestroyDialog Project_Add_Rollout

struct Project_Add_System(
	function CreateDialog_Project_Add_Rollout=(
		m_DialogMaster.DialogMaster_CreateDialog Project_Add_Rollout style_resizing:true
	),
	function Initiate=(
		
	)
)

rollout Project_Add_Rollout "Open Project" width:300(
	local m_WindowSaver
	local m_TreeViewBrowser
	local m_UIMessage_Text_Message
	
	dotNetControl Text_Message "system.windows.forms.label"
	
	dotNetControl TreeView_ScriptBrowser "system.windows.forms.treeView" height:500
	button btn_AddProject "Open Project" width:120 height:40 across:2
	button btn_Close "Close" width:120 height:40
	dotNetControl TextBox_SearchField "system.windows.forms.textBox" visible:false
	
	
	
	fn RefreshUIControls=(
		Text_Message.width = Project_Add_Rollout.width - 20
		TreeView_ScriptBrowser.width = Project_Add_Rollout.width - 20
		TreeView_ScriptBrowser.height = Project_Add_Rollout.height - 80
		btn_AddProject.pos.x = Project_Add_Rollout.width/4 - 120/2
		btn_Close.pos.x = ((Project_Add_Rollout.width/4)*3) - 120/2
		
		btn_AddProject.pos.y = (Project_Add_Rollout.height) - 50
		btn_Close.pos.y = (Project_Add_Rollout.height) - 50
	)
	on TextBox_SearchField KeyUp _e do(
		m_TreeViewBrowser.SearchNode_string TextBox_SearchField.text
	)
	
	fn AddProject _path=(
		
		res = m_MSPM_System.AddProject _path
		
		stringArr = (filterstring _path "\\")
		labelString = stringArr[stringArr.count]
		if(res == true)then(
			destroydialog Project_Add_Rollout
-- 			messageStr = "'"+labelString+"' Added to your Projects"
-- 			m_UIMessage_Text_Message.SetMessage messageStr style:true	
			return true
		)
		if(res == false)then(
			messageStr = "'"+labelString+"' Is allready in your Projects"
			m_UIMessage_Text_Message.SetMessage messageStr style:false
			return false
		)
		
		
	)
	
	fn HandleMSPMNodeClick _eventArgs=(
		global m_MSPM_SelectedNode_AddProject_Path
		
		m_MSPM_SelectedNode_AddProject_Path = _eventArgs.FullPath
		if(_eventArgs == #())then(
			return false
		)
		
		
		if(_eventArgs.OriginalEventArgument.Button == _eventArgs.OriginalEventArgument.Button.Right)then(
			if(_eventArgs.Type == "ROOT")then(
					rcmenu rc_openProject(
					
					menuItem mi_openInExplorer "Open In Explorer"
					on mi_openInExplorer picked do(
						processClass = (dotnetclass "System.Diagnostics.Process")
						processClass.start(m_MSPM_SelectedNode_AddProject_Path)
					)
					
				)
				popupmenu rc_openProject
				return true
			)
			
			rcmenu rc_openProject(
				menuItem mi_addProject "Open Project"
				seperator sep1
				menuItem mi_openInExplorer "Open In Explorer"
				on mi_openInExplorer picked do(
					processClass = (dotnetclass "System.Diagnostics.Process")
					processClass.start(m_MSPM_SelectedNode_AddProject_Path)
				)
				on mi_addProject picked do(
					AddProject m_MSPM_SelectedNode_AddProject_Path
				)
			)
			popupmenu rc_openProject
			
		)
		
	)
	
	fn TreeviewBrowserHandleDoubleClick _eventArgs=(
		if(_eventArgs == #())then(
			return false
		)
		
		if(_eventArgs.Type == "ROOT")then(
			return false
		)
		projectPath = _eventArgs.FullPath
		
		AddProject projectPath
		
-- 		destroydialog Project_Add_Rollout
	)
	on btn_Close pressed do(
		destroydialog Project_Add_Rollout
	)
	on btn_AddProject pressed do(
		if(TreeView_ScriptBrowser.SelectedNode == undefined)then(
			messageStr = "No Folder Selected"
			m_UIMessage_Text_Message.SetMessage messageStr style:false
			return false
		)
		
		loc
		res = m_TreeViewBrowser.GetLocationByNode (TreeView_ScriptBrowser.SelectedNode) &loc
		if(res == true)then(
			projectPath = loc.GetRootFolder()
			if(projectPath == (symbolicPaths.getPathValue("$Scripts")+"\\") )then(
				messageStr = "'$Scripts' can not be added as a Project"
				m_UIMessage_Text_Message.SetMessage messageStr style:false
				return false
			)
			if(projectPath == (symbolicPaths.getPathValue("$UserScripts")+"\\") )then(
				messageStr = "'$UserScripts' can not be added as a Project"
				m_UIMessage_Text_Message.SetMessage messageStr style:false
				return false
			)
			AddProject projectPath
			
		)
	)
	fn HandleMSPMExit _args=(
		destroyDialog Project_Add_Rollout
	)
	on Project_Add_Rollout open do(
		
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		
		m_UIMessage_Text_Message = UIMessageLabel()
		m_UIMessage_Text_Message.Initiate Text_Message
		(m_UIMaster.StyleLabelAsMessage Text_Message)
		
		origPos = getdialogpos Project_Add_Rollout
		origSize = getdialogsize Project_Add_Rollout
		
		m_WindowSaver = WindowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Project_Add_Rollout applySize:false applyPosition:true
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Project_Add_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Project_Add_Rollout.height/2)]
		setdialogpos Project_Add_Rollout newPos
		
		m_TreeViewBrowser = TreeViewBrowser()
		m_TreeViewBrowser.Initiate m_TreeViewBrowser TreeView_ScriptBrowser DepthLimit:1 ShowFiles:false ShowDirectories:true EnableRightClickActions:false
		url = (symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\src\\icons\\")
		m_TreeViewBrowser.AddImageList (url+"Icon_Folder.bmp") #(".")
		m_TreeViewBrowser.AddImageList (url+"Icon_MaxScript.gif") #(".ms")
		m_TreeViewBrowser.AddImageList (url+"Icon_Unknown.gif") #(".bmp",".png")
		loc1 = m_TreeViewBrowser.AddLocation (symbolicPaths.getPathValue("$userScripts")+"\\") labelString:"$UserScripts"
		loc2 = m_TreeViewBrowser.AddLocation (symbolicPaths.getPathValue("$Scripts")+"\\") labelString:"$Scripts"
		
		
			
		m_TreeViewBrowser.Refresh()
			
		loc1.m_Node.Expand()
		loc2.m_Node.Expand()	
		
		m_TreeViewBrowser.AddEventListener "DoubleClick" TreeviewBrowserHandleDoubleClick
		m_TreeViewBrowser.AddEventListener "NodeMouseClick" HandleMSPMNodeClick
			
		RefreshUIControls()
	)
	
	on Project_Add_Rollout resized _args do(
		RefreshUIControls()
	)
	
	on Project_Add_Rollout close do(
		m_WindowSaver.onClose()
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
		m_TreeViewBrowser.RemoveEventListener "DoubleClick" TreeviewBrowserHandleDoubleClick
		m_TreeViewBrowser.RemoveEventListener "NodeMouseClick" HandleMSPMNodeClick
	)
	on Text_Message mouseClick _args do(
		m_UIMessage_Text_Message.onMouseClick _args
	)
	
	on TreeView_ScriptBrowser AfterExpand _args do(
		m_TreeViewBrowser.AfterExpand _args
	)
	on TreeView_ScriptBrowser AfterCollapse _args do(
		m_TreeViewBrowser.AfterCollapse _args
	)
	on TreeView_ScriptBrowser DoubleClick _args do(
		
		m_TreeViewBrowser.DoubleClick _args
		
	)
	
	on TreeView_ScriptBrowser nodemouseclick _args do(
		m_TreeViewBrowser.NodeMouseClick _args
	)
)

m_Project_Add_System = Project_Add_System()
m_Project_Add_System.Initiate()


-- m_DialogMaster.DialogMaster_CreateDialog Project_Add_Rollout style_resizing:true