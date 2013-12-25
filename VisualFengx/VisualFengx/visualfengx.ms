------------------------------------------------
------------------------------------------------
--visualFengx-----------------------------------
--by fengx--------------------------------------
------------------------------------------------
------------------------------------------------
global  VisualFengxVersions =1.4
global  V=("VisualFengxVersions   "+VisualFengxVersions as string)
global  newVersions=0
global  updateMsg=""



function test=
(
	VisualFengxVersions=0.1
	)




------------------------------------------------
------------------ for snap to surface ---------
global PGround=undefined --snaped ground  <GeometryClass>
------------------------------------------------

------------------------------------------------
------------------- only for fun ---------------
global theVoice = CreateOLEObject "SAPI.SpVoice"
------------------------------------------------

------------------------------------------------
------------------ register export path --------
--<String>
global visualPath=""
global objPath=""
global maxPath=""
global saveMapPath=""
------------------------------------------------

------------------------------------------------
-------------------- profiling -----------------
global profilePath= getDir #scripts + "\visualfengx\fengx.fengx" --sysInfo.tempdir --settings flie path <string>
global copyPastePath= getDir #scripts--sysInfo.tempdir  --copyPaste tempPath <string>

global languageId=execute (getinisetting  profilePath "Set" "language") -- Types of language <string>
-->initialize<
languageId=(getinisetting  profilePath "Set" "language")as string
if languageId==undefined do setinisetting  profilePath "Set" "language" "English"

	
global  alertUpdate= execute (getinisetting  profilePath "upDate" "alertupDate") 
if (classOf alertUpdate)==OkClass do 
(
	alertUpdate=true
	setIniSetting  profilePath "upDate" "alertupDate" "true"
)



-----------------rollout pos and size -----------
-----------------main window --------------------
global mainPos= execute (getinisetting  profilePath "rolloutSetting" "mainPos") --position <point2>
global mainSize=execute (getIniSetting  profilePath "rolloutSetting" "mainSize") --size <point2>

-->initialize<
if (classOf mainPos)==OkClass do 
(
	mainpos=[100,100] 
	setIniSetting  profilePath "rolloutSetting" "mainPos"  "[100,100]"
)
if (classOf mainSize)==OkClass do 
(
	mainSize=[140,693] 
	setIniSetting  profilePath "rolloutSetting" "mainSize"  "[140,693]"
)


-----------------snap window --------------------
global snapPos= execute (getinisetting  profilePath "rolloutSetting" "snapPos") --position <point2>
global snapSize=execute (getIniSetting  profilePath "rolloutSetting" "snapSize") --size <point2>

-->initialize<
if (classOf snapPos)==OkClass do 
(
	snapPos=[100,100] 
	setIniSetting  profilePath "rolloutSetting" "snapPos"  "[100,100]"
)
if (classOf snapSize)==OkClass do 
(
	snapSize=[128 ,424] 
	setIniSetting  profilePath "rolloutSetting" "snapSize"  "[128 ,424]"
)

-----------------poly window --------------------
global polyPos= execute (getinisetting  profilePath "rolloutSetting" "polyPos") --position <point2>
global polySize=execute (getIniSetting  profilePath "rolloutSetting" "polySize") --size <point2>

-->initialize<
if (classOf polyPos)==OkClass do 
(
	polyPos=[100,100] 
	setIniSetting  profilePath "rolloutSetting" "polyPos"  "[100,100]"
)
if (classOf polySize)==OkClass do 
(
	polySize=[127 , 480] 
	setIniSetting  profilePath "rolloutSetting" "polySize"  "[127 , 480]"
)

-----------------mate window --------------------
global matePos= execute (getinisetting  profilePath "rolloutSetting" "matePos") --position <point2>
global mateSize=execute (getIniSetting  profilePath "rolloutSetting" "mateSize") --size <point2>

-->initialize<
if (classOf matePos)==OkClass do 
(
	matePos=[100,100] 
	setIniSetting  profilePath "rolloutSetting" "matePos"  "[100,100]"
)
if (classOf mateSize)==OkClass do 
(
	mateSize=[128,323] 
	setIniSetting  profilePath "rolloutSetting" "mateSize"  "[128,323]"
)

-----------------file window --------------------
global filePosx= execute (getinisetting  profilePath "rolloutSetting" "filePosx") --position <point2>
global fileSize=execute (getIniSetting  profilePath "rolloutSetting" "fileSize") --size <point2>

-->initialize<
if (classOf filePosx)==OkClass do 
(
	filePosx=[100,100] 
	setIniSetting  profilePath "rolloutSetting" "filePosx"  "[100,100]"
)
if (classOf fileSize)==OkClass do 
(这
	fileSize=[127, 203]
	setIniSetting  profilePath "rolloutSetting" "fileSize"  "[127, 203]"
)

-----------------copyPaste window --------------------
global copyPastePos= execute (getinisetting  profilePath "rolloutSetting" "copyPastePos") --position <point2>
global copyPasteSize=execute (getIniSetting  profilePath "rolloutSetting" "copyPasteSize") --size <point2>

-->initialize<
if (classOf copyPastePos)==OkClass do 
(
	copyPastePos=[100,100] 
	setIniSetting  profilePath "rolloutSetting" "copyPastePos"  "[100,100]"
)
if (classOf copyPasteSize)==OkClass do 
(
	copyPasteSize=[846 , 112] 
	setIniSetting  profilePath "rolloutSetting" "copyPasteSize"  "[846, 112]"
)

-----------------windows Logic state------------------
global windowState=execute (getIniSetting  profilePath "rolloutSetting" "windowState") -- <int>
global windowActiveState= execute (getinisetting  profilePath "rolloutSetting" "windowsActiveState") -- <point4>
global windowNegativeState=execute (getIniSetting  profilePath "rolloutSetting" "windowsNegativeState") -- <point2>

-->initialize<
if (classOf windowActiveState)==OkClass do 
(
	windowActiveState=[1,1,1,1] 
	setIniSetting  profilePath "rolloutSetting" "windowActiveState"  "[1,1,1,1]"
)
if (classOf windowNegativeState)==OkClass do 
(
	windowNegativeState=1 
	setIniSetting  profilePath "rolloutSetting" "windowNegativeState"  "1"
)
if (classOf windowState)==OkClass do 
(
	windowState=0
	setIniSetting  profilePath "rolloutSetting" "windowState"  "0"
)








-------------------- profiling -----------------
------------------------------------------------


------------------------------------------------
-------------------- color ---------------------
global fgColor=[150,150,150]
global bacolor=[180,50,160]  ----highlight color 
global mc_01=[30,12,30]--[29,19,38]  ------- main background color 


global bgColor= execute (getinisetting  profilePath "rolloutSetting" "bgColor") --color <point3>
-->initialize<
if (classOf bgColor)==OkClass do 
(
	bgColor=(color 47 15 41)
	setIniSetting  profilePath "rolloutSetting" "bgColor"  "(color 47 15 41)"
)
-------------------- color ---------------------
------------------------------------------------


-------------------- uvlayout path -------------
------------------------------------------------
global uvSendPath=sysInfo.tempdir + "\visualfengx\uvlayoutTemp\UVsendTemp.obj"
global uvlayoutPath=(getinisetting  profilePath "uvlayout" "path")
-->initialize<
if (classOf uvlayoutPath)==OkClass  or getFilenameFile uvlayoutPath != "claunch-uvlayout" do 
(
	uvlayoutPath = "C:\Program Files (x86)\headus UVLayout v2 Professional\claunch-uvlayout.exe"
	if  doesFileExist uvlayoutPath ==true do	setIniSetting  profilePath "uvlayout" "path"  uvlayoutPath 
)

-------------------- uvlayout path -------------
------------------------------------------------

