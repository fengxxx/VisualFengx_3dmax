#author @liyy hzliyangyang@corp.netease.com
#coding=gbk


########dirHandle
import os
import time
import gzip
import math
import struct
import shutil

from xml.dom.minidom import parse, parseString, Document
respath = "E:/mf_pangu/tw2/res/"
def cleanDir( Dir ):
   if os.path.isdir( Dir ):
      paths = os.listdir( Dir )
      for path in paths:
         filePath = os.path.join( Dir, path )
         if os.path.isfile( filePath ):
            try:
               os.remove( filePath )
            except os.error:
               autoRun.exception( "remove %s error." %filePath )#引入logging
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
#根据2进制字符串算出int
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
   #取反
   while curPos>-1:
      if bstr[curPos] == '0':
         bstr = bstr[0:curPos] +'1' +bstr[curPos+1:len(bstr)]
      else:
         bstr = bstr[0:curPos] +'0' +bstr[curPos+1:len(bstr)]
      curPos -= 1
   return -int(bstr,2)

#从一个32数字中，解压出float3
def unpackNormal(packed):
   strPacked = bin(packed)
   strPacked = strPacked[2:len(strPacked)+1]
   #补齐到32位
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
      #取反
      curPos = len(bstr)-1
      while curPos>-1:
         if bstr[curPos] == '0':
            bstr = bstr[0:curPos] +'1' +bstr[curPos+1:len(bstr)]
         else:
            bstr = bstr[0:curPos] +'0' +bstr[curPos+1:len(bstr)]
         curPos -= 1
      #+1 遇1置0;遇0置1+break;
      curPos = len(bstr)-1
      while curPos>-1:
         if bstr[curPos] == '1':
            bstr = bstr[0:curPos] +'0' +bstr[curPos+1:len(bstr)]
         else:
            bstr = bstr[0:curPos] +'1' +bstr[curPos+1:len(bstr)]
            break
         curPos -= 1
   
   #补上位数,负数右移补1，正数补0
   buChar = "0"
   if og:
      buChar = "1"
   while len(bstr) <long-1:
      bstr = buChar+bstr
      
   #补上符号位
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

   #解析顶点数据
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
      #xyznuv xyznuvtb的读取方法一样
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
      file.close()
   
   #解析index数据
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
         
      
      #assert index之间没有重叠、vertex的使用没有重叠
      if len(groupList)>1:
         curVertexIndex = 0
         curPrimitiveNumber = 0
         for i in range(1,len(groupList)):
            lastGroupInfo = groupList[i-1]
            curGroupInfo = groupList[i]
            #assert 序列绝对相连
            #assert (curGroupInfo[0] - lastGroupInfo[0] == lastGroupInfo[1]*3)
            #assert 顶点序号绝对相连
            #assert (curGroupInfo[2] - lastGroupInfo[2] == lastGroupInfo[3])
            
            if (not (curGroupInfo[0] - lastGroupInfo[0] == lastGroupInfo[1]*3))or (not (curGroupInfo[2] - lastGroupInfo[2] == lastGroupInfo[3])):
               tiaoguo = True
               file.close()
               cleanDir(temppath)
               os.rmdir(temppath)
               return (tiaoguo,vertexs,indexs,groupList,vertexFormat,"","")
      '''
      file.close()
      s=open("d:\\test.txt","wb")
      s.write(str(vertexs)+"\n\n\ngroupList\n\n"+str(groupList)+"\n\n\nvertexFormatClean\n\n"+str(vertexFormatClean)+"\n\n\nindexs\n\n"+str(indexs)+"\n\n\nvertexFormat\n\n"+str(vertexFormat))
      s.close()
      '''
   return (tiaoguo,vertexs,indexs,groupList,vertexFormat,vertexFormatClean,indexFormat)


