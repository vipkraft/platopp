unit pdp_destination_points;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, platproc, ExtCtrls, EditBtn,
  Calendar, ExtDlgs, MaskEdit, LazUtf8;

type

  { TForm29 }

  TForm29 = class(TForm)
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Splitter1: TSplitter;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: char);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid1ValidateEntry(sender: TObject; aCol, aRow: Integer;
      const OldValue: string; var NewValue: String);
    procedure UpdateGrid1(filter_type:byte; stroka:string); //грид остановочных
    procedure UpdateGrid2(filter_type:byte; stroka:string); //ОБНОВИТЬ ГРИД реестра
    procedure save(currow:word);
  private
    { private declarations }
    formActivated: boolean;
  public
    { public declarations }
  end; 


//  type TGridRect = record
//case Integer of
//0: (Left, Top, Right, Bottom: Longint);
//1: (TopLeft, BottomRight: TGridCoord);
// end;


var
  Form29: TForm29;
  fl_edit_dog: byte;



implementation
uses
  mainopp;

{$R *.lfm}
var
   n: integer;
   kontrID : string;
   rep_count:integer=1;
   //datatyp : byte=0;
   changeFlag:boolean = false;

{ TForm29 }

//***********************************  ОБНОВИТЬ ГРИД реестра **************************************************
procedure TForm29.UpdateGrid2(filter_type:byte; stroka:string);
 var
   n,m:integer;
   //orderby,sstr,stp,sal,stmp : string;
 begin
   with Form29 do
   begin
   Panel1.Visible:=true;
   application.ProcessMessages;
   Stringgrid2.RowCount:=1;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

  // Запрос маршрутов и расписаний
  ZQuery1.SQL.clear;
  ZQuery1.SQL.add('SELECT dname, idek, adddate, location ');
  ZQuery1.SQL.add('  FROM av_spr_destination ');
  ZQuery1.SQL.add('WHERE 1=1 ');
   if (stroka<>'') and (filter_type=1) then
      ZQuery1.SQL.add('and (idek like '+quotedstr('%'+stroka)+') ORDER BY idek;');
   if (stroka<>'') and (filter_type=2) then
      ZQuery1.SQL.add('and (dname ilike '+quotedstr('%'+stroka+'%')+') ORDER BY dname;');
  //-конец запроса :-)
  //showmessage(ZQuery1.SQL.Text);//;$
  try
   ZQuery1.open;
  except
    Panel1.Visible:=false;
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;

  Panel1.Visible:=false;
   if ZQuery1.RecordCount=0 then
      begin
        ZQuery1.close;
        ZConnection1.Disconnect;
        exit;
      end;

   //'Найдено всего: '+
   label9.Caption:=inttostr(ZQuery1.RecordCount);


   for n:=1 to ZQuery1.RecordCount do
    begin
      Stringgrid2.RowCount:= Stringgrid2.RowCount+1;
      StringGrid2.Cells[0,n]:=trim(ZQuery1.FieldByName('dname').asString); //наименование
      StringGrid2.Cells[1,n]:=trim(ZQuery1.FieldByName('idek').asString); //id
      StringGrid2.Cells[2,n]:=trim(ZQuery1.FieldByName('location').asString); //район
      StringGrid2.Cells[3,n]:=trim(ZQuery1.FieldByName('adddate').asString); //дата добавления
      ZQuery1.Next;
    end;

   //StringGrid1.Repaint;
   ZQuery1.Close;
   Zconnection1.disconnect;
  end;
end;




