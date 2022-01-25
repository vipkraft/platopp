unit TicketTypes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, FileUtil, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls, EditBtn, platproc,
  LazUtf8, ticketShablon, ticket;

type

  { TFormTicket }

  TFormTicket = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn8: TBitBtn;
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Edit1: TEdit;
    EditButton1: TEditButton;
    EditButton2: TEditButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton1Exit(Sender: TObject);
    procedure EditButton2ButtonClick(Sender: TObject);
    procedure EditButton2Change(Sender: TObject);
    procedure EditButton2Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1Enter(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string); //обновить грида
    //************ обновление разновидностей чеков услуг ******************
    procedure UpdateServices();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormTicket: TFormTicket;
  result_name:string;
  Fl_Edit_TT : integer;
  shablon_ID : string;
  flname: boolean = false;
  ttype,tusr,nkontr,nshedule:integer;
  tname,tcat,skontr,sshedule:string;


implementation
 uses
  mainopp,kontr_main,shedule_main;
{$R *.lfm}

{ TFormTicket }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag,flshedatp :boolean;
  //ar_seats : array of string;

//************ обновление разновидностей чеков услуг ******************
procedure TFormTicket.UpdateServices();
var
  n:integer;
begin
  With FormTicket do
 begin
// Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   ZQuery1.SQL.Clear;
   // Выбор всего списка
   ZQuery1.SQL.add('Select distinct category ');
   ZQuery1.SQL.add(' FROM av_tick_shablon WHERE del=0 ');
   ZQuery1.SQL.add(' and not(POSITION(''ОБЫЧНЫЙ'' IN name)>0 OR POSITION(''ВОИНСКИЙ'' IN name)>0 OR POSITION(''ЛЬГОТНЫЙ'' IN name)>0 ');
   ZQuery1.SQL.add(' OR POSITION(''МЕЖ'' IN category)>0 OR POSITION(''ЛЮБ'' IN category)>0) ');
   ZQuery1.SQL.add(' order by category; ');
   //showmessage(ZQuery1.SQL.Text);//$
   try
    ZQuery1.open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
   end;
   //сбросить строки комбо
   Combobox4.Items.Clear;
   Combobox4.Items.Add('ЛЮБОЙ');

   for n:=1 to ZQuery1.RecordCount do
    begin
      //ProgressBar1.Position:=ProgressBar1.Position+1;
      //ProgressBar1.Refresh;
      Combobox4.Items.Add(ZQuery1.FieldByName('category').asString);
      ZQuery1.Next;
    end;
   //ProgressBar1.Position:=0;
   //ProgressBar1.Visible:=false;
   ZQuery1.Close;
   Zconnection1.disconnect;
   Combobox4.ItemIndex:=0;
 end;
end;

//*********************  обновить грид  **********************************
procedure TFormTicket.UpdateGrid(filter_type:byte; stroka:string);
var
   n:integer;
