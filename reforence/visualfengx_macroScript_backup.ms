macroScript lllllllllllllllllllllllllllllllllllllsystemTool
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"systemTool"
buttontext:"systemTool"
(
	print "nothing"	
)


macroScript ambientWhite
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"ambientWhite"
buttontext:"ambientWhite"
(
	fengx.fixAmbientColor "+"
	gw.updateScreen()
	print ambientColor 
)

macroScript ambientBlack
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"ambientBlack"
buttontext:"ambientBlack"
(
	fengx.fixAmbientColor "-"	
	gw.updateScreen()
	print ambientColor 
)
--------------------system tool-------------------------
macroScript Setting
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"setting"
buttontext:"setting"
(
	actionMan.executeAction 0 "59226"
)

macroScript reStart
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"restart"
buttontext:"restart"
(
	fengx.restart()	
)
macroScript quitmax
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"quitmax"
buttontext:"quitmax"
(
	if checkForSave() do
	(
	quitmax #noPrompt	
	)
)




macroScript llllllllllllllllllllllllllllllllllllleditFile
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"editFile"
buttontext:"editFile"
(
	print "nothing"	
)
--------------------edit file---------------------------
macroScript saveSelect
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"saveSelect"
buttontext:"saveSelect"
(
	--if $ !=undefined do fengx.saveNodeToMax($)
	if $ !=undefined do fengx.backupMax($)
)


macroScript mainWindow 
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"mainWindow "
buttontext:"mainWindow "
(
	if mainwindow.open==true then (
		rollouts=#(poly,mate,file,snap)
		for r in rolloutS do
		( 
			if r.open==true do destroyDialog r
			)
		destroyDialog mainwindow
	)else(
		if mainSize.x*mainSize.y==0 do mainSize=[140,693]
		createdialog mainWindow mainSize.x mainSize.y pos:mainPos  style:#(#style_minimizebox,#style_resizing,#style_titlebar,#style_border, #style_sysmenu,#style_toolwindow) 
		fengx.updataLanguage()
		mainwindow.windowsLogicStart()
	)
)


macroScript copyPasteWindow
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"copyPasteWindow"
buttontext:"copyPasteWindow"
(
	if copyPaste.open==true then destroyDialog copyPaste else(
	if copyPasteSize.x*copyPasteSize.y==0 do copyPasteSize=[1312, 121]
	createdialog copyPaste copyPasteSize.x copyPasteSize.y pos: copyPastePos   style:#(#style_sunkenedge,#style_minimizebox,#style_resizing,#style_titlebar, #style_border, #style_sysmenu) 
	fengx.updataLanguage()
	)
	
)

macroScript fileWindow
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"fileWindow"
buttontext:"fileWindow"
(
	if file.open==true then destroyDialog file else(
	if fileSize.x*fileSize.y==0 do fileSize=[127, 203]
	createdialog file fileSize.x fileSize.y pos: filePosx   style:#(#style_sunkenedge,#style_minimizebox,#style_resizing, #style_border,#style_titlebar, #style_border, #style_sysmenu,#style_toolwindow)
	fengx.updataLanguage()
	)
	--theVoice.Speak "�ǺǺǺ�"
)

macroScript ployWindow
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"ployWindow"
buttontext:"ployWindow"
(
	if poly.open==true then destroyDialog poly else(
	if polySize.x*polySize.y==0 do polySize=[127 , 480]
	createdialog poly polySize.x polySize.y pos: polyPos  style:#(#style_sunkenedge,#style_minimizebox,#style_resizing, #style_border,#style_titlebar, #style_border, #style_sysmenu,#style_toolwindow) --
	fengx.updataLanguage()
	)
)

macroScript mateWindow
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"mateWindow"
buttontext:"mateWindow"
(
	if mate.open==true then destroyDialog mate else(
	if mateSize.x*mateSize.y==0 do mateSize=[128,323]
	createdialog mate mateSize.x mateSize.y pos:matePos  style:#(#style_sunkenedge,#style_maximizebox,#style_minimizebox,#style_resizing, #style_border,#style_titlebar, #style_border, #style_sysmenu,#style_toolwindow)-- bgcolor: bgColor
	fengx.updataLanguage()
	--theVoice.Speak "�Ǻ� ����������������"
	)
)

