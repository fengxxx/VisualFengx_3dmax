struct MSPM_System_Project(
	m_XMLNode,
	function GetProjectVersion=(),
	function GetProjectLocation=(),
	function Initiate _MSPMProjectXMLNode=(
		m_XMLNode = _MSPMProjectXMLNode
	),
	function GetListViewRowArr=(
		dataArray =#()
		folderPath = (m_XMLNode.GetAttribute "path")
		
		stringArr = (filterstring folderPath "\\")
		projectName = stringArr[stringArr.count]
		
		append dataArray projectName
		append dataArray (GetProjectLocation())
		append dataArray folderPath
		return dataArray
	),
	function SetEnabled _value=(
		enableValue = m_XMLNode.SetAttribute "enabled" (_value as string)
		m_MSPM_System.Save()
	),
	function GetEnabled=(
		enableValue = m_XMLNode.GetAttribute "enabled"
		if(enableValue == undefined)then(
			enableValue = false
		)
		if(enableValue == "true")then(
			enableValue =  true
		)
		if(enableValue == "false")then(
			enableValue =  false
		)
		return enableValue
	),
	
	function GetPublishRepositoryVersion =(
		m_XMLNode.GetAttribute "PublishRepositoryVersion"
	),
	function SetPublishRepositoryVersion _arg=(
		m_XMLNode.SetAttribute "PublishRepositoryVersion" (_arg as string)
	),
	function SetMSMCompatible _arg=(
		m_XMLNode.SetAttribute "MSMCompatible" (_arg as string)
	),
	function GetMSMCompatible=(
		return m_XMLNode.GetAttribute "MSMCompatible"
	),
	function GetPublishRepositoryName=(
		m_XMLNode.GetAttribute "PublishRepositoryName"
	),
	function SetPublishRepositoryName _arg=(
		m_XMLNode.SetAttribute "PublishRepositoryName" (_arg as string)
	),
	function SetPublishRepository _value=(
		m_XMLNode.SetAttribute "PublishRepository" (_value as string)
	),
	function GetPublishRepository=(
		return m_XMLNode.GetAttribute "PublishRepository"
	),
	function SetUninstallMS _path=(
		m_XMLNode.SetAttribute "uninstallMS" (_path as string)
		m_MSPM_System.Save()
	),
	function GetUninstallMS=(
		return m_XMLNode.GetAttribute "uninstallMS"
	),
	function SetInstallerMS _path=(
		m_XMLNode.SetAttribute "installerMS" (_path as string)
		m_MSPM_System.Save()
	),
	function GetInstallerMS=(
		return m_XMLNode.GetAttribute "installerMS"
	),
	function GetInstallerImage=(
		return m_XMLNode.GetAttribute "installerImage"
	),
	function SetInstallerImage _path=(
		m_XMLNode.SetAttribute "installerImage" (_path as string)
		m_MSPM_System.Save()
	),
	function SetPath _path=(
		m_XMLNode.SetAttribute "path" (_path as string)
		m_MSPM_System.Save()
	),
	function GetPath=(
		return (m_XMLNode.GetAttribute "path")
	),
	function GetProjectName=(
		pathStr = (m_XMLNode.GetAttribute "path")
		stringArr = (filterstring pathStr "\\")
		projectName = stringArr[stringArr.count]
		return projectName
	),
	function GetProjectLocation=(
		pathStr = (m_XMLNode.GetAttribute "path")
		userScriptsPath = (symbolicPaths.getPathValue("$userScripts"))
		if( (findstring pathStr userScriptsPath) != undefined)then(
			return "userScripts"
		)
		scriptPath = (symbolicPaths.getPathValue("$Scripts"))
		if( (findstring pathStr scriptPath) != undefined)then(
			return "Scripts"
		)
	),
	function SetCategory _Str=(
		(m_XMLNode.SetAttribute "category" _Str)
		m_MSPM_System.Save()
	),
	function GetCategory=(
		pathStr = (m_XMLNode.GetAttribute "category")
		return pathStr
	),
	m_RepositoryXMLDocument,
	function GetRepositoryXMLDocument=(
		return m_RepositoryXMLDocument
	),
	function SetRepositoryXMLDocument _xmlDoc=(
		m_RepositoryXMLDocument = _xmlDoc
		m_MSPM_System.SendEventListener "ProjectEditRepositoryXMLDocument"
	),
	function GetProjectVersion=(
		pathStr = (m_XMLNode.GetAttribute "version")
		return (filenameFromPath pathStr)
	),
	function SetProjectVersion _versionStr=(
		(m_XMLNode.SetAttribute "version" _versionStr)
		m_MSPM_System.Save()
		m_MSPM_System.SendEventListener "ProjectEditVersion"
	),
	function SetDonate _urlStr=(
		(m_XMLNode.SetAttribute "donate" _urlStr)
		m_MSPM_System.Save()
	),
	function GetDonate=(
		pathStr = (m_XMLNode.GetAttribute "donate")
		return pathStr
	),
	function GetSite=(
		pathStr = (m_XMLNode.GetAttribute "site")
		return pathStr
	),
	function GetDonate=(
		pathStr = (m_XMLNode.GetAttribute "donate")
		return pathStr
	),
	function GetSite=(
		pathStr = (m_XMLNode.GetAttribute "site")
		return pathStr
	),
	function SetSite _urlStr=(
		(m_XMLNode.SetAttribute "site" _urlStr)
		m_MSPM_System.Save()
	),
	function GetRepositoryUrl=(
		pathStr = (m_XMLNode.GetAttribute "repositoryUrl")
		return pathStr
	),
	function SetRepositoryUrl _urlStr=(
		(m_XMLNode.SetAttribute "repositoryUrl" _urlStr)
		m_MSPM_System.Save()
	),
	function GetScriptID=(
		pathStr = (m_XMLNode.GetAttribute "scriptID")
		return pathStr
	),
	function SetScriptID _id=(
		
		(m_XMLNode.SetAttribute "scriptID" _id)
		m_MSPM_System.Save()
	),
	function GetXMLNode=(
		return (m_XMLNode)
	),
	function CreateNewXMLNode _xmlDoc=(
		newProjectNode = (_xmlDoc.CreateNode "element" "mspmProject" "")
		newProjectNode.SetAttribute "path" "_path"
		newProjectNode.SetAttribute "enabled" "true"
		newProjectNode.SetAttribute "version" "0.0"
		return newProjectNode
	),
	function GetFilesArr _path Type:".*"=(
 		returnfilesArr = #()
		
		if(classof Type == Array)then(
			for TypeObj in Type do(
						for file in (getfiles (_path+"*")) do(
					
					if(Type ==".*" or ((getFilenameType file)) == TypeObj)then(
						append returnfilesArr file
					)
					
					
				)
				for dir in (getdirectories  (_path+"*")) do(
					returnFiles = GetFilesArr dir Type:TypeObj
					join returnfilesArr returnFiles
				)
			)
			return returnfilesArr
		)
		
		for file in (getfiles (_path+"*")) do(
			
			if(Type ==".*" or ((getFilenameType file)) == Type)then(
				append returnfilesArr file
			)
			
			
		)
		for dir in (getdirectories  (_path+"*")) do(
			returnFiles = GetFilesArr dir Type:Type
			join returnfilesArr returnFiles
		)
		
		return returnfilesArr
	),
	function GetProjectFilesFilePathAsArr Type:".*"=(
		
		pathStr = (m_XMLNode.GetAttribute "path")
		return (GetFilesArr pathStr Type:Type)
	)
	
)

