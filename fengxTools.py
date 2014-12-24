#coding=utf-8
import sys
# reload(sys)
# sys.setdefaultencoding('utf-8')
import os,string,re
import win32clipboard 
import win32con
import _winreg
import pythoncom

import codecs 
import xml.etree.ElementTree as ET 

from  xml.etree.ElementTree import*
from win32com.shell import shell   
from win32com.shell import shellcon 

modelEditorPath="bigworld/tools/modeleditor/modeleditor.exe"
Rdir="tw2\\res\\scene\\common\\"

dirs=["wj\\wjdx\\","wj\\wjgy\\","wj\\wjjy\\","wj\\wjwy\\" ,
    "zw\\zwgm\\","zw\\zwhc\\","zw\\zwshu\\","zw\\zwts\\",
    "jz\\jzsj\\sjcs\\","jz\\jzsj\\sjyw\\","jz\\jztj\\tjcs\\",
    "jz\\jztj\\tjyw\\","db\\dbcd\\","db\\dblm\\","db\\dbsk\\",
    "db\\dbst\\",""]

#----model
path_model=""
#  5   2/2+3+4   or  2/2+3+4/3+5    cjsd_jzsj_cs0240_5301.visual
p_model=r"([a-z]{0,})_([a-z]{2})([a-z]{2})([a-z]{0,})[_]{0,1}([a-z]{0,2})[0-9]{3,5}_[0-9wb]{2,}"      
p_model_ex=r"([a-z]{0,})_([a-z]{0,})[_]{0,1}([a-z]{0,2})[0-9]{3,5}_[0-9wb]{2,}"      

#----textrue
path_textrue=""
#  5   2/2+3+4/ or 2/2+3+4/3+5    cjsd_zwshu_sd002_d_a_1643
p_textrue=r"([a-z]{0,})_([a-z]{2})([a-z]{2})([a-z]{0,})[_]{0,1}([a-z]{0,2})[0-9]{3,5}_[\d]{0,}[dsnem]{1}_(a){0,1}[_]{0,1}[0-9wb]{2,}"      
p_textrue_type=r"([a-z]{1,}_)([a-z_]{1,}[0-9]{3,5}_[\d]{0,})[dsnem]{1}[_a]{0,2}([_]{1}[0-9wb]{2,})"

#----skybox
path_skybox=""
  #8bceb3f9.4b3c1047.1045dbb3.80065214.xml
p_skybox=r"[a-zA-Z0-9]{8}\.[a-zA-Z0-9]{8}\.[a-zA-Z0-9]{8}\.[a-zA-Z0-9]{8}"                        

#----effect
path_effect=""
 #com_tjy001_1774.xml
p_effect=r"([a-zA-Z]{0,})_([a-zA-Z]{0,})([0-9]{0,})_([0-9]{0,})"                           

#----chunk
path_chunk=""

#  1   3/1+"\sep\"2  or  3/2  ffexffex/sep/ffe1ffefo@ycdg@0x0AD77A50     00ff00ffo@fb_jz_02 - Copy_2@0x072A3EE8
p_chunk=r"([a-z0-9]{0,8})[/sep/]{0,5}([a-f0-9]{8})o@(.{0,})@[xA-Z0-9]{0,}"                                                  


FILE_TYPE= {
"none":0,
"model":1,
"textrue":2,
"skybox":3,
"effect":4,
"chunk":5
}
# FILE_EXT= {
# "none":"",
# "model":".model",
# "textrue":".tga",
# "skybox":".xml",
# "effect":".xml",
# "chunk":".cdata"
# }
FILE_EXT= ["",".model",".tga",".xml",".xml",".chunk"]
flora=["hua","cao","zwhc","zwsc"]

skybox=["skybox"]


def getmfDirB():
    mf_dir=""
    if os.path.isfile(os.getcwd()+"\\fengx.fengx"):
        f=open(os.getcwd()+"\\fengx.fengx","rb")
        line = f.readline()
        while line:
            if len(line)>6 and line[:5]=="mfDIR":
                mf_dir=line[6:].replace("\r","").replace("\n","")
            line = f.readline()
    else:
        ()#print "cant find the setting file (fengx.fengx)"
    return mf_dir
 

