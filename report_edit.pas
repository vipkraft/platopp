unit report_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Spin, Menus, ComCtrls, MaskEdit,
  platproc, htmldoc;

type

  { TFormRepEdit }

  TFormRepEdit = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn23: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Memo1: TMemo;
    Memo3: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    RadioGroup4: TRadioGroup;
    Shape10: TShape;
    Shape9: TShape;
    SpinEdit1: TSpinEdit;
    StaticText1: TStaticText;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    StringGrid6: TStringGrid;
    StringGrid7: TStringGrid;
    StringGrid8: TStringGrid;
    StringGrid9: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn23Click(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckGroup1ItemClick(Sender: TObject; Index: integer);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure RadioGroup4Click(Sender: TObject);
    procedure StringGrid1EditButtonClick(Sender: TObject);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;  var Value: string);
    procedure StringGrid1SelectEditor(Sender: TObject; aCol, aRow: Integer;      var Editor: TWinControl);
    procedure StringGrid2SelectCell(Sender: TObject; aCol, aRow: Integer;     var CanSelect: Boolean);
    procedure StringGrid2SelectEditor(Sender: TObject; aCol, aRow: Integer;    var Editor: TWinControl);
    procedure StringGrid8EditButtonClick(Sender: TObject);
    procedure StringGrid8EditingDone(Sender: TObject);
    procedure StringGrid8GetEditMask(Sender: TObject; ACol, ARow: Integer;      var Value: string);
    procedure StringGrid3EditButtonClick(Sender: TObject);
    procedure StringGrid3EditingDone(Sender: TObject);
    procedure StringGrid3GetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure StringGrid5DblClick(Sender: TObject);
    procedure StringGrid5MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure StringGrid6MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure UpdateShablon(); //обновление текстовых данных на вкладке
    procedure UpdateCombo();  //обновить инфу о таблицах базы на комбо и гриде 5
    procedure UpdateGrid5();///Заполнение ГРИДА 5 ИНФОЙ О СТОЛБЦАХ ВЫБРАННОЙ В КОМБО ТАБЛИЦЕ
    procedure UpdateVars(); //заполенние Гридов 6 и 7 из таблицы переменных отчетов
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormRepEdit: TFormRepEdit;
  id_locality,id_group,razbor:string;


implementation
  uses
    mainopp,report_main;

  var
  nGrid, fl_change, fl2 : byte;
  newid, nRow, nCol, nR2,nCol2: integer;
  arColDes : array of string;
  fltype,id_rep : string;
  { TFormRepEdit }




//заполенние Гридов 6 и 7 из таблицы переменных отчетов
procedure TFormRepEdit.UpdateVars();
var
    n : integer;
begin
 With FormRepEdit do
    begin
  // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
       begin
        showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
        exit;
       end;

    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT * FROM av_reports_vars WHERE del=0 ORDER BY rdepend, rvar desc;');
    try
     ZQuery1.open;
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
    Stringgrid6.RowCount:=0;
    Stringgrid7.RowCount:=1;
    StringGrid6.RowCount := ZQuery1.RecordCount;
    StringGrid7.RowCount := ZQuery1.RecordCount+1;
    for n:=0 to ZQuery1.RecordCount-1 do
     begin
       StringGrid6.Cells[1,n] := ZQuery1.FieldByName('rvar').asString;
       StringGrid6.Cells[0,n] := ZQuery1.FieldByName('rdescription').asString;
       StringGrid7.Cells[0,n+1] := ZQuery1.FieldByName('id').asString;
       StringGrid7.Cells[1,n+1] := ZQuery1.FieldByName('rvar').asString;
       StringGrid7.Cells[2,n+1] := ZQuery1.FieldByName('rdescription').asString;
       StringGrid7.Cells[3,n+1] := ZQuery1.FieldByName('rdepend').asString;
       StringGrid7.Cells[4,n+1] := ZQuery1.FieldByName('rtype').asString;
       ZQuery1.Next;
    end;
    StringGrid6.ShowHint:= true;
    StringGrid6.AutoSizeColumns;
    //Stringgrid6.Refresh;
    //Stringgrid7.Refresh;
    ZQuery1.Close;
    Zconnection1.disconnect;


    end;
end;

///****************        Заполнение ГРИДА 5 ИНФОЙ О СТОЛБЦАХ ВЫБРАННОЙ В КОМБО ТАБЛИЦЕ ***************
procedure TFormRepEdit.UpdateGrid5();
var
    n,m,k : integer;
    TargetTable, sss : string;
    //массив символных типов данных postgre
    arcoltype : array[0..4] of string =('bpchar','varchar','text','timestamp','date');
begin
    //coltype :=
    With FormRepEdit do
    begin
    // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
       begin
        showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
        exit;
       end;
    //ищем в массиве выбранную таблицу
    TargetTable := '';
    TargetTable := trim(copy(ComboBox2.Text,pos('|',ComboBox2.Text)+1,length(ComboBox2.Text)));
    If trim(TargetTable)='' then
       begin
         showmessagealt('ОШИБКА ! В базе данных нет ничего по таблице: '+ TargetTable);
         exit;
       end;
    //список колонок выбранной таблицы и описаний их названия
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT  a.relname,b.attname,b.attnum,c.description,e.typname FROM pg_class AS a ');
    ZQuery1.SQL.add('JOIN pg_attribute AS b ON b.attrelid = a.oid AND b.attnum>0 AND b.attisdropped=False ');
    ZQuery1.SQL.add('LEFT JOIN pg_description AS c ON c.objoid = a.oid AND c.objsubid=b.attnum ');
    ZQuery1.SQL.add('LEFT JOIN pg_type AS e ON b.atttypid = e.oid ');
    ZQuery1.SQL.add('WHERE a.relname='+ QuotedSTR(TargetTable));
    ZQuery1.SQL.add('ORDER by a.relname,b.attnum; ');
    //showmessage(FormRepEdit.ZQuery1.SQL.text);
    try
     ZQuery1.open;
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
    Stringgrid5.RowCount:=0;
    SetLength(arColDes,ZQuery1.RecordCount);
    StringGrid5.RowCount := ZQuery1.RecordCount;
    n := 0;
    //если в таблице меньше 5 столбцов - не катит
    If ZQuery1.RecordCount < 5 then exit;
    for k:=1 to ZQuery1.RecordCount do
     begin
       //не влючать в грид столбцы, отвечающие следующим условиям
       sss:= trim(ZQuery1.FieldByName('attname').asString);
       If (sss='') OR (sss='createdate') OR (sss='createdate_first') OR (sss='id_user') OR (sss='id_user_first') OR (sss='del') then
          begin
            ZQuery1.Next;
            continue;
          end;
       StringGrid5.Cells[0,n] := ZQuery1.FieldByName('attname').asString;
       StringGrid5.Cells[1,n] := trim(ZQuery1.FieldByName('description').asString);
       arColDes[n] := trim(ZQuery1.FieldByName('description').asString);
       StringGrid5.Cells[2,n] := '0';
      for m:=low(arcoltype) to high(arcoltype) do
        begin
          If arcoltype[m]=ZQuery1.FieldByName('typname').asString then
             begin
             StringGrid5.Cells[2,n] := '1';
             break;
             end;
          end;
       n := n+1;
       ZQuery1.Next;
    end;
    StringGrid5.ShowHint:= true;
    StringGrid5.AutoSizeColumns;
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
end;


//***********************  обновить инфу о таблицах базы на комбо **********************
procedure TFormRepEdit.UpdateCombo();
var
  n : integer;
begin
  With FormRepEdit do
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
 ZQuery1.SQL.add('WHERE substring(a.relname, 1, 4) =''av_s'' OR a.relname=''av_route''');
 ZQuery1.SQL.add('ORDER by a.relname ;');
 //showmessage(FormRepEdit.ZQuery1.SQL.text);
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
  ComboBox2.Clear;
  for n:=0 to ZQuery1.RecordCount-1 do
   begin
     If trim(ZQuery1.FieldByName('relname').asString)='' then continue;
     If trim(ZQuery1.FieldByName('description').asString)='' then
        ComboBox2.Items.Add('  |  ' + ZQuery1.FieldByName('relname').asString)
        else
          ComboBox2.Items.Add(ZQuery1.FieldByName('description').asString + '  |  ' + ZQuery1.FieldByName('relname').asString);
     //arTables[n,0] := trim(ZQuery1.FieldByName('relname').asString);
     //arTables[n,1] := trim(ZQuery1.FieldByName('description').asString);
     ZQuery1.Next;
   end;
   ComboBox2.ItemIndex:=0;
   UpdateGrid5();
 end;
end;

  //*****************    обновление текстовых данных на вкладке  *********************************
procedure TFormRepEdit.UpdateShablon();
 var
   tmp_id_user,n,m,k:integer;
   Shead,Sdown, sTt : string;