struct MSPM_System(
	m_XMLDoc,
	m_XMLUrlStr,
	m_ProjectsArr,
	m_Listeners,
	function SendEventListener _event=(),
	
	function OpenFilePath _path=(
		hiddendoscommand ("\""+_path+"\"")
	),
	-- Opens the wanted path in Internet Explorer
	function ShowInExplorer _path=(
-- 		messagebox _path
		try(
		processClass = (dotnetclass "System.Diagnostics.Process")
		processClass.start(_path)
		)catch(
			shelllaunch "explorer.exe" _path	
		)
		
	),
	function EditMaxScriptFile _path=(
		edit _path
	),
	function RunMaxScriptFile _path=(
		filein _path
	),
	function GetUniqueDirectoryName _path=(
		pathPiecesArr = filterstring _path "\\"
		parentPath = ""
		numPieces = (pathPiecesArr.count)
		numInForLoop = numPieces - 1
		for i = 1 to (numInForLoop)do(
			append parentPath pathPiecesArr[i]
			append parentPath "\\"
		)
		folderName = pathPiecesArr[(pathPiecesArr.count)]
		
		found = false
		i = 0
		newDirectoryName = ""
		
		
		
		while found ==false do(
			i = i+1
			possibleDirectoryName = parentPath + folderName + "_" + (i as string) + "\\"
			foundinLoop = false
			
			for dir in (GetDirectories (parentPath+"*")) do(
				
				if(dir == possibleDirectoryName)then(
					foundinLoop = true
				)
			)	
			if(foundinLoop == false)then(
				found = true
				newDirectoryName = possibleDirectoryName
			)
		)
		
		return newDirectoryName
		
		
		
	),
	function GetUniqueFileName _path=(
		if ((getfiles _path).count == 0)then(
			return _path
		)
		folderPathStr = getFilenamePath _path
		extensionStr = getFilenameType _path
		fileName = getFilenameFile _path
		
		found = false
		i = 0
		newFileName = ""
		while found == false do(
			i = i +1
			possibleFileName = folderPathStr+fileName+"_"+(i as string)+extensionStr
			if((getfiles possibleFileName).count == 0)then(
				newFileName = possibleFileName
				found = true
			)
			
		)
		
		return newFileName
	),
	function CreateNewXML _path editFile:false=(
		newFileNameStr = GetUniqueFileName (_path + "new.xml")
		templateFile = (symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\template\\XML_Template\\XML_Template.xml")
		res = copyfile templateFile newFileNameStr
		if(res)then(
			if(editFile)then(
				EditMaxScriptFile newFileNameStr
			)
		)
	),
	function CreateNewIni _path editFile:false=(
		newFileNameStr = GetUniqueFileName (_path + "new.ini")
		templateFile = (symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\template\\INI_Template\\INI_Template.ini")
		res = copyfile templateFile newFileNameStr
		if(res)then(
			if(editFile)then(
				EditMaxScriptFile newFileNameStr
			)
		)
	),
	function CreateNewFolder _path=(
		newDirectoryName = GetUniqueDirectoryName (_path + "New Folder")
		makedir newDirectoryName
	),
	function CreateNewMaxScriptFile _path editFile:false=(
		
		newFileNameStr = GetUniqueFileName (_path + "new.ms")
		
		templateFile = (symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\template\\MS_Template\\MS_Template.ms")
		res = copyfile templateFile newFileNameStr
		if(res)then(
			if(editFile)then(
				EditMaxScriptFile newFileNameStr
			)
		)
		
		
		return res
	),
	function GetProjectsListviewArr=(
		returnArr = #()
		
		for proj in m_ProjectsArr do(
			append returnArr (proj.GetListviewRowArr())
		)
		
		return returnArr
	),
	function GetProjectsNameArr=(
		returnArr = #()
		
		for proj in m_ProjectsArr do(
			append returnArr (proj.GetProjectName())
		)
		
		return returnArr
	),
	function GetProjectFirstInArray=(
		if(m_ProjectsArr.count == 0)then(
			return undefined
		)else (
			return m_ProjectsArr[1]
		)
	),
	function GetProjectByPath _projectPath=(
		for proj in m_ProjectsArr do(
			if((findstring _projectPath (proj.GetPath())) != undefined)then(
				return proj
			)
-- 			if (proj.GetPath() ==_projectPath) then(
-- 				return proj
-- 			)
		)
		return undefined
	),
	function GetProjectByName _projectName=(
		for proj in m_ProjectsArr do(
			if (proj.GetProjectName() ==_projectName ) then(
				return proj
			)
		)
		return undefined
	),
	function GetFileNameFromPathArrStringAsArray _arr=(
		returnArr = #()
		for pathStr in _arr do(
			append returnArr  (filenameFromPath pathStr)
		)
		return returnArr
		
	),
	function GetProjectPathStringArr=(
		returnArr = #()
		for proj in m_ProjectsArr do(
			append returnArr (proj.GetPath())
		)
		return returnArr
	),
	function GetXMLDoc=(
		return m_XMLDoc
	),
	fn ReadProjects _xmlUrl=(
		
		m_XMLUrlStr = _xmlUrl
		m_XmlDoc = dotNetObject "System.Xml.XmlDocument"
		m_XmlDoc.load _xmlUrl
		root = m_XmlDoc.FirstChild
		 
		mspmProjectNodes = ( m_XmlDoc.SelectNodes "mspm/mspmProjects/mspmProject")
		
		
		for i = 1 to mspmProjectNodes.Count do(
			
			mspmProjectNode = mspmProjectNodes.ItemOf[i - 1]
			proj = MSPM_System_Project()
			proj.Initiate mspmProjectNode
			append m_ProjectsArr proj
		)
	),
	function Save =(
		m_XMLDoc.save m_XMLUrlStr
	),
	function Initiate _xmlUrl=(
		m_Listeners=#()
		m_ProjectsArr = #()
		ReadProjects _xmlUrl
		
	),
	fn RemoveProjectByPath _path=(
		for i = 1 to m_ProjectsArr.Count do(
			projObj = m_ProjectsArr[i]
			if(projObj.GetPath() == _path)then(
				
				mspmProjectNode = ( m_XmlDoc.SelectSingleNode "mspm/mspmProjects")
				
				mspmProjectNode.RemoveChild (projObj.GetXMLNode())
				
				deleteItem m_ProjectsArr i
				exit;
			)
		)
		m_XMLDoc.Save m_XMLUrlStr
		SendEventListener "ProjectRemove"
	),
	
	
	
	fn AddProject _path silent:false=(
		if((GetProjectByPath _path) != undefined)then(
			return false
		)
		
		projectNodes = m_XmlDoc.SelectSingleNode "mspm/mspmProjects"
		
		
		
		
		proj = MSPM_System_Project()
		newProjectNode = proj.CreateNewXMLNode m_XMLDoc
		proj.Initiate newProjectNode
		proj.SetPath _path
		
		projectNodes.appendChild newProjectNode
		
		
		
		
		append m_ProjectsArr proj
		Save()
		if(silent == false)then(
			SendEventListener "ProjectAdd"	
		)
		
		return true
	),
	fn NewProject _path=(
		if(m_FileMaster.DirectoryExists _path) then(
			return false
		)
		res = makeDir _path
		if(res == false)then(
			
			return false
		)
		templateFiles = (symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\template\\PROJECT_Template\\")
		m_FileMaster.CopyDir templateFiles _path
		
		AddProject _path silent:true
		SendEventListener "ProjectNew"
		return true
		
		
	),
	fn ExitMSPM=(
		SendEventListener "ExitMSPM"
	),
	--EVENT SYSTEM
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
	function MakeEventArguments=(
		loc
		returnArr = #()
-- 		res = GetLocationByNode _node &loc
-- 		if(res == true)then(
-- 			returnArr = loc.AsEventArgs()	
-- 		)
		return returnArr
	), -- End MakeEventArguments
	function SendEventListener _event=(
		for listenerObj in m_Listeners do(
			if(listenerObj[1] == _event)then(
				listenerObj[2] (MakeEventArguments() )
			)
		)
	) -- End SendEventListener
	
)
m_MSPM_System = MSPM_System()

url = (symbolicPaths.getPathValue("$userScripts") + "\\MaxScriptProjectManager\\data\\MSPM.xml")
m_MSPM_System.Initiate url
-- m_MSPM_System.AddProject @"C:\3DAE Internship"
-- m_MSPM_System.RemoveProjectByPath @"C:\3DAE Internship"
-- m_MSPM_System.Save()


