unit UEnviarEmail;

interface
  type
  novoEmail = class
    emailDoRemetente: String;
    tituloDoEmail: String;
    emailDoDestinatario: String;
    mensagemDoEmail: String;
    anexoDoEmail: String;
//    function enviarEmail(): Boolean;
  end;
implementation
uses IdSMTP, IdMessage, IdSSLOpenSSL;

//  function enviarEmail(): Boolean;
//  var
//    SMTPCon: TIdSMTP;
//    SMTPMensagem: TIdMessage;
//    SMTPIOHandler: TIdSSLIOHandlerSocketOpenSSL;
//  begin
//
//  end;
end.