-------------------- map -----------------------
------------------------------------------------
global titeBarMap  =bitmap 300 100  fileName:(getdir #Scripts + "\visualfengx\titeBarMap1.jpg")

-------------------- map ==---------------------
------------------------------------------------


-------------------- test ----------------------
------------------------------------------------

global matrix_x=5
global matrix_y=1
global matrix_z=1
global matrix_foucs=3

------------------------------------------------
-------------------- test ----------------------















global canSetWindows=true
-------------------- rollout ---------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
rollout mainwindow "visualFengx" width:400 height:720
(
   
    local bm = bitmap 500 50 color: mc_01 pos:[0,0]
    --bitmap the_bmp fileName:"2.1.png" -- pos:[-580,-120]
    --imgtag img_tag "imgtag" bitmap:bm align:#center pos:[1000,-45]
	subRollout sub "fengx" pos:[0,48] width:142 height:616 
 
 
 
 
 
 
	checkbutton ckP "Poly" pos:[0,24] width:32 height:24
	checkbutton ckM "材质" pos:[32,24] width:32 height:24
	checkbutton ckF "文件" pos:[64,24] width:40 height:24
	checkbutton ckS "吸附" pos:[104,24] width:39 height:24
	checkbutton ckX "↓↑" pos:[104,0] width:39 height:24
	checkbutton ckb127 "English" pos:[272,12] width:64 height:24 enabled:true checked:false
	checkbutton ckb128 "中文" pos:[336,12] width:64 height:24 enabled:true checked:true
	colorPicker cp6 "" pos:[336,56] width:63 height:24 enabled:false color:(color 42 8 36)
	button btn335 "Set" pos:[272,0] width:128 height:12 enabled:false
	button btn336 "Color" pos:[272,44] width:128 height:12
	button btn337 "设置" pos:[64,0] width:40 height:24
	checkbutton ckb230 "复制管理" pos:[0,0] width:64 height:24
	button btn744 "background" pos:[272,56] width:64 height:24
	button btn35 "visualfengx.ms" pos:[144,0] width:104 height:24
	button btn37 "startup_tool_01.ms" pos:[144,24] width:104 height:24
	button btn21 "@" pos:[248,0] width:24 height:24
	button btn22 "@" pos:[248,24] width:24 height:24
	button btn23 "fengx.fengx" pos:[144,72] width:72 height:24
	button btn24 "open" pos:[216,72] width:32 height:24
	button btn91 "@" pos:[248,72] width:24 height:24
	button btn142 "userMacros" pos:[144,48] width:104 height:24
	button btn143 "@" pos:[248,48] width:24 height:24
	button btn29 "send to GitHub" pos:[192,200] width:80 height:24
	button btn145 "get from GitHub" pos:[184,128] width:87 height:24
	button btn32 "卸载！" pos:[144,280] width:127 height:104
	
	function 	saveWindowState=
	(
		ckbs=#(ckP,ckM,ckF,ckS)
		--rollouts=#(poly,mate,file,snap)
	-->>> save windowsLogic
		if ckX.state==true  then
		(
			windowState=1
			for i=1 to ckbs.count do  if ckbs[i].state==true then windowActiveState[i]=1 else windowActiveState[i]=0

			setIniSetting  profilePath "rolloutSetting" "windowState"  (windowState as string)
			setIniSetting  profilePath "rolloutSetting" "windowActiveState"  (windowActiveState as string)
			)else (
			windowState=0
			for i=1 to ckbs.count do  	if ckbs[i].state==true do windowNegativeState=i 
			setIniSetting  profilePath "rolloutSetting" "windowState"  (windowState as string)
			setIniSetting  profilePath "rolloutSetting" "windowNegativeState"  (windowNegativeState as string)		
			)
			)

	function windowslogic=
	(
		
		ckbs=#(ckP,ckM,ckF,ckS)
		rollouts=#(poly,mate,file,snap)
		rolloutWindows =#("ployWindow","mateWindow","fileWindow","snapWindow")
		--rolloutSubs=#(mainwindow.sub.poly,mainwindow.sub.mate,mainwindow.sub.file,mainwindow.sub.snap)
		-->>> change to windowsLogic
		if windowState==1 then
		(	
			--ckX.state=true
			mainWindow.width=142
			mainWindow.height=50
			
			tempID=1
			for r in rolloutS do
			( 
				try 
				(
					canSetWindows=false
					removeSubRollout mainwindow.sub r
					)
					catch canSetWindows=true
				canSetWindows=true	
				)
			for i=1 to ckbs.count do 
			(
				if windowActiveState[i]==1 and rollouts[i].open==false then
				(
				ckbs[i].state=true
				macros.run "visualfengx_1.1" rolloutWindows[i]
				)else
				(
					if windowActiveState[i]==0 and rollouts[i].open==true do
					(
					ckbs[i].state=false
					macros.run "visualfengx_1.1" rolloutWindows[i]
					)
				)
					
			)
			
			) else(
			--ckX.state=false
			mainWindow.width=142
			mainWindow.height=691
			
			for r in rolloutS do
			( 
				if r.open==true do destroyDialog r
				try 
				(
					canSetWindows=false
					removeSubRollout mainwindow.sub r
					)
					catch canSetWindows=true
				canSetWindows=true	
				)
			AddSubRollout mainwindow.sub rollouts[windowNegativeState]
			--ckbs[windowNegativeState].state=true
				

			)
		)
	
	function windowsLogicStart=
	(
		ckbs=#(ckP,ckM,ckF,ckS)
		--rollouts=#(poly,mate,file,snap)
		if ckX.state==true then
		(
			--windowState=1
			for i=1 to ckbs.count do  if ckbs[i].state==true then windowActiveState[i]=1 else windowActiveState[i]=0
		)else(
			--windowState=0
			for i=1 to ckbs.count do  	if ckbs[i].state==true do windowNegativeState=i 
			)
		saveWindowState()
		windowslogic()
	)
	
	button btn697 "send to GitHub" pos:[184,104] width:87 height:24
	button btn698 "get from GitHub" pos:[192,224] width:80 height:24
	button btn699 "home" pos:[144,104] width:40 height:48
	button btn700 "company" pos:[144,200] width:48 height:48
	button btn801 "install.ms" pos:[144,152] width:104 height:24
	button btn802 "@" pos:[248,152] width:24 height:24
	button btn803 "install.ms" pos:[144,248] width:104 height:24
	button btn804 "@" pos:[248,248] width:24 height:24
	button btn53 "检查更新！" pos:[144,384] width:127 height:64

	on mainwindow open do
	(
	   
		if windowState==1 then ckX.state=true else  ckX.state=false
		windowslogic()
		
	)
	on mainwindow close do
	(
	    mainsize=GetDialogSize mainwindow 
	    setinisetting  profilePath "rolloutSetting" "mainSize" (mainSize as string )
	    mainpos=GetDialogPos mainwindow
		setinisetting  profilePath "rolloutSetting" "mainPos" (mainpos  as string)
	    --windowsLogicStart()
		)
	on ckP changed state do
	(
	if ckX.state ==false do
	(
	ckbs=#(ckP,ckM,ckF,ckS)
	for i=1 to ckbs.count do 
	(
	if i!=1 do ckbs[i].state=false
	)
	)
	
	    windowsLogicStart()
	)
	on ckM changed state do
	(
	if ckX.state ==false do(
	ckbs=#(ckP,ckM,ckF,ckS)
	for i=1 to ckbs.count do 
	(
	if i!=2 do ckbs[i].state=false
	)
	)
	    windowsLogicStart()
	)
	on ckF changed state do
	(
	if ckX.state ==false do(
	ckbs=#(ckP,ckM,ckF,ckS)
	for i=1 to ckbs.count do 
	(
	if i!=3 do ckbs[i].state=false
	)
	)
	    windowsLogicStart()
	)
	on ckS changed state do
	(
	if ckX.state ==false do(
	ckbs=#(ckP,ckM,ckF,ckS)
	for i=1 to ckbs.count do 
	(
	if i!=4 do ckbs[i].state=false
	)
	)
	
	    windowsLogicStart()
	)
	on ckX changed state do
	(
	if state==true then windowState=1 else
	(
		windowState=0
		
		ckbs=#(ckP,ckM,ckF,ckS)
		for i=1 to ckbs.count do 
		(
		if i!=windowNegativeState do ckbs[i].state=false
		)
		)
	setIniSetting  profilePath "rolloutSetting" "windowState"  (windowState as string)
	windowsLogic()
	)
	on ckb127 changed state do
	(
		if state==true do
		( 
		ckb128.state=false
		languageId="中文"
		--fengx.updataLanguage()
		setinisetting  profilePath  "Set" "language" languageId
	
		)
	)
	on ckb128 changed state do
	(
	if state==true do 
	(		
		ckb127.state=false
		languageId="English"
		--fengx.updataLanguage()	
		setinisetting  profilePath "Set" "language" languageId
		)
	)
	on cp6 changed col do
	(
		bgColor= col
	     setIniSetting  profilePath "rolloutSetting" "bgColor"  (bgColor as string)
		)
	on btn337 pressed do
	(
	if ckX.state==false then 
	(
	mainWindow.height=691 
	if mainWindow.width<=142 then mainWindow.width=270 else mainWindow.width=142 
	)else 
	(
	
	)
	
	
	)
	on ckb230 changed state do
	(
	 macros.run "visualfengx_1.1" "copyPasteWindow"
	)
	on btn35 pressed do
	(
		dir1=getdir #Scripts + "\visualfengx\visualfengx.ms"
		--dir2=getdir #startupScripts + "\visualfengx_startup_tool_01.ms"
		--edit dir2
		edit dir1
	)
	on btn37 pressed do
	(
		--dir1=getdir #Scripts + "\visualfengx\visualfengx.ms"
		dir2=getdir #Scripts + "\visualfengx\visualfengx_macroScript.ms"
		edit dir2
		--edit dir1
	)
	on btn21 pressed do
	(
	ShellLaunch "explorer.exe" ("/select," + getdir #Scripts + "\visualfengx\visualfengx.ms")
	)
	on btn22 pressed do
	(
	ShellLaunch "explorer.exe" ("/select," + getdir #Scripts + "\visualfengx\visualfengx_macroScript.ms")
	)
	on btn23 pressed do
	(
		edit profilePath
	)
	on btn24 pressed do
	(
	ShellLaunch "explorer.exe" profilePath
	)
	on btn91 pressed do
	(
	ShellLaunch "explorer.exe" ("/select," +profilePath)
		
	)
	on btn142 pressed do
	(
	ShellLaunch "explorer.exe" (getdir #userMacros )
	)
	on btn143 pressed do
	(
	ShellLaunch "explorer.exe" (getdir #userMacros )
	)
	on btn29 pressed do
	(
	if (queryBox "确定要同步到 GitHub!")==true do
	(
	worlkGitHubPath="E:\\GitHub\\VisualFengx_3dmax\\VisualFengx\\"
	fengx.sendToGitHub  worlkGitHubPath
	)
	)
	on btn145 pressed do
	(
	if (queryBox "确定从 GitHub 安装!")==true do
	(
	files =getFiles "K:\\VisualFengx_3dmax\\*.mzp"
	try fileIn files[1] catch messageBox "找不到按装包！"
	)
	)
	on btn32 pressed do
	(
		fengx.uninstall()
	)
	on btn697 pressed do
	(
	if (queryBox "确定要同步到 GitHub!")==true do
	(
	homeGitHubPath="K:\\VisualFengx_3dmax\\VisualFengx\\"
	fengx.sendToGitHub  homeGitHubPath
	)
	)
	on btn698 pressed do
	(
	if (queryBox "确定从 GitHub 安装!")==true do
	(
	files =getFiles "E:\\GitHub\\VisualFengx_3dmax\\*.mzp"
	try fileIn files[1] catch messageBox "找不到按装包！"
	)
	)
	on btn801 pressed do
		try edit "K:\\VisualFengx_3dmax\\VisualFengx\\install.ms" catch messageBox "cant find the file!"
	on btn802 pressed do
	(
	ShellLaunch "explorer.exe" ("/select," +"K:\\VisualFengx_3dmax\\VisualFengx\\install.ms" )
		
	)
	on btn803 pressed do
		try edit "E:\\GitHub\\VisualFengx_3dmax\\VisualFengx\\install.ms" catch messageBox "cant find the file!"
	on btn804 pressed do
	(
	ShellLaunch "explorer.exe" ("/select," + "E:\\GitHub\\VisualFengx_3dmax\\VisualFengx\\install.ms" )
		
	)
	on btn53 pressed do
	(
	if fengx.checkUpdate()==true and newVersions > VisualFengxVersions then
	( 
	        createdialog checkUpDateWindow --fengx.update()
		   checkUpDateWindow.lb01.text= updateMsg
		)else messageBox "VsiaulFengx 该版本已经为最新！无需更新!" title:"VisualFengx"
	
	
	)
)



rollout mate "材质" width:128 height:216
(
	button btn1 "清除材质" pos:[60,16] width:68 height:24 enabled:true
	button btn7 "贴图另存为" pos:[0,112] width:104 height:24 enabled:true
	button btn8 "关闭所有高显" pos:[0,192] width:128 height:24 enabled:true
	button btn9 "打开（所择）高显示" pos:[0,163] width:128 height:29 enabled:true
	button btn10 "自动标准名字" pos:[0,40] width:128 height:24 enabled:true
	button btn11 "@" pos:[232,96] width:24 height:24 enabled:true
	button btn12 "整理材质" pos:[0,16] width:60 height:24 enabled:true
	button btn15 "@" pos:[104,112] width:24 height:24 enabled:true
	button btn463 "Select Mate" pos:[128,96] width:104 height:24 enabled:false
	button btn106 "@" pos:[232,120] width:24 height:24
	
	
	button btn107 "Select Object" pos:[128,120] width:104 height:24 enabled:false
	button btn119 "Objet" pos:[128,40] width:64 height:24 enabled:false
	button btn120 "Mate" pos:[192,40] width:64 height:24 enabled:false
	button btn14 "Import Map" pos:[128,160] width:128 height:24
	button btn56 "Import Mate Map" pos:[128,184] width:128 height:24
	button btn273 "材质" pos:[0,0] width:128 height:16 enabled:false
		
	button bmap "贴图" pos:[0,96] width:128 height:16 enabled:false
	button btn275 "Directx" pos:[0,144] width:128 height:19 enabled:false
	button btn21 "去除多余子材质" pos:[0,64] width:128 height:24
	on mate open do
	(
		
		)
	on mate close do
	(
	if  canSetWindows==true do 
	(
	    mainWindow.ckM.state=false
	    mateSize=GetDialogSize mate
	    setinisetting  profilePath "rolloutSetting" "mateSize" (mateSize as string )
	
	    matepos=GetDialogPos mate
	    setinisetting  profilePath "rolloutSetting" "matePos" (matepos as string )
	)
	)
	on btn1 pressed do
	(
	 undo on(
		 macros.run "Medit Tools" "clear_medit_slots"
	)
	)
	on btn7 pressed do
	(
	saveToPath =  getSavePath    caption:"save to"
	if saveToPath !=undefined and $!=undefined  do 
	 (
		mateOn=true
		for s in $ do 
		(
			try s.material catch mateON=false
			if mateOn==true do
			(
				mates=fengx.toStandardMate s.material
				fengx.saveMateMapTo mates saveToPath
			    ShellLaunch "explorer.exe"   saveToPath 
			)
		)
	)
	)
	on btn8 pressed do
	(
	  undo on(
		    for s in fengx.toStandardMate(sceneMaterials)do(
				try s.DirectX_Manager.dxStdMat = off catch print s.name + " is not have DirectX_Manager!"
			)
		    for s in fengx.toStandardMate(meditmaterials)do(
				try s.DirectX_Manager.dxStdMat = off catch print s.name + " is not have DirectX_Manager!"
			)
	    )        
	)
	on btn9 pressed do
	(
	  undo on(
			  if $!=undefined do (
				for s in fengx.toStandardMate($.material)do(
					try s.DirectX_Manager.dxStdMat = on catch print s.name + " is not have DirectX_Manager!"
				)
			)
	    )        
	)
	on btn10 pressed do
	(
	fengx.TexNameToMateName()
	)
	on btn11 pressed do
	(
		   a=StandardMaterial
		   a=medit.GetCurMtl()
	        if classOf(a)==Standardmaterial do
	        (
			fengx.openTexFile  a
			)	
		  if classOf(a)==MultiMaterial do
			(
			for s in a do 
			(
				 fengx.openTexFile  s
				)
			)
	)
	on btn12 pressed do
	(
	  undo on(
		 macros.run "Medit Tools" "clear_medit_slots"
	      ls=meditmaterials
	      for i=1 to scenematerials.count  do 
	      (
			if classof(scenematerials[i])==Standardmaterial	 do 
			(
			  if scenematerials[i].DiffuseMap!=undefined do
			  (
			 	try ls[i]=scenematerials[i] catch print" clearMate 不知道发生了什么问题！"
	          	)
			)
			if classof(scenematerials[i])==MultiMaterial  do 
			(
				try ls[i]=scenematerials[i] catch print" clearMate 不知道发生了什么问题！"
	
			  --if scenematerials[i].name!="Standardmaterial" and  scenematerials[i].DiffuseMap!=undefined do
			  --(
			 	--try ls[i]=scenematerials[i] catch print" clearMate 不知道发生了什么问题！"
	          	--)
			)
	
		 )
	   )        
	)
	on btn15 pressed do
	(
		if (getfiles saveMapPath  ).count != 0 do(
		filePath="/select," +saveMapPath  
		print saveMapPath  
	
	     print filePath
		try  ShellLaunch "explorer.exe" filePath catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！"
	)
	)
	on btn106 pressed do
	if $!=undefined do
		(
		 for sm in $ do
	        (    
	            if classOf(sm.Material)==Standardmaterial do
	            (
					fengx.openTexFile  sm.Material
					)	
					if classOf(sm.Material)==MultiMaterial do
					(
					for s in sm.Material do 
					(
						 fengx.openTexFile  s
						)
					)
			)
		)
	on btn119 pressed do
	(
	fengx.TexNameToMateName()
	)
	on btn120 pressed do
	(
	  undo on(
	  a=StandardMaterial
	  a=medit.GetCurMtl()
	        if classOf(a)==Standardmaterial do
	        (
			str3="物件(" +a.name+")的材质"
	       	fengx.namedMate a str3 
			print("物件（"+a.name+"）")
			)
			if classOf(a)==MultiMaterial do
			(
				a.Material.name=sm.name
				i=0
				for s in a do
				(
					str2="物件(" +sm.name+")第"+(i+1) as String+"个材质"
					print (i)
					fengx.namedMate s  str2
					
					i+=1
					)
				 print("物件("+a.name+")")
				)
	        
	        )
	    
	)
	on btn14 pressed do
	(
	fengx.importMap()
	)
	on btn56 pressed do
	(
		   a=StandardMaterial
		   a=medit.GetCurMtl()
			ppos=[0,0,0]
			lineN=1
			try lineN=sqrt(a.count) catch ()
			i=0
			x=floor lineN
			y=ceil lineN
			for m in a do 
			 (
			     f = m.diffuseMap.bitmap
				i+=1
				ppos.x = (i-(floor(i/x))*x)*100
				ppos.y = (ceil(i/x))*100
				p=Plane length:100 width:100 pos:ppos isSelected:on
				P.lengthsegs = 1
				P.widthsegs = 1
				try(
				name=getFilenameFile f
				p.material=Standardmaterial ()
				p.material.name=name
				p.material.diffuseMap = Bitmaptexture fileName:f
				actionMan.executeAction 0 "40807"
				)catch( print "site fath!")
				
				)
			
	)
	on btn21 pressed do
	(
	undo on(
	if $ !=undefined do 
	(
	fengx.clearObjectMultiMaterial $
	)
	)
	)
)





rollout poly "poly " width:863 height:653
(
	button btn481 "Box" pos:[0,20] width:64 height:24
	

	button btn501 "Cylinder" pos:[128,0] width:64 height:24
	button btn511 "Sphere" pos:[128,24] width:64 height:24
	button btn521 "Plane" pos:[256,0] width:64 height:24
	button btn531 "比例人" pos:[64,20] width:64 height:24
	button btn591 "Big Group" pos:[192,0] width:64 height:24 enabled:false
	button btn7 "Big +" pos:[16,276] width:48 height:24
	button btn13 "Small -" pos:[16,300] width:48 height:24
	button btn151 "重置模型" pos:[64,276] width:64 height:48 
 
 
 
	

	button btn159 "Edit UV" pos:[0,396] width:56 height:24
	checkbutton BS "#" pos:[0,276] width:16 height:48
	button btn97 "排序" pos:[72,56] width:56 height:24
	checkbutton sx "x" pos:[0,56] width:24 height:24 enabled:true checked:true
	checkbutton sy "y" pos:[24,56] width:24 height:24
	checkbutton sz "z" pos:[48,56] width:24 height:24
	button btn51 "Show Infor" pos:[192,24] width:64 height:24 enabled:false
	checkbutton c1 "1" pos:[128,56] width:24 height:24 enabled:true checked:true
	checkbutton c2 "2" pos:[152,56] width:16 height:24
	checkbutton c3 "3" pos:[168,56] width:16 height:24
	checkbutton c4 "4" pos:[184,56] width:16 height:24 enabled:true checked:false
	checkbutton c5 "5" pos:[200,56] width:16 height:24
	checkbutton c6 "6" pos:[216,56] width:16 height:24
	

	button btn354 "编辑多边形" pos:[0,256] width:128 height:20 enabled:false
	button btn356 "编辑UV" pos:[0,376] width:128 height:20 enabled:false
	button btn225 "" pos:[56,396] width:72 height:24 enabled:false
	checkbutton ckb133 "发送到 Uvlayout" pos:[0,420] width:96 height:24
	button btn335 "Set Uvlayout Path" pos:[128,420] width:96 height:24
	
	button btn211 "重来" pos:[96,420] width:32 height:24
	button btn89 "创建多边形" pos:[0,0] width:128 height:20 enabled:false
	button btn490 "右旋" pos:[64,348] width:64 height:24
 
 
 
 
	button btn491 "左旋" pos:[0,348] width:64 height:24
	
	button btn492 "智能旋转" pos:[0,328] width:128 height:20 enabled:false
	button btn563 "置底" pos:[73,154] width:56 height:24
	button btn564 "归中" pos:[73,130] width:56 height:24
	button btn565 "Pos" pos:[1,201] width:24 height:24
	
	button btn566 "+" pos:[49,106] width:24 height:24
	button btn567 "-" pos:[1,106] width:24 height:24
	button btn568 "+" pos:[49,130] width:24 height:24
	button btn569 "-" pos:[1,130] width:24 height:24
	button btn570 "+" pos:[49,154] width:24 height:24
	button btn571 "-" pos:[1,154] width:24 height:24
	button btn572 "X" pos:[25,106] width:24 height:24
	button btn573 "Y" pos:[25,130] width:24 height:24
	button btn574 "Z" pos:[25,154] width:24 height:24
	button btn575 "Pivot" pos:[1,225] width:32 height:24
	button btn576 "Rotate" pos:[37,201] width:40 height:24
	button btn577 "Scale" pos:[33,225] width:44 height:24
	button btn578 "所有" pos:[77,201] width:52 height:48
	button btn579 "重置（所选）属性" pos:[0,182] width:129 height:19 enabled:false
	button btn580 "置顶" pos:[73,106] width:56 height:24
	button btn581 "Pivot" pos:[1,88] width:129 height:18 enabled:false
	button btn582 "" pos:[25,201] width:12 height:24 enabled:false
	on poly close do
	(
	if  canSetWindows==true do 
	(
	    polySize=GetDialogSize poly
	    setinisetting  profilePath "rolloutSetting" "polySize" (polySize as string )
	
	    polypos=GetDialogPos poly
	    setinisetting  profilePath "rolloutSetting" "polyPos" (polypos as string )
	) 
	)
	on btn481 pressed do
	(
		fengx.createBox()
	)
	on btn501 pressed do
	(
		fengx.createCylinder()
	)
	on btn511 pressed do
	(
		fengx.createSphere()
	)
	on btn521 pressed do
	(
		fengx.createPlane()
		)
	on btn531 pressed do
	(
		fengx.stdMen()
		)
	on btn591 pressed do
	(
	fengx.createBoxGizmo()
	)
	on btn7 pressed do
	(
		undo on(
	if BS.state==true do setCoordCenter #local
	if BS.state==false do setCoordCenter #selection
	macros.run "Tools" "SmartScale"
		if $!=undefind do (
			scale $ [2,2,2]
		)
		)
	)
	on btn13 pressed do
	(
		undo on(
	if BS.state==true do setCoordCenter #local
	if BS.state==false do setCoordCenter #selection
	macros.run "Tools" "SmartScale"
		if $!=undefind  do(
			scale $ [0.5,0.5,0.5]
		)
		)
	)
	on btn151 pressed do
	(
		fengx.resetModel()
	)
	on btn159 pressed do
	(
	undo on(
	        if $!=undefined do 
	        (    
			try $.count catch(
				try $.modifiers[#unwrap_uvw].unwrap.edit () catch
	                (
	                macros.run "Modifiers" "Unwrap_UVW"
	                $.modifiers[#unwrap_uvw].unwrap.edit ()
	                subobjectLevel = 3
	                )
				)
				) 
			 )
	)
	on BS changed state do
		(
	
	)
	on btn97 pressed do
	(
	if $!=undefined  do 
	(
		a=undefined  
		for s in $ do 
		(
			if a==undefined then s.pos=[0,0,0] else (
			if sx.state==true do (
				s.pos.x=a.max.x+(s.max.x-s.min.x)/1.25
				s.pos.y=0
				s.pos.z=0
			)
			if sy.state==true do (
				s.pos.y=a.max.y+(s.max.y-s.min.y)/1.25
				s.pos.x=0
				s.pos.z=0
			)
			if sz.state==true do (
				s.pos.z=a.max.z+(s.max.z-s.min.z)/1.25
				s.pos.y=0
				s.pos.x=0
			)
						
			
			)
		a=s
		)
	)
	
	)
	on sx changed state do
	(
	sy.state=false
	sz.state=false
	if $!=undefined  do 
	(
		a=undefined  
		for s in $ do 
		(
			if a==undefined then s.pos=[0,0,0] else (
			if sx.state==true do (
				s.pos.x=a.max.x+(s.max.x-s.min.x)/1.25
				s.pos.y=0
				s.pos.z=0
			)
			if sy.state==true do (
				s.pos.y=a.max.y+(s.max.y-s.min.y)/1.25
				s.pos.x=0
				s.pos.z=0
			)
			if sz.state==true do (
				s.pos.z=a.max.z+(s.max.z-s.min.z)/1.25
				s.pos.y=0
				s.pos.x=0
			)
						
			
			)
		a=s
		)
	)
	)
	on sy changed state do
	(
	sx.state=false
	sz.state=false
	if $!=undefined  do 
	(
		a=undefined  
		for s in $ do 
		(
			if a==undefined then s.pos=[0,0,0] else (
			if sx.state==true do (
				s.pos.x=a.max.x+(s.max.x-s.min.x)/1.25
				s.pos.y=0
				s.pos.z=0
			)
			if sy.state==true do (
				s.pos.y=a.max.y+(s.max.y-s.min.y)/1.25
				s.pos.x=0
				s.pos.z=0
			)
			if sz.state==true do (
				s.pos.z=a.max.z+(s.max.z-s.min.z)/1.25
				s.pos.y=0
				s.pos.x=0
			)
						
			
			)
		a=s
		)
	)
	)
	on sz changed state do
	(
	sy.state=false
	sx.state=false
	if $!=undefined  do 
	(
		a=undefined  
		for s in $ do 
		(
			if a==undefined then s.pos=[0,0,0] else (
			if sx.state==true do (
				s.pos.x=a.max.x+(s.max.x-s.min.x)/1.25
				s.pos.y=0
				s.pos.z=0
			)
			if sy.state==true do (
				s.pos.y=a.max.y+(s.max.y-s.min.y)/1.25
				s.pos.x=0
				s.pos.z=0
			)
			if sz.state==true do (
				s.pos.z=a.max.z+(s.max.z-s.min.z)/1.25
				s.pos.y=0
				s.pos.x=0
			)
						
			
			)
		a=s
		)
	)
	)
	on btn51 pressed do
	(
	fengx.showInfor()
	)
	on c1 changed state do
	(
	c2.state=false
	c3.state=false
	c4.state=false
	c5.state=false
	c6.state=false
	)
	on c2 changed state do
	(
	c1.state=false
	c3.state=false
	c4.state=false
	c5.state=false
	c6.state=false
	)
	on c3 changed state do
	(
	c2.state=false
	c1.state=false
	c4.state=false
	c5.state=false
	c6.state=false
	)
	on c4 changed state do
	(
	c2.state=false
	c1.state=false
	c3.state=false
	c5.state=false
	c6.state=false
	)
	on c5 changed state do
	(
	c2.state=false
	c1.state=false
	c3.state=false
	c4.state=false
	c6.state=false
	)
	on c6 changed state do
	(
	c2.state=false
	c1.state=false
	c3.state=false
	c4.state=false
	c5.state=false
	)
	on ckb133 changed state do
	(
	tempCopyPath=getFilenamePath uvSendPath    +  getFilenameFile uvSendPath   +".out"
	if state==true then 
	   (
	    if $!=undefined then
	    (
	    fengx.sendToUVlayout() 
	    ckb133.text="从 Uvlayout 获取"    
	    )else (
	       if (queryBox "没选择物体!")==true then poly.ckb133.state=false else poly.ckb133.state=false
	    )
	)else 
	(
	    if doesFileExist tempCopyPath ==true then
	    (
	      fengx.getFromUvlayout()
	      ckb133.text="发送到Uvlayout"    
	     )else
	     (
	       if (queryBox "uvlayout 上还没点 send ！")==true then  
	          (
	            poly.ckb133.state=false
	            ckb133.text="发送到Uvlayout"    
	            )else poly.ckb133.state=true
	     )
	)
	)
	on btn335 pressed do
	(
	if (queryBox "设置uvlayout 的路径 选择claunch-uvlayout.exe   一般在 文件夹headus UVLayout v2 Professional 里面")==true do 
			(
					tempPath=getOpenFileName    caption:"claunch-uvlayout.exe "
					if uvlayoutPath  !=undefined  and tempPath !=undefined do 
					(
						uvlayoutPath = tempPath
						setIniSetting  profilePath "uvlayout" "path"  uvlayoutPath 
					)
			)	
	
	
	)
	on btn211 pressed do
	(
	poly.ckb133.state=false
	ckb133.text="发送到 Uvlayout"  
	)
	on btn490 pressed do
	(
	
		if keyboard.shiftpressed then fengx.smartRotate 30
		else fengx.smartRotate 90
		)
	on btn491 pressed do
	(
	
		if keyboard.shiftpressed then fengx.smartRotate -30
		else fengx.smartRotate -90
		)
	on btn492 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.rotation=(quat 0 0 0 0)
				)
		)
	)
	on btn563 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do 
				if classOf(s)==Dummy then
				(
					CenterPivot s
					s.pivot.z=s.min.z
					)else
					(
						CenterPivot s
						print s
						s.pivot.z = s.min.z
						)
					)
			)
	)
	on btn564 pressed do
	(	
		undo on(
		if $!=undefined do 
		(
			for s in fengx.selectGroupDummy($) do 
			CenterPivot s
			)
		)
	)
	on btn565 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.pos=[0,0,0]
				)
		)
	)
	on btn566 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.x=s.max.x
			)
		)
	)
	on btn567 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.x=s.min.x 
			)
		)
	)
	on btn568 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.y=s.max.y
			)
		)
	)
	on btn569 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.y=s.min.y
			)
		)
	)
	on btn570 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.z=s.max.z
			)
		)
	)
	on btn571 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.z=s.min.z
			)
		)
	)
	on btn572 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.x=(s.max.x+s.min.x)/2
			)
		)
	)
	on btn573 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.y=(s.max.y+s.min.y)/2
			)
		)
	)
	on btn574 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.z=(s.max.z+s.min.z)/2
			)
		)
	)
	on btn575 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.pivot=[0,0,0]
				)
		)
	)
	on btn576 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.rotation=(quat 0 0 0 0)
				)
		)
	)
	on btn577 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.scale=[1,1,1]
				)
		)
	)
	on btn578 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do( 
	                if classOf(s)==Dummy then
				    (
					CenterPivot s
					s.pivot.z=s.min.z
					)else
					(
						CenterPivot s
						print s
						s.pivot.z = s.min.z
						)
				  s.pos=[0,0,0]
	                s.rotation=(quat 0 0 0 0)
	                s.scale=[1,1,1]
	                s.pivot=[0,0,0]
	        )
		)
	)
	)
	on btn579 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.rotation=(quat 0 0 0 0)
				)
		)
	)
	on btn580 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do 
				if classOf(s)==Dummy then
				(
					CenterPivot s
					s.pivot.z=s.min.z
					)else
					(
						CenterPivot s
						print s
						s.pivot.z = s.max.z
						)
					)
			)
	)
)

