begin
   with FormRepEdit do
  begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;


  // Режим редактирования
  if (fl_edit=2) or (fl_edit=3) then
   begin
   ZQuery1.SQL.clear;
   ZQuery1.SQL.add('SELECT * FROM av_reports where del=0 AND id='+id_rep+';');
   //showmessage(ZQuery1.SQL.text);//$
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    Close;
    exit;
  end;
   If ZQuery1.RecordCount=0 then
     begin
          showmessagealt('Запись данного отчета ошибочна в базе!');
          ZQuery1.Close;
          Zconnection1.disconnect;
          Close;
          exit;
     end;
   Stringgrid1.RowCount:=1;
   Stringgrid2.ColCount:=1;
   Stringgrid2.ColWidths[0]:=75;
   Stringgrid3.RowCount:=1;
   Stringgrid4.RowCount:=1;
   Sdown:='';
   Shead:='';
   sTt :='';

   Edit1.Text:= ZQuery1.FieldByName('naim').asString;
   SpinEdit1.value:= ZQuery1.FieldByName('id_order').asInteger;
   ComboBox1.ItemIndex := ZQuery1.FieldByName('grup').asInteger;
   Edit2.Text:= Padl(ZQuery1.FieldByName('fl_choice').asString,'0',15);
   If ZQuery1.FieldByName('fl_type').asInteger=1 then
       CheckBox1.Checked:= true
       else
         CheckBox1.Checked:= false;
   Shead := trim(ZQuery1.FieldByName('headtext').AsString);
   SDown := ZQuery1.FieldByName('downtext').AsString;
   sTt := ZQuery1.FieldByName('rep_columns').AsString;
   Memo1.Text := ZQuery1.FieldByName('zapros').asstring;
   //showmessage(sDown);
   //раскладываем заголовок
   While Length(sHead)>1 do
   begin
     n:=Pos('@', Shead);
     If n<3 then break;
     k:=Pos('|', Shead);
     If k<5 then break;
     //showmessagealt(inttostr(n)+' | '+inttostr(k)+' | '+inttostr(length(sHead))+' | '+shead);
     Stringgrid1.RowCount:=Stringgrid1.RowCount+1;

     Stringgrid1.Cells[0,Stringgrid1.RowCount-1]:=Copy(Shead,n-3,1);
     Stringgrid1.Cells[1,Stringgrid1.RowCount-1]:=Copy(Shead,n-2,1);
     Stringgrid1.Cells[2,Stringgrid1.RowCount-1]:=Copy(Shead,n-1,1);
     Stringgrid1.Cells[3,Stringgrid1.RowCount-1]:=Copy(Shead,n+1,k-1-n);
     SHead:= Copy(Shead,k+1,length(Shead));
   end;
  //если что-то не то, то выводим в грид
   If Length(sHead)>1 then
     begin
        Stringgrid1.RowCount:=Stringgrid1.RowCount+1;
        Stringgrid1.Cells[3,Stringgrid1.RowCount-1]:=Shead;
     end;
  //раскладываем подвал
   While Length(Sdown)>1 do
   begin
     n:=Pos('@', SDown);
     If n<3 then break;
     k:=Pos('|', SDown);
     If k<5 then break;
     //showmessagealt(inttostr(n)+' | '+inttostr(length(sDown))+' | '+sDown);
     Stringgrid3.RowCount:=Stringgrid3.RowCount+1;
     Stringgrid3.Cells[0,Stringgrid3.RowCount-1]:=Copy(Sdown,n-3,1);
     Stringgrid3.Cells[1,Stringgrid3.RowCount-1]:=Copy(Sdown,n-2,1);
     Stringgrid3.Cells[2,Stringgrid3.RowCount-1]:=Copy(Sdown,n-1,1);
     Stringgrid3.Cells[3,Stringgrid3.RowCount-1]:=Copy(Sdown,n+1,k-1-n);
     Sdown:= Copy(Sdown,k+1,length(Sdown));
   end;
  //если что-то не то, то выводим в грид
   If Length(sDown)>1 then
     begin
        Stringgrid3.RowCount:=Stringgrid3.RowCount+1;
        Stringgrid3.Cells[3,Stringgrid3.RowCount-1]:=SDown;
     end;
   //раскладываем колонки
   While Length(sTT)>1 do
   begin
     k:=Pos('$', sTt);
     If k=0 then break;
     n:=Pos('@', sTt);
     If n=0 then break;
     m:=Pos('|', sTt);
     If m=0 then break;
     //на первой вкладке
     Stringgrid2.ColCount:=Stringgrid2.ColCount+1;
     Stringgrid2.Cells[Stringgrid2.ColCount-1,0]:=inttostr(Stringgrid2.ColCount-1);
     Stringgrid2.Cells[Stringgrid2.ColCount-1,1]:=Copy(sTt,k+1,n-1-k);
     Stringgrid2.Cells[Stringgrid2.ColCount-1,2]:=Copy(sTt,n+1,m-1-n);
     If k=5 then
       begin
          Stringgrid2.Cells[Stringgrid2.ColCount-1,3]:=Copy(sTt,1,1);
          Stringgrid2.Cells[Stringgrid2.ColCount-1,4]:=Copy(sTt,2,1);
          Stringgrid2.Cells[Stringgrid2.ColCount-1,5]:=Copy(sTt,3,1);
          Stringgrid2.Cells[Stringgrid2.ColCount-1,6]:=Copy(sTt,4,1);
       end
     else
        begin
         Stringgrid2.Cells[Stringgrid2.ColCount-1,3]:='0';
          Stringgrid2.Cells[Stringgrid2.ColCount-1,4]:='1';
          Stringgrid2.Cells[Stringgrid2.ColCount-1,5]:='2';
          Stringgrid2.Cells[Stringgrid2.ColCount-1,6]:='1';
        end;
     //на второй вкладке
     Stringgrid4.RowCount:=Stringgrid4.RowCount+1;
     Stringgrid4.Cells[0,Stringgrid4.RowCount-1]:=inttostr(Stringgrid4.RowCount-1);
     Stringgrid4.Cells[1,Stringgrid4.RowCount-1]:=Copy(sTt,k+1,n-1-k);
     Stringgrid4.Cells[2,Stringgrid4.RowCount-1]:=Copy(sTt,n+1,m-1-n);
     If k=5 then
       begin
         Stringgrid4.Cells[3,Stringgrid4.RowCount-1]:=Copy(sTt,1,1);
         Stringgrid4.Cells[4,Stringgrid4.RowCount-1]:=Copy(sTt,2,1);
         Stringgrid4.Cells[5,Stringgrid4.RowCount-1]:=Copy(sTt,3,1);
         Stringgrid4.Cells[6,Stringgrid4.RowCount-1]:=Copy(sTt,4,1);
       end
     else
       begin
         Stringgrid4.Cells[3,Stringgrid4.RowCount-1]:='0';
         Stringgrid4.Cells[4,Stringgrid4.RowCount-1]:='1';
         Stringgrid4.Cells[5,Stringgrid4.RowCount-1]:='2';
         Stringgrid4.Cells[6,Stringgrid4.RowCount-1]:='1';
       end;

     sTt:= Copy(sTt,m+1,length(sTt));
   end;
   end;

  If  (fl_edit=3) then
    begin
    fl_edit:=1;
    fl_change := 1;
    end;

 //порядковый номер отсчета
   ZQuery1.SQL.clear;
   ZQuery1.SQL.add('SELECT max(id_order) FROM av_reports where del=0;');
   try
   ZQuery1.open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    Close;
    exit;
   end;
   If ZQuery1.RecordCount=1 then
     begin
        // Режим добавления
     if (fl_edit=1) then
       begin
         SpinEdit1.Value := ZQuery1.FieldByName('max').AsInteger+1;
       end;
    SpinEdit1.MaxValue := ZQuery1.FieldByName('max').AsInteger+1;
    end;
  //Stringgrid2.AutoSizeColumn(2);


  ZQuery1.Close;
  Zconnection1.disconnect;
   end;
end;

procedure TFormRepEdit.FormShow(Sender: TObject);
var
  n: integer;
begin
 Centrform(FormRepEdit);
 With FormRepEdit do
 begin
 if flag_access=1 then BitBtn3.Enabled:=false;
 PageControl1.ActivePageIndex:= 0;
 StringGrid2.RowHeights[0] := 23;
 //скрыть все строки таблицы колонок
 for n:=1 to Stringgrid2.RowCount-1 do
  begin
    If n=2 then continue;
    StringGrid2.RowHeights[n] := 0;
  end;
 //скрыть все столбцы таблицы колонок
 for n:=3 to Stringgrid4.ColCount-1 do
  begin
    StringGrid4.ColWidths[n] := 1;
  end;
 //тип отчета
 If CheckBox1.Checked then fltype:='1' else fltype:='0';
 //заполняем комбо 1 групп отчетов
 ComboBox1.Clear;
 ComboBox1.Items.Add('Маршрутная сеть');
 ComboBox1.Items.Add('Тарифы');
 ComboBox1.Items.Add('Аналитика');
 ComboBox1.Items.Add('Разное');
 //флаг внесения изменений
  fl_change := 0;
  fl2 := 0;
  //Если режим редактирования, запоминаем id отчета
  If (fl_edit=2) OR (fl_edit=3)  then
     id_rep :=  trim(FormReport.StringGrid1.Cells[3,FormReport.StringGrid1.row])
    else
      id_rep := '0';

 UpdateShablon();
 UpdateCombo();
 UpdateVars();
 end;
