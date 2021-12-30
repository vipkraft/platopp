unit sezon;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids, EditBtn, Spin,platproc;

type

  { TFormSezon }

  TFormSezon = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckGroup1: TCheckGroup;
    CheckGroup2: TCheckGroup;
    ComboBox1: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    GroupBox1: TGroupBox;
    Image3: TImage;
    Image4: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Shape12: TShape;
    Shape13: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    SpinEdit1: TSpinEdit;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;

    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end; 

const
  cDataC = 'ДТС';//дата начала действия
  cDataP = 'ДТП';//дата окончания действия
  cWeek =  'НЕД';//недели месяца
  cDays =  'ДНИ';//дни недели
  cODD =   'НЧТ';//четные/нечетные дни
  cSeveral='ЧНД';//через несколько дней
  cNol = '';
var
  FormSezon: TFormSezon;

  fl_edit_sezon,new_id:integer;
  znacW,znacD,znacS,raspID,sezonID:string;

implementation
uses
  mainopp;
{$R *.lfm}

{ TFormSezon }


//*******************************************     ОТМЕНА  ************************************
procedure TFormSezon.BitBtn4Click(Sender: TObject);
begin
  FormSezon.close;
end;

procedure TFormSezon.CheckBox1Change(Sender: TObject);
begin
   If FormSezon.CheckBox1.Checked=true then
    FormSezon.CheckGroup1.Enabled:=true;
   If FormSezon.CheckBox1.Checked=false then
    begin
     FormSezon.CheckGroup1.Checked[0]:=false;
     FormSezon.CheckGroup1.Checked[1]:=false;
     FormSezon.CheckGroup1.Checked[2]:=false;
     FormSezon.CheckGroup1.Checked[3]:=false;
     FormSezon.CheckGroup1.Enabled:=false;
    end;
end;

procedure TFormSezon.CheckBox2Change(Sender: TObject);
begin
   If FormSezon.CheckBox2.Checked=true then
    FormSezon.CheckGroup2.Enabled:=true;
   If FormSezon.CheckBox2.Checked=false then
    begin
     FormSezon.CheckGroup2.Checked[0]:=false;
     FormSezon.CheckGroup2.Checked[1]:=false;
     FormSezon.CheckGroup2.Checked[2]:=false;
     FormSezon.CheckGroup2.Checked[3]:=false;
     FormSezon.CheckGroup2.Checked[4]:=false;
     FormSezon.CheckGroup2.Checked[5]:=false;
     FormSezon.CheckGroup2.Checked[6]:=false;
     FormSezon.CheckGroup2.Enabled:=false;
    end;
end;

procedure TFormSezon.CheckBox3Change(Sender: TObject);
begin
  If FormSezon.CheckBox3.Checked=true then
   begin
    FormSezon.Label7.Enabled:=true;
    FormSezon.ComboBox1.Enabled:=true;
   end;
  If FormSezon.CheckBox3.Checked=false then
   begin
    FormSezon.Label7.Enabled:=false;
    FormSezon.ComboBox1.ItemIndex:=-1;
    FormSezon.ComboBox1.Text:='Выберите периодичность...';
    FormSezon.ComboBox1.Enabled:=false;
   end;
end;

procedure TFormSezon.CheckBox4Change(Sender: TObject);
begin
   If FormSezon.CheckBox4.Checked=true then
    begin
    FormSezon.GroupBox1.Enabled:=true;
    FormSezon.Label3.Enabled:=true;
    FormSezon.SpinEdit1.Enabled:=true;
    FormSezon.Label5.Enabled:=true;
    end;
   If FormSezon.CheckBox4.Checked=false then
    begin
     FormSezon.GroupBox1.Enabled:=false;
    FormSezon.Label3.Enabled:=false;
    FormSezon.SpinEdit1.Enabled:=false;
    FormSezon.SpinEdit1.Value:=0;
    FormSezon.Label5.Enabled:=false;
    end;
end;

