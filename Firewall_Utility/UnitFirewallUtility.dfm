object FirewallUtility: TFirewallUtility
  Left = 235
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Firewall Utility'
  ClientHeight = 373
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object EnableFirewall: TButton
    Left = 8
    Top = 40
    Width = 193
    Height = 25
    Caption = 'Enable Firewall'
    TabOrder = 0
    OnClick = EnableFirewallClick
  end
  object DisableFirewall: TButton
    Left = 8
    Top = 72
    Width = 193
    Height = 25
    Caption = 'Disable Firewall'
    TabOrder = 1
    OnClick = DisableFirewallClick
  end
  object FirewallProperties: TButton
    Left = 8
    Top = 8
    Width = 193
    Height = 25
    Caption = 'Firewall Properties'
    TabOrder = 2
    OnClick = FirewallPropertiesClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 104
    Width = 626
    Height = 269
    Align = alBottom
    TabOrder = 3
  end
  object ListAuthorizedApplications: TButton
    Left = 216
    Top = 8
    Width = 201
    Height = 25
    Caption = 'List Authorized Applications'
    TabOrder = 4
    OnClick = ListAuthorizedApplicationsClick
  end
  object RestoreTheDefaultSettings: TButton
    Left = 216
    Top = 40
    Width = 201
    Height = 25
    Caption = 'Restore the Default Settings'
    TabOrder = 5
    OnClick = RestoreTheDefaultSettingsClick
  end
  object ListServices: TButton
    Left = 424
    Top = 8
    Width = 193
    Height = 25
    Caption = 'List Services'
    TabOrder = 6
    OnClick = ListServicesClick
  end
  object ICMPSettings: TButton
    Left = 424
    Top = 40
    Width = 193
    Height = 25
    Caption = 'ICMP Settings'
    TabOrder = 7
    OnClick = ICMPSettingsClick
  end
  object FixFirewall: TButton
    Left = 216
    Top = 72
    Width = 201
    Height = 25
    Caption = 'Fix Firewall'
    TabOrder = 8
    OnClick = FixFirewallClick
  end
end