def getmfDir():
    mf_dir=""
    if os.path.isfile(os.getcwd()+"\\fengxTools.txt"):
        f=open(os.getcwd()+"\\fengxTools.txt","rb")
        line = f.readline()
        while line:
            if len(line)>7 and line[:7]=="rootDir":
                mf_dir=line[8:].replace("\r","").replace("\n","")
            line = f.readline()
    else:
        getmfDirB()
    return mf_dir
 

tdir=getmfDir()
#print tdir
if tdir=="":
        tdir="e:\\mf_pangu\\"
Rdir=tdir+Rdir

ROOTDIR="tw2\\res\\"

rootPath=tdir+ROOTDIR

def getText():
    win32clipboard.OpenClipboard()
    d=""
    try:
        d = win32clipboard.GetClipboardData(win32con.CF_TEXT)
    except:
        d=(win32clipboard.GetClipboardData(win32con.CF_HDROP))[0]
        
    win32clipboard.CloseClipboard()
    return d

def setText(aString):
    win32clipboard.OpenClipboard()
    win32clipboard.EmptyClipboard()
    win32clipboard.SetClipboardData(win32con.CF_TEXT, aString)
    win32clipboard.CloseClipboard()

# ----get save path from file(model) name
def getPathFromName(name,rootPath):
    path=""
    if name=="" or name==None:
        #print "error name"
        return path
    else:
        fpath,fname=os.path.split(name)
        jname,ext=os.path.splitext(fname)
    rem=re.match(p_model,jname)
    if rem:
        reGroup=rem.groups()
         #  5   2/2+3+4   or  2/2+3+4/3+5 
        tarDir=reGroup[1]+reGroup[2]+reGroup[3]
        #print tarDir
        if reGroup[4]=="":
            if tarDir=="skybox":
                path="env\\skybox"
            else:
                fOn=False
                for f in flora:
                    if tarDir==f:
                        fOn=True
                        break
                if fOn==True:
                    path=os.path.join("flora",reGroup[0])
                    if os.path.isdir(rootPath+path)==False:
                        path="flora"
                else:
                    path=os.path.join("scene\\common",reGroup[1],(reGroup[1]+reGroup[2]+reGroup[3]))
        else:
            path=os.path.join(reGroup[1],(reGroup[1]+reGroup[2]+reGroup[3]),(reGroup[2]+reGroup[4]))
    else:
        rem=re.match(p_model_ex,jname)
        if rem:
            reGroup=rem.groups()
            path=os.path.join("flora",reGroup[0])
            if os.path.isdir(rootPath+path)==False:
                path="flora"
    return path

