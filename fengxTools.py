#coding=utf-8
import sys
import os
import win32clipboard 
import win32con
import _winreg
from  xml.etree.ElementTree import*
import string



import pythoncom
from win32com.shell import shell   
from win32com.shell import shellcon 

modelEditorPath="bigworld/tools/modeleditor/modeleditor.exe"
Rdir="tw2\\res\\scene\\common\\"

dirs=["wj\\wjdx\\","wj\\wjgy\\","wj\\wjjy\\","wj\\wjwy\\" ,
    "zw\\zwgm\\","zw\\zwhc\\","zw\\zwshu\\","zw\\zwts\\",
    "jz\\jzsj\\sjcs\\","jz\\jzsj\\sjyw\\","jz\\jztj\\tjcs\\",
    "jz\\jztj\\tjyw\\","db\\dbcd\\","db\\dblm\\","db\\dbsk\\",
    "db\\dbst\\",""]

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

def getAbsolutePath(p):
    global dirs
    global Rdir
    tp=""
    if len(p)>0 and p!="":
        name=os.path.split(os.path.splitext(p)[0])[1]
        try:
            int(p)
        except:
            for dp in  dirs:
                tempDir=Rdir+dp+name+".model"
                if os.path.isfile(tempDir):
                    tp=tempDir
        else:
            tempDir=tdir+ROOTDIR+"char\\"+name+"\\"+name+".model"
            if os.path.isfile(tempDir): 
                tp=tempDir
    return tp


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
    for p in os.listdir(miRootPath):
        miPaths.append((p+"/"))
    for p in os.listdir(miRootPath+"common/"):
        miPaths.append(("common/"+p+"/"))
    
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

import codecs 
import xml.etree.ElementTree as ET 

def getXMLRoot(filepath):
    try:
        cf = codecs.open(filepath, encoding='gbk')
        content = cf.read().encode('utf-8')
        cf.close()
        return ET.fromstring(content)
    except:
        print 'xxxxx', filepath, traceback.format_exc(sys.exc_info())
        return None


def changeGameMap(usd,m):
    uf=getXMLRoot(usd)

    uf.clear()
    
    item=Element("root")
    itemm=Element(m)
    itemm.text=" "
    item.append(itemm)

    outV = ElementTree()
    outV._setroot(item)
    outV.write(usd)#,"utf-8")


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
-cm        | changeMap<filepath><MapName> (change the game map name)
-ib        | import bigworld <filepath>   (worlk in process....)
 """

getAbsolutePath("545")

try:
    sys.argv[1]
except:
    print helpInfor
    raw_input("press  Enter to Exit!")
else:
    #print sys.argv[1]
    if sys.argv[1][:3]=="-ec":#"-explorer-clipboard" or sys.argv[1]=="-ec" :
        showInExplorer(getText())
        print getText()

    elif sys.argv[1][:3]=="-mc":#"-modeleditor-clipboard" or sys.argv[1]=="-mc":
        openModeEditor(getText())

    elif sys.argv[1]=="-gf":#"-getText-fliterPath" or sys.argv[1]=="-gf":
        print getRelativePath(getText())

    elif sys.argv[1][:3]=="-ei":#"-explorer-input" or sys.argv[1]=="-ei":
        #print sys.argv[1][3:]
        #print sys.argv
        showInExplorer(sys.argv[1][3:])

    elif sys.argv[1][:3]=="-mi":#-modeleditor-input" or sys.argv[1]=="-mi":
        openModeEditor(sys.argv[1][3:])
        #print sys.argv[1][3:]

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
        print "xx"
        os.system("TASKKILL /F /IM EXPLORER.EXE")
        os.system("start explorer")
    elif sys.argv[1][:3]=="-cm":
        print sys.argv[1][3:] 

        v=sys.argv[1][3:].split("-")
        print v
        changeGameMap(v[0],v[1])
    elif sys.argv[1][:3]=="-ib":
        a=getRelativePath(getText())
        if a.replace(" ","")!="":
            setText(a) 
