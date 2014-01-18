-- Repositories
struct Repository_ScriptItem(
	m_Node,
	
	fn MakeNewIDStr=(
		randID = random 111111111 999999999
		randID = random 111111111 999999999
		return (randID as string)
	),
	fn GetID=(
		m_Node.GetAttribute("ID")
	),
	fn SetID _arg=(
		m_Node.SetAttribute "ID" _arg
	),
	fn SetMD5 _arg=(
		m_Node.SetAttribute "MD5" _arg
	),
	fn GetMD5 =(
		return m_Node.GetAttribute "MD5"
	),
	fn SetChangeList _arg=(
		m_Node.SetAttribute "ChangeList" _arg
	),
	fn GetChangeList=(
		m_Node.GetAttribute "ChangeList"
	),
	fn GetName=(
		m_Node.GetAttribute("Name")
	),
	fn SetName _arg=(
		m_Node.SetAttribute "Name" _arg
	),
	fn GetNode=(
		return m_Node
	),
	fn GetVersion=(
		m_Node.GetAttribute("Version")
	),
	fn SetVersion _arg=(
		m_Node.SetAttribute "Version" (_arg)
	),
	fn GetDownload=(
		m_Node.GetAttribute("Download")
	),
	fn SetDownload _arg=(
		m_Node.SetAttribute "Download" (_arg)
	),
	fn AsListViewItemDataArr=(
		#(GetName(),GetVersion(),GetID(),GetMD5(),GetChangeList(),GetDownload())
	),
	fn SetDataFromProjectObj _projectObj=(
		SetName (_projectObj.GetProjectName())
		
		projID = _projectObj.GetScriptID()
		if(projID == "")then(
			newID = MakeNewIDStr()
			SetID (newID)
			_projectObj.SetScriptID(newID)
		)else(
			SetID (projID)
		)
		
		
		
	),
	fn GetAuthor=(
		m_Node.GetAttribute("Author")
	),
	fn SetAuthor _arg=(
		m_Node.SetAttribute "Author" (_arg)
	),
	fn GetWebsite=(
		m_Node.GetAttribute("Website")
	),
	fn SetWebsite _arg=(
		m_Node.SetAttribute "Website" (_arg)
	),
	fn GetTwitterUser=(
		m_Node.GetAttribute("TwitterUser")
	),
	fn SetTwitterUser _arg=(
		m_Node.SetAttribute "TwitterUser" (_arg)
	),
	fn GetEmail=(
		m_Node.GetAttribute("Email")
	),
	fn SetEmail _arg=(
		m_Node.SetAttribute "Email" (_arg)
	),
	fn GetDonateURL=(
		m_Node.GetAttribute("DonateURL")
	),
	fn SetDonateURL _arg=(
		m_Node.SetAttribute "DonateURL" (_arg)
	),
	fn GetCategory=(
		m_Node.GetAttribute("Category")
	),
	fn SetCategory _arg=(
		m_Node.SetAttribute "Category" (_arg)
	),
	
	fn FetchDataFromProject _project=(
		Author=m_Author_System.GetAuthor() 
		
		siteUrl = ""
		if(_project.GetSite() != "")then(
			siteUrl = _project.GetSite()
		)else(
			siteUrl = m_Author_System.GetSite()
		)
		Website=siteUrl
		
		Download="http://dl.dropbox.com/u/3715555/GoMax.mzp"
		
		TwitterUser=(m_Author_System.GetTwitter())
		Email=(m_Author_System.GetEmail())
		DonateURL=(m_Author_System.GetDonate())
		Category=_project.GetCategory()	
		
		SetAuthor (m_Author_System.GetAuthor() )
		SetWebsite Website
		SetTwitterUser TwitterUser
		SetEmail Email
		SetDonateURL DonateURL
		SetCategory Category
	),
	fn FetchDownloadURLFromRepositoryObject _repoObj=(
		SetDownload ((_repoObj.GetDownloadUrlFolder())+GetName()+"_"+GetVersion()+".mzp")
	),
	fn Initiate _node=(
		m_Node = _node
		if(GetMD5() == "")then(
			SetMD5 ""	
		)
		if(GetChangeList() == "")then(
			SetChangeList ""	
		)
	)
	
)

