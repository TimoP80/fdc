#include <windows.h>
#include <stdio.h>
#include "FMFDlgSDK.h"
#include "fmfDlgsdk_util.h"
#include "fmfsdk.h"


FMF_FUNC_GetDLG GetDLG=0;
FMF_FUNC_Execute ExecuteScriptLines=0;
FMF_FUNC_GetPlayer GetPlayer=0;

#define ListID 101
#define SHORTSTRING_SETTEXT(p,q) p->Size=strlen(q); memcpy(p->Text,q,strlen(q));
#define SHORTSTRING_SETTEXTZ(p,q) p->Size=strlen(q); memcpy(p->Text,q,strlen(q)+1);


int GetLineCount(HWND hWnd, char * TextToSize, int Off);
LRESULT DoCustomTVDraw(HWND hWnd,UINT uMsg, WPARAM wParam, LPARAM lParam);
int SingleConditionMet(FMF_PLAYERCHAR * StatsToUse,FMF_CONDITION * curCondition);
int ConditionsMet(FMF_PLAYERCHAR * StatsToUse,FMF_OPTION * OptionNode);
void InitPC();

char *cmd;
LPCTSTR defAppName="Node Viewer";
FMF_PLAYERCHAR * PCStats=0;
static int Monitor=0;
static HINSTANCE DLLInst=0;;
static HWND ohWnd=0;
static HWND liWnd=0;
static FMF_DLG * Test;
static HWND infoWnd[7]={0,0,0,0,0,0,0};
void Execute(char * Command);
typedef struct
{
	char * nodename;
	HTREEITEM link;
} matchlist;

static matchlist AllNodes[512];

LRESULT CALLBACK MsgHandle(HWND hWnd,UINT uMsg, WPARAM wParam, LPARAM lParam);
void PopulateList(HWND hWnd,FMF_DLG *Test);
/* Doesn't seem to be defined in headers */
typedef struct tagNMTVCUSTOMDRAW {
    NMCUSTOMDRAW nmcd;
    COLORREF clrText;
    COLORREF clrTextBk;
#if (_WIN32_IE >= 0x0400)
    int iLevel;
#endif
} NMTVCUSTOMDRAW, *LPNMTVCUSTOMDRAW;


LRESULT WriteLines(HWND hWnd, LPNMTVCUSTOMDRAW DrawInfo, char * TextToWrite);
/* --------------------------------------------------------------------------- */
/* Defines not in C SDK */
#define CHECK_TYPE_STAT 1
#define CHECK_TYPE_SKILL 2


#define CHECK_TYPE_CHECKMONEY 3
#define CHECK_FIELD_DUDE_CAPS 1
#define CHECK_FIELD_STAT_ST 1
#define CHECK_FIELD_STAT_PE 2
#define CHECK_FIELD_STAT_EN 3
#define CHECK_FIELD_STAT_CH 4
#define CHECK_FIELD_STAT_IN 5
#define CHECK_FIELD_STAT_AG 6
#define CHECK_FIELD_STAT_LK 7
#define CHECK_FIELD_SKILL_SMALLGUNS	1
#define CHECK_FIELD_SKILL_BIGGUNS	2
#define CHECK_FIELD_SKILL_ENERGYWEAPONS 3
#define CHECK_FIELD_SKILL_UNARMED 4
#define CHECK_FIELD_SKILL_MELEE 5
#define CHECK_FIELD_SKILL_THROWING 6
#define CHECK_FIELD_SKILL_FIRSTAID 7
#define CHECK_FIELD_SKILL_DOCTOR 8
#define CHECK_FIELD_SKILL_SNEAK 9
#define CHECK_FIELD_SKILL_LOCKPICK 10
#define CHECK_FIELD_SKILL_STEAL 11
#define CHECK_FIELD_SKILL_TRAPS 12
#define CHECK_FIELD_SKILL_SCIENCE 13
#define CHECK_FIELD_SKILL_REPAIR 14
#define CHECK_FIELD_SKILL_SPEECH 15
#define CHECK_FIELD_SKILL_BARTER 16
#define CHECK_FIELD_SKILL_GAMBLING 17
#define CHECK_FIELD_SKILL_OUTDOORSMAN 18

#define COMPARE_EQUAL 1
#define COMPARE_NOT_EQUAL 2
#define COMPARE_LARGER_THAN 3
#define COMPARE_LESS_THAN 4
#define COMPARE_LARGER_THAN_OR_EQUAL 5
#define COMPARE_LESS_THAN_OR_EQUAL 6


/* --------------------------------------------------------------------------- */
void ShowError()
{
							{
							DWORD RelDLL_Error;
						 LPVOID MsgBuffer;
							RelDLL_Error=GetLastError();
 						if(!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_FROM_SYSTEM,NULL,RelDLL_Error,0,(LPTSTR)&MsgBuffer,0, NULL))
							{
								MessageBox(NULL,"Unknown Error","Error",MB_OK);
								return;
							}else{
								MessageBox(NULL,MsgBuffer,"Error",MB_OK);
        LocalFree(MsgBuffer);
								return;
	      }
						}
}



BOOL WINAPI __declspec(dllexport) LibMain(HINSTANCE hDLLInst, DWORD fdwReason, LPVOID lpvReserved)
{
    switch (fdwReason)
    {
        case DLL_PROCESS_ATTACH:
								if(Monitor==0)
										{
											++Monitor;
											memset(AllNodes,0,sizeof(matchlist)*512);
									  DLLInst=hDLLInst;
          	// Define Window Class. Because I HATE actual Dialog boxes
          	WNDCLASS wc;
	          wc.style = 0;
	          wc.lpfnWndProc = MsgHandle;
	          wc.cbClsExtra = 0;
	          wc.cbWndExtra = 0;
	          wc.hInstance = DLLInst;
           wc.hIcon = LoadIconA(DLLInst,MAKEINTRESOURCE(IDICON100));
									  wc.hCursor= LoadCursor(NULL,IDC_ARROW);
	          wc.hbrBackground = (HBRUSH)(COLOR_BTNFACE+1);
	          wc.lpszMenuName = defAppName;
	          wc.lpszClassName = defAppName;

	          if (RegisterClass (&wc)==0)
          		{
			          MessageBox(NULL, "Error Generating Script Window","ERROR",MB_OK);
			          return TRUE;
		          }
								  }

												//MessageBox(NULL, "Proc_Attach","Attach",MB_OK);
            break;

        case DLL_PROCESS_DETACH:
 								--Monitor;
									if(Monitor<=0)
										{
											DestroyWindow(ohWnd);
											UnregisterClass(defAppName,DLLInst);
											DLLInst=0;
										}

            break;
        case DLL_THREAD_ATTACH:
            // A thread is being created in a process that has already loaded
            // this DLL.  Perform any per-thread initialization here.  The
            // return value is ignored.

            break;
        case DLL_THREAD_DETACH:
            // A thread is exiting cleanly in a process that has already
            // loaded this DLL.  Perform any per-thread clean up here.  The
            // return value is ignored.

            break;
    }
    return TRUE;
}


