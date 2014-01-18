try(
	destroydialog UIMaster_Rollout_Demo
)catch()

struct UIMaster(
	fn Initiate=(
		
	),
	fn colorManColorAsArgb _colorManColor=(
		colorClass = dotnetClass "System.Drawing.Color"
		multiplyValue = 255
		
		redValue = (_colorManColor[1]*multiplyValue)
		greenValue = (_colorManColor[2]*multiplyValue)
		blueValue = (_colorManColor[3]*multiplyValue)
		
		dotnetColor = colorClass.FromArgb redValue greenValue blueValue
		
		return dotnetColor
		
		
	),
	fn StyleLabelAsMessage _dotnetLabel=(
		theBackgroundColor = (colorMan.getColor #trackbarBg )
		theTextColor = (colorMan.getColor #text )
		_dotnetLabel.backColor = (colorManColorAsArgb theBackgroundColor)
		_dotnetLabel.foreColor = (colorManColorAsArgb theTextColor)
		sizeGrow = 3
		el
		_dotnetLabel.height =  _dotnetLabel.height+sizeGrow
		_dotnetLabel.pos.y = _dotnetLabel.pos.y - (sizeGrow/2)
		_dotnetLabel.text = "  "+_dotnetLabel.text
		
	),
	fn StyleLabelAsHeader _dotnetLabel=(
		theBackgroundColor = (colorMan.getColor #stackViewSelection   )
		theTextColor = (colorMan.getColor #toolTipBackground     )
		sizeGrow = 3
		
		
		_dotnetLabel.height =  _dotnetLabel.height+sizeGrow
		_dotnetLabel.pos.y = _dotnetLabel.pos.y - (sizeGrow/2)
		_dotnetLabel.text = "  "+_dotnetLabel.text
		printtheTextColor
-- 		(colorManColorAsArgb windowColor)
		_dotnetLabel.backColor = (colorManColorAsArgb theBackgroundColor)
		_dotnetLabel.foreColor = (colorManColorAsArgb theTextColor)
		_dotnetLabel.TextAlign = _dotnetLabel.TextAlign.MiddleLeft
	),
	fn ArrangeInRow _controlArr distanceX:30 distanceY:30 doX:true doY:false=(
		if(_controlArr.count < 2)then(
			return false
		)
		mainControl = _controlArr[1]
		prevObj
		iCounter = 1
		for controlObj in _controlArr do(
			if(controlObj == mainControl)then(
				prevObj = controlObj
				continue
			)
			controlObj.pos.x = prevObj.pos.x +( distanceX * iCounter)
			iCounter += 1
		)
	)
)
m_UIMaster = UIMaster()
m_UIMaster.Initiate()

rollout UIMaster_Rollout_Demo "Demo" width:300 height:400(
	dotNetControl Text_Header "system.windows.forms.label" text:"header"
	dotNetControl Text_Message "system.windows.forms.label" text:"header"
	button b1 "1" across:4
	button b2 "2"
	button b3 "3"
	button btn_d "4"
	on UIMaster_Rollout_Demo open do(
		m_UIMaster.StyleLabelAsHeader Text_Header
		m_UIMaster.StyleLabelAsMessage Text_Message
		m_UIMaster.ArrangeInRow #(b1,b2,b3,btn_d) distanceX:25 doX:true
	)
)

-- createdialog UIMaster_Rollout_Demo pos:[100,120] 