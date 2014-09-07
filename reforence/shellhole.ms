hole = undefined
holeDepth = -2
holeSteapness = 0.5
rimHeight = -0.1
tessellations = 0
detail = 1
smoothIts = 2
innerRim = 1.1
outerRim = 1.2*innerRim
doNoise = true
strength = [0,0,0.35]

function relaxx hole sel= 
(
	polyop.setFaceSelection hole sel
	hole.relaxHoldBoundaryPoints = true
	hole.relaxHoldOuterPoints = false
	hole.relaxAmount = 1.0
	hole.relaxIterations = 2
	hole.relax selLevel:#Face
)

function sel_random a b = 
(
	local sele = (polyop.getFaceSelection hole) as array
	local l = sele[sele.count-1]
	local ran = for p = sele[1] to l by (random a b) collect p
	polyop.setFaceSelection hole ran
	
)
function geo_edgeConnect obj sele = 
(
	for  f in sele do
	(
		edgeList = polyop.getFaceEdges obj f 
		copyList = edgeList as array
		startRandomNr = random 1 copyList.count
		endEdge = 0
					
		if startRandomNr == copyList.count then
		(
			endEdge = 2
		)
		else if startRandomNr == copyList.count-1 then
		(
			endEdge = 1
		)
		else 
		(
			endEdge = startRandomNr+2
		)
		
		polyop.setEdgeSelection obj #{copyList[startRandomNr], copyList[endEdge]}
		obj.EditablePoly.ConnectEdges()
	)
)
function sel_common a b =
(
	g=#()
	for c in a do
	(
		for d in b do
		(
			if c == d then
			(
				append g c
			)
		)
	)
	return g
)
function vertexRing verts radius pos =
(
	for ve in verts do
	(
		v = hole.verts[ve]
		ov = v.pos-pos
		p = radius/(length ov)
		v.pos = ov*p + pos
	)
)
function pushArray arr val = 
(
	tmp = #()
	for i in arr do (append tmp (i+val))
	return tmp
)
function sel_invert a b =
(
	for c = 1 to a.count do
	(
		for d = 1 to b.count do(
			if a[c] == b[d] then
			(
				deleteItem a c
			)
		)
	)
	return a
)
function createHole hole sel selFlag2 selFlag3 =
(
	verts = polyop.getVertsUsingFace hole sel
	polyop.deleteFaces hole sel
	verts = verts as Array
	polyop.setVertSelection hole verts[1]

	
	polyop.capHolesByVert hole verts[1]
	sel  = hole.faces.count
	for i=1 to tessellations do (polyop.tessellateByFace hole (sel))
	areal = polyop.getFaceArea hole sel
	outline = circle radius:((areal/pi)^0.5)  pos:(polyop.getFaceCenter hole sel) dir:(polyop.getFaceNormal hole sel)
	verts = polyop.getVertsUsingFace hole sel
	polyop.setVertSelection hole verts
	
	vertexRing verts outline.radius outline.pos 

	polyop.setFaceSelection hole sel
	polyop.bevelFaces hole (polyop.getFaceSelection hole) holeDepth holeSteapness
	hole.growSelection selLevel:#Face 

	for i = 1 to smoothIts do polyop.meshSmoothByFace hole (polyop.getFaceSelection hole)
	for i = 1 to tessellations do (polyop.tessellateByFace hole (polyop.getFaceSelection hole))
	for i = 1 to detail do geo_edgeConnect hole (polyop.getFaceSelection hole)
	 
	faceSel = polyop.getFaceSelection hole
	hole.growSelection selLevel:#Face
	tmp = polyop.getVertsUsingFace hole (polyop.getFaceSelection hole)
	hole.shrinkSelection selLevel:#Face
	holeVerts = polyop.getVertsUsingFace hole (polyop.getFaceSelection hole)
	tmp = tmp as array
	holeVerts = holeVerts as array
	outerRingVerts = sel_invert tmp holeVerts
	vertexRing outerRingVerts (innerRim*outline.radius) outline.pos 
		
	hole.growSelection selLevel:#Face
	tmp2 = polyop.getVertsUsingFace hole (polyop.getFaceSelection hole)
	hole.growSelection selLevel:#Face
	tmp1 = polyop.getVertsUsingFace hole (polyop.getFaceSelection hole)
	hole.shrinkSelection selLevel:#Face
	tmp1 = tmp1 as array
	tmp2 = tmp2 as array
	outerRingVerts = sel_invert tmp1 tmp2

	vertexRing outerRingVerts (outerRim*outline.radius) outline.pos 
	
	hole.relaxHoldBoundaryPoints = true
	hole.relaxHoldOuterPoints = false
	hole.relaxAmount = 1.0
	hole.relaxIterations = 1
	hole.relax selLevel:#Face
		
	sel1 = polyop.getFaceSelection hole
	sel4 = sel1 as array
	polyop.setFaceSelection hole -(sel1)
	hole.growSelection selLevel:#Face
	sel2 = polyop.getFaceSelection hole
	sel3 = sel_common sel2 sel1
	polyop.setFaceSelection hole sel3
	if rimHeight > 0 then polyop.bevelFaces hole (polyop.getFaceSelection hole) rimHeight (log ((-rimHeight/2)+0))
	else if rimHeight < 0 then polyop.extrudeFaces hole sel1 rimHeight
	
	polyop.setFaceSelection hole sel1
	hole.growSelection selLevel:#Face
	sel_random 1 5
	polyop.setFaceFlags hole (polyop.getFaceSelection hole) selFlag3
	
	polyop.setFaceSelection hole sel1
	
	for i = 1 to (smoothIts+1) do
	(
		hole.growSelection selLevel:#Face
	)
	polyop.setFaceFlags hole (polyop.getFaceSelection hole) selFlag2
)
function main hole =
(
	
	holeSel = (polyop.getFaceSelection hole) as array
	nbHoles = holeSel.count
	
	selFlag = bit.set 0 30 true
	selFlag2 = bit.set 0 31 true
	selFlag3 = bit.set 0 32 true
	
	polyop.setFaceFlags hole (polyop.getFaceSelection hole) selFlag
	
	start = timeStamp()
	for i=1 to nbHoles do 
	(
		holeSel = (polyop.getFacesByFlag hole selFlag) as array
		sel = holeSel[1]
		
		createHole hole sel selFlag2 selFlag3
		deleteItem holeSel 1
	)
	
	noiseSel = polyop.getFacesByFlag hole selFlag3
	polyop.setFaceSelection hole noiseSel
	
	if doNoise then 
	(
		noize = noiseModifier fractal:true roughness:1.0 iterations:8 Strength:strength
		max modify mode
		select hole
		subObjectLevel = 4
		modPanel.addModToSelection noize
		convertTo hole polyMeshObject
	)

	
	faceSel = polyop.getFacesByFlag hole selFlag2
--	polyop.setFaceSelection hole faceSel
	polyop.setFaceSelection hole #all
	polyop.meshSmoothByFace hole (polyop.getFaceSelection hole)
	--relaxx hole faceSel
	end = timeStamp()
	print (nbHoles as string + " hole(s) in " + (formattedPrint ((end - start) / 1000.0) format:".1f") + "s")
	
)