//***********************************  ОБНОВИТЬ ДАННЫЕ НА ГРИДЕ **************************************************
procedure TForm29.UpdateGrid1(filter_type:byte; stroka:string);
 var
   n,m,cnt:integer;
   orderby,sstr,stp,sal,stmp : string;
 begin
   with Form29 do
   begin

   Panel1.Visible:=true;
   application.ProcessMessages;
   Stringgrid1.RowCount:=1;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   stmp:='';
  // Запрос маршрутов и расписаний
  ZQuery1.SQL.clear;
  ZQuery1.SQL.add('SELECT *, count(*) over (partition by iddest) as cnt  FROM ');
  ZQuery1.SQL.add('(select a.id,a.name  ');
  ZQuery1.SQL.add(',(select b.id_dest from av_pdp_dest_point b where b.del=0 and b.id_point=a.id order by b.createdate desc limit 1) iddest ');
  ZQuery1.SQL.add(',(select b.rajon from av_spr_locality b where b.id=a.kod_locality order by del asc,createdate desc limit 1) as rajon ');
  ZQuery1.SQL.add(',(select b.region from av_spr_locality b where b.id=a.kod_locality order by del asc,createdate desc limit 1) as region ');
  ZQuery1.SQL.add('from av_spr_point a ');
  ZQuery1.SQL.add('where a.del=0 ');
  ZQuery1.SQL.add(') z ');
  ZQuery1.SQL.add('WHERE 1=1 ');
   if (stroka<>'') and (filter_type=1) then
      ZQuery1.SQL.add('and ((z.id='+stroka+') OR (z.iddest='+stroka+')) ORDER BY z.id;');
   if (stroka<>'') and (filter_type=2) then
      ZQuery1.SQL.add('and ((z.name ilike '+quotedstr(stroka+'%')+')) ORDER BY z.name;');
  //-конец запроса :-)
  //showmessage(ZQuery1.SQL.Text);//;$
  try
   ZQuery1.open;
  except
    Panel1.Visible:=false;
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;

  Panel1.Visible:=false;

   if ZQuery1.RecordCount=0 then
      begin
        ZQuery1.close;
        ZConnection1.Disconnect;
        exit;
      end;

   //'Найдено всего: '+
   label5.Caption:=inttostr(ZQuery1.RecordCount);
   cnt:=0;

   for n:=1 to ZQuery1.RecordCount do
    begin
      If ZQuery1.FieldByName('cnt').AsInteger>cnt then
         cnt:=ZQuery1.FieldByName('cnt').AsInteger;
      Stringgrid1.RowCount:= Stringgrid1.RowCount+1;
      StringGrid1.Cells[0,n]:=trim(ZQuery1.FieldByName('id').asString); //id
      StringGrid1.Cells[1,n]:=trim(ZQuery1.FieldByName('name').asString); //наименование
      StringGrid1.Cells[2,n]:=trim(ZQuery1.FieldByName('iddest').asString); //код реестра
      StringGrid1.Cells[3,n]:=trim(ZQuery1.FieldByName('rajon').asString); //район
      StringGrid1.Cells[4,n]:=trim(ZQuery1.FieldByName('region').asString); //регион
      StringGrid1.Cells[5,n]:='';
      ZQuery1.Next;
    end;

   //StringGrid1.Repaint;
   ZQuery1.Close;
   Zconnection1.disconnect;
   //StringGrid1.Refresh;
   Label7.Caption:=inttostr(cnt);
  end;
end;

procedure TForm29.save(currow:word);
begin
with Form29 do
   begin
    If currow<1 then exit;
    //showmessage('Готов');
       //Stringgrid1.Cells[6,1]:='0';
   //If Stringgrid1.Focused=false then exit;

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
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_pdp_dest_point SET del=1, createdate=now(), id_user='+inttostr(id_user));
       ZQuery1.SQL.add(' WHERE del=0 and id_point='+Stringgrid1.Cells[0,currow]+';');
       //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.ExecSQL;


       //создание записи
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('INSERT INTO av_pdp_dest_point(id_point, id_dest, createdate_first, id_user_first, createdate, id_user, del) VALUES (');
       ZQuery1.SQL.add(Stringgrid1.Cells[0,currow]+','+Stringgrid1.Cells[2,currow]+',now(),'+inttostr(id_user)+',now(),'+inttostr(id_user)+',0);');
       //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.ExecSQL;
 //Завершение транзакции
    Zconnection1.Commit;

   except
     If ZConnection1.InTransaction then Zconnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
     exit;
   end;
   //ZQuery1.Close;
   //Zconnection1.disconnect;

   ZQuery1.Close;
   ZConnection1.Disconnect;

   Stringgrid1.Cells[5,currow]:='';
   changeFlag:=false;
   end;
end;


procedure TForm29.StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  //'!' = delete leading blanks. '0' = position must be a number.
  //'1' = keep formatting symbols. '_' =  trailing '0'.
  //Does not limit fields to 23:59:59.
  //Use ValidateEntry and Copy()to check and change each character as the cell is exited.
  if (ARow > 0) and (ACol = 2) then
    Value := '!99999!;0; ';
end;

