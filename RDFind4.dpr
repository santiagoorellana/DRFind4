program RDFind4;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas',
  UProcedencia in 'UProcedencia.pas' {FormProcedencia};

{$R *.res}

begin
Application.Initialize;
Application.Title := 'RDFind4';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.