rollout file "文件" width:128 height:448
(
	button btn1 ".visual" pos:[0,24] width:64 height:24 enabled:true
	button btn2 ".obj" pos:[0,72] width:64 height:24 enabled:true
	button btn3 ".max" pos:[0,48] width:64 height:24 enabled:true
	button btn17 "显示文件" pos:[64,24] width:64 height:24 enabled:true
	button btn19 "显示文件" pos:[64,72] width:64 height:24 enabled:true
	button btn20 "显示文件" pos:[64,48] width:64 height:24 enabled:true
	button btn330 "显示 此文件" pos:[0,156] width:128 height:24 enabled:true
	button btn345 "Restart" pos:[0,216] width:64 height:64 enabled:true
	button btn346 "Eixt" pos:[64,216] width:64 height:64 enabled:true
	button btn10 "@" pos:[240,344] width:24 height:24 enabled:true
	button btn12 "This Script" pos:[136,344] width:104 height:24 enabled:false
	
	button btn239 "导出（所选）" pos:[0,0] width:128 height:24 enabled:false
	
	button btn240 "系统" pos:[0,136] width:128 height:20 enabled:false
	button btn216 "存为AB备份格式" pos:[0,96] width:128 height:28
	button btn264 "批量分开Maxs文件" pos:[136,388] width:128 height:32
	button btn265 "file IO" pos:[136,368] width:128 height:20 enabled:false
	button btn395 "importMaxs" pos:[136,420] width:128 height:24
	edittext edt1 "import path" pos:[136,0] width:520 height:168
	button btn23 "输出" pos:[192,240] width:464 height:88
	edittext edt2 "export path" pos:[136,184] width:520 height:24
	button btn25 "......" pos:[656,0] width:48 height:24
	button btn26 "paste" pos:[656,24] width:48 height:32
	button btn80 "paste" pos:[656,208] width:48 height:32
	button btn109 "......" pos:[656,184] width:48 height:24
	button btn137 "打开输出文件夹" pos:[544,208] width:112 height:32
	checkbutton ckb1 "创建同名文件夹" pos:[192,208] width:112 height:32 enabled:true checked:true
	button btn85 "copy" pos:[656,88] width:48 height:32
	button btn86 "copy" pos:[656,272] width:48 height:32
	button btn31 "clear" pos:[656,56] width:48 height:32
	button btn32 "clear" pos:[656,240] width:48 height:32
	button btn47 "显示 备份文件" pos:[0,180] width:128 height:24 enabled:true

	on file close do
	(
	if  canSetWindows==true do 
	(
	    fileSize=GetDialogSize file  
	    setinisetting  profilePath "rolloutSetting" "fileSize" (fileSize as string )
	
	    filePosx=GetDialogPos file
	    setinisetting  profilePath "rolloutSetting" "filePosx" (filePosx as string )
	)
	)
	on btn1 pressed do
	(
		if $ !=undefined do fengx.exportSelectToVisual()
		)
	on btn2 pressed do
	(
	    if $ !=undefined do fengx.exportSelectToOBJ()
	)
	on btn3 pressed do
	(
	    if $ !=undefined do fengx.backupMax($)
	)
	on btn17 pressed do
	(
		if (getfiles visualPath).count != 0 do(
	     filePath="/select," +visualPath
	     print filePath
		try  ShellLaunch "explorer.exe" filePath   catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！"
	)
		)
	on btn19 pressed do
	(
	     if (getfiles objPath).count != 0 do(
	     filePath="/select," + objPath
	     print filePath
		try  ShellLaunch "explorer.exe" filePath   catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！"
		))
	on btn20 pressed do
	(
	     if (getfiles maxPath).count != 0 do(
	     filePath="/select," +maxPath
	     print filePath
		try  ShellLaunch "explorer.exe" filePath   catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！"
	)
		)
	on btn330 pressed do
	(	
	    if (getfiles (maxfilepath+maxfilename)).count != 0 then(
	    filePath="/select,"+maxfilepath+maxfilename
	    try  ShellLaunch "explorer.exe" filePath   catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！！"
	)else(
		--theVoice.Speak "还没存 呢 大哥！" 
		 messageBox ("还没存呢！")
		） 
		)
	)
	on btn345 pressed do
	(
	    if checkForSave() then (
	        shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
	        quitmax #noPrompt
	)
	)
	on btn346 pressed do
	(
	    if checkForSave() then (
	        --shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
	        quitmax #noPrompt
	)
	)
	on btn10 pressed do
	(
	ShellLaunch "explorer.exe" (getdir #Scripts)
	)
	on btn240 pressed do
	(
		
		)
	on btn216 pressed do
	(
	saveToPath =  getSavePath    caption:"save to"
	if saveToPath !=undefined and $!=undefined  do 
	 (
	   fengx.saveToStandType  $  saveToPath 
	   ShellLaunch "explorer.exe"   saveToPath 
	)
	)
	on btn264 pressed do
		fengx.splitMaxs()
	on btn265 pressed do
	(
		
		)
	on btn395 pressed do
	(
	fengx.importMaxs()
	)
	on btn23 pressed do
	(
	 paths=b=filterString file.edt1.text "\n"
	for VisualFilePath in paths do 
	(
	mapsPath=fengx.geMapPathFromeVisal VisualFilePath
	if ckb1.state==true then 
	(
	 local name =getFilenameFile VisualFilePath
	 local tempPath=fengx.beWindowsPath (edt2.text+"/"+name)
	 makeDir tempPath
	 print tempPath
	 fengx.copyMapsTo mapsPath tempPath
	)else fengx.copyMapsTo mapsPath edt2.text
	)
	)
	on btn25 pressed do
	(
	  tempPath=getOpenFileName caption:"select a .Visal file" 
	  if  tempPath != undefined do
	  (
	    if edt1.text=="" or edt1.text==undefined then edt1.text+=tempPath else edt1.text+="\n"+tempPath
	   )
	)
	on btn26 pressed do
	(
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	if edt1.text=="" or edt1.text==undefined then edt1.text+=DotNetClipboard.GetText() else edt1.text+="\n"+DotNetClipboard.GetText()
	
	--DotNetClipboard.SetText "Test Clipboard"
		
		)
	on btn80 pressed do
	(
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	  edt2.text = DotNetClipboard.GetText()
	--DotNetClipboard.SetText "Test Clipboard"
		
		)
	on btn109 pressed do
	(
	  tempPath=getSavePath caption:"select a export path" 
	  if  tempPath != undefined do edt2.text=tempPath
	)
	on btn137 pressed do
	(
	 paths=b=filterString file.edt1.text "\n"
	 if paths.count>1 then
	(
	  tempPath = fengx.beWindowsPath  edt2.text
	try  ShellLaunch "explorer.exe"  tempPath  catch messageBox "文件夹地址 不存在！"
	
	)else
	(
	
	if ckb1.state==true then 
	(
	 local name =getFilenameFile edt1.text
	 local tempPath=fengx.beWindowsPath (edt2.text+"/"+name)
	 print tempPath
	 try  ShellLaunch "explorer.exe" tempPath catch messageBox "文件夹地址 不存在！"
	)else (
	  tempPath = fengx.beWindowsPath  edt2.text
	try  ShellLaunch "explorer.exe"  tempPath  catch messageBox "文件夹地址 不存在！"
	)
	)
	)
	on ckb1 changed state do
	(
		
		)
	on btn85 pressed do
	(
	  if edt1.text !=undefined and edt1.text !=""do
	  (
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	  DotNetClipboard.SetText  edt1.text
	  )
	)
	on btn86 pressed do
	(
	 if edt2.text !=undefined and edt2.text !=""do
	  (
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	  DotNetClipboard.SetText  edt2.text
	 )
	)
	on btn31 pressed do
	(
	 edt1.text=""
	)
	on btn32 pressed do
	(
	 edt2.text=""
	)
	on btn47 pressed do
	(
	ShellLaunch "explorer.exe" (getdir #autoback)
	)
)











rollout snap "吸附" width:362 height:562
(
	--fn box_filt obj = classof obj == Box 
	pickbutton chooseit "拾取物体" pos:[0,116] width:128 height:20 --filter:Editable_Poly
	checkbutton p "Pos" pos:[16,20] width:48 height:20 checked:true
	checkbutton px "x" pos:[16,40] width:16 height:16 checked:true
	checkbutton py "y" pos:[32,40] width:16 height:16 checked:true
	checkbutton pz "z" pos:[48,40] width:16 height:16 checked:true
	checkbutton r "Rotate" pos:[0,56] width:48 height:24
	checkbutton rx "x" pos:[0,80] width:16 height:16
	checkbutton ry "y" pos:[16,80] width:16 height:16
	checkbutton rz "z" pos:[32,80] width:16 height:16
	checkbutton s "Scale" pos:[80,56] width:48 height:24
	checkbutton sx "x" pos:[80,80] width:16 height:16
	checkbutton sy "y" pos:[96,80] width:16 height:16
	checkbutton sz "z" pos:[112,80] width:16 height:16
	checkbutton pt "Pivot" pos:[64,20] width:48 height:20 enabled:true checked:false
	checkbutton ptx "x" pos:[64,40] width:16 height:16 checked:false
	checkbutton pty "y" pos:[80,40] width:16 height:16 checked:false
	checkbutton ptz "z" pos:[96,40] width:16 height:16 checked:false
	
	
	checkbutton localpos "@" pos:[0,20] width:16 height:20
	checkbutton localPivot "@" pos:[112,20] width:16 height:20
	button btn14 "置底" pos:[200,66] width:56 height:24
	button btn17 "归中" pos:[200,42] width:56 height:24
	button btn18 "Pos" pos:[128,113] width:24 height:24
	
	button bpxa "+" pos:[176,18] width:24 height:24
	button bpxr "-" pos:[128,18] width:24 height:24
	button btn152 "+" pos:[176,42] width:24 height:24
	button btn153 "-" pos:[128,42] width:24 height:24
	button btn154 "+" pos:[176,66] width:24 height:24
	button btn155 "-" pos:[128,66] width:24 height:24
	button btn156 "X" pos:[152,18] width:24 height:24
	button btn157 "Y" pos:[152,42] width:24 height:24
	button btn158 "Z" pos:[152,66] width:24 height:24
	button btn224 "Pivot" pos:[128,137] width:32 height:24
	checkbutton ckb19 "Name" pos:[0,96] width:48 height:20
	checkbutton ckb20 "Material" pos:[80,96] width:48 height:20
	button btn115 "右旋" pos:[192,188] width:64 height:24 
 
 
 
 
 
	button btn116 "左旋" pos:[128,188] width:64 height:24
	
	pickbutton btn99 "设置吸附目标对象" pos:[0,163] width:128 height:24
	button btn119 "吸附（带方向）" pos:[0,187] width:128 height:27 enabled:true
	button btn174 "吸附（仅位置）" pos:[0,214] width:128 height:28 enabled:true
	button btn78 "Rotate" pos:[164,113] width:40 height:24
	button btn79 "Scale" pos:[160,137] width:44 height:24
	button btn122 "所有" pos:[204,113] width:52 height:48
	button btn123 "重置（所选）属性" pos:[128,94] width:128 height:19 enabled:false
	button btn63 "置顶" pos:[200,18] width:56 height:24
	button btn53 "吸取属性" pos:[0,0] width:128 height:20 enabled:false
		
	button btn54 "Pivot" pos:[128,0] width:128 height:18 enabled:false
	button btn126 "吸附表面" pos:[0,144] width:128 height:19 enabled:false
	button btn127 "智能旋转" pos:[128,168] width:128 height:20 enabled:false
	button btn257 "" pos:[152,113] width:12 height:24 enabled:false
	button btn259 "" pos:[48,56] width:32 height:60 enabled:false
	button btn294 "" pos:[0,40] width:16 height:16 enabled:false
	button btn295 "" pos:[112,40] width:16 height:16 enabled:false
	on snap close do
	(
	if  canSetWindows==true do 
	(
	
	    snapSize=GetDialogSize snap
	    setinisetting  profilePath "rolloutSetting" "snapSize" (snapSize as string )
	
	    snappos=GetDialogPos snap
	    setinisetting  profilePath "rolloutSetting" "snapPos" (snappos as string )
	    )
	)
	on chooseit picked obj do
	( 
	 if obj != undefined and $!= undefined do
	 (
	 undo on(
		for s in $ do (
	         if ckb19.state==true do s.name=obj.name
	         if ckb20.state==true do s.material=obj.material
	
			if localPivot.state==true and localPos.state==true  then(
				CenterPivot s
				if ptx.state==true do s.pivot.x=obj.pivot.x
				if pty.state==true do s.pivot.y=obj.pivot.y
				if ptz.state==true do s.pivot.z=obj.pivot.z
				
				if px.state==true do s.pos.x=obj.pos.x
				if py.state==true do s.pos.y=obj.pos.y
				if pz.state==true do s.pos.z=obj.pos.z
			)else()
			if localPivot.state==true then(
			if ptx.state==true do s.pivot.x=(obj.max.x+obj.min.x)/2
			if pty.state==true do s.pivot.y=(obj.max.y+obj.min.y)/2
			if ptz.state==true do s.pivot.z=(obj.max.z+obj.min.z)/2
			)else(
				if ptx.state==true do s.pivot.x=obj.pivot.x
				if pty.state==true do s.pivot.y=obj.pivot.y
				if ptz.state==true do s.pivot.z=obj.pivot.z			
			)
			if localPos.state==true then(
				print "true"
				if px.state==true do s.pos.x=(obj.max.x+obj.min.x)/2
				if py.state==true do s.pos.y=(obj.max.y+obj.min.y)/2
				if pz.state==true do s.pos.z=(obj.max.z+obj.min.z)/2
			)else(
				print "false"
				if px.state==true do s.pos.x=obj.pos.x
				if py.state==true do s.pos.y=obj.pos.y
				if pz.state==true do s.pos.z=obj.pos.z
			
			)
			if sx.state==true do s.scale.x=obj.scale.x
			if sy.state==true do s.scale.y=obj.scale.y
			if sz.state==true do s.scale.z=obj.scale.z
			
			if rx.state==true do s.rotation.x=obj.rotation.x
			if ry.state==true do s.rotation.y=obj.rotation.y
			if rz.state==true do s.rotation.z=obj.rotation.z
		)
	 )
	--obj.wirecolor = red
		chooseit.text = "Pick:[ "+obj.name+" ]"
	 )
	 )
	on p changed state do
	(
				if state == on  then (
					px.state=true
					py.state=true
					pz.state=true
					)else(
						 px.state=false
						 py.state=false
						 pz.state=false
						)
		)
	on r changed state do
	(
				if state == on  then (
					rx.state=true
					ry.state=true
					rz.state=true
					)else(
						 rx.state=false
						 ry.state=false
						 rz.state=false
						)
		)
	on s changed state do
	(
				if state == on  then (
					sx.state=true
					sy.state=true
					sz.state=true
					)else(
						 sx.state=false
						 sy.state=false
						 sz.state=false
						)
		)
	on pt changed state do
	(
				if state == on  then (
					ptx.state=true
					pty.state=true
					ptz.state=true
					)else(
						 ptx.state=false
						 pty.state=false
						 ptz.state=false
						)
		)
	on ptx changed state do
	(
		
		)
	on pty changed state do
	(
		
		)
	on localpos changed state do
	(
		
		)
	on btn14 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do 
				if classOf(s)==Dummy then
				(
					CenterPivot s
					s.pivot.z=s.min.z
					)else
					(
						CenterPivot s
						print s
						s.pivot.z = s.min.z
						)
					)
			)
	)
	on btn17 pressed do
	(	
		undo on(
		if $!=undefined do 
		(
			for s in fengx.selectGroupDummy($) do 
			CenterPivot s
			)
		)
	)
	on btn18 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.pos=[0,0,0]
				)
		)
	)
	on bpxa pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.x=s.max.x
			)
		)
	)
	on bpxr pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.x=s.min.x 
			)
		)
	)
	on btn152 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.y=s.max.y
			)
		)
	)
	on btn153 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.y=s.min.y
			)
		)
	)
	on btn154 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.z=s.max.z
			)
		)
	)
	on btn155 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.z=s.min.z
			)
		)
	)
	on btn156 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.x=(s.max.x+s.min.x)/2
			)
		)
	)
	on btn157 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.y=(s.max.y+s.min.y)/2
			)
		)
	)
	on btn158 pressed do
	(
		undo on(
		if $!=undefined do
		(
			for s in fengx.selectGroupDummy($) do s.pivot.z=(s.max.z+s.min.z)/2
			)
		)
	)
	on btn224 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.pivot=[0,0,0]
				)
		)
	)
	on ckb19 changed state do
	(
	
		)
	on ckb20 changed state do
	(
	
		)
	on btn115 pressed do
	(
	
		if keyboard.shiftpressed then fengx.smartRotate 30
		else fengx.smartRotate 90
		)
	on btn116 pressed do
	(
	
		if keyboard.shiftpressed then fengx.smartRotate -30
		else fengx.smartRotate -90
		)
	on btn99 picked obj do
	( 
	 if obj != undefined and $!= undefined do
	(
		btn99.text = "Snap to :[ "+obj.name+" ]"
	     PGround=obj
	     --obj.wirecolor = red
	)
	 )
	on btn119 pressed do
	(
	if PGround !=undefined do mousetrack on:PGround prompt:"Tracking" trackCallback:fengx.smartColneD()
	)
	on btn174 pressed do
	(
	if PGround !=undefined do mousetrack on:PGround prompt:"Tracking" trackCallback:fengx.smartColneP()
	)
	on btn78 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.rotation=(quat 0 0 0 0)
				)
		)
	)
	on btn79 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.scale=[1,1,1]
				)
		)
	)
	on btn122 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do( 
	                if classOf(s)==Dummy then
				    (
					CenterPivot s
					s.pivot.z=s.min.z
					)else
					(
						CenterPivot s
						print s
						s.pivot.z = s.min.z
						)
				  s.pos=[0,0,0]
	                s.rotation=(quat 0 0 0 0)
	                s.scale=[1,1,1]
	                s.pivot=[0,0,0]
	        )
		)
	)
	)
	on btn123 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.rotation=(quat 0 0 0 0)
				)
		)
	)
	on btn63 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do 
				if classOf(s)==Dummy then
				(
					CenterPivot s
					s.pivot.z=s.min.z
					)else
					(
						CenterPivot s
						print s
						s.pivot.z = s.max.z
						)
					)
			)
	)
	on btn53 pressed do
	(
	btn53.images =  #(titeBarMap, undefined, 1,1,1,1,1 )
	
	)
	on btn126 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.rotation=(quat 0 0 0 0)
				)
		)
	)
	on btn127 pressed do
	(
		undo on(
		if $==undefined then
		(
			)else
			(
				for s in fengx.selectGroupDummy($) do s.rotation=(quat 0 0 0 0)
				)
		)
	)
)

















