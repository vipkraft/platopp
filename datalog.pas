unit datalog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Grids, EditBtn, platproc, StrUtils;

type

  { TFormDLog }

  TFormDLog = class(TForm)
    BitBtn25: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn9: TBitBtn;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn25Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UpdateCombo();
    procedure UpdateGrid();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormDLog: TFormDLog;

implementation
{ TFormDLog }

uses
    mainopp, users_main;
var
  nRow, nCol : integer;
  arColumns, arColDes : array of string;
  arTables : array of array of string;


procedure TFormDLog.UpdateCombo();
var
  n : integer;
begin
  With FormDlog do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
 //запрос   // список таблиц и описаний их названия
 ZQuery1.SQL.clear;
 ZQuery1.SQL.add('SELECT a.relname, c.description FROM pg_class AS a ');
 ZQuery1.SQL.add('JOIN pg_namespace as d ON d.oid=a.relnamespace AND d.nspname=current_schema() ');
 ZQuery1.SQL.add('LEFT JOIN pg_description AS c ON c.objoid = a.oid AND c.objsubid=0 ');
 ZQuery1.SQL.add('WHERE substring(a.relname, 1, 3) = ''av_'' ');
 ZQuery1.SQL.add('ORDER by a.relname ;');
// showmessage(FormDLog.ZQuery1.SQL.text);
 try
 ZQuery1.Open;
 except
   showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
 end;
 if ZQuery1.RecordCount<1 then
     begin
       ZQuery1.close;
       ZConnection1.Disconnect;
       exit;
     end;
 // Заполняем combo
  ComboBox1.Clear;
  SetLength(arTables,FormDLog.ZQuery1.RecordCount,2);
  for n:=0 to FormDLog.ZQuery1.RecordCount-1 do
   begin
     If trim(ZQuery1.FieldByName('relname').asString)='' then continue;
     If trim(ZQuery1.FieldByName('description').asString)='' then
        ComboBox1.Items.Add('  |  ' + ZQuery1.FieldByName('relname').asString)
        else
          ComboBox1.Items.Add(ZQuery1.FieldByName('description').asString + '  |  ' + ZQuery1.FieldByName('relname').asString);
     arTables[n,0] := trim(ZQuery1.FieldByName('relname').asString);
     arTables[n,1] := trim(ZQuery1.FieldByName('description').asString);
     ZQuery1.Next;
   end;
 end;
end;

//                Заполнение журнала выбранными данными
procedure TFormDLog.UpdateGrid();
var
  n,m,k : integer;
  TargetTable, sss : string;
begin
  With FormDlog do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
  //ищем в массиве выбранную таблицу
  TargetTable := '';
  TargetTable := trim(copy(ComboBox1.Text,pos('|',ComboBox1.Text)+1,length(ComboBox1.Text)));
  If trim(TargetTable)='' then
     begin
       showmessagealt('ОШИБКА ! В базе данных нет ничего по таблице: '+ TargetTable);
       exit;
     end;

  //список колонок выбранной таблицы и описаний их названия
  ZQuery1.SQL.clear;
  ZQuery1.SQL.add('SELECT  a.relname,b.attname, b.attnum , c.description FROM pg_class AS a ');
  ZQuery1.SQL.add('JOIN pg_attribute AS b ON b.attrelid = a.oid AND b.attnum>0 AND b.attisdropped=False ');
  ZQuery1.SQL.add('LEFT JOIN pg_description AS c ON c.objoid = a.oid AND c.objsubid=b.attnum ');
  //ZQuery1.SQL.add('WHERE substring(a.relname, 1, 3) = ''av_'' AND a.relname='+ QuotedSTR(TargetTable));
  ZQuery1.SQL.add('WHERE a.relname='+ QuotedSTR(TargetTable));
  ZQuery1.SQL.add('ORDER by a.relname,b.attnum; ');
  //showmessage(FormDLog.ZQuery1.SQL.text);
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;

  if FormDLog.ZQuery1.RecordCount<1 then
     begin
       FormDLog.ZQuery1.close;
       FormDLog.ZConnection1.Disconnect;
       exit;
     end;

  SetLength(arColumns,ZQuery1.RecordCount);
  SetLength(arColDes,ZQuery1.RecordCount);
  StringGrid1.RowCount:=FormDLog.ZQuery1.RecordCount;