#----find the file(model effect tga) path from file name
def findPathFromName(name,rootPath):
    path=""
    fileType=FILE_TYPE["none"]
    if name=="" or name==None:
        #print "error name"
        return path
    else:
        fpath,fname=os.path.split(name)
        jname,ext=os.path.splitext(fname)
    rem=re.match(p_model,jname)
    fileType=FILE_TYPE["model"]
    if rem:
        reGroup=rem.groups()
        #  5   2/2+3+4   or  2/2+3+4/3+5 
        tarDir=reGroup[1]+reGroup[2]+reGroup[3]
        #print tarDir
        if reGroup[4]=="":
            if tarDir=="skybox":
                path="env\\skybox"
            else:
                fOn=False
                for f in flora:
                    if tarDir==f:
                        fOn=True
                        break
                if fOn==True:
                    path=os.path.join("flora",reGroup[0])
                    if os.path.isdir(rootPath+path)==False:
                        path="flora"
                else:
                    path=os.path.join("scene\\common",reGroup[1],(reGroup[1]+reGroup[2]+reGroup[3]))
        else:
            path=os.path.join("scene\\common",reGroup[1],(reGroup[1]+reGroup[2]+reGroup[3]),(reGroup[2]+reGroup[4]))
    else:
        rem=re.match(p_model_ex,jname)
        fileType=FILE_TYPE["model"]
        if rem:
            reGroup=rem.groups()
            path=os.path.join("flora",reGroup[0])
            if os.path.isdir(rootPath+path)==False:
                path="flora"
        else:
            rem=re.match(p_textrue,jname)
            fileType=FILE_TYPE["textrue"]
            if rem:
                reGroup=rem.groups()
                #  5   2/2+3+4/ or 2/2+3+4/3+5  
                if reGroup[4]=="":
                    tarDir=(reGroup[1]+reGroup[2])
                    if tarDir=="skybox":
                        path="env\\skybox"
                    else:
                        fOn=False
                        for f in flora:
                            if tarDir==f:
                                fOn=True
                                break
                        if fOn==True:
                            path=os.path.join("flora",reGroup[0])
                            if os.path.isdir(rootPath+path)==False:
                                path="flora"
                        else:
                            path=os.path.join("scene\\common",reGroup[1],(reGroup[1]+reGroup[2]+reGroup[3]))
                            if os.path.isdir(rootPath+path)==False:
                                path=""
                else:
                    path=os.path.join("scene\\common",reGroup[1],(reGroup[1]+reGroup[2]+reGroup[3]),(reGroup[2]+reGroup[4]))
                    if os.path.isdir(rootPath+path)==False:
                        path="" 
            else:
                print path
                rem=re.match(p_skybox,jname)
                fileType=FILE_TYPE["skybox"]
                if rem:
                    path="universes\\eg"
                else:
                    path=""
    print fileType
    return path,fileType

    # find file path from file(all) name
def findFilePath(name,rootPath):
    path=""
    flieType=FILE_TYPE["none"]
    paths=["flora","env\\skybox","scene\\common",]
    if name=="" or name==None:
        #print "error name"
        return path
    else:
        fpath,fname=os.path.split(name)
        jname,ext=os.path.splitext(fname)
    rem=re.match(p_chunk,name)
    if rem:
        path,flieType=findPathFromName(name,rootPath)
        jname=rem.groups()[1]+"o"
        flieType=FILE_TYPE["chunk"]
        if rem:
            reGroup=rem.groups()
            #  1   3/1+"\sep\"   or  3 
            if reGroup[0]=="":
                path=os.path.join("universes\\eg",reGroup[2])
            else:
                path=os.path.join("universes\\eg",reGroup[2],reGroup[0],"sep")
    else:
        path,flieType=findPathFromName(jname,rootPath)
    if ext=="":
        ext=FILE_EXT[flieType]
        
    find=False
    if path!="":
       #print (rootPath+path),path,flieType,ext
       for s in os.walk((rootPath+path)):
            path=s[0]+"\\"+jname+ext
            if os.path.isfile(path):
                find=True
                return path
    if find==False:
        for p in paths:
           for s in os.walk((rootPath+p)):
                path=s[0]+"\\"+jname+ext
                #print path

                if os.path.isfile(path):
                    find=True
                    return path
    if find==False:
        return ""


def getAbsolutePath(name):
    global rootPath

    path=""
    if name=="" or name==None:
        #print "error name"
        return path
    else:
        fpath,fname=os.path.split(name)
        jname,ext=os.path.splitext(fname)
    rem=re.match(p_model,jname)
    path=findFilePath(name,rootPath)
    print "test: ",name,"xx",path
    return path
def getRelativePath(p):
    return  getAbsolutePath(p).replace((tdir+"tw2\\res\\"),"").replace("\\","/")


def showInExplorer(c):
    c=c.replace('\"', '')
    c=c.replace('.visual', '.model')
    c=c.replace('.primitives', '.model')
    c=c.replace('.thumbnail.jpg', '.model')

    c=getAbsolutePath(c)
    print c
    if c!="":
        c= "explorer.exe"+"/select,"+c
        os.system(c.replace("\n",""))
    else:
        print "path was none"