procedure TForm29.StringGrid1KeyPress(Sender: TObject; var Key: char);
begin
    if (Key=chr(38)) then
   Form29.Stringgrid1.Row:= Form29.Stringgrid1.Row+1;
 if (Key=chr(40)) then
   Form29.Stringgrid1.Row:= Form29.Stringgrid1.Row-1;
end;

procedure TForm29.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
    Form29.Stringgrid1.Cells[5,aRow]:=inttostr(ARow);
    //edit4.Text:= 'SetEditText' +'|'+Value+'|';
end;

procedure TForm29.StringGrid1ValidateEntry(sender: TObject; aCol,
  aRow: Integer; const OldValue: string; var NewValue: String);
begin
//если произошло изменение значения
  If OldValue<>StringReplace(NewValue,#32,'',[rfReplaceAll, rfIgnoreCase]) then
   begin
     changeFlag:=true;
     form29.save(aRow);
   end
  else  Form29.Stringgrid1.Cells[5,aRow]:='';
end;

procedure TForm29.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key=38) then
   Form29.Stringgrid1.Row:= Form29.Stringgrid1.Row+1;
 if (Key=40) then
   Form29.Stringgrid1.Row:= Form29.Stringgrid1.Row-1;
  //((Key>47) and (Key<58)) or ((Key>95) and (Key<106)) or
  //(Key=8) or (key=46) then
  //  begin
  //    If Form29.Stringgrid1.Col=2 then
  //  begin
  //   currow:=Form29.Stringgrid1.Row;
  //   Form29.Stringgrid1.Cells[5,currow]:='*';
  //  end;
  //  end;
end;


//***********************************************       ВЫХОД     **********************************************************
procedure TForm29.BitBtn4Click(Sender: TObject);
begin
  Form29.Close;
end;

procedure TForm29.Edit1Change(Sender: TObject);
var
 n:integer=0;
 ss:string;
 datatyp:integer;
begin
   datatyp:=0;
  with Form29 do
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
         Edit2.text := ss; //дублируем на EDIT2 второй справочник
         application.ProcessMessages;
         break;
       end;
      datatyp:=1;
        end;

      updategrid1(datatyp,ss);
    end
  else
   begin
    updategrid1(0,'');
    //Edit1.Visible:=false;
    Stringgrid1.SetFocus;
   end;
end;
end;

procedure TForm29.Edit2Change(Sender: TObject);
  var
 n:integer=0;
 ss:string;
 datatyp:integer;
begin
   datatyp:=0;
  with Form29 do
  begin
     ss:=trimleft(Edit2.Text);
     Edit2.text := ss;
  if UTF8Length(ss)>0 then
     begin
      for n:=1 to UTF8Length(ss) do
       begin
       //определяем тип данных для поиска
        if (ss[n] in ['0'..'9']) then
        begin
         datatyp:=1;
         continue;
         end
       else
         begin
           datatyp:=2;
           break;
         end;
       end;
      updategrid2(datatyp,ss);
    end
  else
   begin
    updategrid2(0,'');
    //Edit1.Visible:=false;
    Stringgrid2.SetFocus;
   end;
end;
end;


procedure TForm29.Edit1Enter(Sender: TObject);
begin
   form29.Edit1.SelectAll;
end;

procedure TForm29.Edit1KeyPress(Sender: TObject; var Key: char);
begin

end;


procedure TForm29.Edit2Enter(Sender: TObject);
begin
    form29.Edit2.SelectAll;
end;



procedure TForm29.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
with Form29 do
   begin
