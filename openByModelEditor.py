#coding=utf-8
import sys
import os
import win32clipboard as w
import win32con

modelEditorPath="bigworld/tools/modeleditor/modeleditor.exe"
Rdir="tw2\\res\\scene\\common\\"


def getmfDir():
	mf_dir=""
	if os.path.isfile(os.getcwd()+"\\fengx.fengx"):
		f=open(os.getcwd()+"\\fengx.fengx","rb")
		line = f.readline()
		while line:
			if len(line)>6 and line[:5]=="mfDIR":
				mf_dir=line[6:].replace("\r","").replace("\n","")
			line = f.readline()

		#if checkSVNDir(mf_dir) ==False:
		#	#print mf_dir
		#	print "ssxxs"
		#	#mf_dir=""
		#else:
		#	print "sss"
	else:
		print "cant find the setting file (fengx.fengx)"
	return mf_dir
tdir=getmfDir()
if tdir=="":
        tdir="E:\\mf_pangu\\"
        
Rdir=tdir+Rdir
modelEditorPath=tdir+modelEditorPath

dirs=["wj\\wjdx\\","wj\\wjgy\\","wj\\wjjy\\","wj\\wjwy\\" ,
	"zw\\zwgm\\","zw\\zwhc\\","zw\\zwshu\\","zw\\zwts\\",
	"jz\\jzsj\\sjcs\\","jz\\jzsj\\sjyw\\","jz\\jztj\\tjcs\\",
	"jz\\jztj\\tjyw\\","db\\dbcd\\","db\\dblm\\","db\\dbsk\\",
	"db\\dbst\\"]
	
def getText():
	w.OpenClipboard()
	d=""
	try:
		d = w.GetClipboardData(win32con.CF_TEXT)
	except:
		d=(w.GetClipboardData(win32con.CF_HDROP))[0]
		
	w.CloseClipboard()
	return d

def setText(aString):
	w.OpenClipboard()
	w.EmptyClipboard()
	w.SetClipboardData(win32con.CF_TEXT, aString)
	w.CloseClipboard()

def openModeEditor(p):
	c=p
	c=c.replace('\"', '')
	c=c.replace('.visual', '.model')
	c=c.replace('.primitives', '.model')
	c=c.replace('.thumbnail.jpg', '.model')

	if os.path.isfile(c) and c.find(".model")!=-1:
		c= modelEditorPath+ " -o"+c.replace('/', '\\')
		os.system(c)
	elif len(p)>0:
		tempOn=True
		for p in  dirs:
			c=os.path.split(os.path.splitext(c)[0])[1]
			d=Rdir+p+c+".model"
			if os.path.isfile(d):
				tempOn=False
				d= modelEditorPath+ " -o"+d.replace('/', '\\')
				os.system(d)

		if tempOn==True:
			os.system(modelEditorPath)

def changeToSVN(p):
	fp=p
	return fp 
try:
	sys.argv[1]
except:
	#print (getText())
	openModeEditor(getText())
	#raw_input("don't click me ! dray file up me ! ")
else:
	openModeEditor(sys.argv[1])
	#raw_input("don")

sys.exit()