begin
// With FormTicket do
// begin
//// Подключаемся к серверу
//   If not(Connect2(Zconnection1, flagProfile)) then
//     begin
//      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
//      Close;
//      exit;
//     end;
//   //запрос списка
//   ZQuery1.SQL.Clear;
//   // Выбор всего списка
//   ZQuery1.SQL.add('Select * from av_tick_shablon WHERE del=0 AND usr_category='+inttostr(Combobox1.ItemIndex)+' ORDER BY id ASC;');
//   try
//    ZQuery1.open;
//   except
//    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
//    ZQuery1.Close;
//    Zconnection1.disconnect;
//   end;
//   //сбросить строки грида
//   StringGrid1.RowCount:=1;
//   if ZQuery1.RecordCount<1 then
//     begin
//      ZQuery1.Close;
//      Zconnection1.disconnect;
//      exit;
//     end;
//   // Заполняем stringgrid
//   ProgressBar1.Max:=ZQuery1.RecordCount;
//   ProgressBar1.Visible:=true;
//   for n:=1 to ZQuery1.RecordCount do
//    begin
//      ProgressBar1.Position:=ProgressBar1.Position+1;
//      ProgressBar1.Refresh;
//      StringGrid1.RowCount:=StringGrid1.RowCount+1;
//      StringGrid1.Cells[0,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('id').asString;
//      StringGrid1.Cells[1,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('name').asString;
//      StringGrid1.Cells[2,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('category').asString;
//      If ZQuery1.FieldByName('type_sale').asInteger=1 then
//         StringGrid1.Cells[3,StringGrid1.RowCount-1]:='Продажа';
//      If ZQuery1.FieldByName('type_sale').asInteger=2 then
//         StringGrid1.Cells[3,StringGrid1.RowCount-1]:='Возврат';
//      If ZQuery1.FieldByName('id_kontr').asInteger>0 then
//        StringGrid1.Cells[4,StringGrid1.RowCount-1]:='П';
//      If ZQuery1.FieldByName('id_shedule').asInteger>0 then
//        StringGrid1.Cells[4,StringGrid1.RowCount-1]:='Р';
//      If (ZQuery1.FieldByName('id_kontr').asInteger>0) and (ZQuery1.FieldByName('id_shedule').asInteger>0) then
//        StringGrid1.Cells[4,StringGrid1.RowCount-1]:='П/Р';
//
//      ZQuery1.Next;
//    end;
//   ProgressBar1.Position:=0;
//   ProgressBar1.Visible:=false;
//   ZQuery1.Close;
//   Zconnection1.disconnect;
// end;

 With FormTicket do
 begin
   formTicket.Label1.Caption := 'ВСЕГО: ';
// Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   ZQuery1.SQL.Clear;
   // Выбор всего списка
   ZQuery1.SQL.add('Select * from av_tick_shablon WHERE del=0 ');

   //БИЛЕТ / УСЛУГА
   if not (checkbox1.Checked AND checkbox2.checked) then
      begin
        if checkbox1.Checked then
        begin
            ZQuery1.SQL.add('and (POSITION(''ОБЫЧНЫЙ'' IN UPPER(name))>0 OR POSITION(''ВОИНСКИЙ'' IN UPPER(name))>0 ');
            ZQuery1.SQL.add('OR POSITION(''ЛЬГОТНЫЙ'' IN UPPER(name))>0 OR POSITION(''МЕЖ'' IN category)>0 OR POSITION(''ЛЮБ'' IN category)>0) ');
          end;
        if checkbox2.Checked then
        begin
            ZQuery1.SQL.add('and NOT (POSITION(''ОБЫЧНЫЙ'' IN UPPER(name))>0 OR POSITION(''ВОИНСКИЙ'' IN UPPER(name))>0 ');
            ZQuery1.SQL.add('OR POSITION(''ЛЬГОТНЫЙ'' IN UPPER(name))>0 OR POSITION(''МЕЖ'' IN category)>0 OR POSITION(''ЛЮБ'' IN category)>0) ');
          end;
      end;
     //ТИП БИЛЕТА
    if GroupBox8.Enabled and not (checkbox7.Checked AND checkbox8.checked AND checkbox9.checked) then
    begin
      ZQuery1.SQL.add('and (1=1 ');
       if not checkbox7.Checked then
            ZQuery1.SQL.add('AND NOT POSITION(''ОБЫЧНЫЙ'' IN UPPER(name))>0 ');
      if not checkbox8.Checked then
            ZQuery1.SQL.add('AND NOT POSITION(''ЛЬГОТНЫЙ'' IN UPPER(name))>0 ');
      if not checkbox9.Checked then
            ZQuery1.SQL.add('AND NOT POSITION(''ВОИНСКИЙ'' IN UPPER(name))>0 ');

      ZQuery1.SQL.add(') ');
    end;

     //ТИП ЧЕКА
    if GroupBox9.Enabled and not (checkbox10.Checked AND checkbox11.checked) then
    begin
      ZQuery1.SQL.add('AND ( ');
       if checkbox10.Checked  then
         ZQuery1.SQL.add('POSITION(''ПОЛНЫЙ'' IN UPPER(name))>0 ')
       else
         ZQuery1.SQL.add('NOT POSITION(''ПОЛНЫЙ'' IN UPPER(name))>0 ');

       if checkbox11.Checked  then
         ZQuery1.SQL.add('AND POSITION(''ДЕТСКИЙ'' IN UPPER(name))>0) ')
       else
         ZQuery1.SQL.add('AND NOT POSITION(''ДЕТСКИЙ'' IN UPPER(name))>0) ');

    end;

    //ПРОДАЖA / ВОЗВРАТ
    if not (checkbox3.Checked AND checkbox4.checked) then
    begin
       if checkbox3.Checked then
        begin
            ZQuery1.SQL.add('and type_sale=1 ');
          end;
        if checkbox4.Checked then
        begin
            ZQuery1.SQL.add('and type_sale=2 ');
          end;
    end;
    //  ТИП БИЛЕТА
    If GroupBox3.Enabled and (Combobox3.ItemIndex>0) then
          ZQuery1.SQL.add('and POSITION('+quotedstr(Combobox3.Text)+' IN name)>0 ');
   //  ТИП МАРШРУТА
    If GroupBox6.Enabled and (Combobox5.ItemIndex>0) then
         ZQuery1.SQL.add('and btrim(category)='+quotedstr(trim(Combobox5.Text)) );
    //  ТИП УСЛУГИ
    If GroupBox5.Enabled and (Combobox4.ItemIndex>0) then
         ZQuery1.SQL.add('and btrim(category)='+quotedstr(trim(Combobox4.Text)) );