global CPOn=ture
rollout copyPaste "物件复制管理" width:1850 height:420
(
	checkbutton ckb01 "ckb01" pos:[48,0] width:160 height:112 enabled:true
	checkbutton ckb02 "ckb01" pos:[208,0] width:160 height:112 enabled:true
	checkbutton ckb03 "ckb01" pos:[368,0] width:160 height:112 enabled:true
	checkbutton ckb04 "ckb01" pos:[528,0] width:160 height:112 enabled:true
	checkbutton ckb05 "ckb01" pos:[688,0] width:160 height:112 enabled:true
	checkbutton ckb06 "ckb01" pos:[848,0] width:160 height:112 enabled:true
	checkbutton ckb07 "ckb01" pos:[1008,0] width:160 height:112 enabled:true
	checkbutton ckb08 "ckb01" pos:[1168,0] width:160 height:112 enabled:true
	checkbutton ckb11 "ckb01" pos:[48,112] width:160 height:112 enabled:true
	checkbutton ckb12 "ckb01" pos:[208,112] width:160 height:112 enabled:true
	checkbutton ckb13 "ckb01" pos:[368,112] width:160 height:112 enabled:true
	checkbutton ckb14 "ckb01" pos:[528,112] width:160 height:112 enabled:true
	checkbutton ckb15 "ckb01" pos:[688,112] width:160 height:112 enabled:true
	checkbutton ckb16 "ckb01" pos:[848,112] width:160 height:112 enabled:true
	checkbutton ckb17 "ckb01" pos:[1008,112] width:160 height:112 enabled:true
	checkbutton ckb21 "ckb01" pos:[48,224] width:160 height:112 enabled:true
	checkbutton ckb22 "ckb01" pos:[208,224] width:160 height:112 enabled:true
	checkbutton ckb23 "ckb01" pos:[368,224] width:160 height:112 enabled:true
	checkbutton ckb24 "ckb01" pos:[528,224] width:160 height:112 enabled:true
	checkbutton ckb25 "ckb01" pos:[688,224] width:160 height:112 enabled:true
	checkbutton ckb26 "ckb01" pos:[848,224] width:160 height:112 enabled:true
	checkbutton ckb27 "ckb01" pos:[1008,224] width:160 height:112 enabled:true
	checkbutton ckb18 "ckb01" pos:[1168,112] width:160 height:112 enabled:true
	checkbutton ckb28 "ckb01" pos:[1168,224] width:160 height:112 enabled:true
	checkbutton ckb09 "ckb01" pos:[1328,0] width:160 height:112 enabled:true
	checkbutton ckb10 "ckb01" pos:[1488,0] width:160 height:112 enabled:true
	checkbutton ckb19 "ckb01" pos:[1328,112] width:160 height:112 enabled:true
	checkbutton ckb29 "ckb01" pos:[1328,224] width:160 height:112 enabled:true
	checkbutton ckb20 "ckb01" pos:[1488,112] width:160 height:112 enabled:true
	checkbutton ckb30 "ckb01" pos:[1488,224] width:160 height:112 enabled:true
	checkbutton ckbf "复制" pos:[0,0] width:48 height:24
	checkbutton ckbn "黏贴" pos:[0,24] width:48 height:24 checked:true
	button btn29 "@" pos:[0,136] width:48 height:20
	button btn84 "清除" pos:[0,112] width:48 height:24
	button btn34 "↓" pos:[0,92] width:48 height:20
	
	function updateImage=
	(
		cbks=#(ckb01,ckb02,ckb03,ckb04,ckb05,ckb06,ckb07,ckb08,ckb09,ckb10,ckb11,ckb12,ckb13,ckb14,ckb15,ckb16,ckb17,ckb18,ckb19,ckb20,ckb21,ckb22,ckb23,ckb24,ckb25,ckb26,ckb27,ckb28,ckb29,ckb30)
		bc=color 64 67 65 60 
		theBmp = (BitMap 160 112 color:bc) 
		theDefultBmp = (BitMap 160 112 color:bc) 
		for i=1 to 30 do 
		(
		imagePath= fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/" +"copyTemp"+i as string + ".jpg")
		if doesFileExist imagePath then(
			theBmp =openBitMap  imagePath
			)else(
			imagePath= fengx.beWindowsPath  (getDir #Scripts+ "/visualFengx/copyPasteDefult.png")
			if doesFileExist imagePath  do theBmp =openBitMap  imagePath
			)
			try cbks[i].images=#(theBmp, undefined, 1,1,1,1,1 ) catch (print "-->>>> setImages error! in copyPaste.ckb"+i as string )
		)
	)

	checkbutton ckb42 "home" pos:[136,384] width:128 height:24
	button btn35 "↑" pos:[0,184] width:48 height:20
	button btn36 "↑" pos:[0,316] width:48 height:20
	button btn37 "↓" pos:[0,204] width:48 height:20
	button btn50 "←" pos:[0,68] width:16 height:24
	button btn51 "→" pos:[32,68] width:16 height:24
	button btn60 "↑" pos:[0,48] width:48 height:20
	button btn61 "●" pos:[16,68] width:16 height:24
	on copyPaste open do
	(
	updateImage()
	)
	on copyPaste close do
	(
	    copyPasteSize=GetDialogSize copyPaste
	    setinisetting  profilePath "rolloutSetting" "copyPasteSize" (copyPasteSize as string )

	    copyPastepos=GetDialogPos copyPaste
	    setinisetting  profilePath "rolloutSetting" "copyPastePos" ( copyPastepos as string )
	    )
	on ckb01 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 1 
	  updateImage()
	)
	else  fengx.pasteNodes 1
	)
	on ckb02 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 2 
	  updateImage()
	)
	else  fengx.pasteNodes 2
	)
	on ckb03 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 3 
	  updateImage()
	)
	else  fengx.pasteNodes 3
	)
	on ckb04 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 4
	  updateImage()
	)
	else  fengx.pasteNodes 4
	)
	on ckb05 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 5
	  updateImage()
	)
	else  fengx.pasteNodes 5
	)
	on ckb06 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 6
	  updateImage()
	)
	else  fengx.pasteNodes 6
	)
	on ckb07 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 7
	  updateImage()
	)
	else  fengx.pasteNodes 7
	)
	on ckb08 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 8
	  updateImage()
	)
	else  fengx.pasteNodes 8
	)
	on ckb11 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 11 
	  updateImage()
	)
	else  fengx.pasteNodes 11
	)
	on ckb12 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 12
	  updateImage()
	)
	else  fengx.pasteNodes 12

	)
	on ckb13 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 13
	  updateImage()
	)
	else  fengx.pasteNodes 13
	)
	on ckb14 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 14
	  updateImage()
	)
	else  fengx.pasteNodes 14
	)
	on ckb15 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 15
	  updateImage()
	)
	else  fengx.pasteNodes 15
	)
	on ckb16 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 16
	  updateImage()
	)
	else  fengx.pasteNodes 16

	)
	on ckb17 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 17
	  updateImage()
	)
	else  fengx.pasteNodes 17
	)
	on ckb21 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 21 
	  updateImage()
	)
	else  fengx.pasteNodes 21
	)
	on ckb22 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 22
	  updateImage()
	)
	else  fengx.pasteNodes 22
	)
	on ckb23 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 23
	  updateImage()
	)
	else  fengx.pasteNodes 23
	)
	on ckb24 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 24
	  updateImage()
	)
	else  fengx.pasteNodes 24
	)
	on ckb25 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 25
	  updateImage()
	)
	else  fengx.pasteNodes 25
	)
	on ckb26 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 26
	  updateImage()
	)
	else  fengx.pasteNodes 26
	)
	on ckb27 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 27
	  updateImage()
	)
	else  fengx.pasteNodes 27
	)
	on ckb18 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 18
	  updateImage()
	)
	else  fengx.pasteNodes 18
	)
	on ckb28 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 28
	  updateImage()
	)
	else  fengx.pasteNodes 28
	)
	on ckb09 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 9
	  updateImage()
	)
	else  fengx.pasteNodes 9
	)
	on ckb10 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 10
	  updateImage()
	)
	else  fengx.pasteNodes 10
	)
	on ckb19 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 19
	  updateImage()
	)
	else  fengx.pasteNodes 19
	)
	on ckb29 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 29
	  updateImage()
	)
	else  fengx.pasteNodes 29
	)
	on ckb20 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 20
	  updateImage()
	)
	else  fengx.pasteNodes 20
	)
	on ckb30 changed state do
	(
	if CPOn==true then (
	  fengx.copyNodes 30
	  updateImage()
	)
	else  fengx.pasteNodes 30
	)
	on ckbf changed state do
	(
	ckbn.state=false
	CPOn=true
	)
	on ckbn changed state do
	(
	ckbf.state=false
	CPOn=false
	)
	on btn29 pressed do
	(
	ShellLaunch "explorer.exe" (fengx.beWindowsPath(copyPastePath + "/visualFengx/copyPasteTemp/"))
	)
	on btn84 pressed do
	(
	if (queryBox "确定要全删掉！不可撤销！")==true do 
	(
	for i=1 to 30 do 
	(

		 imagePath= fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/" +"copyTemp"+i as string + ".jpg")
		 maxPath = fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/"  +"copyTemp"+i as string +	".max" )
		 deleteFile  imagePath
		 deleteFile  maxPath 
	)
	updateImage()
	)
	)
	on btn34 pressed do
	(
	if copyPaste.height<336 then copyPaste.height+=112 else copyPaste.height=112
	)
	on ckb42 changed state do
	(
		
		)
	on btn35 pressed do
	(
	copyPaste.height=112
	)
	on btn36 pressed do
	(
	copyPaste.height=224
	)
	on btn37 pressed do
	(
	copyPaste.height=336
	)
	on btn50 pressed do
	(
	if copyPaste.width>208 then copyPaste.width-=160 else copyPaste.width=1648
	)
	on btn51 pressed do
	(
	if copyPaste.width<1648 then copyPaste.width+=160 else copyPaste.width=208
	)
	on btn60 pressed do
	(
	if copyPaste.height>112 then copyPaste.height-=112 else copyPaste.height=336
	)
	on btn61 pressed do
	(
	copyPaste.height=112
	copyPaste.width=846
	)
)


