struct Repository_Object(
	m_Path,
	m_Node,
	m_XmlDoc,
	m_ScriptItemArr,
	fn ReadScriptItems=(
		nodeColl = m_Node.SelectNodes "Script"
		m_ScriptItemArr = #()
		
		for i = 0 to (nodeColl.Count - 1) do(
			
			scriptObj = Repository_ScriptItem()
			scriptObj.Initiate nodeColl.Item[i]
			append m_ScriptItemArr scriptObj
		)
		return m_ScriptItemArr 
	),
	fn GetScriptFromNameVersion _nameStr _versionStr=(
		for scriptObj in m_ScriptItemArr do(
			
			if((scriptObj.GetName() == _nameStr) and (scriptObj.GetVersion() == _versionStr))then(
				return scriptObj
			)
		)
	),
	fn InitiateFromScratch _path=(
		m_Path = _path
		
		m_XmlDoc = dotNetObject "System.Xml.XmlDocument"
		m_Node = m_XmlDoc.CreateNode "element" "script_repository" ""
		m_Node.SetAttribute "Name" "undefined"
		m_Node.SetAttribute "URL" "undefined"
		m_XmlDoc.AppendChild m_Node
		
		m_XmlDoc.Save m_Path
		ReadScriptItems()
		return m_XmlDoc
	),
	fn GetScriptAsListviewArr filter:undefined=(
		returnArr= #()
		for scriptItem in m_ScriptItemArr do(
			if(filter == undefined)then(
				append returnArr (scriptItem.AsListViewItemDataArr())	
				continue
			)
			projectObj = filter
			if(scriptItem.GetID() == projectObj.GetScriptID() )then(
				append returnArr (scriptItem.AsListViewItemDataArr())	
			)
			
		)
		return returnArr
	),
	fn Initiate _path=(
		m_ScriptItemArr=#()
		
		m_Path = _path
		
		m_XmlDoc = dotNetObject "System.Xml.XmlDocument"
		m_XmlDoc.load _path
		m_Node = m_XmlDoc.SelectSingleNode "script_repository"
		
		
		
		ReadScriptItems()
	),
	fn GetAsListViewArr=(
		returnArr = #()
		
		append returnArr (m_Node.GetAttribute("Name"))
		append returnArr (m_Node.GetAttribute("URL"))
		append returnArr (m_Path)
		return returnArr
	),
	fn GetName=(
		res = m_Node.GetAttribute("Name")
		return res
	),
	fn SetName _arg=(
		m_Node.SetAttribute "Name" _arg
	),
	fn GetURL=(
		res = m_Node.GetAttribute("URL")
		return res
	),
	fn SetURL _arg=(
		m_Node.SetAttribute "URL" _arg
	),
	fn GetDownloadUrlFolder=(
		m_Node.GetAttribute("DownloadUrlFolder")
	),
	fn SetDownloadUrlFolder _arg=(
		m_Node.SetAttribute "DownloadUrlFolder" (_arg)
	),
	fn Save=(
		m_XmlDoc.Save m_Path
		m_Repository_System.SendEvent "RepositoryEdit"
	),
	fn GetFilePath=(
		return m_Path
	),
	fn DeleteScriptItem _projectName _version _scriptID=(
		for i = 1 to m_ScriptItemArr.count do(
			scriptItemObj = m_ScriptItemArr[i]
			origName = scriptItemObj.GetName()
			origVersion = scriptItemObj.GetVersion()
			origID = scriptItemObj.GetID()
			if((origName == _projectname) and (_version == origVersion) and (_scriptID == origID))then(
				m_Node.RemoveChild (scriptItemObj.GetNode())
				deleteItem m_ScriptItemArr i
				m_Repository_System.SendEvent "DeleteScriptItem"
				exit
			)
		)
	),
	fn GetScriptItemFromNameScriptID _projectname _scriptID=(
		for i = 1 to m_ScriptItemArr.count do(
			scriptItemObj = m_ScriptItemArr[i]
			origName = scriptItemObj.GetName()
			origVersion = scriptItemObj.GetVersion()
			origID = scriptItemObj.GetID()
			if((origName == _projectname) and (_scriptID == origID))then(
				return scriptItemObj
			)
		)
		return undefined
	),
	fn GetScriptItemFromNameVersionScriptID _projectName _version _scriptID=(
		for i = 1 to m_ScriptItemArr.count do(
			scriptItemObj = m_ScriptItemArr[i]
			origName = scriptItemObj.GetName()
			origVersion = scriptItemObj.GetVersion()
			origID = scriptItemObj.GetID()
			if((origName == _projectname) and (_version == origVersion) and (_scriptID == origID))then(
				return scriptItemObj
			)
		)
		return undefined
	),
	fn ApplyScriptItem _project _version=(
		scriptObj = GetScriptItemFromNameScriptID (_project.GetProjectName()) (_project.GetScriptID())
		
		if(scriptObj != undefined)then(
			-- found a script item that already exists
			scriptObj.SetVersion _version
			scriptObj.SetDataFromProjectObj _project
			scriptObj.SetDownload (GetDownloadUrlFolder()+ GetName() + "_" + scriptObj.GetVersion()+".msr" )
			
			Save()
			m_Repository_System.SendEvent("NewScriptItem")
			
			return true
		)
		
		--add to xml
		scriptxmlNode = m_Node.OwnerDocument.CreateNode "element" "Script" ""
		m_Node.appendChild scriptxmlNode
		
		scriptObj = Repository_ScriptItem()
		scriptObj.Initiate scriptxmlNode
		scriptObj.SetVersion _version
		scriptObj.SetDataFromProjectObj _project
		scriptObj.SetDownload (GetDownloadUrlFolder()+ GetName() + "_" + scriptObj.GetVersion()+".msr" )
		
		append m_ScriptItemArr scriptObj
		Save()
		m_Repository_System.SendEvent("NewScriptItem")
		
		return true
		
	),
	fn NewScriptItem _project _version=(
		--see if scriptItem AllreadyExists
		
		
		checkScriptExistArr = GetScriptItemFromNameVersionScriptID (_project.GetProjectName()) _version (_project.GetScriptID())
		if(checkScriptExistArr != undefined ) then(
			return false
		)
			
		--add to xml
		scriptxmlNode = m_Node.OwnerDocument.CreateNode "element" "Script" ""
		m_Node.appendChild scriptxmlNode
		
		scriptObj = Repository_ScriptItem()
		scriptObj.Initiate scriptxmlNode
		scriptObj.SetVersion _version
		scriptObj.SetDataFromProjectObj _project
		scriptObj.SetDownload (GetDownloadUrlFolder()+ GetName() + "_" + scriptObj.GetVersion()+".msr" )
		
		append m_ScriptItemArr scriptObj
		
		m_Repository_System.SendEvent("NewScriptItem")
		Save()
	),
	fn GetScriptsArr filter:undefined=(
		returnArr = #()
		for scriptObj in m_ScriptItemArr do(
			if(filter == undefined)then(
				append returnArr scriptObj	
			)else(
				if(scriptObj.GetID() == filter.GetScriptID())then(
					append returnArr scriptObj	
				)
			)
		)
		return returnArr
	),
	fn GetScriptsVersionStrArr filter:undefined=(
		filteredScriptArr = GetScriptsArr filter:filter
		returnArr = #()
		for scriptObj in filteredScriptArr do(
			append returnArr (scriptObj.GetVersion())
		)
		
		return returnArr
	)
)
struct Repository_System(
	m_7zipApplication,
	m_MSR_XmlPath,
	m_RepositoryArr,
	m_ListenersArr,
	function ReadRepositories=(
		m_RepositoryArr = #()
		fileArr = getfiles(m_MSR_XmlPath+"*")
		for file in fileArr do(
			repoObj = Repository_Object()
			repoObj.Initiate file
			append m_RepositoryArr repoObj
		)
	),
	function GetRepositoriesAsNameStrArr=(
		returnArr = #()
		
		for repObj in m_RepositoryArr do(
			append returnArr (repObj.GetName())
		)
		return returnArr
	),
	function GetRepositoriesListviewArr=(
		returnArr = #()
		
		for repObj in m_RepositoryArr do(
			append returnArr (repObj.GetAsListViewArr())
		)
		return returnArr
	),
	function GetRepositoryBySlotInArr _posInt=(
		return m_RepositoryArr[_posInt]
	),
	fn Initiate=(
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		m_7zipApplication = userScriptFolder + @"MaxScriptProjectManager\src\plugin\7za.exe"
		m_ListenersArr = #()
		m_RepositoryArr = #()
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		m_MSR_XmlPath = (userScriptFolder+"MaxScriptProjectManager\\data\\repository_xml\\")
		ReadRepositories()
	),
	fn DownloadRepository _url=(
		
		repoObj = Repository_Object()
-- 		_url = "http://www.norman3d.com/repo.msr"
		xmlAdress = m_MaxScriptManager_System.DownloadRepositoryLocalXMLUrl _url
		
		newFileNamePath = (m_MSPM_System.GetUniqueFileName (m_MSR_XmlPath+"repo.xml"))
		if(xmlAdress == undefined)then(
			return undefined
		)
		copyfile xmlAdress newFileNamePath
			
		repoObj.Initiate newFileNamePath
		append m_RepositoryArr repoObj
		
		ReadRepositories()
		
		m_Repository_System.SendEvent "RepositoryNew"		
		return repoObj
		
		
	),
	fn NewRepository=(
		repoObj = Repository_Object()
		repoObj.InitiateFromScratch (m_MSPM_System.GetUniqueFileName (m_MSR_XmlPath+"repo.xml"))
		append m_RepositoryArr repoObj
		
		ReadRepositories()
		m_Repository_System.SendEvent "RepositoryNew"
		return repoObj
	),
	fn GetRepositoryByPath _path=(
		for repObj in m_RepositoryArr do(
			if(repObj.GetFilePath() == _path)then(
				return repObj
			)
		)
		return undefined
	),
	fn DeleteRepository _url=(
		for repObj in m_RepositoryArr do(
			if(repObj.GetFilePath() == _url)then(
				deleteFile _url
				deleteitem m_RepositoryArr (finditem m_RepositoryArr repObj)
				return true
			)
		)
		return false
		
		
	),
	
	fn PublishRepository _repoObj _pathFolder=(
		msrPath = _pathFolder + _repoObj.GetName() + ".msr"
		dnp = CreateDotNetProcessor()
		-- Run a dir command
		dnp.execute m_7zipApplication ("a -tzip "+"\""+msrPath+"\""+" "+"\""+_repoObj.GetFilePath()+"*\"") ""
	),
	fn SendEvent _eventName=(
		
		for listenerObj in m_ListenersArr do(
			
			if(listenerObj[1] == _eventName)then(
				
				functionObj = listenerObj[2]
				functionObj #(_eventName)
			)
		)
	),
	fn RemoveEventListener _eventName _function=(
		for i = 1 to m_ListenersArr.count do(
			if((m_ListenersArr[i][1] == _eventName) and (m_ListenersArr[i][2] == _function))then(
				deleteItem m_ListenersArr i
				return true
			)
		)
		return false
	),
	fn AddEventListener _eventName _function=(
		
		append m_ListenersArr #(_eventName, _function)
	)
)
m_Repository_System= Repository_System()
m_Repository_System.Initiate()

userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
m_MSR_XmlPath = (userScriptFolder+"MaxScriptProjectManager\\data\\repository_xml\\repo.msr")
-- m_MaxScriptManager_RepositoryXml.DeleteRepository m_MSR_XmlPath
-- m_Repository_System.NewRepository()

-- Project_Manager_System.CreateDialog()
