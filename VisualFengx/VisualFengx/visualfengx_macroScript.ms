macroScript lllllllllllllllllllllllllllllllllllllsystemTool
category:"visualfengx_help"
--icon:#("MAXScript",1)
tooltip:"systemTool"
buttontext:"systemTool"
(
	print "nothing"	
)


macroScript ambientWhite category:"visualFengx" tooltip:"ambientWhite" buttontext:"ambientWhite"
(
	fengx.fixAmbientColor "+"
	gw.updateScreen()
	print ambientColor 
)

macroScript ambientBlack category:"visualFengx" tooltip:"ambientBlack" buttontext:"ambientBlack"
(
	fengx.fixAmbientColor "-"	
	gw.updateScreen()
	print ambientColor 
)
--------------------system tool-------------------------

macroScript reStart category:"visualFengx" tooltip:"restart" buttontext:"restart"
(
	fengx.restart()	
)

macroScript quitmax category:"visualFengx" tooltip:"quitmax" buttontext:"quitmax"
(
	if checkForSave() do
	(
	quitmax #noPrompt	
	)
)


macroScript llllllllllllllllllllllllllllllllllllleditFile category:"visualfengx_help"  tooltip:"editFile" buttontext:"editFile"
(
	print "nothing"	
)

--------------------edit file---------------------------
macroScript saveSelect category:"visualFengx" tooltip:"saveSelect" buttontext:"saveSelect"
(
	if $ !=undefined do fengx.saveToMax($)
)


macroScript mainWindow  category:"visualFengx" tooltip:"visualfengx" buttontext:"visualfengx" icon:#("VFX",1)
(
	if mainwindow.open==true then (
		rollouts=#(poly,mate,file,snap)
		for r in rolloutS do
		( 
			if r.open==true do destroyDialog r
			)
		destroyDialog mainwindow
	)else(
		if fengx.checkSVNdir()==false do fengx.setSVNDir()
		if mainSize.x*mainSize.y==0 do mainSize=[140,693]
		createdialog mainWindow mainSize.x mainSize.y pos:mainPos  style:#(#style_minimizebox,#style_resizing,#style_titlebar,#style_border, #style_sysmenu,#style_toolwindow) 
		mainwindow.windowsLogicStart()
	)
)


macroScript copyPasteWindow category:"visualFengx" tooltip:"copyPasteWindow" buttontext:"copyPasteWindow"
(
	if copyPaste.open==true then destroyDialog copyPaste else(
	if copyPasteSize.x*copyPasteSize.y==0 do copyPasteSize=[1312, 121]
	createdialog copyPaste copyPasteSize.x copyPasteSize.y pos: copyPastePos   style:#(#style_sunkenedge,#style_minimizebox,#style_resizing,#style_titlebar, #style_border, #style_sysmenu) 
	)
	
)

macroScript clipboardWindow category:"visualFengx" tooltip:"clipboard" buttontext:"clipboard"
(
	if clipboard.open==true then destroyDialog clipboard else(
	createdialog clipboard 160 112 pos: copyPastePos   style:#(#style_sunkenedge,#style_minimizebox,#style_resizing,#style_titlebar, #style_border, #style_sysmenu) 
	)
	
)
macroScript fileWindow
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"fileWindow"
buttontext:"fileWindow"
(
	if file.open==true then destroyDialog file else(
	if fileSize.x*fileSize.y==0 do fileSize=[127, 203]
	createdialog file fileSize.x fileSize.y pos: filePosx   style:#(#style_sunkenedge,#style_minimizebox,#style_resizing, #style_border,#style_titlebar, #style_border, #style_sysmenu,#style_toolwindow)
	)
	--theVoice.Speak "呵呵呵呵"
)

macroScript ployWindow
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"ployWindow"
buttontext:"ployWindow"
(
	if poly.open==true then destroyDialog poly else(
	if polySize.x*polySize.y==0 do polySize=[127 , 480]
	createdialog poly polySize.x polySize.y pos: polyPos  style:#(#style_sunkenedge,#style_minimizebox,#style_resizing, #style_border,#style_titlebar, #style_border, #style_sysmenu,#style_toolwindow) --
	)
)

macroScript mateWindow
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"mateWindow"
buttontext:"mateWindow"
(
	if mate.open==true then destroyDialog mate else(
	if mateSize.x*mateSize.y==0 do mateSize=[128,323]
	createdialog mate mateSize.x mateSize.y pos:matePos  style:#(#style_sunkenedge,#style_maximizebox,#style_minimizebox,#style_resizing, #style_border,#style_titlebar, #style_border, #style_sysmenu,#style_toolwindow)-- bgcolor: bgColor
	--theVoice.Speak "呵呵 今天天气不错啊！"
	)
)

