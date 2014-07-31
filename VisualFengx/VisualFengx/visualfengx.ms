------------------------------------------------
------------------------------------------------
--visualFengx-----------------------------------
--by fengx--------------------------------------
------------------------------------------------
------------------------------------------------
global  VisualFengxVersions =1.53
global  V=("VisualFengxVersions   "+VisualFengxVersions as string)
global  newVersions=0
global  updateMsg=""

global smartRotateLW="W"
------------------------------------------------
------------------ for snap to surface ---------
global PGround=undefined --snaped ground  <GeometryClass>
------------------------------------------------

------------------------------------------------
------------------- only for fun ---------------
--global theVoice = CreateOLEObject "SAPI.SpVoice"
------------------------------------------------

------------------------------------------------
------------------ register export path --------
--<String>
--global visualPath=""

global objPath=""
global maxPath=""
global saveMapPath=""
------------------------------------------------
------------------------------------------------
-------------------- profiling -----------------


global profilePath= getDir #scripts + "\visualfengx\fengx.fengx" --sysInfo.tempdir --settings flie path <string>
global copyPastePath= getDir #scripts--sysInfo.tempdir  --copyPaste tempPath <string>

global mfDIR=(getinisetting  profilePath "system" "mfDIR"  ) --"E:\\mf_pangu\\"
if classOf mfDIR==OkClass or mfDIR ==""do
(
	mfDIR="E:\\mf_pangu\\"
	setinisetting  profilePath "system" "mfDIR"  mfDIR
	
)
global abPath=""
global modelPath=" "
global visualPath=(getinisetting  profilePath "visualPath" "path") 
if classOf visualPath==OkClass do
(
	visualPath=mfDIR+"tw2\\res\\scene\\common\\"
	setinisetting  profilePath "visualPath" "path"  visualPath
	
)

global languageId=execute (getinisetting  profilePath "Set" "language") -- Types of language <string>
-->initialize<
languageId=(getinisetting  profilePath "Set" "language")as string
if classOf languageId==OkClass do
(
	languageId="English"
	setinisetting  profilePath "Set" "language" "English"
	
)
	
global  alertUpdate= execute (getinisetting  profilePath "upDate" "alertupDate") 
if (classOf alertUpdate)==OkClass do 
(
	alertUpdate=true
	setIniSetting  profilePath "upDate" "alertupDate" "true"
)

--export to Visual reset material 
global visualMateReset= execute (getinisetting  profilePath "file" "visualMateReset") 
if (classOf visualMateReset)==OkClass do 
(
	visualMateReset=false
	setinisetting  profilePath "file" "visualMateReset" "false"
)
global visualPosReset= execute (getinisetting  profilePath "file" "visualPosReset") 
if (classOf visualPosReset)==OkClass do 
(
	visualPosReset=true
	setinisetting  profilePath "file" "visualPosReset" "true"
)

