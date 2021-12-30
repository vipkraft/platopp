unit nas_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls, EditBtn,platproc, ZConnection, ZDataset;

type

  { TForm6 }

  TForm6 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form6: TForm6;

implementation
 uses
   nas,read_nas,mainopp,other_nas;
{$R *.lfm}

{ TForm6 }

procedure TForm6.BitBtn4Click(Sender: TObject);
begin
  form6.close;
end;

procedure TForm6.BitBtn5Click(Sender: TObject);
begin
  type_read:=4;
  form7:=Tform7.create(self);
  form7.ShowModal;
  FreeAndNil(form7);
  if not(result_name_full='') then form6.edit5.Text:=result_name_full;
end;

procedure TForm6.BitBtn6Click(Sender: TObject);
begin
  type_read:=1;
  form7:=Tform7.create(self);
  form7.ShowModal;
  FreeAndNil(form7);
  if not(result_name_full='') then form6.edit2.Text:=result_name_full;
end;

procedure TForm6.BitBtn7Click(Sender: TObject);
begin
  // Вывод сообщения о возможной задержке
  if (trim(form6.edit2.text)='') and (trim(form6.edit3.text)='') and (trim(form6.edit4.text)='') and (trim(form6.edit2.text)='') then
      begin
       showmessagealt('Работа данной функции возможна при условии заполнения одного или нескольких полей формы:'+#13+'   -Наименование населенного пункта'+#13+'   -Страна'+#13+'   -Регион'+#13+'   -Район'+#13+'первыми бувами названия.'+#13+'   Чем больше начальных букв названий в вышеперчисленных полях данных будет введено'+#13+'тем полноценнее будет выпонен поиск.');
       exit;
      end;
  form8:=Tform8.create(self);
  form8.ShowModal;
  FreeAndNil(form8);
  if not(result_name='') then
   begin
    with Form6 do
    begin
 //   showmessagealt(result_name);
    //Выбираем данные из av_locality_new по id населенного пункта
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   form6.ZQuery1.SQL.clear;
   form6.ZQuery1.SQL.Add('select name,land,region,rajon,lat,lon from av_spr_geokladr where id='+trim(result_name)+';');
   form6.ZQuery1.open;
   if form6.ZQuery1.RecordCount=0 then
    begin
      showmessagealt('Ошибка доступа к данным !!! Попробуйте еще раз !!!');
      form6.ZQuery1.close;
      form6.ZConnection1.Disconnect;
      exit;
    end;
      //населенный пункт
      form6.edit2.Text:=form6.ZQuery1.FieldByName('name').asString;
      //страна
      form6.edit3.Text:=form6.ZQuery1.FieldByName('land').asString;
      //Регион
      form6.edit4.Text:=form6.ZQuery1.FieldByName('region').asString;
      //Район
      form6.edit5.Text:=form6.ZQuery1.FieldByName('rajon').asString;
      //Широта
      form6.edit6.Text:=form6.ZQuery1.FieldByName('lat').asString;
      //Долгота
      form6.edit7.Text:=form6.ZQuery1.FieldByName('lon').asString;
      form6.ZQuery1.close;
      form6.ZConnection1.Disconnect;
      end;
   end;
end;


procedure TForm6.FormShow(Sender: TObject);
var
   tmp_id_user:integer;
begin
  Centrform(form6);
  with form6 do
       begin
     if flag_access=1 then  BitBtn3.Enabled:=false;

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
     form6.ZQuery1.SQL.Clear;
     form6.ZQuery1.SQL.add('Select * from av_users where id='+inttostr(id_user));
     form6.ZQuery1.open;
     form6.Label11.caption:='Последняя редакция: '+trim(form6.ZQuery1.FieldByName('fullname').asString)+'  '+trim(form6.ZQuery1.FieldByName('dolg').asString);
     form6.Zconnection1.disconnect;
   end;

  // Режим редактирования
  if flag_edit=2 then
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   // Определяем пользователя
   form6.ZQuery1.SQL.clear;
   form6.ZQuery1.SQL.add('Select * from av_spr_locality where id='+trim(form5.StringGrid1.Cells[0,form5.StringGrid1.row])+' and del=0');
   form6.ZQuery1.open;
   // Определяем текущие данные
   form6.Edit1.Text:=form6.ZQuery1.FieldByName('id').asString;
   form6.Edit2.Text:=form6.ZQuery1.FieldByName('name').asString;
   form6.combobox1.Text:=form6.ZQuery1.FieldByName('typ_locality').asString;
   form6.Edit3.Text:=form6.ZQuery1.FieldByName('land').asString;
   form6.Edit4.Text:=form6.ZQuery1.FieldByName('region').asString;
   form6.Edit5.Text:=form6.ZQuery1.FieldByName('rajon').asString;
   form6.Edit6.Text:=form6.ZQuery1.FieldByName('lat').asString;
   form6.Edit7.Text:=form6.ZQuery1.FieldByName('lon').asString;
   form6.combobox2.Text:=form6.ZQuery1.FieldByName('typ_region').asString;
   tmp_id_user:=form6.ZQuery1.FieldByName('id_user').asInteger;
   form6.ZQuery1.SQL.Clear;
   form6.ZQuery1.SQL.add('Select * from av_users where id='+inttostr(tmp_id_user));
   form6.ZQuery1.open;
   form6.Label11.caption:='Последняя редакция: '+trim(form6.ZQuery1.FieldByName('fullname').asString)+'  '+trim(form6.ZQuery1.FieldByName('dolg').asString);
   form6.Zconnection1.disconnect;
   end;

  end;
end;

procedure TForm6.BitBtn1Click(Sender: TObject);
begin
  type_read:=2;
  form7:=Tform7.create(self);
  form7.ShowModal;
  FreeAndNil(form7);
  if not(result_name_full='') then form6.edit3.Text:=result_name_full;
end;

procedure TForm6.BitBtn2Click(Sender: TObject);
begin
  type_read:=3;
  form7:=Tform7.create(self);
  form7.ShowModal;
  FreeAndNil(form7);
  if not(result_name_full='') then form6.edit4.Text:=result_name_full;
end;

procedure TForm6.BitBtn3Click(Sender: TObject);
 var
   new_id:integer;
begin
  With Form6 do
  begin
  //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if (trim(form6.Edit2.text)='') or
     (trim(form6.ComboBox1.text)='') or
     (trim(form6.ComboBox2.text)='') or
     (trim(form6.Edit3.text)='') or
     (trim(form6.Edit4.text)='') or
     (trim(form6.Edit5.text)='') then
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
        form6.ZQuery1.SQL.Clear;
        form6.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_locality;');
        form6.ZQuery1.open;
        new_id:=form6.ZQuery1.FieldByName('new_id').asInteger+1;
      end
  else
      begin
        new_id:=strtoint(trim(form6.Edit1.Text));
      end;

    //Производим запись новых данных
  //Маркируем запись на удачение если режим редактирования
  if flag_edit=2 then
      begin
       form6.ZQuery1.SQL.Clear;
       form6.ZQuery1.SQL.add('UPDATE av_spr_locality SET del=1,createdate=default WHERE id='+trim(form5.StringGrid1.Cells[0,form5.StringGrid1.row])+' and del=0;');
       form6.ZQuery1.ExecSQL;
      end;
  form6.ZQuery1.SQL.Clear;
  form6.ZQuery1.SQL.add('INSERT INTO av_spr_locality(id, id_user, name, typ_locality, rajon, region,typ_region,land');
  if flag_edit=1 then form6.ZQuery1.SQL.add(',createdate_first,id_user_first');
  form6.ZQuery1.SQL.add(') VALUES (');
  form6.ZQuery1.SQL.add(inttostr(new_id)+','+QuotedSTR(inttostr(id_user))+','+QuotedSTR(trim(form6.Edit2.text))+','+QuotedSTR(trim(form6.Combobox1.text))+','+QuotedSTR(trim(form6.Edit5.text))+','+QuotedSTR(trim(form6.Edit4.text))+','+QuotedSTR(trim(form6.ComboBox2.text))+','+QuotedSTR(trim(form6.Edit3.text)));
  if flag_edit=1 then form6.ZQuery1.SQL.add(',default,'+inttostr(new_id));
  form6.ZQuery1.SQL.add(');');
  form6.ZQuery1.ExecSQL;
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



procedure TForm6.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'F9 - Выбор из другого источника'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then form6.Close;
    // F2 - Сохранить
    if (Key=113) and (form6.BitBtn3.Enabled=true) then form6.BitBtn3.Click;
    // F9 - Другой источник
    if (Key=129) and (form6.BitBtn7.Enabled=true) then form6.BitBtn7.Click;
    if (Key=112) or (Key=113) or (Key=129) or (Key=27) then Key:=0;
end;






end.

