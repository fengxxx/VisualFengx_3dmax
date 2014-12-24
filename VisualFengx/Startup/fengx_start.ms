-->> 开机启动脚本
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx_macroScript.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx_macroScript.ms")
-->> 开机更新
function checkUpadteFile=
(
	if startCheckUpdate do
	(
		if fengx.checkUpdate()  do 
		(
			print "visualFengx: A new version released"
			print "visualFengx: start download the new version update"
			fengx.downloadUpdateFiles()
			)
		)
)
( 
MainThread = dotnetobject "System.ComponentModel.BackGroundWorker"
dotNet.addEventHandler MainThread "DoWork" checkUpadteFile
MainThread.RunWorkerAsync()
)