//  StringGrid1.ColCount:=2;
//  StringGrid1.ColWidths[1] := 20;
  n := 0;
  m := ZQuery1.RecordCount - 1;
  If m < 5 then exit;
  for k:=0 to m do
   begin
     If trim(ZQuery1.FieldByName('attname').asString)='' then
        begin
          ZQuery1.Next;
          continue;
        end;
     // первая строка
     If trim(ZQuery1.FieldByName('attname').asString)='createdate' then
        begin
          arColumns[0] := trim(ZQuery1.FieldByName('attname').asString);
          arColDes[0] := 'Дата редакции';//trim(ZQuery1.FieldByName('description').asString);
          StringGrid1.Cells[0,0] := arColDes[0];
          ZQuery1.Next;
          continue;
        end;
     // четвертая снизу строка
     If trim(ZQuery1.FieldByName('attname').asString)='id_user' then
        begin
          arColumns[m-3] := trim(ZQuery1.FieldByName('attname').asString);
          arColDes[m-3] := 'Кто редактировал';
          StringGrid1.Cells[0,m-3] := arColDes[m-3];
          ZQuery1.Next;
          continue;
        end;
     // третья снизу строка
     If trim(ZQuery1.FieldByName('attname').asString)='createdate_first' then
        begin
          arColumns[m-2] := trim(ZQuery1.FieldByName('attname').asString);
          arColDes[m-2] := 'Дата создания';
          StringGrid1.Cells[0,m-2] := arColDes[m-2];
          ZQuery1.Next;
          continue;
        end;
     // вторая снизу строка
     If trim(ZQuery1.FieldByName('attname').asString)='id_user_first' then
        begin
          arColumns[m-1] := trim(ZQuery1.FieldByName('attname').asString);
          arColDes[m-1] := 'Кто создал';
          StringGrid1.Cells[0,m-1] := arColDes[m-1];
          ZQuery1.Next;
          continue;
        end;
     // последняя строка
     If trim(ZQuery1.FieldByName('attname').asString)='del' then
        begin
          arColumns[m] := trim(ZQuery1.FieldByName('attname').asString);
          arColDes[m] := 'Пометка об удалении';
          StringGrid1.Cells[0,m] := arColDes[m];
          ZQuery1.Next;
          continue;
        end;
     //если все варианты прошли, значит начнем со второй строки
     n := n+1;
     If n>m then continue;
   //   If trim(ZQuery1.FieldByName('description').asString)='' then
        StringGrid1.Cells[0,n] := ZQuery1.FieldByName('attname').asString;
       // else
       //   StringGrid1.Cells[0,n] := ZQuery1.FieldByName('description').asString;
       arColumns[n] := trim(ZQuery1.FieldByName('attname').asString);
       arColDes[n] := trim(ZQuery1.FieldByName('description').asString);
     ZQuery1.Next;
  end;
  StringGrid1.ShowHint:= true;
  ////////////////////////////////////////////////////////////////////////////////////////
  // запрос на данные из таблицы за период
  ZQuery1.SQL.clear;
  ZQuery1.SQL.add('SELECT * FROM '+ TargetTable + ' WHERE createdate>Date('+ QuotedStr(DateEdit1.Text));
  ZQuery1.SQL.add(') AND createdate<Date(' + QuotedStr(DateToStr(DateEdit2.Date+1)) + ') ');
  sss:= '';
  //фильтр по удаленным
  If Checkgroup1.Checked[0]=true then sss := sss+ ' AND del=0'; //включая реальные
  If Checkgroup1.Checked[1]=true then   //включая отредактированные
    If sss = '' then sss:= sss+ ' AND del=1' else sss:= sss+ ' OR del=1';
  If Checkgroup1.Checked[2]=true then   //включая удаленные
    If sss = '' then sss:= sss+ ' AND del=2' else sss:= sss+ ' OR del=2';
  //фильтр по пользователям
  If Stringgrid2.RowCount>1 then
  begin
    sss:= sss + ' AND ';
    for n:=1 to Stringgrid2.RowCount-1 do
     begin
       If n=1 then sss:= sss + ' id_user='+Stringgrid2.Cells[0,n]
              else sss:= sss + ' OR id_user='+Stringgrid2.Cells[0,n];
     end;
  end;
  ZQuery1.SQL.add(sss);
  ZQuery1.SQL.add(' ORDER BY createdate;');