def openModeEditor(p):
    #print p
    global modelEditorPath
    modelEditorPath=tdir+modelEditorPath
    c=p
    c=c.replace('\"', '')
    c=c.replace('.visual', '.model')
    c=c.replace('.primitives', '.model')
    c=c.replace('.thumbnail.jpg', '.model')
    #print "c: ",c
    if os.path.isfile(c) and c.find(".model")!=-1:
        c=modelEditorPath+ " -o"+c.replace('/', '\\')
        os.system(c)
        
    else:
        
        c=getAbsolutePath(c)
        if c!="":
            c= "start "+ modelEditorPath+ " -o"+c.replace('/', '\\')
            os.system(c)
        else:
            print "path was none"
            os.system(("start "+modelEditorPath))

#--------------change visual file Material
#ROOTDIR=Rdir #"tw2/res/"
LOG=""
materialChange=False

#--- rootPath "E:\\mf_pangu\\tw2\\res\\"
def getDNS(Dpath):
    paths=[]
    if Dpath=="" or Dpath==None:
        #print "error name"
        return ""
    else:
        fpath,fname=os.path.split(Dpath)
        jname,ext=os.path.splitext(fname)
        rem=re.match(p_textrue_type,jname)
        if rem:
            paths.append(Dpath)
            reGroup=rem.groups()
            paths.append((fpath+"\\"+(reGroup[0]+reGroup[1]+"n"+reGroup[2])+ext))
            paths.append((fpath+"\\"+(reGroup[0]+reGroup[1]+"s"+reGroup[2])+ext))
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
    global ROOTDIR  
    global LOG
    global materialChange
    vf=ElementTree(file=VPath)
    v=ElementTree(file=VPath).getroot()
    
    #print dump(v)
    #shaderPath=v.find("renderSet/geometry/primitiveGroup/material/fx").text
    mateID=v.findall("renderSet/geometry/primitiveGroup")


    miPaths=[]
    miRootPath="e:/mf_pangu/tw2/res/mi/"

    mapTypes=["\tdiffuseTexMap","\tnormalTexMap","\tspecularTexMap"]
    DPath=""
    #-----------only support defult export visual

    #----get mi dirs
    for miPath in os.walk(miRootPath): miPaths.append(miPath[0])
    
    for mid in mateID:
        #shaderType
        
        for m in mid:
            LOG+=("\n start............:   ")
            changeMapOn=True
            #---material 
            for mmap in m.findall("property"):
                try:
                    m.find("fx").text
                except:
                    LOG+=("\n   can't find material type :   ")
                    changeMapOn=False
                else:
                    if m.find("fx").text.replace("\t","")=="shaders/std_effects/lightonly.fx":
                        changeMapOn=True
                    else:
                        changeMapOn=False
                try:
                    mmap.find("Texture").text
                except:
                    #print mmap.text
                    #print m.text
                    if changeMapOn==True:
                          LOG+=("\n     can't find diffuse path :   ")
                    changeMapOn=False
                else:
                    DPath=mmap.find("Texture").text.replace("\t","")
                    if  os.path.isfile((ROOTDIR+DPath).replace("\t","")) and changeMapOn==True:
                        LOG+=("\n   difusseMap path :   " +DPath)
                        m.find("fx").text="\tshaders/core/scene_dns.fx\t"
                        
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
                        LOG+=("\n   start change material......")
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
                                    LOG+="\n        set material son: "+miPath
                                    miOn=True
                        if miOn==False:
                            LOG+="\n        can't find the material son  so starting set map:"
                            #----set normal map and specular map
                            maps=getDNS(DPath)
                            #LOG+="\n找到的法线高光"+str(maps)
                            i=0
                            LOG+="\n            set map...."
                            for texP in  maps:
                                if i!=0:
                                    item= Element("property")
                                    item.text=mapTypes[i]
                                    texN=Element("Texture")
                                    if os.path.isfile((ROOTDIR+texP).replace("\t","")):
                                        LOG+="\n                set map ....."+mapTypes[i] + " : "+texP
                                        texN.text=texP
                                        item.append(texN)
                                        m.append(item)
                                    else: 
                                        LOG+="\n                 set map ....."+mapTypes[i] + " : can't find"
                                        texN.text="   "
                                        item.append(texN)
                                        m.append(item)
                                i+=1

                            #---set alhpa
                            name=os.path.splitext(os.path.split(DPath)[1])[0]
                            nameParts=string.split(name,"_")
                            if len(nameParts)>3:
                                if nameParts[len(nameParts)-2]=="a":
                                    LOG+="\n                    set Alpha True"
                                    try:
                                        m.find("\tdoubleSided").text
                                        m.find("\tdoubleSided").find("Int").text
                                    except:
                                        item= Element("property")
                                        item.text=("\tdoubleSided")
                                        itemA=Element("Int")
                                        itemA.text=("\t1\t")
                                        item.append(itemA)
                                        m.append(item)
                                    else:
                                        m.find("\tdoubleSided").find("Int").text="\t1\t"
    outV = ElementTree()
    #print materialChange
    #if materialChange==True:
    outV._setroot(indent(v))
    LOG+="\n        save to a temp "
    print LOG
    #raw_input("LOG")
    outV.write(outVPath,"utf-8")