global backMapType= execute (getinisetting  profilePath "mate" "backMapType") --position <point5>
-->initialize<
if (classOf backMapType)==OkClass do 
(
	backMapType=#(1,0,0,0,1)
	setIniSetting  profilePath "mate" "backMapType"  (backMapType as string)
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
	mainSize=[138,686]
	setIniSetting  profilePath "rolloutSetting" "mainSize"  "[138,686]"
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
(
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
	windowNegativeState=3 
	setIniSetting  profilePath "rolloutSetting" "windowNegativeState"  "3"
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
global uvSendPath= sysInfo.tempdir + "\visualfengx\uvlayoutTemp\UVsendTemp.obj"  --getDir #scripts+"\visualFengx\UVsendTemp.obj" -- 
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





theDefultBmp = (BitMap 160 112 color:(color 64 67 65 60)) 
MainBGPath=getDir #scripts +"/visualfengx/MainBG.bmp"
MainIcon32Path=getDir #scripts +"/visualfengx/VisualFengx_32i.bmp"
MainIcon32Patha=getDir #scripts +"/visualfengx/VisualFengx_32a.bmp"

MainIcon24Path=getDir #scripts +"/visualfengx/VisualFengx_24i.bmp"
MainIcon24Patha=getDir #scripts +"/visualfengx/VisualFengx_24a.bmp"

MainIcon16Path=getDir #scripts +"/visualfengx/VisualFengx_16i.bmp"
MainIcon16Patha=getDir #scripts +"/visualfengx/VisualFengx_16a.bmp"
	
if doesFileExist MainIcon32Path then MainIcon32b=openBitMap  MainIcon32Path else MainIconb=theDefultBmp
if doesFileExist MainIcon32Patha then MainIcon32ab=openBitMap  MainIcon32Patha else MainIconab=theDefultBmp
if doesFileExist MainIcon24Path then MainIcon24b=openBitMap  MainIcon24Path else MainIconb=theDefultBmp
if doesFileExist MainIcon24Patha then MainIcon24ab=openBitMap  MainIcon24Patha else MainIconab=theDefultBmp	
if doesFileExist MainIcon16Path then MainIcon16b=openBitMap  MainIcon16Path else MainIconb=theDefultBmp
if doesFileExist MainIcon16Patha then MainIcon16ab=openBitMap  MainIcon16Patha else MainIconab=theDefultBmp
	
if doesFileExist MainBGPath then MainBG=openBitMap  MainBGPath else restartBmp =theDefultBmp

function iconBitmapToArray b=
(
	a=#()
	if classof(b)==BitMap do 
	(
		for i=1 to b.width/b.height do
		(
			tbmp=(BitMap  b.height  b.height  color:(color 64 67 65 60)) 
			for x=1 to 32 do
			(
				
				colorA=getPixels b [(i-1)*b.height,(x-1)]  b.height
				setPixels    tbmp [0,(x-1)]  colorA
				)
			append a tbmp
			)
		)
	return a
)

mainIcon32A=iconBitmapToArray mainIcon32b
mainIcon24A=iconBitmapToArray mainIcon24b
mainIcon16A=iconBitmapToArray mainIcon16b

mainIcon32Aa=iconBitmapToArray mainIcon32ab
mainIcon24Aa=iconBitmapToArray mainIcon24ab
mainIcon16Aa=iconBitmapToArray mainIcon16ab




copyPasteBGPath= (getDir #Scripts+ "\\visualFengx\\copyPasteBG.png")
if doesFileExist copyPasteBGPath do copyPasteBGBmp  = Bitmaptexture fileName:copyPasteBGPath 
backUpBGPath= (getDir #Scripts+ "\\visualFengx\\backUpBG.png")   
if doesFileExist backUpBGPath do backUpBGBmp  = Bitmaptexture fileName:backUpBGPath
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
global app="notepad++.exe"
-------------------- rollout ---------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
mainWindowName="visualFengx_"+ (VisualFengxVersions as string)


rollout mainwindow "visualFengx_1.53" width:1178 height:796
(
    local bm = bitmap 500 50 color: mc_01 pos:[0,0]
	subRollout sub "fengx" pos:[0,35] width:139 height:586 
 
 
 
 
 
 


	checkbutton ckP "Poly" pos:[1,0] width:36 height:36 toolTip:"poly面板： poly 相关处理...."
	checkbutton ckM "材质" pos:[37,0] width:36 height:36 toolTip:"材质面板： 材质处理相关....."
	checkbutton ckF "文件" pos:[73,0] width:36 height:36 toolTip:"文件面板:  文件导出 相关等等。。。。。"
	checkbutton ckS "吸附" pos:[109,18] width:28 height:18 toolTip:"吸附"
	checkbutton ckX "↓↑" pos:[109,0] width:28 height:18 toolTip:"面板打散 收拢"
	button btn337 "设置" pos:[96,660] width:42 height:32 toolTip:"设置"

	checkbutton ckb230 "复制管理" pos:[92,620] width:46 height:40 toolTip:"打开复制管理器"
	button btn142 "userMacros" pos:[316,158] width:104 height:24
	button btn143 "@" pos:[420,158] width:24 height:24
	button btn29 "send to GitHub" pos:[364,230] width:80 height:24
	button btn32 "卸载！" pos:[143,626] width:171 height:66
	button btn697 "send to GitHub" pos:[356,182] width:88 height:24
	button btn699 "home" pos:[316,182] width:40 height:48
	button btn700 "company" pos:[316,230] width:48 height:48
	button btn53 "检查更新！" pos:[143,538] width:171 height:48
	button btn26 "强制更新！" pos:[143,586] width:171 height:40
	button btn196 "visualfengx.ms" pos:[316,62] width:80 height:24
	button btn197 "macroScript" pos:[316,86] width:80 height:24
	button btn198 "@" pos:[420,62] width:24 height:24
	button btn199 "@" pos:[420,86] width:24 height:24
	button btn200 "fengx.fengx" pos:[316,134] width:80 height:24
	button btn201 "@" pos:[420,134] width:24 height:24
	button btn202 "fengx_start.ms" pos:[316,110] width:80 height:24
	button btn203 "@" pos:[420,110] width:24 height:24
	button btn204 "○" pos:[396,62] width:24 height:24
	button btn205 "○" pos:[396,86] width:24 height:24
	button btn206 "○" pos:[396,110] width:24 height:24
	button btn207 "notepad++" pos:[316,38] width:64 height:24
	button btn208 "sublime_text" pos:[380,38] width:64 height:24
	button btn209 "○" pos:[396,134] width:24 height:24
	button btn65 "已经是最新版" pos:[32,660] width:32 height:32 enabled:false toolTip:"有新的更新时 按钮可用"
	button btn66 "重开max" pos:[0,660] width:32 height:32 enabled:true toolTip:"重开max"
	button btn67 "Eixt" pos:[64,660] width:32 height:32 enabled:true toolTip:"退出max"
	button btn40 "复制" pos:[0,620] width:46 height:40 enabled:true toolTip:"复制选择的模型"
	button btn41 "黏贴" pos:[46,620] width:46 height:40 enabled:true toolTip:"黏贴选择的模型"
	button btn43 "send to SVN" pos:[364,254] width:80 height:24
	button btn44 "send to SVN" pos:[356,206] width:88 height:24
	button btn82 "增加Python27环境变量" pos:[142,36] width:173 height:52 toolTip:"增加Python27系统环境变量 默认值为 c:\Python27"
	button btn173 "增加Vusial导出插件MAX环境变量" pos:[142,88] width:173 height:52 toolTip:"增加VisualExport 补丁max 系统变量 默认值为 E:\mf_pangu\bigworld	ools\exporter_max9\ "
	
	button btn47 "修复max文件缩略图" pos:[143,152] width:173 height:68 toolTip:"max文件在文件夹中将会显示缩略图!"
	button btn48 "注册.Visual等文件" pos:[143,220] width:173 height:79 toolTip:".Visual .model .primitives 格式将可以直接点击打开!"
	button btn331 "重启资源浏览器(explorer)" pos:[143,299] width:173 height:88
	button btn49 "Button" pos:[894,623] width:821 height:42
	button btn50 "Button" pos:[894,665] width:474 height:28
	button btn51 "Button" pos:[894,693] width:363 height:20
	
	HyperLink hy_help "帮助" pos:[317,11] width:32 height:24 color:(color 255 255 255 100) hovercolor:(color 0 10 100 10) visitedcolor:(color 255 255 255 100) address:"E:\SVN\VisualFengx_3dmax\index.html"--"http://fengxxx.github.io/blog/"
	--"http://fengxxx.github.io/blog/"

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
			mainWindow.width=138
			mainWindow.height=40
			
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
				macros.run "visualfengx" rolloutWindows[i]
				)else
				(
					if windowActiveState[i]==0 and rollouts[i].open==true do
					(
					ckbs[i].state=false
					macros.run "visualfengx" rolloutWindows[i]
					)
				)
					
			)
			
			) else(
			--ckX.state=false
			mainWindow.width=138
			mainWindow.height=692
			
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

	button btn496 "设置" pos:[142,0] width:173 height:36 enabled:false
	button btn42 "帮助文档" pos:[143,476] width:171 height:62
	button btn256 "设置SVN 地址" pos:[143,412] width:173 height:43
	on mainwindow open do
	(
		if fengx.checkSVNDir()==false do
		(
			mainwindow.btn48.enabled=False
			mainwindow.btn173.enabled=False
			
			)
		
	   
		if windowState==1 then ckX.state=true else  ckX.state=false
		windowsLogicStart
		--windowslogic()
		if  newVersions > VisualFengxVersions  then
		(
			mainWindow.btn65.text="最新版-- " +(newVersions as string)
			mainWindow.btn65.enabled=true
			try btn65.images=#(mainIcon24A[12], mainIcon24Aa[12], 1,1,1,1,1 ) catch (print "btn65.images not exsit")
		)else try btn65.images=#(mainIcon24A[11], mainIcon24Aa[11], 1,1,1,1,1 ) catch (print "btn65.images not exsit")
		--（
			--print "jiade xxx"
			--mainWindow.btn65.text="已经是最新版" 
			--btn65.enabled=false
		--）
	
	
		try btn66.images=#(mainIcon24A[14], mainIcon24Aa[14], 1,1,1,1,1 ) catch (print "btn66.images=#(mainIcon24A[14]")
		try btn40.images=#(mainIcon32A[9], mainIcon32Aa[9], 1,1,1,1,1 ) catch (print "btn40.images=#(mainIcon32A[9]")
		try btn41.images=#(mainIcon32A[10], mainIcon32Aa[10], 1,1,1,1,1 ) catch (print "btn41.images=#(mainIcon32A[10]")
		
		try ckX.images=#(mainIcon16A[13], mainIcon16Aa[13], 1,1,1,1,1 ) catch (print "ckX.images=#(mainIcon16A[13]")
		try btn67.images=#(mainIcon24A[15], mainIcon24Aa[15], 1,1,1,1,1 ) catch (print "btn67.images=#(mainIcon24A[15]")
		try btn337.images=#(mainIcon24A[16], mainIcon24Aa[16], 1,1,1,1,1 ) catch (print "btn337.images=#(mainIcon24A[16]")
		
		try btn203.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn203.images=#(mainIcon16A[5]")
		try btn201.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn201.images=#(mainIcon16A[5]")
		try btn198.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn198.images=#(mainIcon16A[5]")
		try btn199.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print " btn199.images=#(mainIcon16A[5]")
		try btn143.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn143.images=#(mainIcon16A[5]")
		try ckb230.images=#(mainIcon32A[8], mainIcon32Aa[8], 1,1,1,1,1 ) catch (print "ckb230.images=#(mainIcon32A[8]")
		try ckP.images=#(mainIcon32A[2], mainIcon32Aa[2], 1,1,1,1,1 ) catch (print "ckP.images=#(mainIcon32A[2]")
		try ckF.images=#(mainIcon32A[3], mainIcon32Aa[3], 1,1,1,1,1 ) catch (print "ckF.images=#(mainIcon32A[3]")
		try ckM.images=#(mainIcon32A[4], mainIcon32Aa[4], 1,1,1,1,1 ) catch (print "ckM.images=#(mainIcon32A[4]")
		
		try btn49.images=#(MainIcon32b, MainIcon32ab, 1,1,1,1,1 ) catch (print "btn49.images=#(MainIcon32b")
		try btn50.images=#(MainIcon24b, MainIcon24ab, 1,1,1,1,1 ) catch (print "btn50.images=#(MainIcon24b")  
		try btn51.images=#(MainIcon16b, MainIcon16ab, 1,1,1,1,1 ) catch (print "btn51.images=#(MainIcon16b")
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
	on btn337 pressed do
	(
	if ckX.state==false do 
	(
	mainWindow.height=691 
	if mainWindow.width<=136 then mainWindow.width=312 else mainWindow.width=136 
	)
	
	)
	on ckb230 changed state do
	(
	 macros.run "visualfengx" "copyPasteWindow"
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
	on btn53 pressed do
	(
	if fengx.checkUpdate()==true and newVersions > VisualFengxVersions then
	( 
	        createdialog checkUpDateWindow --fengx.update()
		   checkUpDateWindow.lb01.text= updateMsg
		)else messageBox "VsiaulFengx 该版本已经为最新！无需更新!" title:"VisualFengx"
	
	
	)
	on btn26 pressed do
	(
	--tempV=VisualFengxVersions 
	--VisualFengxVersions =1.0
	--if  newVersions > VisualFengxVersions then--fengx.checkUpdate()==true and
	--(
	        createdialog checkUpDateWindow --fengx.update()
		   if updateMsg!="" do checkUpDateWindow.lb01.text= updateMsg
		--)else messageBox "VsiaulFengx 该版本已经为最新！无需更新!" title:"VisualFengx"
	--VisualFengxVersions =tempV
	)
	on btn196 pressed do
	(
		dir1=getdir #Scripts + "\visualfengx\visualfengx.ms"
		--dir2=getdir #startupScripts + "\visualfengx_startup_tool_01.ms"
		--edit dir2
		edit dir1
	)
	on btn197 pressed do
	(
		--dir1=getdir #Scripts + "\visualfengx\visualfengx.ms"
		dir2=getdir #Scripts + "\visualfengx\visualfengx_macroScript.ms"
		edit dir2
		--edit dir1
	)
	on btn198 pressed do
	(
	ShellLaunch "explorer.exe" ("/select," + getdir #Scripts + "\visualfengx\visualfengx.ms")
	)
	on btn199 pressed do
	(
	ShellLaunch "explorer.exe" ("/select," + getdir #Scripts + "\visualfengx\visualfengx_macroScript.ms")
	)
	on btn200 pressed do
	(
		edit profilePath
	)
	on btn201 pressed do
	(
	ShellLaunch "explorer.exe" ("/select," +profilePath)
	)
	on btn202 pressed do
	(
		dir2=getdir #startupScripts + "\\fengx_start.ms"
		edit dir2
	)
	on btn203 pressed do
	(
	 startPath=getdir #startupScripts + "\\fengx_start.ms"
	ShellLaunch "explorer.exe" ("/select," + startPath)
	)
	on btn204 pressed do
	(
	ShellLaunch app  (getdir #Scripts + "\\visualfengx\\visualfengx.ms")
	
	)
	on btn205 pressed do
	(
	ShellLaunch app  ("/select," + getdir #Scripts + "\visualfengx\visualfengx_macroScript.ms")
	)
	on btn206 pressed do
	(
	ShellLaunch app  (getdir #startupScripts + "\\fengx_start.ms")
	
	)
	on btn207 pressed do
	(
	app="notepad++.exe"
	)
	on btn208 pressed do
	(
	app="C:\Users\fengx\Desktop\application\Sublime Text Build 3047 x64\sublime_text.exe"
	)
	on btn209 pressed do
	(
	ShellLaunch app   profilePath
	)
	on btn65 pressed do
	(
	--tempV=VisualFengxVersions 
	--VisualFengxVersions =1.0
	--if  newVersions > VisualFengxVersions then --fengx.checkUpdate()==true and
	--( 
	createdialog checkUpDateWindow --fengx.update()
	checkUpDateWindow.lb01.text= updateMsg
	--	)else messageBox "VsiaulFengx 该版本已经为最新！无需更新!" title:"VisualFengx"
	--VisualFengxVersions =tempV
	)
	on btn66 pressed do
	(
	    if checkForSave() then (
	        shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
	        quitmax #noPrompt
	)
	)
	on btn67 pressed do
	(
	    if checkForSave() then (
	        --shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
	        quitmax #noPrompt
	)
	)
	on btn40 pressed do
	(
	macros.run "visualFengx" "copyObject"
	
	)
	on btn41 pressed do
	(
	macros.run "visualFengx" "PasteObject"
	)
	on btn43 pressed do
	(
		if (queryBox "确定要同步到 SVN!")==true do
		(
			worlkGitHubPath="E:\\SVN\\VisualFengx_3dmax\\VisualFengx\\"
			fengx.sendToGitHub  worlkGitHubPath
			)
	)
	on btn44 pressed do
	(
		if (queryBox "确定要同步到 SVN!")==true do
		(
			worlkGitHubPath="K:\\SVN\\VisualFengx_3dmax\\VisualFengx\\VisualFengx\\"
			fengx.sendToGitHub  worlkGitHubPath
			)
		)
	on btn82 pressed do
	(
		shelllaunch (getDir #Scripts +"\\visualFengx\\增加python27 系统变量.bat") ""
		)
	on btn173 pressed do
	(
		iniFile = (pathConfig.removePathLeaf (getDir #temp)) + "\\plugin.ini"
		setIniSetting iniFile "Directories" "visualExportPlug" (mfDIR+"bigworld\\tools\\exporter_max9\\")
		if (queryBox "重开MAX生效 是否现在重开MAX")==true do 
			(
				if checkForSave() then (
				shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
				quitmax #noPrompt
			)
			)
		)
	on btn47 pressed do
	(
		
		
		ShellLaunch (getdir #Scripts +"\\VisualFengx\\getBack max thumbnails for win7.reg") ""
		if (queryBox "弹出的注册窗口上 单击 添加到注册表  然后在点击(是)重启资源浏览器(explorer)后生效")==true do
		(
			ShellLaunch (getdir #Scripts +"\\VisualFengx\\restartExplorer.bat") ""
			)
		
		
		)
	on btn48 pressed do
	(
		copyfile (getdir #Scripts +"\\VisualFengx\\fengxTools.exe") (mfDIR+"bigworld\\tools\\worldeditor\\fengxTools.exe")
		copyfile (profilePath) (mfDIR+"bigworld\\tools\\worldeditor\\fengx.fengx")
	     if doesFileExist(mfDIR+"bigworld\\tools\\worldeditor\\fengxTools.exe") then
		(
			shellLaunch  (getDir #Scripts+ "\\visualFengx\\fengxTools.exe") "-rb"
		
			)else messagebox ("无法复制fengxTools.exe 到 "+mfDIR+("bigworld\\tools\\worldeditor\\"))
		)
	on btn331 pressed do
	(
		--if (queryBox "确定重启资源浏览器(explorer)?")==true do
		if (queryBox "在弹出的文件夹里面 手动点击restartExplorer.bat 就可以了! (不知道怎么获得权限...所以要不能自动重启explorer!) ")==true do
	       (
	           ShellLaunch  "explorer" ( "/select,"+getdir #Scripts +"\\VisualFengx\\restartExplorer.bat")
			--ShellLaunch (getdir #Scripts +"\\VisualFengx\\restartExplorer.bat") ""
			)
		)
	on btn42 pressed do
	(
	ShellLaunch (getdir #Scripts +"\\VisualFengx\\VisualFengx_help.pdf") ""
	
	)
	on btn256 pressed do
	(
	      if fengx.setSVNDir()==false do print "地址不对!"
		)
)

















rollout mate "材质" width:541 height:615
(
	button btn1 "清除材质" pos:[60,16] width:68 height:24 enabled:true toolTip:"清除材质编辑器里面的材质"
	button btn7 "提取物体贴图" pos:[0,240] width:104 height:24 enabled:true toolTip:"提取当前物体的所有贴图（只存选择的物体）"
	button btn8 "关闭所有高显" pos:[0,291] width:128 height:24 enabled:true toolTip:"关闭场景中的所有DX高显"
	button btn9 "打开（所择）高显示" pos:[0,315] width:128 height:29 enabled:true toolTip:"打开所选择DX显示"
	button btn10 "整理 材质名" pos:[0,40] width:128 height:24 enabled:true toolTip:"将材质名改为和diffuse贴图一样（只改选择的物体）"
	button btn11 "@" pos:[232,184] width:24 height:24 enabled:true
	button btn12 "整理材质" pos:[0,16] width:60 height:24 enabled:true toolTip:"整理材质编辑器里面的材质"
	button btn15 "@" pos:[104,240] width:24 height:24 enabled:true toolTip:"打开提取贴图的地址"	
	
	
	
	
	
	button btn463 "Select Mate" pos:[128,184] width:104 height:24 enabled:false
	button btn106 "@" pos:[232,208] width:24 height:24
	
	
	button btn107 "Select Object" pos:[128,208] width:104 height:24 enabled:false
	button btn119 "Objet" pos:[128,40] width:64 height:24 enabled:false
	button btn120 "Mate" pos:[192,40] width:64 height:24 enabled:false
	button btn14 "Import Map" pos:[128,232] width:128 height:24
	button btn56 "Import Mate Map" pos:[128,256] width:128 height:24
	button btn273 "材质" pos:[0,0] width:128 height:16 enabled:false
		
	button bmap "贴图" pos:[128,168] width:128 height:16 enabled:false
	button btn275 "Directx" pos:[0,272] width:128 height:19 enabled:false
	button btn21 "去除 多余子材质" pos:[0,64] width:128 height:24 enabled:true toolTip:"去除没有使用到的子材质 重新排序材质ID （只改选择的物体）<此功能在菜单 utilities//Clean MultiMaterial 有 但是貌似很多情况先不管用 还卡>"
	button btn20 "从SVN找回贴图" pos:[0,88] width:128 height:24 enabled:true toolTip:"从SVN寻找贴图 下面D N S A E 可以控制找回贴图种类"
	button btn210 "整理材质" pos:[0,136] width:128 height:48 enabled:true toolTip:"名字命好 贴图贴好 材质整理好"
	button btn52 "去除 重复子材质" pos:[128,64] width:128 height:24 enabled:true toolTip:"将复合材质里面同样diffuse的材质合并成一个ID 都是多余的ID 不会被删除 （只改选择的物体）"
	checkbutton ckb_D "D" pos:[4,112] width:24 height:24 toolTip:"Diffuse"
	checkbutton ckb_N "N" pos:[28,112] width:24 height:24 toolTip:"Normal map"
	checkbutton ckb_S "S" pos:[52,112] width:24 height:24 toolTip:"Specular map"
	checkbutton ckb_A "A" pos:[76,112] width:24 height:24 toolTip:"透明贴图"
	checkbutton ckb_E "E" pos:[100,112] width:24 height:24 toolTip:"自发光贴图"
	button btn68 "清除diffuse以外的贴图" pos:[0,184] width:128 height:24 enabled:true toolTip:"清除diffuse以外的其余贴图"
	button btn61 "从当前目录找回贴图" pos:[128,144] width:128 height:24 enabled:true toolTip:"从SVN寻找贴图 下面D N S A E 可以控制找回贴图种类"
	button btn25 "显示贴图" pos:[0,208] width:64 height:24 enabled:true toolTip:"在视图中显示选中物件的贴图"
	button btn26 "隐藏贴图" pos:[64,208] width:64 height:24 enabled:true toolTip:"在视图中显示选中物件的贴图"
	on mate open do
	(
		
		if fengx.checkSVNDir()==false do
		(
			mate.btn20.enabled=False
			mate.ckb_D.enabled=False
			mate.ckb_N.enabled=False
			mate.ckb_S.enabled=False
			mate.ckb_A.enabled=False
			mate.ckb_E.enabled=False
			)
		
		function intToBool i=
		(
		   b=False
		   if i==1 do b=true
		   return b
		)
		
		ckb_D.state= intToBool (backMapType[1]	)
		ckb_N.state= intToBool (backMapType[2]	)
		ckb_S.state= intToBool (backMapType[3]	)
		ckb_E.state= intToBool (backMapType[4]	)
		ckb_A.state= intToBool (backMapType[5]	)
		try btn15.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn15.images=#(mainIcon16A[5]")
	)
	on mate close do
	(
	       setIniSetting  profilePath "mate" "backMapType"   (backMapType as string)
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
				for o in $ do 
				(
					if o.material !=undefined do 
					(
						for s in fengx.toStandardMate(o.material)do(
						try s.DirectX_Manager.dxStdMat = on catch print s.name + " is not have DirectX_Manager!"
						)
					
					)
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
	on btn20 pressed do
	(
	if $!=undefined do
	(
	for s in $ do  fengx.findMapResource s
	)
	)
	on btn210 pressed do
	(
	undo on(
	if $ !=undefined do 
	(
	--fengx.deleteSameMate $
	fengx.clearObjectMultiMaterial $
	fengx.TexNameToMateName()
	for s in $ do  fengx.findMapResource s
	)
	)
	)
	on btn52 pressed do
	(
	undo on(
	if $ !=undefined do 
	(
	fengx.deleteSameMate $
	)
	)
	)
	on ckb_D changed state do
	(
	if state==true then  backMapType[1]=1 else backMapType[1]=0
	)
	on ckb_N changed state do
	(
	if state==true then  backMapType[2]=1 else backMapType[2]=0
	)
	on ckb_S changed state do
	(
	if state==true then  backMapType[3]=1 else backMapType[3]=0
	)
	on ckb_A changed state do
	(
	if state==true then  backMapType[4]=1 else backMapType[4]=0
	)
	on ckb_E changed state do
	(
	if state==true then  backMapType[5]=1 else backMapType[5]=0
	)
	on btn68 pressed do
	(
	undo on(
		if $!=undefined do
		(
			log=""
			for o in $ do 
			(
				if classOf(o)==Editable_Poly then
				(
					mates=fengx.toStandardMate o.material
					for m in mates do 
					(
						if m!=undefined do 
						(
							print (classOf(m))
							m.bumpMap=undefined
							--m.diffusemap
							m.opacityMap =undefined
							m.selfillumMap=undefined
							m.specularLevelMap=undefined
			                   m.reflectionMap=undefined
							m.specularMap=undefined
						)
					)
				)else  try log+="\n"+o.name catch()
			)
			if log !="" do messageBox ("请将这些物体\n " + log + "\n\n转换成 Editable_Poly !")	
		)
	)
	)
	on btn61 pressed do
	(
	if $!=undefined do
	(
	  for s in $ do  fengx.findMap (fengx.toStandardMate s.material)
	)
	)
	on btn25 pressed do
	(
		undo on(
			if $ !=undefined do 
			(
				for s in $ do 
				(
					try(
						for m in s.material do showTextureMap m on
						)catch()
	                   )
				)
			)
		)
	on btn26 pressed do
	(
		undo on(
			if $ !=undefined do 
			(
				for s in $ do 
				(
					try(
						for m in s.material do showTextureMap m false
						)catch()
	                   )
				)
			)
		)
)








rollout poly "poly " width:864 height:688
(
	button btn481 "Box" pos:[0,20] width:64 height:24
	

	button btn501 "Cylinder" pos:[0,44] width:64 height:24
	button btn511 "Sphere" pos:[128,44] width:64 height:24
	button btn521 "Plane" pos:[64,44] width:64 height:24
	button btn531 "比例人" pos:[64,20] width:64 height:24
	button btn591 "Big Group" pos:[128,20] width:64 height:24 enabled:true
	button btn7 "Big +" pos:[16,446] width:48 height:24 toolTip:"放大一倍"
	button btn13 "Small -" pos:[16,470] width:48 height:24 toolTip:"缩小一倍"
	button btn151 "重置模型" pos:[64,446] width:64 height:48 
	button btn159 "Edit UV" pos:[0,602] width:128 height:24
	checkbutton BS "#" pos:[0,446] width:16 height:48
	button btn97 "排序" pos:[72,80] width:56 height:48 enabled:false
	checkbutton sx "x" pos:[0,80] width:24 height:24 enabled:true toolTip:"将选择物体以X轴向排列" checked:true
	checkbutton sy "y" pos:[24,80] width:24 height:24 toolTip:"将选择物体以Y轴向排列"
	checkbutton sz "z" pos:[48,80] width:24 height:24 toolTip:"将选择物体以Z轴向排列"
	button btn51 "Show Infor" pos:[192,20] width:64 height:24 enabled:true
	checkbutton c1 "1" pos:[128,80] width:24 height:24 enabled:true checked:true
	checkbutton c2 "2" pos:[152,80] width:16 height:24
	checkbutton c3 "3" pos:[168,80] width:16 height:24
	checkbutton c4 "4" pos:[184,80] width:16 height:24 enabled:true checked:false
	checkbutton c5 "5" pos:[200,80] width:16 height:24
	checkbutton c6 "6" pos:[216,80] width:16 height:24
	

	button btn354 "编辑多边形" pos:[0,426] width:128 height:20 enabled:false
	button btn356 "编辑UV" pos:[0,582] width:128 height:20 enabled:false
	checkbutton ckb133 "发送到 Uvlayout" pos:[0,650] width:96 height:24
	button btn335 "Set Uvlayout Path" pos:[128,632] width:96 height:24
	
	button btn211 "重来" pos:[96,626] width:32 height:48
	button btn89 "创建多边形" pos:[0,0] width:128 height:20 enabled:false
	button btn490 "右旋" pos:[64,554] width:64 height:24
 
 
 
 
	button btn491 "左旋" pos:[0,554] width:64 height:24
	
	button btn492 "智能旋转" pos:[0,498] width:128 height:20 enabled:false
	button btn563 "置底" pos:[72,324] width:56 height:24 toolTip:"枢轴置物体底部"
	button btn564 "归中" pos:[72,300] width:56 height:24 toolTip:"枢轴置物件中间"
	button btn565 "Pos" pos:[0,371] width:24 height:24
	
	button btn566 "+" pos:[48,276] width:24 height:24
	button btn567 "-" pos:[0,276] width:24 height:24
	button btn568 "+" pos:[48,300] width:24 height:24
	button btn569 "-" pos:[0,300] width:24 height:24
	button btn570 "+" pos:[48,324] width:24 height:24
	button btn571 "-" pos:[0,324] width:24 height:24
	button btn572 "X" pos:[24,276] width:24 height:24
	button btn573 "Y" pos:[24,300] width:24 height:24
	button btn574 "Z" pos:[24,324] width:24 height:24
	button btn575 "Pivot" pos:[0,395] width:32 height:24
	button btn576 "Rotate" pos:[36,371] width:40 height:24
	button btn577 "Scale" pos:[32,395] width:44 height:24
	button btn578 "所有" pos:[76,371] width:52 height:48
	button btn579 "重置（所选）属性" pos:[0,352] width:128 height:19 enabled:false
	button btn580 "置顶" pos:[72,276] width:56 height:24 toolTip:"枢轴置顶"
	button btn581 "Pivot" pos:[0,258] width:128 height:18 enabled:false toolTip:""
	button btn582 "" pos:[24,371] width:12 height:24 enabled:false
	checkbutton ckbnew "New" pos:[0,626] width:48 height:24
	checkbutton ckbedit "Edit" pos:[48,626] width:48 height:24 checked:true
	checkbutton ckb_world "world" pos:[36,518] width:34 height:16 enabled:true checked:true
	checkbutton ckb_local "local" pos:[0,518] width:36 height:16 enabled:true checked:false
	spinner spn1 "" pos:[68,518] width:60 height:16 range:[0,360,90]
	button ckb64 "30" pos:[28,534] width:28 height:20 enabled:true checked:false
	button ckb65 "45" pos:[56,534] width:36 height:20 enabled:true checked:false
	button ckb66 "90" pos:[92,534] width:36 height:20 enabled:true checked:false
	button ckb67 "15" pos:[0,534] width:28 height:20 enabled:true checked:false
	button btn45 "左" pos:[0,178] width:24 height:48
	button btn46 "右" pos:[64,178] width:24 height:48
	button btn47 "复制" pos:[88,154] width:40 height:96 toolTip:"复制物体 名字也会一样"
	button btn48 "上" pos:[0,154] width:88 height:24
	button btn49 "下" pos:[0,226] width:88 height:24
	button btn250 "后" pos:[24,178] width:40 height:24
	button btn251 "前" pos:[24,202] width:40 height:24
	button btn149 "移动模型" pos:[0,136] width:128 height:18 enabled:false toolTip:"智能移动"
	button btn53 "标准排列" pos:[0,104] width:72 height:24 toolTip:"将选择物体以矩阵方式排列"
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
	macros.run "visualFengx" "createStandMen"
		--fengx.stdMen()
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
	)(
		if $!=undfined do
		(
			a = copy $
	         for s in a do 
	          (
	            s.pos.z+=($.max.z-$.min.z)
	
	           )
	 
			)
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
	setMode=" -plugin,Poly,Edit,  "
	if ckbnew.state==true then setMode= " -plugin,Poly,New,  " else if ckbedit.state==true do setMode= " -plugin,Poly,Edit,  "
	
	if state==true then 
	   (
	    if $!=undefined then
	    (
	    fengx.sendToUVlayout(setMode) 
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
	
	
	 fengx.smartRotate spn1.value
		)
	on btn491 pressed do
	(
	
	
	 fengx.smartRotate -spn1.value
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
	on ckbnew changed state do
	(
	if state==true then ckbedit.state=false else ckbedit.state=true
	)
	on ckbedit changed state do
	(
	if state==true then ckbnew.state=false else ckbnew.state=true
	)
	on ckb_world changed state do
	(
	if state ==true then
	( ckb_local.state=false 
	  smartRotateLW="W"
	)else (
	ckb_local.state=true
	smartRotateLW="L"
	)
	)
	on ckb_local changed state do
	(
	if state ==true then
	( ckb_world.state=false 
	  smartRotateLW="L"
	)else (
		ckb_world.state=true
		smartRotateLW="W"
		)
	)
	on ckb64 pressed do
	(
	spn1.value=30
	)
	on ckb65 pressed do
	(
	spn1.value=45
	)
	on ckb66 pressed do
	(
	spn1.value=90
	)
	on ckb67 pressed do
	(
	spn1.value=15
	)
	on btn45 pressed do
	(
	macros.run "visualFengx" "smartMoveR"
	)
	on btn46 pressed do
	(
	macros.run "visualFengx" "smartMoveL"
	)
	on btn47 pressed do
	(
		if $!=undefined do 
		(
			local a=#()
			for s in $ do 
			(
				o=copy s
				o.name=s.name
				append a o
			)
		)
	)
	on btn48 pressed do
	(
	macros.run "visualFengx" "smartMoveU"
	)
	on btn49 pressed do
	(
	macros.run "visualFengx" "smartMoveD"
	)
	on btn250 pressed do
	(
	macros.run "visualFengx" "smartMoveB"
	)
	on btn251 pressed do
	(
	macros.run "visualFengx" "smartMoveF"
	)
	on btn53 pressed do
	(
		undo on(
			if $!=undefined  do 
			(
				 fengx.matrixObject $
				)
		)
	)
)














rollout uv "UV" width:162 height:300
(
	button btn39 "alignU" pos:[0,0] width:40 height:32
	button btn40 "alignV" pos:[40,0] width:40 height:32
)















rollout file "文件" width:720 height:592
(
	button btn1 ".visual" pos:[0,24] width:48 height:48 enabled:true toolTip:"快速导出.visual到SVN目录 (现在只支持...//common//和//char// 下模型和)"
	button btn2 ".obj" pos:[0,464] width:104 height:24 enabled:true toolTip:"另存所选择为 obj 格式"
	button btn3 ".max" pos:[0,440] width:104 height:24 enabled:true toolTip:"另存所选择为 max 格式"
	button btn17 "显示文件" pos:[88,72] width:40 height:40 enabled:true toolTip:"打开刚刚导出的.visual文件位置"
	button btn19 "显示文件" pos:[104,464] width:24 height:24 enabled:true
	button btn20 "显示文件" pos:[104,440] width:24 height:24 enabled:true
	button btn330 "显示 此文件" pos:[0,384] width:104 height:24 enabled:true toolTip:"打开当前正在编辑的文件 的文件夹"
	button btn239 "快速导出（选择）" pos:[0,0] width:128 height:24 enabled:false
	button btn216 "存为AB备份格式" pos:[0,152] width:128 height:24 toolTip:"存储为AB备份格式  会给选中物体 分别备份到所选地址 （BSP物体 命名为物体名字加上 “_coll”后才会随物体一起备份） 材质贴图路径正确的都会被拷贝过去"
	button btn264 "批量分开Maxs文件" pos:[136,388] width:128 height:32
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
	button btn47 "显示 自动备份文件" pos:[0,408] width:104 height:24 enabled:true toolTip:"打开自动备份的文件夹"
	checkbutton ckb3 "自动贴图" pos:[48,48] width:80 height:24 toolTip:"导出VISUAL后自动贴上材质贴图"
	checkbutton ckb311 "位置归零" pos:[48,24] width:80 height:24 toolTip:"导出Visual 的时候自动把物体归于原点（导出完成后回重新移回之前位置）"
	button btn72 "ModelEditor" pos:[48,72] width:40 height:40 enabled:true toolTip:"用模型编辑器打开刚刚导出的文件位置"
	button btn146 "存为AB备份格式" pos:[0,176] width:64 height:48 toolTip:"存储为AB备份格式  会给选中物体 分别备份到所选地址 （BSP物体 命名为物体名字加上 “_coll”后才会随物体一起备份） 材质贴图路径正确的都会被拷贝过去"
	button btn258 "显示 自动备份文件" pos:[104,408] width:24 height:24 enabled:true toolTip:"打开自动备份的文件夹"
	button btn259 "显示 此文件" pos:[104,384] width:24 height:24 enabled:true toolTip:"打开当前文件的文件夹"
	button btn333 "打开刚刚备份的文件夹" pos:[64,176] width:64 height:48 toolTip:"打开刚刚备份的文件夹"
	button btn404 "提取物体贴图" pos:[0,232] width:104 height:24 enabled:true toolTip:"提取当前物体的所有贴图（只存选择的物体）"
	button btn405 "@" pos:[104,232] width:24 height:24 enabled:true toolTip:"打开提取贴图的地址"
	button btn33 "智能打开模型" pos:[0,264] width:128 height:24 enabled:false toolTip:"会通过黏贴版 上面的地址 去寻找"
	button btn34 "智能打开模型" pos:[0,288] width:64 height:48 toolTip:"复制模型名字或者路径 点击后用模型编辑器打开该模型 （路径不需要完整）"
	button btn35 "智能打开模型" pos:[64,288] width:64 height:48 toolTip:"复制模型名字或者路径 点击后打开该模型所在文件夹 （路径不需要完整）"
	button btn106 "智能导入primitives" pos:[0,496] width:128 height:24 enabled:false toolTip:"还没写完"
	button btn143 "智能导入地形" pos:[0,520] width:128 height:24 enabled:false toolTip:"还没写好"
	button btn75 "复制模型地址" pos:[0,112] width:128 height:24 toolTip:"复制上次导出.visual文件的地址 这个地址可以直接填到明显编辑器里面"
	button btn114 "名字转换成地址" pos:[0,336] width:128 height:32 toolTip:"把黏贴板中的名字转换成.model地址(编辑器中可用的模型地址) (现在只支持...//common//和//char// 下模型和)"
	button btn173 "批量" pos:[0,72] width:48 height:40 enabled:true toolTip:"快速导出.visual到SVN目录"
	

	on file open do
	(
		if fengx.checkSVNDir()==false do
		(
			file.btn1.enabled=False
			file.btn173.enabled=False
			
			file.btn72.enabled=False
			file.btn17.enabled=False
			file.btn75.enabled=False
			file.btn34.enabled=False
			file.btn35.enabled=False
			file.ckb311.enabled=False
			file.ckb3.enabled=False
			
			)
		
		
		ckb3.state=visualMateReset
		ckb311.state=visualPosReset
		try btn72.images=#(mainIcon32A[6], mainIcon32Aa[6], 1,1,1,1,1 ) catch (print " btn72.images=#(mainIcon32A[6]")
		try btn17.images=#(mainIcon32A[5], mainIcon32Aa[5], 1,1,1,1,1 ) catch (print "btn17.images=#(mainIcon32A[5]")
		try btn35.images=#(mainIcon32A[5], mainIcon32Aa[5], 1,1,1,1,1 ) catch (print "btn35.images=#(mainIcon32A[5]")
		try btn19.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn19.images=#(mainIcon16A[5]")
		try btn20.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn20.images=#(mainIcon16A[5]")
		try btn258.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn258.images=#(mainIcon16A[5]")
		try btn259.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print " btn259.images=#(mainIcon16A[5]")
		try btn333.images=#(mainIcon32A[5], mainIcon32Aa[5], 1,1,1,1,1 ) catch (print "btn333.images=#(mainIcon32A[5]")
		try btn146.images=#(mainIcon32A[7], mainIcon32Aa[7], 1,1,1,1,1 ) catch (print "btn146.images=#(mainIcon32A[7]") 
		try btn34.images=#(mainIcon32A[6], mainIcon32Aa[6], 1,1,1,1,1 ) catch (print "btn34.images=#(mainIcon32A[6]") 
		try btn405.images=#(mainIcon16A[5], mainIcon16Aa[5], 1,1,1,1,1 ) catch (print "btn405.images=#(mainIcon16A[5]") 
		)
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
	    if $ !=undefined do fengx.saveToMax($)
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
	on btn216 pressed do
	(
	if $!=undefined then(
		saveToPath =  getSavePath    caption:"save to"
		if saveToPath!=undefined and saveToPath!="" then
		(
	          abPath=saveToPath
			fengx.saveToStandType $ saveToPath
			shelllaunch "explorer.exe" saveToPath
		)else print "导出路径错误！"
	)else messageBox "请选择要导出的物体！"
	
	)
	on btn264 pressed do
		fengx.splitMaxs()
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
	on ckb3 changed state do
	(
	visualmateReset=state
	setinisetting  profilePath "file" "visualMateReset" (state as string)
	)
	on ckb311 changed state do
	(
	visualPosReset=state
	setinisetting  profilePath "file" "visualPosReset" (state as string)
	)
	on btn72 pressed do
	(
		modelPath=getFilenamePath visualPath +getFilenameFile  visualPath +".model"
		if (getfiles modelPath).count != 0 then(
		     filePath="-o" +(fengx.beWindowsPath modelPath)
		     print filePath
			try  ShellLaunch (mfDIR+"bigworld\\tools\\modeleditor\\modeleditor.exe") filePath   catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！"
		)else messageBox "这个路径下没有文件 打不开  ！   "
		)
	on btn146 pressed do
	(
	if $!=undefined then(
		saveToPath =  getSavePath    caption:"save to"
		if saveToPath!=undefined and saveToPath!="" then
		(
	          abPath=saveToPath
			fengx.saveToStandType $ saveToPath
			shelllaunch "explorer.exe" saveToPath
		)else print "导出路径错误！"
	)else messageBox "请选择要导出的物体！"
	
	)
	on btn258 pressed do
	(
	ShellLaunch "explorer.exe" (getdir #autoback)
	)
	on btn259 pressed do
	(	
	    if (getfiles (maxfilepath+maxfilename)).count != 0 then(
	    filePath="/select,"+maxfilepath+maxfilename
	    try  ShellLaunch "explorer.exe" filePath   catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！！"
	)else(
		--theVoice.Speak "还没存 呢 大哥！" 
		 messageBox ("还没存呢  ！    ")
	     
		） 
		)
	)
	on btn333 pressed do
	(
		if abPath!=undefined and abPath!="" do try  ShellLaunch "explorer.exe" abPath   catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！"
		)
	on btn404 pressed do
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
	on btn405 pressed do
	(
		if (getfiles saveMapPath  ).count != 0 do(
		filePath="/select," +saveMapPath  
		print saveMapPath  
	
	     print filePath
		try  ShellLaunch "explorer.exe" filePath catch messageBox("硬是没打开！") title:"擦擦擦擦擦擦！！"
	)
	)
	on btn33 pressed do
		(
	
	)
	on btn34 pressed do
	(
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	   tempStr="-mi"+DotNetClipboard.GetText()
	 shellLaunch  (getDir #Scripts+ "\\visualFengx\\fengxTools.exe") tempStr
	)
	on btn35 pressed do
	(
	 DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	   tempStr="-ei"+DotNetClipboard.GetText()
	 shellLaunch  (getDir #Scripts+ "\\visualFengx\\fengxTools.exe") tempStr
	)
	on btn106 pressed do
	(
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	   tempStr=DotNetClipboard.GetText()
	 shellLaunch  (getDir #Scripts+ "\\visualFengx\\primitives2obj_tool.py") tempStr
	)
	on btn143 pressed do
	(
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	   tempStr=DotNetClipboard.GetText()
	 shellLaunch  (getDir #Scripts+ "\\visualFengx\\primitives2obj_tool.py") tempStr
	)
	on btn75 pressed do
	(
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	  if modelPath!="" or modelPath!=" " or modelPath!=undefined  do DotNetClipboard.SetText modelPath
	)
	on btn114 pressed do
	(
	  DotNetClipboard = DotNetClass "System.Windows.Forms.Clipboard"
	  if (fengx.getNamePath(DotNetClipboard.GetText()))==(mfDIR+"/tw2/res/scene/common/") then messageBox "转换失败!" else
	 (
	  mPath= fengx.getNamePath(DotNetClipboard.GetText())+DotNetClipboard.GetText()+".model"
	  mPath=replace mPath 1 20 ""
	  DotNetClipboard.SetText  mPath
	  )
	)
	on btn173 pressed do
	(
	if $!=undefined do
	(
		a=#()
		for s in $ do append a s
		for s in a do
		(
			select s 
			fengx.exportSelectToVisual()
		)
	)
	)
)
















rollout snap "吸附" width:362 height:562
(
	--fn box_filt obj = classof obj == Box 
	pickbutton chooseit "拾取物体" pos:[0,116] width:128 height:20 --filter:Editable_Poly
	checkbutton p "Pos" pos:[16,20] width:48 height:20 checked:false
	checkbutton px "x" pos:[16,40] width:16 height:16 checked:false
	checkbutton py "y" pos:[32,40] width:16 height:16 enabled:true checked:false
	checkbutton pz "z" pos:[48,40] width:16 height:16 checked:false
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
	checkbutton ckb19 "Name" pos:[0,96] width:48 height:20
	checkbutton ckb20 "Material" pos:[80,96] width:48 height:20
	pickbutton btn99 "设置吸附目标对象" pos:[0,163] width:128 height:24
	button btn119 "吸附（带方向）" pos:[0,187] width:128 height:27 enabled:true
	button btn174 "吸附（仅位置）" pos:[0,214] width:128 height:28 enabled:true
	button btn53 "吸取属性" pos:[0,0] width:128 height:20 enabled:false
	button btn126 "吸附表面" pos:[0,144] width:128 height:19 enabled:false
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
	on ckb19 changed state do
	(
	
		)
	on ckb20 changed state do
	(
	
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
)















global CPD_type=2 -->> 1=copy 2=paste 3=delete
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
	checkbutton ckb_C "复制" pos:[0,0] width:48 height:20
	checkbutton ckb_P "黏贴" pos:[0,20] width:48 height:20 checked:true
	button btn29 "打开" pos:[0,128] width:48 height:20
	button btn84 "清除所有" pos:[0,108] width:48 height:20
	button btn34 "↓" pos:[0,92] width:48 height:16
	button btn35 "↑" pos:[24,204] width:24 height:20
	button btn36 "↑" pos:[0,316] width:48 height:20
	button btn37 "↓" pos:[0,204] width:24 height:20
	button btn50 "←" pos:[0,76] width:16 height:16
	button btn51 "→" pos:[32,76] width:16 height:16
	button btn60 "↑" pos:[0,60] width:48 height:16
	button btn61 "●" pos:[16,76] width:16 height:16
	checkbutton ckb_D "删除" pos:[0,40] width:48 height:20 checked:false
	button btn31 "整理" pos:[0,148] width:48 height:20
	button btn12 "黏贴板" pos:[0,168] width:48 height:20
	
	
	function updateImage=
	(
		local cbks=#(ckb01,ckb02,ckb03,ckb04,ckb05,ckb06,ckb07,ckb08,ckb09,ckb10,ckb11,ckb12,ckb13,ckb14,ckb15,ckb16,ckb17,ckb18,ckb19,ckb20,ckb21,ckb22,ckb23,ckb24,ckb25,ckb26,ckb27,ckb28,ckb29,ckb30)
		local bc=color 64 67 65 60 
		local c1=color 10 10 100 60 
		local c2=color 10 100 10 60 
		local c3=color 100 10 10 60 
		local cls=#(c1,c2,c3)
		local posRect=[-10,-10,-10,-10]
		local posRect1=[0,102,10,160]
		--local posRect1=[0,0,20,160]
		local theBmp = (BitMap 160 112 color:cls[CPD_Type]) 
		local theDefultBmp = (BitMap 160 112 color:cls[CPD_Type]) 
		local theDefultUpBmp = (BitMap 160 112 color:cls[CPD_Type]) 
		local theUpBmp= (BitMap 160 112 color:cls[CPD_Type]) 
		-->>DefultImage
		local DefultImagePath= (getDir #Scripts+ "\\visualFengx\\copyPasteDefult.png")
		if doesFileExist DefultImagePath ==true  do theDefultUpBmp  = openBitMap  DefultImagePath 
	
		for i=posRect1.y to (posRect1.w+posRect1.y) do
		(
			colorA=getPixels theDefultBmp [posRect1.x,i]  posRect1.w
			for i=1 to colorA.count do colorA[i]*=0.51
			setPixels  theDefultUpBmp   [posRect1.x,i]  colorA
			)
		
			
		/*
		for i=-posRect.y to  (theDefultUpBmp .height+posRect.w) do
		(
			colorA=getPixels theDefultUpBmp [-posRect.x,i] (theDefultUpBmp .width+posRect.x+posRect.z)
			setPixels theDefultBmp  [-posRect.x,i]  colorA
			)
		*/		
		-->>Image
		for i=1 to 30 do 
		(
		imagePath=copyPastePath + "\\visualFengx\\copyPasteTemp\\" +"copyTemp"+i as string + ".jpg"
		if doesFileExist imagePath then(
			theUpBmp =openBitMap  imagePath
			theBmp = (BitMap 160 112 color:cls[CPD_Type]) 
			/*
			for i=-posRect.y to  (theUpBmp.height+posRect.w) do
			(
				colorA=getPixels theUpBmp [-posRect.x,i] (theUpBmp.width+posRect.x+posRect.z)
				setPixels theBmp  [-posRect.x,i]  colorA
				)	
			*/
			
			for i=posRect1.y to (posRect1.w+posRect1.y) do
			(
			colorA=getPixels  theBmp [posRect1.x,i]  posRect1.w
			for i=1 to colorA.count do colorA[i]*=0.7
			setPixels  theUpBmp  [posRect1.x,i]  colorA
			)
			theBmp=theUpBmp 
			)else(
			
			theBmp=theDefultupBmp
			)
			try cbks[i].images=#(theBmp, undefined, 1,1,1,1,1 ) catch (print "-->>>> setImages error! in copyPaste.ckb"+i as string )
		)
	)
	

-->>clearup copyPaste sort
	function getStringNumber str=
	(
		local num=0
		local tempStr=""
		for i=1 to str.count do 
		(
			if str[i]>="0" and str[i]<="9" do tempStr+=str[i]
			)
		--if tempStr="" do 
		num=tempStr as Integer
		return num
		)
	
		
	function reName CID TID=
	(
		imagePathC= fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/" +"copyTemp"+CID as string + ".jpg")
		maxPathC = fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/"  +"copyTemp"+CID as string +	".max" )
		imagePathT= fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/" +"copyTemp"+TID as string + ".jpg")
		maxPathT = fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/"  +"copyTemp"+TID as string +	".max" )
		renameFile  imagePathC  imagePathT
		renameFile  maxPathC  maxPathT
		)
		
		
		
	function clearup=
	(
		local IDs=#()
		local IDsEct=#()
		local filePath=(copyPastePath + "\\visualFengx\\copyPasteTemp\\"  +"copyTemp*.max" )
		files = getFiles filePath
		
		for f in files do 
		(
			local ID= getStringNumber (getFilenameFile f)
			append IDs ID
			)
		sort IDs
		
		for i=1 to IDs[IDs.count] do 
		(
			if (findItem IDs i)==0 do append IDsEct i
			)
		sort IDsEct
		--print IDsEct.count 
		for i=1 to IDsEct.count do 
		(
			
			tempIDsEct=#()
			for i=1 to IDs[IDs.count] do 
			(
				if (findItem IDs i)==0 do append tempIDsEct i
				)
			sort tempIDsEct
			print tempIDsEct.count
			if tempIDsEct.count!=0 do
			(
			reName IDs[IDs.count]  tempIDsEct[1]
			deleteitem IDs  IDs.count
			append IDs tempIDsEct[1]
			sort IDs 
			)
		)
	)
-->>clearup copyPaste sort	
	
		
		
	function deleteObject ID=
	(		
		imagePath= fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/" +"copyTemp"+ID as string + ".jpg")
		maxPath = fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/"  +"copyTemp"+ID as string +	".max" )
		deleteFile  imagePath
		deleteFile  maxPath 
		
		
		)
		
	function CPD ID=
	(
		if CPD_Type==1 do fengx.copyNodes ID
		if CPD_Type==2 do fengx.pasteNodes ID
		if CPD_Type==3 do deleteObject ID
		updateImage()
		)
	
	

	on copyPaste open do
	(

		--try btn17.images=#(openBmp, undefined, 1,1,1,1,1 ) catch (print "xxxxxxx")
		
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
		CPD 1
	)
	on ckb02 changed state do
	(
		CPD 2
	)
	on ckb03 changed state do
	(
		CPD 3
	)
	on ckb04 changed state do
	(
		CPD 4
	)
	on ckb05 changed state do
	(
		CPD 5
	)
	on ckb06 changed state do
	(
		CPD 6
	)
	on ckb07 changed state do
	(
		CPD 7
	)
	on ckb08 changed state do
	(
		CPD 8
	)
	on ckb11 changed state do
	(
		CPD 11
	)
	on ckb12 changed state do
	(
		CPD 12
	)
	on ckb13 changed state do
	(
		CPD 13
	)
	on ckb14 changed state do
	(
		CPD 14
	)
	on ckb15 changed state do
	(
		CPD 15
	)
	on ckb16 changed state do
	(
		CPD 16
	)
	on ckb17 changed state do
	(
		CPD 17
	)
	on ckb21 changed state do
	(
		CPD 21
	)
	on ckb22 changed state do
	(
		CPD 22
	)
	on ckb23 changed state do
	(
		CPD 23
	)
	on ckb24 changed state do
	(
		CPD 24
	)
	on ckb25 changed state do
	(
		CPD 25
	)
	on ckb26 changed state do
	(
		CPD 26
	)
	on ckb27 changed state do
	(
		CPD 27
	)
	on ckb18 changed state do
	(
		CPD 18
	)
	on ckb28 changed state do
	(
		CPD 28
	)
	on ckb09 changed state do
	(
		CPD 9
	)
	on ckb10 changed state do
	(
		CPD 10
	)
	on ckb19 changed state do
	(
		CPD 19
	)
	on ckb29 changed state do
	(
		CPD 19
	)
	on ckb20 changed state do
	(
		CPD 20
	)
	on ckb30 changed state do
	(
		CPD 30
	)
	on ckb_C changed state do
	(
	ckb_P.state=false
	ckb_D.state=false
	CPD_Type=1
	updateImage()
	)
	on ckb_P changed state do
	(
	ckb_C.state=false
	ckb_D.state=false
	CPD_Type=2
	updateImage()
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
	if copyPaste.width<1646 then (
	copyPaste.height=336
	copyPaste.width=1646
	)else
	(
	copyPaste.height=112
	copyPaste.width=846
	)
	)
	on ckb_D changed state do
	(
	ckb_P.state=false
	ckb_C.state=false
	CPD_Type=3
	updateImage()
	)
	on btn31 pressed do
	(
	clearup()
	updateImage()
	)
	on btn12 pressed do
	(
	createdialog clipboard 160 112 pos: copyPastePos
	)
)
























rollout clipboard "clipboard" width:160 height:116
(
	checkbutton ckb01 "ckb01" pos:[0,0] width:160 height:112 enabled:true
	
	on clipboard open  do
(
	updateClipboardImages()
	)
	on ckb01 changed state do
	(
	 fengx.pasteNodes 0
	)

)
	
function updateClipboardImages=
(
	bc=color 64 67 65 60 
	theBmp = (BitMap 160 112 color:bc) 
	theDefultBmp = (BitMap 160 112 color:bc) 

	imagePath= fengx.beWindowsPath  (copyPastePath + "/visualFengx/copyPasteTemp/copyTemp0.jpg")
	if doesFileExist imagePath then(
		theBmp =openBitMap  imagePath
		)else(
		imagePath= fengx.beWindowsPath  (getDir #Scripts+ "/visualFengx/copyPasteDefult.png")
		if doesFileExist imagePath  do theBmp =openBitMap  imagePath
		)
	try clipboard.ckb01.images=#(theBmp, undefined, 1,1,1,1,1 ) catch (print "clipboard.ckb01.images")
	)












U_bc=color 64 67 65 60 
U_updateBmp = (BitMap 233 112 color:U_bc) 
U_imagePath= (getDir #Scripts+ "\\visualFengx\\update_bg.jpg")
if doesFileExist U_imagePath do U_updateBmp=openBitMap  U_imagePath
	
rollout checkUpDateWindow "Update" width:232 height:396
(
	button btn54 "x" pos:[-1,-1] width:233 height:112 images:#(U_updateBmp, undefined, 1, 1, 1, 1, 1)
	label lb01 "" pos:[1,112] width:231 height:208
	button btn55 "更新" pos:[120,320] width:112 height:48
	button btn56 "下次在说" pos:[0,320] width:120 height:48
	button btn57 "不要再提醒了" pos:[0,368] width:232 height:24


	
	on checkUpDateWindow open  do
	(
	if updateMsg==""do lb01.text="没有更新包!"
	
	)
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
function llllllllllllllllllllllllllllllllllllllllllllllllsystemToolFn=(),
--------------------------------------------------------
-------------------------system tool-------------------------


function iconBitmapToArray b=
(
	a=#()
	if classof(b)==BitMap do 
	(
		for i=1 to b.width/b.height do
		(
			tbmp=(BitMap  b.height  b.height  color:(color 64 67 65 60)) 
			for x=1 to 32 do
			(
				
				colorA=getPixels b [i,x]  b.height
				setPixels    tbmp [0,x]  colorA
				)
			append a tbmp
			)
		)
	return a
	),


function checkSVNDir=
(
	b=True
	if 	doesFileExist (mfDir +"tw2\\res\\") == false do b=false
	if 	doesFileExist (mfDir +"bigworld\\tools\\worldeditor\\worldeditor.exe") == false do b=false
	if 	doesFileExist (mfDir +"bigworld\\tools\\modeleditor\\modeleditor.exe") == false do b=false	
	return b
	),
	
function setSVNDir=
(
	b=False
	--if  fengx.checkSVNDir()==False do

		
	if (queryBox "设置  SVN 游戏资源 目录 (mf_pangu 的位置 选择mf_pangu)!")==true then
		(
			tdir=getSavePath()
			if tdir!=undefined and tdir!="" and tdir!=" " do 
			(
				mfDir=tdir+"\\"
				setinisetting  profilePath "system" "mfDIR"  mfDIR
				macros.run "VisualFengx" "mainwindow"
				macros.run "VisualFengx" "mainwindow"
				if doesFileExist(profilePath) then
				(	
					copyfile (profilePath) (mfDIR+"bigworld\\tools\\worldeditor\\fengx.fengx")
					setinisetting  (mfDIR+"bigworld\\tools\\worldeditor\\fengx.fengx") "system" "mfDIR"  mfDIR
					
				)
			)
		)else( print "不设置的话 涉及到目录里面的 功能将无法使用!")
	
	
	
	if fengx.checkSVNDir() do b=True

	return b
	),	
		
-------------------------------------------->> for edit script
-------------------------------------------->> for edit script 
-------------------------------------------->> for edit script 
	
---->>send script To Github directory
	
function sendToGithub GitHubPath=
(
	local oPath=getDir #scripts +"\\visualfengx\\" 
	local startFile=getDir #startupScripts +"\\fengx_start.ms"
	local files=getFiles (oPath+"*")
	for f in files do 
	(
		local fName=filenameFromPath f 
		if fName!="fengx.fengx" do 
		(
		local newPath=GitHubPath as string +"\\visualfengx\\" + fName
		if doesFileExist newPath do deleteFile newPath
		if (copyFile f newPath) then () else (messageBOx ("复制失败"+f) )
		)
		)
	local newStartFilePath=GitHubPath as string +"Startup\\fengx_start.ms"
	if doesFileExist newStartFilePath do deleteFile newStartFilePath
	if (copyFile startFile newStartFilePath )then () else (messageBOx ("复制失败"+startFile) )
	),
	
	
---->> uninstall VisualFengx	
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
	local copyPastePath=getDir #scripts +"\\VisualFengx\\copyPasteTemp\\*"
	local files=getFiles copyPastePath
	for s in files do deleteFile s
	if (queryBox "卸载完成 最好重启Max！")==true do 
	(
		if checkForSave() then (
		shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
		quitmax #noPrompt
		)
		)
	)
),

	
---->>check  VisualFengx Update
function checkUpdate=
(
local updateA=false
local web = dotNetObject "System.Net.WebClient"
local updateFileUrl = "https://raw.github.com/fengxxx/VisualFengx_3dmax/Netease/update"
local updateFilePath = getDir #downloads +"\\update"
deleteFile  updateFilePath
local tempon=true
try web.DownloadFile updateFileUrl  updateFilePath catch
(
	tempon=false 
	messageBox "检测更新失败!"
)

if (doesFileExist updateFilePath )==true then 
(
	
	try (updateFile=openFile updateFilePath   mode: "rb" ) catch
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
		--print lineStr 
		--print (lineStr as string)
		if i==1 then( if lineStr !=undefind and lineStr !="" and (lineStr as float) !=undefined do try  newVersions = (lineStr as float) catch (tempon=false)) else
		(
			tempMsg+=(lineStr  as string + "\n")
		)
		i+=1
		)
		upDateMsg=tempMsg as string	
		--print upDateMsg	
		if 	newVersions > VisualFengxVersions do updateA=true --else print "该版本已经为最新！无需更新!"
		try close updateFile catch()
		try deleteFile updateFilePath catch ()
	)	
	)else print ("cant find update file! in " +updateFilePath )
	--)--else messageBox "检查更新失败！"
	if updateA==true do 
	(
		local web = dotNetObject "System.Net.WebClient"
		local installFileUrl="https://github.com/fengxxx/VisualFengx_3dmax/raw/Netease/VisualFengx_"+(newVersions as string )+".mzp"
		local installFilePath= getDir #downloads +"\\VisualFengx_"+(newVersions as string )+".mzp"
		--tempon=true
		if (doesFileExist installFilePath)==false do try web.DownloadFile installFileUrl  installFilePath catch()--print "下载失败！"

	)
return updateA
),

---->> update VisualFengx
function update=
(
	installFilePath= getDir #downloads +"\\VisualFengx_"+(newVersions as string )+".mzp"
	if (doesFileExist installFilePath)==true then (try fileIn installFilePath catch ()) else(
		if (queryBox "更新文件不存在！是否下载")==true do(
			local web = dotNetObject "System.Net.WebClient"
			local installFileUrl="https://github.com/fengxxx/VisualFengx_3dmax/raw/Netease/VisualFengx_"+(newVersions as string )+".mzp"
			local installFilePath= getDir #downloads +"\\VisualFengx_"+(newVersions as string )+".mzp"
			print installFileUrl
			print installFilePath
			try  web.DownloadFile installFileUrl  installFilePath catch print "下载失败！"
			try fileIn installFilePath catch messageBox "下载失败！下次重开在试试吧！"	
			)
			)
),
--------------------------------------->> only test function
--------------------------------------->> only test function
--------------------------------------->> only test function
---->> Bubble sort  
function BubbleSort a=
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
function bubbleSortArry b=
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



--------------------------------------->> only test function
--------------------------------------->> only test function
--------------------------------------->> only test function

	
---->>save select to max 	
function saveToMax nodes=
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


------------------------------------------------>> <only for netease> 
------------------------------------------------>> <only for netease> 
------------------------------------------------>> <only for netease> 

---->>split maxs file to standerd type file
function splitMaxs =
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


---->>save to standType  file 
function saveToStandType nodes exportPath=
(
	local log=localtime+" start...saveToStandType.....\n"
if nodes!=undefined and  exportPath!=undefined then
(
--exportPath =getSavePath  caption:"get to"
	local names=#()
	for s in nodes do append names s.name
	for n in names do 
	(
		local namePart= filterString n "_"
		if namePart.count>-1 do--if namePart.count>2 and namePart[namePart.count]!="coll" do
		(
			local saveOn=true
			local nodePath=exportPath+"\\"+n+"\\max"
			makeDir nodePath
			local maxPath=nodePath +"\\"+n+".max"
			local s=getNodeByName n exact:true ignoreCase:true  all:false
			local coll=getNodeByName (n+"_coll") exact:true ignoreCase:true  all:false
			local sPos=s.pos
			local nodeA=#(s)
			local collPos=[0,0,0]
			if coll!=undeifend do
			(
				append nodeA coll
				collPos=coll.pos
				collPos=coll.pos
				coll.pos=[0,0,0]
			) 
			try saveNodes nodeA maxPath catch  saveOn=false 
			if coll!=undeifend do coll.pos=collPos
			s.pos=sPos
			if saveOn==true then
			(
				log +=("\n"+localtime+"  -- > max was saved success.....\n start copying " + n +" maps .....")
				-->> save a thumbnail
				select s
				macros.run "Tools" "Isolate_Selection"
				max zoomext sel all
				bc=color 64 67 65 60 
				theBmp = (bitmap 160 112 color:bc)
				
				fEnvironmentMap =environmentMap 
				uon=useEnvironmentMap
				environmentMap =backUpBGBmp  
				try theBmp = render outputsize:[1024,768] vfb:off catch messageBox("渲染缩略图失败")
				environmentMap =fEnvironmentMap 
				useEnvironmentMap=uon
				
			     --try theBmp = render outputsize:[1024,768] vfb:off catch messageBox("渲染缩略图失败")
				thebmp.filename=exportPath + "\\" + n + "\\" + n +".jpg"
				save theBmp 
				--max select all
				max views undo
				max unhide all
				--s.primaryVisibility=off
				for map in  (fengx.getTrueMapPath s) do
					(
					tName =getFilenameFile map
					tType= getFilenameType map
					tempMapPath=nodePath +"\\" + tName +tType
					local copySOn=true
					if doesFileExist map ==true then(
						try copyfile map tempMapPath catch (
							 log += ("\n....."+map +" was not be saved.....")
							 copySOn=false
							 )
						 )else(
							log += ("\n  ------  "+map +"     > map does not exist .....")
							copySOn=false
							)
					if copySOn==true do log += ("\n  ------  "+map +"     > map was copyed success.....")
					)
				log+=("\n"+localtime +"  "+ n+" maps be saved.....")
			)else log+= (localtime+"\n"+ n+"   was not be saved.....")

		)
	)
)else log+= localtime+"\nnot choese save path...  will not be saved... "
print log

),

---->>smart save select to Visual File 
function exportSelectToVisual=
(
	local name=maxfilename
	local pos=[0,0,0]
	try pos=$.pos catch()
	try $.count catch name=$.name 
	try name=(fengx.selectGroupDummy $)[1].name catch print "no group" 
	
	if $!=undefined do 
	(
		tempTargetPath=fengx.getNamePath(name) --"E:/mf_pangu/tw2/res/scene/common/"+
		)
	modelPath=tempTargetPath+name+".model"
	modelPath=replace modelPath 1 20 ""
	tempTargetPath=tempTargetPath+name+".visual"
	print tempTargetPath
	targetPath=getSaveFileName  caption:"save select"  types:"*.visual"  filename:tempTargetPath
	if targetPath!=""and targetPath!=undefined do 
    (
		if (getFilenameType targetPath)!=".visual" do 
		(
			targetPath=getFilenamePath targetPath +".visual" 
			
		)
	  	--targetPath=tempTargetPath+".visual" 
		theClasses = VisualExporter
		if visualPosReset==true do try $.pos=[0,0,0] catch()
		if (exportFile (targetPath) selectedOnly:true  using:theClasses)==true do
		(		
			
			visualPath=fengx.beWindowsPath TargetPath
			setinisetting  profilePath "visualPath" "path" visualPath
 			print (fengx.beStringPath(modelPath))
			if visualMateReset==true do 
			(
			 --shellLaunch  (getDir #Scripts+ "\\visualFengx\\VisualFileXML.py") (TargetPath) --"E:\GitHub\VisualFengx_3dmax\VisualFengx\VisualFengx\VisualFileXML.py"  TargetPath
			 shellLaunch  (getDir #Scripts+ "\\visualFengx\\fengxTools.exe") (("-am"+TargetPath)) 

			)
		)
		try $.pos=pos catch()
    )

	
),

function getNamePath n=
(
	n=getFilenameFile n
	path=(mfDIR+"tw2/res/scene/common/")
	tw1=""
	tw2=""
	count=0
	numOn=True
	for i=1 to n.count do(
		if n[i]=="_" do  count+=1
		if n[i]<"z"and n[i]>"a" do numOn=False
		if count>=1 and count<2 do 	tw1+=n[i]
		if count>=2 and count<3 do  tw2+=n[i]
	)
	
	if count!=0 then
	(
		tw1=fengx.getLetter(tw1)
		tw2=fengx.getLetter(tw2)
		if tw1[1]=="j" and tw1.count>3 then(
			path=path+tw1[1]+tw1[2]+"/"+tw1+"/"+tw1[3]+tw1[4]+tw2+"/"
		)else(
			if tw1.count>2 do path=path+tw1[1]+tw1[2]+"/"+tw1+"/"
		)
		b=getFiles(path+"*")
		-- and tw1[1]!="l"
		)else
		(
			if numOn==True then  path=mfDIR+"tw2/res/char/"+n+"/" else path=mfDIR+"tw2/res/scene/"
			
		)

	
	return path
),

function getLetter n=
(
	name=""
	for i=1 to n.count do(
		if n[i]>="A" and n[i]<="z" and n[i]!="_" do name+=n[i]  
	)
	return name
),
------------------------------------------------>> <only for netease> 
------------------------------------------------>> <only for netease> 
------------------------------------------------>> <only for netease> 


---->>copy nodes
function  copyNodes  NO =
(
	local targetPath = copyPastePath + "/visualFengx/copyPasteTemp/"  +"copyTemp"+NO as string +	".max" 
	makeDir (copyPastePath+ "/visualFengx/copyPasteTemp")
	targetPath = fengx.beWindowsPath targetPath 
	if $ != undefined and NO != undefined do 
	(
	-->> tempname
	for s in $ do(
		 try s.name+=".Fcopy" catch() 
		 if s.material!=undefined do 
		 (
		 	for m in fengx.toStandardMate s.material do m.name+=".Fcopy"
			if classof s.material == Multimaterial do s.material.name+=".Fcopy"
			)
		)	
	saveNodes $  targetPath
	-->>change name back
	for s in $ do
				(
				 try (
				 	if (getFilenameType  s.name==".Fcopy") do s.name=(getFilenameFile  s.name )
					)catch() -->> tempname
				 if s.material!=undefined do 
				 (
				 	for m in fengx.toStandardMate s.material do 
						(
						if (getFilenameType  m.name==".Fcopy") do m.name=(getFilenameFile  m.name)
						)
					)
				if classof s.material == Multimaterial do 
				(
				if (getFilenameType  s.material.name==".Fcopy") do s.material.name=(getFilenameFile  s.material.name)
				)
				)	

	
	for s in $ do try s.name=(getFilenameFile  s.name) catch()
	bc=color 64 67 65 60 
	theBmp = (bitmap 160 112 color:bc)
	--theBmpT = (bitmap 160 112 color:bc)
	macros.run "Tools" "Isolate_Selection"
	max zoomext sel all
	fEnvironmentMap =environmentMap 
	uon=useEnvironmentMap
	environmentMap =copyPasteBGBmp
	try theBmp = render outputsize:[160,112] vfb:off catch messageBox("渲染缩略图失败")
	environmentMap =fEnvironmentMap 
	useEnvironmentMap=uon
	max unhide all
	--macros.run "Tools" "Isolate_Selection"
	max views undo
	max views undo
	theBmp.filename=fengx.beWindowsPath (copyPastePath+ "\\visualFengx\\copyPasteTemp\\" +"copyTemp"+NO as string + ".jpg") -- (copyPastePath+ "/visualFengx/copyPasteTemp/" +"copyTempT.png")
	--print thebmp.filename
	save theBmp
	/*
	-->> only for fun 
	local theDefultBmp = (BitMap 160 112 color:bc) 
	local DefultImagePath= (getDir #Scripts+ "\\visualFengx\\copyPasteDefult.png")
	if doesFileExist DefultImagePath ==true  do theDefultBmp  = openBitMap  DefultImagePath 
	--close theBmpT 
	
	theBmpx = openBitMap  (copyPastePath+ "\\visualFengx\\copyPasteTemp\\" +"copyTempT.png") 
	theBmp=theBmpx
	theBmp.filename =(copyPastePath+ "\\visualFengx\\copyPasteTemp\\" +"copyTemp"+NO as string +	".png")
	for x=1 to theDefultBmp.width  do
	(
		for y=1 to   theDefultBmp.height do
		(
		colorA=getPixels theDefultBmp [x,y]  1
		colorB=getPixels theBmp [x,y]  1
		a=225
		try a=colorB[1].a catch ()
		if x==80 do print a
		if a>=224 do setPixels theBmp   [x,y]   colorA
		
		)
	)
	-->> only for fun 
	--copyPaste.ckb01.images=#(theBmp, undefined, 1,1,1,1,1 )
	save theBmp 
	*/
	)
	),
	

---->>paste nodes 
function  pasteNodes NO=
(
	local targetPath = fengx.beWindowsPath(copyPastePath+ "/visualFengx/copyPasteTemp/" +"copyTemp"+NO as string +	".max" )
	targetPath = fengx.beWindowsPath targetPath 
	if NO != undefined do (
		 if (mergemaxfile  targetPath  #select)==true do 
		 (
			for s in $ do
				(
				 try (
				 	if (getFilenameType  s.name==".Fcopy") do s.name=(getFilenameFile  s.name )
					)catch() -->> tempname
				 if s.material!=undefined do 
				 (
				 	for m in fengx.toStandardMate s.material do 
						(
						if (getFilenameType  m.name==".Fcopy") do m.name=(getFilenameFile  m.name)
						)
					)
					if classof s.material == Multimaterial do 
						(
						if (getFilenameType  s.material.name==".Fcopy") do s.material.name=(getFilenameFile  s.material.name)
						)
				)	
		 	)
		 )
	),

	
---->>smart  save select to OBJ file 
function exportSelectToOBJ=
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

---->> change path "/" to "\\"
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
),

---->> change path "\\" to "/"
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
),

---->>restart max 
function restart =
(
    if checkForSave() then (
        shellLaunch (getdir #maxroot+"\\3dsmax.exe") (maxfilepath+maxfilename)
        quitmax #noPrompt
    )
),
    

function fixAmbientColor n=
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

function llllllllllllllllllllllllllllllllllllllllllllllllmatelrialToolFn=(),
-------------------------matelrial tool----------------------

---->> delete <nodes>'s  unnecessary materials 
 function clearObjectMultiMaterial nodes=
(
	if nodes!=undefined do
	(
		for n in nodes do 
		(
			if classOf n==Editable_Poly and classOf n.material==Multimaterial do
			(
				faceA=#()
				mateA=#()
				local deleteIds=#() ---->>unnecessary materials IDs
				local mID=#()
				for i=1 to n.material.materialIDList.count do 
				(
					subobjectLevel = 0	
					clearSelection()
					select n
					subobjectLevel = 4
					MID=n.material.materialIDList[i]
					n.selectByMaterial MID
					faces=n.getSelection #Face
					--print faces
					if (faces as array).count!=0 do(
						append mateA n.material[n.material.materialIDList[i]]
						
						append faceA (polyOp.getFaceSelection($))
					)
				)	
				subobjectLevel = 0	
				if mateA.count==1 then newMate=mateA[1] else
				(
				local newMate=MultiMaterial()
				newMate.materialList=mateA
				)
				n.material=newMate
				
				i=1
				for s in faceA do 
				(
					polyOp.setFaceSelection $ s
					n.EditablePoly.setMaterialIndex  i  1 
					i+=1
				)
				try meditMaterials[medit.GetActiveMtlSlot()]=n.material catch()
			)
		)
	)
),

function deleteSameMate nodes=
(
for n in nodes do
(
	if classOf n.material==MultiMaterial do
	for i=1 to n.material.count do
	(
		for ii=(i+1) to n.material.count do 
		(
			if n.material[i].name==n.material[ii].name do 
			(
				n.selectByMaterial ii 
				$.EditablePoly.setMaterialIndex i 1
			)
		) 
	)
	try meditMaterials[medit.GetActiveMtlSlot()]=n.material catch()	 
	)
),

---->>change multiMaterial to  StandardMaterial
function toStandardMate mate=
(	
	mateStandard=#()
	local tempOn=true
	try mate.count catch tempOn=false
	if tempOn==true and mate!=undefined then 
	(
		--try(
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
		--) catch print "no material!"
	)else append mateStandard mate
	

	return mateStandard
),


---->>Get maps that is Really in the use of from <nodes>
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


---->>Get maps that is Really in the use of from <materials>  
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
	

---->>replace map path with really in use map path 	
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
	
------------------------------------------------>> <only for netease> 
------------------------------------------------>> <only for netease> 
------------------------------------------------>> <only for netease> 
---->>from diffuse map path get others map path 
function dToDNS DPath=
(
	mapPath=getFilenamePath     DPath
	mapName = getFilenameFile   DPath
	mapType =getFilenameType    DPath	
	
	mapsPathArry=#()
	append	mapsPathArry DPath
	namePart= filterString mapName "_"
	if namePart.count>2 then
	(
		if namePart[(namePart.count-1)]=="a" do deleteItem namePart  (namePart.count-1) --alpha
		temp=""
		local NName=""
		local SName=""
		local EName=""
		local MName=""
		--Normal map
		namePart[(namePart.count-1)][namePart[(namePart.count-1)].count]="n"
		for a in namePart do 
		(
			temp =a+"_"
			NName+=temp
			)
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
			
		strS=""
		for i=1 to (SName.count-1) do  strS+=SName[i]
		SName =strS
	
		--xxx
		--Self-Illumination map
		namePart[(namePart.count-1)][namePart[(namePart.count-1)].count]="e"
		for a in namePart do
		(
			temp =a+"_"
			EName+=temp
		)
		
		strE=""
		for i=1 to (EName.count-1) do  strE+=EName[i]
		EName=strE
		--xxx
		--mask map
		namePart[(namePart.count-1)][namePart[(namePart.count-1)].count]="m"
		for a in namePart do
		(
			temp =a+"_"
			MName+=temp
		)
		strM=""
		for i=1 to (MName.count-1) do  strM+=MName[i]
		MName=strM
		--xxx	

		
		--substring SName 1 (NName.count-1)
		append	mapsPathArry (mapPath+NName+mapType)
		append	mapsPathArry (mapPath+SName+mapType)
		append	mapsPathArry (mapPath+EName+mapType)
		append	mapsPathArry (mapPath+MName+mapType)
		
	)else(
		append	mapsPathArry ""
		append	mapsPathArry ""
		append	mapsPathArry ""	
		append	mapsPathArry ""
	)
	return mapsPathArry
	),
	

--->>  替换成 资源文件夹的 贴图 路径  

function getPathFromMapName n=
(
	local namePart=filterString n "_"
	-- dsc_jztj_cs0020_3d_wb.tga
	--dsc_jztj_cs0020_3d_a_wb.tga
	local path=(mfDIR+"tw2/res/scene/common/")
	local tw1=""
	local tw2=""
	local count=0
	charOn=True
	for i=1 to n.count do(
		if n[i]=="_" do  count+=1
		if n[i]<"z" and n[i]>"a" do charOn=false
		if count>=1 and count<2 do 	tw1+=n[i]
		if count>=2 and count<3 do  tw2+=n[i]
	)
	
	
	if count!=0 then
	(
		tw1=fengx.getLetter(tw1)
		tw2=fengx.getLetter(tw2)
		
		if tw1[1]=="j" and tw1.count>3 then(
			path=path+tw1[1]+tw1[2]+"/"+tw1+"/"+tw1[3]+tw1[4]+tw2+"/"
		)else(
			if tw1.count>2 do path=path+tw1[1]+tw1[2]+"/"+tw1+"/"
		)
		b=getFiles(path+"*")
		)else (
			if charOn==True then path=(mfDIR+"tw2/res/char/"+n+"/texture/") else   path=(mfDIR+"tw2/res/scene/")
		
		)
	path=fengx.beStringPath path
	return path


),
function mapChangeToResource mapPath=
 (
 	local mapRPath=mapPath
	local Rdir=(mfDIR+"tw2\\res\\scene\\common\\")
	local dirs=#("wj\\wjdx\\","wj\\wjgy\\","wj\\wjjy\\","wj\\wjwy\\" ,"zw\\zwgm\\","zw\\zwhc\\","zw\\zwshu\\","zw\\zwts\\","jz\\jzsj\\sjcs\\","jz\\jzsj\\sjyw\\","jz\\jztj\\tjcs\\","jz\\jztj\\tjyw\\","db\\dbcd\\","db\\dblm\\","db\\dbsk\\","db\\dbst\\")
	
	
	mapRPath= fengx.getNamePath (getFilenameFile mapRPath) + filenameFromPath mapRPath
	--print ("change"+mapRPath)
	if doesFileExist mapRPath ==false do 
	(	
		
		if mapPath!=undefined and mapPath !="" do
		(
			mapName=filenameFromPath mapPath
			for d in dirs do 
			(
				tempDir=Rdir+d+mapName
				if  doesFileExist tempDir do
				(
					 mapRPath=tempDir
					 print  (mapPath+"贴图所在的地址可能有误")
					)
			)
		)
	)
 	return mapRPath
 ),
function findMapDir n=
(
	--dir=n
	dir=maxFilePath+"\\map\\1\\"+n
	return dir 
	),	
 
	
	
----------the miss map need time to fix  	
function findMap mates=
(
	local l=localtime + "\n <findMap mates> "
	if mates!=undefined do
	(
		for m in mates do
		(
			local newMapDir=""
			
			
			
			if backMapType[1]==1 do 
			(
				mapON=True
				Dname=""
				try Dname=(filenameFromPath m.diffusemap.filename )catch 
				(
					l+=localtime +"\n no diffuse"
					mapOn=False
					)
				if mapOn==True and Dname!=""do 
				(
					
					tDir=fengx.findMapDir Dname
					if tDir!=Nname do(
						m.diffusemap.filename=tDir
						newMapdir=getFilenamePath tDir
						)
						)
					
				)
				
			--opacity need time to fix 
			/*
			if backMapType[4]==1 do (
				m.opacityMap = Bitmaptexture fileName:newPath 
				m.opacityMap.monoOutput = 1
			)		
			*/
				
				
			if  backMapType[2]==1 and m.bumpmap!=undefined do
			( 
				mapON=True
				try m.bumpmap.normal_map.filename catch mapON=False
				if mapON==True and m.bumpmap.normal_map.filename!=""do
				(
					local Nname=m.bumpmap.normal_map.filename
						if (doesFileExist (newMapDir+filenameFromPath Nname))==True and newMapDir!="" then m.bumpmap.normal_map.filename=newMapDir+filenameFromPath Nname else
							(
								tDir=fengx.findMapDir Nname
								if tDir!=Nname do
								(
									m.bumpmap.normal_map.filename=tDir
									newMapdir=getFilenamePath tDir
									)
								)
						)
					)					
				
					
			if  backMapType[3]==1 and m.specularLevelMap!=undefined do
			( 
				local mapON=True
				try m.specularLevelMap.filename catch mapON=False
				if mapON==True and m.specularLevelMap.filename!=""do
				(
					local Nname=filenameFromPath m.specularLevelMap.filename
						if (doesFileExist (newMapDir+filenameFromPath Nname))==True and newMapDir!="" then m.specularLevelMap.filename=newMapDir+filenameFromPath Nname else
							(
								tDir=fengx.findMapDir Nname
								if tDir!=Nname do
								(
									m.specularLevelMap.filename=tDir
									newMapdir=getFilenamePath tDir
									)
								)
						)
					)					
			--if backMapType[5]==1 and doesFileExist  allMaps[4] do m.selfillumMap = Bitmaptexture fileName:allMaps[4]
			
			)
		)		
	),
	
function  findMapResource nodes=
(
	if nodes!=defined do
	(
	 mates=fengx.toStandardMate nodes.material
	 for m in mates do 
	 (
		-->>diffuse
		mapOn=true
		try m.diffusemap.filename catch mapOn=false
		if mapOn==true do
		(
			newPath=fengx.mapChangeToResource m.diffusemap.filename 
			allMaps=fengx.dToDNS  newPath
			if doesFileExist newPath do
				
				if backMapType[1]==1 do m.diffusemap =  Bitmaptexture fileName: newPath
				namePart= filterString  newPath "_"
				if backMapType[4]==1 and namePart.count>2 and  namePart[(namePart.count-1)]=="a" do (
					m.opacityMap = Bitmaptexture fileName:newPath 
					m.opacityMap.monoOutput = 1
				)		
				if  backMapType[2]==1 and doesFileExist  allMaps[2]  do
				( 
				 	m.bumpMap = Normal_Bump ()
					m.bumpMap.normal_map=Bitmaptexture fileName:allMaps[2]
					m.bumpMapAmount = 100
					)
				if backMapType[3]==1 and doesFileExist  allMaps[3] do m.specularLevelMap = Bitmaptexture fileName:allMaps[3]
				 
				if backMapType[5]==1 and doesFileExist  allMaps[4] do m.selfillumMap = Bitmaptexture fileName:allMaps[4]
				 )
				 ）
		)
	)
),

---->> <only for netease> change <select>'s name to diffuse name 
function  TexNameToMateName=
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
			try meditMaterials[medit.GetActiveMtlSlot()]= sm.material catch()--sceneMaterials[sm.material.name] 
            )
        )
    )
),

function namedMate mate s=
( 
	if classOf(mate)==Standardmaterial do
	(
	  try (
		 mate.name=getFilenameFile mate.DiffuseMap.filename 
		 print  ("      "+ mate.name+"       ") 
		) catch  ()--print "  找不到diffuse ！名字自己改吧！"--messagebox   (s+"的Diffuse贴的不是图吧！！！ 这个材质无法命名！")   title:" 擦擦擦擦擦！ "
	)
),
------------------------------------------------>> <only for netease> 
------------------------------------------------>> <only for netease> 
------------------------------------------------>> <only for netease> 


---->> <useless function>
---->> <useless function>
---->> <useless function>
function openTexFile m=
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


-------------------------matelrial tool----------------------
-------------------------UV tool-----------------------------
function lllllllllllllllllllllllllllllllllllllllllllllllleditUVFn=(),
function alignU=
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
function sendToUVlayout setMode =
(
	if uvlayoutPath!=undeifend and doesFileExist uvlayoutPath ==true and getFilenameFile uvlayoutPath == "claunch-uvlayout"  then
	(
		makedir (getFilenamePath uvSendPath )
		
		try exportFile uvSendPath   #noPrompt  selectedOnly:true catch print "fath to export file "
		tempCopyPath=getFilenamePath uvSendPath    +  getFilenameFile uvSendPath   +"01.obj"
		deleteFile tempCopyPath
		--uvLayoutMeshMode ="Poly"
		--uvLayoutUVMode = "Edit"
		
		if setMode==undefined and setMode=="" do setMode " -plugin,Poly,Edit,  "
		shelllaunch  uvlayoutPath (setMode  + uvSendPath  )
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
function getFromUvlayout =
(
	
	tempPath=getFilenamePath uvSendPath  + getFilenameFile uvSendPath   +".out"
	tempCopyPath=getFilenamePath uvSendPath    +  getFilenameFile uvSendPath   +"01.obj"
	deleteFile tempCopyPath
	copyfile tempPath  tempCopyPath
	importFile tempCopyPath  #noPrompt 
	
),


function alignV=
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
function lllllllllllllllllllllllllllllllllllllllllllllllleditModelFn=(),
-------------------------edit model--------------------------
--将选中的模型导出Obj 在导入 借此来重置下
function showInfor=(
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

function resetModel =
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
				try $.pivot=yuModel.pivot catch "x"
			)
			delete(yuModel)
		)
	)
)
)
),

function matrixObject n=
(
ax=#()
ay=#()
for s in n do 
(	
	vx=(s.max.x-s.min.x)
	vy=(s.max.y-s.min.y)
	
	append ax vx
	append ay vy
)

t=sqrt n.count
x=int t
y=int n.count/x
x+=1
--y+=1
maxX=(amax ax)*1.08
maxY=(amax ay)*1.08
nom=0
for ix=1 to (x+1) do 
	(
		for iy=1 to (y+1) do
		(
			try n[((ix-1)*x+iy)].pos=[(ix-1)*maxX,(iy-1)*maxY,0] catch ()
		)
	)
),

function matrixSort =
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
function setpos n=
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
function selectGroupDummy select=
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
-------------------------edit model---------------------------



function smartColneD message intRay obj faceNumber shift ctrl alt =
(
	 
	returnValue = case message of
	(
	 	#freeMove:  (#continue)
		
		#mouseAbort: (undefined)
		
		#mousePoint:
		(
		 	if ($!=undefined and obj != undefined) and (intRay != undefined) do
			(
				for s in $ do 
				(
					try s.pos=(intRay.pos) catch()
					try s.dir=intRay.dir	catch()
				)
			)
			#continue
		)
		
		#mouseMove: (#continue)
	)
	returnValue
),

function smartColneP message intRay obj faceNumber shift ctrl alt =
(
	 
	returnValue = case message of
	(
	 	#freeMove:  (#continue)
		
		#mouseAbort: (undefined)
		
		#mousePoint:
		(
		 	if (obj != undefined) and (intRay != undefined) do
			(
				for s in $ do 
				(
					try s.pos=(intRay.pos) catch()
					--try s.dir=intRay.dir	catch()
				)
			)
			#continue
		)
		
		#mouseMove: (#continue)
	)
	returnValue
),









function llllllllllllllllllllllllllllllllllllllllllllllllcreateObjectFn=(),
-------------------------create model-------------------------

function createBox=
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
function createCylinder=
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
function createSphere=
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
function createPlane=
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
function stdMen=(
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
function randomColor=
(
    a=undefined
    r=(random 0 225)
    g=(random 0 225)
    b=(random 0 225)
    a=color   r g b 0
    return a
),

function createBoxGizmo=
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

function drawLine pointA pointB lineColor =
(
    ss = SplineShape pos:pointA
    addNewSpline ss
    addKnot ss 1 #corner #line PointA
    addKnot ss 1 #corner #line PointB
    updateShape ss
    ss.wirecolor=lineColor
    return ss

),

function dirToPath dir1=
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
function maxminf n=
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
--显示物体名字
function showname=
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
function showObjectNames=
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
function saveMateMapTo mates targetPath=
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
	

function getRowDir n=
(
	if classOf(n)==Point3 do 
	(
		local dir=[1,1]
		local count=0
		local allV=#(abs(n.x),abs(n.y),abs(n.z))
		local maxV=0
		for i=1 to 3 do
		(
		if  allV[i] > maxV do
		(
			maxV=allV[i] 
			count=i
			)
		)	
		dir[1]=count
		if n[count]<0 then dir[2]=-1 else dir[2]=1
		return dir
	)
	
),
function getViewDir dir=
(
	local rDir=#(1,1)
	if dir!=undefined and dir!=""then
	(
		local vieM=Inverse(getViewTM())
		
		local leftStr=#("L","l","left","Left","LEFT")
		local RightStr=#("R","r","right","Right","RIGHT")
		local UpStr=#("U","u","up","Up","UP")
		local DownStr=#("D","d","down","Down","DOWN")
		local ForwardStr=#("F","f","forward","Forward","FORWARD")
		local BackStr=#("B","b","back","Back","BACK")
		
		if findItem LeftStr dir !=0 or findItem RightStr dir !=0  do rDir=fengx.getRowDir vieM.row1
		--if findItem RightStr dir  do()
		if findItem UpStr dir !=0 or findItem DownStr dir !=0  do rDir=fengx.getRowDir vieM.row2
		--if findItem DownStr dir  do()
		if findItem ForwardStr dir !=0  or findItem backStr dir !=0 do rDir=fengx.getRowDir vieM.row3
		--if findItem backStr dir  do()

	)else print "调用的方向 字符 写错了"
	return rDir 
	
),

function smartRotate n=
(
	if $!=undefined do
	(
	direction=[0,0,0]
	direction[(fengx.getViewDir("Forward"))[1]]=(fengx.getViewDir("Forward"))[2]
	--print smartRotateLW
		
	if smartRotateLW=="W" then
	(
		
		--print "world"
		rotate $ (angleaxis n direction)
	)else 
	(
		if smartRotateLW=="L" do 
		(
			for s in $ do  rotate s (angleaxis n direction)
			--print "local"
		)
	)
	--rotate $ (angleaxis n direction)
	)
),

function importMap=
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
function importMaxs =
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


function llllllllllllllllllllllllllllllllllllllllllllllllfileFn=(),
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
			 append mapsPath (mfDIR+"tw2/res/"+lineParts[3])
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
	local log=localTime+"__start.........."
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
			 log+=localTime+"__\n....."+map +" was not be saved....."
			 copySOn=false
			 )
		 )else(
			log+=localTime+"__\n  ------  "+map +"     > map does not exist ....."
			copySOn=false
			)
	if copySOn==true do log+=localTime+"__\n  ------  "+map +"     > map was copyed success....."
	)
	--return log
	--print localtime
	print log


),
function ToVisualPath targetPath=
(
	--local son=true
	local rPath=""
	name = (getFilenameFile	targetPath) + ".visual"
	tempPathPart = getFilenamePath targetPath
	
	if tempPathPart[1]=="/" or tempPathPart[1]== "\\" do tempPathPart =substring tempPathPart 2 tempPathPart.count 
	if tempPathPart[1]=="e" or tempPathPart[1]=="E" then () else tempPathPart=mfDIR+"tw2/res/"+ tempPathPart
	rPath=tempPathPart+name
	rPath=fengx.beStringPath rPath
	--if (doesFileExist rPath)==true then print "Visal file is Exist" else print "Visal file does not Exist" 
	return rPath
	)
)
