# -*- coding: utf-8 -*-
from  xml.etree.ElementTree import*
import sys
import string
import os
test="E:\GitHub\VisualFengx_3dmax\VisualFengx\VisualFengx\01.visual"

def getDNS(Dpath):
    paths=[]
    paths.append(Dpath)
    tempPath=os.path.split(Dpath)[0]
    tempType=os.path.splitext(os.path.split(Dpath)[1])[1]
    name=os.path.splitext(os.path.split(Dpath)[1])[0]
    nameParts=string.split(name,"_")
    if len(nameParts)>3:
        typeName=nameParts[len(nameParts)-2]
        tempID=2
        if nameParts[len(nameParts)-2]=="a":
            typeName=nameParts[len(nameParts)-3]
            tempID=3
        tempStr=""
        for ts in typeName:
            if ts=="d":
                tempStr+="n"
            else:        
                tempStr+=ts
        #typeName.replace("d", "n") 
        typeName=tempStr
        #print typeName
        #"n"
        newName=""
        i=0
        for s in nameParts:
            if i==(len(nameParts)-tempID):
                newName+=(typeName+"_")
                #print newName
            else:
                if i==(len(nameParts)-1):
                    newName+=s
                    #print newName
                else:
                    newName+=(s+"_")
                    #print newName
            i+=1
        Npath=tempPath+"/"+newName+tempType
        paths.append(Npath)
        #"s"
        tempStr=""
        for ts in typeName:
            if ts=="n":
                tempStr+="s"
            else:        
                tempStr+=ts
        #typeName.replace("d", "s") 
        typeName=tempStr
        #print typeName
        newName=""
        i=0
        for s in nameParts:
            if i==(len(nameParts)-tempID):
                newName+=(typeName+"_")
                #print newName
            else:
                if i==(len(nameParts)-1):
                    newName+=s
                    #print newName
                else:
                    newName+=(s+"_")
                    #print newName
            i+=1
        Spath=tempPath+"/"+newName+tempType
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
    vf=ElementTree(file=VPath)
    v=ElementTree(file=VPath).getroot()
    
    #dump(v)
    #shaderPath=v.find("renderSet/geometry/primitiveGroup/material/fx").text
    mateID=v.findall("renderSet/geometry/primitiveGroup")
    for mid in mateID:
        #print mid.text
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
            if len(m.findall("property"))<3:
                mapTypes=["	diffuseTexMap","	normalTexMap","	specularTexMap"]
                DPath=""
                for mmap in m.findall("property"):
                    i+=1
                    try:
                        mmap.find("Texture").text
                    except:
                        print " "
                    else:
                        print "xx"
                        DPath=mmap.find("Texture").text
                        mmap.text=mapTypes[0]

                 #m.remove(mmap)
                if DPath!="":
                    maps=getDNS(DPath)
                    i=0
                    for texP in  maps:
                        if i!=0:
                            item= Element("property")
                            item.text=mapTypes[i]
                            texN=Element("Texture")
                            texN.text=texP
                            item.append(texN)
                            m.append(item)
                        i+=1               

          

    outV = ElementTree()
    outV._setroot(indent(v))
    outV.write(outVPath,"utf-8")
#setMaterials("01.visual","test.xml")

def replaceVisual(oldPath):
    tempPath="fengx.temp"
    setMaterials(oldPath,tempPath)
    os.remove(oldPath)
    os.rename(tempPath,oldPath)

#replaceVisual("01.visual")#("E:\GitHub\VisualFengx_3dmax\VisualFengx\VisualFengx\01 -sads.visual")
try:
    sys.argv[1]
except:
    raw_input("don't click me ! dray file up me ! ")
else:
    #print "all\n"
    #f=sys.argv[1]
    #print f
    #raw_input()
    replaceVisual(sys.argv[1])

#raw_input()