//showmessage(
 If changeFlag then
 begin
   if MessageDlg('Внимание !!!', 'Есть несохраненные изменения'+#13+'Продолжить выход?', mtConfirmation, [mbYes, mbNo],0) = mrNo
  then
   CloseAction := caNone;

  end;
  end;
end;


//************************************************* HOTKEYS ********************************************************************
procedure TForm29.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   res:integer;
begin
    with Form29 do
  begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ESC] - Отмена\Выход');

    // ESC
    if Key=27 then
        begin
            If (dialogs.MessageDlg('Выйти из справочника ?',mtConfirmation,[mbYes,mbNO], 0)= mrYes) then
        begin
          Form29.Close;
          exit;
        end;
        end;

      //поле поиска
  If Edit1.focused then
    begin
    // ESC поиск // Вверх по списку   // Вниз по списку
     If key=27 then
        begin
          Edit1.text := '';
          updategrid1(0,'');
          StringGrid1.SetFocus;
          StringGrid1.Col:=2;
          key:=0;
          exit;
      end;

     if (Key=38) OR (Key=40) then
     begin
       //Edit1.Visible:=false;
       StringGrid1.SetFocus;
       StringGrid1.Col:=2;
       //key:=0;
       exit;
     end;
     // ENTER - остановить контекстный поиск
     if (Key=13) then
     begin
       StringGrid1.SetFocus;
       StringGrid1.Col:=2;
       key:=0;
       exit;
     end;
    end;

  //If StringGrid1.focused then
  //  begin
  //     StringGrid1.Col:=2;
  //  end;

  //поле поиска Edit2
  If Edit2.focused then
    begin
    // ESC поиск // Вверх по списку   // Вниз по списку
     If key=27 then
        begin
          Edit2.text := '';
          updategrid2(0,'');
          StringGrid2.SetFocus;
          key:=0;
          exit;
      end;
     if (Key=38) OR (Key=40) then
        begin
       //Edit1.Visible:=false;
       StringGrid2.SetFocus;
       //key:=0;
       exit;
        end;
      // ENTER - остановить контекстный поиск
   if (Key=13) then
     begin
       StringGrid2.SetFocus;
       key:=0;
       exit;
     end;
    end;

 if (stringgrid1.Focused) then
     begin
       //up
      if (Key=38) then
       Form29.Stringgrid1.Row:= Form29.Stringgrid1.Row-1;
      if (Key=40) or (Key=13) then //down
       Form29.Stringgrid1.Row:= Form29.Stringgrid1.Row+1;
     end;
       // Контекcтный поиск
   if (stringgrid2.Focused) then
     begin
       If (get_type_char(key)>0) or (key=8) or (key=46) or (key=96) then //8-backspace 46-delete 96- numpad 0
       begin
         //Edit1.text:='';
         //Edit1.Visible:=true;
         Edit2.SetFocus;
       end;
     end;
      if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=120) or (Key=27)
//      or (Key=13)
      then Key:=0;
      end;
end;


//***********************************   ОТРИСОВКА ГРИДА ****************************************************
//procedure TForm29.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
//  aRect: TRect; aState: TGridDrawState);
//var
//    cBrush,cFont,cFontOther,cDefault,cAl,cPen: TColor;
//begin
 //  cBrush:=clMenuHighLight;
 //  cFont:=clBlack;
 //  cAl := $000505A8;
 //  cFontOther := clNavy;//$006868DE;
 //  cDefault := clCream;
 //  cPen := clBlue;
 //with Sender as TStringGrid,Canvas do
 // begin
 //      Brush.Color:=clWhite;
 //      //Закрашиваем бэкграунд
 //      FillRect(aRect);
 //    if (gdSelected in aState) then
 //          begin
 //           pen.Width:=6;
 //           pen.Color:=cPen;
 //           MoveTo(aRect.left,aRect.bottom-1);
 //           LineTo(aRect.right,aRect.Bottom-1);
 //           MoveTo(aRect.left,aRect.top-1);
 //           LineTo(aRect.right,aRect.Top);
 //           Font.Color := cFontOther;
 //           font.Size:=12;
 //           font.Style:= [];
 //          end
 //        else
 //         begin
 //           font.Style:= [];
 //           Font.Color := cFont;
 //           font.Size:=12;
 //         end;
 //
 //    //Остальные поля
 // if (ARow > 0) then
 // begin
 //   TextOut(aRect.Left+10, aRect.Top+5, Cells[ACol, ARow]);
 // end;
 //
 // // Заголовок
 // if aRow=0 then
 //        begin
 //          Brush.Color:=cDefault;
 //          FillRect(aRect);
 //          Font.Color := cFont;
 //          font.Size:=10;
 //          TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
 //         end;
 //end;

//end;



//procedure TForm29.StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
//  var Value: string);
//begin
//    if (ARow > 0) and ((ACol = 1) or (ACol = 2)) then
//        Value := '!00/00/0000;1;_';
//end;

//procedure TForm29.StringGrid1KeyPress(Sender: TObject; var Key: char);
//begin
//  If Form29.StringGrid1.Col>0 then
//   Form29.StringGrid1.Cells[8,Form29.StringGrid1.Row]:='*';
//end;

//procedure TForm29.StringGrid1PickListSelect(Sender: TObject);
//begin
//    Form29.StringGrid1.Cells[8,Form29.StringGrid1.Row]:='*';
//end;

