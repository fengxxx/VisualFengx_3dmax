/*
	havardsc@stud.ntnu.no
	-- "this." redundant? think so
*/
struct treeViewOps
(
	tv, mainDir,	treeNodeClass, extensionsFilter,	exList, imageList,	hideSource, copyNode, dragNode, dropNode, favFolder,
	
	fn populateTreeView dir  =
	(
		local filterStr = filterString dir "\\" 
		local dirName = filterStr[filterStr.count]
		local treeNode = dotNetObject this.TreeNodeClass dirName
		local subDirectories = getDirectories (dir + @"/*")
		treeNode.tag = dir
		treeNode.imageIndex = 2
		treeNode.selectedImageIndex = 2
		
		local subNodes = for n in subDirectories collect 
			this.populateTreeView n
		
		for i in (getFiles (@"" + dir + "*.*")) do
		(
			local imgIndex = 3
			if this.isSourceFile i then
				imgIndex = 4
			else if this.isScript i then
				imgIndex = 0
			else if this.isImage i then
				imgIndex = 1
						
			if this.extensionsFilter[1] == "" then
			(
				local childNode = (dotNetObject this.TreeNodeClass (fileNameFromPath i))
				childNode.tag = i
				childNode.imageIndex = childNode.selectedImageIndex  = imgIndex
				treeNode.nodes.add childNode
			)
			
			else if (findItem this.extensionsFilter (getFilenameType i)) != 0 then
			(
				local childNode = (dotNetObject this.TreeNodeClass (fileNameFromPath i))
				childNode.tag = i
				childNode.imageIndex = childNode.selectedImageIndex  = imgIndex
				treeNode.nodes.add childNode
			)
		)
		
		treeNode.nodes.addRange subNodes
		
		if dir == this.mainDir then
			treeNode.expand()
		
		treeNode
	),
	
	fn hideSourceFiles =
	(
		local topNode = this.tv.nodes.item[0]
		local nodes = for i = 0 to topNode.nodes.count - 1 where (substring topNode.nodes.item[i].text 1 4) == "_SO_" collect 
			topNode.nodes.item[i]
		for i in nodes do
			i.remove()
	),
	
	fn getNodeAtPoint pos =
		this.tv.getNodeAt (dotNetObject "System.Drawing.Point" pos.x pos.y),
	
	fn getSelectedNode =
		this.tv.selectedNode,
	
	fn refreshView treeView =
	(
		this.tv.nodes.clear()
		this.init treeView inputDir:this.mainDir
	),
	
	fn deleteNode theNode =
	(
		if theNode != undefined then
		(
			if (queryBox ("Delete " + theNode.text + " ?") caption:"Delete file") then
			(
				if this.isFolder theNode.tag then
					hiddenDOSCommand ("rmdir " + "\""+ (@"" + theNode.tag) + "\"" + " /Q /S" )   
				else
					hiddenDOSCommand ("del " + "\""+ (@"" + theNode.tag) + "\"") 
				theNode.remove()
			)
		)
	),
	
	fn renameNode theNode =
	(
		if theNode != undefined  then
			theNode.beginEdit()
	),
	
	fn moveNode theNode destNode= 
	(
		if theNode != undefined and destNode != undefined then
		(
			if destNode.text == "_favourites" then
			(
				if (this.isFolder theNode.tag) then
				(
					local moveString = "xcopy " + "\"" + @"" +getFileNamePath(theNode.tag)
					moveString = replace moveString moveString.count 1 ""
					local destString =   "\"" + " \"" + (getFilenamePath destNode.tag) + "\"" + "/S"
					hiddenDOSCommand (moveString + destString)
				)
				else
					hiddenDOSCommand ("copy " + "\"" + theNode.tag +  "\" " + "\"" + (getFilenamePath destNode.tag) + "\"")
			)
			else if (this.isFolder theNode.tag) then
			(
				local moveString = "move " + "\"" + @"" +getFileNamePath(theNode.tag)
				moveString = replace moveString moveString.count 1 ""
				local destString =   "\"" + " \"" + (getFilenamePath destNode.tag) + "\""
				hiddenDOSCommand (moveString + destString)
			)
			else
				hiddenDOSCommand ("move " + "\"" + theNode.tag +  "\" " + "\"" + (getFilenamePath destNode.tag) + "\"")
		)
	),

	fn copySelNode =
		this.copyNode = this.getSelectedNode(),
	
	fn pasteNode =
	(
		local destNode  = this.getSelectedNode()
		if this.copyNode != undefined and destNode != undefined and this.copyNode != destNode then
		(
			local newNode = this.copyNode.clone()
			if (this.isFolder copyNode.tag) then
			(
				local moveString = "xcopy " + "\"" + @"" +getFileNamePath(this.copyNode.tag)
				moveString = replace moveString moveString.count 1 ""
				if (this.isFolder destNode.tag) then
				(					
					local destString =   "\"" + " \"" + (getFilenamePath destNode.tag) + "\"" + "/S"
					hiddenDOSCommand (moveString + destString)
				)
				else 
				(
					local destString =   "\"" + " \"" + (getFilenamePath destNode.parent.tag) + "\"" + "/S"
					hiddenDOSCommand (moveString + destString)
				)
				destNode.nodes.insert 0 newNode
			)
			else
			(
				if (this.isFolder destNode.tag) then
				(
					hiddenDOSCommand ("copy " + "\"" + this.copyNode.tag +  "\" " + "\"" + (getFilenamePath destNode.tag) + "\"")
					destNode.nodes.insert 0 newNode
				)
				else
				(
					hiddenDOSCommand ("copy " + "\"" + this.copyNode.tag +  "\" " + "\"" + (getFilenamePath destNode.parent.tag) + "\"")
					destNode.parent.nodes.insert 0 newNode
				)
			)
		)
	),
	
	fn isScript nodePath = 
	(
		if (findItem exList[1] (getFilenameType nodePath)) != 0 then
			true
		else
			false
	),
	
	fn isSourceFile nodePath =
	(
		if (substring (getFilenameFile nodePath) 1 4) == "_SO_" then
			true
		else
			false
	),
	
	fn isImage nodePath = 
	(
		if (findItem exList[2] (getFilenameType nodePath)) != 0 then
			true
		else
			false
	),
	
	fn isFolder nodePath =
	(
		if (getFilenameType nodePath) == "" then
			true
		else 
			false
	),
		
	fn createFolder theNode folderName refresh:true imgIndex:2=
	(
		if theNode != undefined then
		(
			local childNode = (dotNetObject this.TreeNodeClass folderName)
			childNode.imageIndex = childNode.selectedImageIndex  = 2
			if (this.isFolder theNode.tag) then
			(
				try
				(
					theNode.expand()
					childNode.tag = (theNode.tag + folderName)
					theNode.nodes.add childNode
					hiddenDOSCommand (" mkDir " + "\"" + childNode.tag + "\"")
				)
				catch
					messageBox "Could not create file, you need to have writing rights to the folder!"
			)
			else
			(
				try
				(
					childNode.tag = (theNode.parent.tag + folderName)
					theNode.parent.nodes.add childNode
					hiddenDOSCommand ("mkDir " + "\"" + childNode.parent.tag + "\"")
				)
				catch
					messageBox "Could not create file, you need to have writing rights to the folder!"
			)
			if refresh then
				this.refreshView this.tv
		)
	),
	
	fn favFolderCheck =
	(
		for i = 0 to ((this.tv.nodes.item 0).nodes.count - 1) while this.favFolder == undefined do
		(
			local curNode = ((this.tv.nodes.item 0).nodes.item i)
			if curNode.text == "_favourites" then
			(
				this.favFolder = curNode
				curNode.imageIndex = 5
				curNode.selectedImageIndex = 5
			)
		)
		if this.favFolder == undefined then
			createFolder (this.tv.nodes.item 0) "_favourites" refresh:false imgIndex:5		
		else
		(
			this.favFolder.imageIndex = 5
			this.favFolder.selectedImageIndex = 5
		)
	
	),
	
	fn startUpCheck = 
	(
		if getIniSetting (mainDir + @"_SO_\scriptOrganizer.ini") "Options" "startupCheck" == "true" then
		(
			local found = false
			for i in  (getFiles (getDir #startupScripts + @"\*.ms")) where (getFilenameFile i) == "scriptOrganizerStartup" do 
				found = true
			if not found then
			(
				if queryBox "Run this script at startup?" beep:false then
				(
					format "fileIn %" ("\"" + getFilenamePath(getSourceFileName()) + "_SO_ScriptOrganizer.ms" + "\"") to:(openFile "$startupscripts\scriptOrganizerStartup.ms" mode:"w")
					setIniSetting (mainDir + "scriptOrganizer.ini") "Options" "StartupCheck"  "false"
				)
			)
		)
	),
	
	fn createScript theNode =
	(
		if theNode != undefined then
		(
			local childNode = (dotNetObject this.treeNodeClass "renameMe.ms")
			childNode.imageIndex = childNode.selectedImageIndex = 0
			if (this.isFolder theNode.tag) then
			(
				try 
				(
					theNode.expand()
					childNode.tag = (theNode.tag + "renameMe.ms")
					theNode.nodes.add childNode
					createFile childNode.tag
				)
				catch
					messageBox "Could not create file, you need to have writing rights to the folder!"
			)
			else
			(
				childNode.tag = (theNode.parent.tag + "renameMe.ms")
				theNode.parent.nodes.add childNode
				createFile childNode.tag
			)
			this.tv.selectedNode = childNode
		)
	),
	
	fn init tv inputDir: "" = 
	(
		this.tv = tv
		
		if inputDir == "" then
			this.mainDir = getFilenamePath(getSourceFilename())
		else 
			this.mainDir = inputDir
		this.tv.allowDrop = true
		this.tv.sorted = true
		this.tv.scrollable = true
		this.tv.labelEdit = true
		this.treeNodeClass = dotnetclass "System.Windows.Forms.TreeNode"
	--	this.tv.imageList = this.getIconList()
		this.tv.Nodes.add (populateTreeView this.mainDir)
		this.startupCheck()
		this.favFolderCheck()
		if this.hideSource then
			this.hideSourceFiles()
	)
)