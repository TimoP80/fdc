// Last updated: 12.4.2005 19:04

#pragma pack(1)
#define FMFDLG_API __stdcall
#define FMFDLG_EXPORT FMFDLG_API __declspec(dllexport)

#define MAX_OPTIONS 512
#define MAX_NODES 512
#define MAX_CONDITIONS 64

#define FMF_Execute "ExecuteScriptLines"
#define FMF_GetDLG "GetDLG"
#define FMF_DLGName "GetCurrentDLGName"
#define FMF_GetCurrentNode "GetCurrentNode"
#define FMF_SetCurrentNode "SetCurrentNode"
#define FMF_SendDebugMSG "SendDebugMSG"
#define FMF_GetPlayer "GetPlayer"

#define INTERFACE_VERSION "0.25"

/* DELPHI Data Structures */
typedef struct
{
	char Size;
	char Text[255];
} ShortString;


/* FMFDlg Data Structures */


/* Player character structure

*/

typedef struct
{
char *name;
int value;
} FMF_SKILL;

typedef struct
{
char *name;
int gender;
int age;
int strength;
int perception;
int endurance;
int charisma;
int intelligence;
int agility;
int luck;
int dude_caps;

// NOTE!!! This was "array [0..17] of skill"
//         in the original pascal code so I don't know if
//	   C arrays are zero-based. If they aren't, change this to 18
//	   but if they are, then leave it be.
//
//		-djunique
//
FMF_SKILL skills[17];

} FMF_PLAYERCHAR;

/* Node condition structure


*/


typedef struct
{
 long int check_type;
 long int check_field;
 long int check_eval;
 char * check_value;
 char * resolved_code;
} FMF_CONDITION;

/* Node Option Structure */
typedef struct
{
	char * optiontext;
	char * nodelink;
	// NodeResolved = index of the target node in the node list -DjUnique
	long int NodeResolved;
	long int Reaction;
	long int Gender;
	long int Intelligence;
	char * notes;
	FMF_CONDITION * conditions[MAX_CONDITIONS+1];
	long int conditioncnt;
} FMF_OPTION;

/* Dialogue Node Structure */
typedef struct
{
	char * nodename;
	char * npctext;
	char * femaletext;
	char * notes;
	FMF_OPTION * options[MAX_OPTIONS+1];
	long int optioncnt;
} FMF_DLGNODE;

/* Dialog Structure */

typedef struct
{
 char * filename;
 char * npcname;
 char * description;
 char * location;
 char * unknowndesc;
 char * knowndesc;
 char * detaileddesc;
	FMF_DLGNODE * nodes [MAX_NODES+1];
	long int nodecount;
} FMF_DLG;




/* Functions that must be exported */
ShortString FMFDLG_EXPORT GetPluginName();
ShortString FMFDLG_EXPORT GetPluginDescription();
ShortString FMFDLG_EXPORT GetInterfaceVersion();
void FMFDLG_EXPORT RunPlugin(ShortString basepath);
BOOL FMFDLG_EXPORT CanAddToMenu();

/* Functions that may be exported

  Comment out the ones you want to export

*/

// This function returns a shortcut string and assigns
// it to the menu item the plugin is associated with.
// if this function is not present in the DLL, no shortcut
// will be assigned

// ShortString FMFDLG_EXPORT GetKeyShortCut();

// PluginClose is called when the tool is exiting
// You must free any windows that have been created

 void FMFDLG_EXPORT PluginClose();

// This forces the plugin to refresh any data it is displaying
// for example, if you have a dialogue structure, you must
// call GetDLG again to get the updated dialogue

 void FMFDLG_EXPORT PluginUpdate();

// This function is made to allow displaying of debug messages in
// a plugin or to log them into a file even when debugmode is off
// (ie the debug window is not visible)
// The message is stored in the msg parameter.
// void FMFDLG_EXPORT DebugIntercept(char *msg);


/* Functions available through FMFDlg.exe */
typedef void (FMFDLG_API * FMF_FUNC_Execute)(char *);
typedef FMF_DLG * (FMFDLG_API * FMF_FUNC_GetDLG)();
typedef void (FMFDLG_API * FMF_FUNC_DLGName)(char *);

/*

SetCurrentNode		Sets the current node to a specified node

			(only if dialogue is running)

GetCurrentnode		Gets the current node the dialogue test is
			running at

			(only if dialogue is running)


*/

typedef ShortString (FMFDLG_API * FMF_FUNC_GetCurrentNode) ();
typedef FMF_PLAYERCHAR * (FMFDLG_API * FMF_FUNC_GetPlayer) ();
typedef void (FMFDLG_API * FMF_FUNC_SetCurrentNode)(ShortString);
// Sends a debug message to the tool, which will then process it

// WARNING! Avoid using debug messages in a plugin that contains
//          a DebugIntercept function because that is likely
//	    to cause an endless loop.

typedef void (FMFDLG_API * FMF_FUNC_SendDebugMSG) (char *);
