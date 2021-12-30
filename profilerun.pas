unit profilerun;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls, StdCtrls,platproc;

type

  { TForm4 }

  TForm4 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel1Enter(Sender: TObject);
    procedure Panel1Exit(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel2Enter(Sender: TObject);
    procedure Panel2Exit(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form4: TForm4; 

implementation
uses
  mainopp;
{$R *.lfm}

{ TForm4 }

procedure TForm4.BitBtn1Click(Sender: TObject);
begin
  // Возвращаем выбор центрального сервера
  flagprofile:=1;
  form4.Close;
end;

procedure TForm4.BitBtn2Click(Sender: TObject);
begin
  // Возвращаем выбор эмулируемого сервера
  flagprofile:=2;
  form4.Close;
end;

procedure TForm4.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ESC] - Выход из программы'+#13+'[ENTER] - Выбор профиля');
    // ESC
    if Key=27 then form4.Close;
    // ENTER
    if Key=13 then
      begin
        if form4.Panel1.focused then Panel1Click(Sender);
        if form4.Panel2.focused then Panel2Click(Sender);
      end;
    if (Key=13) or (Key=112) or (Key=27) then Key:=0;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  Centrform(form4);
  form4.Panel1.SetFocus;
end;

procedure TForm4.Panel1Click(Sender: TObject);
begin
    // Возвращаем выбор центрального сервера
  flagprofile:=1;
  form4.Close;
end;

procedure TForm4.Panel1Enter(Sender: TObject);
begin
  form4.Label1.Font.Color:=clWhite;
end;

procedure TForm4.Panel1Exit(Sender: TObject);
begin
  form4.Label1.Font.Color:=clInactiveCaption;
end;

procedure TForm4.Panel2Click(Sender: TObject);
begin
   // Возвращаем выбор эмулируемого сервера
  flagprofile:=2;
  form4.Close;
end;

procedure TForm4.Panel2Enter(Sender: TObject);
begin
  form4.Label2.Font.Color:=clWhite;
end;

procedure TForm4.Panel2Exit(Sender: TObject);
begin
  form4.Label2.Font.Color:=clInactiveCaption;
end;

end.