ShortString FMFDLG_EXPORT GetPluginName()
{
	ShortString FMF;
	memcpy(FMF.Text,"Node Viewer",strlen("Node Viewer"));
	FMF.Size=strlen("Node Viewer");
 return FMF;
}

ShortString FMFDLG_EXPORT GetPluginDescription()
{
	ShortString FMF;
	memcpy(FMF.Text,"Node Viewer",strlen("Node Viewer"));
	FMF.Size=strlen("Node Viewer");
 return FMF;
}

void FMFDLG_EXPORT RunPlugin(ShortString basepath)
{
					HANDLE fmfDlgExe=0;
					MSG msg;

					 fmfDlgExe=LoadLibrary("fmfdlg.exe");
						if(!fmfDlgExe)
						{
							DWORD RelDLL_Error;
						 LPVOID MsgBuffer;
							RelDLL_Error=GetLastError();
 						if(!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_FROM_SYSTEM,NULL,RelDLL_Error,0,(LPTSTR)&MsgBuffer,0, NULL))
							{
								MessageBox(NULL,"Unknown Error Occurred while linking to library","Error",MB_OK);
								return;
							}else{
								MessageBox(NULL,MsgBuffer,"Error loading executable",MB_OK);
        LocalFree(MsgBuffer);
								return;
	      }
						}else{
							/* Library Obtained. Run the Command */
							GetDLG=GetProcAddress(fmfDlgExe,FMF_GetDLG);
							if(!GetDLG)
							{
								MessageBox(NULL,"Error retrieving ExecuteScriptCommand.","Error",MB_OK);
								return;
							}else{ //* Run the command */

							Execute("debugmsg('dialogue get commence.');");
							Test=GetDLG();
							Execute("debugmsg('dialogue done.');");
						} /* */
					}
					if(ohWnd)
						{
							InitPC();
		     PopulateList(liWnd,Test);
					 	return;
					 }

	/* CreateWindow */
	 InitCommonControls();
		ohWnd=CreateWindow(defAppName,defAppName,WS_MINIMIZEBOX|WS_MAXIMIZEBOX|WS_THICKFRAME|WS_POPUP|WS_SYSMENU|WS_CAPTION,CW_USEDEFAULT,CW_USEDEFAULT,400,400,NULL,NULL,DLLInst,NULL);
		liWnd=CreateWindowEx(0,WC_TREEVIEW,"Nodes",WS_CHILD|WS_BORDER|WS_VISIBLE|TVS_LINESATROOT|TVS_HASLINES|TVS_HASBUTTONS|TVS_SHOWSELALWAYS,10,115,375,240,ohWnd,(HMENU)ListID,DLLInst,NULL);
		infoWnd[0]=CreateWindow("EDIT","",WS_CHILD|WS_VISIBLE|WS_BORDER|WS_VSCROLL|ES_MULTILINE|ES_LEFT|ES_AUTOVSCROLL,10,5,375,45,ohWnd,NULL,DLLInst,NULL);
		infoWnd[1]=CreateWindow("EDIT","",WS_CHILD|WS_VISIBLE|WS_DISABLED|ES_LEFT,10,55,180,15,ohWnd,NULL,DLLInst,NULL);
		infoWnd[2]=CreateWindow("EDIT","",WS_CHILD|WS_VISIBLE|WS_DISABLED|ES_LEFT,200,55,180,15,ohWnd,NULL,DLLInst,NULL);
		infoWnd[3]=CreateWindow("EDIT","",WS_CHILD|WS_VISIBLE|WS_DISABLED|ES_LEFT,10,75,180,15,ohWnd,NULL,DLLInst,NULL);
		infoWnd[4]=CreateWindow("EDIT","",WS_CHILD|WS_VISIBLE|WS_DISABLED|ES_LEFT,200,75,180,15,ohWnd,NULL,DLLInst,NULL);
		infoWnd[5]=CreateWindow("EDIT","",WS_CHILD|WS_VISIBLE|WS_DISABLED|ES_LEFT,10,95,180,15,ohWnd,NULL,DLLInst,NULL);
		infoWnd[6]=CreateWindow("EDIT","",WS_CHILD|WS_VISIBLE|WS_DISABLED|ES_LEFT,200,95,180,15,ohWnd,NULL,DLLInst,NULL);

	 /*SendMessage(liWnd,0x2007,5,0); DOOOOOOOOOOOOOOOOOOO */

		/* Initialize Data in List View */
		InitPC();
		PopulateList(liWnd,Test);
		ShowWindow(ohWnd,SW_SHOW);

		 while(GetMessage (&msg, NULL,0,0))
		{
			TranslateMessage (&msg);
			DispatchMessage(&msg);
		}
	FreeLibrary(fmfDlgExe);
 return;
}


BOOL FMFDLG_EXPORT CanAddToMenu()
{
	return TRUE;
}


