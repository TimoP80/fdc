(*

FMF Dialogue Tool - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2008 T. Pitkänen

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

*)

unit debugwnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
type
  TForm11 = class(TForm)
    ListBox1: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11:    TForm11;
  debugmode: boolean;
  tx: textfile;
procedure DebugMSG(str: string; sender: string = 'MainApp');
procedure ResetLog;

implementation

uses pluginapi;
{$R *.dfm}

procedure ResetLog;
begin
 assignfile(tx,extractfiledir(paramstr(0))+'\debug.log');
   rewrite(tx);
closefile(tx);
end;

procedure DebugMSG(str: string; sender: string = 'MainApp');
begin
 assignfile(tx,extractfiledir(paramstr(0))+'\debug.log');
   if fileexists(extractfiledir(paramstr(0))+'\debug.log') then
   begin
   Append(tx);
   end else
   rewrite(tx);
   writeln(tx,datetimetostr(now)+': '+str);
   closefile(tx);

  if debugmode = True then
  begin

    if (form11 <> nil) and (form11.visible=true) then
    begin
      //showmessage('Trying to add:' +str);
      Form11.ListBox1.Items.add(str);
      form11.listbox1.ItemIndex := form11.listbox1.items.Count - 1;
      form11.listbox1.ItemIndex := -1;

    end;

    // DebugIntercept (data: string)

  end;
 // debugmessages can be processed by plugins even when debugmode = false
 // only if sender is MainApp!!1!
 if sender = 'MainApp' then DoDebugIntercept(str);
end;
end.

