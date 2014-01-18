m_DialogMaster.DialogMaster_DestroyDialog Author_Rollout
struct Author_System(
	m_XMLDoc,
	m_AuthorNode,
	fn GetAuthorNode=(
		m_AuthorNode = ( m_XmlDoc.SelectSingleNode "mspm/author")
		if(m_AuthorNode == undefined)then(
			m_AuthorNode = (m_XmlDoc.CreateNode "element" "author" "")
			mspmProjectNode = ( m_XmlDoc.SelectSingleNode "mspm")
			mspmProjectNode.appendchild m_AuthorNode
		)
		return m_AuthorNode
	),
	
	fn SetAuthor _stringValue=(
		m_AuthorNode.SetAttribute "author" _stringValue
	),
	
	fn GetAuthor=(
		return (m_AuthorNode.GetAttribute "author")
	),
	fn SetDonate _stringValue=(
		m_AuthorNode.SetAttribute "donate" _stringValue
	),
	
	fn GetDonate=(
		return (m_AuthorNode.GetAttribute "donate")
	),
	
	fn SetEmail _stringValue=(
		m_AuthorNode.SetAttribute "email" _stringValue
	),
	
	fn GetEmail=(
		return (m_AuthorNode.GetAttribute "email")
	),
	
	fn SetSite _stringValue=(
		m_AuthorNode.SetAttribute "site" _stringValue
	),
	fn GetSite=(
		return (m_AuthorNode.GetAttribute "site")
	),
	fn GetTwitter=(
		return (m_AuthorNode.GetAttribute "twitter")
	),
	
	fn SetTwitter _stringValue=(
		m_AuthorNode.SetAttribute "twitter" _stringValue
	),
	
	fn GetAsShortString=(
		return (GetAuthor() + " - " + GetSite()+ " - " + GetEmail())
	),
	
	fn Initiate=(
		
		m_XMLDoc = m_MSPM_System.GetXMLDoc()
		GetAuthorNode()
		
		
		
	)
)

rollout Author_Rollout "Author Profile" width:300 height:230(
	local m_WindowSaver
	local m_UIMessage_Text_Message
	
	dotNetControl Text_AuthorTitle "system.windows.forms.label" text:"Profile"
	label l2 offset:[-15,-10]
	edittext txt_Author "Author"
	edittext txt_Email "Email"
	edittext txt_Site "Site"
	edittext txt_Twitter "Twitter"
	edittext txt_Donate "Donate"
	label l1
	button btn_Save "Save" width:100 height:40 align:#right
	
	
	on btn_Save pressed do(
		m_Author_System.SetAuthor txt_Author.text
		m_Author_System.SetEmail txt_Email.text
		m_Author_System.SetSite txt_Site.text
		m_Author_System.SetTwitter txt_Twitter.text
		m_Author_System.SetDonate txt_Donate.text
		m_MSPM_System.Save()
		m_MSPM_System.SendEventListener "AuthorEdit"
		destroydialog Author_Rollout

	)
	
	fn HandleMSPMExit _args=(
		destroyDialog Author_Rollout
	)
	
	on Author_Rollout open do(
		m_MSPM_System.AddEventListener "ExitMSPM" HandleMSPMExit
		(m_UIMaster.StyleLabelAsHeader Text_AuthorTitle)
		m_WindowSaver = WindowSaver()
		
		origPos = getdialogpos Author_Rollout
		origSize = getdialogsize Author_Rollout
		
		
		m_WindowSaver.onOpen ("$userScripts\\maxscriptprojectmanager\\src\\rolloutData.ini") Author_Rollout applySize:false applyPosition:true
		
		newPos = [(origPos[1] + (origSize[1]/2)) - (Author_Rollout.width/2), (origPos[2] + (origSize[2]/2)) - (Author_Rollout.height/2)]
		setdialogpos Author_Rollout newPos
		
		txt_Author.text = m_Author_System.GetAuthor()
		txt_Email.text = m_Author_System.GetEmail()
		txt_Site.text = m_Author_System.GetSite()
		txt_Twitter.text = m_Author_System.GetTwitter()
		txt_Donate.text = m_Author_System.GetDonate()
	)
	on Author_Rollout close do(
		m_MSPM_System.RemoveEventListener "ExitMSPM" HandleMSPMExit
		m_WindowSaver.onClose()
	)
	
	
	
	
)

m_Author_System = Author_System()
m_Author_System.Initiate()

-- m_DialogMaster.DialogMaster_CreateDialog Author_Rollout