U_bc=color 64 67 65 60 
U_updateBmp = (BitMap 160 112 color:U_bc) 
U_imagePath=  (getDir #Scripts+ "\\visualFengx\\copyPasteDefult.png")
if doesFileExist U_imagePath do U_updateBmp=openBitMap  U_imagePath
	
rollout checkUpDateWindow "UpDate" width:159 height:390
(
	button btn54 "x" pos:[-1,-1] width:160 height:112 images:#(U_updateBmp, undefined, 1, 1, 1, 1, 1)
	label lb01 "" pos:[1,112] width:159 height:208
	button btn55 "更新" pos:[80,320] width:80 height:48
	button btn56 "下次在说" pos:[0,320] width:80 height:48
	button btn57 "不要提醒了" pos:[0,368] width:160 height:24


	
	on btn55 pressed do
	(
	fengx.upDate()
	)
	on btn56 pressed do
	(
	try destroyDialog checkUpDateWindow catch ()
	)
	on btn57 pressed do
	(
	alertUpdate=false
	setIniSetting  profilePath "upDate" "alertupDate" "false"
	try destroyDialog checkUpDateWindow catch ()
	)
)
	










--------------------------------------------------------------------------------------------------------------------------------------
-------------------- rollout ---------------------------------------------------------------------------------------------------------

-------------------- function --------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
struct fengx
(

------------------创建窗口------------------------------
fn llllllllllllllllllllllllllllllllllllllllllllllllsystemToolFn=(),
--------------------------------------------------------
-------------------------system tool-------------------------
function sendToGithub GitHubPath=
(
	local oPath=getDir #scripts +"\\visualfengx\\" 
	local startFile=getDir #startupScripts +"\\fengx_start.ms"
	local files=getFiles (oPath+"*")
	for f in files do 
	(
		local fName=filenameFromPath f 
		local newPath=GitHubPath as string +"\\visualfengx\\" + fName
		if doesFileExist newPath do deleteFile newPath
		if (copyFile f newPath) then () else (messageBOx ("复制失败"+f) )
		)
	local newStartFilePath=GitHubPath as string +"Startup\\fengx_start.ms"
	if doesFileExist newStartFilePath do deleteFile newStartFilePath
	if (copyFile startFile newStartFilePath )then () else (messageBOx ("复制失败"+startFile) )
	),
	
	
function uninstall=
(
	if (queryBox "确定卸载！")==true do
	(
	print  VisualFengxVersions as string
	local targetPath=getDir #scripts +"\\VisualFengx\\*"
	local files=getFiles targetPath
	deleteFile  (getDir #startupScripts +"\\fengx_start.ms")
	for f in files do deleteFile f		
	local MacrosPath=getdir #userMacros +"\\visualfengx*.mcr"
	local Macrosfiles = getFiles MacrosPath
	for s in Macrosfiles do deleteFile s
	
	if (queryBox "卸载完成 最好重启Max！")==true do 
	(
		if checkForSave() then (
		shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
		quitmax #noPrompt
		)
		)
	)
),

function checkUpdate=
(
updateA=false
local web = dotNetObject "System.Net.WebClient"
local updateFileUrl = "https://raw.github.com/fengxxx/VisualFengx_3dmax/Netease/update"
local updateFilePath = getDir #downloads +"\\update"
local tempon=true

try web.DownloadFile updateFileUrl  updateFilePath catch
(
tempon=false 
 messageBox "检测更新失败!"
)
if (doesFileExist updateFilePath )==true then 
(
	
	try updateFile=openFile updateFilePath  catch
	(
	 messageBox "update fath! -->> open  update file fath!"
	 tempon=fasle
	)
	
	if tempon==true do(
		i=1
		tempMsg=""
		while not eof updateFile do
		(
		lineStr = readLine updateFile

		if i==1 then( if lineStr !=undefind and lineStr !="" and (lineStr as float) !=undefined do try  newVersions = (lineStr as float) catch (tempon=false))else
			(

				tempMsg+=(lineStr  as string + "\n")
				)
		i+=1
		)
		upDateMsg=tempMsg as string
				
				
				
		if 	newVersions > VisualFengxVersions then
		( 
			updateA=true 
			)else 
		(
			print "该版本已经为最新！无需更新!"
		)
	)	

)else print ("cant find update file! in " +updateFilePath )
return updateA
),


function update=
(
local web = dotNetObject "System.Net.WebClient"
local installFileUrl="https://github.com/fengxxx/VisualFengx_3dmax/raw/Netease/VisualFengx_"+(newVersions as string )+".mzp"
local installFilePath= getDir #downloads +"\\VisualFengx_"+(newVersions as string )+".mzp"
tempon=true
try web.DownloadFile installFileUrl  installFilePath catch
(
tempon=false 
 messageBox "VisualFengx 下载更新失败"
)
if tempon==true do 
(	
	tempstr ="VisualFengx "+ (newVersions as string ) +" 下载完成！ 是否开始更新" 
	if (queryBox tempstr)==true do
	(
		try destroyDialog checkUpDateWindow catch ()
		fileIn installFilePath
	)
)
),
	
fn BubbleSort a=
(    
    temp = 0
    for i = 1 to a.count do 
    (
        for j = 1 to  i do 
        (        
            if (j<a.count) do 
            (
                x=a[j + 1]
                y=a[j]
                if x<y do 
                (    
                    temp=a[j]
                    a[j]=a[j + 1]
                    a[j + 1]=temp
                    )
                )
            )
        )
    ),
fn bubbleSortArry b=
(    
    temp = undefined
    for i = 1 to b.count do 
    (
        for j = 1 to  i do 
        (        
            if (j<b.count) do 
            (
                x=(b[j + 1].max.x-b[j + 1].min.x)--*(b[j + 1].max.y-b[j + 1].min.y)*(b[j + 1].max.z-b[j + 1].min.z)
                y=(b[j].max.x-b[j + 1].min.x)--*(b[j].max.y-b[j + 1].min.y)*(b[j].max.z-b[j + 1].min.z)
                if x<y do 
                (    
                    temp=b[j]
                    b[j]=b[j + 1]
                    b[j + 1]=temp
                    )
                )
            )
        )
    return b
    ),
	
fn backupMax nodes=
(
    if nodes !=undefined do
    (	
		name=maxfilename
		try nodes.count==undefined catch name=nodes.name
		try name=(fengx.selectGroupDummy nodes)[1].name catch print "no group" 
    
		tempPath=maxfilepath+name
		targetPath=""
		targetPath=getSaveFileName  caption:"save nodes"  types:"*.max" filename: tempPath
		if targetPath!=""and targetPath!=undefined do 
	    (
			try saveNodes nodes (targetPath+".max") catch print "save fail！"
			maxPath=fengx.beWindowsPath (targetPath+".max")
    		)
	)

),

fn splitMaxs =
(
exportPath="d:/"
maxsPath=getSavePath   caption:"get to"

if maxsPath!=undefined do 
	( 
	saveToPath =  getSavePath    caption:"save to"
	if saveToPath !=undefined do
		(
		tempPath=getDirectories (maxsPath + "/*")
		all=#()
		for a in tempPath do(
		 append all (getfiles (a+"max/*.max"))
		)
		print(">>>>"+(all.count as string )+" max files > "+(all as string))
		for p in all do  (
			max select all
			max delete
			loadMaxFile (fengx.beWindowsPath p)
			print ("start split Max in path --->  "+ fengx.beWindowsPath p)
			max select all
			t=0
			if $!=undefined do (
				for tt in $ do t+=1		
				if t!=1 or t!=0 do 
				(
					fengx.saveToStandType $ saveToPath
				)
				)
		)
		ShellLaunch "explorer.exe"   saveToPath 
		)
	)
),


function saveToStandType nodes exportPath=
(		
if nodes!=undefined do 
(
	
	--exportPath =getSavePath  caption:"get to"
	if exportPath !=undefined then 
	(
		for s in nodes do (
			print ("start  " +s.name+"  save.....")
			
			local sPos=s.pos
			try s.pos=[0,0,0] catch ()
			nodePath=fengx.beWindowsPath (exportPath+"/"+s.name+"/max")
			makeDir nodePath
			maxPath=fengx.beStringPath (nodePath +"/"+s.name+".max")
			local saveOn=true
			try saveNodes s maxPath catch  saveOn=false 
			if saveOn==true then 
			(
				s.pos=sPos
				print ("  -- > max was saved success.....")
				print ("start  " +s.name+" maps  save.....")
				-->> save a thumbnail
				--select s
				macros.run "Tools" "Isolate_Selection"
				max zoomext sel all
				
				bc=color 64 67 65 60 
				theBmp = (bitmap 160 112 color:bc)
			     try theBmp = render outputsize:[1024,768] vfb:off catch messageBox("渲染缩略图失败")
				thebmp.filename=fengx.beWindowsPath (exportPath + "/" + s.name + "/" + s.name +".jpg")
				save theBmp 
				max views undo
				max unhide all

				
				for map in  (fengx.getTrueMapPath s) do
					(
					tName =getFilenameFile map
					tType= getFilenameType map
					tempMapPath=fengx.beStringPath  (nodePath +"/" + tName +tType)
					local copySOn=true
					if doesFileExist map ==true then(
						try copyfile map tempMapPath catch (
							 print ("....."+map +" was not be saved.....")
							 copySOn=false
							 )
						 )else(
							print ("  ------  "+map +"     > map does not exist .....")
							copySOn=false
							)
					if copySOn==true do print ("  ------  "+map +"     > map was copyed success.....")
					)
				print ("-----  " +s.name+" maps be saved.....")
			)else print (s.name+"   was not be saved.....")
		)
	)else print "not choese save path...  will not be saved... "
)


),

function  copyNodes  NO =
(
	local targetPath = copyPastePath + "/visualFengx/copyPasteTemp/"  +"copyTemp"+NO as string +	".max" 
	makeDir (copyPastePath+ "/visualFengx/copyPasteTemp")
	targetPath = fengx.beWindowsPath targetPath 
	if $ != undefined and NO != undefined do 
	(
	saveNodes $  targetPath
	bc=color 64 67 65 60 
	theBmp = (bitmap 160 112 color:bc)
	macros.run "Tools" "Isolate_Selection"
	max zoomext sel all
	try theBmp = render outputsize:[160,112] vfb:off catch messageBox("渲染缩略图失败")
	max unhide all
	max views undo
	max views undo
	thebmp.filename=fengx.beWindowsPath (copyPastePath+ "/visualFengx/copyPasteTemp/" +"copyTemp"+NO as string +	".jpg")
	--print thebmp.filename
	save theBmp 
	)
	),
	
	
function  pasteNodes NO=
(
	local targetPath = fengx.beWindowsPath(copyPastePath+ "/visualFengx/copyPasteTemp/" +"copyTemp"+NO as string +	".max" )
	targetPath = fengx.beWindowsPath targetPath 
	if NO != undefined do  mergemaxfile  targetPath  #select  
	),
	
fn exportSelectToVisual=
(
	name=maxfilename
	try $.count catch name=$.name 
	try name=(fengx.selectGroupDummy $)[1].name catch print "no group" 

	if $!=undefined do 
	(
		tempTargetPath=fengx.getNamePath(name) --"E:/mf_pangu/tw2/res/scene/common/"+
		)
	tempTargetPath=tempTargetPath+name
	print (tempTargetPath+".visual")
	targetPath=getSaveFileName  caption:"save select"  types:"*.visual"  filename:tempTargetPath
	if targetPath!=""and targetPath!=undefined do 
    (
	  	targetPath=tempTargetPath+".visual" 
		theClasses = VisualExporter
		exportFile (targetPath) selectedOnly:true  using:theClasses	
    )
	visualPath=fengx.beWindowsPath TargetPath
),

fn getNamePath n=
(
	path="E:/mf_pangu/tw2/res/scene/common/"
	tw1=""
	tw2=""
	count=0
	for i=1 to n.count do(
		if n[i]=="_" do  count+=1
		if count>=1 and count<2 do 	tw1+=n[i]
		if count>=2 and count<3 do  tw2+=n[i]
	)
	
	tw1=fengx.getLetter(tw1)
	tw2=fengx.getLetter(tw2)
	if tw1[1]=="j" and tw1.count>3 then(
		path=path+tw1[1]+tw1[2]+"/"+tw1+"/"+tw1[3]+tw1[4]+tw2+"/"
	)else(
		if tw1.count>2 do path=path+tw1[1]+tw1[2]+"/"+tw1+"/"
	)
	b=getDirectories(path+"*")
	
	if b.count==0 and tw1[1]!="l"do path="E:/mf_pangu/tw2/res/scene/common/"
	
	--print path
	return path
),

fn getLetter n=
(
	name=""
	for i=1 to n.count do(
		if n[i]>="A" and n[i]<="z" and n[i]!="_" do name+=n[i]  
	)
	return name
),
fn exportSelectToOBJ=
(
	name=maxfilename
	try $.count==undefined catch name=$.name
	try name=(fengx.selectGroupDummy $)[1].name catch print "no group" 
	tempPath=maxfilepath+name
	

	safePath=ture 
    targetPath=getSaveFileName  caption:"save select"  types:"*.obj"  filename: tempPath
	if targetPath!=""and targetPath!=undefined do 
    (
		try exportFile (targetPath) selectedOnly:true using:Wavefront_ObjectExporterPlugin   catch  print "export fail on  exportSelectToOBJ()"
    		objPath=fengx.beWindowsPath (targetPath+".obj")
	)
),
fn randomColor=
(
    a=undefined
    r=(random 0 225)
    g=(random 0 225)
    b=(random 0 225)
    a=color   r g b 0
    return a
),

fn beWindowsPath thePath=
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
),
fn beStringPath thePath=
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
),


fn restart =
(
    if checkForSave() then (
        shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
        quitmax #noPrompt
    )
),
    
fn fixAmbientColor n=
(
	undo on(
		if n=="+" do
		(
			if ambientColor.r>255 then ambientColor=(color 255 255 255) else ambientColor*=2
			if ambientColor.r<1 then ambientColor= (color 3 3 3) else ambientColor*=2

		)
		if n=="-" do
		(
		 	ambientColor/=2
		)
	)
),
-------------------------------------------------------------
-------------------------system tool-------------------------

fn llllllllllllllllllllllllllllllllllllllllllllllllmatelrialToolFn=(),
-------------------------matelrial tool----------------------
 function clearObjectMultiMaterial nodes=
(
	if nodes!=undefined do
	(
	for n in nodes do
	(
	if classOf n == Editable_Poly do 
	(
	if classOf n.material == MultiMaterial do
	(
		if n.material.count !=1 then
		(
		local deleteIds=#()
		for i=1 to n.material.count do 
		(
			subobjectLevel = 0	
			clearSelection()
			select n
			subobjectLevel = 4
			MID=n.material.materialIDList[i]
			n.selectByMaterial MID
			faces=n.getSelection #Face
			if (faces as array).count== 0 do append deleteIds MID 
		)
		
		if deleteIds.count!=0 and deleteIds!=undefined do 
		(
			print "多余材质ID"
			print deleteIds as string
			--build a new MultiMaterial
			newMM=MultiMaterial()
			if (n.material.count-deleteIds.count)==0  then newMM.materialList.count == 1 else
			( 
				newID=1
				newMM.materialList.count = n.material.count-deleteIds.count
				for i=1 to n.material.materialIDList.count do 
				(
					if findItem deleteIds n.material.materialIDList[i]  ==0 do
					(					
						newMM[newID]=n.material[i]
						newMM.materialList[newID]=n.material.materialList[i]
						newID+=1
						)
				)
				subobjectLevel = 0
				n.material=newMM
				if n.material.count==1 do 
				(
					local newMate=StandardMaterial()
					newMate=n.material[1]
					n.material=newMate
				)	
			)
		)
	)else
	(
		local newMate=standardMaterial()
		newMate=n.material[1]
		n.material=newMate
	)
	)
	)
	)
	)
),
 

fn openTexFile m=
(
	try	 dir2=m.DiffuseMap.bitmap.filename catch print "根本就没贴图 怎么打的开！"-- messageBox(" 根本就没贴图 怎么打的开！") title:"擦擦擦擦擦擦！！！"
	if dir2!=""and dir2!=undefined do 
	(
	if (getfiles dir2).count != 0 do(
	dir2="/select,"+dir2
	try  ShellLaunch "explorer.exe" dir2  catch print "硬是没打开！"--messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！！"
	)
	)
),

---材质命名
fn  TexNameToMateName=
(    
    undo on(
    if $==undefined do
    (
        messageBox "选个东西 在按" title:"Material tool" beep:on 
        )
    if $!=undefined and (classOf($))!=Dummy do 
    (
        for sm in $ do
        (    
            if classOf(sm.Material)==Standardmaterial do
            (
			str3="物件(" +sm.name+")的材质"
           	fengx.namedMate sm.Material str3 
			print("物件（"+sm.name+"）")
			)
			if classOf(sm.Material)==MultiMaterial do
			(
				sm.Material.name=sm.name
				i=0
				for s in sm.Material do
				(
					str2="物件(" +sm.name+")第"+(i+1) as String+"个材质"
					print (i)
					fengx.namedMate s  str2
					
					i+=1
					)
				 print("物件("+sm.name+")")
				)
            )
        )
    )
),

fn namedMate mate s=
( 
	undo on (
	str=""
	if classOf(mate)==Standardmaterial do
            (
              try (
				 mate.name=getFilenameFile mate.DiffuseMap.bitmap.filename 
				 print  ("      "+ mate.name+"       ") 
				) catch  print "  找不到diffuse ！名字自己改吧！"--messagebox   (s+"的Diffuse贴的不是图吧！！！ 这个材质无法命名！")   title:" 擦擦擦擦擦！ "
		    )
		)
),




-------------------------matelrial tool----------------------
-------------------------UV tool-----------------------------
fn lllllllllllllllllllllllllllllllllllllllllllllllleditUVFn=(),
fn alignU=
(
if $!=undifined and classOf(modpanel.getcurrentobject())==Unwrap_UVW do 
(

UV = modpanel.getcurrentobject()
uvsel = uv.getselectedvertices() as array
mid = 0.0
for i in uvsel do
	(
	mid += (uv.getvertexposition currenttime i).x
	)
mid /= uvsel.count

undo "Align U" on
	(
	uv.forceupdate false
	uv.movex mid
	uv.forceupdate true
	uv.updateview()
	)	

)
),

fn alignV=
(
if $!=undifined and classOf(modpanel.getcurrentobject())==Unwrap_UVW do 
(

	uvsel = uv.getselectedvertices() as array
	mid = 0.0
	for i in uvsel do
		(
		mid += (uv.getvertexposition currenttime i).y
		)
	mid /= uvsel.count
	
	undo "Align V" on
		(
		uv.forceupdate false
		uv.movey mid
		uv.forceupdate true
		uv.updateview()
		)
	

)
),


-------------------------UV tool-----------------------------
fn lllllllllllllllllllllllllllllllllllllllllllllllleditModelFn=(),
-------------------------edit model--------------------------
--将选中的模型导出Obj 在导入 借此来重置下
fn showInfor=(
	if $ != undefined do 
	(
	try $.count catch(
	if classof($)==GeometryClass or classof(classof($))==GeometryClass do
	( 
	s=$
	p=$.pos
	text size:100  pos:p isSelected:on name:("Text_"+s.name)
	text01=getnodebyname ("Text_"+s.name)
	text01.text=(s.name)+"\n"+"  三角面 " +s.mesh.numFaces as string+" 个"
	)
	)

)
),

fn resetModel =
(    
undo on(
	if $ != undefined do 
	(
	yuModel=$
	next=true
	try $.count !=null catch yuMate=$.material
	targetPath="D:\\temp.obj"
	try exportFile "d:/temp.obj" #noPrompt selectedOnly:true catch (
		messageBox("import fail!") title:"擦擦擦擦擦擦！！！"
		next=false
	)

	--try exportFile (targetPath) selectedOnly:true using:Wavefront_ObjectExporterPlugin catch(
	--	messageBox("import fail!") title:"擦擦擦擦擦擦！！！"
	--	next=false
	--)
	importOn=true
	if next==true do(
		try importFile "d:/temp.obj" #noPrompt catch importOn=false
		--try importFile (targetPath) using:Wavefront_Object catch importOn=false
		if importOn==true do(
			if $!=undefined do(
				try $.material=yuModel.material catch  print "x"
				try $.pivot=yuModel.pivot catch print "x"
			)
			delete(yuModel)
		)
	)
)
)
),

