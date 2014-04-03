#coding=utf-8
from  xml.etree.ElementTree import*
import sys
import string
import os

try:
	os.remove('setMaterials LOG'+'.fengx')
except:
	print ""


ROOTDIR="E:/mf_pangu/tw2/res/"
LOG=""
materialChange=False
def getDNS(Dpath):
	paths=[]
	paths.append(Dpath)
	tempPath=os.path.split(Dpath)[0]
	tempType=os.path.splitext(os.path.split(Dpath)[1])[1]
	name=os.path.splitext(os.path.split(Dpath)[1])[0]
	nameParts=string.split(name,"_")
	if len(nameParts)>3:
		isaOn=False
		typeName=nameParts[len(nameParts)-2]
		tempID=len(nameParts)-2
		if nameParts[len(nameParts)-2]=="a":
			typeName=nameParts[len(nameParts)-3]
			tempID=len(nameParts)-3
			isaOn=True
		fName=""
		bName=""
		for i in range (0,len(nameParts)):
			aSite=2
			if isaOn:
				aSite=3		
			if i<(len(nameParts)-aSite):
				fName+=nameParts[i]+"_"
			elif i>(len(nameParts)-2):#-aSite):
				bName+="_"+nameParts[i]
		Npath=tempPath+"/"+fName+nameParts[(len(nameParts)-aSite)].replace("d","n")+bName+tempType
		Spath=tempPath+"/"+fName+nameParts[(len(nameParts)-aSite)].replace("d","s")+bName+tempType
		paths.append(Npath)
		paths.append(Spath)

		return paths

def indent(elem, level=0):
	i = "\n" + level*"  "
	if len(elem):
		if not elem.text or not elem.text.strip():
			elem.text = i + "  "
		for e in elem:
			indent(e, level+1)
		if not e.tail or not e.tail.strip():
			e.tail = i
	if level and (not elem.tail or not elem.tail.strip()):
		elem.tail = i
	return elem

def setMaterials(VPath,outVPath):   
	global LOG
	global materialChange
	vf=ElementTree(file=VPath)
	v=ElementTree(file=VPath).getroot()
	
	#dump(v)
	#shaderPath=v.find("renderSet/geometry/primitiveGroup/material/fx").text
	mateID=v.findall("renderSet/geometry/primitiveGroup")


	miPaths=[]
	miRootPath="E:/mf_pangu/tw2/res/mi/"

	mapTypes=[" diffuseTexMap","	normalTexMap"," specularTexMap"]
	DPath=""
	#-----------only support defult export visual

	#----get mi dirs
	for p in os.listdir(miRootPath):
		miPaths.append((p+"/"))
	for p in os.listdir(miRootPath+"common/"):
		miPaths.append(("common/"+p+"/"))
	
	
	for mid in mateID:
		#shaderType
		
		for m in mid:
			LOG+=("\n 开始搞起。。。。。。。:   ")
			changeMapOn=True
			#---material 
			for mmap in m.findall("property"):
				try:
					m.find("fx").text
				except:
					LOG+=("\n 找不到 材质类型 :   ")
					changeMapOn=False
				else:
					if m.find("fx").text=="	shaders/std_effects/lightonly.fx	":
						changeMapOn=True
						#LOG+=("\n 材质为默认的 :   " +m.find("fx").text)
					else:
						changeMapOn=False
				try:
					mmap.find("Texture").text
				except:
					#print mmap.text
					#print m.text
					if changeMapOn==True:
						  LOG+=("\n 找不到diffuse 地址 :   ")
					changeMapOn=False
				else:
					DPath=mmap.find("Texture").text.replace("\t","")
					if  os.path.isfile((ROOTDIR+DPath).replace("\t","")) and changeMapOn==True:
						LOG+=("\n difusseMap 地址 :   " +DPath)
						m.find("fx").text="	shaders/core/scene_dns.fx	"
						
						try:
							m.find("collisionFlags").text
						except:
							SubElement(m,"collisionFlags").text=" 0 "
						
						try:
							m.find("materialKind").text
						except:
							SubElement(m,"materialKind").text=" 0 "
						mmap.text=mapTypes[0]
						materialChange=True
			if changeMapOn==True:
				for mmap in m.findall("property"):
					if len(m.findall("property"))<3:
						LOG+=("\n 开始修改材质了。。。。")
						miOn=False
						# check mi 
						#----set mi
						try:
							a=m.find("mi").text
							#b=m.find("mixxx").text
							#if a=="" or a=="\r":
								#miOn=True
							#changeMapOn=False
						except:
							miPath=""
							name=os.path.splitext(os.path.split(DPath)[1])[0]
							for p in miPaths:
								#print (miRootPath+p+"/"+name+".mi")
								if os.path.isfile((miRootPath+p+"/"+name+".mi").replace("\t","")):
									miPath="mi/"+p+name+".mi"  
									SubElement(m,"mi").text=miPath
									LOG+="\n 设置子材质 ： "+miPath
									miOn=True
						if miOn==False:
							LOG+="\n 子材质不存在开始找贴图  设置属性： "
							#----set normal map and specular map
							maps=getDNS(DPath)
							#LOG+="\n找到的法线高光"+str(maps)
							i=0
							LOG+="\n 设置贴图。。。"
							for texP in  maps:
								if i!=0:
									item= Element("property")
									item.text=mapTypes[i]
									texN=Element("Texture")
									if os.path.isfile((ROOTDIR+texP).replace("\t","")):
										LOG+="\n 	设置贴图。。。"+mapTypes[i] + " : "+texP
										texN.text=texP
										item.append(texN)
										m.append(item)
									else: 
										LOG+="\n 	设置贴图。。。"+mapTypes[i] + " : 没找到"
										texN.text="   "
										item.append(texN)
										m.append(item)
								i+=1

							#---set alhpa
							name=os.path.splitext(os.path.split(DPath)[1])[0]
							nameParts=string.split(name,"_")
							if len(nameParts)>3:
								if nameParts[len(nameParts)-2]=="a":
									LOG+="\n 有alpha 设置为透明 "
									try:
										m.find("	doubleSided").text
										m.find("	doubleSided").find("Int").text
									except:
										item= Element("property")
										item.text=("	doubleSided")
										itemA=Element("Int")
										itemA.text=("   1   ")
										item.append(itemA)
										m.append(item)
									else:
										m.find("	doubleSided").find("Int").text="	1   "
	outV = ElementTree()
	#print materialChange
	#if materialChange==True:
	outV._setroot(indent(v))
	LOG+="\n 存储 材质到临时文件 "
	outV.write(outVPath,"utf-8")
def replaceVisual(oldPath):
	global LOG
	tempPath="fengx.temp"
	setMaterials(oldPath,tempPath)
	LOG+="\n 开始替换材质已经修改好的材质 "
	try:
		os.remove(oldPath)
		os.rename(tempPath,oldPath)
	except:
		LOG+="\n 替换失败"
	else:
		LOG+="\n 替换成功"

try:
	sys.argv[1]
except:
	raw_input("don't click me ! dray file up me ! ")
else:
	replaceVisual(sys.argv[1])
	l = open('setMaterials LOG'+'.fengx', 'w')
	l.write(LOG)
	l.close()
	#raw_input()

'''
test="E:\\mf_pangu\\tw2\\res\\scene\\common\\jz\\jztj\\tjcs\\cjsd_jztj_cs0010_1748.visual"
replaceVisual(test)
l = open('setMaterials LOG'+'.fengx', 'w')
l.write(LOG)
l.close()
'''