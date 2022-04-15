unit lgot_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons;
  //ColorBox, SynHighlighterAny;

type

  { TFormlgot_edit }

  TFormlgot_edit = class(TForm)
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
    Shape10: TShape;
    Shape5: TShape;
    Shape8: TShape;
    Shape9: TShape;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formlgot_edit: TFormlgot_edit;

implementation
 uses
   mainopp,lgot_main,platproc;
{$R *.lfm}

{ TFormlgot_edit }

procedure TFormlgot_edit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+ #13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then formlgot_edit.Close;
    // F2 - Сохранить
    if (Key=113) and (formlgot_edit.BitBtn3.Enabled=true) then formlgot_edit.BitBtn3.Click;
end;

procedure TFormlgot_edit.FormShow(Sender: TObject);
 var
   tmp_id_user,n:integer;
begin
   with formlgot_edit do
   begin
     if flag_access=1 then BitBtn3.Enabled:=false;
  // Определяем доступные значения Combobox1
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
  // Определяем значения
  formlgot_edit.ZQuery1.SQL.Clear;
  formlgot_edit.ZQuery1.SQL.add('Select distinct(zakon) from av_spr_lgot;');
  formlgot_edit.ZQuery1.open;
  if formlgot_edit.ZQuery1.RecordCount>0 then;
     begin
      for n:=1 to formlgot_edit.ZQuery1.RecordCount do
         begin
          formlgot_edit.combobox1.items.Add(trim(formlgot_edit.ZQuery1.FieldByName('zakon').asString));
          formlgot_edit.ZQuery1.Next;
         end;
     end;
  formlgot_edit.ZQuery1.close;
  formlgot_edit.Zconnection1.disconnect;

  // Режим редактирования
  if flag_edit_lgot=2 then
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   // Определяем данные
   formlgot_edit.ZQuery1.SQL.clear;
   formlgot_edit.ZQuery1.SQL.add('select id,name,short_name, zakon,swed,id_user from av_spr_lgot where id='+trim(formlgot.StringGrid1.Cells[0,formlgot.StringGrid1.row])+' and del=0;');
   formlgot_edit.ZQuery1.open;

   // Определяем текущие данные
   formlgot_edit.Edit1.Text:=formlgot_edit.ZQuery1.FieldByName('id').asString;
   formlgot_edit.Edit6.Text:=formlgot_edit.ZQuery1.FieldByName('name').asString;
   formlgot_edit.Edit3.Text:=formlgot_edit.ZQuery1.FieldByName('short_name').asString;
   formlgot_edit.combobox1.Text:=formlgot_edit.ZQuery1.FieldByName('zakon').asString;
   formlgot_edit.Memo1.text:=formlgot_edit.ZQuery1.FieldByName('swed').asString;
   formlgot_edit.ZQuery1.Close;
   formlgot_edit.Zconnection1.disconnect;
   end;
  end;
end;

procedure TFormlgot_edit.BitBtn4Click(Sender: TObject);
begin
  formlgot_edit.close;
end;

procedure TFormlgot_edit.ComboBox1Exit(Sender: TObject);
begin
  formlgot_edit.ComboBox1.Text:=upperall(formlgot_edit.ComboBox1.Text);
end;

procedure TFormlgot_edit.Edit3Exit(Sender: TObject);
begin
  formlgot_edit.edit3.Text:=upperall(formlgot_edit.edit3.Text);
end;

procedure TFormlgot_edit.BitBtn3Click(Sender: TObject);
 var
   new_id:integer;
begin
  with FOrmLgot_edit do
  begin
   //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if (trim(formlgot_edit.Edit6.text)='') or
     (trim(formlgot_edit.Edit3.text)='') or
     (trim(formlgot_edit.combobox1.text)='') or
     (trim(formlgot_edit.Memo1.lines[1])='')  then
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
  if flag_edit_lgot=1 then
     begin
        formlgot_edit.ZQuery1.SQL.Clear;
        formlgot_edit.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_lgot where del=0;');
        formlgot_edit.ZQuery1.open;
        new_id:=formlgot_edit.ZQuery1.FieldByName('new_id').asInteger+1;
     end
  else
  new_id := StrToInt(FormLgot_edit.Edit1.Text);
    //Производим запись новых данных
  //Маркируем запись на удачение если режим редактирования
  if flag_edit_lgot=2 then
      begin
       formlgot_edit.ZQuery1.SQL.Clear;
       formlgot_edit.ZQuery1.SQL.add('UPDATE av_spr_lgot SET del=1,createdate=now(),id_user='+inttostr(new_id)+' WHERE id='+trim(formlgot.StringGrid1.Cells[0,formlgot.StringGrid1.row])+' and del=0;');
       formlgot_edit.ZQuery1.ExecSQL;
      end;

  //Определяем id населенного пункта и id группы
  formlgot_edit.ZQuery1.SQL.Clear;
  formlgot_edit.ZQuery1.SQL.add('INSERT INTO av_spr_lgot(id, id_user, name, short_name, zakon, swed');
  if flag_edit_lgot=1 then formlgot_edit.ZQuery1.SQL.add(',createdate_first,id_user_first');
  formlgot_edit.ZQuery1.SQL.add(') VALUES (');
  formlgot_edit.ZQuery1.SQL.add(inttostr(new_id)+','+inttostr(id_user)+','+QuotedSTR(trim(formlgot_edit.Edit6.text))+','+QuotedSTR(trim(formlgot_edit.Edit3.text))+','+QuotedSTR(trim(formlgot_edit.ComboBox1.text))+','+QuotedSTR(trim(formlgot_edit.memo1.text)));
  if flag_edit_lgot=1 then formlgot_edit.ZQuery1.SQL.add(',now(),'+inttostr(id_user));
  formlgot_edit.ZQuery1.SQL.add(');');
  //showmessage(formlgot_edit.ZQuery1.SQL.Text);
  formlgot_edit.ZQuery1.ExecSQL;

  // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  //showmessage('СОХРАНЕНО УСПЕШНО !');
  Close;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
end;

end;

end.

