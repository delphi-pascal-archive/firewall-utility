unit UnitFirewallUtility;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ActiveX, Dialogs, ComObj, StdCtrls, Spin, Firewall;

type
  TFirewallUtility = class(TForm)
    FirewallProperties: TButton;
    EnableFirewall: TButton;
    DisableFirewall: TButton;
    Memo1: TMemo;
    ListAuthorizedApplications: TButton;
    RestoreTheDefaultSettings: TButton;
    ListServices: TButton;
    ICMPSettings: TButton;
    FixFirewall: TButton;
    procedure FixFirewallClick(Sender: TObject);
    procedure ICMPSettingsClick(Sender: TObject);
    procedure ListServicesClick(Sender: TObject);
    procedure RestoreTheDefaultSettingsClick(Sender: TObject);
    procedure ListAuthorizedApplicationsClick(Sender: TObject);

    procedure FirewallPropertiesClick(Sender: TObject);
    procedure EnableFirewallClick(Sender: TObject);
    procedure DisableFirewallClick(Sender: TObject);
  end;

var
  FirewallUtility: TFirewallUtility;

implementation

{$R *.dfm}

procedure TFirewallUtility.ListServicesClick(Sender: TObject);
Var
  objFirewall,
  objPolicy,
  objService,
  colServices,
  objPort,
  colPorts:OleVariant;
  IEnum : IEnumVariant;
  Count1,Count2:LongWord;
begin
  Memo1.Clear;
  objFirewall := CreateOLEObject('HNetCfg.FwMgr');
  objPolicy := objFirewall.LocalPolicy.CurrentProfile;
  colServices := objPolicy.Services;

  IEnum:=IUnKnown(colServices._NewEnum) as IEnumVariant;

  While IEnum.Next(1,objService,Count1)=S_OK Do
  With Memo1.Lines do
  begin
    Add(objService.Name+ ' - '+
    FW_BOOL[StrToInt(BoolToStr(objService.Enabled))]+ ' - '+
    IntToStr(objService.Type)+ ' - '+
    FW_IP_VERSION[integer(objService.IPVersion)]+ ' - '+
    FW_BOOL[StrToInt(BoolToStr(objService.Scope))]+ ' - '+
    objService.RemoteAddresses+ ' - '+
    FW_BOOL[StrToInt(BoolToStr(objService.Customized))]);

    (*
    colPorts := objService.GloballyOpenPorts;

    While IEnum.Next(1,objPort,Count2)=S_OK Do
    With Memo1.Lines do
    begin
      Add(objPort.Name);
      Add(IntToStr(objPort.Port));


      Add(FW_BOOL[StrToInt(BoolToStr(objPort.Enabled))]);
      Add(objService.Type);
      Add(String(objPort.BuiltIn));
      Add(FW_IP_VERSION[integer(objPort.IPVersion)]);
      Add(FW_BOOL[StrToInt(BoolToStr(objPort.Scope))]);
      Add(objService.objPort.Protocol);
      Add(objService.RemoteAddresses);

    End;
    *)
  End;
end;

procedure TFirewallUtility.ICMPSettingsClick(Sender: TObject);
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
  IEnum : IEnumVariant;
  Count:LongWord;
begin
  Memo1.Clear;
  objFirewall := CreateOLEObject('HNetCfg.FwMgr');
  objPolicy := objFirewall.LocalPolicy.CurrentProfile;
  objICMPSettings := objPolicy.ICMPSettings;

  With Memo1.Lines do
  Begin
    Add('Inbound echo request: '             +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowInboundEchoRequest))]);
    Add('Inbound mask request: '             +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowInboundMaskRequest))]);
    Add('Inbound router request: '           +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowInboundRouterRequest))]);
    Add('Inbound timestamp request: '        +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowInboundTimestampRequest))]);
    Add('Outbound destination unreachable: '+FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowOutboundDestinationUnreachable))]);
    Add('Outbound packet too big: '         +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowOutboundPacketTooBig))]);
    Add('Outbound parameter problem: '      +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowOutboundParameterProblem))]);
    Add('Outbound source quench: '          +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowOutboundSourceQuench))]);
    Add('Outbound time exceeded: '          +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowOutboundTimeExceeded))]);
    Add('Redirect: '                        +FW_BOOL[StrToInt(BoolToStr(objICMPSettings.AllowRedirect))]);
  end;