/* Right Click on List Box - Show Menu */
void TreeRightClick(HWND TreeHWND)
{
	//Mouse Location
	char Command[200];
	TV_HITTESTINFO tmpHit;
	HMENU tmpMenu;
	int tmpSel;
	HTREEITEM tmpItemID;
	HTREEITEM Parent;
	TVITEMEX tmpItem;
	int tmpDmp=0;
	int tmpCmp=0;
	GetCursorPos(&tmpHit.pt);
	ScreenToClient(TreeHWND,&(tmpHit.pt));
	(HTREEITEM)SendMessage(TreeHWND,TVM_HITTEST,(WPARAM) 0, (LPARAM)&tmpHit);
	tmpItemID=tmpHit.hItem;
	ClientToScreen(TreeHWND,&(tmpHit.pt));
	if(!tmpItemID)
	{
		tmpItemID=0;//TreeView_GetSelection(TreeHWND);//
	}else{
		SendMessage(TreeHWND,TVM_SELECTITEM,(WPARAM)TVGN_CARET,(WPARAM)tmpItemID);
	}

	Parent=tmpItemID;
	if(TreeView_GetParent(liWnd,Parent)!=NULL)
		Parent=TreeView_GetParent(liWnd,Parent);
	else
  Parent=0;
 //AllNodes[tmpCmp].nodename
	//Do Popup
		tmpMenu=CreatePopupMenu();
	SetMenu(TreeHWND,tmpMenu);

	if(!Parent)
	{
		tmpItem.hItem=tmpItemID;
		tmpItem.mask=TVIF_PARAM;
		SendMessage(TreeHWND,TVM_GETITEM,(WPARAM) 0, (LPARAM)&tmpItem);
		tmpCmp=tmpItem.lParam;
	}else{
		tmpItem.hItem=Parent;
		tmpItem.mask=TVIF_PARAM;
		SendMessage(TreeHWND,TVM_GETITEM,(WPARAM) 0, (LPARAM)&tmpItem);
		tmpCmp=tmpItem.lParam;

		tmpItem.hItem=tmpItemID;
		tmpItem.mask=TVIF_PARAM;
		SendMessage(TreeHWND,TVM_GETITEM,(WPARAM) 0, (LPARAM)&tmpItem);
		tmpDmp=tmpItem.lParam;

	}

	// Insert Menu Items As Needed;
	if(tmpItemID)
	{
 	AppendMenu(tmpMenu,MFT_STRING|MFS_GRAYED,100,AllNodes[tmpCmp].nodename);
		AppendMenu(tmpMenu,MFT_SEPARATOR,0,0);
	}

	if(!tmpItemID)
	{
		AppendMenu(tmpMenu,MFT_STRING,103,"New Node");
	}else{
		if(!Parent) /* If Response */
		{
			AppendMenu(tmpMenu,MFT_STRING,101,"Edit");
			AppendMenu(tmpMenu,MFT_STRING,103,"New Node");
			AppendMenu(tmpMenu,MFT_STRING,109,"New Option");
	 	AppendMenu(tmpMenu,MFT_STRING,104,"Delete Node");
			AppendMenu(tmpMenu,MFT_SEPARATOR,0,0);
			AppendMenu(tmpMenu,MFT_STRING,102,"Run/Restart From here");
	  AppendMenu(tmpMenu,MFT_STRING,106,"Jump to here");
	 }else{
			AppendMenu(tmpMenu,MFT_STRING,109,"New Option");
			AppendMenu(tmpMenu,MFT_STRING,152,"Edit Option");
			AppendMenu(tmpMenu,MFT_STRING,151,"Delete Option");
		} /* If Main Node */
	} /* End TmpItemID */
	tmpSel=TrackPopupMenu(tmpMenu,TPM_LEFTALIGN|TPM_TOPALIGN|TPM_RETURNCMD,tmpHit.pt.x,tmpHit.pt.y,0,TreeHWND,NULL);
	//void AddComponent(struct Component * Parent,struct Component * ToAdd)
	switch(tmpSel)
	{
		case 101: /* Edit */
			sprintf(Command,"EditNode('%s');",AllNodes[tmpCmp].nodename);
			Execute(Command);
			break;
		case 102: /* Run */
			sprintf(Command,"RunDialogue('%s');",AllNodes[tmpCmp].nodename);
			Execute(Command);
			break;
		case 103: /* New */
			{
			 DWORD itmpName=GetTickCount();
			 sprintf(Command,"AddNode('%d','','','');",itmpName);
			 Execute(Command);
				sprintf(Command,"EditNode('%d');",itmpName);
				Execute(Command);
			 break;
		 }
		case 104:	/* DeleteNode */
			strcpy(Command,"DeleteNode('");
			strcpy(Command+12,AllNodes[tmpCmp].nodename);
			strcpy(Command+12+strlen(AllNodes[tmpCmp].nodename),"');");
			if(MessageBox(liWnd,"Are You sure you wish to delete this Node?","Delete Verification",MB_YESNO|MB_DEFBUTTON2)==IDYES)
			 Execute(Command);
			break;
		case 106:
			strcpy(Command,"SetCurrentNode('");
			strcpy(Command+16,AllNodes[tmpCmp].nodename);
			strcpy(Command+16+strlen(AllNodes[tmpCmp].nodename),"');");
			Execute(Command);
   break;
		case 109:
			{
				int tmpCnt=0;
				while(Test->nodes[tmpCnt]->nodename && strcmp(Test->nodes[tmpCnt]->nodename,AllNodes[tmpCmp].nodename))
					++tmpCnt;
				tmpCnt=Test->nodes[tmpCnt]->optioncnt;
			 sprintf(Command,"AddPlayerOption('%s','','','');",AllNodes[tmpCmp].nodename);
				Execute(Command);
			 sprintf(Command,"EditPlayerOption('%s',%d);",AllNodes[tmpCmp].nodename,tmpCnt);
				Execute(Command);
	 	}
			break;
		case 151: /* Delete Option */
			sprintf(Command,"DeletePlayerOption('%s',%d);",AllNodes[tmpCmp].nodename,tmpDmp);
			if(MessageBox(liWnd,"Are You sure you wish to delete this Player Option?","Delete Verification",MB_YESNO|MB_DEFBUTTON2)==IDYES)
			{
				TreeView_SelectItem(liWnd,AllNodes[tmpCmp].link);
			 Execute(Command);
			}
			break;
		case 152: /* Edit Option */
			sprintf(Command,"EditPlayerOption('%s',%d);",AllNodes[tmpCmp].nodename,tmpDmp);
			Execute(Command);
			break;
	}

}
LRESULT CALLBACK MsgHandle(HWND hWnd,UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	switch(uMsg)
	{
		case WM_NOTIFY:
			{
				LPNMHDR source=(LPNMHDR)lParam;
				switch(source->code)
				{
					case NM_CUSTOMDRAW:
						if(source->hwndFrom==liWnd)
						 return DoCustomTVDraw(liWnd,uMsg,wParam,lParam);
						break;
					case NM_RCLICK:	//Right Click
						TreeRightClick(liWnd);
						break;
					case TVN_ITEMEXPANDED:
						break;
 				case NM_DBLCLK:
						{
						 HTREEITEM CurItm=TreeView_GetSelection(liWnd);
							if(TreeView_GetParent(liWnd,CurItm))
							{
 							TVITEM ActItem;
								TVITEM ParItem;
								char * ActLnk;
								int i;
		 					ActItem.mask=TVIF_PARAM | TVIF_HANDLE;
								ParItem.mask=TVIF_PARAM | TVIF_HANDLE;
			 				ActItem.hItem=CurItm;
								ParItem.hItem=TreeView_GetParent(liWnd,CurItm);
 							TreeView_GetItem(liWnd,&ActItem);
								TreeView_GetItem(liWnd,&ParItem);
								ActLnk=Test->nodes[ParItem.lParam]->options[ActItem.lParam]->nodelink;
								if (!ActLnk)
								{
									MessageBox(ohWnd,"No Target Listed for this node.","Node not found",MB_OK);
									break;
								}
								i=0;
								while (AllNodes[i].nodename && strcmp(AllNodes[i].nodename,ActLnk))
							  ++i;
								if(AllNodes[i].nodename) /* Found a match */
								{
									TreeView_Expand(liWnd,(ParItem.hItem),TVE_COLLAPSE);
									TreeView_SelectItem(liWnd,(AllNodes[i].link));
									TreeView_Expand(liWnd,(AllNodes[i].link),TVE_EXPAND);

								}else{
									MessageBox(ohWnd,"Target Node is not present in list.","Node not found",MB_OK);
								}
						}
					} /* End NM_DBLCLK */
						break;
 				case TVN_SELCHANGED:
 				{
	 				LPTVITEM CurItm;
 				 HTREEITEM Parent=NULL;
		 			LPNMTREEVIEW tvSrc=(LPNMTREEVIEW)lParam;


					 CurItm=&(tvSrc->itemNew);
						if(!CurItm->hItem)
							{
								int iii=0;
							 for(iii=0;iii<6;++iii)
								 SendMessage(infoWnd[iii],WM_SETTEXT,0,(LPARAM)"");
								break;
							}

 					if(CurItm->mask & TVIF_HANDLE)
 						Parent=TreeView_GetParent(liWnd,CurItm->hItem);


 					if(CurItm->mask & TVIF_PARAM) /* We Have Node Param */
 					{
 						char * TmpStr;
 						if(Parent)
 							{	/* Option */
	 							TVITEM ParentItem;
 								FMF_OPTION * ActOpt;
		 						ParentItem.mask=TVIF_PARAM | TVIF_HANDLE;
			 					ParentItem.hItem=Parent;
 								TreeView_GetItem(liWnd,&ParentItem);

         ActOpt=Test->nodes[ParentItem.lParam]->options[CurItm->lParam];

 								if(ActOpt->optiontext)
 						 	 SendMessage(infoWnd[0],WM_SETTEXT,0,(LPARAM)ActOpt->optiontext);
								else
									SendMessage(infoWnd[0],WM_SETTEXT,0,(LPARAM)"<No Text>");

								if(ActOpt->nodelink)
								{

									TmpStr=malloc(strlen(ActOpt->nodelink)+15);
									memcpy(TmpStr,"nodelink: ",strlen("NodeLink: ")+1);
									memcpy(TmpStr+10,ActOpt->nodelink,strlen(ActOpt->nodelink)+1);
								 SendMessage(infoWnd[1],WM_SETTEXT,0,(LPARAM)TmpStr);
									free(TmpStr);
								}else{
								 SendMessage(infoWnd[1],WM_SETTEXT,0,(LPARAM)"");
								}
									TmpStr=malloc(50);
									//sprintf(TmpStr,"Unknown1: %d",ActOpt->Unknown1); //Index of resolved Node
								 SendMessage(infoWnd[2],WM_SETTEXT,0,(LPARAM)"");
									switch(ActOpt->Reaction)
									{
									 case 0: /* Neutral */
											SendMessage(infoWnd[3],WM_SETTEXT,0,(LPARAM)"Neutral Reaction");
											break;
										case 1: /* Good */
											SendMessage(infoWnd[3],WM_SETTEXT,0,(LPARAM)"Positive Reaction");
											break;
										case 2: /* Bad */
											SendMessage(infoWnd[3],WM_SETTEXT,0,(LPARAM)"Negative Reaction");
											break;
										default: /* Unknown */
										 sprintf(TmpStr,"ReactionValue: %d",ActOpt->Gender); /* Gender. 0-Both 1-male 2-fem */
										 SendMessage(infoWnd[3],WM_SETTEXT,0,(LPARAM)TmpStr);
									}

									switch(ActOpt->Gender)
									{
									 case 0: /* Either */
											SendMessage(infoWnd[4],WM_SETTEXT,0,(LPARAM)"Any Gender");
											break;
										case 1: /* Male Only */
											SendMessage(infoWnd[4],WM_SETTEXT,0,(LPARAM)"Male Only");
											break;
										case 2: /* Female Only */
											SendMessage(infoWnd[4],WM_SETTEXT,0,(LPARAM)"Female Only");
											break;
										default: /* Unknown */
										sprintf(TmpStr,"GenderValue: %d",ActOpt->Gender); /* Gender. 0-Both 1-male 2-fem */
										SendMessage(infoWnd[4],WM_SETTEXT,0,(LPARAM)TmpStr);
									}
									sprintf(TmpStr,"Intelligence: %d",ActOpt->Intelligence);
								 SendMessage(infoWnd[5],WM_SETTEXT,0,(LPARAM)TmpStr);
									free(TmpStr);
								SendMessage(infoWnd[6],WM_SETTEXT,0,(LPARAM)"");


							}else{ /* Root Node */
     			if(Test->nodes[CurItm->lParam]->npctext)
						 	 SendMessage(infoWnd[0],WM_SETTEXT,0,(LPARAM)Test->nodes[CurItm->lParam]->npctext);
								else
									SendMessage(infoWnd[0],WM_SETTEXT,0,(LPARAM)"<No Text>");
								if(Test->nodes[CurItm->lParam]->nodename)
								{
									TmpStr=malloc(strlen(Test->nodes[CurItm->lParam]->nodename)+15);
									memcpy(TmpStr,"NodeName: ",strlen("NodeName: ")+1);
									memcpy(TmpStr+10,Test->nodes[CurItm->lParam]->nodename,strlen(Test->nodes[CurItm->lParam]->nodename)+1);
								 SendMessage(infoWnd[1],WM_SETTEXT,0,(LPARAM)TmpStr);
									free(TmpStr);
								}else{
								 SendMessage(infoWnd[1],WM_SETTEXT,0,(LPARAM)"");
								}
								SendMessage(infoWnd[2],WM_SETTEXT,0,(LPARAM)"");
								SendMessage(infoWnd[3],WM_SETTEXT,0,(LPARAM)"");
								SendMessage(infoWnd[4],WM_SETTEXT,0,(LPARAM)"");
								SendMessage(infoWnd[5],WM_SETTEXT,0,(LPARAM)"");
								SendMessage(infoWnd[6],WM_SETTEXT,0,(LPARAM)"");
							}
					}else{
						 SendMessage(infoWnd[0],WM_SETTEXT,0,(LPARAM)"<Unable to Get Item Data>");
							SendMessage(infoWnd[1],WM_SETTEXT,0,(LPARAM)"");
							SendMessage(infoWnd[2],WM_SETTEXT,0,(LPARAM)"");
							SendMessage(infoWnd[3],WM_SETTEXT,0,(LPARAM)"");
							SendMessage(infoWnd[4],WM_SETTEXT,0,(LPARAM)"");
							SendMessage(infoWnd[5],WM_SETTEXT,0,(LPARAM)"");
							SendMessage(infoWnd[6],WM_SETTEXT,0,(LPARAM)"");
					}/* End ifPARAM */
				 //	if(source->idFrom==ListID)


			  }
				 break;

				} /* End type switch */
		 } /* End switch statement *//* End WM_NOTIFY case */

			break;
  case WM_SIZE:
			if(wParam==SIZE_RESTORED || wParam==SIZE_MAXIMIZED)
				{
					int Width=LOWORD(lParam);
					int Height=HIWORD(lParam);
	    if(Width<30)
						Width=30;
					if(Height<135)
						Height=135;

					SetWindowPos(liWnd,HWND_TOP,10,115,Width-20,Height-125,SWP_SHOWWINDOW);
					SetWindowPos(infoWnd[0],HWND_TOP,10,5,Width-20,40,SWP_SHOWWINDOW);
				PopulateList(liWnd,Test);
				}
			break;
		case WM_DESTROY:
			PostQuitMessage(0);
			break;
		default:
   return ( DefWindowProc (hWnd, uMsg, wParam, lParam));
	}

 return ( DefWindowProc (hWnd, uMsg, wParam, lParam));
}

