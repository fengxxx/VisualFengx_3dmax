#author @liyy hzliyangyang@corp.netease.com
#coding=gbk


########dirHandle
import os
import time
import gzip
import math
import struct
import shutil


def cleanDir( Dir ):
	if os.path.isdir( Dir ):
		paths = os.listdir( Dir )
		for path in paths:
			filePath = os.path.join( Dir, path )
			if os.path.isfile( filePath ):
				try:
					os.remove( filePath )
				except os.error:
					autoRun.exception( "remove %s error." %filePath )#����logging
			elif os.path.isdir( filePath ):
				if filePath[-4:].lower() == ".svn".lower():
					continue
				shutil.rmtree(filePath,True)

















##################





#######binsesc
import os, struct, sys

MAGIC = '\x65\x4e\xa1\x42' # binary section magic number

def pad(size, padding = 4):
    return ((padding-size)%padding)

def extract(fname, dirname):

    f = open(fname, 'rb')
    assert MAGIC == f.read(4)

    # read indeices size
    f.seek(-4, os.SEEK_END)
    index_size = struct.unpack('L', f.read(4))[0]
    assert((index_size % 4) == 0)
    f.seek(-4-index_size, os.SEEK_END)
    # read indices
    readsize = 0
    sec_list = [] # [(name, offset, size), ...]
    calc_size = 0 # calculate the size we get for verification
    calc_size += len(MAGIC) # magic
    while readsize < index_size:
        nums = struct.unpack('L'*6,f.read(4*6))
        readsize += 4*6
        sec_size = nums[0]
        secname_size = nums[5]
        # read secname
        secname = f.read(secname_size)
        readsize += secname_size
        pad_size = pad(secname_size)
        f.read(pad_size) # pad to 4bytes
        readsize += pad_size
        
        sec_list.append((secname, calc_size, sec_size)) #(name, offset, size)
        calc_size += sec_size + pad(sec_size) # sections are also pad to 4bytes

    # print sec_list

    calc_size += index_size
    calc_size += 4 # index_size dword
    # check file size correct
    f.seek(0, os.SEEK_END)
    fsize = f.tell()
    assert fsize == calc_size # check if size match

    # create target dirs
    os.makedirs(dirname)
    for name, offset, secsize in sec_list:
        # save each section
        #print 'writing: %s, offset %d, size %d' % (name, offset, secsize)
        f.seek(offset)
        content = f.read(secsize)
        open(dirname+'/'+name, 'wb').write(content)
    
    f.close()

def create(fname, dirname):
    f = open(fname, 'wb')
    f.write(MAGIC) # binsec magic
    
    secnames = []
    for secname in os.listdir(dirname):
        if os.path.isfile(dirname+'/'+secname):
            secnames.append(secname)
        else:
            print 'skipping', secname
    
    sections = [] # [(name, offset, size),...]
    # writing each section contents
    for secname in secnames:
        content = open(dirname+'/'+secname,'rb').read()
        secsize = len(content)
        offset = f.tell()
        assert((offset % 4) == 0) # check padding
       # print 'packing %s, offset %d, size %d' % (secname, offset, secsize)
        f.write(content)
        # add padding
        padsize = pad(secsize)
        f.write('\x00'*padsize)
        
        sections.append((secname, offset, secsize))
        
    # generate index
    index = ''
    for secname, offset, secsize in sections:
        index += struct.pack('L'*6, secsize, 0,0,0,0, len(secname))
        index += secname
        index += '\x00' * pad(len(secname))

    index_size = len(index)
    f.write(index)
    f.write(struct.pack('L', index_size))
    f.close()
  

#########binsec




##############primitivesHandle


def getFourPatch(number):
	excessFour = number%4
	if(excessFour == 0):
		return 0
	else:
		return 4-excessFour




format = "3f1I2f1I1I"
#����2�����ַ������int
def getIntbyBStr(bstr):
	egChar = bstr[0]
	bstr = bstr[1:len(bstr)]
	if egChar == '0':
		return int(bstr,2)
	
	#-1
	curPos = len(bstr)-1
	while curPos>-1:
		#print bstr
		if bstr[curPos] == '0':
			bstr = bstr[0:curPos] +'1' +bstr[curPos+1:len(bstr)]
		else:
			bstr = bstr[0:curPos] +'0' +bstr[curPos+1:len(bstr)]
			break
		curPos -= 1
	curPos = len(bstr)-1
	#ȡ��
	while curPos>-1:
		if bstr[curPos] == '0':
			bstr = bstr[0:curPos] +'1' +bstr[curPos+1:len(bstr)]
		else:
			bstr = bstr[0:curPos] +'0' +bstr[curPos+1:len(bstr)]
		curPos -= 1
	return -int(bstr,2)

