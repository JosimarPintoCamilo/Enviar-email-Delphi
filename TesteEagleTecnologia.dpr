program TesteEagleTecnologia;

uses
  Vcl.Forms,
  ULogin in 'ULogin.pas' {Form1},
  UPrincipal in 'UPrincipal.pas' {FormPrincipal},
  UTesteEagle in 'UTesteEagle.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