macroScript snapWindow
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"snapWindow"
buttontext:"snapWindow"
(
	on isEnabled return  selection.count > 0
	on Execute do(
	if snap.open==true then destroyDialog snap else(
	if snapSize.x*snapSize.y==0 do snapSize=[127, 425]
	createDialog snap snapSize.x snapSize.y pos:snapPos  style:#(#style_sunkenedge,#style_maximizebox,#style_minimizebox,#style_resizing, #style_border,#style_titlebar, #style_border, #style_sysmenu,#style_toolwindow) 
	fengx.updataLanguage()
	)
)
)

macroScript exportSelect
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"exportSelect"
buttontext:"exportSelect"
(
	if $ !=undefined do fengx.exportSelectToOBJ()

)


macroScript resetModel
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"resetModel"
buttontext:"resetModel"
(
	fengx.resetModel()
)
macroScript showMaxFile
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"showMaxFile"
buttontext:"showMaxFile"
(	--actionMan.executeAction -841213575 "1"
	     if (getfiles (maxfilepath+maxfilename)).count != 0 then(
	    filePath="/select,"+maxfilepath+maxfilename
	    try  ShellLaunch "explorer.exe" filePath   catch messageBox("Ӳ��û�򿪣�") title:"������������������"
	)else messageBox ("��û���أ�")
	)

macroScript exportToVisual
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"exportToVisual"
buttontext:"exportToVisual"
(
	if $ !=undefined do fengx.exportSelectToVisual()
)

--------------------edit file---------------------------

--------------------system tool-------------------------
macroScript lllllllllllllllllllllllllllllllllllllcreateSomething
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"createSomething"
buttontext:"createSomething"
(
	print "nothing"	
)
--------------------create something--------------------
macroScript createMyBox
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"createMyBox"
buttontext:"createMyBox"
(
	undo on(
	fengx.createBox()	
	)
	
)
macroScript createCylinder
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"createCylinder"
buttontext:"createCylinder"
(
	undo on(
	fengx.createCylinder()	
	)
)
macroScript createSphere
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"createSphere"
buttontext:"createSphere"
(
	undo on(
	fengx.createSphere()	
	)
)
macroScript createPlane
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"createPlane"
buttontext:"createPlane"
(
	undo on(
	fengx.createPlane()	
	)
)

macroScript createStandMen
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"createStandMen"
buttontext:"createStandMen"
(
	undo on(
	fengx.Stdmen()	
	)
)
--------------------create something--------------------
macroScript llllllllllllllllllllllllllllllllllllleditModel
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"editModel"
buttontext:"editModel"
(
	print "nothing"	
)
--------------------edit model--------------------------
--------------------edit model--------------------------
macroScript autosmooth 
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"autosmooth "
buttontext:"autosmooth "
(
	try $.EditablePoly.autosmooth () catch print "autosmooth fath!"
)

macroScript smartCloneD
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"smartCloneD"
buttontext:"smartCloneD"
(
	if $ !=undefined do 
	(
		if PGround !=undefined do mousetrack on:PGround prompt:"Tracking" trackCallback:smartColne
	)
)

macroScript smartCloneP
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"smartCloneP"
buttontext:"smartCloneP"
(
	if $ !=undefined do 
	(
		if PGround !=undefined do mousetrack on:PGround prompt:"Tracking" trackCallback:smartColne
	)
)

macroScript convertToPoly
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"convertToPoly"
buttontext:"convertToPoly"
(
	if $ !=undefined do 
	(
		macros.run "Modifier Stack" "Convert_to_Poly"
	)
)
macroScript cloneObject
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"cloneObject"
buttontext:"cloneObject"
(
	if $!=undfined do
	(
	 	
		a = copy $
		--select a 
		--try a.count catch (select a )
		)
)
macroScript instanceOBJ
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"instanceOBJ"
buttontext:"instanceOBJ"
(
	if $!=undfined do maxOps.cloneNodes $  cloneType:#instance
)
macroScript subobjectLevel
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"subobjectLevel"
buttontext:"subobjectLevel"
(
	subobjectLevel = 0	
)

