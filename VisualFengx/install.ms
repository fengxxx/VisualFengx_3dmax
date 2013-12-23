--VisualFengx 1.11 install MZP

Versions=1.11

--local _LocalPath=find_MZP_path()
--ShellLaunch "explorer.exe" tempStr 

	function beWindowsPath thePath=
	(
		a=true
		windowsPath=""
		try thePath.count catch a=false
		if a!=false do 
		(
			for i=1 to thePath.count do(
				if thePath[i]=="/" then windowsPath+="\\" else windowsPath+=thePath[i] 
			)
		)
		return windowsPath
	)
	
	function beStringPath thePath=
	(
		a=true
		windowsPath=""
		try thePath.count catch a=false
		if a!=false do 
		(
			for i=1 to thePath.count do(
				if thePath[i]=="\\" then windowsPath+="/" else windowsPath+=thePath[i] 
			)
		)
		return windowsPath
	)
	
	function find_MZP_path=
	(	
		local url = sysInfo.tempdir as string
		local folders = getDirectories (url+"mzptmp*")
		local matchDates = #()
		local MZP_path=""
		if folders.count==0 then 
			(
				print "cant find mzptemp"
				MZP_path=""
			)else (
				
			for f in folders do
			(
				local tempMzpPath=f+"VisualFengx/mzp.run"
				if (doesFileExist tempMzpPath)==true then 
				(
					local MZP_Data=getFileCreateDate tempMzpPath
					append matchDates MZP_Data
					)else  append matchDates "12/13/2000 10:28:24 AM"
				)
			local maxDate = amax matchDates
			local MaxID =  findItem matchDates maxDate
			MZP_path=folders[MaxID]
			)
	
		return MZP_path
		)	
		
		
	function install=
	(
		print  VisualFengxVersions as string
		local _LocalPath=find_MZP_path()
		--ShellLaunch "explorer.exe" (beWindowsPath  _LocalPath)
		local targetPath=getDir #scripts +"/VisualFengx/"
		makeDir (beWindowsPath  targetPath)
		local files=getFiles (beWindowsPath ( _LocalPath+"/VisualFengx/VisualFengx/*"))
		local startFiles=getFiles (beWindowsPath ( _LocalPath+"/VisualFengx/Startup/*"))
		print files
		print startFiles
		for f in files do
		(
			local fileName= filenameFromPath f	
			local newPath=beWindowsPath (targetPath +"/" +fileName)
			--print fileName
			--print newPath
			try deleteFile  newPath catch ()
			try copyFile  f  newPath catch  print  (f +" copy fath!")
		)
		for f in startFiles do
		(
			local fileName= filenameFromPath f	
			local newPath=beWindowsPath ((getDir #startupScripts) + "/"+fileName)
			try deleteFile  newPath catch ()
			try copyFile  f  newPath catch  print (f +" copy fath!")
		)
	if (queryBox "安装完成 最好重启Max！")==true do 
		(
			if checkForSave() then (
			shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
			quitmax #noPrompt
		)
		)
	)
	

	
	
	function setupStart=
	(	
		if  VisualFengxVersions==undefined then 
		(
			install()
		)else(
		if Versions >VisualFengxVersions ==true do 	
		(
			tempM="当前版本 " +VisualFengxVersions as string +"  更新VisalFengx到" + Versions as string
			if (queryBox tempM)==true do
			(
			 install()
			)
		)
		
		if Versions <VisualFengxVersions==true do 
		(
			tempM="当前版本 " +VisualFengxVersions as string  +"更高！ 确定要退回到" + Versions as string
			if (queryBox tempM)==true do
			(
			 install()
			)
		)
		if Versions ==VisualFengxVersions do 
		(
		tempM="和当前版本 " +VisualFengxVersions as string  +"确定覆盖重新安装！"
		if (queryBox tempM)==true do
		(
		 install()
		)
		)
	)
	)

rollout installTool "setup" width:200 height:160
(
	button btn76 "安装" pos:[16,104] width:80 height:40

	button btn77 "卸载" pos:[104,104] width:80 height:40
	button btn80 "VisalFengx 1.11" pos:[0,0] width:200 height:32
	

	on btn76 pressed do
	(
	setupStart()
	)
	on btn77 pressed do
	(
	if  VisualFengxVersions==undefined then messageBox "没有安装过！没法卸载！" else fengx.uninstall()
	)	
	
	)
	

createdialog installTool