end;





 // ===================== Меню полей для  =============================================================
procedure TFormRepEdit.MenuItem1Click(Sender: TObject);
begin
  If nGrid=1 then
  FormRepEdit.StringGrid1.Cells[0,FormRepEdit.StringGrid1.Row]:='1';
  If nGrid=2 then
  begin
  FormRepEdit.StringGrid8.Cells[0,FormRepEdit.StringGrid8.Row]:='1';
  Stringgrid8.SetFocus;
  Stringgrid8.Col:=0;
  Stringgrid8.Row:=1;
  end;
  If nGrid=3 then
  FormRepEdit.StringGrid3.Cells[0,FormRepEdit.StringGrid3.Row]:='1';
end;

procedure TFormRepEdit.MenuItem2Click(Sender: TObject);
begin
  If nGrid=1 then
  FormRepEdit.StringGrid1.Cells[0,FormRepEdit.StringGrid1.Row]:='2';
  If nGrid=2 then
  begin
  FormRepEdit.StringGrid8.Cells[0,FormRepEdit.StringGrid8.Row]:='2';
  Stringgrid8.SetFocus;
  Stringgrid8.Col:=1;
  Stringgrid8.Row:=1;
  end;
  If nGrid=3 then
  FormRepEdit.StringGrid3.Cells[0,FormRepEdit.StringGrid3.Row]:='2';
end;

procedure TFormRepEdit.MenuItem3Click(Sender: TObject);
begin
If nGrid=1 then
  FormRepEdit.StringGrid1.Cells[0,FormRepEdit.StringGrid1.Row]:='3';
If nGrid=2 then
  begin
  FormRepEdit.StringGrid8.Cells[0,FormRepEdit.StringGrid8.Row]:='3';
  Stringgrid8.SetFocus;
  Stringgrid8.Col:=1;
  Stringgrid8.Row:=1;
  end;
If nGrid=3 then
  FormRepEdit.StringGrid3.Cells[0,FormRepEdit.StringGrid3.Row]:='3';
end;

procedure TFormRepEdit.MenuItem4Click(Sender: TObject);
begin
If nGrid=1 then
  FormRepEdit.StringGrid1.Cells[2,FormRepEdit.StringGrid1.Row]:='1';
If nGrid=2 then
  begin
  FormRepEdit.StringGrid8.Cells[2,FormRepEdit.StringGrid8.Row]:='1';
  Stringgrid8.SetFocus;
  Stringgrid8.Col:=0;
  Stringgrid8.Row:=1;
  end;
If nGrid=3 then
  FormRepEdit.StringGrid3.Cells[2,FormRepEdit.StringGrid3.Row]:='1';
end;

procedure TFormRepEdit.MenuItem5Click(Sender: TObject);
begin
   If nGrid=1 then
  FormRepEdit.StringGrid1.Cells[2,FormRepEdit.StringGrid1.Row]:='2';
   If nGrid=2 then
     begin
     FormRepEdit.StringGrid8.Cells[2,FormRepEdit.StringGrid8.Row]:='2';
     Stringgrid8.SetFocus;
     Stringgrid8.Col:=0;
     Stringgrid8.Row:=1;
     end;
   If nGrid=3 then
  FormRepEdit.StringGrid3.Cells[2,FormRepEdit.StringGrid3.Row]:='2';
end;

procedure TFormRepEdit.MenuItem6Click(Sender: TObject);
begin
  If nGrid=1 then
    FormRepEdit.StringGrid1.Cells[2,FormRepEdit.StringGrid1.Row]:='3';
  If nGrid=2 then
    begin
    FormRepEdit.StringGrid8.Cells[2,FormRepEdit.StringGrid8.Row]:='3';
    Stringgrid8.SetFocus;
     Stringgrid8.Col:=0;
     Stringgrid8.Row:=1;
    end;
  If nGrid=3 then
    FormRepEdit.StringGrid3.Cells[2,FormRepEdit.StringGrid3.Row]:='3';
end;

procedure TFormRepEdit.MenuItem7Click(Sender: TObject);
begin
  If nGrid=1 then
   FormRepEdit.StringGrid1.Cells[2,FormRepEdit.StringGrid1.Row]:='4';
  If nGrid=2 then
   begin
   FormRepEdit.StringGrid8.Cells[2,FormRepEdit.StringGrid8.Row]:='4';
   Stringgrid8.SetFocus;
     Stringgrid8.Col:=0;
     Stringgrid8.Row:=1;
    end;
  If nGrid=3 then
   FormRepEdit.StringGrid3.Cells[2,FormRepEdit.StringGrid3.Row]:='4';
end;




procedure TFormRepEdit.StringGrid1EditButtonClick(Sender: TObject);
begin
   nGrid:=1;
   if FormRepEdit.StringGrid1.Col=0 then FormRepEdit.PopupMenu1.PopUp;
   if FormRepEdit.StringGrid1.Col=2 then FormRepEdit.PopupMenu2.PopUp;
end;

procedure TFormRepEdit.StringGrid1EditingDone(Sender: TObject);
var
  sS : string;
begin
  with FormRepEdit do
  begin
  If StringGrid1.Col=1 then
  begin
   sS := FormRepEdit.StringGrid1.Cells[1,FormRepedit.StringGrid1.row];
   If not(sS[1] in ['1'..'9']) then
    FormRepEdit.StringGrid1.Cells[1,FormRepedit.StringGrid1.row]:='1';
  end;
 end;
end;


procedure TFormRepEdit.StringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  // маска вводимых занчений
  if ACol=1 then Value := '!9;1; ';
end;

procedure TFormRepEdit.StringGrid1SelectEditor(Sender: TObject; aCol,
  aRow: Integer; var Editor: TWinControl);
begin
    With FormRepEdit do
  begin
   If Stringgrid1.Col<3 then exit;

  end;
end;


procedure TFormRepEdit.StringGrid2SelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  FormRepEdit.StringGrid8.Cells[0,1] := FormRepEdit.StringGrid2.Cells[FormRepEdit.StringGrid2.Col,4];
  FormRepEdit.StringGrid8.Cells[1,1] := FormRepEdit.StringGrid2.Cells[FormRepEdit.StringGrid2.Col,5];
  FormRepEdit.StringGrid8.Cells[2,1] := FormRepEdit.StringGrid2.Cells[FormRepEdit.StringGrid2.Col,6];
end;

procedure TFormRepEdit.StringGrid2SelectEditor(Sender: TObject; aCol,
  aRow: Integer; var Editor: TWinControl);
begin
   FormRepEdit.StringGrid8.Cells[0,1] := FormRepEdit.StringGrid2.Cells[FormRepEdit.StringGrid2.Col,4];
  FormRepEdit.StringGrid8.Cells[1,1] := FormRepEdit.StringGrid2.Cells[FormRepEdit.StringGrid2.Col,5];
  FormRepEdit.StringGrid8.Cells[2,1] := FormRepEdit.StringGrid2.Cells[FormRepEdit.StringGrid2.Col,6];
end;


procedure TFormRepEdit.StringGrid8EditButtonClick(Sender: TObject);
begin
  nGrid:=2;
   if FormRepEdit.StringGrid8.Col=0 then FormRepEdit.PopupMenu1.PopUp;
   if FormRepEdit.StringGrid8.Col=2 then FormRepEdit.PopupMenu2.PopUp;
end;

procedure TFormRepEdit.StringGrid8EditingDone(Sender: TObject);
var
  sS : string;
begin
  with FormRepEdit do
  begin
  //выравнивание
  //If StringGrid8.Col=0 then
     StringGrid2.Cells[StringGrid2.Col,4]:=StringGrid8.Cells[0,1];
  //шрифт
  //If StringGrid8.Col=1 then
  begin
   sS := StringGrid8.Cells[1,StringGrid8.row];
   If (trim(ss)='') OR not(sS[1] in ['1'..'9']) then
    StringGrid8.Cells[1,StringGrid8.row]:='2';
    StringGrid2.Cells[StringGrid2.Col,5]:=StringGrid8.Cells[1,1];
  end;
  //тип
  //If StringGrid8.Col=2 then
     StringGrid2.Cells[StringGrid2.Col,6]:=StringGrid8.Cells[2,1];
  end;
 end;


procedure TFormRepEdit.StringGrid8GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
   // маска вводимых занчений
  //if ACol=1 then Value := '!9;1; ';