procedure TFormSezon.DateEdit2Exit(Sender: TObject);
begin
  with FormSezon do
  begin
  If DateEdit2.Date<DateEdit1.Date then
   begin
        showmessage('Некорректное значение даты !'+char(13)+'Значение даты начала действия расписания больше даты окончания !');
        DateEdit2.Text:='';
   end;
  end;
end;

//********************************************************   HOT   KEYS     *******************************************************
procedure TFormSezon.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // F1
    if Key=112 then showmessage('F1 - Справка'+char(13)+'F2 - Сохранить'+char(13)+'ESC - Отмена\Выход');
    //if Key=112 then showmessage('F1 - Справка'+char(13)+'F2 - Сохранить'+char(13)+'F4 - Изменить'+char(13)+'F5 - Добавить'+char(13)+'F8 - Удалить'+char(13)+'ENTER - Выбор'+char(13)+'ESC - Отмена\Выход');
    //F2 - Сохранить
    if (Key=113) and (FormSezon.bitbtn3.enabled=true) then FormSezon.bitbtn3.click;
    // ESC
    if Key=27 then FormSezon.Close;
    // ENTER  - Сохранить
    if Key=13 then
      begin
        FormSezon.BitBtn3.Click;
        //FormSezon.close;
      end;
end;

//************************************************    СОХРАНИТЬ  **********************************
procedure TFormSezon.BitBtn3Click(Sender: TObject);
begin
  With FormSezon do
  begin
  if (trim(DateEdit1.text)='') then
   begin
     showmessage('Не введена дата начала действия расписания !!!');
     exit;
   end;
  if (trim(DateEdit2.text)='') then
   begin
     showmessage('Не введена дата окончания действия расписания !!!');
     exit;
   end;
  try
      StrToDate(trim(DateEdit1.text));
  except
      showmessage('Некорректное значение даты начала действия расписания !');
      DateEdit1.text:='';
  end;
  try
      StrToDate(trim(DateEdit2.text));
  except
      showmessage('Некорректное значение даты окончания действия расписания !');
      DateEdit2.text:='';
  end;
  //формируем строчки значений
  //недели
  znacW := '';
  IF CheckGroup1.Checked[0]=false then
    znacW := znacW+'0'
  else
      znacW := znacW + '1';
  IF CheckGroup1.Checked[1]=false then
    znacW := znacW+'0'
  else
      znacW := znacW + '1';
  IF CheckGroup1.Checked[2]=false then
    znacW := znacW+'0'
  else
      znacW := znacW + '1';
  IF CheckGroup1.Checked[3]=false then
    znacW := znacW+'0'
  else
      znacW := znacW + '1';

  //дни недели
  znacD := '';
  IF CheckGroup2.Checked[0]=false then //пн
    znacD := znacD+'0'
  else
      znacD := znacD+'1';
  IF CheckGroup2.Checked[1]=false then //вт
    znacD := znacD+'0'
  else
      znacD := znacD+'1';
  IF CheckGroup2.Checked[2]=false then //ср
    znacD := znacD+'0'
  else
      znacD := znacD+'1';
  IF CheckGroup2.Checked[3]=false then //чт
    znacD := znacD+'0'
  else
      znacD := znacD+'1';
  IF CheckGroup2.Checked[4]=false then //пт
    znacD := znacD+'0'
  else
      znacD := znacD+'1';
  IF CheckGroup2.Checked[5]=false then //сб
    znacD := znacD+'0'
  else
      znacD := znacD+'1';
  IF CheckGroup2.Checked[6]=false then //вс
    znacD := znacD+'0'
  else
      znacD := znacD+'1';

  // Подключаемся к серверу
  if flagprofile=1 then MConnect(Zconnection1,ConnectINI[3],ConnectINI[1]);
  if flagprofile=2 then MConnect(Zconnection1,ConnectINI[6],ConnectINI[4]);
  try
      Zconnection1.connect;
  except
      showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      exit;
  end;

  //Открываем транзакцию
  Zconnection1.AutoCommit:=false;

  //*************** режим ДОБАВЛЕНИЯ
  IF fl_edit_sezon=1 then
  begin
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_shedule_sezon;');
  ZQuery1.open;
  new_id:=ZQuery1.FieldByName('new_id').asInteger+1;

  //дата с
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
  ZQuery1.SQL.add(inttostr(new_id)+',DEFAULT,'+inttostr(id_user)+',0,now(),'+inttostr(id_user)+','+raspID+',''Дата с'','+QuotedSTR(cDataC)+','+QuotedSTR(DateToStr(DateEdit1.Date))+','+QuotedSTR(cNol)+')');
  ZQuery1.ExecSQL;

  //дата по
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
  ZQuery1.SQL.add(inttostr(new_id)+',DEFAULT,'+inttostr(id_user)+',0,now(),'+inttostr(id_user)+','+raspID+',''Дата по'','+QuotedSTR(cDataP)+','+QuotedSTR(DateToStr(DateEdit2.Date))+','+QuotedSTR(cNol)+')');
  ZQuery1.ExecSQL;

  //недели
  IF trim(znacW)<>'0000' then
   begin
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
  ZQuery1.SQL.add(inttostr(new_id)+',DEFAULT,'+inttostr(id_user)+',0,now(),'+inttostr(id_user)+','+raspID+',''Недели'','+QuotedSTR(cWeek)+','+QuotedSTR(znacW)+','+QuotedSTR(cNol)+')');
  showmessage(ZQuery1.SQL.Text);
  ZQuery1.ExecSQL;
  end;
  //////////////////

  //дни недели
  IF trim(znacD)<>'0000000' then
   begin
  //дни недели
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
  ZQuery1.SQL.add(inttostr(new_id)+',DEFAULT,'+inttostr(id_user)+',0,now(),'+inttostr(id_user)+','+raspID+',''Дни недели'','+QuotedSTR(cDays)+','+QuotedSTR(znacD)+','+QuotedSTR(cNol)+')');
  showmessage(ZQuery1.SQL.Text);
  ZQuery1.ExecSQL;
  end;
 ///////////////
 // четные/нечетные
  If ComboBox1.ItemIndex>(-1) then
   begin
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
     ZQuery1.SQL.add(inttostr(new_id)+',DEFAULT,'+inttostr(id_user)+',0,now(),'+inttostr(id_user)+','+raspID+',''Четные/нечетные'','+QuotedSTR(cODD)+','+QuotedSTR(IntToStr(ComboBox1.ItemIndex))+','+QuotedSTR(cNol)+')');
     showmessage(ZQuery1.SQL.Text);
     ZQuery1.ExecSQL;
  end;
  ///////////////
 // через равное количество дней
  If SpinEdit1.value>0 then
   begin
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
     ZQuery1.SQL.add(inttostr(new_id)+',DEFAULT,'+inttostr(id_user)+',0,now(),'+inttostr(id_user)+','+raspID+',''Через несколько дней'','+QuotedSTR(cSeveral)+','+QuotedSTR(IntToStr(ComboBox1.ItemIndex))+','+QuotedSTR(cNol)+')');
     showmessage(ZQuery1.SQL.Text);
     ZQuery1.ExecSQL;
  end;
  end;

  //*************** режим РЕДАКТИРОВАНИЯ ****************
  IF fl_edit_sezon=2 then
  begin

  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('UPDATE av_shedule_sezon SET del=1 WHERE del=0 AND id='+sezonID+' AND id_shedule='+raspID+';');
  showmessage(ZQuery1.SQL.Text);
  ZQuery1.ExecSQL;

  //дата с
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
  ZQuery1.SQL.add(sezonID+',DEFAULT,'+inttostr(id_user)+',0,NULL,NULL,'+raspID+',''Дата с'','+QuotedSTR(cDataC)+','+QuotedSTR(DateToStr(DateEdit1.Date))+','+QuotedSTR(cNol)+')');
  ZQuery1.ExecSQL;

  //дата по
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
  ZQuery1.SQL.add(sezonID+',DEFAULT,'+inttostr(id_user)+',0,NULL,NULL,'+raspID+',''Дата по'','+QuotedSTR(cDataP)+','+QuotedSTR(DateToStr(DateEdit2.Date))+','+QuotedSTR(cNol)+')');
  ZQuery1.ExecSQL;

  //недели
  IF trim(znacW)<>'0000' then
   begin
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
  ZQuery1.SQL.add(sezonID+',DEFAULT,'+inttostr(id_user)+',0,NULL,NULL,'+raspID+',''Недели'','+QuotedSTR(cWeek)+','+QuotedSTR(znacW)+','+QuotedSTR(cNol)+')');
  ZQuery1.ExecSQL;
  end;
  //////////////////

  //дни недели
  IF trim(znacD)<>'0000000' then
   begin
  //дни недели
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
  ZQuery1.SQL.add(sezonID+',DEFAULT,'+inttostr(id_user)+',0,NULL,NULL,'+raspID+',''Дни недели'','+QuotedSTR(cDays)+','+QuotedSTR(znacD)+','+QuotedSTR(cNol)+')');
  ZQuery1.ExecSQL;
  end;
 ///////////////
 // четные/нечетные
  If (ComboBox1.ItemIndex=0) OR (ComboBox1.ItemIndex=1) then
   begin
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
     ZQuery1.SQL.add(sezonID+',DEFAULT,'+inttostr(id_user)+',0,NULL,NULL,'+raspID+',''Четные/нечетные'','+QuotedSTR(cODD)+','+QuotedSTR(IntToStr(ComboBox1.ItemIndex))+','+QuotedSTR(cNol)+')');
     ZQuery1.ExecSQL;
  end;
  ///////////////
 // через равное количество дней
  If SpinEdit1.value>0 then
   begin
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id,createdate,id_user,del,createdate_first,id_user_first,id_shedule,name,short_name,val1,val2) VALUES (');
     ZQuery1.SQL.add(sezonID+',DEFAULT,'+inttostr(id_user)+',0,NULL,NULL,'+raspID+',''Через несколько дней'','+QuotedSTR(cSeveral)+','+QuotedSTR(IntToStr(SpinEdit1.value))+','+QuotedSTR(cNol)+')');
     ZQuery1.ExecSQL;
  end;
  end;
  // Завершение транзакции
  Zconnection1.Commit;
  Zconnection1.AutoCommit:=true;
  if ZConnection1.InTransaction then
     begin
       showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
       ZConnection1.Rollback;
     end
  else
     begin
       showmessage('Транзакция завершена УСПЕШНО !!!');
       Zconnection1.disconnect;
       close;
     end;
  Zconnection1.disconnect;

end;
end;

//********************************************** ВОЗНИКНОВЕНИЕ ФОРМЫ ***************************************
procedure TFormSezon.FormShow(Sender: TObject);
begin
     Centrform(Formsezon);
    raspID:='777';
     with FormSezon do
      begin
    if flag_access=1 then
     begin
        BitBtn3.Enabled:=false;
        BitBtn4.Enabled:=false;
        DateEdit1.Enabled:=false;
        DateEdit2.Enabled:=false;
        CheckBox1.Enabled:=false;
        CheckBox2.Enabled:=false;
        CheckBox3.Enabled:=false;
        CheckBox4.Enabled:=false;
     end;

       // Подключаемся к серверу
       if flagprofile=1 then MConnect(Zconnection1,ConnectINI[3],ConnectINI[1]);
       if flagprofile=2 then MConnect(Zconnection1,ConnectINI[6],ConnectINI[4]);
         try
          Zconnection1.connect;
         except
         showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
         exit;
         end;
      // запрос
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('SELECT max(id) FROM av_shedule_sezon WHERE id_shedule='+raspID+' AND del=0;');
      try
        ZQuery1.Open;
      except
        showmessage('Выполнение команды SQL SELECT - ОШИБКА !'+#13+'Команда: '+ZQuery1.SQL.Text);
        ZQuery1.Close;
        Zconnection1.disconnect;
      end;
      If  ZQuery1.RecordCount>0 then
      sezonID:=trim(ZQuery1.FieldByName('max').asString);

      //Определяем режим работы
      If trim(sezonID)='' then
         fl_edit_sezon:=1  //режим добавления
      else
         fl_edit_sezon:=2; //режим редактирования

   end;

end;


end.

