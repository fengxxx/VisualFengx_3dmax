/*
	havardsc@stud.ntnu.no
	TODO:
		- Fix renaming issues
		- Folders sorted first
		- Get eventhandlers in the treeview struct (currently in the GUI-control) - or the most of the event handler code should be in the treeViewStruct :(
*/

global scriptorganizerFloater, treeViewRollout, hotBarRollout, currentDir, iniDir

try (cui.UnRegisterDialogBar scriptorganizerFloater) catch()
try (cui.UnRegisterDialogBar hotBarRollout) catch()
try (closeRolloutFloater scriptorganizerFloater) catch()
try (destroyDialog hotBarRollout) catch()


fileIn "_SO_treeViewStruct.ms" quiet:true	

(
	dotNet.loadAssembly (getFilenamePath(getSourceFilename()) + @"scriptorganiser.dll")
	clearListener() -- tmp
	local currentDir =  (getFilenamePath(getSourceFilename()))
	--Options
	iniDir = currentDir + @"\" + "scriptOrganizer.ini"
	local topDir = replace currentDir (currentDir.count - 4) 4 ""
	local version = 1.1
	local nodeRightClickMenu, scriptorganizerTreeView, hotBarRClickNode
	local scriptsOnly = true
	local currentExtensionFilter = 1
	local extensionsList = #( #(".ms", ".MS", ".mcr", ".MCR", ".mse", ".MSE", ".mzp", ".MZP"), \
		#(".jpg", ".JPG", ".jpeg", ".JPEG", ".gif", ".GIF", ".png", ".PNG", ".tiff", ".TIFF", ".bmp", ".BMP", ".tga", ".TGA", ".ico", ".ICO"), \
		#(""))
	
	struct hotBarRightClickStruct
	(
		nodePath, icoIndex, pathIndex
	)
	
	struct windowStruct 
	(
		winName, handle
	)
	
	rcmenu nodeRightClickMenu 
	(
		menuItem muRun "Execute "
		menuItem muEdit "Edit"
		menuItem muRename "Rename (F2)"
		menuItem muDelete "Delete (Del)"
		menuItem muRefreshView "Refresh view (F5)"
		menuItem muFileProperties "File properties"
		seperator sep1
		menuItem muCopy "Copy"
		menuItem muPaste "Paste"
		seperator sep2
		menuItem muNewScript "New script"
		menuItem muNewFolder "New folder"
		seperator sep4
		menuItem muScriptFilt "Show scripts only" checked:(currentExtensionFilter == 1) enabled:(not(currentExtensionFilter == 1))
		menuItem muImgFilt "Show images only" checked:(currentExtensionFilter == 2) enabled:(not(currentExtensionFilter == 2))
		menuItem muNoFilt "No filters" checked:(currentExtensionFilter == 3) enabled:(not(currentExtensionFilter == 3))
		seperator sep5
		menuItem muShowOrig "Show source files" checked:(not scriptorganizerTreeView.hideSource)
		seperator sep6
		menuItem muAbout "About"
		menuItem muTest "Version" 
		
		on nodeRightClickMenu open do
			muTest.text = ("Version: " + version as string)
			
		on muTest picked do
		(
			--edit (getFilenamePath(getSourceFilename()))
			print ((dotNetObject "scriptorganiser.windowsOps").getCurrentWindow())
			print ((dotNetObject "scriptorganiser.windowsOps").getProcesses())
		)
			
		on muRun picked do
		(
			local selectedNode = scriptorganizerTreeView.getSelectedNode()
			if selectedNode != undefined do
			(
				if (findItem extensionsList[1] (getFilenameType selectedNode.tag)) != 0 then
					fileIn selectedNode.tag
				else
					ShellLaunch selectedNode.tag ""
			)
		)
		
		on muEdit picked do
		(
			local selectedNode = scriptorganizerTreeView.getSelectedNode()
			if (scriptorganizerTreeView.isFolder selectedNode.tag) then
				ShellLaunch selectedNode.tag ""
			else
				edit selectedNode.tag
		)
		
		on muRename picked do
			scriptorganizerTreeView.renameNode (scriptorganizerTreeView.getSelectedNode() )
				
		on muDelete picked do
			scriptorganizerTreeView.deleteNode (scriptorganizerTreeView.getSelectedNode() )
		
		on muRefreshView picked do
			scriptorganizerTreeView.refreshView scriptorganizerTreeView.tv
		
		on muFileProperties picked do
			(dotNetObject "scriptorganiser.filePropertiesOps").showFileProperties  (scriptorganizerTreeView.getSelectedNode() ).tag
		
		on muCopy picked do
			scriptorganizerTreeView.copySelNode()
		
		on muPaste picked do
			scriptorganizerTreeView.pasteNode()
		
		on muAddToFavourites picked do
		(
			local thisNode = scriptorganizerTreeView.getSelectedNode()
			local destNode = undefined
			print scriptorganizerTreeView.tv.nodes
			/*
			hiddenDOSCommand ("copy " + "\"" + thisNode.tag +  "\" " + "\"" + (getFilenamePath destNode.tag) + "\"")
			destNode.nodes.insert 0 newNode*/
		)
				
		on muNewScript picked do
			scriptorganizerTreeView.createScript (scriptorganizerTreeView.getSelectedNode())
		
		on muNewFolder picked do
			scriptorganizerTreeView.createFolder (scriptorganizerTreeView.getSelectedNode()) "renameMe"
		
		on muScriptFilt picked do
		(
			if muScriptFilt.enabled then
			(
				muScriptFilt.checked = true
				muScriptFilt.enabled = false
				muImgFilt.checked = false
				muImgFilt.enabled = true
				muNoFilt.checked = false
				muNoFilt.enabled = true
				
				currentExtensionFilter = 1
				scriptorganizerTreeView.extensionsFilter = extensionsList[1]
				scriptorganizerTreeView.refreshView scriptorganizerTreeView.tv
			)
		)
		
		on muImgFilt picked do
		(
			if muImgFilt.enabled then
			(
				muImgFilt.checked = true
				muImgFilt.enabled = false
				muScriptFilt.checked = false
				muScriptFilt.enabled = true
				muNoFilt.checked = false
				muNoFilt.enabled = true
				
				currentExtensionFilter = 2
				scriptorganizerTreeView.extensionsFilter = extensionsList[2]
				scriptorganizerTreeView.refreshView scriptorganizerTreeView.tv
			)
		)
		
		on muNoFilt picked do
		(
			if muNoFilt.enabled then
			(
				muNoFilt.checked = true
				muNoFilt.enabled = false
				muScriptFilt.checked = false
				muScriptFilt.enabled = true
				muImgFilt.checked = false
				muImgFilt.enabled = true
				
				currentExtensionFilter = 3
				scriptorganizerTreeView.extensionsFilter = extensionsList[3]
				scriptorganizerTreeView.refreshView scriptorganizerTreeView.tv
			)
		)
		
		on muShowOrig picked do
		(
			if muShowOrig.checked then
			(
				scriptorganizerTreeView.hideSource = true
				muShowOrig.checked = false
			)
			else 
			(
				scriptorganizerTreeView.hideSource = false
				muShowOrig.checked = true
			)
			scriptorganizerTreeView.refreshView scriptorganizerTreeView.tv
		)
		
		on muAbout picked do
			hiddenDOSCommand ("start " + "http://folk.ntnu.no/havardsc/site/wordpress/?page_id=411")
		
	)
	
	rollout treeViewRollout "Script organizer"
	(

		dotNetControl treeView "system.windows.forms.treeView" width:245 height:390 pos:[0,0]--250 400
		
		on treeViewRollout open do
		(
			local parent = getFilenamePath(getSourceFilename())
			local startIndex = findString parent @"MXSExtendedEditor\"
			parent = replace parent startIndex 18 ""

			scriptorganizerTreeView = treeViewOps hideSource:true exList:extensionsList  extensionsFilter:extensionsList[1]
			scriptorganizerTreeView.init treeView inputDir:parent
		)

		on treeViewRollout resized arg do
		(
			treeViewRollout.width = arg[1]
			treeViewRollout.height = scriptorganizerFloater.size[2] - 30
			scriptorganizerTreeView.tv.height = scriptorganizerFloater.size[2] - 15
			scriptorganizerTreeView.tv.width = treeViewRollout.width - 10
		)
		
		on treeView mouseDoubleClick arg do
		(
			local hitNode = scriptorganizerTreeView.getNodeAtPoint arg
			if hitNode != undefined do
			(
				if (findItem extensionsList[1] (getFilenameType hitNode.tag)) != 0 then
					fileIn hitNode.tag
				else
					ShellLaunch hitNode.tag ""
			)
		)
		
		on treeView mouseClick arg do
		(
			local hitNode = scriptorganizerTreeView.getNodeAtPoint arg
			scriptorganizerTreeView.tv.selectedNode = hitNode
			if arg.button.value__ == 2097152 then
			(
				nodeRightClick = hitNode
				popupmenu nodeRightClickMenu
			)
		)
		
		on treeView afterCollapse arg do
			if arg.node.text != "_favourites" then
				arg.node.imageIndex = arg.node.selectedImageIndex = 2
		
		on treeView afterExpand arg do
		(
			if arg.node.text != "_favourites" then
				arg.node.imageIndex = arg.node.selectedImageIndex = 6
		)
		
		on treeView afterLabelEdit arg do
		(
			if arg.label != undefined then
			(
				local theNode = scriptorganizerTreeView.getSelectedNode()
				if (getFilenameType theNode.tag) != "" then
					renameFile theNode.tag ((getFileNamePath theNode.tag) + arg.label)
				else
					HiddenDOSCommand ("rename " + "\"" + theNode.tag + "\"" + " " + "\"" + (getFilenameFile arg.label) + "\"") 
			)
		)
		
		on treeView keyDown arg do
		(
			local theNode = scriptorganizerTreeView.getSelectedNode()
			if arg.keyCode.value__ == 113 then	--F2
				scriptorganizerTreeView.renameNode theNode
			else if arg.keyCode.value__ == 46 then --Del
				scriptorganizerTreeView.deleteNode theNode
			else if arg.keyCode.value__ == 116 then	--F5
				scriptorganizerTreeView.refreshView scriptorganizerTreeView.tv
		)
		
		on treeView itemDrag arg do
		(
			scriptorganizerTreeView.dragNode = arg.item
			if arg.item != undefined do
				scriptorganizerTreeView.tv.doDragDrop scriptorganizerTreeView.dragNode (dotNetclass ("System.Windows.Forms.DragDropEffects")).move
		)
		
		on treeView dragOver arg do
		(
			if (scriptorganizerTreeView.dragNode != undefined) and (arg.data.GetDataPresent(dotNetClass "System.Windows.Forms.TreeNode")) do
			(
				arg.effect = (dotNetclass "System.Windows.Forms.DragDropEffects").move				
				local position = dotNetObject "System.Drawing.Point" arg.x arg.y
				position = scriptorganizerTreeView.tv.pointToClient position
				
				scriptorganizerTreeView.dropNode = scriptorganizerTreeView.tv.GetNodeAt position
				
				if scriptorganizerTreeView.dropNode != undefined do 
				(
					scriptorganizerTreeView.tv.selectedNode = scriptorganizerTreeView.dropNode
				--	if (scriptorganizerTreeView.isFolder scriptorganizerTreeView.dropNode.tag) and not scriptorganizerTreeView.dropNode.isExpanded then
						--scriptorganizerTreeView.dropNode.expand() --annoying shit!
				)
			)
		)
		
		on treeView dragDrop arg do
		(
			if (scriptorganizerTreeView.dropNode != undefined) and (scriptorganizerTreeView.dragNode != undefined) do
			( 
				if (scriptorganizerTreeView.dropNode != scriptorganizerTreeView.dragNode) do
				(
					local newNode = scriptorganizerTreeView.dragNode.clone()
					if (scriptorganizerTreeView.isFolder scriptorganizerTreeView.dropNode.tag) then
					(
						scriptorganizerTreeView.moveNode scriptorganizerTreeView.dragNode scriptorganizerTreeView.dropNode
						scriptorganizerTreeView.dropNode.nodes.insert 0 newNode
						if scriptorganizerTreeView.dropNode.text != "_favourites" then
							scriptorganizerTreeView.dragNode.remove()
					)
					else if (scriptorganizerTreeView.dropNode.parent != scriptorganizerTreeView.dragNode.parent) do
					(
						scriptorganizerTreeView.moveNode scriptorganizerTreeView.dragNode scriptorganizerTreeView.dropNode.parent
						scriptorganizerTreeView.dropNode.parent.nodes.insert 0 newNode
						if scriptorganizerTreeView.dropNode.text != "_favourites" then
							scriptorganizerTreeView.dragNode.remove()
					)
				)
				scriptorganizerTreeView.tv.sort()
			)
		)
	)
	--scriptorganizerFloater = newRolloutFloater "Script organizer" 250 400 0 0
)

scriptorganizerFloater = newRolloutFloater "Script organizer" 250 400 0 0
addRollout treeViewRollout scriptorganizerFloater border:false
