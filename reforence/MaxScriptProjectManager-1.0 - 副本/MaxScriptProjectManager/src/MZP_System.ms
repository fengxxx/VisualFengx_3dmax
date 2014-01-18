struct MZP_System(
	m_MZP_TemplateDirectory,
	m_TempDirectory,
	m_7zipApplication,
	m_PublishDirectory,
	fn HiddenDotNetCommand Command=
	(
		Process = DotNetObject "System.Diagnostics.Process"
		Process.StartInfo.WindowStyle   =  (DotNetClass  "System.Diagnostics.ProcessWindowStyle").Hidden
		Process.StartInfo.CreateNoWindow   =   true
		Process.StartInfo.UseShellExecute   =   false
		Process.StartInfo.RedirectStandardInput = true;
		Process.StartInfo.RedirectStandardOutput = true;
		Process.StartInfo.FileName = "cmd.exe"
		Process.Start()
		Process.StandardInput.WriteLine(Command)
		Process.StandardInput.WriteLine("exit")
		Process.WaitForExit()
	),
	fn CreateMzpInstallScriptWithData _mzpInstallMsPath _projectObj _randomNrStr version:undefined repositoryUrl:undefined scriptID:undefined=(
		
		file =openfile _mzpInstallMsPath
		newFilePath = (getFilenamePath _mzpInstallMsPath)+"mzpInstall_temp.ms"
		newFile = createfile ( newFilePath)
		pName
		
		addToMZPInstallerDataArr = #()
		
		
		
		ProjectPath = _projectObj.GetPath()
		
		customInstallFile = ""
		installerPath = (_projectObj.GetInstallerMS())
		
		loc = findString installerPath ProjectPath
		if(loc != undefined)then(
			customInstallFile = substring installerPath (ProjectPath.count+1) ((installerPath.count) )
		)
		
		customUninstallFile = ""
		uninstallPath = (_projectObj.GetUninstallMS())
		loc = findString uninstallPath ProjectPath
		if(loc != undefined)then(
			customUninstallFile = substring uninstallPath (ProjectPath.count+1) ((uninstallPath.count) )
		)
			
			
		installImagePath = (_projectObj.GetInstallerImage())
		
		loc = findString installImagePath ProjectPath
		if(loc != undefined)then(
			installImageRelativePath = substring installImagePath (ProjectPath.count+1) ((installImagePath.count) )
		)
		if(installImagePath == "")then(
			installImageRelativePath = ""
		)

		append addToMZPInstallerDataArr ("m_ProjectName = \""+(_projectObj.GetProjectName())+"\"")
		append addToMZPInstallerDataArr ("m_Location = \""+(_projectObj.GetProjectLocation())+"\"")
			
		if(version == undefined)then(
			version = (_projectObj.GetProjectVersion())
		)
		
		append addToMZPInstallerDataArr ("m_Version = \""+version+"\"")
		append addToMZPInstallerDataArr ("m_ScriptNameToLaunch = \""+customInstallFile+"\"")
		append addToMZPInstallerDataArr ("m_RandomNumber = \""+_randomNrStr+"\"")
		append addToMZPInstallerDataArr ("m_Site= \""+(_projectObj.GetSite())+"\"")
		append addToMZPInstallerDataArr ("m_Author = \""+(m_Author_System.GetAuthor())+"\"")
		append addToMZPInstallerDataArr ("m_Author_Email = \""+(m_Author_System.GetEmail())+"\"")
		append addToMZPInstallerDataArr ("m_Author_Site= \""+(m_Author_System.GetSite())+"\"")
		append addToMZPInstallerDataArr ("m_Author_Donate= \""+(m_Author_System.GetDonate())+"\"")
		append addToMZPInstallerDataArr ("m_InstallerImage= \""+installImageRelativePath+"\"")
		append addToMZPInstallerDataArr ("m_UninstallScript= \""+customUninstallFile+"\"")
		 
		
		append addToMZPInstallerDataArr "m_MaxscriptManagerBool = true"
		
		if(repositoryUrl == undefined)then(
			repositoryUrl= ("")
		)
			
		append addToMZPInstallerDataArr ("m_RepoUrl = \""+repositoryUrl+"\"")
		
		if(scriptID == undefined)then(
			scriptID= ("")
		)
		
		append addToMZPInstallerDataArr ("m_ScriptID = \""+scriptID+"\"")
		for dataItem in addToMZPInstallerDataArr do(
			format (dataItem + "\n") to:newFile	
		)

		while (eof file != true) do(
			
			readedLine = readLine file
			
			format readedLine to: newFile
			format "\n" to: newFile
				
			
		)
		close file
		close newFile
		deletefile _mzpInstallMsPath
		
		renamefile newFilePath _mzpInstallMsPath
	),
	fn getFileHash SourceFile =
	(
		dnp = CreateDotNetProcessor()
		dnp.execute (getDir #userscripts + "\\MaxScriptProjectManager\\src\\plugin\\md5.exe") ("\"" + SourceFile + "\"") ""

		theMD5filtered = filterstring (dnp.output()) " "
		return (theMD5filtered[1])
	),
	fn CreateMZP _projectPath _mzpSavePath version:undefined repositoryUrl:undefined scriptID:undefined=(
		
		
		ProjectObject = m_MSPM_System.GetProjectByPath _projectPath
		
		if(version == undefined)then(
			version = "undefined"
		)
		
		
		
		
		randomNumberStr = (random 1 9999) as string
		
		ProjectName = (m_FileMaster.GetFolderName _projectPath)
		MZPprojectFolder = (_mzpSavePath+ProjectName+"\\")
		TempFolder = m_TempDirectory + ProjectName + "\\"
		makedir TempFolder
		
		m_FileMaster.DeleteDir TempFolder
		
		--Copying MZP Template
		m_FileMaster.CopyDir m_MZP_TemplateDirectory TempFolder
				
		CreateMzpInstallScriptWithData (TempFolder+"mzpInstall.ms") ProjectObject (randomNumberStr+".txt") version:version repositoryUrl:repositoryUrl scriptID:scriptID
		
		fs = createfile (TempFolder+randomNumberStr+".txt")
		close fs
		fs = createfile ((TempFolder+(version))+".txt")
		close fs
			
		--Copying Project into Temp
		TempProjectFolder = TempFolder + ProjectName
		makedir TempProjectFolder
		m_FileMaster.CopyDir _projectPath TempProjectFolder
		
		
		mzpFilePathWithNoExtension = _mzpSavePath+ProjectName+"_"+(version)
		if(version == "undefined")then(
			mzpFilePathWithNoExtension = _mzpSavePath+ProjectName
		)
		
		
		deletefile (mzpFilePathWithNoExtension+".zip")
			
		mzpFullPath = mzpFilePathWithNoExtension+".zip"
-- 		(shelllaunch m_7zipApplication ("a -tzip "+"\""+mzpFullPath+"\""+" "+"\""+TempFolder+"\"*"))
		
-- 		hiddendoscommand ("\""+m_7zipApplication+"\" "+("a -tzip "+"\""+mzpFullPath+"\""+" "+"\""+TempFolder+"*\"")) donotwait:false
		
-- 		HiddenDotNetCommand ("\""+m_7zipApplication+"\" "+("a -tzip "+"\""+mzpFullPath+"\""+" "+"\""+TempFolder+"\"*"))
-- 			res = hiddenDosCommand ("zipnote -w " + "\""+ theFile + "\"" + " < " + "\"" + theWatermarkFile + "\"") donotwait:false startpath:((_7zipApplicationLocation) as string) --Startpaht is where zipnote.exe is located
		
		dnp = CreateDotNetProcessor()
		-- Run a dir command
		dnp.execute m_7zipApplication ("a -tzip "+"\""+mzpFullPath+"\""+" "+"\""+TempFolder+"*\"") ""
		
--		Add the watermark To Th MWP (Note Needed anymore in new version of MPM)
-- 		m_MaxScriptManager_System.AddWaterMark mzpFullPath
		
		deletefile (mzpFilePathWithNoExtension+".mzp")
		
		md5Hash = getFileHash(mzpFilePathWithNoExtension+".zip")			
		
		res = renamefile (mzpFilePathWithNoExtension+".zip") (mzpFilePathWithNoExtension+".mzp")
		
		return md5Hash
			
		-- Removeing Temp Files
		
	),
	
	fn GetMd5FromMZPFilePath _path=(
		dirPath = getFilenamePath _path
		filenameStr = getFilenameFile  _path
		extensionStr = getFilenameType  _path
		
		zipFilename = (dirPath + filenameStr + ".zip")
		
		res = renamefile (_path) zipFilename
		if(res == true)then(
			
			md5Hash = getFileHash zipFilename
			
			renamefile zipFilename (_path)
			return md5Hash
		)
		
	),
	
	fn Initiate=(
		
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		m_PublishDirectory = userScriptFolder + @"MaxScriptProjectManager\publish\"
		m_TempDirectory = userScriptFolder + @"MaxScriptProjectManager\temp\"
		m_MZP_TemplateDirectory = userScriptFolder + @"MaxScriptProjectManager\template\MZP_Template\"
		m_7zipApplication = userScriptFolder + @"MaxScriptProjectManager\src\plugin\7za.exe"
	)
)

m_MZP_System = MZP_System()
m_MZP_System.Initiate()
-- userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
-- m_MZP_System.CreateMZP (userScriptFolder+@"TheMessageBoxProject\") (userScriptFolder + @"MaxScriptProjectManager\publish\")
