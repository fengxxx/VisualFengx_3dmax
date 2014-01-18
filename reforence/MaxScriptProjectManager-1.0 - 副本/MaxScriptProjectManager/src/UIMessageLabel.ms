try(
	destroydialog UIMessage_Demo
)catch()
struct UIMessageLabel(
	
	m_DotnetLabel,
	function GetMessage=(
		return (m_DotnetLabel.text)
	),
	
	function SetGreenMessageColors=(
		m_DotnetLabel.backcolor = m_DotnetLabel.backcolor.Green
		m_DotnetLabel.Forecolor = m_DotnetLabel.Forecolor.White
	),
	function SetRedMessageColors=(
		m_DotnetLabel.backcolor = m_DotnetLabel.backcolor.Red
		m_DotnetLabel.Forecolor = m_DotnetLabel.Forecolor.White
	),
	function SetDefaultMessageColors=(
		tint = 230
		m_DotnetLabel.backcolor = m_DotnetLabel.backcolor.fromArgb tint tint tint
		tint = 0
		m_DotnetLabel.Forecolor = m_DotnetLabel.Forecolor.fromArgb tint tint tint
-- 		m_DotnetLabel.ResetBackColor()
-- 		m_DotnetLabel.ResetForeColor()
	),
	function Initiate _dotnetLabel=(
		
		m_DotnetLabel = _dotnetLabel
		m_DotnetLabel.text = " ..."
		 SetDefaultMessageColors()
		
-- 		m_DotnetLabel.BorderStyle=m_DotnetLabel.BorderStyle.FixedSingle
-- 		showproperties m_DotnetLabel.padding
	),
	function SetMessage _messageStr style:undefined=(
		m_DotnetLabel.Text = "  "+_messageStr
		
		if(style == true)then(
			SetGreenMessageColors()
		)else if(style == false)then(
			SetRedMessageColors()
		)else(
			SetDefaultMessageColors()
		)
		m_DotnetLabel.ImageAlign = m_DotnetLabel.ImageAlign.MiddleLeft
	),
	function OnMouseClick _EventArgs=(
		
	
		
	)
)

rollout UIMessage_Demo "UIMessage" width:400 height:200(
	local m_MessageLabel
	dotNetControl Text_Message "system.windows.forms.label" height:20
	button btn_Green "Green" across:3
	button btn_Red "Red"
	button btn_Default "Default"
	on btn_Green pressed do(
		m_MessageLabel.SetMessage "Green!" style:true
	)
	on btn_Red pressed do(
		m_MessageLabel.SetMessage "Red!" style:false
	)
	on btn_Default pressed do(
		m_MessageLabel.SetMessage "Default!" style:undefined
	)
	on UIMessage_Demo open do(
		
		ImageClass = dotnetClass "System.Drawing.Image"
		
-- 		Text_Message.Image = ImageClass.FromFile("c:\\Icon_Folder.bmp")
		
-- 		Text_Message.ImageAlign = Text_Message.ImageAlign.MiddleLeft
-- 		Text_Message.Padding.Left = 200.0
-- 		showevents Text_Message
		m_MessageLabel = UIMessageLabel()
		m_MessageLabel.Initiate Text_Message
		m_MessageLabel.SetMessage ""
-- 		m_MessageLabel.SetMessage "Project Added!" style:false
		
	)
	
	on Text_Message mouseClick _args do(
		m_MessageLabel.onMouseClick _args
	)
	
)
-- createdialog UIMessage_Demo pos:[200,200]