def replaceVisual(oldPath):
    global LOG
    tempPath="fengx.temp"
    setMaterials(oldPath,tempPath)
    LOG+="\nreplace visual file "
    try:
        os.remove(oldPath)
        os.rename(tempPath,oldPath)
    except:
        LOG+="\nreplace faith"
    else:
        LOG+="\nreplace sucessed"


def autoVisualFileMaterial(vp):
    global LOG
    global ROOTDIR
    pdir=getmfDir()

    try:
        os.remove('setMaterials LOG.fengx')
    except:
        ()


    if pdir!="":
        ROOTDIR=(pdir+ROOTDIR).replace("\\","/")
    else:
        ROOTDIR="e:/mf_pangu/tw2/res/"

    replaceVisual(vp)
    l = open('setMaterials LOG.fengx', 'w')
    l.write(LOG)
    l.close()
#--------------change visual file Material




def registryBigworldFile():
    #print getmfDir()
    #CDir=getmfDir()+"bigworld\\tools\\worldeditor\\"
    CDir=os.getcwd()+"\\"
    #BDir=os.getcwd()+"\\worldeditor.exe"
    #MDir=os.getcwd()[:-12]+"\\modeleditor\\modeleditor.exe"
    FDir=CDir+"fengxTools.exe"
    

    key = _winreg.OpenKey(_winreg.HKEY_CLASSES_ROOT,r"")
    
    ts=[".visual",".model",".primitives",".prefab",".animation"]
    tsv=["bigWorld.visual","bigWorld.model","bigWorld.primitives","bigWorld.prefab","bigWorld.animation"]
    
    bvi=["icon_mfm.bmp","icon_fx.bmp","icon_prefab.bmp","icon_mvl.bmp","icon_animation.bmp"]
    bvc=["-modeleditor-clipboard"]
    i=0
    for t in ts:
        vKey = _winreg.CreateKey(key,t)    
        _winreg.SetValue(vKey,"",_winreg.REG_SZ,tsv[i])
        
        bvKey = _winreg.CreateKey(key,tsv[i])
        _winreg.SetValue(bvKey,"",_winreg.REG_SZ,("bigWorld "+ ts[i][-1:] +"files"))
        _winreg.SetValue(bvKey,"DefaultIcon",_winreg.REG_SZ,(CDir+"resources\\ual\\"+bvi[i]))


        if i<3:
            tkey = _winreg.OpenKey(_winreg.HKEY_CLASSES_ROOT,(tsv[i]))
            sKey = _winreg.CreateKey(tkey,"shell")
            _winreg.SetValue(sKey,"open",_winreg.REG_SZ,"")
            sokey = _winreg.OpenKey(_winreg.HKEY_CLASSES_ROOT,(tsv[i]+"\\shell\\open"))
            _winreg.SetValue(sokey,"command",_winreg.REG_SZ,("\""+FDir+"\""+"-mi"+"\""+"%1"+"\""))
        i+=1





