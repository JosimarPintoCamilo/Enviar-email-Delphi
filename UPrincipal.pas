unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdBaseComponent, IdMessage, Vcl.StdCtrls, Vcl.ExtDlgs, IdSSL, IdSSLOpenSSL, UTesteEagle,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFormPrincipal = class(TForm)
    editDe: TEdit;
    editPara: TEdit;
    editAssunto: TEdit;
    editMensagem: TMemo;
    IdMessage1: TIdMessage;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label5: TLabel;
    btnEnviar: TImage;
    Label6: TLabel;
    Image7: TImage;
    mensagemEnvio: TPanel;
    procedure btnEnviarClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure editMensagemEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation




{$R *.dfm}

procedure TFormPrincipal.btnEnviarClick(Sender: TObject);

var

SMTPCon: TIdSMTP;
SMTPMsg: TIdMessage;
SMTPIOHandler: TIdSSLIOHandlerSocketOpenSSL;
novoEmail: EnviarEmail;

begin
  if (Trim( editPara.Text) = '') or (Trim( editAssunto.Text) = '') or ( editMensagem.GetTextLen = 0) then
  begin
      Application.MessageBox('Preencha todos os campos.','Atenção');
  end
  else
  begin
    novoEmail := EnviarEmail.Create();

    novoEmail.hostServidor    := 'smtp.gmail.com';
    novoEmail.portaServidor   := 465;
    novoEmail.usuarioServidor := 'josimartester@gmail.com';
    novoEmail.senhaUsuario    := 'josimartester2100';

    novoEmail.nomeRemetente      := 'Teste Eagle';
    novoEmail.remetenteEmail     := 'josimartester@gmail.com';
    novoEmail.destinatariosEmail := editPara.Text;
    novoEmail.assuntoEmail       := editAssunto.Text;
    novoEmail.mensagemEmail      := editMensagem.Lines.Text;

    mensagemEnvio.Caption := 'Enviando...';
    mensagemEnvio.Visible := true;
    mensagemEnvio.Update;
    if novoEmail.enviarEmail() then
    begin
      mensagemEnvio.Visible := false;
      Application.MessageBox('E-mails enviados com sucesso!','Sucesso!');
    end
    else
    begin
      mensagemEnvio.Visible := false;
      Application.MessageBox('Erro ao enviar e-mails. Verifique os campos e a conexão com a internet.','Atenção');
    end;

  end;

end;

procedure TFormPrincipal.btnSelecionarClick(Sender: TObject);
var
 openDialog:   TOpenDialog;
 listaEmails: ImportarEmails;
begin
  openDialog            := TOpenDialog.Create(self);
  openDialog.InitialDir := 'C:\';
  openDialog.Options    := [ofFileMustExist];
  openDialog.Filter := 'All files (*.*)|*.*';

  if openDialog.Execute  then
  begin
    listaEmails := ImportarEmails.Create();
    listaEmails.caminhoArquivo := openDialog.FileName;

    if editPara.Text = '' then
      editPara.Text :=  listaEmails.montarLista()
    else
      editPara.Text :=  editPara.Text + ',' + listaEmails.montarLista();

  end;

  openDialog.Free;
end;

procedure TFormPrincipal.editMensagemEnter(Sender: TObject);
begin
  editMensagem.SelectAll;
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

end.
