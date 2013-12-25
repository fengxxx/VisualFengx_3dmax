rolTurboCocktailGreeble
try(destroyDialog rolTurboCocktailGreeble) catch()
(
	fn randomSelection obj sel percentage =
	(
		percentage /= 100.0
		if sel.count == 0 then
			sel = for i = 1 to obj.faces.count collect i
		polyop.setFaceSelection obj (for i in sel where random 0.0 1.0 <= percentage collect i)
	)
	
	fn relaxFaces obj amount its =
	(
		obj.relaxAmount = amount
		obj.relaxIterations = its
		obj.relax selLevel:#Face
	)

	fn faceRandomCollectSlice obj sel = 
	(
		local getEdgesFromFace = polyop.getFaceEdges
		local setEdgeSel = polyop.setEdgeSelection
		local connectEdges = obj.editablePoly.connectEdges
		local edges = #()

		with undo off
			with redraw off 
			(
				for f in sel do
				(
					faceEdges = getEdgesFromFace obj f
					fCount = faceEdges.count
					if fCount > 3 do
					(
						startEdge = random 1 fCount
						unvalidEdges = #{
							if startEdge == 1 then faceEdges[fCount] else faceEdges[startEdge - 1],
							faceEdges[startEdge],
							if startEdge == fCount then faceEdges[1] else faceEdges[startEdge + 1]}
						validEdges = (faceEdges as bitArray - unvalidEdges) as array
						join edges #(validEdges[random 1 validEdges.count], faceEdges[startEdge])
					)
				)
				setEdgeSel obj edges
				connectEdges()
			)
	)

	fn faceRandomSlice obj sel = 
	(
		local getEdgesFromFace = polyop.getFaceEdges
		local setEdgeSel = polyop.setEdgeSelection
		local connectEdges = obj.editablePoly.connectEdges
		local edges = #()

		with undo off
			with redraw off 
				for f in sel do
				(
					faceEdges = getEdgesFromFace obj f
					fCount = faceEdges.count
					if fCount > 3 do
					(
						startEdge = random 1 fCount
						unvalidEdges = #{
							if startEdge == 1 then faceEdges[fCount] else faceEdges[startEdge - 1],
							faceEdges[startEdge],
							if startEdge == fCount then faceEdges[1] else faceEdges[startEdge + 1]}
						validEdges = (faceEdges as bitArray - unvalidEdges) as array
						setEdgeSel obj #(validEdges[random 1 validEdges.count], faceEdges[startEdge])
						connectEdges()
					)
				)
	)

	fn randomConnect1 obj sel =
	(
		local getEdgesFromFace = polyop.getFaceEdges
		local setEdgeSel = polyop.setEdgeSelection
		local connectEdges = obj.editablePoly.connectEdges
		local edges = #()
		with undo off
			with redraw off
			(
				for f in sel do
				(
					faceEdges = (getEdgesFromFace obj f) as array
					conEdges = #(faceEdges[random 1 faceEdges.count], faceEdges[random 1 faceEdges.count])
					
					if conEdges[1] != conEdges[2] then
						join edges conEdges
				)
				setEdgeSel obj edges
				connectEdges()
			)
	)

	fn randomConnect2 obj sel =
	(
		local getEdgesFromFace = polyop.getFaceEdges
		local setEdgeSel = polyop.setEdgeSelection
		local connectEdges = obj.editablePoly.connectEdges

		with undo off
			with redraw off
				for f in sel do
				(
					faceEdges = (getEdgesFromFace obj f) as array
					conEdges = #(faceEdges[random 1 faceEdges.count], faceEdges[random 1 faceEdges.count])
					
					if conEdges[1] != conEdges[2] then
					(
						setEdgeSel obj conEdges
						connectEdges()
					)
				)
	)
	
	fn extrudeRandom obj sel emin emax =
	(
		local extrudeFaces = polyop.extrudefaces
		with undo off
			with redraw off
				for i in sel do
					extrudeFaces obj i (random emin emax)
	)

	fn extrudeBySize obj sel strength doLog doInv =
	(
		local inv = if doInv then -1 else 1
		local getFaceArea = polyop.getFaceArea
		local extrudeFaces = polyop.extrudefaces
		with undo off
			with redraw off
				for i in sel do
				(
					fArea = getFaceArea obj i
					if i == 1 then 
					(
						print (fArea^inv)
						print fArea
					)
					if doLog then
						extrudeFaces obj i (aMin 10.0 (aMax 0.0 (strength * log (fArea/2.0)^inv+2)))
					else
						extrudeFaces obj i ((fArea^inv) * strength)
				)
	)
		
	rollout rolTurboCocktailGreeble "Turbo Coctail Greeble"
	(
		local logOn = false
		local invOn = false
		
		fn objFilter obj = superClassOf obj == GeometryClass
		
		pickButton pBtnObject "Pick ePoly object" height:16 align:#left filter:objFilter
		group "Selection"
		(
			button btnSelect "Select"  across:2 align:#left height:16 enabled:false
			spinner spnRandSelection "% of sel" range:[0, 100, 50] type:#integer align:#right enabled:false fieldWidth:35
		)
		group "Shuffling!"
		(
			label lblRelaxDescription "Relax     Amount:  Iterations:" align:#left 
			radioButtons rBtnDoRelax labels:#("") align:#center across:3 default:0 enabled:false
			spinner spnRelaxAmount "" range:[-1.0, 1.0, 0.5] type:#float fieldwidth:30 enabled:false
			spinner spnRelaxIterations "" range:[0, 100, 1] type:#integer fieldwidth:30 enabled:false
			button btnShuffle1 "Method 1" align:#left height:16 enabled:false across:2
			button btnShuffle2 "Method 2" align:#left height:16 enabled:false
			button btnShuffle3 "Method 3" align:#left height:16 enabled:false across:2
			button btnShuffle4 "Method 4" align:#left height:16 enabled:false
		)
		
		group "Extruding"
		(
			spinner spnExtrudeRandomMin "Min:" range:[-10000, 10000, 0] across:2 enabled:false
			spinner spnExtrudeRandomMax "Max:" range:[-10000, 10000, 5] enabled:false
			button btnExtrudeRandom "Extrude random" align:#right height:16 enabled:false
			radioButtons rBtnDoLog labels:#("Log.") align:#left across:2 default:0 enabled:false
			spinner spnExtrudeBySizeStrength "Strength:" range:[-100.0, 100.0, 1.0] type:#float fieldwidth:30 enabled:false
			radioButtons rBtnInv labels:#("Inv.") align:#left across:2 default:0 enabled:false
			button btnExtrudeBySize "Extrude by size" align:#right height:16 enabled:false
		)		
		
		on pBtnObject picked arg do
		(
			local qMessage = "This will convert the object to an editable poly, continue?"
			isEPoly = classOf arg == Editable_Poly
			if classOf arg == Editable_Poly or (not isEPoly and (queryBox qMessage)) then
			(
				if not isEPoly do 
					convertTo arg PolyMeshObject
				pBtnObject.text = arg.name
				local uiItems = #(btnSelect, spnRandSelection, rBtnDoRelax, btnShuffle1, btnShuffle2, btnShuffle3, btnShuffle4, btnExtrudeRandom, spnExtrudeRandomMin, spnExtrudeRandomMax, spnExtrudeBySizeStrength, btnExtrudeBySize, rBtnInv, rBtnDoLog)
				for i in uiItems do
					i.enabled = true
			)
		)
		
		on btnSelect pressed do
			randomSelection pBtnObject.object ((polyop.getFaceSelection pBtnObject.object) as array) spnRandSelection.value
		
		on rBtnDoRelax changed arg do
		(
			if spnRelaxAmount.enabled then
			(
				rBtnDoRelax.state = 0
				spnRelaxAmount.enabled = false
				spnRelaxIterations.enabled = false
			)
			else
			(
				rBtnDoRelax.state = 1
				spnRelaxAmount.enabled = true
				spnRelaxIterations.enabled = true
			)
		)
		
		on rBtnDoLog changed arg do
		(
			if logOn then
			(	
				rBtnDoLog.state = 0
				logOn = false
			)
			else
				logOn = true	
		)
		
		on rBtnInv changed arg do
		(
			if invOn then
			(
				rBtnInv.state = 0
				invOn = false
			)
			else
				invOn = true
		)
		
		on btnShuffle1 pressed do
		(
			faceRandomSlice pBtnObject.object (polyop.getFaceSelection pBtnObject.object)
			if rBtnDoRelax.state == 1 do
				relaxFaces pBtnObject.object spnRelaxAmount.value spnRelaxIterations.value
		)
		
		on btnShuffle2 pressed do
		(
			faceRandomCollectSlice pBtnObject.object (polyop.getFaceSelection pBtnObject.object)
			if rBtnDoRelax.state == 1 do
				relaxFaces pBtnObject.object spnRelaxAmount.value spnRelaxIterations.value
		)
		
		on btnShuffle3 pressed do
		(
			randomConnect1 pBtnObject.object (polyop.getFaceSelection pBtnObject.object)
			if rBtnDoRelax.state == 1 do
				relaxFaces pBtnObject.object spnRelaxAmount.value spnRelaxIterations.value
		)
		
		on btnShuffle4 pressed do
		(
			randomConnect2 pBtnObject.object (polyop.getFaceSelection pBtnObject.object)
			if rBtnDoRelax.state == 1 do
				relaxFaces pBtnObject.object spnRelaxAmount.value spnRelaxIterations.value
		)
		
		on btnExtrudeRandom pressed do
			extrudeRandom pBtnObject.object (polyop.getFaceSelection pBtnObject.object) spnExtrudeRandomMin.value spnExtrudeRandomMax.value
		
		on btnExtrudeBySize pressed do
				undo on
					extrudeBySize pBtnObject.object (polyop.getFaceSelection pBtnObject.object) spnExtrudeBySizeStrength.value (rBtnDoLog.state == 1) (rBtnInv.state == 1)
		
	)
	createDialog rolTurboCocktailGreeble 
)