fn matrixSort =
(
	if $!=undefined do(
	   if $.count>100 do(
			strcount="物体数量达到" + ($.count as string )+"耐心等待！"
			messagebox strcount  title:" 擦擦擦擦擦擦！ " 
			)
		)
	obj=fengx.BubbleSortArry(fengx.selectGroupDummy($))
	
		
		
	izz=obj.count/(matrix_x*matrix_y)
	iyy=(obj.count-izz*matrix_y*matrix_x)/matrix_y
	ixx=obj.count-izz*matrix_x*matrix_y-iyy*matrix_x
	for iz=1 to izz do
	(
		allx=0
		ally=0
		allz=0
		for iay=1 to matrix_y do 
		(
			for iax=1 to matrix_x do 
			(	
				count=(iz-1)*matrix_x*matrix_y+(iay-1)*matrix_x+iax
				allx=allx+(obj[count].max.x-obj[count].min.x)
				ally=ally+(obj[count].max.y-obj[count].min.y)
				allz=allz+(obj[count].max.z-obj[count].min.z)
			)
		)

		ax=allx/(matrix_x*matrix_y*izz)
		ay=ally/(matrix_x*matrix_y*izz)
		az=allz/(matrix_x*matrix_y*izz)
		print az
		print ay
		print ax
		for izy=1 to matrix_y do 
		(
			for izx=1 to matrix_x do 
			(
				count=(iz-1)*matrix_x*matrix_y+(izy-1)*matrix_x+izx
				obj[count].pos.z=(iz-1)*az
				obj[count].pos.y=(izy-1)*ay
				obj[count].pos.x=(izx-1)*ax
			)
		)
	)
	
	
	for iy=1 to iyy do 
	(
		for iyx=1 to matrix_x do 
		(
				
		)
	)

	for ix=1 to ixx do 
	(
		
	)


	),


