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
            elif i>(len(nameParts)-1):#-aSite):
                bName+="_"+nameParts[i]
        Npath=tempPath+fName+"n"+bName+tempType
        Spath=tempPath+fName+"s"+bName+tempType
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
    vf=ElementTree(file=VPath)
    v=ElementTree(file=VPath).getroot()
    
    #dump(v)
    #shaderPath=v.find("renderSet/geometry/primitiveGroup/material/fx").text
    mateID=v.findall("renderSet/geometry/primitiveGroup")

    changeMapOn=True
    miPaths=[]
    miRootPath="E:/mf_pangu/tw2/res/mi/"


    #-----------only support defult export visual

    #----get mi dirs
    for p in os.listdir(miRootPath):
        miPaths.append((p+"/"))
    for p in os.listdir(miRootPath+"common/"):
        miPaths.append(("common/"+p+"/"))
    

    for mid in mateID:
        #shaderType
        for m in mid:
            m.find("fx").text="	shaders/core/scene_dns.fx	"
            try:
                m.find("collisionFlags").text
            except:
                SubElement(m,"collisionFlags").text=" 0 "
            try:
                m.find("materialKind").text
            except:
                SubElement(m,"materialKind").text=" 0 "
            i=0
            
            DPath=""

            if changeMapOn==True and len(m.findall("property"))<30:

                mapTypes=["	diffuseTexMap","	normalTexMap","	specularTexMap"]
                
                for mmap in m.findall("property"):
                    i+=1
                    try:
                        mmap.find("Texture").text
                    except:
                        print "  "
                    else:
                        DPath=mmap.find("Texture").text
                        LOG+=("\n difusseMap path get from Visual file :   " +DPath)
                        mmap.text=mapTypes[0]

                
                if DPath!="" and os.path.isfile((ROOTDIR+DPath).replace("\t","")):
                    LOG+="\n"+"difusseMap 存在 开始找 其他贴图。。。"

                    miOn=False
                    # check mi 
                    #----set mi
                    try:
                        a=m.find("mi").text
                        if a=="" or a=="\r":
                            miOn=True
                        changeMapOn=False
                    except:
                        miOn=True
                    if miOn:
                        print "xxxxxxx"
                        miPath=""
                        name=os.path.splitext(os.path.split(DPath)[1])[0]
                        for p in miPaths:
                            #print (miRootPath+p+"/"+name+".mi")
                            if os.path.isfile(miRootPath+p+"/"+name+".mi"):
                                miPath="mi/"+p+name+".mi"  
                        #print miPath

                        SubElement(m,"mi").text=miPath
                        LOG+="\n 设置子材质 ： "+miPath

                    #----set normal map and specular map
                    maps=getDNS(DPath)
                    i=0
                    for texP in  maps:
                        if i!=0:
                            item= Element("property")
                            item.text=mapTypes[i]
                            texN=Element("Texture")
                            if os.path.isfile((ROOTDIR+texP)):
                                texN.text=texP
                            else: texN.text=" "
                            item.append(texN)
                            m.append(item)
                        i+=1

            if DPath!="":
                name=os.path.splitext(os.path.split(DPath)[1])[0]
                nameParts=string.split(name,"_")
                
                if len(nameParts)>3:
                    if nameParts[len(nameParts)-2]=="a":
                        try:
                            m.find("	doubleSided").text
                            m.find("	doubleSided").find("Int").text
                        except:
                            item= Element("property")
                            item.text=("	doubleSided")
                            itemA=Element("Int")
                            itemA.text=("	1	")
                            item.append(itemA)
                            m.append(item)
                        else:
                            m.find("	doubleSided").find("Int").text="    1	"
    outV = ElementTree()
    outV._setroot(indent(v))
    outV.write(outVPath,"utf-8")


def replaceVisual(oldPath):
    tempPath="fengx.temp"
    setMaterials(oldPath,tempPath)


    os.remove(oldPath)

    #LOG+="\n 无法移除"+oldPath
    os.rename(tempPath,oldPath)



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


#test="E:\\mf_pangu\\tw2\\res\\scene\\judian\\yhys_layout0080_010.visual"
#replaceVisual(test)
#raw_input()