//procedure TForm29.StringGrid1SelectEditor(Sender: TObject; aCol, aRow: Integer;
//  var Editor: TWinControl);
//begin
  // if aCol=3 then begin
  //  if (Editor is TCustomComboBox) then
  //    with Editor as TCustomComboBox do begin
  //      if (aRow mod 2=0) then
  //        Style := csDropDown
  //      else
  //        Style := csDropDownList;
  //      case aRow of
  //        1:
  //          Items.CommaText := 'ONE,TWO,THREE,FOUR';
  //        2:
  //          Items.CommaText := 'A,B,C,D,E';
  //        3:
  //          Items.CommaText := 'MX,ES,NL,UK';
  //        4:
  //          Items.CommaText := 'RED,GREEN,BLUE,YELLOW';
  //      end;
  //    end;
  //end;
//end;

//procedure TForm29.StringGrid1ValidateEntry(sender: TObject; aCol,
//  aRow: Integer; const OldValue: string; var NewValue: String);
//begin
//   //Constrain to '23:59:59'.
//  //This only takes effect on leaving cell.
//  if (aRow > 0) and ((aCol = 1) or (aCol = 2)) then
//  begin
//      If Copy(NewValue, 1, 2)>'31' then
//    begin
//       NewValue[1] := '3';
//       NewValue[2] := '0';
//       end;
//    If Copy(NewValue, 4, 2)>'12' then
//    begin
//       NewValue[4] := '1';
//       NewValue[5] := '2';
//       end;
//
//    if Copy(NewValue, 7, 1)<>'2' then
//      NewValue[7] := '2';
//    if Copy(NewValue, 8, 1)<> '0' then
//      NewValue[8] := '0';
//    //if Copy(NewValue, 4, 1) > '5' then
//      //NewValue[4] := '5';
//    //if Copy(NewValue, 7, 1) > '5' then
//      //NewValue[7] := '5';
//  end;
//end;


//procedure TForm29.StringGrid1ButtonClick(Sender: TObject; aCol, aRow: Integer);
//var
//   datebefore:Tdate;
//begin
//
//   if (aCol = 10) then  //ButtonColumn
//  begin
//    StringGrid1.Options := StringGrid1.Options - [goEditing];
//    //store as string
//    StringGrid1.Cells[aCol, aRow] := 'Запуск...';//+IntToStr(aRow);
//    //StringGrid1.Options := StringGrid1.Options + [goEditing]; //Turn cell editing back on
//    rep();
//  end;
//    if (aCol = 1) or (aCol = 2)  then
//  begin
//    try
//     datebefore:=strtodate(StringGrid1.cells[aCol,aRow]);
//     StringGrid1.cells[aCol,aRow]:=datetostr(date);
//    except
//        datebefore:=date();
//      end;
//     CalendarDialog1.Date:= datebefore;
//
//    If CalendarDialog1.Execute then
//    begin
//      StringGrid1.Cells[aCol, aRow] := Datetostr(Form29.CalendarDialog1.Date);
//    end;
//    If datebefore<>CalendarDialog1.Date then
//        Form29.StringGrid1.Cells[8,Form29.StringGrid1.Row]:='*';
//  end;
//end;

//procedure TForm29.StringGrid1CheckboxToggled(sender: TObject; aCol,
//  aRow: Integer; aState: TCheckboxState);
//begin
//   Form29.StringGrid1.Cells[8,Form29.StringGrid1.Row]:='*';
//end;


procedure TForm29.FormActivate(Sender: TObject);
begin
  if not FormActivated then begin
    FormActivated := True;

     UpdateGrid1(0,'');
     Edit1.SetFocus;
     //UpdateGrid2(0,'');
  end;
end;

// **************************************  ВОЗНИКНОВЕНИЕ ФОРМЫ ****************************************
procedure TForm29.FormShow(Sender: TObject);
begin
  with Form29 do
     begin
//Centrform(Form29);
//Form29.StringGrid1.RowHeights[0]:=30;
//Form29.Label3.Caption:=formsk.StringGrid1.Cells[2,formsk.StringGrid1.Row];
//определить уровень доступа
  if flag_access=1 then
   begin

      //BitBtn1.Enabled:=false;
      //BitBtn2.Enabled:=false;
      //BitBtn3.Enabled:=false;
     end;


 //Stringgrid1.Row:=1;
 //Stringgrid1.SetFocus;
end;
end;


end.