void PopulateList(HWND hWnd,FMF_DLG *kTest)
{
	TVINSERTSTRUCT AddData;
	TVITEMEX OldData;
	long int curCnt=0;
	long int curOpt;
	long int maxCnt=0;
	HTREEITEM SelectedItem=0;
	char * SelectedName=0;
	HTREEITEM NodeID;
	HTREEITEM OptID;
	char tmpXYZ[100];



	/* End */
	maxCnt=0;
	while(AllNodes[maxCnt].nodename)
		{
			int matCh=0;
   while(matCh<Test->nodecount && AllNodes[maxCnt].nodename && strcmp(AllNodes[maxCnt].nodename,kTest->nodes[matCh]->nodename))
	   ++matCh;
			if(matCh==Test->nodecount)
				{
					int BadNo=0;
					BadNo=maxCnt;
					TreeView_DeleteItem(hWnd,(AllNodes[maxCnt].link));

				if(AllNodes[maxCnt].nodename)
					{
						free(AllNodes[maxCnt].nodename);
					}

					AllNodes[BadNo].nodename=AllNodes[BadNo+1].nodename;
					AllNodes[BadNo].link=AllNodes[BadNo+1].link;
					while(AllNodes[BadNo].nodename)
					{
 					AllNodes[BadNo].nodename=AllNodes[BadNo+1].nodename;
	 				AllNodes[BadNo].link=AllNodes[BadNo+1].link;
						++BadNo;
					}
 					AllNodes[BadNo].nodename=0;
	 				AllNodes[BadNo].link=0;
			 }else{
			  ++maxCnt;
				}
		}

		/* Still Good */
 while(curCnt<Test->nodecount)
	{
  int CurHmm=0;
  while(CurHmm<Test->nodecount && AllNodes[CurHmm].nodename && strcmp(AllNodes[CurHmm].nodename,kTest->nodes[curCnt]->nodename))
	  ++CurHmm;

		if(CurHmm<Test->nodecount && AllNodes[CurHmm].nodename)
		{
			char * UseThisforID;
		 OldData.hItem=AllNodes[CurHmm].link;
		 OldData.mask=TVIF_TEXT|TVIF_PARAM|0x80;
			if(kTest->nodes[curCnt]->npctext)
		 {
    OldData.pszText=kTest->nodes[curCnt]->npctext;
		 	OldData.cchTextMax=strlen(kTest->nodes[curCnt]->npctext)+1;
			}else{
    OldData.pszText=kTest->nodes[curCnt]->nodename;
		 	OldData.cchTextMax=strlen(kTest->nodes[curCnt]->nodename)+1;
			}
			OldData.iIntegral=GetLineCount(hWnd, OldData.pszText,0);
			OldData.lParam=curCnt;
 		TreeView_SetItem(liWnd,&OldData);

/*
	  if(AllNodes[CurHmm].nodename)
			 free(AllNodes[CurHmm].nodename);

		 UseThisforID=kTest->nodes[curCnt]->nodename;

	  AllNodes[CurHmm].nodename=malloc(strlen(UseThisforID)+2);
			memcpy(AllNodes[CurHmm].nodename,UseThisforID,strlen(UseThisforID)+1);
*/
			while(TreeView_GetChild(liWnd,AllNodes[CurHmm].link))
			{
				HTREEITEM kid=TreeView_GetChild(liWnd,AllNodes[CurHmm].link);
				TreeView_DeleteItem(liWnd,kid);
			}
			curOpt=0;
			 while(curOpt<kTest->nodes[curCnt]->optioncnt)
				{

					 AddData.hParent=AllNodes[CurHmm].link;
					 AddData.hInsertAfter=TVI_LAST;
					 AddData.itemex.mask=TVIF_TEXT|TVIF_PARAM|TVIF_STATE|0x80; /* TVIF_INTEGRAL==0x80 */
				 		AddData.itemex.stateMask=TVIS_BOLD;
						if(ConditionsMet(PCStats,kTest->nodes[curCnt]->options[curOpt]))
							AddData.itemex.state=TVIS_BOLD;
						else
							AddData.itemex.state=0;
						if(kTest->nodes[curCnt]->options[curOpt]->optiontext && strlen(kTest->nodes[curCnt]->options[curOpt]->optiontext)>0)
						{
 		    AddData.itemex.pszText=kTest->nodes[curCnt]->options[curOpt]->optiontext;
	 				 AddData.itemex.cchTextMax=strlen(kTest->nodes[curCnt]->options[curOpt]->optiontext)+1;
						}else{
							strcpy(tmpXYZ,"{No Text}");
							AddData.itemex.pszText=tmpXYZ;
	 				 AddData.itemex.cchTextMax=strlen(tmpXYZ)+1;
						}
						AddData.itemex.iIntegral=GetLineCount(hWnd, AddData.item.pszText,1);
		 			AddData.itemex.lParam=curOpt;
			 		OptID=TreeView_InsertItem(hWnd,&AddData);
				 ++curOpt;
				}
		}else{ /* New Node */
			char * UseThisforID;

   curOpt=0;
			if(AllNodes[CurHmm].nodename)
			 free(AllNodes[CurHmm].nodename);
			/*Test->nodes[curCnt]*/
			UseThisforID=kTest->nodes[curCnt]->nodename;
			if(kTest->nodes[curCnt]->npctext)
				UseThisforID=Test->nodes[curCnt]->npctext;
			AddData.hParent=TVI_ROOT;
			AddData.hInsertAfter=TVI_LAST;
			AddData.itemex.mask=TVIF_TEXT|TVIF_PARAM|0x80;
   AddData.itemex.pszText=UseThisforID;
			AddData.itemex.cchTextMax=strlen(UseThisforID)+1;
			AddData.itemex.lParam=curCnt;
			AddData.itemex.iIntegral=GetLineCount(hWnd, AddData.itemex.pszText,0);
			NodeID=TreeView_InsertItem(hWnd,&AddData);
	  AllNodes[CurHmm].nodename=malloc(strlen(kTest->nodes[curCnt]->nodename)+2);
			memcpy(AllNodes[CurHmm].nodename,kTest->nodes[curCnt]->nodename,strlen(kTest->nodes[curCnt]->nodename)+1);
			AllNodes[CurHmm].link=NodeID;
   while(curOpt<kTest->nodes[curCnt]->optioncnt)
				{
					 AddData.hParent=NodeID;
					 AddData.hInsertAfter=TVI_LAST;
					 AddData.itemex.mask=TVIF_TEXT|TVIF_PARAM|TVIF_STATE|0x80;

					 AddData.itemex.stateMask=TVIS_BOLD;
						if(ConditionsMet(PCStats,kTest->nodes[curCnt]->options[curOpt]))
						 AddData.itemex.state=TVIS_BOLD;
						else
						 AddData.itemex.state=0;
						if(kTest->nodes[curCnt]->options[curOpt]->optiontext && strlen(kTest->nodes[curCnt]->options[curOpt]->optiontext)>0)
						{
 		    AddData.itemex.pszText=kTest->nodes[curCnt]->options[curOpt]->optiontext;
	 				 AddData.itemex.cchTextMax=strlen(kTest->nodes[curCnt]->options[curOpt]->optiontext)+1;
						}else{
							strcpy(tmpXYZ,"{No Text}");
							AddData.itemex.pszText=tmpXYZ;
	 				 AddData.itemex.cchTextMax=strlen(tmpXYZ)+1;
						}
						AddData.itemex.iIntegral=GetLineCount(hWnd, AddData.itemex.pszText,1);
		 			AddData.itemex.lParam=curOpt;
			 		OptID=TreeView_InsertItem(hWnd,&AddData);
				 ++curOpt;
				}
			}
		++curCnt;
	} /*End While */

 maxCnt=0;
/*
if(SelectedItem && SelectedName)
{
 while(AllNodes[maxCnt].nodename && strcmp(AllNodes[maxCnt].nodename,SelectedName))
  ++maxCnt;
 free(SelectedName);
 if(AllNodes[maxCnt].nodename)
 {
 	TreeView_EnsureVisible(liWnd,AllNodes[maxCnt].link);
 	TreeView_SelectItem(liWnd,AllNodes[maxCnt].link);
 }
}
*/
		/*if(AllNodes[0].nodename)
			TreeView_SelectItem(liWnd,AllNodes[0].link);*/
	return;

}