end;

procedure TFormRepEdit.StringGrid3EditButtonClick(Sender: TObject);
begin
   nGrid:=3;
   if FormRepEdit.StringGrid3.Col=0 then FormRepEdit.PopupMenu1.PopUp;
   if FormRepEdit.StringGrid3.Col=2 then FormRepEdit.PopupMenu2.PopUp;
end;

procedure TFormRepEdit.StringGrid3EditingDone(Sender: TObject);
var
  sS : string;
begin
  with FormRepEdit do
  begin
  If StringGrid2.Col=1 then
  begin
   sS := FormRepEdit.StringGrid2.Cells[1,FormRepedit.StringGrid2.row];
   If not(sS[1] in ['1'..'9']) then
    FormRepEdit.StringGrid2.Cells[1,FormRepedit.StringGrid2.row]:='1';
  end;
 end;

end;

procedure TFormRepEdit.StringGrid3GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
   // маска вводимых занчений
  if ACol=1 then Value := '!9;1; ';
end;

procedure TFormRepEdit.StringGrid5DblClick(Sender: TObject);
begin
  FormRepEdit.BitBtn9.Click();
end;

procedure TFormRepEdit.StringGrid5MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  r: integer;
  c: integer;
begin
  FormRepEdit.StringGrid5.MouseToCell(X, Y, C, R);
  with FormRepEdit.StringGrid5 do
  begin
  If RowCount< 2 then exit;
  iF length(arColdes)<4 then exit;
  if (nRow <> r) then
    begin
      nRow := r;
      nCol := c;
      Application.CancelHint;
      StringGrid5.Hint := arColDes[r];
    end;
  end;
end;

procedure TFormRepEdit.StringGrid6MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
var
  r: integer;
  c: integer;
begin
  FormRepEdit.StringGrid6.MouseToCell(X, Y, C, R);
  with FormRepEdit.StringGrid6 do
  begin
  If RowCount < 1 then exit;
  if (nR2 <> r) then
    begin
      nR2 := r;
      nCol2 := c;
      Application.CancelHint;
      StringGrid6.Hint := Cells[0,r];
    end;
  end;

end;


//*******************************************  СОХРАНИТЬ данные ОТЧЕТА *****************************************
procedure TFormRepEdit.BitBtn3Click(Sender: TObject);
var
   new_id,n,k,i:integer;
   razbor:string;
   Shead,Sdown,sTt, sZapros, ss : string;
