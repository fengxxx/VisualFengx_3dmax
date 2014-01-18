/*
	TreeViewBroswer
	-------------------
	Version : 1.0
	Developed By : Sven Fraeys
	Info: http://sven.fraeys.be/
	
*/



try(destroyDialog treeViewDemoRollout)catch()

/*
	EVENT ARGUMENTS
	------------------------
	Struct that will be returned to developers, containing sufficant data about the selected node

*/
struct TreeViewBrowser_EventArgs(
	Node, -- Gives Back Node : TreeNode (DotNet)
	FullPath, -- Fullpath of the File : String
	Label, --Label Of Node : String
	Type,
	OriginalEventArgument, -- Original EventData (if exists)
	TreeViewBrowser_Location	-- Adress of the Location Object itself
)
/*
	LOCATION
	--------------
	Node in the Treeview
	Manages the Node in the Treeview, expanding his content
*/
struct TreeViewBrowser_Location(
	m_This,						-- TreeViewBrowser_Location	:	Object Of Itself
	m_Type, 					-- String				:	Type of location Can be "DIR"  "FILE"
	m_Frozen, 					-- Boolean 			:	If Location is in Frozen state or not. If Frozen, Removing and Adding is disabled in the Node
	m_Label,					-- String				:	Label of the node
	m_TreeViewBrowser,		-- DotNetTreeview 	:	TreeviewBrowser, Manager of Location
	m_ParentLocation,		-- Location			:	Parent Location
	m_RootFolder,				-- String				:	Full path to file or directory
	m_Node,						-- TreeviewNode		:	The Node in the Treeview
	m_Depth,					-- Integer				:	Depth of node
	
	fn Expand _all:false=(),
	fn Freeze _state=(
		m_Frozen = _state
	),
	
	fn GetExtension=(
		-- Returns Exe as String, example: ".ms" ".txt"
		if(m_Type == "FILE")then(
			return (getFilenameType m_RootFolder)
		)
		return ""
	),
	fn Destroy=(
		-- Destroy the current location
		m_Node = undefined
	),
	fn GetType=(
		return m_Type
	),
	fn GetRootFolder=(
		return m_RootFolder
	),
	fn SetLabel _labelStr=(
		m_Label = _labelStr
		m_Node.text = m_TreeViewBrowser.ApplyStringStyle(_labelStr)
	),
	fn Initiate _treeViewLocation _treeViewBrowser _folder _type Depth:-1 =(
		-- Initiate TreeviewBrowser
		m_This = _treeViewLocation
		m_Depth = Depth
		m_Type = _type
		
		m_Frozen = false
		m_TreeViewBrowser = _treeViewBrowser
		m_RootFolder = _folder
		
		if(m_Type == "FILE")then(
			labelString = (filenameFromPath m_RootFolder)	
		)else(
			stringArr = (filterstring m_RootFolder "\\")
			labelString = stringArr[stringArr.count]
		)
		m_Label  = m_TreeViewBrowser.ApplyStringStyle(labelString)
		
		imageIndex = 0
		
		
		
		if(_type == "ROOT")then(
			imageIndex = (m_TreeViewBrowser.GetImageIDForExtension ("ROOT") )
		)
		
		if(_type == "DIR")then(
-- 			m_Label = substring m_Label 1 (m_Label.Count-1)
		)
		if(_type == "FILE")then(
			imageIndex = (m_TreeViewBrowser.GetImageIDForExtension (GetExtension()) )
		)
		
		
		
-- 		m_Label = "<no label>"
		m_Node =(dotNetObject "System.Windows.Forms.TreeNode" m_Label )
-- 		showproperties m_Node
		m_Node.imageIndex = imageIndex
		m_Node.SelectedImageIndex = imageIndex
	),
	fn AddDummyNode=(
		dummyNode = (dotNetObject "System.Windows.Forms.TreeNode" "dummy")
			
			m_Node.nodes.add dummyNode
	),
	fn ClearNodes=(
		if(m_Frozen == true)then(
			return false
		)
		for i = 0 to m_Node.nodes.Count-1 do(
			_node = (m_Node.nodes.Item[i])
			res = m_TreeViewBrowser.GetLocationByNode _node &loc
			if(res == true)then(
				loc.ClearNodes()
			)
-- 			loc.ClearNodes()
			m_TreeViewBrowser.RemoveLocation  _node
			
		)
		m_Node.nodes.clear()
	),
	fn GetNodes _folder:undefined _noDummy:false =(
		if(m_Frozen == true)then(
			return false
		)
		if(_folder == undefined)then(
			_folder = m_RootFolder
		)
		
		if(_noDummy == false)then(
			childFiles = (getFiles (m_RootFolder+"/*"))
			childDirectories = (getDirectories (m_RootFolder+"*"))		
			if(childFiles.count != 0 or childDirectories.count != 0)then(
				
				if( (m_Depth < m_TreeViewBrowser.m_DepthLimit) or (m_TreeViewBrowser.m_DepthLimit == -1))then(
					AddDummyNode()
				)
				
			)	
		)
		
		return m_Node
	),
	fn Collapse=(
		if(m_Frozen == true)then(
			return false
		)
		ClearNodes()
		AddDummyNode()
	),
	fn ExpandAll=(
		Expand _all:true
	),
	fn Expand _all:false=(
		if(m_Frozen == true)then(
			return false
		)
		ClearNodes()
		
		if(m_TreeViewBrowser.m_ShowDirectoriesBool==true)then(
			
			childFiles = (getdirectories (m_RootFolder+"*"))
		
			for childFile in childFiles do(
				if( (m_Depth < m_TreeViewBrowser.m_DepthLimit) or (m_TreeViewBrowser.m_DepthLimit == -1))then(
-- 					AddDummyNode()
				)else(
					continue;
				)
				loc = m_TreeViewBrowser.CreateLocation childFile _type:"DIR" _depth:(m_Depth + 1)
				
				m_Node.nodes.add (loc.GetNodes _noDummy:_all)
				if(_all)then(
					loc.ExpandAll()
				)
				
				
			)
		)
		if(m_TreeViewBrowser.m_ShowFilesBool== true)then(
			childFiles = (getfiles (m_RootFolder+"*"))
			for childFile in childFiles do(
				loc = m_TreeViewBrowser.CreateLocation childFile _type:"FILE"
				m_Node.nodes.add (loc.getNodes _noDummy:_all)
				
			)
		)
		return m_Node
	),
	fn isValid=(
		if(m_Node == undefined)then(
			return false
		)
		return true
	),
	function Refresh expandState:false=(
		newNode = (Expand())
		if(expandState)then(
			m_Node.Expand()	
		)
	),
	function RefreshParentNode expandState:false=(
		if(m_Node.parent == undefined)then(
			Refresh()
			
-- 			m_TreeViewBrowser.Refresh()
			return false
		)
		
		m_TreeViewBrowser.GetLocationByNode m_Node.parent &loc
		newNode = loc.Expand()
		
		if(expandState)then(
			newNode.Expand()	
		)
		
		
	),
	function Rename _newName=(
		if(isValid() == false)then(
			return false
		)
		if(m_Type == "FILE")then(
			
			origName = filenameFromPath m_RootFolder
			directory = getFilenamePath m_RootFolder
			newFilePath = directory + _newName
			
			res = renamefile m_RootFolder newFilePath
			if(res == false)then(
-- 				m_Node.Text = m_TreeViewBrowser.ApplyStringStyle origName
				
			)
			m_TreeViewBrowser.SendEventListener "RenameSuccess" m_Node
			m_RootFolder = newFilePath
		)
		
		if(m_Type == "DIR")then(
			stringArr = (filterstring m_RootFolder "\\")
			labelString = stringArr[stringArr.count]
-- 			m_Node.Text = labelString
			
			arrCount = (stringArr.count) 
			toSize =  arrCount - 1
			newPath = ""
			for i = 1 to toSize do(
				append newPath stringArr[i]
				append newPath "\\"
			)
			append newPath _newName
-- 			append newPath "\\"
			
			if(m_TreeViewBrowser.DirectoryExists (newPath+"\\"))then(
				m_TreeViewBrowser.SendEventListener "RenameError" m_Node			
				RefreshParentNode()				
				return false
			)
			
-- 			doscommand ("mkdir "+"\""+newPath+"\"")
-- 			makedir newPath
			numFiles = (getfiles (m_RootFolder+"*")).count
			numDirectories = (getdirectories (m_RootFolder+"*")).count
			if((numFiles) == 0 and (numDirectories) == 0)then(
				makedir newPath
				m_TreeViewBrowser.HiddenDotNetCommand "cmd.exe" ("/K RMDIR "+"\""+m_RootFolder+"\"") ""
				m_TreeViewBrowser.SendEventListener "RenameSuccess" m_Node
				return true
			)
			
			dosMoveCommand = ("/K move \""+m_RootFolder+"*\" \""+newPath+"\"")
			
			moveRes = m_TreeViewBrowser.HiddenDotNetCommand "cmd.exe" dosMoveCommand ""
			m_TreeViewBrowser.SendEventListener "RenameSuccess" m_Node
-- 			if(moveRes)then(
-- 				doscommand ("RMDIR "+"\""+m_RootFolder+"\"")	
-- 				m_TreeViewBrowser.SendEventListener "RenameSuccess" m_Node
-- 			)else(
-- 				m_TreeViewBrowser.SendEventListener "RenameError" m_Node
-- 				doscommand ("RMDIR "+"\""+newPath+"\"")	
-- 			)
			
		)
		if(m_Type == "ROOT")then(
			stringArr = (filterstring m_RootFolder "\\")
			labelString = stringArr[stringArr.count]
-- 			m_Node.Text = labelString
			m_TreeViewBrowser.SendEventListener "RenameError" m_Node
		)
		
		RefreshParentNode()
		
		return false
	),
	function Delete=(
		res = querybox ("Are you sure you want to delete "+m_Label+"?\n This action can not be undone.")
		if(res == false or res == undefined)then(
			return false
		)
		if(m_Type == "FILE")then(
			deletefile m_RootFolder
			RefreshParentNode()
		)
		if(m_Type == "DIR")then(

			
			DeleteDosCommand = "/K RMDIR \""
			DeleteDosCommand = append DeleteDosCommand m_RootFolder
			DeleteDosCommand = append DeleteDosCommand "\" /S /Q"
			m_TreeViewBrowser.HiddenDotNetCommand "cmd.exe" DeleteDosCommand ""
			

			
			RefreshParentNode()
		)
		
		return true
		
	),
	function ShowRCMenu=(
		
		if(m_Type == "FILE")then(
			RCMenu locationRC(
				menuItem mi_Properties "Properties"
			)
			popUpMenu locationRC			
		)
		if(m_Type == "ROOT")then(
			RCMenu locationRC(
				menuItem mi_Properties "Properties Root"
				menuItem mi_RemoveProject "Remove Project"
				on mi_RemoveProject picked do(
					
				)
			)
			popUpMenu locationRC			
		)
		if(m_Type == "DIR")then(
			RCMenu locationRC(
				menuItem mi_Properties "Properties Dir"
			)	
			popUpMenu locationRC
		)
		
		
	),
	-- Returns location as Event Argument
	function AsEventArgs OriginalEventArgument:undefined=(
		args = TreeViewBrowser_EventArgs()
		args.Node = m_Node
		args.Label = m_Label
		args.FullPath = m_RootFolder
		args.OriginalEventArgument = OriginalEventArgument
		args.TreeViewBrowser_Location = m_This
		args.Type = m_Type
		return args
	)
	
)
/*
	TREEVIEWBROWSER
	-------------------------
	Main Manager
	Manages the Treeview
	Manages the Locations in the Treeview
*/
struct TreeViewBrowser(
	m_isInExpandStateBool, -- Boolean			:	If Treeview is in full expand state for each project, needed for searchstring
	m_SaveExpandStateBool,
	m_DotnetImageList,		-- ImageListDotNet	:	Contains Imagelist for icons
	m_ImageListData,		-- Array				: 	Contains Arrays with path to icon and the Extensions linked to this icon
	m_Frozen,					-- Boolean				:	Is Frozen (freezes the node content of the Tree
	m_Listeners,				-- Array				:	Contains Listeners in Array #("EventName", FunctionToExecute)
	m_DotnetTreeView,		-- DotnetTreeView	:	The Dotnetobject
	m_This,						-- TreeViewBrowser	:	For self referencing and to give adress to Locations
	m_Locations,				-- Array				:	Contains all the active Locations in the Treeview
	m_DepthLimit,				-- Integer				:	The depth limit of the Tree (-1 = no limit)
	m_ShowFilesBool,			-- Boolean				:	Display files in Tree
	m_ShowDirectoriesBool,	-- Boolean				:	Display directories in Tree
	m_SaveExpandStateArr,
	m_SaveExpandStateXML,
	m_XMLDoc,
	m_EnableDoubleClickActionsBool,--Boolean	:	Double Click Item actions : for example Edit , Open in Explorer
	m_EnableRightClickActionsBool,
	
	fn HiddenDotNetCommand exe args input=
	(
		dnp = CreateDotNetProcessor()
		dnp.execute exe args input
		--format "output:\n%" (dnp.output())
		--format "errors:\n%" (dnp.errors())
	),
	fn DirectoryExists _path=(
		_path
		pathArr = filterstring _path "\\"
		parentFolder = ""
		arrSize= ((pathArr.count))
		for i = 1 to (arrSize-1) do(
			append parentFolder pathArr[i]
			append parentFolder "\\"
		)
		filesArr = (getdirectories (parentFolder+"*"))
		for file in filesArr do(
			if((toUpper file) == (toUpper _path))then(
				return true
			)
		)
		return false
	),
	fn GetLocationByNode _node &_loc=(),
	fn GetLocationByPath _pathStr &_returnLoc=(),
	fn ExpandNode _node=(),
	
	m_ExpandStateArr,
	fn GetExpandState _targetXMLNode _nodeCollection=(
		xmlElement = undefined
		returnArr = #()
		
		for i = 0 to _nodeCollection.Count-1 do(
			
			
			_node = (_nodeCollection.Item[i])
-- 			showproperties _node
			if(_node.IsExpanded)then(
				xmlElement = (m_XMLDoc.CreateNode "element" "dataTreeNode" "")
				
				PairValue = DataPair()
				loc
				res = GetLocationByNode _node &loc
				if(res == true)then(
					xmlElement.SetAttribute "path" loc.m_RootFolder
					
-- 					PairValue.v1 = loc.m_RootFolder
				)
				
				(GetExpandState xmlElement _node.nodes)
				
				_targetXMLNode.appendChild xmlElement
				
-- 				append returnArr PairValue
				
			)
		)
		
		return xmlElement
		
		
	), -- GetExpandState
	
	fn ParseDashFromString _strValue=(
		strArr = filterString _strValue "\\"
		newStr = ""
		for str in strArr do(
			append newStr str
		)
		return newStr
		
	),
	
	fn ApplyStringStyle _strValue=(
		return (ParseDashFromString _strValue)
	),
	
	
	fn OpenInExplorer _path=(
		if(getFilenameType _path == ".ms")then(
			edit _path
			return true
		)
		try(
			processClass = (dotnetclass "System.Diagnostics.Process")
			processClass.start(_path)
		)catch(
			
			HiddenDotNetCommand "cmd.exe" ("\""+_path+"\"") ""
		)
-- 		messagebox _path
-- 		shellLaunch "explorer.exe" _path
		
	), --OpenInExplorer
	fn CreateXMLFile=(
		-- Creates an XMLFile if non exists
		if ((getfiles(m_SaveExpandStateXML)).Count ==0)then(
			--File Not Found
			f = createFile m_SaveExpandStateXML
			close f
		)
	), --CreateXMLFile
	fn SaveExpandState=(
		CreateXMLFile()
		m_ExpandStateArr = #()
		
-- 		m_XmlDoc.addChild res
		
		
		m_XmlDoc = dotNetObject "System.Xml.XmlDocument"
		m_XmlDoc.loadXML @"<?xml version='1.0' ?><treeView></treeView>"
		root = m_XmlDoc.FirstChild
-- 		showmethods root
-- 		m_XmlDoc.SelectNodes("treeView")
		treeViewNode = ( m_XmlDoc.SelectSingleNode "treeView")
		
		xmlElement = (m_XMLDoc.CreateNode "element" "data" "")
		treeViewNode.appendChild xmlElement
		
		xmlElement = (m_XMLDoc.CreateNode "element" "expandState" "")
		treeViewNode.appendChild xmlElement
-- 		messagebox root.GetItem["treeView"]
		res = GetExpandState xmlElement m_DotnetTreeView.nodes
		m_XmlDoc.Save m_SaveExpandStateXML
		

	), -- End SaveEpandState
	fn LoadExpandStateElement _nodes=(
		nodelist = _nodes
		for i = 1 to nodelist.Count do(
			xmlproject = nodelist.ItemOf[i - 1]
			projectPath = xmlproject.GetAttribute "path"
			loc
			res = GetLocationByPath projectPath &loc
			if(res == true)then(
				loc.Expand()
				loc.m_Node.Expand()
				LoadExpandStateElement (xmlproject.SelectNodes("dataTreeNode"))
			)
			
		)
	), -- End LoadExpandStateElement
	fn LoadExpandState=(
		
		m_XmlDoc = dotNetObject "System.Xml.XmlDocument"
		m_XmlDoc.Load m_SaveExpandStateXML
		LoadExpandStateElement (m_XmlDoc.SelectNodes("/treeView/expandState/dataTreeNode"))
		 -- End LoadExpandState
	),

	fn AppendExpandStateInArr _loc=(
		append m_SaveExpandStateArr _loc.m_RootFolder
-- 		SaveExpandState()
-- 		setinisetting ""m_SaveExpandStateIniFile _loc.m_RootFolder
	), -- End AppendExpandStateInArr
	fn Freeze _state=(
		m_Frozen = _state
		if(m_Frozen)then(
			for loc in m_Locations do(
				loc.Freeze true
			)
		)else(
			for loc in m_Locations do(
				loc.Freeze false
			)
		)
	), -- End Freeze
	fn FindInTreeView _nodeCollection _stringNode=(
		
		foundSomething = false
		for i = 0 to _nodeCollection.Count-1 do(
			_node = (_nodeCollection.Item[i])

			
			nodeLabel = ToLower _node.Text
			nodeLabel = substring nodeLabel 1 _stringNode.count
			
			searchString = ToLower _stringNode
			
			--Look for string in node Test
			foundResult = (findstring _node.Text searchString)
			
			
			if ((foundResult != undefined) and _stringNode != "")then
			(
				if(_node.parent != undefined)then(
					_node.parent.Expand()	
				)
				
				foundSomething =true
				_color = dotnetclass "System.Drawing.Color"
				_color = _color.FromArgb 0 0 255
	-- 			showmethods _color
				_node.BackColor = _color
	--             _node.TreeView.SelectedNode = _node
			)
			else
			(
				_node.BackColor = _node.TreeView.BackColor;
			)
			
			
			res = FindInTreeView _node.Nodes _stringNode;
			if(res == true)then(
			
-- 				showproperties _node
				
				foundSomething = true
				
				_node.Expand()
			)
			
			
		)
		return foundSomething 
	),  -- End FindInTreeView
	fn SearchNode_string _searchStr=(
		--Expand all if searchString is not ""
-- 		if(_searchStr == "")then(
-- 		if(m_isInExpandStateBool == false)then(
			m_isInExpandStateBool = true
			for loc in m_Locations do(
				loc.ExpandAll()
			)
			
-- 		)
-- 		)
		
		Freeze true
		FindInTreeView m_DotnetTreeView.nodes _searchStr
		Freeze false
	), -- End SearchNode_string
	fn GetLocationByPath _pathStr &_returnLoc=(
		for loc in m_Locations do(
			if(loc.m_RootFolder == _pathStr)then(
				_returnLoc = loc
				return true
			)
			
		)
		return false
	), -- End GetLocationByPath
	fn GetLocationByNode _node &_returnLoc=(
		for loc in m_Locations do(
			if(loc.m_Node== _node)then(
				_returnLoc = loc
				return true
			)
		)
		return false
	), -- End GetLocationByNode
	fn CreateLocation _path _type:"FILE" _depth:-1=(
		location = TreeViewBrowser_Location()
		location.Initiate location m_This _path _type Depth:_depth
		append m_Locations location
		return location
	), -- End CreateLocation
	fn AddLocation _folder labelString:false=(
		
		loc = TreeViewBrowser_Location()
		
		loc.Initiate loc m_This _folder "ROOT" Depth:0
		if(labelString != false)then(
			loc.SetLabel labelString
		)
		
		append m_Locations loc
		return loc
	), -- End AddLocation
	fn SetDotnetTreeView _dotnetTreeview=(
		m_DotnetTreeView = _dotnetTreeview
	), -- End SetDotnetTreeView
	fn Clear=(
		m_DotnetTreeView.Nodes.clear()
		m_Locations = #()
	),
	fn Refresh=(
-- 		SaveExpandState()
		
		m_DotnetTreeView.nodes.clear()
-- 		m_DotnetTreeView.Refresh()
		for location in m_Locations do(
			m_DotnetTreeView.nodes.add (location.GetNodes())
		)
		if(m_SaveExpandStateBool)then(
			LoadExpandState()	
		)
		
	), -- End Refresh
	fn GetActiveLocation _loc=(
		loc
		res = GetLocationByNode (m_DotnetTreeView.SelectedNode) &loc
		if(res == true)then(
			_loc = loc
			return true
		)
		return false
	), -- End GetActiveLocation
	fn ExpandNode _node=(
-- 		messagebox "expand"
		res = GetLocationByNode _node &loc
		if(res == true)then(
			loc.Expand()
		)
	), -- End ExpandNode
	fn DoubleClickNode _node=(
		if(m_EnableDoubleClickActionsBool)then(
			loc
			res = GetLocationByNode _node &loc
			if(res == true)then(
				
				if(loc.GetType() == "FILE")then(
					
					OpenInExplorer loc.m_RootFolder
				)
				
			)
		)
	), -- End DoubleClickNode
	fn CollapseNode _node=(
		res = GetLocationByNode _node &loc
		if(res == true)then(
			loc.Collapse()
		)
		
	), -- End CollapseNode
	function GetImageIDForExtension _extension=(
		for i = 1 to m_ImageListData.Count do(
			image = (m_ImageListData[i])
			for extension in image[2] do(
				if(extension == _extension)then(
					return (i - 1)
				)
			)
		)
		--Try look for the ".*" => All Good Icon
		for i = 1 to m_ImageListData.Count do(
			image = (m_ImageListData[i])
			for extension in image[2] do(
				if(extension == ".*")then(
					return (i - 1)
				)
			)
		)
		
		return -1
	), -- End GetImageIDForExtension
	function RemoveLocation _node =(
		loc = undefined
		GetLocationByNode _node &loc
		if(loc == undefined)then(
			return false
		)
		loc.Destroy()
		pos = findItem m_Locations loc
		deleteItem m_Locations pos
		
		return true
		
	), -- End RemoveLocation
	function Initiate _this _dotnetTreeview SaveExpandState:false DepthLimit:-1 ShowFiles:true ShowDirectories:true EnableDoubleClickActions:true EnableRightClickActions:true EnableLabelEdit:false=(
		if(SaveExpandState != false)then(
			m_SaveExpandStateXML = SaveExpandState
			m_SaveExpandStateBool = true
		)else(
			m_SaveExpandStateBool = false
		)
		m_isInExpandStateBool = false
		m_SaveExpandStateArr=#()
		m_DepthLimit = DepthLimit
		m_EnableDoubleClickActionsBool = EnableDoubleClickActions
		m_EnableRightClickActionsBool = EnableRightClickActions
		m_Frozen = false
		m_Listeners=#()
		m_This = _this
		m_ShowFilesBool = ShowFiles
		m_ShowDirectoriesBool = ShowDirectories
		m_Locations=#()
		m_DotnetTreeView = _dotnetTreeview
		m_DotnetImageList = (dotNetObject "System.Windows.Forms.ImageList")
		m_DotnetTreeView.ImageList = m_DotnetImageList
		
		m_DotnetTreeView.LabelEdit = EnableLabelEdit
		
		m_ImageListData = #()
	), -- End Initiate
	/*
	*   Event System
	*/
	function RemoveEventListener _Event _Function=(
		itemToDelete = -1
		for i = 1 to m_Listeners.count do(
			listenerObj = m_Listeners[i]
			if(listenerObj[1] == _Event and listenerObj[2] == _Function)then(
				itemToDelete = i
				exit
			)
		)
		if(itemToDelete == -1)then(
			return false
		)
		deleteItem m_Listeners itemToDelete
		return true
	),
	function AddEventListener _Event _Function=(
		append m_Listeners #(_Event, _Function)
	), -- End AddEventListener
	function MakeEventArguments _node OriginalEventArgument:undefined=(
		loc
		returnArr = #()
		res = GetLocationByNode _node &loc
		if(res == true)then(
			returnArr = loc.AsEventArgs OriginalEventArgument:OriginalEventArgument
		)
		return returnArr
	), -- End MakeEventArguments
	function SendEventListener _event _node OriginalEventArgument:undefined noNode:false=(
		
		if(_node == undefined and noNode == false)then(
			return false
		)
		
		for listenerObj in m_Listeners do(
			
			if(listenerObj[1] == _event)then(
				
				if(noNode)then(
					eventArguments = OriginalEventArgument
				)else(
					eventArguments = (MakeEventArguments _node OriginalEventArgument:OriginalEventArgument)	
				)
				
				if(eventArguments == #())then(
					messagebox "node problems "+(eventArguments as string)
					--Something went wrong with the selected node, don t exist anymore or something
					continue
				)
				listenerObj[2] eventArguments
			)
		)
	), -- End SendEventListener
	
	/*
	*	EVENTS
	*/
	function DoubleClick _EventArgs =(
-- 		showproperties _EventArgs
		
		DoubleClickNode m_DotnetTreeView.selectedNode
		SendEventListener "DoubleClick" m_DotnetTreeView.selectedNode OriginalEventArgument:_EventArgs
	), -- End DoubleClick
	
	function AfterExpand _EventArgs =(
		ExpandNode _EventArgs.Node
		SendEventListener "AfterExpand" _EventArgs.Node OriginalEventArgument:_EventArgs
	), -- End AfterExpand
	
	function AfterCollapse _EventArgs=(		
		CollapseNode _EventArgs.Node
		SendEventListener "AfterCollapse" _EventArgs.Node OriginalEventArgument:_EventArgs
	), -- End AfterCollapse
	
	function AfterLabelEdit _NodeLabelEditEventArgs=(
		m_isInExpandStateBool = false
		
		if(_NodeLabelEditEventArgs.CancelEdit ==true)then(
			return false
		)
		if(_NodeLabelEditEventArgs.Label == undefined)then(
			return false
		)
		loc
		GetLocationByNode _NodeLabelEditEventArgs.Node &loc
		loc.Rename _NodeLabelEditEventArgs.Label
		
		
	), -- End AfterLabelEdit
	function MouseUp _TreeNodeMouseClickEventArgs=(
		
		SendEventListener "MouseUp" undefined OriginalEventArgument:_TreeNodeMouseClickEventArgs noNode:true
	), --End MouseUp
	function NodeMouseClick _TreeNodeMouseClickEventArgs=(
-- 		_TreeNodeMouseClickEventArgs.Node
		if (_TreeNodeMouseClickEventArgs.Button == _TreeNodeMouseClickEventArgs.Button.Right )then(
			
			res = GetLocationByNode _TreeNodeMouseClickEventArgs.Node &loc
			if(res == true)then(
				if(m_EnableRightClickActionsBool == true)then(
					(loc.ShowRCMenu())
				)
			)			
		)
		
		SendEventListener "NodeMouseClick" _TreeNodeMouseClickEventArgs.Node OriginalEventArgument:_TreeNodeMouseClickEventArgs
	), -- End NodeMouseClick
	
	
	function AddImageList _iconFile _extensionArr=(
		
		imageClass = (dotNetClass "System.Drawing.Image" )
		fromFileResult = imageClass.FromFile(_iconFile)
		m_Image = (dotNetObject "System.Drawing.Image" fromFileResult)
		m_DotnetImageList.images.add m_Image
		
		append m_ImageListData #(_iconFile, _extensionArr)
		
	), -- End AddImageList
	function Save=(
		SaveExpandState()
	),
	function onClose =(
		SaveExpandState()
	), -- End Close
	function onOpen=(
		
	) -- End Open
)



rollout treeViewDemoRollout "tree" width:500(
	local MSPM_TreeViewBrowser
	local MSPM_TreeViewBrowser2
	
	edittext txt_search ""
	
	on txt_search entered _arg do(
		MSPM_TreeViewBrowser.SearchNode_string txt_search.text
		
	)
	
	dotNetControl TreeView_Project "system.windows.forms.treeView" height:600 across:2 width:450
-- 	dotNetControl TreeView_Project2 "system.windows.forms.treeView" height:600
	
	fn treeviewHandleClick _eventArgs=(
		
	)
	
	
	
	fn treeviewHandleNodeClick _eventArgs=(
		
-- 		 print _eventArgs.OriginalEventArgument
		if (_eventArgs.OriginalEventArgument.Button == _eventArgs.OriginalEventArgument.Button.Right )then(
			
		)
	)
	
	on treeViewDemoRollout close do(
		MSPM_TreeViewBrowser.RemoveEventListener "AfterExpand" treeviewHandleClick
		MSPM_TreeViewBrowser.RemoveEventListener "NodeMouseClick" treeviewHandleNodeClick
		
		MSPM_TreeViewBrowser.onClose()
	)
	
	on treeViewDemoRollout open do(
		
		
		
		MSPM_TreeViewBrowser = TreeViewBrowser()
		MSPM_TreeViewBrowser.Initiate MSPM_TreeViewBrowser TreeView_Project SaveExpandState:(symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\src\\expandState3.xml") DepthLimit:-1 ShowFiles:true ShowDirectories:false EnableDoubleClickActions:true EnableRightClickActions:true
		"$userScripts\\MaxScriptProjectManager\\src\\expandState.ini"
-- 		MSPM_TreeViewBrowser.AddLocation @"C:\"
		MSPM_TreeViewBrowser.AddLocation @"C:\Users\sven\AppData\Local\Autodesk\3dsMax\2011 - 64bit\enu\scripts\ToTex\"
		
-- 		MSPM_TreeViewBrowser.AddLocation @"C:\Users\sven\AppData\Local\Autodesk\3dsMax\2011 - 64bit\enu\scripts\MaxScriptProjectManager\"
		
		url = (symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\src\\icons\\")
		
		MSPM_TreeViewBrowser.AddImageList (url+"Icon_Folder.bmp") #(".")
		MSPM_TreeViewBrowser.AddImageList (url+"Icon_MaxScript.gif") #(".ms")
		MSPM_TreeViewBrowser.AddImageList (url+"Icon_Unknown.gif") #(".bmp",".png")
		
-- 		MSPM_TreeViewBrowser.AddLocation "c:/"
-- 		MSPM_TreeViewBrowser.AddLocation "c:/"
		MSPM_TreeViewBrowser.Refresh()
		TreeView_Project.LabelEdit = true
-- 		TreeView_Project.AllowDrop = True
		
		
		
-- 		TreeView_Project.AllowDrag = true
		MSPM_TreeViewBrowser.AddEventListener "AfterExpand" treeviewHandleClick
		MSPM_TreeViewBrowser.AddEventListener "NodeMouseClick" treeviewHandleNodeClick
		
		

	)
	
	on TreeView_Project AfterLabelEdit _args do(
		
		MSPM_TreeViewBrowser.AfterLabelEdit _args
	)
	
	on TreeView_Project DragEnter _args do(
		
	)
	
	on TreeView_Project MouseClick _args _args2 do(
		
	)
	
	on TreeView_Project Enter _arg do(
		
		
	)
	on TreeView_Project AfterExpand _args do(
		MSPM_TreeViewBrowser.AfterExpand _args
		MSPM_TreeViewBrowser.onClose()
	)
	on TreeView_Project AfterCollapse _args do(
		MSPM_TreeViewBrowser.AfterCollapse _args
	)
	on TreeView_Project DoubleClick _args do(
		MSPM_TreeViewBrowser.DoubleClick _args
		
	)
	
	on TreeView_Project NodeMouseClick _args do(
		MSPM_TreeViewBrowser.NodeMouseClick _args
	)
	

	
	
	
)

-- START DEMO
-- createDialog treeViewDemoRollout pos:[20,20]