--物体重新矩阵排列
fn setpos n=
(
    undo on(
    allx=0
    A=0
    all=0
    if $!=undefined do
    (
        
        if classof($)==ObjectSet do 
        (
            if $.count>100 do(
                strcount="物体数量达到" + ($.count as string )+"耐心等待！"
                messagebox strcount  title:" ca！ " 
                )
            )
        
        b=fengx.BubbleSortArry(fengx.selectGroupDummy($))
        if n=="resetZ" do 
        (
            for s in g do 
            (
                s.pos.z=0    
                )
        )
        if n=="reposx" do 
        (    
            for s in g do 
            (
                s.pos.z=0
                s.pos.y=0
                
                s.pos.x=allx+(s.max.x-s.min.x)/2
                allx=allx+(s.max.x-s.min.x)
                )
            )
        if n=="reposy" do 
        (    
            for s in g do 
            (
                s.pos.z=0
                s.pos.x=0
                s.pos.y=allx+(s.max.y-s.min.y)/2
                allx=allx+(s.max.y-s.min.y)
                )
            )        
        if n=="reposz" do 
        (    
            for s in g do 
            (
                s.pos.x=0
                s.pos.y=0
                s.pos.z=allx+(s.max.z-s.min.z)/2
                allx=allx+(s.max.z-s.min.z)
                )
            )
        if n=="averageX" do 
        (
            for s in g do 
            (
                all=all+s.pos.x
                )
            A=all/g.count
            for s in g do 
            (
                g.pos.x=A
                )
        )
        if n=="averageY" do 
        (    
            for s in g do 
            (
                all=all+s.pos.y        
                )
            A=all/g.count
            for s in g do 
            (
                g.pos.y=A
                )
        )
        if n=="averageZ" do 
        (
            for s in g do 
            (
                all=all+s.pos.z
                )
            A=all/g.count
            for s in g do 
            (
                g.pos.z=A
                )
            )
        
        )

    )
),

--排除掉已经归入组的物体   node 或者 node[]
fn selectGroupDummy select=
(    
    GroupDummy=#()
    --theDummy=undefined 
    if select!=undefined do 
    (
        for s in select do  
        (
            if isGroupMember(s)!=true do append GroupDummy s
        ))
    --theDummy=GroupDummy[1]
	return GroupDummy
),
-- reject != StandardMaterial
fn toStandardMate mate=
(	
	mateStandard=#()
	try(
	for s in mate do(
		if classof(s)==Standardmaterial do append mateStandard s
		if classof(s)==Multimaterial do 
		(
			for sm in s do 
			(
				if classof(sm)==Standardmaterial do append mateStandard sm
			)
		)
		)
	) catch print "no material!"
	return mateStandard
),-------------------------edit model---------------------------



fn smartColneD message intRay obj faceNumber shift ctrl alt =
(
	 
	returnValue = case message of
	(
	 	#freeMove:  (#continue)
		
		#mouseAbort: (undefined)
		
		#mousePoint:
		(
		 	if (obj != undefined) and (intRay != undefined) do
			(
				$.pos=(intRay.pos)
				$.dir=intRay.dir
			)
			#continue
		)
		
		#mouseMove: (#continue)
	)
	returnValue
),

fn smartColneP message intRay obj faceNumber shift ctrl alt =
(
	 
	returnValue = case message of
	(
	 	#freeMove:  (#continue)
		
		#mouseAbort: (undefined)
		
		#mousePoint:
		(
		 	if (obj != undefined) and (intRay != undefined) do
			(
				$.pos=(intRay.pos)
				--$.dir=intRay.dir
			)
			#continue
		)
		
		#mouseMove: (#continue)
	)
	returnValue
),









fn llllllllllllllllllllllllllllllllllllllllllllllllcreateObjectFn=(),
-------------------------create model-------------------------

fn createBox=
(
undo on(
    bpos=[0,0,0]
    sx=10.0
    sy=10.0
    sz=10.0
    if $ !=undefined then
    (    
        sx=($.max.x-$.min.x)
        sy=($.max.y-$.min.y)
        sz=($.max.z-$.min.z)
        bx=($.max.x-$.min.x)/2+$.min.x
        bpy=$.max.y+sy  
        
		bmx=($.max.x+$.min.x)/2
		bmy=($.max.y+$.min.y)/2
		bpos=[bmx,bmy,$.max.z]
		
        Box lengthsegs:1 widthsegs:1 heightsegs:1 length:sy width:sx height:sz mapcoords:on pos:bpos isSelected:on        
        $.material=Standardmaterial ()  
		$.name=$.name+"_fengx"
    )else
    (
        Box lengthsegs:1 widthsegs:1 heightsegs:1 length:10 width:10 height:10 mapcoords:on pos:bpos isSelected:on        
        $.material=Standardmaterial ()   
		$.name=$.name+"_fengx"		
    )
    )
),
fn createCylinder=
(
undo on(
    bpos=[0,0,0]
    sx=10.0
    sy=10.0
    sz=10.0
    if $ !=undefined then
    (    
        sx=($.max.x-$.min.x)
        sy=($.max.y-$.min.y)
        sz=($.max.z-$.min.z)
        sx=(sx+sy)/4
        bx=($.max.x-$.min.x)/2+$.min.x
        bpy=$.max.y+sy  
	   ax=($.max.x+$.min.x)/2
	   ay=($.max.y+$.min.y)/2
        bpos=[ax,ay,$.max.z]
        Cylinder smooth:on heightsegs:1 capsegs:1 sides:16 height:sz radius: sx mapcoords:on pos:bpos isSelected:on
        $.material=Standardmaterial ()    
        )else
        (
            Cylinder smooth:on heightsegs:1 capsegs:1 sides:16 height:30 radius:20 mapcoords:on pos:bpos isSelected:on
            $.material=Standardmaterial ()
        )    
    )
),
fn createSphere=
(
undo on(
    bpos=[0,0,0]
    sx=10.0
    sy=10.0
    sz=10.0
    if $ !=undefined then
    (    
        sx=($.max.x-$.min.x)
        sy=($.max.y-$.min.y)
        sz=($.max.z-$.min.z)
        sr=(sx+sy+sz)/6
        bx=($.max.x-$.min.x)/2+$.min.x
        bpy=$.max.y+sy   
	   ax=($.max.x+$.min.x)/2
	   ay=($.max.y+$.min.y)/2
        bpos=[ax,ay,$.max.z]
        Sphere radius:sr smooth:on segs:20 chop:0 slice:off sliceFrom:0 sliceTo:0 mapcoords:on recenter:off pos:bpos isSelected:on
        $.material=Standardmaterial ()    
        )else
        (
            Sphere radius:28 smooth:on segs:20 chop:0 slice:off sliceFrom:0 sliceTo:0 mapcoords:on recenter:off pos:bpos isSelected:on
            $.material=Standardmaterial ()
        )    
    )
),
fn createPlane=
(
    undo on(
    bpos=[0,0,0]
    sx=10.0
    sy=10.0
    if $ !=undefined then
    (   
        sx=($.max.x-$.min.x)
        sy=($.max.y-$.min.y)
        bx=($.max.x-$.min.x)+$.min.x
        bpy=$.max.y+sy/2   
	   ax=($.max.x+$.min.x)/2
	   ay=($.max.y+$.min.y)/2
        bpos=[ax,ay,$.max.z]
        a=Plane length:sy width:sx pos:bpos isSelected:on
        a.material=Standardmaterial ()
        )else
        (
        a=Plane length:10 width:10 pos:bpos lengthsegs:1  widthsegs:1 isSelected:on
        a.material=Standardmaterial ()
    )
)
),
--标准人物创建
fn stdMen=(
    undo on(
    bpos=[0,0,0]
    if $ !=undefined do 
    ( 
		bmx=($.max.x+$.min.x)/2
		bmy=($.max.y+$.min.y)/2
		bpos=[bmx,bmy,$.max.z]
    )
    a=Box lengthsegs:1 widthsegs:1 heightsegs:1 length:8 width:8 height:20 isSelected:on   pos:bpos
    a.material=Standardmaterial ()
    )
),    
fn createBoxGizmo=
(    
    lColor = fengx.randomColor()
    lColor = color 112 112 112 112
	if $!= undefined do 
    (
    a=[$.min.x,$.min.y,$.min.z]
    a1=[$.min.x,$.min.y,$.max.z]
    
    b=[$.min.x,$.max.y,$.min.z]
    b1=[$.min.x,$.max.y,$.max.z]
    
    c=[$.max.x,$.max.y,$.min.z]
    c1=[$.max.x,$.max.y,$.max.z]
    
    d=[$.max.x,$.min.y,$.min.z]
    d1=[$.max.x,$.min.y,$.max.z]
    
    l1=fengx.drawLine  a a1 lColor
    l2=fengx.drawLine  b b1    lColor
    l3=fengx.drawLine  c c1    lColor
    l4=fengx.drawLine  d d1    lColor
    l5=fengx.drawLine  a d    lColor
    l6=fengx.drawLine  b c  lColor
    l7=fengx.drawLine  a1 d1 lColor
    l8=fengx.drawLine  b1 c1 lColor
    l9=fengx.drawLine  a b      lColor
    l10=fengx.drawLine  a1 b1 lColor
    l11=fengx.drawLine  d c   lColor
    l12=fengx.drawLine  d1 c1 lColor

    ls=#(l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12)
    r=(random 0 1000)*(random 0 10000)/1000
    str="Group_"+(r as string)
    group ls name:"fengxGroup"
    scale  $fengxGroup  [1.1,1.1,1.1]
    boxG=$fengxGroup
    for ss in boxG do 
    (
        if isGroupMember(ss) then 
        (
            )else
            (
                ss.name=str
                )
        )
    s=$
    all=#()
    for obj1 in $ do
    (
        append all obj1
    )
    append all boxG
    group all name:"fengx" 
    select $fengx
    boxAll=$fengx
    str="Fengx_Group_"+(r as string)
    
    for ss in boxAll do 
    (
        if isGroupMember(ss) then 
        (
            )else
            (
              ss.name=str
			gw.setTransform(Matrix3 1)
			tpos=ss.pos+[0,0,(ss.max.z+5)]
			gw.text (tpos+[0,0,6]) (ss.name ) color:red
			gw.enlargeUpdateRect #whole
			gw.updateScreen()
              )
        )
    )
),

fn drawLine pointA pointB lineColor =
(
    ss = SplineShape pos:pointA
    addNewSpline ss
    addKnot ss 1 #corner #line PointA
    addKnot ss 1 #corner #line PointB
    updateShape ss
    ss.wirecolor=lineColor
    return ss

),

fn dirToPath dir1=
(	pathStr=dir1
	tempStr=getFilenameFile dir1
	print tempStr
	print tempStr.count
	print dir1.count
	for i = 0 to (tempStr.count+3) do
	(	
		--print pathStr.count-i
		a=" "
		pathStr[dir1.count-i]=a
		)
	return pathStr
	
)
	,
-------------------------create model-------------------------  
fn maxminf n=
(
    maxf=n[1]
    minf=n[1]
    mm=#()
    for s in n do 
    (    
        if maxf<s do 
        (    
            maxf=s
            )
        if minf>s do 
        (
            minf=s
            )            
    )
    append mm maxf
    append mm minf
    return mm
),      
function getFromUvlayout =
(
	
	tempPath=getFilenamePath uvSendPath  + getFilenameFile uvSendPath   +".out"
	tempCopyPath=getFilenamePath uvSendPath    +  getFilenameFile uvSendPath   +"01.obj"
	deleteFile tempCopyPath
	copyfile tempPath  tempCopyPath
	importFile tempCopyPath  #noPrompt 
	
),

fn sendToUVlayout =
(
	if uvlayoutPath!=undeifend and doesFileExist uvlayoutPath ==true and getFilenameFile uvlayoutPath == "claunch-uvlayout"  then
	(
		makedir (getFilenamePath uvSendPath )
		
		try exportFile uvSendPath   #noPrompt  selectedOnly:true catch print "fath to export file "
		tempCopyPath=getFilenamePath uvSendPath    +  getFilenameFile uvSendPath   +"01.obj"
		deleteFile tempCopyPath
		--uvLayoutMeshMode ="Poly"
		--uvLayoutUVMode = "Edit"
		shelllaunch  uvlayoutPath (" -plugin,Poly,Edit,  "  + uvSendPath  )
	)else (
		if (queryBox "设置uvlayout 的路径 选择claunch-uvlayout.exe   一般在 文件夹headus UVLayout v2 Professional 里面")==true then 
		(
			tempPath=getOpenFileName    caption:"claunch-uvlayout.exe " filename: "C:\Program Files (x86)\headus UVLayout v2 Professional\claunch-uvlayout.exe"


			if uvlayoutPath  !=undefined do 
			(
				uvlayoutPath = tempPath as string
				setIniSetting  profilePath "uvlayout" "path"  uvlayoutPath 
			)
			poly.ckb133.state=false
			poly.ckb133.text="send to uvlayout"
			)else
			(
				 poly.ckb133.text="send to Uvlayout"
				 poly.ckb133.state=false
			)	
	)

),
--显示物体名字
fn showname=
(    
    if $==undefined then
    (
        )else
        (
        c=0
        for i in $ do
        (
            a=i.pos
            bb=text size:10 kerning:0 leading:0 pos:a     text:i.name -- name: d --isSelected:on
            bb.pos.z=i.min.z-10
            rotate bb (angleaxis 90 [1,0,0])
            bb.wirecolor=[1,0,0,1]
            append t bb
            convertToPoly(bb) 
            c=c+1
            )
        )
),
    
--显示物体名字
fn showObjectNames=
(
    gw.setTransform(Matrix3 1)
    for o in objects where not o.isHidden do
    (
        tpos=o.pos+[0,0,(o.max.z+5)]
        gw.text (tpos+[0,0,6]) (o.name ) color:red

        --aaa=gw.text (tpos+[0,0,1]) (o.pos as string) color:blue
        )
    gw.enlargeUpdateRect #whole
    gw.updateScreen()
),


