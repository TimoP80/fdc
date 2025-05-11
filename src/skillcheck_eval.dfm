object Form27: TForm27
  Left = 1445
  Top = 542
  Width = 380
  Height = 331
  Caption = 'Skill Check'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object JvMarkupLabel1: TJvMarkupLabel
    Left = 8
    Top = 8
    Width = 345
    Height = 241
    Text = 
      'The player option you selected is linked to a skill check named:' +
      '<br><b>%s</b><br>with the following options:<br> <br> Skill = <b' +
      '>%s</b><br> Modifier = <b>%d</b><br> OnSuccess => <b>%s</b><br> ' +
      'OnFailure => <b>%s</b><br>  You can now choose which node to go ' +
      'to: Success/Failure/Evaluate<br> <br>Probability of success: <b>' +
      '%0.2f%% </b>  (out of <b>%d </b> executed checks)<br>Probability' +
      ' of failure: <b>%0.2f%% </b> (out of <b>%d </b> executed checks)' +
      '<br><br> <br> <b>[HELP]</b><i><br> Success = go to the success n' +
      'ode<br> Failure = go to the failure node<br> Evaluate = perform ' +
      'the skill check normally<br></i>'
  end
  object Button1: TButton
    Left = 32
    Top = 256
    Width = 97
    Height = 25
    Caption = 'Success'
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 240
    Top = 256
    Width = 97
    Height = 25
    Caption = 'Evaluate'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 136
    Top = 256
    Width = 97
    Height = 25
    Caption = 'Failure'
    ModalResult = 1
    TabOrder = 2
    OnClick = Button3Click
  end
end