ShortString FMFDLG_EXPORT GetInterfaceVersion()
{
	ShortString FMF;
	SHORTSTRING_SETTEXT((&FMF),INTERFACE_VERSION);
 return FMF;
}

void FMFDLG_EXPORT PluginClose()
{
	DestroyWindow(ohWnd);
	UnregisterClass(defAppName,DLLInst);
	DLLInst=0;
}

void FMFDLG_EXPORT PluginUpdate()
{
					HANDLE fmfDlgExe=0;
					MSG msg;
 if(!ohWnd)
		return;
						InitPC();
					 fmfDlgExe=LoadLibrary("fmfdlg.exe");
						if(!fmfDlgExe)
						{
							DWORD RelDLL_Error;
						 LPVOID MsgBuffer;
							RelDLL_Error=GetLastError();
 						if(!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_FROM_SYSTEM,NULL,RelDLL_Error,0,(LPTSTR)&MsgBuffer,0, NULL))
							{
								MessageBox(NULL,"Unknown Error Occurred while linking to library","Error",MB_OK);
								return;
							}else{
								MessageBox(NULL,MsgBuffer,"Error loading executable",MB_OK);
        LocalFree(MsgBuffer);
								return;
	      }
						}else{
							/* Library Obtained. Run the Command */
							GetDLG=GetProcAddress(fmfDlgExe,FMF_GetDLG);
							if(!GetDLG)
							{
								MessageBox(NULL,"Error retrieving ExecuteScriptCommand.","Error",MB_OK);
								return;
							}else{ //* Run the command */
							Execute("debugmsg('GET DLG!');");
							Test=GetDLG();
							Execute("debugmsg('DONE!');");

						} /* */
					}
					if(Test)
	     PopulateList(liWnd,Test);
					else
						TreeView_DeleteAllItems(liWnd);
	FreeLibrary(fmfDlgExe);
 return;


}

