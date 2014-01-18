
m_DialogMaster.DialogMaster_DestroyDialog MPM_Repository_Rollout
struct MPM_Repository_System(
	m_Path,
	fn Initiate=(
		
	),
	fn ShowRepository _path=(
		m_Path = _path
		createDialog MPM_Repository_Rollout
	)
)

rollout MPM_Repository_Rollout "MaxScript Repository" width:400 height:200(
	local m_WindowSaver
	edittext txt_RepoUrl "Repository URL" across:2
	
	button btn_Browse "L"
	dotNetControl Text_RepositoryTitle "system.windows.forms.label" text:""
	edittext txt_newVersion "New Version" text:"0.0" across:2
	button btn_Upgrade "Add" 
	dotNetControl listView_Projects "System.Windows.Forms.ListView" height:420
	
	
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
		listView_Projects.Columns.add "ID" 240
		
	)	
	
	fn RefreshUIContent=(
		
	)
	
	fn RefreshUIControls=(
		Text_RepositoryTitle.pos.x = 15
		Text_RepositoryTitle.pos.y= 30
		Text_RepositoryTitle.width = (MPM_Repository_Rollout.width - 25)
		
		btn_Upgrade.pos.x = 210
		
		txt_RepoUrl.width = (MPM_Repository_Rollout.width - 140)
		btn_Browse.pos.x = (MPM_Repository_Rollout.width - 40)
		listView_Projects.width = (MPM_Repository_Rollout.width - 20)
		listView_Projects.height = (( (MPM_Repository_Rollout.height - listView_Projects.pos.y) - 10))
	)
	
	on MPM_Repository_Rollout open do(
		(m_UIMaster.StyleLabelAsHeader Text_RepositoryTitle)
		SetupListView()
		m_WindowSaver = WindowSaver()
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") MPM_Repository_Rollout applySize:true applyPosition:true
		RefreshUIControls()
		RefreshUIContent()
		
		if(m_MPM_Repository_System.m_NewRepository == true)then(
			txt_RepoUrl.enabled = false
			btn_Browse.enabled = false
		)
		
	)
	on MPM_Repository_Rollout close do(
		m_WindowSaver.onClose()
	)
	on MPM_Repository_Rollout resized _args do(
		RefreshUIControls()
	)
	
	on btn_Browse pressed do(
		RefreshUIContent()
	)
	
	on btn_Upgrade pressed do(
		
	)
	
	on listView_Projects doubleclick _args do(
		
	)
)

m_MPM_Repository_System = MPM_Repository_System()
m_MPM_Repository_System.Initiate()
-- m_MPM_Repository_System.ShowRepository
-- m_DialogMaster.DialogMaster_CreateDialog MPM_Repository_Rollout style_resizing:true

-- m_MPM_Repository_System.ShowRepositoriesOfProject (m_MSPM_System.GetProjectByName "TheMessageBoxProject") new:false

-- m_MPM_Repository_System.CreateEmptyRepository()