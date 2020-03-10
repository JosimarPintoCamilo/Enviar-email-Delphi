unit ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, UPrincipal, Vcl.Mask;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    editUsuario: TEdit;
    Image3: TImage;
    Image4: TImage;
    btnCancelar: TImage;
    editSenha: TMaskEdit;
    Image7: TImage;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ListUsers: TList;

implementation

{$R *.dfm}




procedure TForm1.btnEntrarClick(Sender: TObject);
begin
   FormPrincipal.Show();
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  if (Trim( editUsuario.Text) = '') or (Trim( editSenha.Text) = '') then
  begin
    Application.MessageBox('Preencha todos os campos.','Atenção');
  end
  else
  begin
    if (editUsuario.Text = 'admin') and (editSenha.Text = 'admin') then
    begin
      FormPrincipal.Show;
    end
    else Application.MessageBox('Usuário Inválido.','Atenção');
  end;
end;

procedure TForm1.btnCancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