macroScript snapWindow
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"snapWindow"
buttontext:"snapWindow"
(
	on isEnabled return  selection.count > 0
	on Execute do(
	if snap.open==true then destroyDialog snap else(
	if snapSize.x*snapSize.y==0 do snapSize=[127, 425]
	createDialog snap snapSize.x snapSize.y pos:snapPos  style:#(#style_sunkenedge,#style_maximizebox,#style_minimizebox,#style_resizing, #style_border,#style_titlebar, #style_border, #style_sysmenu,#style_toolwindow) 
	)
)
)

macroScript exportSelect
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"exportSelect"
buttontext:"exportSelect"
(
	if $ !=undefined do fengx.exportSelectToOBJ()

)


macroScript resetModel
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"resetModel"
buttontext:"resetModel"
(
	fengx.resetModel()
)
macroScript showMaxFile
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"showMaxFile"
buttontext:"showMaxFile"
(	--actionMan.executeAction -841213575 "1"
	     if (getfiles (maxfilepath+maxfilename)).count != 0 then(
	    filePath="/select,"+maxfilepath+maxfilename
	    try  ShellLaunch "explorer.exe" filePath   catch print "cant open explorer!"
	)else messageBox ("还没存呢！")
	)

macroScript exportToVisual
category:"visualFengx"
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
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"createMyBox"
buttontext:"createMyBox"
(
	undo on(
	fengx.createBox()	
	)
	
)
macroScript createCylinder
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"createCylinder"
buttontext:"createCylinder"
(
	undo on(
	fengx.createCylinder()	
	)
)
macroScript createSphere
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"createSphere"
buttontext:"createSphere"
(
	undo on(
	fengx.createSphere()	
	)
)
macroScript createPlane
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"createPlane"
buttontext:"createPlane"
(
	undo on(
	fengx.createPlane()	
	)
)

