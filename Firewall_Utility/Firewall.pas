unit Firewall;
{
  adaptation <aboulouy@gmail.com>
  Référence : http://msdn2.microsoft.com/en-us/library/aa366415.aspx

}
Interface
uses
  SysUtils, ActiveX, ComObj;

Const
  // Define Constants from the SDK and their associated string name Scope
  NET_FW_SCOPE_ALL = 0;
  NET_FW_SCOPE_ALL_NAME = 'All subnets';
  NET_FW_SCOPE_LOCAL_SUBNET = 1;
  NET_FW_SCOPE_LOCAL_SUBNET_NAME = 'Local subnet only';
  NET_FW_SCOPE_CUSTOM = 2;
  NET_FW_SCOPE_CUSTOM_NAME = 'Custom Scope (see RemoteAddresses)';

  // Profile Type
  NET_FW_PROFILE_DOMAIN = 0;
  NET_FW_PROFILE_DOMAIN_NAME = 'Domain';
  NET_FW_PROFILE_STANDARD = 1;
  NET_FW_PROFILE_STANDARD_NAME = 'Standard';

  // IP Version
  NET_FW_IP_VERSION_V4 = 0;
  NET_FW_IP_VERSION_V4_NAME = 'IPv4';
  NET_FW_IP_VERSION_V6 = 1;
  NET_FW_IP_VERSION_V6_NAME = 'IPv6';
  NET_FW_IP_VERSION_ANY = 2;
  NET_FW_IP_VERSION_ANY_NAME = 'ANY';

  // Protocol
  NET_FW_IP_PROTOCOL_TCP = 6;
  NET_FW_IP_PROTOCOL_TCP_NAME = 'TCP';
  NET_FW_IP_PROTOCOL_UDP = 17;
  NET_FW_IP_PROTOCOL_UDP_NAME = 'UDP';


Type
  BOOL=-1..0;
Const
  VRAI  =-1;
  FAUX  = 0;

  FW_PROFILE    : Array[0..1]  of string =('DOMAIN','STANDARD');
  FW_IP_VERSION : Array[0..2]  of string =('V4','V6','ANY');
  FW_BOOL       :  Array[VRAI..FAUX]  of string =('ENABLED','DISABLED');
  Function FW_PROTOCOL(Value:Integer):String;


  Function IsFirewallEnabled:boolean;
  Function IsExceptionsNotAllowed:Boolean;
  Function IsNotificationsDisabled:Boolean;
  Function IsUnicastResponsestoMulticastBroadcastDisabled:Boolean;
  Function IsRemoteAdministrationEnabled:Boolean;

  Procedure FirewallEnabled(STATE:BOOL);
  Procedure ExceptionsNotAllowed(STATE:BOOL);
  Procedure NotificationsDisabled(STATE:BOOL);
  Procedure UnicastResponsestoMulticastBroadcastDisabled(STATE:BOOL);
  Procedure RemoteAdministrationEnabled(STATE:BOOL);

  Function IsAllowInboundEchoRequest:Boolean;
  Function IsAllowInboundMaskRequest:Boolean;
  Function IsAllowInboundRouterRequest:Boolean;
  Function IsAllowInboundTimestampRequest:Boolean;
  Function IsAllowOutboundDestinationUnreachable:Boolean;
  Function IsAllowOutboundPacketTooBig:Boolean;
  Function IsAllowOutboundParameterProblem:Boolean;
  Function IsAllowOutboundSourceQuench:Boolean;
  Function IsAllowOutboundTimeExceeded:Boolean;
  Function IsAllowRedirect:Boolean;

  Procedure AllowInboundEchoRequest(STATE:BOOL);
  Procedure AllowInboundMaskRequest(STATE:BOOL);
  Procedure AllowInboundRouterRequest(STATE:BOOL);
  Procedure AllowInboundTimestampRequest(STATE:BOOL);
  Procedure AllowOutboundDestinationUnreachable(STATE:BOOL);
  Procedure AllowOutboundPacketTooBig(STATE:BOOL);
  Procedure AllowOutboundParameterProblem(STATE:BOOL);
  Procedure AllowOutboundSourceQuench(STATE:BOOL);
  Procedure AllowOutboundTimeExceeded(STATE:BOOL);
  Procedure AllowRedirect(STATE:BOOL);

  Function  IsApplicationAuthorized(ApplicationPathAndExe:String):Boolean;
  Function  IsApplicationAuthorizedIsActive(ApplicationPathAndExe:String):Boolean;

  Procedure AddAnAuthorizedApplication(ApplicationName:string;ApplicationPathAndExe:string);
  Function  DeleteAnAuthorizedApplication(ApplicationPathAndExe:string):Integer;
  Procedure RestoreTheDefaultSettings;

  Procedure SetFirewall;