macroScript bigGroup
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"bigGroup"
buttontext:"bigGroup"
(
	fengx.createBoxGizmo()
)
macroScript Povitbot
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"Povitbot"
buttontext:"Povitbot"
(	
	undo on(
	if $==undefined then
	(
		)else
		(
			for s in fengx.selectGroupDummy($) do 
			if classOf(s)==Dummy then
			(
				s.pivot.x=0
				s.pivot.y=0
				s.pivot.z=0
				)else
				(
					s.pivot.x=0
					s.pivot.y=0
					s.pivot.z=0
					)
				)
		)
)
macroScript botPovit
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"botPovit"
buttontext:"botPovit"
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
macroScript centerPovit
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"centerPovit"
buttontext:"centerPovit"
(	
	undo on(
	if $!=undefined do 
	(
		for s in fengx.selectGroupDummy($) do 
		CenterPivot s
		)
	)
)
macroScript resetPos
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"resetPos"
buttontext:"resetPos"
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
macroScript speedScaleBig
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"speedScaleBig"
buttontext:"speedScaleBig"
(
	undo on(
	if $!=undefind do (
		scale (fengx.selectGroupDummy($)) [2,2,2]
	)
	)
)
macroScript speedScaleSmall
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"speedScaleSmall"
buttontext:"speedScaleSmall"
(
	undo on(
	if $!=undefind do (
		scale (fengx.selectGroupDummy($)) [0.5,0.5,0.5]
	)
	)
)
macroScript groupOpen
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"groupOpen"
buttontext:"groupOpen"
(
	undo on(
	if $!=undefind do (
		max group open
		)
	)
)
macroScript groupClose
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"groupClose"
buttontext:"groupClose"
(
	undo on(
	if $!=undefind do (
		max group close
		)
	)
)
global copyObj=undefined
macroScript copyObject
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"copyObject"
buttontext:"copyObject"
(	
	thecopypastedir = getdir #Scripts 
	thecopypastefile = fengx.changePath  "/visualFengx/copyPaste.max" 
	thecopypastestring = thecopypastedir + thecopypastefile 
	if $ != undefined do(
		try (
		  saveNodes $ thecopypastestring
		  print "���Ƴɹ�"
            )  catch print "����ʧ��"
    )
)
macroScript pasteObject
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"pasteObject"
buttontext:"pasteObject"
(
	thecopypastedir = getdir #Scripts
	thecopypastefile = fengx.changePath  "/visualFengx/copyPaste.max" 
	thecopypastestring = thecopypastedir + thecopypastefile 
	mergemaxfile (thecopypastedir + thecopypastefile) #select 
)

macroScript smartRotationL
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"smartRotationL"
buttontext:"smartRotationL"
(
on isEnabled return (selection.count == 1)
on execute do
	(
	if keyboard.shiftpressed then fengx.smartRotate 30
	else fengx.smartRotate 90
	)
)

macroScript smartRotationR
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"smartRotationR"
buttontext:"smartRotationR"
(
on isEnabled return (selection.count == 1)
on execute do
	(
	if keyboard.shiftpressed then fengx.smartRotate -30
	else fengx.smartRotate -90
	)
)



macroScript clearSelection
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"clearSelection"
buttontext:"clearSelection"
(
	clearSelection()
)

--------------------edit UV--------------------------
macroScript llllllllllllllllllllllllllllllllllllleditUV
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"editUV"
buttontext:"editUV"
(
	print "nothing"	
)

macroScript alignU
category:"visualfengx_1.1"
--InternalCategory:"Unwrap UVW" 
--icon:#("MAXScript",1)
tooltip:"alignU"
buttontext:"alignU"
( 
 fengx.alignU()
)

macroScript alignV
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"alignV"
buttontext:"alignV"
( 
 fengx.alignV()
)




macroScript preserveUV
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"preserveUV"
buttontext:"preserveUV"
( 
try(
    if $.preserveUVs ==on then $.preserveUVs = off else $.preserveUVs = on
)catch(print "preserveUVs  falth!")
)

