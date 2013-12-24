--VisualFengx 1.20 install MZP

Versions=1.20
installTool
setupStart
setup_progress_update
R_name="VisualFengx_"  + Versions as string 
--local _LocalPath=find_MZP_path()
--ShellLaunch "explorer.exe" tempStr 

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
	tempStr="-->>> �����ļ��� "+targetPath
	setup_progress_update 10 tempstri
	makeDir (beWindowsPath  targetPath)
	local files=getFiles (beWindowsPath ( _LocalPath+"/VisualFengx/VisualFengx/*"))
	local startFiles=getFiles (beWindowsPath ( _LocalPath+"/VisualFengx/Startup/*"))
	--print files
	--print startFiles
	prct=10
	for f in files do
	(
		local fileName= filenameFromPath f	
		local newPath=beWindowsPath (targetPath +"/" +fileName)
		--print fileName
		--print newPath
		try deleteFile  newPath catch ()
		try copyFile  f  newPath catch  print  (f +" copy fath!")
		tempStr="-->>> �����ļ� "+f as string
		prct=prct*1.4
		setup_progress_update  prct tempStr

	)
	
	for f in startFiles do
	(
		local fileName= filenameFromPath f	
		local newPath=beWindowsPath ((getDir #startupScripts) + "/"+fileName)
		try deleteFile  newPath catch ()
		try copyFile  f  newPath catch  print (f +" copy fath!")
		setup_progress_update 60 "-->> ����startScript�ļ�"
	)
	
	try fileIn (getDir #startupScripts +"\\fengx_start.ms") catch (print "cant find fengx_start.ms!")
	setup_progress_update 100  "-->> ��װ���"
	if (queryBox "��װ��� �������Max��")==true do 
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
		setup_progress_update 1 "-->>> ��ʼ....."
		install()
	)else(
	if Versions >VisualFengxVersions ==true do 	
	(
		tempM="��ǰ�汾 " +VisualFengxVersions as string +"  ���µ�" + Versions as string
		if (queryBox tempM)==true do
		(
			setup_progress_update 1 "-->>> ��ʼ....."
			install()
		)
	)
	
	if Versions <VisualFengxVersions==true do 
	(
		tempM="��ǰ�汾 " +VisualFengxVersions as string  +"���ߣ� ȷ��Ҫ�˻ص�" + Versions as string
		if (queryBox tempM)==true do
		(
			setup_progress_update 1 "-->>> ��ʼ....."
			install()
		)
	)
	if Versions ==VisualFengxVersions do 
	(
	tempM="�͵�ǰ�汾 " +VisualFengxVersions as string  +"һ��  ȷ�����ǰ�װ��"
	if (queryBox tempM)==true do
	(
	 setup_progress_update 1 "-->>> ��ʼ....."
	 install()
	)
	)
)
)

bc=color 64 67 65 60 
theBmp = (BitMap 160 112 color:bc) 
tempPath=find_MZP_path() +"\\VisualFengx\\setup_bg.png"
theBmp =openBitMap  tempPath



rollout installTool R_name width:158 height:211
(
	button btn76 "��װ" pos:[0,132] width:80 height:80
	button btn77 "ж��" pos:[80,132] width:80 height:80
	button bt01 " xx" pos:[-1,-1] width:160 height:112 
	progressBar pb_bar "ProgressBar" pos:[-2,110] width:162 height:22 color:[0,100,60]
	label lb01 "-->>> ��ʼ....." pos:[0,213] width:159 height:22

	on btn76 pressed do
	(
	installTool.height=230
	setupStart()
	)
	on btn77 pressed do
	(
	if  VisualFengxVersions==undefined then messageBox "û�а�װ����û��ж�أ�" else fengx.uninstall()
	)
)






createdialog installTool  style:#(#style_border,#style_titlebar,#style_toolwindow, #style_sysmenu)
installTool.bt01.images=#(theBmp, undefined, 1, 1, 1, 1, 1)