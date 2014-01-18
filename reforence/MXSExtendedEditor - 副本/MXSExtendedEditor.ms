(
	dotNet.LoadAssembly (getFilenamePath( getSourceFilename() ) + "MXSExtendedEditor.dll")
	
	global  mXSExtendedForm
	local mXSEOutlinerTimerClock -- global for debugging
	
	local editorHandle
	local listenerHandle
	local parentHandle
	local explorerHandle
	
	local mXSEOutlinerTimerClockInterval = 1000
	
	local scriptExtensions = #(".ms", ".mcr", ".mse", ".mzp")
	local editableScriptExtensions = #(scriptExtensions[1], scriptExtensions[2])
	
	
	fn stringArrToString arr =
	(
		local newString = ""
		for i in arr do
			append newString (i + " ")
		(toLower (newString + "\n"))
	)

	fn collectScriptAttributes =
	(
		local uiItemFilter = #("angle", "slider", "spinner", "button", "checkbutton", "mapbutton", "materialbutton", "pickbutton", "checkbox", \
			"colorpicker", "listbox", "multilistbox", "dropdownlist", "combobox", "edittext", "groupbox", "hyperlink", "label", "progressbar", "radiobuttons", \
			"bitmap", "imgtag", "rollout", "subrollout", "curvecontrol", "popupmenu", "timer", "menuitem", "rcmenu")	
		local filters = join #("fn", "function", "struct", "on") uiItemFilter
		local atts = ""
		local windowText
		-- Get the current opened script tab's name
		local currentTab = for i in windows.getchildrenhwnd mXSExtendedForm.handle where i[4] == "MXS_SciTEWindow" do exit with 
									for j in windows.getchildrenhwnd i[1] where j[4] == "MXS_Scintilla" do exit with j[1]
		if currentTab != undefined then
		mXSExtendedForm.MXSCurrentTabHandle = dotNetObject "IntPtr" currentTab
		
		windowText = mXSExtendedForm.GetWindowText (dotNetObject "IntPtr" mXSExtendedForm.MXSCurrentTabHandle)
		for stringLine in (filterString windowText "\n") do
		(
			stringArr = filterString stringLine "\t "
			for i in filters where i == (toLower stringArr[1]) do
			(
				if stringArr[1] == "on" then
					exit with (append atts (stringArr[1] + " " + stringArr[2] + " " + stringArr[3] + "\n") )
				else
					exit with (append atts (stringArr[1] + " " + stringArr[2] + "\n") )
			)
		)
		mXSExtendedForm.TreeViewOutline.UpdateOutlineList atts
	)
	
	-- Opens the windows to embed to get their handles.
	fn openWindows = 
	(
		actionMan.executeAction 0 "40839" -- Open MXSEditor
		actionMan.executeAction 0 "40469" -- Open new script 
		actionMan.executeAction 0 "40472" -- Open MAX Script: MAXScript Listener
		fileIn "_SO_MXSExtendedExplorer.ms" -- Open script explorer
	)
	
	-- Sets the handles so their windows can be embedded in the form.
	fn setHandles =
	(
		openWindows()
		
		editorHandle = (windows.getchildhwnd 0 "(Untitled) - MAXScript")[1]
		editorHandle =  dotNetObject "IntPtr" editorHandle
		listenerHandle = (windows.getChildHwnd 0 "MAXScript Listener")[1]
		listenerHandle =  dotNetObject "IntPtr" listenerHandle
		parentHandle = windows.getMaxHWND() 
		parentHandle = dotNetObject "IntPtr" parentHandle
		explorerHandle = (windows.getChildHwnd 0 "Script organizer")[1]
		explorerHandle = dotNetObject "IntPtr" explorerHandle
		
		mXSExtendedForm.SetScriptHandles editorHandle listenerHandle parentHandle explorerHandle
		mXSExtendedForm.EmbedScriptWindows()
	)
	
	fn startOutlineUpdates =
	(
		mXSExtendedForm.OutlinerTimer = dotNetObject "System.Windows.Forms.Timer"
		dotNet.addEventHandler mXSExtendedForm.OutlinerTimer "tick" collectScriptAttributes
		mXSExtendedForm.OutlinerTimer.Interval = mXSEOutlinerTimerClockInterval
		mXSExtendedForm.OutlinerTimer.Start()
	)
		
	fn createAndShowForm =
	(
		mXSExtendedForm = dotNetObject "MXSExtendedEditor.MainForm"
		setHandles()

		-- Set the parent of mXSExtendedForm to be MAX.  Necessary to show new dialogs correctly 
		local maxHWND = dotNetObject "System.IntPtr" ( Windows.GetMAXHWND() )
		maxHWND = dotNetObject "MaxCustomControls.Win32HandleWrapper" maxHWND
		
		dotNet.addEventHandler mXSExtendedForm "formClosed" openWindows
		
		mXSExtendedForm.show maxHWND		
		startOutlineUpdates()
		
	)
	
	createAndShowForm()
)