macroScript editUV
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"editUV"
buttontext:"editUV"
(
undo on(
        if $!=undefined do 
        (    
		try $.count catch(
			try $.modifiers[#unwrap_uvw].unwrap.edit () catch
                (
                macros.run "Modifiers" "Unwrap_UVW"
			  --createdialog unwrapholder --test
			  $.modifiers[#unwrap_uvw].unwrap2.setIgnoreBackFaceCull off
                $.modifiers[#unwrap_uvw].unwrap.edit ()
                $.modifiers[#unwrap_uvw].unwrap.setCurrentMap 2
			  $.modifiers[#unwrap_uvw].unwrap.DisplayMap on
			  $.modifiers[#unwrap_uvw].unwrap.fitselected ()
			  subobjectLevel = 3
			  
                )
			)
			) 
		--createDialog uv
		 )
)
macroScript HorizontalUV
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"HorizontalUV"
buttontext:"HorizontalUV"
(
undo on(
  	--$.modifiers[#unwrap_uvw].unwrap2.ScaleSelectedXY 1 -1 [0.5,0.5,0]
	$.modifiers[#unwrap_uvw].unwrap.mirrorh ()        
  )          
)

macroScript alignU
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"alignU"
buttontext:"alignU"
(
	)
macroScript VerticalUV
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"VerticalUV"
buttontext:"VerticalUV"
(
undo on(
  	--$.modifiers[#unwrap_uvw].unwrap2.ScaleSelectedXY -1 1 [0.5,0.5,0]
     $.modifiers[#unwrap_uvw].unwrap.mirrorv ()
		  )          
)

--------------------edit UV--------------------------

--------------------edit Mate--------------------------
macroScript llllllllllllllllllllllllllllllllllllleditMate
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"editMate"
buttontext:"editMate"
(
	print "nothing"	
)

macroScript clearMate 
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"clearMate"
buttontext:"clearMate"
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
		 	try ls[i]=scenematerials[i] catch print" clearMate ��֪��������ʲô���⣡"
          	)
		)
		if classof(scenematerials[i])==MultiMaterial  do 
		(
			try ls[i]=scenematerials[i] catch print" clearMate ��֪��������ʲô���⣡"

		  --if scenematerials[i].name!="Standardmaterial" and  scenematerials[i].DiffuseMap!=undefined do
		  --(
		 	--try ls[i]=scenematerials[i] catch print" clearMate ��֪��������ʲô���⣡"
          	--)
		)

	 )
   )        
)
macroScript clearEditMate 
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"clearEditMate"
buttontext:"clearEditMate"
(
  undo on(
	 macros.run "Medit Tools" "clear_medit_slots"
        )        
)

macroScript clearSenceMate 
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"clearSenceMate"
buttontext:"clearSenceMate"
(
  undo on(
	 macros.run "Medit Tools" "clear_medit_slots"
	 for s in scenematerials do 
      (
         try s=standmaterial catch print" clearSenceMate ��֪��������ʲô���⣡"
        )        
)
)
macroScript DXoff 
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"DXoff"
buttontext:"DXoff"
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

macroScript DXon 
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"DXon"
buttontext:"DXon"
(
  undo on(
		  if $!=undefined do (
			for s in fengx.toStandardMate($.material)do(
				try s.DirectX_Manager.dxStdMat = on catch print s.name + " is not have DirectX_Manager!"
			)
		)
    )        
)

--------------------edit Mate--------------------------
--------------------reset material----------------------
macroScript resetMate
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"resetMate"
buttontext:"resetMate"
(
	undo on(
	if $ != undefined do 
	(
		for s in $ do 
		(
			s.material=Standardmaterial ()
			s.wirecolor = black
		)
	  )
    )
)

macroScript mateToStandardName
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"mateToStandardName"
buttontext:"mateToStandardName"
(
	fengx.TexNameToMateName()

)
--����ѡ���ʵ���ͼ�ļ���
macroScript openMateMapFolder
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"openMateMapFolder"
buttontext:"openMateMapFolder"
(
	if $!=undefined do
	(
	 for sm in $ do
        (    
            if classOf(sm.Material)==Standardmaterial do
            (
				fengx.openTexFolder  sm.Material
				)	
				if classOf(sm.Material)==MultiMaterial do
			(
				for s in sm.Material do 
				(
					fengx.openTexFolder  s
					)
				)
		)
	)

)
--����ѡ���ʵ���ͼ�ļ���
macroScript showMapInExplorer
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"showMapInExplorer"
buttontext:"showMapInExplorer"
(
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

)
--����Ϊѡ��������ͼ
macroScript saveMapTo
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"saveMapTo"
buttontext:"saveMapTo"
(
	fengx.saveObjectMapto()	

)
--------------------reset material----------------------
macroScript llllllllllllllllllllllllllllllllllllljustTest
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"justTest"
buttontext:"justTest"
(
	print "justTest"	
)
macroScript SnapSurface
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"SnapSurface"
buttontext:"SnapSurface"
(
	fn g_filter o = superclassof o == Geometryclass	
	target_mesh = pickObject message:"Pick Target Surface:" filter:g_filter
	PGround= target_mesh 
	--PGround.wirecolor = red
)
macroScript snapToSurfaceD
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"snapToSurfaceD"
buttontext:"snapToSurfaceD"
(
undo on(
if PGround !=undefined do
(
 mousetrack on:PGround prompt:"Tracking" trackCallback:fengx.smartColneD()
)
)
)

macroScript snapToSurfaceP
category:"visualfengx_1.1"
--icon:#("MAXScript",1)
tooltip:"snapToSurfaceP"
buttontext:"snapToSurfaceP"
(
undo on(
if PGround !=undefined do
(
 mousetrack on:PGround prompt:"Tracking" trackCallback:fengx.smartColneP()
)
)
)