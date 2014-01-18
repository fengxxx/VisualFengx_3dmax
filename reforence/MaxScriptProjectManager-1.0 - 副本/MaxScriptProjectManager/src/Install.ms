--Install MaxScript Icons
fn CreateMaxImageButtonIcon _folder _name=(
	ui_dir = cui.getDir ()
	size = "24"
	deletefile (ui_dir+"Icons\\"+_name+"_"+size+"i.bmp")
	deletefile (ui_dir+"Icons\\"+_name+"_"+size+"a.bmp")
	copyFile (_folder+""+_name+"_"+size+"i.bmp") (ui_dir+"Icons\\"+_name+"_"+size+"i.bmp")	
	copyFile (_folder+""+_name+"_"+size+"a.bmp") (ui_dir+"Icons\\"+_name+"_"+size+"a.bmp")	
	size = "16"
	deletefile (ui_dir+"Icons\\"+_name+"_"+size+"i.bmp")
	deletefile (ui_dir+"Icons\\"+_name+"_"+size+"a.bmp")
	copyFile (_folder+""+_name+"_"+size+"i.bmp") (ui_dir+"Icons\\"+_name+"_"+size+"i.bmp")
	copyFile (_folder+""+_name+"_"+size+"a.bmp") (ui_dir+"Icons\\"+_name+"_"+size+"a.bmp")	
	print (_folder+""+_name+"_"+size+"i.bmp")
)
CreateMaxImageButtonIcon ("$userScripts\\MaxScriptProjectManager\\src\\maxImageButton\\") "MaxScriptProjectManager"
colorman.reInitIcons()

--Create MacroScript
macroScript MaxScriptProjectManager
buttonText:"MaxScriptProjectManager"
category:"MaxScriptProjectManager"
tooltip:"MaxScriptProjectManager"
icon:#("MaxScriptProjectManager", 1)
(
	on execute do(
		filein("$userScripts\\MaxScriptProjectManager\\src\\MaxScriptProjectManager.ms");
	)
)
filein("$userScripts\\MaxScriptProjectManager\\src\\MaxScriptProjectManager.ms");