void Execute(char * Command)
{
					HANDLE fmfDlgExe=0;
					MSG msg;

 if(!ohWnd)
		return;
					 fmfDlgExe=LoadLibrary("fmfdlg.exe");
						if(!fmfDlgExe)
						{
							DWORD RelDLL_Error;
						 LPVOID MsgBuffer;
							RelDLL_Error=GetLastError();
 						if(!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_FROM_SYSTEM,NULL,RelDLL_Error,0,(LPTSTR)&MsgBuffer,0, NULL))
							{
								MessageBox(NULL,"Unknown Error Occurred while linking to library","Error",MB_OK);
								return;
							}else{
								MessageBox(NULL,MsgBuffer,"Error loading executable",MB_OK);
        LocalFree(MsgBuffer);
								return;
	      }
						}else{
							/* Library Obtained. Run the Command */

							ExecuteScriptLines=GetProcAddress(fmfDlgExe,FMF_Execute);
							if(!ExecuteScriptLines)
							{
								MessageBox(NULL,"Error retrieving ExecuteScriptCommand.","Error",MB_OK);
								return;
							}else{ //* Run the command */
						} /* */
					}
	    ExecuteScriptLines(Command);


	FreeLibrary(fmfDlgExe);
 return;


}



void InitPC()
{
					HANDLE fmfDlgExe=0;
					MSG msg;

 if(!ohWnd)
		return;
					 fmfDlgExe=LoadLibrary("fmfdlg.exe");
						if(!fmfDlgExe)
						{
							DWORD RelDLL_Error;
						 LPVOID MsgBuffer;
							RelDLL_Error=GetLastError();
 						if(!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_FROM_SYSTEM,NULL,RelDLL_Error,0,(LPTSTR)&MsgBuffer,0, NULL))
							{
								MessageBox(NULL,"Unknown Error Occurred while linking to library","Error",MB_OK);
								return;
							}else{
								MessageBox(NULL,MsgBuffer,"Error loading executable",MB_OK);
        LocalFree(MsgBuffer);
								return;
	      }
						}else{
							/* Library Obtained. Run the Command */

							GetPlayer=GetProcAddress(fmfDlgExe,FMF_GetPlayer);
							if(!GetPlayer)
							{
								MessageBox(NULL,"Error retrieving GetPlayer.","Error",MB_OK);
								return;
							}else{ //* Run the command */
						} /* */
					}
	    PCStats=GetPlayer();