Implementation

Function IsFirewallEnabled:boolean;
Var
  objFirewall,
  objPolicy:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    Result:=objPolicy.FirewallEnabled
  except
  end;
end;

Function  IsExceptionsNotAllowed:Boolean;
Var
  objFirewall,
  objPolicy:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    Result:=objPolicy.ExceptionsNotAllowed;
  except
  end;
end;

Function  IsNotificationsDisabled:Boolean;
Var
  objFirewall,
  objPolicy:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    Result:=objPolicy.NotificationsDisabled;
  except
  end;
end;

Function  IsUnicastResponsestoMulticastBroadcastDisabled:Boolean;
Var
  objFirewall,
  objPolicy:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    Result:=objPolicy.UnicastResponsestoMulticastBroadcastDisabled;
  except
  end;
end;

Function IsRemoteAdministrationEnabled:Boolean;
Var
  objFirewall,
  objPolicy,
  objAdminSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objAdminSettings := objPolicy.RemoteAdminSettings;
    result:=objAdminSettings.Enabled;
  except
  end;
end;

Function IsAllowInboundEchoRequest:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowInboundEchoRequest;
  except
  end;
end;

Function IsAllowInboundMaskRequest:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowInboundMaskRequest;
  except
  end;
end;

Function IsAllowInboundRouterRequest:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowInboundRouterRequest;
  except
  end;
end;

Function IsAllowInboundTimestampRequest:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowInboundTimestampRequest;
  except
  end;
end;

Function IsAllowOutboundDestinationUnreachable:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowOutboundDestinationUnreachable;
  except
  end;
end;

Function IsAllowOutboundPacketTooBig:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowOutboundPacketTooBig;
  except
  end;
end;

Function IsAllowOutboundParameterProblem:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowOutboundParameterProblem;
  except
  end;
end;


Function IsAllowOutboundSourceQuench:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowOutboundSourceQuench;
  except
  end;
end;

Function IsAllowOutboundTimeExceeded:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowOutboundTimeExceeded;
  except
  end;
end;

Function IsAllowRedirect:Boolean;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    result:=objICMPSettings.AllowRedirect;
  except
  end;
end;

Procedure FirewallEnabled;
Var
  objFirewall,
  objPolicy :OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objPolicy.FirewallEnabled := STATE
  except
  end;
end;

Procedure ExceptionsNotAllowed;
Var
  objFirewall,
  objPolicy :OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objPolicy.ExceptionsNotAllowed := STATE
  except
  end;
end;

Procedure NotificationsDisabled;
Var
  objFirewall,
  objPolicy :OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objPolicy.NotificationsDisabled := STATE
  except
  end;
end;

Procedure UnicastResponsestoMulticastBroadcastDisabled;
Var
  objFirewall,
  objPolicy :OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objPolicy.UnicastResponsestoMulticastBroadcastDisabled := STATE
  except
  end;
end;

Procedure RemoteAdministrationEnabled;
Var
  objFirewall,
  objPolicy,
  objAdminSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objAdminSettings := objPolicy.RemoteAdminSettings;
    objAdminSettings.Enabled := STATE;
  except
  end;
end;

Procedure AllowInboundEchoRequest;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowInboundEchoRequest:=STATE;
  except
  end;
end;

Procedure AllowInboundMaskRequest;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowInboundMaskRequest:=STATE;
  except
  end;
end;

Procedure AllowInboundRouterRequest;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowInboundRouterRequest:=STATE;
  except
  end;
end;

Procedure AllowInboundTimestampRequest;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowInboundTimestampRequest:=STATE;
  except
  end;
end;

Procedure AllowOutboundDestinationUnreachable;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowOutboundDestinationUnreachable:=STATE;
  except
  end;
end;

Procedure AllowOutboundPacketTooBig;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowOutboundPacketTooBig:=STATE;
  except
  end;
