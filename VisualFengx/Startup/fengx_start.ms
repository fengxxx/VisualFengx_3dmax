-->> 开机启动脚本

fileIn (getdir #Scripts +"\\visualfengx\\visualfengx.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx_macroScript.ms")
fileIn (getdir #Scripts +"\\visualfengx\\visualfengx_macroScript.ms")

-->> 开机更新
-->> 好像没啥用  还挺烦的 关掉算了. 任何弹出的窗口都尽量不要有..最好全部在后台不用操心 

function test=
(
fengx.checkUpdate()
)
( 
MainThread = dotnetobject "System.ComponentModel.BackGroundWorker"
dotNet.addEventHandler MainThread "DoWork" test
MainThread.RunWorkerAsync()
)

function startCheck=
(
	if fengx.checkUpdate()==true and newVersions > VisualFengxVersions then
	( 
	     if alertUpdate==true do 
	     (
	      -- msg="VisualFengx 可以更新到 " + (newVersions as string)+"是否下载更新！"
		--if (queryBox msg)==true do(
			createdialog checkUpDateWindow --fengx.update()
		    checkUpDateWindow.lb01.text= updateMsg
	      --)
	      )
		)else ()--print  "VsiaulFengx 该版本已经为最新！无需更新!" 
	)