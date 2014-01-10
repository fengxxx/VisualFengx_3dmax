macroScript ExternalMaxScriptIDE_RunScript
category:"ExternalMaxScriptIDE"
(
	
	global EMSIDESettings
	global EMSIDEFunctions
	try (
		result = filein(EMSIDESettings.message)
		print result
	) catch (
		EMSIDEFunctions.PrintError (getCurrentException())
		if (EMSIDESettings.OpenListenerOnError) then (
			actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
		)
	)
)


global EMSIDESettings
global EMSIDEFunctions

struct EMSIDESettings_struct(
	OpenListenerOnError = true,
	ShowReceiverDialog = false,
	RunOnStartUp = true,
	Form = undefined,
	Message = undefined,
	IniFilePath = "$userScripts\\ExternalMaxScriptIDE\\ExternalMaxScriptIDE.ini"
	
)
global EMSIDESettings = EMSIDESettings_struct()

struct EMSIDEFunctions_struct(
	fn ExecuteMessage=(),
	fn HandleExecuteMaxScriptEvent _args=(),
	fn Start=(),
	fn PrintError _exception=(
		errorStr = ""
		exceptionString = 
		
		errorStr += "\n"
		errorStr += ("-- ERROR") 
		errorStr += "\n"
		errorStr += ("-- Error occurred in anonymous codeblock; started from filename: "+(EMSIDESettings.message as string)+"")
		errorStr += "\n"
		errorStr += exceptionString
		errorStr += "\n"
		print (errorStr)
	),
-- 	fn HandleClosedEvent _args=(),
	fn ExecuteMessage _args=(
		message = _args.Message
		EMSIDESettings.Message = message
		try (
			if ( _args.Message != undefined) then (
				try(
					if(doesfileexist (message as string) )then(
	-- 					print ("filein ("+message+")")
						try(
							macros.run "ExternalMaxScriptIDE" "ExternalMaxScriptIDE_RunScript"
						)catch()
	-- 					filein(message)
	-- 					include message
					)else(
						res = execute(message)
						print res
					)
				)catch(
					res = execute(message)
					print res
				)
				
				completeRedraw()
			)
		)catch(
			EMSIDEFunctions.PrintError (getCurrentException())
			if (EMSIDESettings.OpenListenerOnError) then (
				actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
			)
		)
	),
	fn HandleExecuteMaxScriptEvent _args=(
		EMSIDEFunctions.ExecuteMessage _args
	),
	fn HandleClosedEvent sender CancelEventArgs=(
		
	),
	fn ShowForm valueBoolean =(
		if(EMSIDESettings.Form == undefined)then(
			return false
		)
		if(valueBoolean)then(
			EMSIDESettings.Form.Location = dotnetobject "System.Drawing.Point" 0 0
			EMSIDESettings.Form.Size = dotnetobject "System.Drawing.Size" 290 288
		)else(
			EMSIDESettings.Form.Location = dotnetobject "System.Drawing.Point" -9000 -9000
			EMSIDESettings.Form.Size = dotnetobject "System.Drawing.Size" 1 1
		)
	),
	fn CloseConnection=(
		-- close the current connection
		try(EMSIDESettings.Form.close())catch()
	),
	fn OpenConnection=(
		try(EMSIDESettings.Form.close())catch()
		-- Loading needed data
		userScriptsPath = (symbolicPaths.getPathValue "$userScripts")
		dllPath = userScriptsPath+("\\ExternalMaxScriptIDE\\MaxScriptReceiverForm.dll")
		Assembly = dotNetClass "System.Reflection.Assembly" 
		Assembly.loadfrom dllPath
	
		-- Creating widow
		maxScriptReceiverForm = dotnetobject "MaxScriptReceiverForm.MaxScriptReceiver"
		EMSIDESettings.Form = maxScriptReceiverForm
		maxScriptReceiverForm.text = "MaxScriptReceiver"

		dotNet.addEventHandler EMSIDESettings.Form "ExecuteMaxScript" HandleExecuteMaxScriptEvent
		dotNet.addEventHandler EMSIDESettings.Form "FormClosing" HandleClosedEvent
		
		-- adding to max as subwindow
		maxHndl = windows.getMAXHWND()
		maxHandlePointer=(Windows.GetMAXHWND())
		sysPointer = DotNetObject "System.IntPtr" maxHandlePointer
		maxHwnd = DotNetObject "MaxCustomControls.Win32HandleWrapper" sysPointer
		-- creating window
		maxScriptReceiverForm.FormBorderStyle = maxScriptReceiverForm.FormBorderStyle.FixedToolWindow
		maxScriptReceiverForm.StartPosition = maxScriptReceiverForm.StartPosition.Manual
		maxScriptReceiverForm.ShowInTaskbar = false
		maxScriptReceiverForm.Location = dotnetobject "System.Drawing.Point" -9000 -9000
		maxScriptReceiverForm.Size = dotnetobject "System.Drawing.Size" 1 1
		maxScriptReceiverForm.show(maxHwnd)
		print ("ExternalMaxScriptIDE.ms - " + "Window Handle "+(maxScriptReceiverForm.handle as string))
		ShowForm EMSIDESettings.ShowReceiverDialog
	),
	fn RestartConnection=(
		-- restart the connection
		CloseConnection()
		OpenConnection()
	),
	fn LoadIniParam _name=(
		valueStr = getinisetting EMSIDESettings.IniFilePath "ExternalMaxScriptIDE" _name
		return valueStr
	),
	fn SaveIniParam _name _value=(
		valueStr = setinisetting EMSIDESettings.IniFilePath "ExternalMaxScriptIDE" _name (_value as string)
	),
	fn LoadSettings=(
		-- load settings from the inifile
		try(EMSIDESettings.OpenListenerOnError = (LoadIniParam "OpenListenerOnError") as booleanclass )catch()
		try(EMSIDESettings.ShowReceiverDialog = (LoadIniParam "ShowReceiverDialog") as booleanclass )catch()
	),
	fn SaveSettings=(
		-- save settings to the inifile
		SaveIniParam "OpenListenerOnError" EMSIDESettings.OpenListenerOnError
		SaveIniParam "ShowReceiverDialog" EMSIDESettings.ShowReceiverDialog
	)
)
global EMSIDEFunctions = EMSIDEFunctions_struct()