begin
  With FormRepEdit do
  begin
   //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if (trim(FormRepEdit.Edit1.text)='') or
     (trim(ComboBox2.Text)='') then
      begin
       showmessagealt('Сохранение невозможно !!!'+#13+'Заполнены не все обязательные поля данных !');
       exit;
      end;
  //преобразуем данные гридов в текстовые строки с разделяющими символами
  Shead:='';
  sDown:= '';
  sTT := '';
  sZapros :='';
  sS := Edit2.Text;
   For i:=1 to length(ss) do
    begin
     If not(sS[i] in ['0'..'9']) then
       begin
           ss[i]:='0';
           Edit2.text := ss;
       end;
    end;

 //запрос
 //sZapros := Memo1.Text;

  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

  //проверка на дубликат названия, если режим добавления
  if fl_edit=1 then
    begin
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('SELECT id FROM av_reports WHERE naim='+Quotedstr(trim(Edit1.Text))+' AND del=0;');
   //showmessage(ZQuery1.SQL.text);//$
    try
     ZQuery1.open;
    except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    end;
    //Если уже есть отчет с таким именем, выход
     If ZQuery1.RecordCount>0 then
       begin
       showmessagealt('Невозможно сохранить отчет !'+#13+'Отчет с таким названием уже существует !');
       exit;
       end;
    end;


 //колонки отчета
 // если на 1-й вкладке
 If PageControl1.ActivePageIndex=0 then
 begin
  for n:=1 to Stringgrid2.ColCount-1 do
   begin
     sTT:=sTT+trim(Stringgrid2.Cells[n,3])+trim(Stringgrid2.Cells[n,4])+trim(Stringgrid2.Cells[n,5])+trim(Stringgrid2.Cells[n,6])+'$'+trim(Stringgrid2.Cells[n,1])+'@'+trim(Stringgrid2.Cells[n,2])+'|';
   end;
 end;
 // если на другой вкладке
 If not(PageControl1.ActivePageIndex=0) then
 begin
  for n:=1 to Stringgrid4.RowCount-1 do
   begin
     sTT:=sTT+trim(Stringgrid4.Cells[3,n])+trim(Stringgrid4.Cells[4,n])+trim(Stringgrid4.Cells[5,n])+trim(Stringgrid4.Cells[6,n])+'$'+trim(Stringgrid4.Cells[1,n])+'@'+trim(Stringgrid4.Cells[2,n])+'|';
   end;
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
  //определяем порядок отчетов
  //пронумеруем все отчеты по порядку после данного
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('CREATE LOCAL TEMPORARY TABLE reports_num (orderid integer NOT NULL DEFAULT 0,id integer NOT NULL DEFAULT 0) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('insert into reports_num select row_number() over (order by id_order)+'+inttostr(SpinEdit1.Value)+' orderid,id from av_reports where del=0 AND id_order>='+inttostr(SpinEdit1.Value)+' AND id<>'+id_rep+' order by id_order;');
  ZQuery1.ExecSQL;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('update av_reports Set id_order=reports_num.orderid From reports_num where av_reports.id=reports_num.id AND av_reports.del=0 AND av_reports.id_order>='+inttostr(SpinEdit1.Value)+';');
  ZQuery1.ExecSQL;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('drop table reports_num;');
  ZQuery1.ExecSQL;

  //режим добавления
  if fl_edit=1 then
      begin
  //Определяем текущий id+1
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_reports;');
        ZQuery1.open;
        id_rep:= inttostr(ZQuery1.FieldByName('new_id').asInteger+1);
     end;

  //Маркируем запись на удаление если режим редактирования
  if fl_edit=2 then
      begin
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_reports SET del=1,createdate=now() WHERE id='+id_rep+' and del=0;');
       ZQuery1.ExecSQL;
      end;

  //Производим запись новых данных
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('INSERT INTO av_reports(id_order,naim,grup,fl_type,fl_choice,headtext,downtext,rep_columns,zapros,id_user,createdate,del,id,id_user_first,createdate_first) VALUES (');
   ZQuery1.SQL.add(inttostr(SpinEdit1.value)+','+Quotedstr(Edit1.Text)+','+inttostr(Combobox1.ItemIndex)+','+fltype+','+Edit2.Text+',');
   ZQuery1.SQL.add('''');
     //заголовок отчета
   for n:=1 to Stringgrid1.RowCount-1 do
     begin
       ZQuery1.SQL.add(trim(Stringgrid1.Cells[0,n])+trim(Stringgrid1.Cells[1,n])+trim(Stringgrid1.Cells[2,n])+'@'+trim(Stringgrid1.Cells[3,n])+'|');
     end;
   ZQuery1.SQL.add(''',''');
    //подвал отчета
   for n:=1 to Stringgrid3.RowCount-1 do
     begin
      ZQuery1.SQL.add(trim(Stringgrid3.Cells[0,n])+trim(Stringgrid3.Cells[1,n])+trim(Stringgrid3.Cells[2,n])+'@'+trim(Stringgrid3.Cells[3,n])+'|');
     end;
   ZQuery1.SQL.add(''',');
   //ZQuery1.SQL.add(QuotedStr(Shead)+','+QuotedStr(Sdown)+',');
   ZQuery1.SQL.add(QuotedStr(sTt) +','+QuotedStr(Memo1.text)+','+ intToStr(id_user)+',now(),0,'+id_rep+',');

   //режим добавления
  if fl_edit=1 then
      begin
        ZQuery1.SQL.add(intToStr(id_user)+',now());');
      end;
   //режим редактирования
  if fl_edit=2 then
      begin
        ZQuery1.SQL.add('NULL,NULL);');
      end;
  //showmessage(ZQuery1.SQL.Text);
  ZQuery1.ExecSQL;

  // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  //флаг внесения изменений
  fl_change := 0;
  Close;
  //Если первая вкладка - закрывать окно, иначе - нет
  //If PageControl1.ActivePageIndex=0 then Close;
//  else showmessagealt('Сохранение Успешно!');
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
  end;
end;

//*******************************************  СОХРАНИТЬ данные на 3 вкладке *****************************************
procedure TFormRepEdit.BitBtn13Click(Sender: TObject);
var
   n, fl, k:integer;
   ntype: string;
begin
  With FormRepEdit do
  begin
  //проверка на дубликат

  for n:=1 to Stringgrid7.RowCount-1 do
  begin
  fl:= 0;
  for k:=1 to Stringgrid7.rowcount-1 do
  begin
    If k=n then continue;
    If trim(Stringgrid7.Cells[1,n])=trim(Stringgrid7.Cells[1,k]) then
      fl := 1;
  end;
  If fl=1 then
    begin
      Stringgrid7.Cells[1,n]:= '';
      continue;
    end;
  end;

    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
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
  //помечаем все записи таблицы на удаление
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('UPDATE av_reports_vars SET del=1,createdate=now() WHERE del=0;');
    ZQuery1.ExecSQL;

  for n:=1 to Stringgrid7.RowCount-1 do
  begin
    If trim(Stringgrid7.Cells[1,n])='' then continue;
    If trim(Stringgrid7.Cells[4,n])='1' then ntype:='1'
    else ntype:='0';
  //Производим запись новых данных
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('INSERT INTO av_reports_vars(rvar,rdescription,rdepend,rtype) VALUES (');
   ZQuery1.SQL.add(QuotedStr(trim(Stringgrid7.Cells[1,n]))+','+QuotedStr(trim(Stringgrid7.Cells[2,n]))+',');
   ZQuery1.SQL.add(QuotedStr(trim(Stringgrid7.Cells[3,n]))+','+ntype+');');
   ZQuery1.ExecSQL;

  end;
  // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  //флаг внесения изменений
  fl2 := 0;
  UpdateVars();
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;

 end;

//************************* ДОБАВИТЬ СТРОЧКУ В ЗАГОЛОВОК */***********************************
procedure TFormRepEdit.BitBtn1Click(Sender: TObject);
begin
With FormRepEdit do
begin
  if (StringGrid1.RowCount>1) and
     (not(trim(StringGrid1.Cells[0,StringGrid1.Row])='')) and
     (not(trim(StringGrid1.Cells[1,StringGrid1.Row])='')) and
     (not(trim(StringGrid1.Cells[2,StringGrid1.Row])='')) then
     begin
      StringGrid1.RowCount:=StringGrid1.RowCount+1;
      StringGrid1.Cells[0,StringGrid1.RowCount-1]:=StringGrid1.Cells[0,StringGrid1.RowCount-2];
      StringGrid1.Cells[1,StringGrid1.RowCount-1]:=StringGrid1.Cells[1,StringGrid1.RowCount-2];
      StringGrid1.Cells[2,StringGrid1.RowCount-1]:=StringGrid1.Cells[2,StringGrid1.RowCount-2];
     end;
  if (StringGrid1.RowCount=1) then
     begin
       StringGrid1.RowCount:=StringGrid1.RowCount+1;
       StringGrid1.Cells[0,StringGrid1.RowCount-1]:='1';
       StringGrid1.Cells[1,StringGrid1.RowCount-1]:='2';
       StringGrid1.Cells[2,StringGrid1.RowCount-1]:='1';
       StringGrid1.Cells[3,StringGrid1.RowCount-1]:='';
     end;
  Stringgrid1.SetFocus;
  Stringgrid1.Col:=3;
  Stringgrid1.Row:=Stringgrid1.RowCount-1;
  end;
//флаг внесения изменений
  fl_change := 1;
end;

//******************** ДОБАВИТЬ ПЕРЕМЕННУЮ ***************************************************
procedure TFormRepEdit.BitBtn20Click(Sender: TObject);
var
   n: integer;
begin
  With FormRepEdit do
begin
  StringGrid7.RowCount:=StringGrid7.RowCount+1;
  Stringgrid7.SetFocus;
  Stringgrid7.Col:=1;
  Stringgrid7.Row:=Stringgrid7.RowCount-1;
//флаг внесения изменений
  fl2 := 1;
end;
end;


//******************* УДАЛИТЬ *****************************
procedure TFormRepEdit.BitBtn14Click(Sender: TObject);
begin
  DelGridColumn(FormRepEdit.StringGrid2, FormRepEdit.StringGrid2.Col);
  //флаг внесения изменений
  fl_change := 1;
end;

//******************* УДАЛИТЬ *****************************
procedure TFormRepEdit.BitBtn10Click(Sender: TObject);
begin
  DelStringGrid(FormRepEdit.StringGrid4, FormRepEdit.StringGrid4.Row);
  //флаг внесения изменений
  fl_change := 1;
end;

//******************* УДАЛИТЬ *****************************
procedure TFormRepEdit.BitBtn19Click(Sender: TObject);
begin
  DelStringGrid(FormRepEdit.StringGrid7, FormRepEdit.StringGrid7.Row);
  //флаг внесения изменений
  fl2 := 1;
end;

//************************** добавить пустую колонку *******************************************
procedure TFormRepEdit.BitBtn6Click(Sender: TObject);
begin
With FormRepEdit.StringGrid4 do
begin
    RowCount:=RowCount+1;
    Cells[0,RowCount-1] := inttostr(RowCount-1);
    If rowcount=2 then
       begin
       Cells[3,RowCount-1] := '0';//тип колонки
       Cells[4,RowCount-1] := '1';//вырвнивание
       Cells[5,RowCount-1] := '2';//шрифт
       Cells[6,RowCount-1] := '1';//тип
       end
    else
    begin
       Cells[3,RowCount-1] := Cells[3,RowCount-2];//тип колонки
       Cells[4,RowCount-1] := Cells[4,RowCount-2];//вырвнивание
       Cells[5,RowCount-1] := Cells[5,RowCount-2];//шрифт
       Cells[6,RowCount-1] := Cells[6,RowCount-2];//тип
    end;

    SetFocus;
    Col:=1;
    Row:=RowCount-1;
  end;
//флаг внесения изменений
  fl_change := 1;
end;

//************* ДОБАВИТЬ КОЛОНКУ ИЗ ГРИДА СПРАВА ******************************
procedure TFormRepEdit.BitBtn9Click(Sender: TObject);
var
   TargetTable : string;
begin
   With FormRepEdit do
  begin
  If trim(StringGrid5.Cells[0,StringGrid5.row])='' then exit;
  //TargetTable := '';
  //TargetTable := trim(copy(ComboBox2.Text,pos('|',ComboBox2.Text)+1,length(ComboBox2.Text)));
  //If trim(TargetTable)='' then exit;

  StringGrid4.RowCount:=StringGrid4.RowCount+1;
  StringGrid4.Cells[0,StringGrid4.RowCount-1]:= inttostr(StringGrid4.RowCount-1);
  StringGrid4.Cells[1,StringGrid4.RowCount-1]:= StringGrid5.Cells[0,StringGrid5.Row];
  StringGrid4.Cells[2,StringGrid4.RowCount-1]:=StringGrid5.Cells[1,StringGrid5.Row];
  StringGrid4.Cells[3,StringGrid4.RowCount-1] := StringGrid5.Cells[2,StringGrid5.Row];//тип колонки
  StringGrid4.Cells[4,StringGrid4.RowCount-1] := '1';//вырвнивание
  StringGrid4.Cells[5,StringGrid4.RowCount-1] := '2';//шрифт
  StringGrid4.Cells[6,StringGrid4.RowCount-1] := '1';//тип
  StringGrid4.SetFocus;
  StringGrid4.Col:=1;
  StringGrid4.Row:=StringGrid4.RowCount-1;
  end;
  //флаг внесения изменений
  fl_change := 1;
end;

//**************** ТИП ОТЧЕТА: 1-ДИНАМИЧЕСКИЙ, 0 - СТАТИЧЕСКИЙ
procedure TFormRepEdit.CheckBox1Change(Sender: TObject);
begin
  If CheckBox1.Checked then    fltype:='1'
   else  fltype:= '0';
end;



procedure TFormRepEdit.ComboBox2Change(Sender: TObject);
begin
  UpdateGrid5();
end;

procedure TFormRepEdit.FormClose(Sender: TObject; var CloseAction: TCloseAction  );
var
  res_flag:integer;
begin
 //если были изменения
  If (fl_change=1) or (fl2=1) then
      begin
      res_flag := dialogs.MessageDlg('Внесенные изменения НЕ будут сохранены !'+#13+'Продолжить выход ?',mtConfirmation,[mbYes,mbNO], 0);
        if res_flag=7 then CloseAction := caNone;
      end;
end;

//******************* ПЕРЕМЕСТИТЬ СТРОЧКУ ГРИДА 4 ВВЕРХ *******************************
procedure TFormRepEdit.BitBtn12Click(Sender: TObject);
 var
   i: integer;
begin
  With FormRepEdit.StringGrid4 do
  begin
 // Если нет пунктов или первый то ничего не делаем
  if (Row=1) or (RowCount<2) then exit;
  //Меняем местами строчки грида
    begin
       RowCount := RowCount+1;
       for i:=1 to Colcount-1 do
       begin
       Cells[i,RowCount-1]:=Cells[i,Row];
       Cells[i,Row]:=Cells[i,Row-1];
       Cells[i,Row-1]:=Cells[i,RowCount-1];
       end;
       RowCount := RowCount-1;
    end;
  SetFocus;
  Row:=Row-1;
  end;
end;


//************************** добавить пустую колонку *******************************************
procedure TFormRepEdit.BitBtn15Click(Sender: TObject);
begin
With FormRepEdit.StringGrid2 do
begin
    ColCount:=ColCount+1;
    Cells[ColCount-1,0] := inttostr(ColCount-1);
    If ColCount=2 then
    begin
    Cells[ColCount-1,3] := '0';//тип колонки
    Cells[ColCount-1,4] := '1';//вырвнивание
    Cells[ColCount-1,5] := '2';//шрифт
    Cells[ColCount-1,6] := '1';//тип
    end
    else
    begin
    Cells[ColCount-1,3] := Cells[ColCount-2,3];//тип колонки
    Cells[ColCount-1,4] := Cells[ColCount-2,4];//вырвнивание
    Cells[ColCount-1,5] := Cells[ColCount-2,5];//шрифт
    Cells[ColCount-1,6] := Cells[ColCount-2,6];//тип
    end;
    SetFocus;
    Row:=2;
    Col:=ColCount-1;
  end;
//флаг внесения изменений
  fl_change := 1;
end;

//******************* ПЕРЕМЕСТИТЬ КОЛОНКУ ГРИДА 2 ВЛЕВО *******************************
procedure TFormRepEdit.BitBtn16Click(Sender: TObject);
 var
    i: integer;
begin
  With FormRepEdit.StringGrid2 do
  begin
 // Если нет пунктов или первый то ничего не делаем
  if (Col=1) or (ColCount<2) then exit;
  //Меняем местами колонки грида
    begin
       ColCount := ColCount+1;
       for i:=1 to Rowcount-1 do
       begin
       Cells[ColCount-1,i]:=Cells[Col,i];
       Cells[Col,i]:=Cells[Col-1,i];
       Cells[Col-1,i]:=Cells[ColCount-1,i];
       end;
       ColCount := ColCount-1;
    end;
  SetFocus;
  Col:=Col-1;
  end;
end;

//************ ПЕРЕМЕСТИТЬ КОЛОНКУ ГРИДА 2 ВПРАВО *****************************
procedure TFormRepEdit.BitBtn17Click(Sender: TObject);
var
  i : integer;
begin
  With FormRepEdit.StringGrid2 do
  begin
 // Если нет пунктов или последний то ничего не делаем
  if (Col=ColCount-1) or (ColCount<2) then exit;
  //Меняем местами колонки грида
    begin
       ColCount := ColCount+1;
       for i:=1 to Rowcount-1 do
       begin
       Cells[ColCount-1,i]:=Cells[Col,i];
       Cells[Col,i]:=Cells[Col+1,i];
       Cells[Col+1,i]:=Cells[ColCount-1,i];
       end;
       ColCount := ColCount-1;
    end;
  SetFocus;
  Col:=Col+1;
  end;
end;


//************ ПЕРЕМЕСТИТЬ СТРОЧКУ ГРИДА 4 ВНИЗ *****************************
procedure TFormRepEdit.BitBtn11Click(Sender: TObject);
var
  i: integer;
begin
  With FormRepEdit.StringGrid4 do
  begin
 // Если нет пунктов или последний то ничего не делаем
  if (Row=RowCount-1) or (RowCount<2) then exit;
  //Меняем местами строчки грида
    begin
       RowCount := RowCount+1;
       for i:=1 to Colcount-1 do
       begin
       Cells[i,RowCount-1]:=Cells[i,Row];
       Cells[i,Row]:=Cells[i,Row+1];
       Cells[i,Row+1]:=Cells[i,RowCount-1];
       end;
       RowCount := RowCount-1;
    end;
  SetFocus;
  Row:=Row+1;
  end;
end;

//********************************* УДАЛИТЬ *****************************
procedure TFormRepEdit.BitBtn2Click(Sender: TObject);
begin
  DelStringGrid(FormRepEdit.StringGrid1, FormRepEdit.StringGrid1.Row);
  //флаг внесения изменений
  fl_change := 1;
end;

procedure TFormRepEdit.BitBtn4Click(Sender: TObject);
begin
  FormRepEdit.close;
end;

//******************************  ОБНОВИТЬ *****************************************
procedure TFormRepEdit.BitBtn5Click(Sender: TObject);
begin
   If FormRepEdit.PageControl1.ActivePageIndex=2 then
      UpdateVars()
   else
      UpdateShablon();
   //If FormRepEdit.PageControl1.ActivePageIndex=1 then
     //UpdateCombo();
end;

procedure TFormRepEdit.BitBtn7Click(Sender: TObject);
begin
  With FormRepEdit do
begin
  if (StringGrid3.RowCount>1) and
     (not(trim(StringGrid3.Cells[0,StringGrid3.Row])='')) and
     (not(trim(StringGrid3.Cells[1,StringGrid3.Row])='')) and
     (not(trim(StringGrid3.Cells[2,StringGrid3.Row])='')) then
     begin
      StringGrid3.RowCount:=StringGrid3.RowCount+1;
      StringGrid3.Cells[0,StringGrid3.RowCount-1]:=StringGrid3.Cells[0,StringGrid3.RowCount-2];
      StringGrid3.Cells[1,StringGrid3.RowCount-1]:=StringGrid3.Cells[1,StringGrid3.RowCount-2];
      StringGrid3.Cells[2,StringGrid3.RowCount-1]:=StringGrid3.Cells[2,StringGrid3.RowCount-2];
     end;
  if (StringGrid3.RowCount=1) then
     begin
       StringGrid3.RowCount:=StringGrid3.RowCount+1;
       StringGrid3.Cells[0,StringGrid3.RowCount-1]:='1';
       StringGrid3.Cells[1,StringGrid3.RowCount-1]:='2';
       StringGrid3.Cells[2,StringGrid3.RowCount-1]:='1';
       StringGrid3.Cells[3,StringGrid3.RowCount-1]:='';
     end;
  StringGrid3.SetFocus;
  StringGrid3.Col:=3;
  StringGrid3.Row:=StringGrid3.RowCount-1;
  end;
//флаг внесения изменений
  fl_change := 1;
end;

procedure TFormRepEdit.BitBtn8Click(Sender: TObject);
begin
    DelStringGrid(FormRepEdit.StringGrid3, FormRepEdit.StringGrid3.Row);
    //флаг внесения изменений
  fl_change := 1;
end;

//************* ДОБАВИТЬ ПЕРЕМЕННУЮ В ЗАГОЛОВОК ИЗ ГРИДА 6 ******************************
procedure TFormRepEdit.BitBtn18Click(Sender: TObject);
begin
  With FormRepEdit do
  begin
  If trim(StringGrid6.Cells[1,StringGrid6.row])='' then exit;
  Stringgrid1.Cells[3, stringgrid1.Row] := Stringgrid1.Cells[3, stringgrid1.Row] +' &'+ StringGrid6.Cells[1,StringGrid6.row]+' ';
  end;
  //флаг внесения изменений
  fl_change := 1;
end;

//************* ДОБАВИТЬ ПЕРЕМЕННУЮ В ПОДВАЛ ИЗ ГРИДА 6 ******************************
procedure TFormRepEdit.BitBtn21Click(Sender: TObject);
begin
  With FormRepEdit do
  begin
  If trim(StringGrid6.Cells[1,StringGrid6.row])='' then exit;
  Stringgrid3.Cells[3, stringgrid3.Row] := Stringgrid3.Cells[3, stringgrid3.Row] +' &'+ StringGrid6.Cells[1,StringGrid6.row]+' ';
  end;
  //флаг внесения изменений
  fl_change := 1;
end;


//*************************** ВЫПОЛНИТЬ ЗАПРОС SQL *************************************************************************
procedure TFormRepEdit.BitBtn22Click(Sender: TObject);
var
  n,m:integer;
  Zapros : string;
begin
 With FormRepEdit do
 begin
   //проверка что memo1 не пустое
   if Memo1.lines.Count=0 then exit;
   Memo3.Clear;

   // ЗАПОЛНЕНИЕ МАССИВА ПЕРЕМЕННЫХ ОТЧЕТОВ
    FillReportVars(Zconnection1,ZQuery1);

   //проверяем запрос на наличие переменных и подставляем значения
   Zapros := GetZapros(Memo1.Text);

   // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
       begin
        showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
        exit;
       end;
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add(Zapros);
   // Выполняем команду и ловим ошибки
  try
    ZQuery1.Open;
    Memo3.Append('Команда выполнена успешно !!!'+chr(13));
    Memo3.Append('Всего: '+inttostr(ZQuery1.recordcount)+' строк'+chr(13));
   // Если SELECT то выводим результат
    if ZQuery1.RecordCount>0 then
       begin
         StringGrid9.ColCount:=ZQuery1.FieldCount;
         //Заполняем заголовки полей
         for n:=0 to ZQuery1.FieldCount-1 do
           begin
            StringGrid9.Cells[n,0]:=ZQuery1.Fields[n].fieldname;
           end;
         //Заполняем поля
         StringGrid9.RowCount:=ZQuery1.RecordCount+1;
         for n:=1 to StringGrid9.RowCount-1 do
          begin
             for m:=0 to ZQuery1.FieldCount-1 do
              begin
               StringGrid9.Cells[m,n]:=ZQuery1.FieldByName(ZQuery1.Fields[m].fieldname).Asstring;
              end;
               ZQuery1.Next;
          end;
       end;
  except
    on E: Exception do
    begin
       Memo3.Append('ОШИБКА: '+e.Message);
    end;
  end;
   ZQuery1.close;
   Zconnection1.disconnect;
 end;
end;

procedure TFormRepEdit.BitBtn23Click(Sender: TObject);
begin
  Memo1.Clear;
end;

//**************************** ВСТАВИТЬ ЗАПРОС ИЗ ДРУГОГО ОТЧЕТА **************************************
procedure TFormRepEdit.BitBtn24Click(Sender: TObject);
var
  FormReport2: TFormReport;
  nRow : integer;
begin
  with FormRepEdit do
  begin
  FormReport2:=TFormReport.create(FormReport);
  with FormReport2 do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;

       end;
  fl_open := 1;
  FormReport2.Showmodal;
  FreeAndNil(FormReport2);
  fl_open:=0;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;

   ZQuery1.SQL.clear;
   ZQuery1.SQL.add('SELECT zapros FROM av_reports where del=0 AND id='+newRow+';');
   //showmessage(ZQuery1.SQL.text);//$
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;
   If ZQuery1.RecordCount=0 then
     begin
          showmessagealt('Запись данного отчета ошибочна в базе!');
          ZQuery1.Close;
          Zconnection1.disconnect;
          EXIT;
     end;
   Memo1.Clear;
   Memo1.Text := ZQuery1.FieldByName('zapros').asstring;
   ZQuery1.Close;
   Zconnection1.disconnect;
   end;
end;


procedure TFormRepEdit.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F5] - Добавить'+#13+'[ENTER] - Выбрать'+#13+'ESC - Отмена\Выход');
    // ESC
    if Key=27 then FormRepEdit.Close;
    // F2 - Сохранить
    if (Key=113) and (FormRepEdit.BitBtn3.Enabled=true) then FormRepEdit.BitBtn3.Click;

    if (Key=112) or (Key=113) or (Key=27) then  Key:=0;
end;
//******************  ОПЦИИ ВЫБОРА *****************************************************************************************
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// таблица соответствия кодов запуска форм выбора условий отчетов
  // s[1] = '1' shedule
  // s[2] = '1' shedule_sostav
  // s[3] = '1' spr_locality
  // s[4] = '1' spr_point
  // s[5] = '1' route
  // s[6] = '1' spr_kontragent
  // s[7] = '1' spr_kontr_dog
  // s[7] = '2' spr_kontr_viddog
  // s[7] = '3' spr_kontr_license
  // s[7] = '4' spr_kontr_ats
  // s[8] = '1' spr_ats
  // s[9] = '1' spr_uslugi
  // s[10] = '1' spr_lgot
  // s[11] = '1' users
  // s[12] = '1' servers
  // s[13] = '1' tarif
  // s[14] = '1' tarif_bagag
  // s[14] = '2' tarif_lgot
  // s[14] = '3' tarif_local
  // s[14] = '4' tarif_predv
  // s[14] = '5' tarif_uslugi
  // s[15] = '1' report_vibor - date
  // s[15] = '2' report_vibor - time
  // s[15] = '3' report_vibor - sezon
  // s[15] = '4' report_vibor - kolvo

procedure TFormRepEdit.Edit2Change(Sender: TObject);
var
  i: integer;
  ss: string;
begin
   with FormRepEdit do
  begin
   sS := Edit2.Text;
   If length(ss)>15 then Edit2.Text:=Copy(Edit2.Text,1,15);
   If length(ss)<14 then Edit2.text:=Padl(Edit2.text,'0',15);
   For i:=1 to length(ss) do
    begin
     If not(sS[i] in ['0'..'9']) then
       begin
           ss[i]:='0';
           Edit2.text := ss;
       end;
    end;
  If ss[1] = '1' then CheckBox2.Checked:= true else CheckBox2.Checked := false; //shedule
  If ss[2] = '1' then RadioGroup1.ItemIndex:= 0; //shedule_sostav
  If ss[2] = '2' then RadioGroup1.ItemIndex:= 1; //shedule_atp
  If ss[2] = '3' then RadioGroup1.ItemIndex:= 2; //shedule_tarif
  If ss[2] = '4' then RadioGroup1.ItemIndex:= 3; //shedule_ats
  If ss[2] = '5' then RadioGroup1.ItemIndex:= 4; //shedule_sezon
  If ss[2] = '6' then RadioGroup1.ItemIndex:= 5; //shedule_lgot
  If ss[2] = '7' then RadioGroup1.ItemIndex:= 6; //shedule_uslugi
  If ss[2] = '8' then RadioGroup1.ItemIndex:= 7; //shedule_denyuser
  If ss[3] = '1' then CheckGroup1.Checked[0]:= true else CheckGroup1.Checked[0]:= false;//spr_locality
  If ss[4] = '1' then CheckGroup1.Checked[1]:= true else CheckGroup1.Checked[1]:= false;//spr_point
  If ss[5] = '1' then CheckGroup1.Checked[2]:= true else CheckGroup1.Checked[2]:= false;//route
  If ss[6] = '1' then CheckBox3.Checked:= true else CheckBox3.Checked := false; //spr_kontragent
  If ss[7] = '1' then RadioGroup2.ItemIndex:= 0; //spr_kontr_dog
  If ss[7] = '2' then RadioGroup2.ItemIndex:= 1; //spr_kontr_viddog
  If ss[7] = '3' then RadioGroup2.ItemIndex:= 2; //spr_kontr_license
  If ss[7] = '4' then RadioGroup2.ItemIndex:= 3; //spr_kontr_ats
  If ss[8] = '1' then CheckGroup1.Checked[3]:= true else CheckGroup1.Checked[3]:= false;//spr_ats
  If ss[9] = '1' then CheckGroup1.Checked[4]:= true else CheckGroup1.Checked[4]:= false;//spr_uslugi
  If ss[10] = '1' then CheckGroup1.Checked[5]:= true else CheckGroup1.Checked[5]:= false;//spr_lgot
  If ss[11] = '1' then CheckGroup1.Checked[6]:= true else CheckGroup1.Checked[6]:= false;//users
  If ss[12] = '1' then CheckGroup1.Checked[7]:= true else CheckGroup1.Checked[7]:= false;//servers
  If ss[13] = '1' then CheckBox4.Checked:= true else CheckBox4.Checked := false; //tarif
  If ss[14] = '1' then RadioGroup3.ItemIndex:= 0; //tarif_bagag
  If ss[14] = '2' then RadioGroup3.ItemIndex:= 1; //tarif_lgot
  If ss[14] = '3' then RadioGroup3.ItemIndex:= 2; //tarif_local
  If ss[14] = '4' then RadioGroup3.ItemIndex:= 3; //tarif_predv
  If ss[14] = '5' then RadioGroup3.ItemIndex:= 4; //tarif_uslugi
  If ss[15] <> '0' then CheckBox5.Checked:= true else CheckBox5.Checked := false; //report_vibor
  If ss[15] = '1' then RadioGroup4.ItemIndex:= 0; //date
  If ss[15] = '2' then RadioGroup4.ItemIndex:= 1; //time
  If ss[15] = '3' then RadioGroup4.ItemIndex:= 2; //sezon
  If ss[15] = '4' then RadioGroup4.ItemIndex:= 3; //kolvo

 end;

end;

procedure TFormRepEdit.Edit2Exit(Sender: TObject);
begin
  If length(Edit2.text)<15 then Edit2.text:=Padl(Edit2.text,'0',15);
end;

//расписания
procedure TFormRepEdit.CheckBox2Change(Sender: TObject);
begin
 with FormRepEdit do
 begin
  If CheckBox2.Checked = true then
     begin
       Edit2.Text := '1'+Copy(Edit2.Text,2,length(Edit2.Text));
       RadioGroup1.Enabled := true;
       RadioGroup1.ItemIndex:= -1;
     end
  else
    begin
       Edit2.Text := '00'+Copy(Edit2.Text,3,length(Edit2.Text));
       RadioGroup1.Enabled:= false;
    end;
 end;
end;

//контрагент
procedure TFormRepEdit.CheckBox3Change(Sender: TObject);
begin
   with FormRepEdit do
 begin
  If CheckBox3.Checked = true then
     begin
       Edit2.Text := Copy(Edit2.Text,1,5)+'1'+Copy(Edit2.Text,7,length(Edit2.Text));
       RadioGroup2.Enabled := true;
       RadioGroup2.ItemIndex:= -1;
     end
  else
    begin
       Edit2.Text := Copy(Edit2.Text,1,5)+'00'+Copy(Edit2.Text,8,length(Edit2.Text));
       RadioGroup2.Enabled:= false;
    end;
 end;
end;

//тарифы
procedure TFormRepEdit.CheckBox4Change(Sender: TObject);
begin
    with FormRepEdit do
 begin
  If CheckBox4.Checked = true then
     begin
       Edit2.Text := Copy(Edit2.Text,1,12)+'1'+Copy(Edit2.Text,14,length(Edit2.Text));
       RadioGroup3.Enabled := true;
       RadioGroup3.ItemIndex:= -1;
     end
  else
    begin
       Edit2.Text := Copy(Edit2.Text,1,12)+'00'+Copy(Edit2.Text,15,length(Edit2.Text));
       RadioGroup3.Enabled:= false;
    end;
 end;
end;

//временные
procedure TFormRepEdit.CheckBox5Change(Sender: TObject);
begin
    with FormRepEdit do
 begin
  If CheckBox5.Checked = true then
     begin
       //Edit2.Text := Copy(Edit2.Text,1,14)+'1'+Copy(Edit2.Text,16,length(Edit2.Text));
       RadioGroup4.Enabled := true;
       RadioGroup4.ItemIndex:= -1;
   //    RadioGroup4.ItemIndex:=0;
     end
  else
    begin
       Edit2.Text := Copy(Edit2.Text,1,14)+'0'; //+Copy(Edit2.Text,16,length(Edit2.Text));
       RadioGroup4.Enabled:= false;
    end;
 end;
end;


//расписания составляющие
procedure TFormRepEdit.RadioGroup1Click(Sender: TObject);
begin
 with FormRepEdit do
 begin
    case RadioGroup1.ItemIndex of
     0 : Edit2.Text:= Copy(Edit2.Text,1,1)+'1'+Copy(Edit2.Text,3,length(Edit2.Text)); //shedule_sostav
     1 : Edit2.Text:= Copy(Edit2.Text,1,1)+'2'+Copy(Edit2.Text,3,length(Edit2.Text));// shedule_atp
     2 : Edit2.Text:= Copy(Edit2.Text,1,1)+'3'+Copy(Edit2.Text,3,length(Edit2.Text));// shedule_tarif
     3 : Edit2.Text:= Copy(Edit2.Text,1,1)+'4'+Copy(Edit2.Text,3,length(Edit2.Text));// shedule_ats
     4 : Edit2.Text:= Copy(Edit2.Text,1,1)+'5'+Copy(Edit2.Text,3,length(Edit2.Text));// shedule_sezon
     5 : Edit2.Text:= Copy(Edit2.Text,1,1)+'6'+Copy(Edit2.Text,3,length(Edit2.Text));// shedule_lgot
     6 : Edit2.Text:= Copy(Edit2.Text,1,1)+'7'+Copy(Edit2.Text,3,length(Edit2.Text));// shedule_uslugi
     7 : Edit2.Text:= Copy(Edit2.Text,1,1)+'8'+Copy(Edit2.Text,3,length(Edit2.Text));// shedule_denyuser
     else
       Edit2.Text:= Copy(Edit2.Text,1,1)+'0'+Copy(Edit2.Text,3,length(Edit2.Text));
     end;
 end;
end;

//контрагенты составляющие
procedure TFormRepEdit.RadioGroup2Click(Sender: TObject);
begin
  with FormRepEdit do
 begin
    case RadioGroup2.ItemIndex of
     0 : Edit2.Text:= Copy(Edit2.Text,1,6)+'1'+Copy(Edit2.Text,8,length(Edit2.Text)); //spr_kontr_dog
     1 : Edit2.Text:= Copy(Edit2.Text,1,6)+'2'+Copy(Edit2.Text,8,length(Edit2.Text));// spr_kontr_dog
     2 : Edit2.Text:= Copy(Edit2.Text,1,6)+'3'+Copy(Edit2.Text,8,length(Edit2.Text));//spr_kontr_dog
     3 : Edit2.Text:= Copy(Edit2.Text,1,6)+'4'+Copy(Edit2.Text,8,length(Edit2.Text));// spr_kontr_dog
     else
       Edit2.Text:= Copy(Edit2.Text,1,6)+'0'+Copy(Edit2.Text,8,length(Edit2.Text));
     end;
 end;
end;

//тарифы составляющие
procedure TFormRepEdit.RadioGroup3Click(Sender: TObject);
begin
  with FormRepEdit do
 begin
    case RadioGroup3.ItemIndex of
     0 : Edit2.Text:= Copy(Edit2.Text,1,13)+'1'+Copy(Edit2.Text,15,length(Edit2.Text)); //tarif
     1 : Edit2.Text:= Copy(Edit2.Text,1,13)+'2'+Copy(Edit2.Text,15,length(Edit2.Text)); // tarif
     2 : Edit2.Text:= Copy(Edit2.Text,1,13)+'3'+Copy(Edit2.Text,15,length(Edit2.Text)); //tarif
     3 : Edit2.Text:= Copy(Edit2.Text,1,13)+'4'+Copy(Edit2.Text,15,length(Edit2.Text)); // tarif
     else
       Edit2.Text:= Copy(Edit2.Text,1,13)+'0'+Copy(Edit2.Text,15,length(Edit2.Text));
     end;
 end;
end;

//тарифы составляющие
procedure TFormRepEdit.RadioGroup4Click(Sender: TObject);
begin
  with FormRepEdit do
 begin
    case RadioGroup4.ItemIndex of
     0 : Edit2.Text:= Copy(Edit2.Text,1,14)+'1';// date
     1 : Edit2.Text:= Copy(Edit2.Text,1,14)+'2';// time
     2 : Edit2.Text:= Copy(Edit2.Text,1,14)+'3';// sezon
     3 : Edit2.Text:= Copy(Edit2.Text,1,14)+'4';// kolvo
     else
       Edit2.Text:= Copy(Edit2.Text,1,14)+'0';
     end;
 end;
end;


//cправочники
procedure TFormRepEdit.CheckGroup1ItemClick(Sender: TObject; Index: integer);
begin
  with FormRepEdit do
 begin
  If CheckGroup1.Checked[0] = true then
       Edit2.Text := Copy(Edit2.Text,1,2)+'1'+Copy(Edit2.Text,4,length(Edit2.Text))
  else
       Edit2.Text := Copy(Edit2.Text,1,2)+'0'+Copy(Edit2.Text,4,length(Edit2.Text));

  If CheckGroup1.Checked[1] = true then
       Edit2.Text := Copy(Edit2.Text,1,3)+'1'+Copy(Edit2.Text,5,length(Edit2.Text))
  else
       Edit2.Text := Copy(Edit2.Text,1,3)+'0'+Copy(Edit2.Text,5,length(Edit2.Text));

  If CheckGroup1.Checked[2] = true then
       Edit2.Text := Copy(Edit2.Text,1,4)+'1'+Copy(Edit2.Text,6,length(Edit2.Text))
  else
       Edit2.Text := Copy(Edit2.Text,1,4)+'0'+Copy(Edit2.Text,6,length(Edit2.Text));

  If CheckGroup1.Checked[3] = true then
       Edit2.Text := Copy(Edit2.Text,1,7)+'1'+Copy(Edit2.Text,9,length(Edit2.Text))
  else
       Edit2.Text := Copy(Edit2.Text,1,7)+'0'+Copy(Edit2.Text,9,length(Edit2.Text));

  If CheckGroup1.Checked[4] = true then
       Edit2.Text := Copy(Edit2.Text,1,8)+'1'+Copy(Edit2.Text,10,length(Edit2.Text))
  else
       Edit2.Text := Copy(Edit2.Text,1,8)+'0'+Copy(Edit2.Text,10,length(Edit2.Text));

  If CheckGroup1.Checked[5] = true then
       Edit2.Text := Copy(Edit2.Text,1,9)+'1'+Copy(Edit2.Text,11,length(Edit2.Text))
  else
       Edit2.Text := Copy(Edit2.Text,1,9)+'0'+Copy(Edit2.Text,11,length(Edit2.Text));

  If CheckGroup1.Checked[6] = true then
       Edit2.Text := Copy(Edit2.Text,1,10)+'1'+Copy(Edit2.Text,12,length(Edit2.Text))
  else
       Edit2.Text := Copy(Edit2.Text,1,10)+'0'+Copy(Edit2.Text,12,length(Edit2.Text));

  If CheckGroup1.Checked[7] = true then
       Edit2.Text := Copy(Edit2.Text,1,11)+'1'+Copy(Edit2.Text,13,length(Edit2.Text))
  else
       Edit2.Text := Copy(Edit2.Text,1,11)+'0'+Copy(Edit2.Text,13,length(Edit2.Text));

 end;
end;



{$R *.lfm}

end.