//  showmessage(FormDLog.ZQuery1.SQL.text);
 try
 ZQuery1.Open;
 except
   showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
 end;
  if FormDLog.ZQuery1.RecordCount<1 then
     begin
       showmessagealt('Нет данных по заданным критериям !');
       FormDLog.ZQuery1.close;
       FormDLog.ZConnection1.Disconnect;
       exit;
     end;
  Label1.Caption:= 'Всего записей по выбранным критериям: '+inttostr(FormDLog.ZQuery1.RecordCount);
  StringGrid1.ColCount:=FormDLog.ZQuery1.RecordCount+1;
//  StringGrid1.ColWidths[1] := 20;
 //заполняем грид данными
  m := StringGrid1.RowCount-1;
  for n:=1 to ZQuery1.RecordCount do
   begin
      StringGrid1.Cells[n,0] := trim(ZQuery1.FieldByName('createdate').asString);
      StringGrid1.Cells[n,m-3] := trim(ZQuery1.FieldByName('id_user').asString);
      StringGrid1.Cells[n,m-2] := trim(ZQuery1.FieldByName('createdate_first').asString);
      StringGrid1.Cells[n,m-1] := trim(ZQuery1.FieldByName('id_user_first').asString);
      If ZQuery1.FieldByName('del').asInteger=0 then
         StringGrid1.Cells[n,m] := '-';
      If ZQuery1.FieldByName('del').asInteger=1 then
         StringGrid1.Cells[n,m] := 'отредактировано';
      If ZQuery1.FieldByName('del').asInteger=2 then
         StringGrid1.Cells[n,m] := 'удалено';
      For k := 1 to m-4 do
       begin
         StringGrid1.Cells[n,k] := trim(ZQuery1.FieldByName(arColumns[k]).asString);
       end;
      ZQuery1.Next;
   end;

  //заполнить имена вместо id
  for n:=1 to StringGrid1.ColCount-2 do
   begin
     If trim(StringGrid1.Cells[n,m-3])='' then continue;
   //кто редактировал
      ZQuery1.SQL.clear;
      ZQuery1.SQL.add('SELECT name FROM av_users WHERE del=0 AND id='+StringGrid1.Cells[n,m-3]);
      try
      ZQuery1.Open;
      except
         showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+inttostr(n)+'|'+inttostr(m)+'|'+ZQuery1.SQL.Text);
      end;
      If Zquery1.RecordCount=1 then
      StringGrid1.Cells[n,m-3] := trim(ZQuery1.FieldByName('name').asString);
    //кто создал
    If trim(StringGrid1.Cells[n,m-1])='' then continue;
      ZQuery1.SQL.clear;
      ZQuery1.SQL.add('SELECT name FROM av_users WHERE del=0 AND id='+StringGrid1.Cells[n,m-1]);
      try
      ZQuery1.Open;
      except
         showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+inttostr(n)+'|'+ZQuery1.SQL.Text);
      end;
      If Zquery1.RecordCount=1 then
       StringGrid1.Cells[n,m-1] := trim(ZQuery1.FieldByName('name').asString);
   end;

   /////////////////////////////////////////////////////////////////////


  ZQuery1.Close;
  Zconnection1.disconnect;

  StringGrid1.AutoSizeColumns;
  StringGrid1.Refresh;
  StringGrid1.SetFocus;

  SetLength(arColumns,0);
  SetLength(arTables,0,0);
  end;
end;


