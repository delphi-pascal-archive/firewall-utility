program FrewallUtility;

uses
  Forms,
  UnitFirewallUtility in 'UnitFirewallUtility.pas' {FirewallUtility},
  Firewall in 'Firewall.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFirewallUtility, FirewallUtility);
  Application.Run;
end.
