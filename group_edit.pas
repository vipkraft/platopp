unit group_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons,platproc;

type

  { TForm12 }

  TForm12 = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    Edit6: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label10: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Shape8: TShape;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form12: TForm12; 

implementation
uses
  mainopp, group;
{$R *.lfm}

{ TForm12 }

procedure TForm12.BitBtn3Click(Sender: TObject);
var
   new_id:integer;
begin
  With Form12 do
  begin
   //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if trim(form12.Edit6.text)='' then
      begin
       showmessagealt('Запись новых данных невозможна.'+#13+'Заполните все обязательные поля с данными !');
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
  if flag_edit=1 then
      begin
        form12.ZQuery1.SQL.Clear;
        form12.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_point_group;');
        form12.ZQuery1.open;
        new_id:=form12.ZQuery1.FieldByName('new_id').asInteger+1;
      end
  else
      begin
        new_id:=strtoint(trim(form12.Edit1.Text));
      end;

    //Производим запись новых данных
  //Маркируем запись на удачение если режим редактирования
  if flag_edit=2 then
      begin
       form12.ZQuery1.SQL.Clear;
       form12.ZQuery1.SQL.add('UPDATE av_spr_point_group SET del=1,createdate=default,id_user='+inttostr(new_id)+' WHERE id='+trim(form11.StringGrid1.Cells[0,form11.StringGrid1.row])+' and del=0;');
       form12.ZQuery1.ExecSQL;
      end;

  //Определяем id населенного пункта и id группы
  form12.ZQuery1.SQL.Clear;
  form12.ZQuery1.SQL.add('INSERT INTO av_spr_point_group(id, id_user, name');
  if flag_edit=1 then form12.ZQuery1.SQL.add(',createdate_first,id_user_first');
  form12.ZQuery1.SQL.add(') VALUES (');
  form12.ZQuery1.SQL.add(inttostr(new_id)+','+QuotedSTR(inttostr(id_user))+','+QuotedSTR(trim(form12.Edit6.text)));
  if flag_edit=1 then form12.ZQuery1.SQL.add(',default,'+inttostr(new_id));
  form12.ZQuery1.SQL.add(');');
  form12.ZQuery1.ExecSQL;
   // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  Close;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
end;
end;

procedure TForm12.BitBtn4Click(Sender: TObject);
begin
  form12.close;
end;

procedure TForm12.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
      // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then form12.Close;
    // F2 - Сохранить
    if (Key=113) and (form12.BitBtn3.Enabled=true) then form12.BitBtn3.Click;
end;

procedure TForm12.FormShow(Sender: TObject);
  var
   tmp_id_user:integer;
begin
  with form12 do
    begin
     if flag_access=1 then   BitBtn3.Enabled:=false;

  // Режим новой записи
  if flag_edit=1 then
   begin
      // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
     // Определяем пользователя
     form12.ZQuery1.SQL.Clear;
     form12.ZQuery1.SQL.add('Select * from av_users where id='+inttostr(id_user));
     form12.ZQuery1.open;
     form12.Label12.caption:='Последняя редакция: '+trim(form12.ZQuery1.FieldByName('fullname').asString)+'  '+trim(form12.ZQuery1.FieldByName('dolg').asString);
     form12.Zconnection1.disconnect;
   end;

  // Режим редактирования
  if flag_edit=2 then
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   // Определяем пользователя
   form12.ZQuery1.SQL.clear;
   form12.ZQuery1.SQL.add('select id,name,id_user from av_spr_point_group where del=0;');
   form12.ZQuery1.open;

   // Определяем текущие данные
   form12.Edit1.Text:=form12.ZQuery1.FieldByName('id').asString;
   form12.Edit6.Text:=form12.ZQuery1.FieldByName('name').asString;
   tmp_id_user:=form12.ZQuery1.FieldByName('id_user').asInteger;
   form12.ZQuery1.SQL.Clear;
   form12.ZQuery1.SQL.add('Select * from av_users where id='+inttostr(tmp_id_user));
   form12.ZQuery1.open;
   form12.Label12.caption:='Последняя редакция: '+trim(form12.ZQuery1.FieldByName('fullname').asString)+'  '+trim(form12.ZQuery1.FieldByName('dolg').asString);
   form12.Zconnection1.disconnect;
   end;
    end;
end;

end.