end;

Procedure AllowOutboundParameterProblem;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowOutboundParameterProblem:=STATE;
  except
  end;
end;

Procedure AllowOutboundSourceQuench;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowOutboundSourceQuench:=STATE;
  except
  end;
end;

Procedure AllowOutboundTimeExceeded;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowOutboundTimeExceeded:=STATE;
  except
  end;
end;

Procedure AllowRedirect;
Var
  objFirewall,
  objPolicy,
  objICMPSettings:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    objICMPSettings := objPolicy.ICMPSettings;
    objICMPSettings.AllowRedirect := STATE;
  except
  end;
end;

Function FW_PROTOCOL(value:Integer):String;
begin
  case value of
    NET_FW_IP_PROTOCOL_UDP:result:='UDP';
    NET_FW_IP_PROTOCOL_TCP:result:='TCP';
  else
    result:='';
  end;
end;

Procedure AddAnAuthorizedApplication(ApplicationName:string;ApplicationPathAndExe:string);
Var
  objFirewall,
  objPolicy,
  objApplication,
  colApplications:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;

    objApplication := CreateOLEObject('HNetCfg.FwAuthorizedApplication');
    objApplication.Name := ApplicationName;
    objApplication.IPVersion := NET_FW_IP_VERSION_ANY;
    objApplication.ProcessImageFileName := ApplicationPathAndExe;
    objApplication.RemoteAddresses := '*';
    objApplication.Scope := NET_FW_SCOPE_ALL;
    objApplication.Enabled := VRAI;

    colApplications := objPolicy.AuthorizedApplications;
    colApplications.Add(objApplication);
  except
  end;
end;

Function DeleteAnAuthorizedApplication(ApplicationPathAndExe:string):Integer;
Var
  objFirewall,
  objPolicy,
  colApplications:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    colApplications := objPolicy.AuthorizedApplications;
    result := colApplications.Remove(ApplicationPathAndExe)
  except
  end;
end;

procedure RestoreTheDefaultSettings;
Var
  objFirewall:OleVariant;
begin
  Try
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objFirewall.RestoreDefaults;
  except
  end;
end;

Function IsApplicationAuthorized(ApplicationPathAndExe:String):Boolean;
Var
  objFirewall,
  objPolicy,
  objApplication,
  colApplications:OleVariant;
  IEnum : IEnumVariant;
  Count : LongWord;
begin
  Try
    result:=False;
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    colApplications := objPolicy.AuthorizedApplications;

    IEnum:=IUnKnown(colApplications._NewEnum) as IEnumVariant;
    While IEnum.Next(1,objApplication,Count)=S_OK Do
      if UpperCase(objApplication.ProcessImageFileName)=UpperCase(ApplicationPathAndExe) then
      begin
        result:=true;
        exit;
      end;
  except
  end;
end;

Function IsApplicationAuthorizedIsActive(ApplicationPathAndExe:String):Boolean;
Var
  objFirewall,
  objPolicy,
  objApplication,
  colApplications:OleVariant;
  IEnum : IEnumVariant;
  Count : LongWord;
begin
  Try
    result:=False;
    objFirewall := CreateOLEObject('HNetCfg.FwMgr');
    objPolicy := objFirewall.LocalPolicy.CurrentProfile;
    colApplications := objPolicy.AuthorizedApplications;

    IEnum:=IUnKnown(colApplications._NewEnum) as IEnumVariant;
    While IEnum.Next(1,objApplication,Count)=S_OK Do
      if UpperCase(objApplication.ProcessImageFileName)=UpperCase(ApplicationPathAndExe) then
      begin
        if objApplication.Enabled=VRAI  then result:=true;
        exit;
      end;
  except
  end;
end;


Procedure SetFirewall;
begin
  if IsExceptionsNotAllowed                             then ExceptionsNotAllowed(FAUX);
  if not IsNotificationsDisabled                        then NotificationsDisabled(VRAI);
  if IsUnicastResponsestoMulticastBroadcastDisabled     then UnicastResponsestoMulticastBroadcastDisabled(FAUX);
  if IsRemoteAdministrationEnabled                      then RemoteAdministrationEnabled(FAUX);
  if not IsAllowInboundEchoRequest                      then AllowInboundEchoRequest(VRAI);
end;

end.