def createDesktopLnk(filename,lnkname):
    shortcut = pythoncom.CoCreateInstance(   
        shell.CLSID_ShellLink, None,   
        pythoncom.CLSCTX_INPROC_SERVER, shell.IID_IShellLink)   
    shortcut.SetPath(filename)   
    if os.path.splitext(lnkname)[-1] != '.lnk':   
        lnkname += ".lnk"
    # get desktop path
    desktopPath = shell.SHGetPathFromIDList(shell.SHGetSpecialFolderLocation(0,shellcon.CSIDL_DESKTOP))
    lnkname = os.path.join((desktopPath),lnkname)
    shortcut.QueryInterface(pythoncom.IID_IPersistFile).Save(lnkname,0)   

#createDesktopLnk("E:\\mf_pangu\\bigworld\\tools\\worldeditor\\fengxTools.exe" ,"xxxxxxxxxxxxxxxxxxxxxx")


def getXMLRoot(filepath):
    try:
        cf = codecs.open(filepath, encoding='gbk')
        content = cf.read().encode('utf-8')
        cf.close()
        return ET.fromstring(content)
    except:
        print 'xxxxx', filepath, traceback.format_exc(sys.exc_info())
        return None


# def changeGameMap(usd,m):
    # uf=getXMLRoot(usd)

    # uf.clear()
    
    # item=Element("root")
    # itemm=Element(m)
    # itemm.text=" "
    # item.append(itemm)

    # outV = ElementTree()
    # outV._setroot(item)
    # outV.write(usd)#,"utf-8")


helpInfor="""
fengxTools OPTIONS:    
-ec        | explorer-clipboard           (showInExplorer)
-mc        | modeleditor-clipboard        (openByModeEditor) 
-ei<path>  | explorer-input <path>        (showInExplorer by imput a path )
-em<path>  | modeleditor-input <path>     (openByModeEditor by imput a path )
-gf        | getText-fliterPath           (change Clipboard text to path )
-gt        | getText                      (get Clipboard text)
-st<string>| setText<string>              (set Clipboard text)
-am<path>  | AutoVisualFileMaterial<path> (auto fill Visual material)
-gs        | getSVNDir                    (get SVN Dir)
-rb        | regBigworldFile<path>        (registry Bigworld File)
-ib        | import bigworld <filepath>   (worlk in process....)
-fp        | findPathFromNameName         (all in clipboard)
 """
#-cm        | changeMap<filepath><MapName> (change the game map name)

#print findFilePath("22301",rootPath)
#print getPathFromName("22301",rootPath)

try:
    sys.argv[1]
except:
    print helpInfor
    raw_input("press  Enter to Exit!")