cmd = (char *)malloc(256);
cmd = "";
sprintf(cmd,"debugmsg('PC Stats! Name=%s, age=%d');",PCStats->name,PCStats->age);
Execute(cmd);
	FreeLibrary(fmfDlgExe);
 return;


}

int SingleConditionMet(FMF_PLAYERCHAR * StatsToUse,FMF_CONDITION * curCondition)
{
	long int SourceValue=0;
	long int CompareValue=0;
 char Test[200];

  CompareValue=atol(curCondition->check_value);
		switch(curCondition->check_type)
		{
			case CHECK_TYPE_SKILL:
 			SourceValue=StatsToUse->skills[curCondition->check_field-1].value;
				break;
			case CHECK_TYPE_CHECKMONEY:
				SourceValue=StatsToUse->dude_caps;
				break;
			case CHECK_TYPE_STAT:
				switch(curCondition->check_field)
				{
					case CHECK_FIELD_STAT_ST:
						SourceValue=StatsToUse->strength;
						break;
					case CHECK_FIELD_STAT_PE:
						SourceValue=StatsToUse->perception;
						break;
					case CHECK_FIELD_STAT_EN:
						SourceValue=StatsToUse->endurance;
						break;
					case CHECK_FIELD_STAT_CH:
						SourceValue=StatsToUse->charisma;
						break;
					case CHECK_FIELD_STAT_IN:
						SourceValue=StatsToUse->intelligence;
						break;
					case CHECK_FIELD_STAT_AG:
						SourceValue=StatsToUse->agility;
						break;
					case CHECK_FIELD_STAT_LK:
						SourceValue=StatsToUse->luck;
						break;
				} /* End Switch */
				break;
		} /* End Check Type Switch */

	/* Now Do actual compare */
	switch(curCondition->check_eval)
	{
		case COMPARE_EQUAL:
			if(SourceValue==CompareValue)
				return 1;
			break;
		case COMPARE_NOT_EQUAL:
			if(SourceValue!=CompareValue)
				return 1;
			break;
		case COMPARE_LARGER_THAN:
			if(SourceValue>CompareValue)
				return 1;
			break;
		case COMPARE_LESS_THAN:
			if(SourceValue<CompareValue)
				return 1;
			break;
		case COMPARE_LARGER_THAN_OR_EQUAL:
			if(SourceValue>=CompareValue)
				return 1;
			break;
		case COMPARE_LESS_THAN_OR_EQUAL:
			if(SourceValue<=CompareValue)
				return 1;
			break;
	}/* End actual compare. This means it failed */
	return 0;
}



