unit uslugi_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, EditBtn, Spin;


type

  { TFormuslugi_edit }

  TFormuslugi_edit = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit3: TEdit;
    Edit6: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Shape5: TShape;
    Shape8: TShape;
    Shape9: TShape;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formuslugi_edit: TFormuslugi_edit;

implementation
 uses
   mainopp,uslugi_main,platproc;
{$R *.lfm}

{ TFormuslugi_edit }

procedure TFormuslugi_edit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+ #13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then Formuslugi_edit.Close;
    // F2 - Сохранить
    if (Key=113) and (Formuslugi_edit.BitBtn3.Enabled=true) then Formuslugi_edit.BitBtn3.Click;
end;

procedure TFormuslugi_edit.FormShow(Sender: TObject);
 var
   tmp_id_user,n:integer;
begin
     Centrform(Formuslugi_edit);
   with Formuslugi_edit do
    begin
      Memo1.Clear;

  // Режим редактирования
  if flag_edit_uslugi=2 then
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   // Определяем данные
   Formuslugi_edit.ZQuery1.SQL.clear;
   Formuslugi_edit.ZQuery1.SQL.add('select id,name,short_name, sposob,swed,id_user from av_spr_uslugi where id='+trim(formuslugi.StringGrid1.Cells[0,formuslugi.StringGrid1.row])+' and del=0;');
   Formuslugi_edit.ZQuery1.open;

   // Определяем текущие данные
   Formuslugi_edit.Edit1.Text:=Formuslugi_edit.ZQuery1.FieldByName('id').asString;
   Formuslugi_edit.Edit6.Text:=Formuslugi_edit.ZQuery1.FieldByName('name').asString;
   Formuslugi_edit.Edit3.Text:=Formuslugi_edit.ZQuery1.FieldByName('short_name').asString;
   Formuslugi_edit.combobox1.Text:=Formuslugi_edit.ZQuery1.FieldByName('sposob').asString;
   Formuslugi_edit.Memo1.text:=Formuslugi_edit.ZQuery1.FieldByName('swed').asString;
   Formuslugi_edit.ZQuery1.Close;
   Formuslugi_edit.Zconnection1.disconnect;
   end;
  Edit6.SetFocus;
  end;
end;

procedure TFormuslugi_edit.BitBtn4Click(Sender: TObject);
begin
  Formuslugi_edit.close;
end;



procedure TFormuslugi_edit.Edit3Exit(Sender: TObject);
begin
  Formuslugi_edit.edit3.Text:=upperall(Formuslugi_edit.edit3.Text);
end;


procedure TFormuslugi_edit.BitBtn3Click(Sender: TObject);
 var
   new_id:integer;
begin
  With FOrmUslugi_edit do
  begin
   //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if (trim(Edit6.text)='') then
      begin
       showmessagealt('Сохранение НЕВОЗМОЖНО !'+#13+'Заполните поле наименования услуги !');
       exit;
      end;
  if (trim(Edit3.text)='') then
      begin
       showmessagealt('Сохранение НЕВОЗМОЖНО !'+#13+'Заполните поле краткого наименования услуги !');
       exit;
      end;
    if (trim(combobox1.Text)='') then
      begin
       showmessagealt('Сохранение НЕВОЗМОЖНО !'+#13+'Не определен способ оплаты !');
       exit;
      end;

  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
  //Открываем транзакцию
  try
   If not Zconnection1.InTransaction then
      Zconnection1.StartTransaction
   else
     begin
      showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      ZConnection1.Rollback;
      exit;
     end;
  //Определяем текущий id+1
   if flag_edit_uslugi=1 then
        begin
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('SELECT max(id) FROM av_spr_uslugi Where del=0;');
        ZQuery1.Open;
        new_id:=ZQuery1.FieldByName('max').asInteger+1;
       end
   else
     begin
     new_id := strToInt(Formuslugi_edit.Edit1.Text);
     end;
    //Производим запись новых данных
  //Маркируем запись на удачение если режим редактирования
  if flag_edit_uslugi=2 then
      begin
       Formuslugi_edit.ZQuery1.SQL.Clear;
       Formuslugi_edit.ZQuery1.SQL.add('UPDATE av_spr_uslugi SET del=1,createdate=now(),id_user='+inttostr(new_id)+' WHERE id='+trim(formuslugi.StringGrid1.Cells[0,formuslugi.StringGrid1.row])+' and del=0;');
    //   showmessagealt(Formuslugi_edit.ZQuery1.SQL.text);
       Formuslugi_edit.ZQuery1.ExecSQL;
      end;

  //Определяем id населенного пункта и id группы
  Formuslugi_edit.ZQuery1.SQL.Clear;
  Formuslugi_edit.ZQuery1.SQL.add('INSERT INTO av_spr_uslugi(id, id_user, name, short_name, sposob,swed');
  if flag_edit_uslugi=1 then Formuslugi_edit.ZQuery1.SQL.add(',createdate_first,id_user_first');
  Formuslugi_edit.ZQuery1.SQL.add(') VALUES (');
  Formuslugi_edit.ZQuery1.SQL.add(inttostr(new_id)+','+inttostr(id_user)+','+QuotedSTR(trim(Formuslugi_edit.Edit6.text))+','+QuotedSTR(trim(Formuslugi_edit.Edit3.text))+','+
                                  QuotedSTR(upperall(trim(Formuslugi_edit.ComboBox1.text)))+','+
                                  QuotedSTR(trim(Formuslugi_edit.memo1.text)));
  if flag_edit_uslugi=1 then Formuslugi_edit.ZQuery1.SQL.add(',now(),'+inttostr(id_user));
  Formuslugi_edit.ZQuery1.SQL.add(');');
  //showmessage(Formuslugi_edit.ZQuery1.SQL.text);
  Formuslugi_edit.ZQuery1.ExecSQL;
  // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  //showmessage('СОХРАНЕНО УСПЕШНО !');
  Close;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
end;
end;


end.