macroScript createStandMen
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"createStandMen"
buttontext:"createStandMen"
(
	undo on(
	--fengx.Stdmen()	
	tempCopyPath =getDir #scripts +"\\visualFengx\\standardMen_2m.obj"
	tpos=[0,0,0]
	undo on(
	    bpos=[0,0,0]
	    sx=10.0
	    sy=10.0
	    sz=10.0
	    if $ !=undefined then
	    (    
	        --sx=($.max.x-$.min.x)
	        --sy=($.max.y-$.min.y)
	        --sz=($.max.z-$.min.z)
	        --sx=(sx+sy)/4
	        --bx=($.max.x-$.min.x)/2+$.min.x
	        --bpy=$.max.y+sy  
		   ax=($.max.x+$.min.x)/2
		   ay=($.max.y+$.min.y)/2
	        bpos=[ax,ay,$.max.z]
	        --Cylinder smooth:on heightsegs:1 capsegs:1 sides:16 height:sz radius: sx mapcoords:on pos:bpos isSelected:on
	        	importFile tempCopyPath  #noPrompt 
			$.pos=bpos
			$.name="stardardMen_2m_01"
			$.material=Standardmaterial ()   
			max views undo 
	        )else
	        (
	        	importFile tempCopyPath  #noPrompt 
			$.pos=[0,0,0]
			$.name="stardardMen_2m_01"
			$.material=Standardmaterial () 
			max views undo 	           

	        )    
	    )

	


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

macroScript smartMoveL
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartMoveL"
buttontext:"smartMoveL"
(
undo on(
	if $!=undefined do 
	(
		maxP=$.max
		minP=$.min
		print maxP
		print minP
		for s in $ do 
			s.pos.x+=maxP.x-minP.x	
	)
)
)


macroScript autosmooth 
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"autosmooth "
buttontext:"autosmooth "
(
	try $.EditablePoly.autosmooth () catch print "autosmooth fath!"
)


macroScript convertToPoly
category:"visualFengx"
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
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"cloneObject"
buttontext:"cloneObject"
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
macroScript instanceOBJ
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"instanceOBJ"
buttontext:"instanceOBJ"
(
	if $!=undfined do maxOps.cloneNodes $  cloneType:#instance
)
macroScript subobjectLevel
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"subobjectLevel"
buttontext:"subobjectLevel"
(
	subobjectLevel = 0	
)

macroScript bigGroup
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"bigGroup"
buttontext:"bigGroup"
(
	fengx.createBoxGizmo()
)
macroScript Povitbot
category:"visualFengx"
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
category:"visualFengx"
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
category:"visualFengx"
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
category:"visualFengx"
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

macroScript resetRotate
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"resetRotate"
buttontext:"resetRotate"
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

macroScript resetScale
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"resetScale"
buttontext:"resetScale"
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

macroScript resetTransform
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"resetTransform"
buttontext:"resetTransform"
(
	undo on(
	if $==undefined then
	(
		)else
		(
			for s in fengx.selectGroupDummy($) do(
			 s.pos=[0,0,0]
			 s.rotation=(quat 0 0 0 0)
			 s.scale=[1,1,1]
			 )
			)
	)
)


macroScript speedScaleBig
category:"visualFengx"
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
category:"visualFengx"
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
category:"visualFengx"
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
category:"visualFengx"
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

macroScript copyObject category:"visualFengx" tooltip:"copyObject" buttontext:"copyObject"
(
--if clipboard.open==true then destroyDialog clipboard else(
createdialog clipboard 160 112 pos: copyPastePos 
--)

if $!=undefined do
	( 
	--if clipboard.open==true then destroyDialog clipboard else(
	--createdialog clipboard 160 112 pos: copyPastePos  -- style:#(#style_sunkenedge,#style_minimizebox,#style_resizing,#style_titlebar, #style_border, #style_sysmenu) 
	--)
	fengx.copyNodes 0 
	updateClipboardImages()
	)
)


macroScript pasteObject category:"visualFengx" tooltip:"pasteObject" buttontext:"pasteObject"
(
  fengx.pasteNodes 0
  -- destroyDialog clipboard
  
  try destroyDialog  clipboard catch()
)

-----------------------------------smart things
---------------smart Rotate
macroScript smartRotationL
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartRotationL"
buttontext:"smartRotationL"
(
undo on (
	if $!=undefined do
	(
		local n=90
		if keyboard.shiftpressed then n=-30 else n=-90
		local direction=[0,0,0]
		direction[(fengx.getViewDir("Forward"))[1]]=(fengx.getViewDir("Forward"))[2]
		rotate $ (angleaxis n direction)
	)
)	
)

macroScript smartRotationR
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartRotationR"
buttontext:"smartRotationR"
(
undo on (
	if $!=undefined do
	(
		local n=90
		if keyboard.shiftpressed then n=30 else  n=90
		local direction=[0,0,0]
		direction[(fengx.getViewDir("Forward"))[1]]=(fengx.getViewDir("Forward"))[2]
		rotate $ (angleaxis n direction)
	)
)	
)

macroScript smartRotationU
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartRotationU"
buttontext:"smartRotationU"
(
undo on (
	if $!=undefined do
	(
		local n=90
		if keyboard.shiftpressed then n=30 else  n=90
		local direction=[0,0,0]
		direction[(fengx.getViewDir("Left"))[1]]=(fengx.getViewDir("Left"))[2]
		rotate $ (angleaxis n direction)
	)
)	

)
macroScript smartRotationD
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartRotationD"
buttontext:"smartRotationD"
(
undo on (
	if $!=undefined do
	(
		local n=90
		
		if keyboard.shiftpressed then n=-30 else n=-90
		local direction=[0,0,0]
		direction[(fengx.getViewDir("Left"))[1]]=(fengx.getViewDir("Left"))[2]
		rotate $ (angleaxis n direction)
	)
)	
)

macroScript smartRotationF
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartRotationF"
buttontext:"smartRotationF"
(
undo on (
	if $!=undefined do
	(
		local n=90
		if keyboard.shiftpressed then n=-30 else  n=-90
		local direction=[0,0,0]
		direction[(fengx.getViewDir("Up"))[1]]=(fengx.getViewDir("Up"))[2]
		rotate $ (angleaxis n direction)
	)
)	
)

macroScript smartRotationB
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartRotationB"
buttontext:"smartRotationB"
(
undo on (
	if $!=undefined do
	(
		local n=90
		if keyboard.shiftpressed then n=30 else  n=90
		local direction=[0,0,0]
		direction[(fengx.getViewDir("Up"))[1]]=(fengx.getViewDir("Up"))[2]
		rotate $ (angleaxis n direction)
	)
)	
)
---------------smart Rotate

---------------smart move
macroScript smartMoveL
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartMoveL"
buttontext:"smartMoveL"
(
undo on (
	if $!=undefined do
	(
		dir=fengx.getViewDir("Left")
		for s in $ do 
		(
			if dir[1]==1 do s.pos.x+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.y+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==3 do s.pos.z+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			)
	)
)	
)
macroScript smartMoveR
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartMoveR"
buttontext:"smartMoveR"
(
undo on (
	if $!=undefined do
	(
		dir=fengx.getViewDir("Left")
		for s in $ do 
		(
			if dir[1]==1 do s.pos.x-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.y-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==3 do s.pos.z-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			)
	)
)	
)


macroScript smartMoveU
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartMoveU"
buttontext:"smartMoveU"
(
undo on (
	if $!=undefined do
	(
		dir=fengx.getViewDir("u")
		for s in $ do 
		(
			if dir[1]==1 do s.pos.x+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.y+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==3 do s.pos.z+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			)
	)
)	
)
macroScript smartMoveD
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartMoveD"
buttontext:"smartMoveD"
(
undo on (
	if $!=undefined do
	(
		dir=fengx.getViewDir("u")
		for s in $ do 
		(
			if dir[1]==1 do s.pos.x-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.y-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==3 do s.pos.z-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			)
	)
)	
)

macroScript smartMoveB
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartMoveB"
buttontext:"smartMoveB"
(
undo on (
	if $!=undefined do
	(
		dir=fengx.getViewDir("f")
		for s in $ do 
		(
			if dir[1]==1 do s.pos.x-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.y-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==3 do s.pos.z-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			)
	)
)	
)

macroScript smartMoveF
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartMoveF"
buttontext:"smartMoveF"
(
undo on (
	if $!=undefined do
	(
		dir=fengx.getViewDir("f")
		for s in $ do 
		(
			if dir[1]==1 do s.pos.x=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.y=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==3 do s.pos.z=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			)
	)
)	
)

----------------smart clone

macroScript smartCloneL
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartCloneL"
buttontext:"smartCloneL"
(
undo on (
	if $!=undefined do
	(
		dir=fengx.getViewDir("Left")
		for o in $ do 
		(
			s = copy o
			if dir[1]==1 do s.pos.x+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.y+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.z+=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			)
	)
)	
)
macroScript smartCloneR
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"smartCloneR"
buttontext:"smartCloneR"
(
undo on (
	if $!=undefined do
	(
		dir=fengx.getViewDir("Left")
		for o in $ do 
		(
			s = copy o
			if dir[1]==1 do s.pos.x-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.y-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			if dir[1]==2 do s.pos.z-=((s.max[dir[1]]-s.min[dir[1]])*dir[2])
			)
	)
)	
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
category:"visualFengx"
--InternalCategory:"Unwrap UVW" 
--icon:#("MAXScript",1)
tooltip:"alignU"
buttontext:"alignU"
( 
 fengx.alignU()
)

macroScript alignV
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"alignV"
buttontext:"alignV"
( 
 fengx.alignV()
)




macroScript preserveUV
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"preserveUV"
buttontext:"preserveUV"
( 
try(
    if $.preserveUVs ==on then $.preserveUVs = off else $.preserveUVs = on
)catch(print "preserveUVs  falth!")
)

macroScript editUV
category:"visualFengx"
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
			  try subobjectLevel = 3 catch()
			  
                )
			)
			) 
		--createDialog uv
		 )
)
macroScript HorizontalUV
category:"visualFengx"
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
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"alignU"
buttontext:"alignU"
(
	)
macroScript VerticalUV
category:"visualFengx"
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
category:"visualFengx"
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
macroScript clearEditMate 
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"clearEditMate"
buttontext:"clearEditMate"
(
  undo on(
	 macros.run "Medit Tools" "clear_medit_slots"
        )        
)

macroScript clearSenceMate 
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"clearSenceMate"
buttontext:"clearSenceMate"
(
  undo on(
	 macros.run "Medit Tools" "clear_medit_slots"
	 for s in scenematerials do 
      (
         try s=standmaterial catch print" clearSenceMate 不知道发生了什么问题！"
        )        
)
)
macroScript DXoff 
category:"visualFengx"
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
category:"visualFengx"
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
category:"visualFengx"
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
category:"visualFengx"
--icon:#("MAXScript",1)
tooltip:"mateToStandardName"
buttontext:"mateToStandardName"
(
	fengx.TexNameToMateName()

)
--打开所选材质的贴图文件夹
macroScript openMateMapFolder
category:"visualFengx"
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
--打开所选材质的贴图文件夹
macroScript showMapInExplorer
category:"visualFengx"
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
--另存为选择物体题图
macroScript saveMapTo
category:"visualFengx"
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
category:"visualFengx"
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
category:"visualFengx"
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
category:"visualFengx"
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