def writeMtl(modelPath):

   #print modelPath
   
   visualPath = modelPath.replace(".primitives",".visual")
   mtlPath = modelPath.replace(".primitives",".mtl")

   fxName = 0;
   content = open(visualPath,"r+").read()
   content = unicode(content,"cp936").encode("utf-8")
   doc = parseString(content)
   root = doc.documentElement
   texturePathKeys = []
   primitiveGroupCount = 0
   renderSets = root.getElementsByTagName("renderSet")
   primitiveGroups = root.getElementsByTagName("primitiveGroup")
   primitiveGroupCount = len(primitiveGroups)
   
   mtls = []
   
   for renderSet in renderSets:
      geometrys = renderSet.getElementsByTagName("geometry")
      for geometry in geometrys:
         primitiveGroups = geometry.getElementsByTagName("primitiveGroup")
         for primitiveGroup in primitiveGroups:
            primitiveGroupNum = primitiveGroup.firstChild.data.strip()
            materials = primitiveGroup.getElementsByTagName("material")

            for material in materials:
               diffuseMap = ""
               specularMap = ""
               normalMap = ""
               identifier = material.getElementsByTagName("identifier")[0].firstChild.data.strip()
               
               propertys = material.getElementsByTagName("property")
               for property in propertys:
                  propertyName = property.firstChild.data.strip()
                  Textures = property.getElementsByTagName("Texture")
                  if len(Textures) == 0:
                     continue
                  if propertyName.find("diffuse") != -1:
                     diffuseMap = Textures[0].firstChild.data.strip()
                  elif propertyName.find("specular") != -1:
                     specularMap  = Textures[0].firstChild.data.strip()
                  elif propertyName.find("normal") != -1:
                     normalMap  = Textures[0].firstChild.data.strip()
                     
               if diffuseMap == "":
                  diffuseMap = "system/maps/default/white.tga"
               if specularMap == "":
                  specularMap =  diffuseMap
               if normalMap == "":
                  normalMap =  diffuseMap
               
               diffuseMap = diffuseMap.replace("\\","\/")
               #print diffuseMap
               specularMap = specularMap.replace("\/","\\")
               normalMap = normalMap.replace("\/","\\")
               mtls.append((diffuseMap,specularMap,normalMap,identifier))
               
   file = open(mtlPath, "w")
   index = 0
   for mtl in mtls:
      file.write("newmtl "+mtl[3]+"\n")
      file.write("Ns 10.0000\n")
      file.write("Ni 1.5000\n")
      file.write("d 1.0000\n")
      file.write("Tr 0.0000\n")
      file.write("Tf 1.0000 1.0000 1.0000\n")
      file.write("illum 2\n")
      file.write("Kd 0.0000 0.0000 0.0000\n")
      file.write("Ks 0.0000 0.0000 0.0000\n")
      file.write("Ke 0.0000 0.0000 0.0000\n")
      file.write("map_Kd "+ respath+ mtl[0] + "\n")
      #file.write("map_Ks "+ respath + mtl[1] + "\n")
      #file.write("bump "+ respath + mtl[2] + "\n")
      file.write("\n")
      names = mtl[0].split("/")
      filename = names[len(names)-1]
      filename = filename.split(".")[0]
      #shutil.copy(respath+ mtl[0],"D:\\pic\\"+filename+".tga");
      index += 1
   
   file.close()
   
   return mtls
   
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
   
def writeObj(modelinfo,outputPath,mtls,filename):
   global outputPaths
   global tiaoguoCount
   global formatInvalidCount

   tiaoguo,vertexs,indexs,groupList,vertexFormat,vertexFormatClean,indexFormat = modelinfo
      
   if tiaoguo:
      tiaoguoCount = tiaoguoCount+1
      return
   
   if not vertexFormatClean == "xyznuvtb" and not vertexFormatClean == "xyznuv":
      print "find skinned model ：",outputPath, "  跳过处理"
      print vertexFormatClean
      formatInvalidCount = formatInvalidCount+1
      return

   filePath = outputPath
   print filePath
   if os.path.isfile( filePath ):
      os.remove( filePath )
   file = open(filePath, "w")
   
   outputPaths.append(filePath)
   file.write("mtllib "+ filename+".mtl\n")
   for vertex in vertexs:
      #print vertex[0]
      file.write("v ")
      file.write(str(10*vertex[0][0]))
      file.write(" ")
      file.write(str(10*vertex[0][1]))
      file.write(" ")
      file.write(str(-10*vertex[0][2]))
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
   file.write("usemtl "+mtls[0][3]+"\n")
   
   groupPos = []
   curPos = 0
   #找出分割点
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
         file.write("usemtl "+mtls[curGroupIndex][3]+"\n")
         curGroupIndex += 1
      
   
      #obj index从1开始
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
   
   paths = primitivesPath.split("\\")
   binfname = paths[len(paths)-1]
   filename = binfname.replace(".primitives","")
   paths = paths[:len(paths)-1]
   cwd = paths[0]
   for item in paths[1:]:
      cwd += "\\"+item
      
      
   outputPath = primitivesPath.replace(".primitives",".obj")
   tempPath = primitivesPath.replace(".primitives","")
   modelinfo = getModelInfo(primitivesPath,tempPath)
   cleanDir(tempPath)
   os.rmdir(tempPath)
   mtls = writeMtl(primitivesPath,)
   writeObj(modelinfo,outputPath,mtls,filename)



