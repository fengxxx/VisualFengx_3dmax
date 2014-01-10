try(EMSIDEFunctions.CloseConnection())catch()
deletefile "$userScripts\\startup\\ExternalMaxScriptIDE_startup.ms"
print ("deletefile $userScripts\\startup\\ExternalMaxScriptIDE_startup.ms")
print "Uninstalled ExternalMaxScript IDE"