int ConditionsMet(FMF_PLAYERCHAR * StatsToUse,FMF_OPTION * OptionNode)
{
	FMF_CONDITION * curCondition;
	int CondCnt=0;

	/* Check Gender */
	if(OptionNode->Gender && OptionNode->Gender!=StatsToUse->gender)
	 return 0;

	/* Check Intelligence */
	if(OptionNode->Intelligence>0 && OptionNode->Intelligence>StatsToUse->intelligence)
		return 0;

	if(OptionNode->Intelligence<0 && (0-OptionNode->Intelligence)<StatsToUse->intelligence)
		return 0;

	/* Check STats */
	for(CondCnt=0;CondCnt<OptionNode->conditioncnt;++CondCnt)
	{
		curCondition=OptionNode->conditions[CondCnt];
		if(!SingleConditionMet(StatsToUse,curCondition))
			return 0;
	} /* End Compare Loops */
	return 1;
}


int GetLineCount(HWND hWnd, char * TextToSize, int Off)
{
	int LineCount=1;
	char * LeftOver=TextToSize;
	int CharsFit=0;;
	char * BackTracker=0;
	SIZE strsize;
 HDC TreeWin=0;
	SIZE TreeSize;
	int Die=0;
 int set=30;
	if(Off)
		set+=10;

	return 1;
	TreeWin=GetWindowDC(hWnd);

	 RECT rect;
  GetClientRect(hWnd, (LPRECT) &rect);
  DPtoLP(TreeWin, (LPPOINT) &rect, 2);

	while(LeftOver && *LeftOver)
		{
			GetTextExtentExPoint(TreeWin,LeftOver,strlen(LeftOver)+1,rect.right-rect.left-set,&CharsFit,NULL,&strsize);
			if(LeftOver+CharsFit>=TextToSize+strlen(TextToSize) || !(*(LeftOver+CharsFit)))
				return LineCount;
			for(Die=0;Die<CharsFit;++Die)
				{
					if(*(LeftOver+Die)==0)
						return LineCount;
				}
			++LineCount;
			LeftOver=LeftOver+CharsFit;
		}
	return LineCount;
}


LRESULT DoCustomTVDraw(HWND hWnd,UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	LPNMTVCUSTOMDRAW DrawInfo=(LPNMTVCUSTOMDRAW)lParam;
	//return ( DefWindowProc (hWnd, uMsg, wParam, lParam));
	switch((DrawInfo->nmcd).dwDrawStage)
	{
  case CDDS_PREPAINT:
			return CDRF_NOTIFYITEMDRAW;
			break;
		case CDDS_ITEMPREPAINT:
			{
				TVITEM InfoPat;
				char iTst[1024];
				memset(iTst,0,1024);
				InfoPat.hItem=(HTREEITEM)((DrawInfo->nmcd).dwItemSpec);
			 InfoPat.mask=TVIF_TEXT|TVIF_HANDLE;
				InfoPat.pszText=iTst;
				InfoPat.cchTextMax=1024;

				return CDRF_DODEFAULT;
				// Normal for now.
				if(!TreeView_GetItem(liWnd,&InfoPat))
				{
					ShowError();
					return ( DefWindowProc (hWnd, uMsg, wParam, lParam));
				}
			  return WriteLines(hWnd,DrawInfo,iTst);
			}

			//return CDRF_SKIPDEFAULT;
			//return CDRF_DODEFAULT;
				break;
	}

	return ( DefWindowProc (hWnd, uMsg, wParam, lParam));
}


LRESULT WriteLines(HWND hWnd, LPNMTVCUSTOMDRAW DrawInfo, char * TextToWrite)
{
	int LineCount=0;
	char * LeftOver=TextToWrite;
	int CharsFit=0;;
	int LineHeight=0;
	char * BackTracker=0;
	SIZE strsize;
 HDC TreeWin=0;
	SIZE TreeSize;
	LPRECT DrawSpace;
	TreeWin=(DrawInfo->nmcd).hdc;
 DrawSpace=&((DrawInfo->nmcd).rc);
	int Die=0;
/*
			(DrawInfo->nmcd).hdc
			(DrawInfo->nmcd).rc
			(DrawInfo->nmcd).dwItemSpec
			(DrawInfo->nmcd).uItemState
			(DrawInfo->nmcd).
			DrawInfo->iLevel
	*/

	 LPRECT rect=DrawSpace;
  LineHeight=TreeView_GetItemHeight(hWnd);

  FillRect(TreeWin,DrawSpace,(HBRUSH)(COLOR_WINDOW+1));

	while(!Die && LeftOver && *LeftOver)
		{

			GetTextExtentExPoint(TreeWin,LeftOver,strlen(LeftOver),rect->right-rect->left-30,&CharsFit,NULL,&strsize);
			//GetTextExtentExPoint(TreeWin,"ABC",4,50,&CharsFit,NULL,&strsize);

			if(CharsFit==0)
			{
				LeftOver=0;
			}
			else
			{

		 	BackTracker=LeftOver+CharsFit;
				if(*BackTracker==0)
				{
					Die=1;
			 }else{
				 while (BackTracker>LeftOver && !isspace(*BackTracker))
 					{
 						--BackTracker;
 					}
				}



				if(BackTracker==LeftOver)
				{

					TextOut(TreeWin,DrawSpace->left+20,DrawSpace->top+LineCount*LineHeight,LeftOver,CharsFit);
					LeftOver=LeftOver+CharsFit;
				}else{
					if(*BackTracker==0)
						{

 					TextOut(TreeWin,DrawSpace->left+20,DrawSpace->top+LineCount*LineHeight,LeftOver,BackTracker-LeftOver);
						LeftOver=BackTracker;
					}
					else
						{

						TextOut(TreeWin,DrawSpace->left+20,DrawSpace->top+LineCount*LineHeight,LeftOver,BackTracker-LeftOver);

					LeftOver=BackTracker;
				}
				}
				++LineCount;
		 } //
		}
 //ReleaseDC(hWnd,TreeWin);

	return CDRF_SKIPDEFAULT;
}