def to_OBJFile(pPath):
   mate=writeMtl(pPath)
   modelData=getModelInfo(pPath,"w")
   oPath=pPath.replace(".primitives",".obj")
   objFile=open(oPath,"w")

   objFile.write("#test for max9 --visualFengx1.53")
   filename=os.path.split(pPath)[1].replace(".primitives","")
   objFile.write("\nmtllib "+ filename+".mtl\n")
   for s in modelData[1]:
      objFile.write("\nv "+str(s[0][0])+" "+str(s[0][1])+" "+str(s[0][2]))

   for s in modelData[1]:
      objFile.write("\nvt "+str(s[1][0])+" "+str(-s[1][1])+" 0.000000")

   for s in modelData[1]:
      objFile.write("\nvn "+str(s[2][0])+" "+str(s[2][1])+" "+str(s[2][2]))

   
   objFile.write("\ng (null)")
   objFile.write("\ns 1\n")


   #for s in  modelData[3]:
      #for 



   
   #print modelData[3]
   i=0
   uvIndex=0
   
   objFile.write(("\nusemtl "+mate[0][3]))
   for s in range(0,(len(modelData[2])/3)):
      #print "i:",i
      if i==modelData[3][uvIndex][1]:
         #print "i,uvIndex : ",i,uvIndex
         i=0
         uvIndex+=1
         objFile.write(("\nusemtl "+mate[uvIndex][3]))
         objFile.write("\ns "+str(uvIndex+2)+"\n")
      #objFile.write("\nf "+str(modelData[2][s*3])+" "+str(modelData[2][s*3+1])+" "+str(modelData[2][s*3+2]) )
      objFile.write("\nf "+str(modelData[2][s*3]+1)+"/"+str(modelData[2][s*3]+1)+"/"+str(modelData[2][s*3]+1))
      objFile.write(" "+str(modelData[2][s*3+1]+1)+"/"+str(modelData[2][s*3+1]+1)+"/"+str(modelData[2][s*3+1]+1) )
      objFile.write(" "+str(modelData[2][s*3+2]+1)+"/"+str(modelData[2][s*3+2]+1)+"/"+str(modelData[2][s*3+2]+1) )      
      i+=1
   
   objFile.write("\ng  "  )
   #print  "v: ",len(modelData[1])
   #print  "f: ",len(modelData[2]),(len(modelData[2])/3-1)

   objFile.close()
#to_OBJFile("H:\\testPrimitives\\jz_jzsj_yw0050_wb.primitives")
if __name__ == "__main__":
   #getModelInfo("H:\\testPrimitives\\bghm_jztj_yw0040_2545.primitives","H:\\testPrimitives\\bghm_jztj_yw0040_2545")
   #to_OBJFile("H:\\testPrimitives\\jz_jzsj_yw0050_wb.primitives")

   helpInfor="only can use -ib<filePath>  to export bigworld file to  obj !"
   try:
      sys.argv[1]
   except:
      print helpInfor
      raw_input("press  Enter to Exit!")
   else:
      #print sys.argv[1]
      if sys.argv[1][:3]=="-ib":#"-explorer-clipboard" or sys.argv[1]=="-ec" :

         to_OBJFile(sys.argv[1][3:]) 
         
         #to_OBJFile()
         #print getText()
         #raw_input("press  Enter to Exit!")
      else:
         print helpInfor