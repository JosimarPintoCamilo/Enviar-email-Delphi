unit UTesteEagle;

interface
type

  EnviarEmail = class
    hostServidor:    String;
    portaServidor:   Integer;
    usuarioServidor: String;
    senhaUsuario:    String;

    nomeRemetente:      String;
    remetenteEmail:     String;
    destinatariosEmail: String;
    assuntoEmail:       String;
    mensagemEmail:      String;

    function enviarEmail(): Boolean;
  end;

  ImportarEmails = class
    caminhoArquivo: String;
    arquivoDeEmails: TextFile;
    contador, i: Integer;
    linhaArquivo: String;
    listaEmails: String;

    function  montarLista(): String;
    function  montaEmail() : String;
  end;

implementation
uses IdSMTP, IdMessage, IdIOHandlerSocket, IdSSLOpenSSL, IdExplicitTLSClientServerBase;

function EnviarEmail.enviarEmail(): Boolean;
var

SMTPCon: TIdSMTP;
SMTPMsg: TIdMessage;
SMTPIOHandler: TIdSSLIOHandlerSocketOpenSSL;

begin
  //email teste josimarifmg@gmail.com senha: josimarifmg@gmail.com https://mailtrap.io/

  SMTPCon       := TIdSMTP.Create();
  SMTPMsg       := TIdMessage.Create();
  SMTPIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create();

  SMTPCon.Host      := hostServidor;
  SMTPCon.Port      := portaServidor;
  SMTPCon.Username  := usuarioServidor;
  SMTPCon.Password  := senhaUsuario;
  SMTPCon.IOHandler := SMTPIOHandler;
  SMTPCon.UseTLS    := utUseExplicitTLS;

  with SMTPIOHandler do
  begin
     Destination            := hostServidor;
     Host                   := hostServidor;
     Port                   := portaServidor;
     SSLOptions.Method      := sslvTLSv1;
     SSLOptions.Mode        := sslmUnassigned;
     SSLOptions.VerifyMode  := [];
     SSLOptions.VerifyDepth := 0;
  end;

  SMTPMsg.From.Name                 := nomeRemetente;
  SMTPMsg.From.Address              := remetenteEmail;
  SMTPMsg.Recipients.EMailAddresses := destinatariosEmail;
  SMTPMsg.Subject                   := assuntoEmail;
  SMTPMsg.Body.Add( mensagemEmail );

  try

    SMTPCon.Connect();
    SMTPCon.Send(SMTPMsg);
    SMTPCon.Disconnect();

    SMTPMsg.Clear;
    SMTPCon.Free;
    SMTPIOHandler.Free;
    Result := True;

  except

    SMTPCon.Free;
    SMTPIOHandler.Free;
    Result := False;

  end;

end;

function ImportarEmails.montaEmail(): String;
var
    emailMontado: String;
  begin
    emailMontado := '';
    inc(i);
    While linhaArquivo[i] >= ' ' do
    begin
      If (linhaArquivo[i] = ';') or (linhaArquivo[i] = ',')then
        break;
      emailMontado := emailMontado + linhaArquivo[i];
      inc(i);
    end;

    result := emailMontado;
  end;

function ImportarEmails.montarLista(): String;
begin
  listaEmails := '';
  AssignFile(arquivoDeEmails, caminhoArquivo);

  try
    Reset(arquivoDeEmails);
    Readln(arquivoDeEmails, linhaArquivo);
    contador := 1;

    while not Eoln(arquivoDeEmails) do
    begin

      if contador = 1 then
      begin
        i := 0;
        listaEmails := listaEmails + montaEmail;
      end;

      i := 0;
      Readln(arquivoDeEmails, linhaArquivo);
      listaEmails := listaEmails + ',' + montaEmail;
      contador := contador + 1;

    end;

    Result :=  listaEmails;

  finally
    CloseFile(arquivoDeEmails);
  end;
end;

end.