// возникновение формы
procedure TFormDLog.FormShow(Sender: TObject);
begin
  Centrform(FormDLog);
  FormDLog.UpdateCombo();
 {
   SELECT  t.table_name, c.column_name
   FROM information_schema.TABLES AS t
   JOIN information_schema.COLUMNS AS c ON t.table_name::text = c.table_name::text
  WHERE t.table_schema::text = 'public'::text AND
        t.table_catalog::name = current_database() AND
        NOT "substring"(t.table_name::text, 1, 1) = '_'::text
  ORDER BY t.table_name, c.ordinal_position;

    SELECT d.nspname AS schema_name,
         pg_catalog.obj_description(d.oid) AS schema_comment,
         c.relname AS table_name,
         pg_catalog.obj_description(c.oid) AS table_comment,
         a.attnum AS ordinal_position,
         a.attname AS column_name,
         t.typname AS data_type,
         a.attlen AS character_maximum_length,
         pg_catalog.col_description(c.oid, a.attnum) AS field_comment,
         a.atttypmod AS modifier,
         a.attnotnull AS notnull,
         a.atthasdef AS hasdefault
    FROM pg_class c
LEFT JOIN pg_attribute a ON a.attrelid = c.oid
LEFT JOIN pg_type t ON a.atttypid = t.oid
LEFT JOIN pg_namespace d ON d.oid = c.relnamespace
   WHERE c.relname = 'test_comments'
     AND a.attnum > 0
ORDER BY a.attnum;

  // список таблиц и описаний их названия
  SELECT a.relname, c.description
FROM pg_class AS a
JOIN pg_namespace as d ON d.oid=a.relnamespace AND d.nspname=current_schema()
LEFT JOIN pg_description AS c ON c.objoid = a.oid AND c.objsubid=0
WHERE substring(a.relname, 1, 3) = 'av_'
ORDER by a.relname


//список колонок и описаний их названия
SELECT  a.relname,b.attname, b.attnum , c.description
FROM pg_class AS a
JOIN pg_attribute AS b ON b.attrelid = a.oid AND b.attnum>0 AND b.attisdropped=False
LEFT JOIN pg_description AS c ON c.objoid = a.oid AND c.objsubid=b.attnum
WHERE substring(a.relname, 1, 3) = 'av_'
ORDER by a.relname,b.attnum;
 }
end;

procedure TFormDLog.StringGrid1MouseMove(Sender: TObject; Shift: TShiftState;  X, Y: Integer);
var
  r: integer;
  c: integer;
begin
  FormDlog.StringGrid1.MouseToCell(X, Y, C, R);
  with FormDlog.StringGrid1 do
  begin
  If RowCount< 2 then exit;
  iF length(arColdes)<4 then exit;
  if (nRow <> r) then//or (Col <> c) then
    begin
      nRow := r;
      nCol := c;
      Application.CancelHint;
      StringGrid1.Hint := arColDes[r];//IntToStr(r)+#32+IntToStr(c);
    end;
  end;
end;

//////////     ОБНОВИТЬ *****************************************
procedure TFormDLog.BitBtn5Click(Sender: TObject);
begin
  //проверки
  If trim(FormDLog.ComboBox1.Text)='' then
     begin
       showmessagealt('Не выбрана таблица для просмотра !');
       exit;
     end;
  If FormDLog.DateEdit1.Date>FormDLog.DateEdit2.Date then
     begin
       showmessagealt('Дата "С" больше даты "ПО" !');
       exit;
     end;
  UpdateGrid();
end;

//********************************** ДОБАВИТЬ ПОЛЬЗОВАТЕЛЯ в фильтр *******************************************************
procedure TFormDLog.BitBtn9Click(Sender: TObject);
var
  n : integer;
begin
 //ОТКРЫВАЕМ справочник юзеров
  users_mode :=0;
  form_Users:=Tform_users.create(self);
  form_Users.ShowModal;
  FreeAndNil(form_users);
 //обрабатываем выбор
  if (result_user = '') then exit;
 //проверка на совпадающие
  with FormDlog.Stringgrid2 do
  begin
  for n:=1 to RowCount-1 do
    begin
      If Cells[0,n]=result_user then
      begin
       showmessagealt('Добавляемый пользователь уже есть в списке !');
       exit;
      end;
    end;
   // Columns[0].ValueChecked:='1';
  //  Columns[0].ValueUnchecked:='0';
    n := RowCount;
    RowCount:= RowCount + 1;
    Cells[0,n] := result_user;
    Cells[1,n] := result_usname;
  end;
end;

//*************************************  УДАЛИТЬ  ПОЛЬЗОВАТЕЛЯ *******************************************************
procedure TFormDLog.BitBtn25Click(Sender: TObject);
begin
  DelStringgrid(FormDlog.StringGrid2, FormDlog.StringGrid2.Row);
end;

procedure TFormDLog.ComboBox1Change(Sender: TObject);
begin
  If trim(FormDLog.ComboBox1.Text)<>'' then
   UpdateGrid();
end;

procedure TFormDLog.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //очистка памяти от массива
  SetLength(arTables,0,0);
  arTables := nil;
end;

///////////  ВЫХОД *******************************************
procedure TFormDLog.BitBtn4Click(Sender: TObject);
begin
  FormDlog.Close;
end;




{$R *.lfm}

end.

