--LIB CopyFiles
struct FileMaster(
	fn DirectoryExists _path=(
		_path
		pathArr = filterstring _path "\\"
		parentFolder = ""
		arrSize= ((pathArr.count))
		for i = 1 to (arrSize-1) do(
			append parentFolder pathArr[i]
			append parentFolder "\\"
		)
		filesArr = (getdirectories (parentFolder+"*"))
		for file in filesArr do(
			if((toUpper file) == (toUpper _path))then(
				return true
			)
		)
		return false
	),
	fn GetFolderName _path=(
		_parts = filterstring _path "\\"
		return _parts[_parts.count]
	),
	fn DeleteDir _path=(
		DeleteDosCommand = "RMDIR \""
		DeleteDosCommand = append DeleteDosCommand _path
		DeleteDosCommand = append DeleteDosCommand "\" /S /Q"
		DOSCommand DeleteDosCommand
	),
	fn CopyDir _dir1 _dir2=(
		
		final_url = _dir1;
	
		if (final_url != "")then(
			--prepare to copy files
			local _scriptDir = _dir2;
			local accessFolder = makeDir _scriptDir;
			if (accessFolder == true)then(

				
				local _filesSource = getFiles (final_url+"\\*");
				
				local _pCnt = 0.0;
				
				--copy content files
				for sf in _filesSource do (
					_pCnt+=1.0;
					local tf = _scriptDir+"\\"+filenameFromPath sf;
					
					local accessFile = deleteFile tf;--try to delete the icons if they can not be replaced below
					local accessFile = copyFile sf tf;
					
					if (accessFile == true)then(
						local p = (_pCnt / _filesSource.count) * 50.0+25.0;
						
					)else(

						failing = true;
					)
				)
				
				
				
				local myfolders = getDirectories(final_url+"\\*")
				for i = 1 to myfolders.count do(
					folder = myfolders[i]
					
					folderName = GetFolderName (folder)

					makedir (_dir2+"\\"+folderName+"\\")
					CopyDir (folder) (_dir2+"\\"+folderName+"\\")
				)
			)else
			(
				Messagebox "Can't install, installer doesn't have enough accessRights, try to run 3ds max as administrator"
			)
		)else(
			Messagebox "Could not find folder in the Local Temp, extract failed"
		)
		
	)
)
m_FileMaster = FileMaster()
