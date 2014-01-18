struct MaxScriptListenerMaster(
	WM_CLOSE = 0x0010,
	WM_SHOWWINDOW = 0x0018,
	WM_SETFOCUS = 0x07,
	m_ToggleBool,
	function Initiate=(
		m_ToggleBool = true
	),
	function GetMaxScriptListener_Window=(
		for w in (windows.getChildrenHWND 0) do (
			if(w[5] == "MAXScript Listener" )then(
-- 				UIAccessor.CloseDialog w[1]
				
				return w
-- 				print (UIAccessor.GetWindowDllFileName w[1])
-- 				UIAccessor.PressDefaultButton()
			)
		)
		return undefined
	),
	
	function Open=(
		actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
		window = GetMaxScriptListener_Window()
		(UIAccessor.SendMessage window[1] WM_SETFOCUS 20 20)
	),
	function Close =(
		window = GetMaxScriptListener_Window()
		
		(UIAccessor.SendMessage window[1] WM_CLOSE 20 20)
-- 		UIAccessor.CloseDialog window[1]
		
-- 		print (UIAccessor.GetWindowDllDescription window[1])
	),
	function Toggle=(
		if(m_ToggleBool == true)then(
			Open()
			m_ToggleBool = false
		)else(
			Close()
			m_ToggleBool = true
		)
	)
)
m_MaxScriptListenerMaster = MaxScriptListenerMaster()
m_MaxScriptListenerMaster.Initiate()