#��һ��32�����У���ѹ��float3
def unpackNormal(packed):
	strPacked = bin(packed)
	strPacked = strPacked[2:len(strPacked)+1]
	#���뵽32λ
	while len(strPacked) <32:
		strPacked = "0"+strPacked

	z = getIntbyBStr(strPacked[0:10])#10
	y = getIntbyBStr(strPacked[10:21])#11
	x = getIntbyBStr(strPacked[21:32])#11

	return (float( x ) / 1023.0, float( y ) / 1023.0, float( z ) / 511.0)

def getBStrbyInt(pvalue,long):
	#print pvalue
	pvalue = int(pvalue)

	bstr = bin(pvalue)
	og = False
	
	if bstr[0] == "-":
		og = True
		bstr = bstr[3:len(bstr)]
	else:
		bstr = bstr[2:len(bstr)]
	
	if og:
		#ȡ��
		curPos = len(bstr)-1
		while curPos>-1:
			if bstr[curPos] == '0':
				bstr = bstr[0:curPos] +'1' +bstr[curPos+1:len(bstr)]
			else:
				bstr = bstr[0:curPos] +'0' +bstr[curPos+1:len(bstr)]
			curPos -= 1
		#+1 ��1��0;��0��1+break;
		curPos = len(bstr)-1
		while curPos>-1:
			if bstr[curPos] == '1':
				bstr = bstr[0:curPos] +'0' +bstr[curPos+1:len(bstr)]
			else:
				bstr = bstr[0:curPos] +'1' +bstr[curPos+1:len(bstr)]
				break
			curPos -= 1
	
	#����λ��,�������Ʋ�1��������0
	buChar = "0"
	if og:
		buChar = "1"
	while len(bstr) <long-1:
		bstr = buChar+bstr
		
	#���Ϸ���λ
	if og:
		bstr = "1"+bstr
	else:
		bstr = "0"+bstr
	
	return bstr

	
def packNormal((x,y,z)):
	x = x*1023.0
	y = y*1023.0
	z = z*511.0
	
	zbStr = getBStrbyInt(z,10)
	ybStr = getBStrbyInt(y,11)
	xbStr = getBStrbyInt(x,11)
	packedNormal = int(zbStr+ybStr+xbStr,2)

	return packedNormal




def getModelInfo(modelpath,temppath):

	indexList = []
	vertexList = []
	vertexs = []
	indexs = []
	groupList = []
	tiaoguo = False
	indexFormat = ""

	cleanDir(temppath)
	if os.path.isdir(temppath):
		os.rmdir(temppath)

	
	extract(modelpath,temppath)
	list = os.listdir(temppath)
	
	
	for listItem in list:
		if listItem.find("vertices") != -1:
			vertexList.append(listItem)
		elif listItem.find("indices") != -1:
			indexList.append(listItem)

	#������������
	for vertexItem in vertexList:
		file = open(temppath+"\\"+vertexItem, "rb")
		dataVh = file.read(68)
		dataVhValue = struct.unpack("64s1i",dataVh)
		vertexFormat = dataVhValue[0]
		vertexNumber = dataVhValue[1]
		
		vertexFormatClean = ""
		for char in vertexFormat:
			if char <='z' and char >= 'a':
				vertexFormatClean = vertexFormatClean+char
			else:
				break
		#print vertexFormatClean
		
		#print vertexFormat[7]
		#print vertexFormat[8]
		#print vertexNumber
		#xyznuv xyznuvtb�Ķ�ȡ����һ��
		for i in range(0,vertexNumber):
			vertexDataStr = file.read(32)
			if len(vertexDataStr) != 32:
				tiaoguo = True
				break
			vertexDataValue = struct.unpack("3f1I2f1I1I",vertexDataStr)
			vPos = (vertexDataValue[0],vertexDataValue[1],vertexDataValue[2])
			vUV = (vertexDataValue[4],vertexDataValue[5])
			vNormal = unpackNormal(vertexDataValue[3])
			vT = unpackNormal(vertexDataValue[6])
			vB = unpackNormal(vertexDataValue[7])
			vertexs.append((vPos,vUV,vNormal,vT,vB))
		print vertexs
		file.close()
		raw_input()
	#����index����
	for indexItem in indexList:
		if tiaoguo:
			break
	
		file = open(temppath+"\\"+indexItem, "rb")
		
		dataIh = file.read(64+4+4)
		dataVhValue = struct.unpack("64s2i",dataIh)
		#print dataVhValue
		indexFormat = dataVhValue[0]
		#print indexformat
		indexNumber = dataVhValue[1]
		groupNumber = dataVhValue[2]

		
		for i in range(0,indexNumber):
			indexDataStr = file.read(2)
			indexDataValue = struct.unpack("H",indexDataStr)[0]
			indexs.append(indexDataValue)
			
		for i in range(0,groupNumber):
			groupInfo = []
			for j in range(0,4):
				indexDataStr = file.read(4)
				indexDataValue = struct.unpack("i",indexDataStr)[0]
				groupInfo.append(indexDataValue)
			groupList.append(groupInfo)
			
		
		#assert index֮��û���ص���vertex��ʹ��û���ص�
		if len(groupList)>1:
			curVertexIndex = 0
			curPrimitiveNumber = 0
			for i in range(1,len(groupList)):
				lastGroupInfo = groupList[i-1]
				curGroupInfo = groupList[i]
				#assert ���о�������
				#assert (curGroupInfo[0] - lastGroupInfo[0] == lastGroupInfo[1]*3)
				#assert ������ž�������
				#assert (curGroupInfo[2] - lastGroupInfo[2] == lastGroupInfo[3])
				
				if (not (curGroupInfo[0] - lastGroupInfo[0] == lastGroupInfo[1]*3))or (not (curGroupInfo[2] - lastGroupInfo[2] == lastGroupInfo[3])):
					tiaoguo = True
					file.close()
					cleanDir(temppath)
					os.rmdir(temppath)
					return (tiaoguo,vertexs,indexs,groupList,vertexFormat,"","")
		
		file.close()
	return (tiaoguo,vertexs,indexs,groupList,vertexFormat,vertexFormatClean,indexFormat)

	
	
