--VisualFengx 1.5 install MZP

Versions=1.51
installTool
setupStart
setup_progress_update
R_name="VisualFengx_"  + Versions as string 

function setup_progress_update prct msg=(
	installTool.pb_bar.value = prct
	installTool.lb01.text = msg as string
)	

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
	for f in folders do 
	(
		namePart= filterString f "\\"
		ID=-1
		try ID= (substring namePart[namePart.count]  7  -1) as Integer 	catch()
		if classof (ID)==Integer  do append  matchDates ID
	
	)
	CID= amax matchDates
	MZP_path=sysInfo.tempdir+"mzptmp"+(CID as string) +"\\"
	return MZP_path
	)	
	

/*
function find_MZP_path1=
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
	
*/
function install=
(
	--print  VisualFengxVersions as string
	local _LocalPath=find_MZP_path()
	--ShellLaunch "explorer.exe" (beWindowsPath  _LocalPath)
	local targetPath=getDir #scripts +"/VisualFengx/"
	tempStr="-->>> 拷贝文件到 "+targetPath
	setup_progress_update 10 tempstri
	makeDir (beWindowsPath  targetPath)
	local files=getFiles (beWindowsPath ( _LocalPath+"/VisualFengx/VisualFengx/*"))
	local startFiles=getFiles (beWindowsPath ( _LocalPath+"/VisualFengx/Startup/*"))

	prct=10
	for f in files do
	(
		local fileName= filenameFromPath f	
		local newPath=beWindowsPath (targetPath +"/" +fileName)

		try deleteFile  newPath catch ()
		try copyFile  f  newPath catch  print  (f +" copy fath!")
		tempStr="-->>> 拷贝文件 "+f as string
		prct=prct*1.4
		setup_progress_update  prct tempStr

	)
	
	for f in startFiles do
	(
		local fileName= filenameFromPath f	
		local newPath=beWindowsPath ((getDir #startupScripts) + "/"+fileName)
		try deleteFile  newPath catch ()
		try copyFile  f  newPath catch  print (f +" copy fath!")
		setup_progress_update 60 "-->> 拷贝startScript文件"
	)
	
	--try fileIn (getDir #startupScripts +"\\fengx_start.ms") catch (print "cant find fengx_start.ms!")
	setup_progress_update 100  "-->> 安装完成"
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
		setup_progress_update 1 "-->>> 开始....."
		install()
	)else(
		
		if Versions >VisualFengxVersions ==true then	
		(
			tempM="当前版本 " +VisualFengxVersions as string +"  更新到" + Versions as string
			if (queryBox tempM)==true do
			(
				setup_progress_update 1 "-->>> 开始....."
				install()
			)
		)else (
		
			if Versions <VisualFengxVersions==true then
			(
				tempM="当前版本 " +VisualFengxVersions as string  +"更高！ 确定要退回到" + Versions as string
				if (queryBox tempM)==true do
				(
					setup_progress_update 1 "-->>> 开始....."
					install()
				)
				
			)else (
				if Versions ==VisualFengxVersions do 
				(
				tempM="和当前版本 " +VisualFengxVersions as string  +"一致  确定覆盖安装！"
				if (queryBox tempM)==true do
				(
				 setup_progress_update 1 "-->>> 开始....."
				 install()
				)
				)
				)
			
			)
	
		)
		

)

bc=color 64 67 65 60 
theBmp = (BitMap 160 112 color:bc) 
tempPath=find_MZP_path() +"\\VisualFengx\\setup_bg.jpg"
try theBmp =openBitMap  tempPath catch print "cant find install_bg_map!"



rollout installTool R_name width:232 height:239
(
	button btn76 "安装" pos:[0,134] width:192 height:80
	button btn77 "卸载" pos:[192,134] width:40 height:80
	progressBar pb_bar "ProgressBar" pos:[-1,111] width:234 height:22 color:[0,100,60]
	label lb01 "-->>> 开始....." pos:[0,215] width:232 height:19
	button btn293 "x" pos:[-1,-1] width:233 height:112 images:#(tempPath, undefined, 1, 1, 1, 1, 1)
	on btn76 pressed do
	(
	installTool.height=230
	setupStart()
	)
	on btn77 pressed do
	(
	if  VisualFengxVersions==undefined then messageBox "没有安装过！没法卸载！" else fengx.uninstall()
	)
)


if VisualFengxVersions!=undefined then
(
	setupStart()
)else
(
createdialog installTool  style:#(#style_border,#style_titlebar,#style_toolwindow, #style_sysmenu)
)
--installTool.bt01.images=#(theBmp, undefined, 1, 1, 1, 1, 1)