else:
    #print sys.argv[1]
    if sys.argv[1][:3]=="-ec":#"-explorer-clipboard" or sys.argv[1]=="-ec" :
        try:
            if sys.argv[1][3:]!="" and sys.argv[1][3:]!=" ": 
                p=findFilePath(sys.argv[1][3:],rootPath)
                if p!="" and p!=" ":
                    p= "explorer.exe"+"/select,"+p
                    os.system(p.replace("\n",""))
                    print p
            else:
                t=getText()
                if t!="" and t!=" " and t!=None:
                    p=findFilePath(t,rootPath)
                    if p!="" and p!=" ":
                        #setText(p)
                        p= "explorer.exe"+"/select,"+p
                        os.system(p.replace("\n",""))
                        print p   
        except:
            print "find  fath!"
        

    elif sys.argv[1][:3]=="-mc":#"-modeleditor-clipboard" or sys.argv[1]=="-mc":
        try:
            if sys.argv[1][3:]!="" and sys.argv[1][3:]!=" ": 
                p=findFilePath(sys.argv[1][3:],rootPath)
                if p!="" and p!=" ":
                    openModeEditor(p)
                    print p
            else:
                t=getText()
                if t!="" and t!=" " and t!=None:
                    p=findFilePath(t,rootPath)
                    if p!="" and p!=" ":
                        openModeEditor(p)
                        print p   
        except:
            print "find  fath!"
   
        

    elif sys.argv[1]=="-gf":#"-getText-fliterPath" or sys.argv[1]=="-gf":
        print getRelativePath(getText())

    elif sys.argv[1][:3]=="-ei":#"-explorer-input" or sys.argv[1]=="-ei":
        try:
            if sys.argv[1][3:]!="" and sys.argv[1][3:]!=" ": 
                p=findFilePath(sys.argv[1][3:],rootPath)
                if p!="" and p!=" ":
                    p= "explorer.exe"+"/select,"+p
                    os.system(p.replace("\n",""))
                    print p
            else:
                t=getText()
                if t!="" and t!=" " and t!=None:
                    p=findFilePath(t,rootPath)
                    if p!="" and p!=" ":
                        #setText(p)
                        p= "explorer.exe"+"/select,"+p
                        os.system(p.replace("\n",""))
                        print p   
        except:
            print "find  fath!"
        

    elif sys.argv[1][:3]=="-mi":#-modeleditor-input" or sys.argv[1]=="-mi":
        try:
            if sys.argv[1][3:]!="" and sys.argv[1][3:]!=" ": 
                p=findFilePath(sys.argv[1][3:],rootPath)
                if p!="" and p!=" ":
                    openModeEditor(p)
                    print p
            else:
                t=getText()
                if t!="" and t!=" " and t!=None:
                    p=findFilePath(t,rootPath)
                    if p!="" and p!=" ":
                        openModeEditor(p)
                        print p   
        except:
            print "find  fath!"
   
        


    elif sys.argv[1]=="-h" or sys.argv[1]=="-help" or sys.argv[1]=="-H" or sys.argv[1]=="-HELP"  :
        print helpInfor
    elif sys.argv[1][:3]=="-gt":#"-getText"or sys.argv[1]=="-gt":
        print getText()

    elif sys.argv[1][:3]=="-st":#"-setText"or sys.argv[1]=="-st":
        try:
            if sys.argv[1][3:]!="" and sys.argv[1][3:]!=" ": 
                setText(sys.argv[1][3:])
                print "setText  OK!"
        except:
            print "setText fath!"
    elif sys.argv[1][:3]=="-gd":#"-getDir"or sys.argv[1]=="-gd":
        print getDir()

    elif sys.argv[1][:3]=="-am":
        autoVisualFileMaterial(sys.argv[1][3:])
        if sys.argv[1][:4]=="-amd":
            raw_input("press  Enter to Exit!")
    elif sys.argv[1][:3]=="-rb":#"-registryBigworldFile" or sys.argv[1]=="-rb":
        registryBigworldFile()
    elif sys.argv[1][:3]=="-re"or sys.argv[1][:4]=="--re":
        os.system("TASKKILL /F /IM EXPLORER.EXE")
        os.system("start explorer")
          
    elif sys.argv[1][:3]=="-fp":#or sys.argv[1][:4]=="--fp":
        try:
            if sys.argv[1][3:]!="" and sys.argv[1][3:]!=" ": 
                p=findFilePath(sys.argv[1][3:],rootPath)
                if p!="" and p!=" ":
                    setText(p)
                    print p
            else:
                t=getText()
                if t!="" and t!=" " and t!=None:
                    p=findFilePath(t,rootPath)
                    if p!="" and p!=" ":
                        setText(p)
                        print p   
        except:
            print "find  fath!"
    # elif sys.argv[1][:3]=="-cm":
        # print sys.argv[1][3:] 

        # v=sys.argv[1][3:].split("-")
        # print v
        # changeGameMap(v[0],v[1])
        
    elif sys.argv[1][:3]=="-ib":
        print "getText",getText()
        a=getAbsolutePath(getText())
        print a
        if a!="" and a!=" " and a!=None:
            if a.replace(" ","")!="":
                setText(a) 
                print a
            else: print "false!"