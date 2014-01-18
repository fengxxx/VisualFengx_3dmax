/*
	<project_name>
	------------------------------
	Version : <version>
	Developed By : <author_name>
	Info: <site>
	Description: <description>
	
*/
struct MaxScriptManager_System(
	fn Initiate=(
		
	),
	fn AddWaterMark _mzpPath=(
		theFile = _mzpPath --Note, if these files are in $userscripts you need to use GetDir #userscripts + "\\debugger_v.1.0.mzp" So that the whole path is passed to DOS
		
		userScriptFolder = (symbolicPaths.getPathValue("$userScripts")+"\\")
		theWatermarkFile = userScriptFolder + @"MaxScriptProjectManager\src\plugin\watermark.tmp"
		
		_7zipApplication = userScriptFolder + @"MaxScriptProjectManager\src\plugin\7za.exe"
		_7zipApplicationLocation = userScriptFolder + @"MaxScriptProjectManager\src\plugin\"
		
		theComment ="-MaxScriptManager compatible"
		ver = maxversion()

		--First we extract the "watermark" file. (This file contains also folder structure)
		if ver[1] > 9000 then --Every 3dsMax version
		(
			hiddenDosCommand ("zipnote " + "\""+ theFile + "\"" + " > " + "\"" + theWatermarkFile + "\"") donotwait:false startpath:((_7zipApplicationLocation) as string) --Startpaht is where zipnote.exe is located
		)
		else --3dsMax 9
		(
			shellLaunch ("\"" +_7zipApplication + "\"") ("\""+ theFile + "\"" + " > " + "\"" + theWatermarkFile + "\"")
		)

		--Then we add the comment. --I prefer to use dotnet here instead of opening and closing FileStream, "closing" files is broken in 3dsMax 2012 :(
		AppendText = (dotnetClass "System.IO.File").AppendAllText theWatermarkFile theComment

		--Finally we add the "watermark" file back to the mzp
		if ver[1] > 9000 then --Every 3dsMax version
		(
			res = hiddenDosCommand ("zipnote -w " + "\""+ theFile + "\"" + " < " + "\"" + theWatermarkFile + "\"") donotwait:false startpath:((_7zipApplicationLocation) as string) --Startpaht is where zipnote.exe is located
		)
		else --3dsMax 9
		(
			
			shellLaunch ("\"" +_7zipApplication + "\"") ("-w " + "\""+ theFile + "\"" + " < " + "\"" + theWatermarkFile + "\"")
		)
		--We delete the watermark.tmp file
-- 		deleteFile theWatermarkFile
	),
	fn DownloadRepositoryLocalXMLUrl _url=
	(
		
		--Clear temp folder
		makedir ((getdir #userscripts) + "\\MaxScriptProjectManager\\temp\\_MSPM_Repository_XML\\")
		for f in getFiles (getDir #userscripts + "\\MaxScriptProjectManager\\temp\\_MSPM_Repository_XML\\*.*") do deletefile f
		
		--Download MSR file
		theDownloadedFile = (getDir #userscripts + "\\MaxScriptProjectManager\\temp\\_MSPM_Repository_XML\\" + getFileNameFile _url + getFileNameType _url)
		try
		(
			(dotNetObject "System.Net.WebClient").downloadFile _url theDownloadedFile
		)
		catch(
-- 			print ("ERROR 404: " + _url)
			return undefined
		)
		
		if doesFileExist theDownloadedFile do
		(
			--Extract zip and delete
			
			renameFile theDownloadedFile ((pathConfig.removePathLeaf (theDownloadedFile)) + getFileNameFile theDownloadedFile + ".zip") --Rename MSR to ZIP
			unmaz ((pathConfig.removePathLeaf (theDownloadedFile)) + getFileNameFile theDownloadedFile + ".zip") (getDir #userscripts + "\\MaxScriptProjectManager\\temp\\_MSPM_Repository_XML\\") --Extract files with unmaz
			deleteFile ((pathConfig.removePathLeaf (theDownloadedFile)) + getFileNameFile theDownloadedFile + ".zip") --Delete the repository file
		)
		--Get XML file
		theXMLfile = #()
		for f in getFiles "$userscripts\\MaxScriptProjectManager\\temp\\_MSPM_Repository_XML\\*.xml" do
		(
			append theXMLfile f
		)
		
		--Return XML path
		return theXMLfile[1]
	),
	fn GetRepositoryLocalXMLUrl _url=(
		xmlPath = DownloadRepositoryLocalXMLUrl _url
		
		--"http://www.norman3d.com/repo.msr"
-- 		xmlPath = @"C:\Users\sven\AppData\Local\Autodesk\3dsMax\2011 - 64bit\enu\scripts\MaxScriptProjectManager\temp\repo.xml"
-- 		xmlPath = m_MaxScriptManager_System.GetRepositoryLocalXMLUrl _url
		return xmlPath
	)
)
m_MaxScriptManager_System = MaxScriptManager_System()
m_MaxScriptManager_System.Initiate()

-- theXML = m_MaxScriptManager_System.GetRepositoryLocalXMLUrl "http://www.norman3d.com/repo.mr"
-- print theXML