end;

procedure TFirewallUtility.FirewallPropertiesClick(Sender: TObject);
Var
  objFirewall,
  objPolicy :OleVariant;

  CurrentProfileType:String;
  FirewallEnabled:Boolean;
  ExceptionsNotAllowed:Boolean;
  NotificationsDisabled:Boolean;
  UnicastResponsestoMulticastBroadcastDisabled:Boolean;
begin
  Memo1.Clear;
  objFirewall := CreateOLEObject('HNetCfg.FwMgr');
  objPolicy := objFirewall.LocalPolicy.CurrentProfile;
  CurrentProfileType                          :=FW_PROFILE[Integer(objFirewall.CurrentProfileType)];
  FirewallEnabled                             :=(Integer(objPolicy.FirewallEnabled)=VRAI);
  ExceptionsNotAllowed                        :=(Integer(objPolicy.ExceptionsNotAllowed)=VRAI);
  NotificationsDisabled                       :=(Integer(objPolicy.NotificationsDisabled)=VRAI);
  UnicastResponsestoMulticastBroadcastDisabled:=(Integer(objPolicy.UnicastResponsestoMulticastBroadcastDisabled)=VRAI);

  FirewallUtility.Memo1.Lines.Clear;
  With FirewallUtility.Memo1.Lines do
    begin
      Add('Current profile type: '                             +CurrentProfileType);
      Add('Firewall enabled: '                                 +FW_BOOL[StrToInt(BoolToStr(FirewallEnabled))]);
      Add('Exceptions not allowed: '                           +FW_BOOL[StrToInt(BoolToStr(ExceptionsNotAllowed))]);
      Add('Notifications disabled: '                           +FW_BOOL[StrToInt(BoolToStr(NotificationsDisabled))]);
      Add('Unicast responses to multicast broadcast disabled: '+FW_BOOL[StrToInt(BoolToStr(UnicastResponsestoMulticastBroadcastDisabled))]);
    end;
end;

procedure TFirewallUtility.EnableFirewallClick(Sender: TObject);
begin
  FirewallEnabled(VRAI);
end;

procedure TFirewallUtility.FixFirewallClick(Sender: TObject);
begin
  SetFirewall;
end;

procedure TFirewallUtility.DisableFirewallClick(Sender: TObject);
begin
  FirewallEnabled(FAUX);
end;

procedure TFirewallUtility.ListAuthorizedApplicationsClick(Sender: TObject);
Var
  objFirewall,
  objPolicy,
  objApplication,
  colApplications:OleVariant;
  IEnum : IEnumVariant;
  Count : LongWord;
begin
  objFirewall := CreateOLEObject('HNetCfg.FwMgr');
  objPolicy := objFirewall.LocalPolicy.CurrentProfile;
  colApplications := objPolicy.AuthorizedApplications;

  IEnum:=IUnKnown(colApplications._NewEnum) as IEnumVariant;

  Memo1.Clear;
  
  While IEnum.Next(1,objApplication,Count)=S_OK Do
  With Memo1.Lines do
  begin
    Add(objApplication.Name+ ' - '+
    FW_BOOL[StrToInt(BoolToStr(objApplication.Enabled))]+ ' - '+
    FW_IP_VERSION[integer(objApplication.IPVersion)]+ ' - '+
    objApplication.ProcessImageFileName+ ' - '+
    objApplication.RemoteAddresses+ ' - '+
    FW_BOOL[StrToInt(BoolToStr(objApplication.Scope))]);
  End;
end;

procedure TFirewallUtility.RestoreTheDefaultSettingsClick(Sender: TObject);
begin
  RestoreTheDefaultSettings.Click;
end;

end.


