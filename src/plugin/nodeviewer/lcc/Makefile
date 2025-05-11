# Wedit Makefile for project Utililty_NodeViewer
SRCDIR=m:\fmfdlgtool\src\plugin\nodeviewer
CFLAGS=-Im:\lcc\include 
CC=$(LCCROOT)\bin\lcc.exe
LINKER=$(LCCROOT)\bin\lcclnk.exe
OBJS=\
	fmf_sdk_example.obj \

LIBS=
EXE=utility_nodeviewer.dll

$(EXE):	$(OBJS) Makefile
	$(LINKER)  -s -dll -map m:\fmfdlgtool\src\plugin\nodeviewer\lcc\utility_nodeviewer.map -nounderscores -o $(SRCDIR)\lcc\utility_nodeviewer.dll $(OBJS) $(LIBS)

# Build fmf_sdk_example.c
FMF_SDK_EXAMPLE_C=\
	$(SRCDIR)\FMFDlgSDK.h\
	$(SRCDIR)\fmfDlgsdk_util.h\
	$(SRCDIR)\fmfsdk.h\

fmf_sdk_example.obj: $(FMF_SDK_EXAMPLE_C) $(SRCDIR)\fmf_sdk_example.c
	$(CC) -c $(CFLAGS) $(SRCDIR)\fmf_sdk_example.c

link:
	$(LINKER)  -s -dll -map m:\fmfdlgtool\src\plugin\nodeviewer\lcc\utility_nodeviewer.map -nounderscores -o $(SRCDIR)\lcc\utility_nodeviewer.dll $(OBJS) $(LIBS)

clean:
	del $(OBJS) utility_nodeviewer.dll
