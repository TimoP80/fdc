�
 TFORM1 0�  TPF0TForm1Form1Left� Top� BorderStylebsDialogCaption!Script Exporter - Output SettingsClientHeight�ClientWidth�Color	clBtnFace
ParentFont	OldCreateOrderPositionpoScreenCenterShowHint	PixelsPerInch`
TextHeight TLabelLabel11Left�Top�Width� HeightCaptionBase MSG number increment  	TGroupBox	GroupBox1LeftTopWidth�HeightyCaptionOutput filenamesTabOrder  TLabelLabel1LeftTopWidth$HeightCaptionSSL File  TLabelLabel2LeftTop@Width(HeightCaptionMSG File  TJvFilenameEditLMDFileOpenEdit1LeftTop(WidthiHeightCursorcrIBeam
DefaultExtsslFlat	
ParentFlatFilterSSL Files (*.ssl)|*.sslDialogOptionsofHideReadOnlyofNoChangeDir 
AutoSelect
ButtonFlat	ColorclWhite
ImageIndex ButtonWidthTabOrder Text      TJvFilenameEditLMDFileOpenEdit2LeftTopPWidthiHeightCursorcrIBeam
DefaultExtmsgFlat	
ParentFlatFilterMSG Files (*.msg)|*.msgDialogOptionsofHideReadOnlyofNoChangeDir 
AutoSelect
ButtonFlat	ColorclWhite
ImageIndex TabOrderText       	TGroupBox	GroupBox2LeftTop� Width�Height9CaptionScript Global DataTabOrder TLabelLabel3LeftTopWidthJHeightCaptionScript Template  TLabelLabel4LeftTopHWidth/HeightCaptionNPCName  TLabelLabel5LeftTophWidth5HeightCaptionDescription  TLabelLabel6LeftTop� Width(HeightCaptionLocation  TLabelLabel10LeftTop� Width,Height	AlignmenttaRightJustifyCaptionScript ID
Constant  TEditEdit1LeftHTopAWidth1HeightHint�The content of this edit box is 
retrieved from the global npc properties 
in the dialogue so you don't need to do 
anything to this if you have already 
specified the properties earlierTabOrderOnChangeEdit1Change  TEditEdit3LeftHTop� Width1HeightTabOrder  TEditEdit4LeftHTop� Width1HeightAutoSizeTabOrder  TMemoEdit2LeftHTop`Width1Height1Hint�The content of this edit box is 
retrieved from the global npc properties 
in the dialogue so you don't need to do 
anything to this if you have already 
specified the properties earlierTabOrder  TJvFilenameEditLMDFileOpenEdit3LeftTop WidthiHeightCursorcrIBeamHint)This specifies the script template to use
DefaultExtsslFlat	
ParentFlatFilterSSL Files (*.ssl)|*.sslDialogOptionsofHideReadOnlyofNoChangeDir 
AutoSelect
ButtonFlat	ColorclWhite
ImageIndex TabOrder Text      	TComboBoxtemplateListLeftTop WidthiHeightTabOrder  	TCheckBox	CheckBox3LeftTop� WidthAHeightCaption)Include MSG text references to the scriptTabOrder  	TCheckBox	CheckBox4LeftTop� WidthaHeightCaption9Insert node names to the beginning of each node procedureTabOrder  	TCheckBox	CheckBox5LeftTopWidthaHeightCaption4Show debug dump of local variables on dialogue startTabOrder  	TCheckBox	CheckBox6LeftTop WidthyHeightCaptionAdd debug info for skill checksTabOrder	   TButtonButton1LeftPTop�WidthAHeightCaptionOKTabOrderOnClickButton1Click  TButtonButton2Left�Top�WidthAHeightCaptionCancelModalResultTabOrderOnClickButton2Click  	TGroupBox	GroupBox3Left�TopWidthAHeightqCaptionDescriptionsTabOrder TLabelLabel7LeftTopWidth,HeightCaptionUnknown  TLabelLabel8LeftTopxWidth HeightCaptionKnown  TLabelLabel9LeftTop� WidthnHeightCaptionDetailed (glance desc.)  TMemoMemo1LeftTop(Width1HeightIHint�The content of this memo control is 
retrieved from the global npc properties 
in the dialogue so you don't need to do 
anything to this if you have already 
specified the properties earlierTabOrder   TMemoMemo2LeftTop� Width1HeightYHint�The content of this memo control is 
retrieved from the global npc properties 
in the dialogue so you don't need to do 
anything to this if you have already 
specified the properties earlierTabOrder  TMemoMemo3LeftTop� Width1HeightiHint�The content of this memo control is 
retrieved from the global npc properties 
in the dialogue so you don't need to do 
anything to this if you have already 
specified the properties earlierTabOrder   	TCheckBox	CheckBox1LefthTop�Width� HeightHint6  If this is checked, the script will be exported directly to SSL + MSG and the
intermediate file is deleted after the process is finished.

When unchecked, the export process stops to the DDF file which is compilable with the commandline tool. (This is useful when you want to add more start conditions etc.)Caption#Output script (SSL && MSG) directlyChecked	State	cbCheckedTabOrder  TButtonButton4Left(Top�WidthAHeightHintRThis clears all controls (prompts if you wish to keep the script template, though)Caption	Clear AllTabOrderOnClickButton4Click  TEditEdit5Left�Top�Width8HeightHintJThis value specifies how much to increment the MSG ID number on each node.TabOrderText10  TUpDownUpDown1Left!Top�WidthHeight	AssociateEdit5Max� Position
TabOrder  	TCheckBox	CheckBox2Left�Top�WidthHeightCaption*Compile script to the following directory:TabOrder	  TJvDirectoryEditJvDirectoryEdit1Left�Top�Width1HeightFlat	
ParentFlat
ButtonFlat	TabOrder
Text      TButtonButton5LeftTop�WidthAHeightCaptionHelpTabOrderOnClickButton5Click   