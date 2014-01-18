struct IncludeMaster(
	m_IncludeArr,
	fn Initiate=(
		m_IncludeArr = #()
	),
	fn Add _path=(
		append m_IncludeArr _path
	),
	fn fileInAll=(
		for includePath in m_IncludeArr do(
			filein includePath
		)
	)
)
m_IncludeMaster = IncludeMaster()
m_IncludeMaster.Initiate()