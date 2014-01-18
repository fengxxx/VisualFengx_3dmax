theFile = "C:\\debugger_v1.0.mzp" --Note, if these files are in $userscripts you need to use GetDir #userscripts + "\\debugger_v.1.0.mzp" So that the whole path is passed to DOS
theWatermarkFile = "C:\\watermark.tmp" --Same as above!
theComment ="-MaxScriptManager compatible"
ver = maxversion()

--First we extract the "watermark" file. (This file contains also folder structure)
if ver[1] > 9000 then --Every 3dsMax version
(
	hiddenDosCommand ("zipnote " + "\""+ theFile + "\"" + " > " + "\"" + theWatermarkFile + "\"") donotwait:false startpath:(("$userscripts" + "\\MAXScriptManager\\") as string) --Startpaht is where zipnote.exe is located
)
else --3dsMax 9
(
	shellLaunch ("\"" + GetDir #userscripts + "\\MaxScriptManager\\zipnote.exe" + "\"") ("\""+ theFile + "\"" + " > " + "\"" + theWatermarkFile + "\"")
)

--Then we add the comment. --I prefer to use dotnet here instead of opening and closing FileStream, "closing" files is broken in 3dsMax 2012 :(
AppendText = (dotnetClass "System.IO.File").AppendAllText theWatermarkFile theComment

--Finally we add the "watermark" file back to the mzp
if ver[1] > 9000 then --Every 3dsMax version
(
	hiddenDosCommand ("zipnote -w " + "\""+ theFile + "\"" + " < " + "\"" + theWatermarkFile + "\"") donotwait:false startpath:(("$userscripts" + "\\MAXScriptManager\\") as string) --Startpaht is where zipnote.exe is located
)
else --3dsMax 9
(
	shellLaunch ("\"" + GetDir #userscripts + "\\MaxScriptManager\\zipnote.exe" + "\"") ("-w " + "\""+ theFile + "\"" + " < " + "\"" + theWatermarkFile + "\"")
)

--We delete the watermark.tmp file
deleteFile theWatermarkFile