--<material>--<startardMaterial only>
fn saveMateMapTo mates targetPath=
(	
	-->>>   forbid anything was not standarMaterial 
	local standerdMates=#()
	for m in mates do if classOf m == standardMaterial do append standerdMates m
	mates=standerdMates
	
	-->>>   
	--savePath=getSavePath   caption:"save to"
	if targetPath !=undefined then (
		if mates!=undefined then (
			local mapsPath =#()
			mapsPath=fengx.getMatesTrueMapsPath mates
			)else print "material if null....>>> save fath...."
		
		)else print "path is not choese....>>> save fath...."
	
		
		for map in  (fengx.getMatesTrueMapsPath mates) do
		 (
			local tName = getFilenameFile map 
			local tType = getFilenameType map
			 
			local tempMapPath = targetPath + "/" + tName + tType
			tempMapPath=fengx.beStringPath tempMapPath
			local copySOn=true
			try copyfile map tempMapPath catch (
				 print ("....."+map +" was not be saved.....")
				 copySOn=false
				 )
			if copySOn==true do print ("  ------  "+map +"     > map was copyed success.....")
			)
			
	
	),
	
	

fn updataLanguage=
(
	if languageId=="English" do
		( 
		poly.btn481.text= "盒子" 
		poly.btn501.text= "圆柱"
		poly.btn511.text= "球" 
		poly.btn521.text= "平面" 
		poly.btn531.text= "比例人" 
		poly.btn591.text= "大组" 
		poly.btn7.text= "扩大 +" 
		poly.btn13.text= "缩小 -" 
		poly.btn151.text= "重置多边形"
	
		poly.btn102.text= "枢轴归底"
		poly.btn103.text= "枢轴归中"
		poly.btn104.text="坐标归零"
	
		poly.btn114.text= "枢轴归零"
		poly.btn159.text= "编辑UV"
	
		poly.btn97.text= "排序" 

		poly.btn51.text= "模型信息"			
	
		
		--mate window
		mate.btn1.text ="清除"		
		mate.btn7.text="贴图另存为"		
		mate.btn8.text="关闭" 				
		mate.btn9.text="打开" 				
		mate.btn10.text ="自动命名"	
		mate.btn11.text ="@" 				
		mate.btn12.text ="整理" 		
		mate.btn15.text ="@" 						
		mate.btn463.text= "所选材质" 	
		mate.btn106.text= "@"				
		mate.btn107.text= "所选物体"	
		mate.btn119.text= "物体"			
		mate.btn120.text= "材质" 	
		
		--file window
		file.btn1.text= ".visual" 		
		file.btn2.text= ".obj" 			
		file.btn3.text= ".max" 			
		file.btn17.text= "@"				
		file.btn19.text= "@"				
		file.btn20.text= "@"				
		file.btn330.text= "@"			
		file.btn345.text= "重启Max" 		
		file.btn346.text= "退出Max" 		
		file.btn10.text= "@" 				
		file.btn11.text= "本文件" 		
		file.btn12.text= "本脚本" 	
	
		--snap
		snap.chooseit.text= "拾取" 			
		snap.p.text= "位置" 			
		snap.px.text= "x" 				
		snap.py.text= "y" 				
		snap.pz.text= "z" 				
		snap.r .text="旋转" 			
		snap.rx.text= "x" 				
		snap.ry.text= "y" 				
		snap.rz.text= "z" 				
		snap.s .text="缩放" 			
		snap.sx.text= "x" 				
		snap.sy.text= "y" 				
		snap.sz.text= "z" 				
		snap.pt.text= "枢轴" 			
		snap.ptx.text= "x" 			
		snap.pty.text= "y" 			
		snap.ptz.text= "z" 			
		snap.localPos.text= "@" 		
		snap.localPivot.text= "@" 		
	
		snap.btn14.text= "枢轴归底" 	
		snap.btn17.text= "枢轴归中" 
		snap.btn18.text= "位置归零" 	
		snap.bpxa.text= "+" 			
		snap.bpxr.text= "-" 			
		snap.btn152.text= "+" 			
		snap.btn153.text= "-" 			
		snap.btn154.text= "+" 			
		snap.btn155.text= "-" 			
		snap.btn156.text= "X" 			
		snap.btn157.text= "Y" 			
		snap.btn158.text= "Z" 			
		snap.btn224.text= "枢轴归零" 

	)
	if languageId=="中文" do
	(
		-- poly rollout	
		poly.btn481.text= "Box" 
		poly.btn501.text= "Cylinder"
		poly.btn511.text= "Sphere" 
		poly.btn521.text= "Plane" 
		poly.btn531.text= "Standard" 
		poly.btn591.text= "Big Group" 
		poly.btn7.text= "Big +" 
		poly.btn13.text= "Small -" 
		poly.btn151.text= "Reset Poly"
	
		poly.btn102.text= "Pivot"
		poly.btn103.text= "Pivot"
		poly.btn104.text="Pos"
	
		poly.btn114.text= "Pivot"
		poly.btn159.text= "Edit UV"

		poly.btn97.text= "Sort" 
	
		poly.btn51.text= "Show Infor"
		
		--mate window
		mate.btn1.text= "Clear Away"		
		mate.btn7.text="Save Map To"		
		mate.btn8.text="Off" 				
		mate.btn9.text="On" 				
		mate.btn10.text= "Auto Naming"	
		mate.btn11.text = "@" 				
		mate.btn12.text ="Clear Up" 		
		mate.btn15.text= "@" 					
		mate.btn463.text= "Select Mate" 	
		mate.btn106.text= "@"				
		mate.btn107.text= "Select Object"	
		mate.btn119.text= "Objet"			
		mate.btn120.text= "Mate" 			
		
		--file window
		file.btn1.text= ".visual" 		
		file.btn2.text= ".obj" 			
		file.btn3.text= ".max" 			
		
		file.btn17.text= "@"				
		file.btn19.text= "@"				
		file.btn20.text= "@"				
		file.btn330.text= "@"			
		file.btn345.text= "Restart" 		
		file.btn346.text= "Eixt" 		
		file.btn10.text= "@" 				
		file.btn11.text= "Max File" 		
		file.btn12.text= "Script" 		
		
		
		--snap
		snap.chooseit.text= "Pick" 			
		snap.p.text= "Pos" 			
		snap.px.text= "x" 				
		snap.py.text= "y" 				
		snap.pz.text= "z" 				
		snap.r .text="Rotate" 			
		snap.rx.text= "x" 				
		snap.ry.text= "y" 				
		snap.rz.text= "z" 				
		snap.s .text="Scale" 			
		snap.sx.text= "x" 				
		snap.sy.text= "y" 				
		snap.sz.text= "z" 				
		snap.pt.text= "Pivot" 			
		snap.ptx.text= "x" 			
		snap.pty.text= "y" 			
		snap.ptz.text= "z" 			
		snap.localPos.text= "@" 		
		snap.localPivot.text= "@" 		
		
		snap.btn14.text= "Bot" 	
		snap.btn17.text= "Center" 
		snap.btn18.text= "Pos" 	
		snap.bpxa.text= "+" 			
		snap.bpxr.text= "-" 			
		snap.btn152.text= "+" 			
		snap.btn153.text= "-" 			
		snap.btn154.text= "+" 			
		snap.btn155.text= "-" 			
		snap.btn156.text= "X" 			
		snap.btn157.text= "Y" 			
		snap.btn158.text= "Z" 			
		snap.btn224.text= "Pivot" 
	)
),
fn getViewDir =
(
-- The affine TM transforms from world coords to view coords -- so we need the inverse of this matrix
local coordSysTM = Inverse(getViewTM())
-- The Z axis of this matrix is the view direction.
local viewDir = -coordSysTM.row3
-- get the view position from this matrix
local viewPt = coordSysTM.row4
--print viewPt 
--print viewDir
return viewDir --ray viewPt viewDir
),
fn geTrotateDir n=
(
	rotatedir=[0,0,0]
	x=abs(n.x)
	y=abs(n.y)
	z=abs(n.z)
	count=0
	allV=#(x,y,z)
	maxV=0
	
	for i=1 to 3 do
	(
	if  allV[i] > maxV do
	(
		maxV=allV[i] 
		count=i
		)
	)
	
	if n[count]<0 then rotateDir[count]=-1 else rotateDir[count]=1
	return rotateDir
),
fn smartRotate n=
(
	if $!=undefined do
	(
	direction=fengx.geTrotateDir (fengx.getViewDir())
	rotate $ (angleaxis n direction)
	)
),

fn importMap=
(
FilesPath=getSavePath   caption:"get to"  
if FilesPath !=undefined do 
(
files = getFiles (FilesPath + "\*.tga")
ppos=[0,0,0]
lineN=sqrt(files.count) 
i=0
x=floor lineN
y=ceil lineN
for f in files do 
 (
	i+=1
	ppos.x = (i-(floor(i/x))*x)*100
	ppos.y = (ceil(i/x))*100
	p=Plane length:100 width:100 pos:ppos isSelected:on
	P.lengthsegs = 1
	P.widthsegs = 1
	name=getFilenameFile f
	p.material=Standardmaterial ()
	p.material.name=name
	p.material.diffuseMap = Bitmaptexture fileName:f
	actionMan.executeAction 0 "40807"
	)
)
),
fn importMaxs =
(
maxsPath=getSavePath   caption:"get to"  
if maxsPath!=undefined do 
(
	tempPath=getDirectories ( maxsPath + "/*")
	all=#()
	for a in tempPath do append all (getfiles (a+"/max/*.max"))
	for p in all do  mergemaxfile (fengx.beWindowsPath p) #select 
)
),



--------------------------------------------------------------------------------------------------------------------------------------
-------------------- function --------------------------------------------------------------------------------------------------------


function getTrueMapPath nodes=
(
	
mapsPath=#()
missMap=usedMaps()
missMapName=#()


for p in missMap do append missMapName (getFileNameFile p)

for m in nodes do 
(
	local materials=#()
	mOn=true
	try m.material catch mOn=false
	if mOn==true do
	( 
		if classOf m.material ==StandardMaterial then append materials m.material else
		(
			if classOf m.material ==MultiMaterial do materials=m.material
		 )
		mapsPath+=fengx.getMatesTrueMapsPath materials
		)
)	
return mapsPath
),


function getMatesTrueMapsPath mates =
(
	local mapsPath=#()
	local missMapName=#()

	missMap=usedMaps()
	for p in missMap do append missMapName (getFileNameFile p)
	
	-->>>   forbid anything was not standarMaterial 
	local standerdMates=#()
	for m in mates do if classOf m == standardMaterial do append standerdMates m
	mates=standerdMates
	
	for s in mates do
	( 
		dOn=true
		try s.diffuseMap.fileName catch dOn=false
		if dOn==true do
		(
			if (doesFileExist s.diffuseMap.fileName) ==true then
				(
				mapsPath+=(fengx.dToDNS s.diffuseMap.fileName)
				)else(
				mapName= getFilenameFile s.diffuseMap.fileName
				mapType= getFilenameType  s.diffuseMap.fileName
				index = finditem missMapName mapName
				if index ==0 then
					(
					 print ( "<map>=======  "+mapName + mapType+"  ====== was not found....")  
					 print ("      =======  in a wrong path >  " + s.diffuseMap.fileName)
					 )else  (
					mapsPath+=(fengx.dToDNS  missMap[index])
					)
				)
			)
	)
	
	return mapsPath
	),
	
	
	
function dToDNS DPath=
(
	mapPath=getFilenamePath     DPath
	mapName = getFilenameFile   DPath
	mapType =getFilenameType    DPath	
	
	
	mapsPathArry=#()
	append	mapsPathArry DPath
	
	namePart= filterString mapName "_"

	if namePart[(namePart.count-1)]=="a" do deleteItem namePart  (namePart.count-1) --alpha

	temp=""
	local NName=""
	local SName=""
	--Normal map
	namePart[(namePart.count-1)][namePart[(namePart.count-1)].count]="n"
	for a in namePart do 
	(
		temp =a+"_"
		NName+=temp
		)
	--substring NName 1 (NName.count-1)
	--xxx
	strN=""
	for i=1 to (NName.count-1) do  strN+=NName[i]
	NName=strN
		
	--Specluar map
	namePart[(namePart.count-1)][namePart[(namePart.count-1)].count]="s"
	for a in namePart do
	(
		temp =a+"_"
		SName+=temp
	)
	--xxx
	strS=""
	for i=1 to (SName.count-1) do  strS+=SName[i]
	SName =strS
	--substring SName 1 (NName.count-1)
	
     append	mapsPathArry (mapPath+NName+mapType)
	append	mapsPathArry (mapPath+SName+mapType)
	return mapsPathArry
	),
	

	
function fixMissMap=
(
mapsPath=#()
missMap=usedMaps()
missMapName=#()

for s in pathArry do append missMapName (getFileNameFile s)

for s in $.material do  (
	mapName= getFilenameFile s.diffuseMap.fileName
	
	local index = finditem missMapName mapName
	if index ==0 then () else  s.diffuseMap = Bitmaptexture fileName: missMap[index]
	)

),
fn llllllllllllllllllllllllllllllllllllllllllllllllfileFn=(),
-------------------------create model-------------------------

function geMapPathFromeVisal targetPath=
(

	local mapsPath=#()
	local fileStr=""
	
if targetPath !=undefined do 
(
	targetPath = fengx.ToVisualPath targetPath 
	if (doesFileExist targetPath )==true then 
	(print "Visal file is Exist" 
	VisualFile=openFile targetPath  --"r"
	
	while not eof VisualFile do
	(
	lineStr = readLine VisualFile 
	lineParts = filterString lineStr "<> "
	if lineParts!=undefined and lineParts.count==4 do
	(
		if lineParts[2]=="Texture" and lineParts[4]=="/Texture"do
		(				 
			 append mapsPath ("E:/mf_pangu/tw2/res/"+lineParts[3])
		)
	)
	)
	)else
	(
 		messageBox "地址错误  找不到 Visual 文件!"
	)
	

)
	return mapsPath
),

function copyMapsTo mapsPath targetPath=
(
	for map in  mapsPath  do
	(
	local tempStr=""
	for i=1 to map .count do if map[i]!=" "and map[i]!="\t" do tempStr+= map[i]
	map=tempStr
	tName =getFilenameFile map
	tType= getFilenameType map
	tempMapPath=fengx.beStringPath  (targetPath+"/" + tName +tType)
	local copySOn=true
	if doesFileExist map ==true then(
		try copyfile map tempMapPath catch (
			 print ("....."+map +" was not be saved.....")
			 copySOn=false
			 )
		 )else(
			print ("  ------  "+map +"     > map does not exist .....")
			copySOn=false
			)
	if copySOn==true do print ("  ------  "+map +"     > map was copyed success.....")
	)


),
function ToVisualPath targetPath=
(
	--local son=true
	local rPath=""
	name = (getFilenameFile	targetPath) + ".visual"
	tempPathPart = getFilenamePath targetPath
	
	if tempPathPart[1]=="/" or tempPathPart[1]== "\\" do tempPathPart =substring tempPathPart 2 tempPathPart.count 
	if tempPathPart[1]=="e" or tempPathPart[1]=="E" then () else tempPathPart="E:/mf_pangu/tw2/res/"+ tempPathPart
	rPath=tempPathPart+name
	rPath=fengx.beStringPath rPath
	--if (doesFileExist rPath)==true then print "Visal file is Exist" else print "Visal file does not Exist" 
	return rPath
)
	




)
