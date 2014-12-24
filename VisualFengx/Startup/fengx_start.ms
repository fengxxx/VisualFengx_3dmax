-->> 开机启动脚本
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx_macroScript.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx_macroScript.ms")
-->> 开机更新
function test=
(
	fengx.checkUpdate()
)
( 
MainThread = dotnetobject "System.ComponentModel.BackGroundWorker"
dotNet.addEventHandler MainThread "DoWork" test
MainThread.RunWorkerAsync()
)