//категория пользователя
    ZQuery1.SQL.add(' AND usr_category='+inttostr(Combobox1.ItemIndex));

  //расписание / перевозчик
    if flshedatp then
    begin
        //расписание
        if checkbox5.Checked then
            begin
              ZQuery1.SQL.add(' and id_shedule>0 ');
              if EditButton1.Text<>'' then
                  ZQuery1.SQL.add(' and id_shedule in ('+EditButton1.Text+') ');
            end
        else
            ZQuery1.SQL.add(' and id_shedule=0 ');
        //перевозчик
        if checkbox6.Checked then
            begin
              ZQuery1.SQL.add(' and id_kontr>0 ');
              if EditButton1.Text<>'' then
                  ZQuery1.SQL.add(' and id_kontr in ('+EditButton2.Text+') ');
            end
        else
          ZQuery1.SQL.add(' and id_kontr=0 ');
    end;

   if (stroka<>'') and (filter_type=2) then ZQuery1.SQL.add('and name ilike '+quotedstr(stroka+'%'));
   if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('and cast(id as text) like '+quotedstr(stroka+'%'));

   if flshedatp then
       ZQuery1.SQL.add(' ORDER BY id DESC;')
     else
        ZQuery1.SQL.add(' ORDER BY createdate DESC;');
   //showmessage(ZQuery1.SQL.Text);//$
   try
    ZQuery1.open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
   end;
   //сбросить строки грида
   StringGrid1.RowCount:=1;
   if ZQuery1.RecordCount<1 then
     begin
      ZQuery1.Close;
      Zconnection1.disconnect;
      exit;
     end;

   formTicket.Label1.Caption := 'ВСЕГО: '+inttostr(ZQuery1.RecordCount);
   // Заполняем stringgrid
   //ProgressBar1.Max:=ZQuery1.RecordCount;
   //ProgressBar1.Visible:=true;
   for n:=1 to ZQuery1.RecordCount do
    begin
      //ProgressBar1.Position:=ProgressBar1.Position+1;
      //ProgressBar1.Refresh;
      StringGrid1.RowCount:=StringGrid1.RowCount+1;
      StringGrid1.Cells[0,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('id').asString;
      StringGrid1.Cells[1,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('name').asString;
      StringGrid1.Cells[2,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('category').asString;
      If ZQuery1.FieldByName('type_sale').asInteger=1 then
         StringGrid1.Cells[3,StringGrid1.RowCount-1]:='Продажа';
      If ZQuery1.FieldByName('type_sale').asInteger=2 then
         StringGrid1.Cells[3,StringGrid1.RowCount-1]:='Возврат';
      If ZQuery1.FieldByName('id_shedule').asInteger>0 then
        StringGrid1.Cells[4,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('id_shedule').AsString;
      If ZQuery1.FieldByName('id_kontr').asInteger>0 then
        StringGrid1.Cells[5,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('id_kontr').AsString;

      StringGrid1.Cells[6,StringGrid1.RowCount-1]:=FormatDateTime('YYYY-MM-DD HH:NN',ZQuery1.FieldByName('createdate').AsDateTime);
      StringGrid1.Cells[7,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('id_user').AsString;

      ZQuery1.Next;
    end;
   //ProgressBar1.Position:=0;
   //ProgressBar1.Visible:=false;
   ZQuery1.Close;
   Zconnection1.disconnect;
 end;

end;

//***************************************************************  HOT KEYS **************************************************************
procedure TFormTicket.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    With FormTicket do
   begin
   //поле поиска
  If Edit1.Visible then
    begin
    // ESC поиск // Вверх по списку   // Вниз по списку
     If key=27 then
        begin
          datatyp := 0;
          updategrid(datatyp,'');
          StringGrid1.SetFocus;
          key:=0;
          exit;
      end;
  if (Key=38) OR (Key=40) then
     begin
       Edit1.Visible:=false;
       StringGrid1.SetFocus;
       key:=0;
       exit;
     end;
      // ENTER - остановить контекстный поиск
   if (Key=13) then
     begin
       StringGrid1.SetFocus;
       key:=0;
       exit;
     end;
    end;

   // F1
    //if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    if Key=112 then showmessagealt('F1 - Справка'+#13+'F3 - Добавить'+#13+'F4 - Изменить'+#13+'F5 - Обновить'+#13+'F8 - Удалить'+#13+'ENTER - Выбор'+#13+'ESC - Отмена\Выход');
    //F3 - Добавить
    if (Key=114) and (FormTicket.bitbtn1.enabled=true) then FormTicket.BitBtn1.Click;
    //F4 - Изменить
    if (Key=115) AND (FormTicket.bitbtn2.enabled=true) then FormTicket.BitBtn2.Click;

    //F5 - Обновить
    if (Key=116) and (FormTicket.bitbtn8.enabled=true) then FormTicket.BitBtn8.Click;

    //F8 - Удалить
    if (Key=119) and (FormTicket.bitbtn3.enabled=true) then FormTicket.BitBtn3.Click;
    // ESC
    if Key=27 then FormTicket.Close;
    // ENTER
    if (Key=13)  and  (FormTicket.StringGrid1.Focused) then
      begin
        FormTicket.BitBtn5.Click;
        FormTicket.close;
      end;

     if (Key=112) OR (Key=114) or (Key=115) or (Key=116) or (Key=119) or (Key=13) or (Key=27) then Key:=0;

    // Контекcтный поиск
   if (Key>0) and (Edit1.Visible=false) AND (stringgrid1.Focused) then
     begin
       If (get_type_char(key)>0) or (key=8) or (key=46) or (key=96) then //8-backspace 46-delete 96- numpad 0
       begin
         Edit1.text:='';
         Edit1.Visible:=true;
         Edit1.SetFocus;
       end;
     end;


   end;
end;

procedure TFormTicket.BitBtn4Click(Sender: TObject);
begin
  FormTicket.close;
end;

procedure TFormTicket.BitBtn3Click(Sender: TObject);
begin
  with FormTicket do
  begin
  //Удаляем запись
   if (trim(StringGrid1.Cells[1,StringGrid1.row])='') or (StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;
  if dialogs.MessageDlg('Вы действительно хотите удалить запись ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;

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
      //проставляем запись на удаление
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('UPDATE av_tick_shablon SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(StringGrid1.Cells[0,StringGrid1.row])+' and del=0;');
     ZQuery1.ExecSQL;
   //Завершение транзакции
   Zconnection1.Commit;
  // showmessagealt('Транзакция завершена УСПЕШНО !!!');
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
 end;
    Zconnection1.disconnect;
    UpdateGrid(datatyp,'');//обновить грида
  end;

end;

//*************************  ДОБАВИТЬ  **********************************
procedure TFormTicket.BitBtn1Click(Sender: TObject);
begin
  //Создаем новую запись
  Fl_Edit_TT:=1;
  flname := false; //флаг корректной работы формы с наименованием шаблона
   //id редактируемого шаблона
  shablon_id := trim(formTicket.StringGrid1.Cells[0,formTicket.StringGrid1.row]);
  FormAdd := TFormAdd.create(self);
  FormAdd.ShowModal;
  FreeAndNil(FormAdd);
  If flname then
    begin
  FormTT := TFormTT.create(self);
  FormTT.ShowModal;
  FreeAndNil(FormTT);
    end;
  FormTicket.UpdateGrid(datatyp,'');
  formTicket.StringGrid1.Row:=formTicket.StringGrid1.RowCount-1;
end;

//*************************  ИЗМЕНИТЬ  *****************
procedure TFormTicket.BitBtn2Click(Sender: TObject);
var
   n:integer;
begin
  Fl_Edit_TT:=2;
  flname := false; //флаг корректной работы формы с наименованием шаблона
   //id редактируемого шаблона
  n:=formTicket.StringGrid1.Row;
  shablon_id := trim(formTicket.StringGrid1.Cells[0,formTicket.StringGrid1.row]);
  FormTT := TFormTT.create(self);
  FormTT.ShowModal;
  FreeAndNil(FormTT);

  FormTicket.UpdateGrid(datatyp,'');
  formTicket.StringGrid1.Row:=n;
end;

//***************************** ВЫБРАТЬ  ********************************************
procedure TFormTicket.BitBtn5Click(Sender: TObject);
begin
  if  FormTicket.StringGrid1.rowcount=1 then
     begin
        result_name:='';
        FormTicket.close;
     end
  else
     begin
       result_name:=FormTicket.StringGrid1.Cells[0,FormTicket.StringGrid1.row];
       FormTicket.close;
     end;
end;

//Обновить данные на форме
procedure TFormTicket.BitBtn8Click(Sender: TObject);
begin
 UpdateGrid(datatyp,'');
end;

procedure TFormTicket.Button1Click(Sender: TObject);
begin
 //если открыт фильтр, то скрыть
  If formTicket.Panel1.Height>formTicket.Button1.Height then
     begin
         formTicket.Panel1.Height :=formTicket.Button1.Height;
         formTicket.Button1.Caption:='ОТОБРАЗИТЬ  ФИЛЬТР';
         formTicket.GroupBox2.Visible:=false;
         formTicket.GroupBox7.Visible:=false;
         formTicket.GroupBox8.Visible:=false;
         end
      else
      begin
         formTicket.Panel1.Height :=215;
         formTicket.Button1.Caption:='СКРЫТЬ  ФИЛЬТР';
         formTicket.GroupBox2.Visible:=true;
         formTicket.GroupBox7.Visible:=true;
         formTicket.GroupBox8.Visible:=true;
         end;
end;

procedure TFormTicket.CheckBox1Change(Sender: TObject);
begin
  If formTicket.CheckBox1.Checked then
      begin
         formTicket.GroupBox3.Enabled:=true;
         formTicket.GroupBox6.Enabled:=true;
         formTicket.GroupBox8.Enabled:=true;
      end
  else
      begin
         formTicket.GroupBox3.Enabled:=false;
         formTicket.GroupBox6.Enabled:=false;
         formTicket.GroupBox8.Enabled:=false;
      end;
end;

procedure TFormTicket.CheckBox2Change(Sender: TObject);
begin
   If formTicket.CheckBox2.Checked then
      begin
         formTicket.GroupBox5.Enabled:=true;
         //formTicket.GroupBox6.Enabled:=true;
      end
  else
      begin
         formTicket.GroupBox5.Enabled:=false;
         //formTicket.GroupBox6.Enabled:=false;
      end;
end;

procedure TFormTicket.CheckBox5Change(Sender: TObject);
begin
  flshedatp:=true;
  If CheckBox5.Checked then EditButton1.Enabled:=true else EditButton1.Enabled:=false;
end;

procedure TFormTicket.CheckBox6Change(Sender: TObject);
begin
  flshedatp:=true;
  If CheckBox6.Checked then EditButton2.Enabled:=true else EditButton2.Enabled:=false;
end;

procedure TFormTicket.ComboBox1Change(Sender: TObject);
begin

end;



procedure TFormTicket.Edit1Change(Sender: TObject);
var
   n:integer=0;
 begin
   with FormTicket do
 begin
   ss:=trimleft(Edit1.Text);
   if UTF8Length(ss)>0 then
        begin
        for n:=1 to UTF8Length(ss) do
        begin
       //определяем тип данных для поиска
     if not (ss[n] in ['0'..'9']) then
       begin
         datatyp:=2;
         break;
       end;
      datatyp:=1;
        end;

       updategrid(datatyp,ss);
        end
   else
      begin
       datatyp:=0;
       updategrid(datatyp,'');
       Edit1.Visible:=false;
       Stringgrid1.SetFocus;
      end;
 end;

end;

procedure TFormTicket.EditButton1ButtonClick(Sender: TObject);
var
   stmp:string;
begin
  //Расписание
  result_name_shedule:='';
  form15:=Tform15.create(self);
  form15.ShowModal;
  FreeAndNil(form15);
  if  trim(result_name_shedule)='' then exit;
  stmp:= trim(formTicket.EditButton1.Text);
  ///=========================================================================
  If stmp='' then
                  formTicket.EditButton1.Text:=trim(result_name_shedule)
                  else
                    If copy(stmp,length(stmp),1)=',' then
                         formTicket.EditButton1.Text:= formTicket.EditButton1.Text + trim(result_name_shedule)
                         else
                           formTicket.EditButton1.Text:=formTicket.EditButton1.Text + ','+ trim(result_name_shedule);
end;

procedure TFormTicket.EditButton1Exit(Sender: TObject);
begin
  if EditButton1.Text='' then exit;
       // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
      begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
      end;
     //запрос списка
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('SELECT id FROM av_shedule WHERE del=0 AND id in ('+EditButton1.Text+');');
     showmessage(ZQuery1.SQL.Text);
     try
      ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       //Close;
       exit;
     end;
     if ZQuery1.RecordCount=0 then
     begin
       showmessagealt('Не найдено расписаний по введенным условиям!');
       EditButton1.Text:= '';
     end;
     ZQuery1.Close;
     Zconnection1.disconnect;
end;

procedure TFormTicket.EditButton2ButtonClick(Sender: TObject);
var
   stmp:string;
begin
      //Добавляем контрагента
  result_kontr_id:='';
  formsk:=Tformsk.create(self);
  formsk.ShowModal;
  FreeAndNil(formsk);
  if  trim(result_kontr_id)='' then exit;
  stmp:= trim(formTicket.EditButton2.Text);
  ///=========================================================================
  If stmp='' then
                  formTicket.EditButton2.Text:=trim(result_kontr_id)
                  else
                    If copy(stmp,length(stmp),1)=',' then
                         formTicket.EditButton2.Text:= formTicket.EditButton2.Text + trim(result_kontr_id)
                         else
                           formTicket.EditButton2.Text:=formTicket.EditButton2.Text + ','+ trim(result_kontr_id);
end;

procedure TFormTicket.EditButton2Change(Sender: TObject);
begin

end;

procedure TFormTicket.EditButton2Exit(Sender: TObject);
begin
  if EditButton2.Text='' then exit;
       // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
      begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
      end;
     //запрос списка
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('SELECT id,name FROM av_spr_kontragent WHERE del=0 AND id in ('+EditButton2.Text+');');
     try
      ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       //Close;
       exit;
     end;
     if ZQuery1.RecordCount=0 then
     begin
       showmessagealt('Не найдено перевозчиков по введенным условиям!');
       EditButton2.Text:= '';
     end;
     ZQuery1.Close;
     Zconnection1.disconnect;
end;

procedure TFormTicket.FormActivate(Sender: TObject);
begin
  UpdateServices();
  flshedatp:= false;
end;

procedure TFormTicket.FormShow(Sender: TObject);
begin

 if flag_access=1 then
     begin
      with formTicket do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn3.Enabled:=false;
       end;
     end;
 UpdateGrid(datatyp,'');
 StringGrid1.SetFocus;
end;

procedure TFormTicket.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

end.