#######primitivesHandle
	
	
	










import os
import sys
import time
import gzip
import math
import struct



tiaoguoCount = 0
formatInvalidCount = 0

flipTexture = True
outputPaths = []
	
def writeObj(modelinfo,outputPath):
	global outputPaths
	global tiaoguoCount
	global formatInvalidCount

	tiaoguo,vertexs,indexs,groupList,vertexFormat,vertexFormatClean,indexFormat = modelinfo
		
	if tiaoguo:
		tiaoguoCount = tiaoguoCount+1
		return
	
	if not vertexFormatClean == "xyznuvtb" and not vertexFormatClean == "xyznuv":
		print "find skinned model ��",outputPath, "  ��������"
		print vertexFormatClean
		formatInvalidCount = formatInvalidCount+1
		return

	filePath = outputPath
	print filePath
	if os.path.isfile( filePath ):
		os.remove( filePath )
	file = open(filePath, "w")
	
	outputPaths.append(filePath)
	
	for vertex in vertexs:
		#print vertex[0]
		file.write("v ")
		file.write(str(vertex[0][0]))
		file.write(" ")
		file.write(str(vertex[0][1]))
		file.write(" ")
		file.write(str(vertex[0][2]))
		file.write("\n")
		
	for vertex in vertexs:
		#print vertex[0]
		file.write("vt ")
		file.write(str(vertex[1][0]))
		file.write(" ")
		if flipTexture:
			file.write(str(1-vertex[1][1]))
		else:
			file.write(str(vertex[1][1]))
		file.write("\n")
		
	for vertex in vertexs:
		#print vertex[0]
		file.write("vn ")
		file.write(str(vertex[2][0]))
		file.write(" ")
		file.write(str(vertex[2][1]))
		file.write(" ")
		file.write(str(vertex[2][2]))
		file.write("\n")
	
	file.write("g model0\n")
	file.write("usemtl initialShadingGroup0\n")
	
	groupPos = []
	curPos = 0
	#�ҳ��ָ��
	for i in range(0,len(groupList)-1):
		curPos = curPos+groupList[i][1]
		groupPos.append(curPos)
	
	curGroupIndex = 1
	primitivenumber = len(indexs)/3
	for index in range(0,primitivenumber):
		reachGroupFenge = False
		for i in range(0,len(groupPos)):
			if groupPos[i] == index:
				reachGroupFenge = True
		if reachGroupFenge:
			file.write("g model"+str(curGroupIndex)+"\n")
			file.write("usemtl initialShadingGroup"+str(curGroupIndex)+"\n")
			curGroupIndex += 1
		
	
		#obj index��1��ʼ
		one = str(indexs[3*index]+1)
		two = str(indexs[3*index+1]+1)
		thr = str(indexs[3*index+2]+1)
		file.write("f ")
		file.write("%s/%s/%s "%(one,one,one))
		file.write("%s/%s/%s "%(two,two,two))
		file.write("%s/%s/%s"%(thr,thr,thr))
		file.write("\n")
	
	file.close()
	
def doconvert(primitivesPath):
	outputPath = primitivesPath.replace(".primitives",".obj")
	tempPath = primitivesPath.replace(".primitives","")
	modelinfo = getModelInfo(primitivesPath,tempPath)
	cleanDir(tempPath)
	os.rmdir(tempPath)
	writeObj(modelinfo,outputPath)



#doconvert("E:\\primitives\\ycj_jzsj_yw020_wb.primitives")

if __name__ == "__main__":
	param, binfname = sys.argv[0:]
	doconvert(binfname)