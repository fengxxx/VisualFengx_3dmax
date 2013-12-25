fileIn (getdir #Scripts +"\\visualfengx\\visualfengx.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx_macroScript.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx_macroScript.ms")
if fengx.checkUpdate()==true and	newVersions > VisualFengxVersions then
( 
	msg="可以更新到 " + (newVersions as string)+"是否下载更新！"
	if (queryBox msg)==true do fengx.update()
	updateA=true 
	)else messageBox "该版本已经为最新！无需更新!"