function sel_filter obj = selection.count == 1 and classOf selection[1].baseobject == Editable_Poly 

try(destroyDialog mainRollout ) catch()
rollout mainRollout "ShellHole"
(
	
	label descriptionsLabel1 "Use the face-selections" align:#center
	label descriptionsLabel2 "as hole centers" align:#center
	group "Options" 
	(
		pickbutton pickButton "object: " width:80 filter:sel_filter
		spinner holeDepthSpinner "Hole depth" range:[-100,100,holeDepth] align:#Right enabled:false across:1 type:#float
		spinner holeSteapnessSpinner "Hole steapness" range:[-100,100,holeSteapness] align:#Right enabled:false across:1 type:#float
		spinner rimHeightSpinner "Rim height    " range:[-100,100,rimHeight] align:#Right enabled:false across:1 type:#float
		spinner rimSizeSpinner "Rim size" range:[-10.0,10.0,innerRim] align:#Right enabled:false  type:#float across:1
		spinner tessellationSpinner "Tessellations" range:[0,10,tessellations] align:#Right enabled:false across:1 type:#integer
		spinner detailSpinner "Details" range:[0,10,detail] align:#Right enabled:false type:#integer across:1
		label strenghtLabel "Noise strength" align:#Center
		spinner xSpinner "x" range:[0,100,strength.x] enabled:false align:#Right across:1 width:50
		spinner ySpinner "y" range:[0,100,strength.y] enabled:false align:#Right width:50 across:1
		spinner zSpinner "z" range:[0,100,strength.z] enabled:false align:#Right width:50 across:1
		spinner smoothSpinner "Smooths" range:[0,10,2] align:#Right enabled:false across:1 type:#integer
	)
	button goButton "Go!" width:160 enabled:false align:#Center
	label aboutLabel "havardsc@stud.ntnu.no" align:#center
	


	on pickButton picked obj do
	(
		hole = obj
		pickButton.text = hole.name
		
		holeDepthSpinner.enabled = true
		holeSteapnessSpinner.enabled = true
		rimHeightSpinner.enabled = true
		rimSizeSpinner.enabled = true
		tessellationSpinner.enabled = true
		detailSpinner.enabled = true
		xSpinner.enabled = true
		ySpinner.enabled = true
		zSpinner.enabled = true
		smoothSpinner.enabled = true
		goButton.enabled = true
	)
	on goButton pressed do
	(
		holeDepth = holeDepthSpinner.value
		holeSteapness = holeSteapnessSpinner.value
		rimHeight = rimHeightSpinner.value
		tessellations = tessellationSpinner.value
		detail = detailSpinner.value
		smoothIts = smoothSpinner.value
		--innerRim = (rimSizeSpinner.value/100) +1
		innerRim = 1.1
		outerRim = 1.2*innerRim
		doNoise = true
		strength = [xSpinner.value,ySpinner.value,zSpinner.value]
		
		undo on
		(
			main hole
		)
	)
)
createDialog mainRollout 175 370
