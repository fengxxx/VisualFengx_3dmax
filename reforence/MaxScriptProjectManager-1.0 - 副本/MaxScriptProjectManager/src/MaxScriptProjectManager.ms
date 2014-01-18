/*
	MaxScriptProjectManager
	------------------------------
	Version : 1.0
	Developed By : Sven Fraeys
	Info: http://sven.fraeys.be/
	Description:
	Contains the main start file of MSPM
	
*/


filein("includeMaster.ms")
m_IncludeMaster
m_IncludeMaster.Add ("WindowSaver.ms")
m_IncludeMaster.Add ("UIMessageLabel.ms")
m_IncludeMaster.Add ("DialogMaster.ms")
m_IncludeMaster.Add ("TreeViewBrowser.ms")
m_IncludeMaster.Add ("FileMaster.ms")
m_IncludeMaster.Add ("UIMaster.ms")
m_IncludeMaster.Add ("CreateDotNetProcessor.ms")
m_IncludeMaster.Add ("MaxScriptListenerMaster.ms")

m_IncludeMaster.Add ("MPM_Repository.ms")
m_IncludeMaster.Add ("MSPM_System.ms")
m_IncludeMaster.Add ("MaxScriptManager_System.ms")
m_IncludeMaster.Add ("Repository_System.ms")
m_IncludeMaster.Add ("Repository_Manager.ms")
m_IncludeMaster.Add ("Repository_Properties.ms")
m_IncludeMaster.Add ("Repository_Download.ms")

m_IncludeMaster.Add ("MZP_System.ms")
m_IncludeMaster.Add ("Project_Publish.ms")
m_IncludeMaster.Add ("ProjectView.ms")
m_IncludeMaster.Add ("Project_Manager.ms")
m_IncludeMaster.Add ("Project_Properties.ms")
m_IncludeMaster.Add ("Author.ms")
m_IncludeMaster.Add ("Project_Add.ms")
m_IncludeMaster.Add ("Project_New.ms")
m_IncludeMaster.Add ("About.ms")
m_IncludeMaster.Add("Repository_ScriptItem_Properties.ms")

m_IncludeMaster.fileInAll()
m_IncludeMaster.fileInAll()

m_DialogMaster.DialogMaster_CreateDialog MSPM_ProjectView_Rollout menu:rc_ProjectView style_resizing:true
