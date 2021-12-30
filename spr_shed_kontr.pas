unit spr_shed_kontr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, platproc, ExtCtrls, EditBtn,
  Calendar, ExtDlgs, LazUtf8;

type

  { TForm28 }

  TForm28 = class(TForm)
    BitBtn4: TBitBtn;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UpdateGrid(filter_type:byte; stroka:string);
    procedure save();
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
  Form28: TForm28;
  fl_edit_dog: byte;



implementation
uses
  mainopp;

{$R *.lfm}
var
   n,currow: integer;
   kontrID : string;
   rep_count:integer=1;
   datatyp : byte=0;

{ TForm28 }

//***********************************  ОБНОВИТЬ ДАННЫЕ НА ГРИДЕ **************************************************
procedure TForm28.UpdateGrid(filter_type:byte; stroka:string);
 var
   n,m,cnt:integer;
   orderby,sstr,stp,sal,stmp : string;
 begin
   with FOrm28 do
   begin

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
  ZQuery1.SQL.add('Select Distinct z.* ');
  ZQuery1.SQL.add(',count(*) over (partition by reestr) as cnt ');
  ZQuery1.SQL.add('FROM ( ');
  ZQuery1.SQL.add('SELECT ');
  ZQuery1.SQL.add('a.id,a.name_shedule,a.active ');
  ZQuery1.SQL.add(',coalesce((SELECT b.type_route from av_route AS b WHERE a.id_route=b.id ORDER BY b.del ASC, b.createdate DESC limit 1),0) as type_route ');
  ZQuery1.SQL.add(',coalesce((SELECT 1 FROM av_shedule_fio    WHERE del=0 AND a.id=id_shedule LIMIT 1),0) as personal ');
  ZQuery1.SQL.add(',c.id_kontr ');
  ZQuery1.SQL.add(',(select b.name from av_spr_kontragent b where b.id=c.id_kontr order by b.del asc, b.createdate desc limit 1) pname ');
  ZQuery1.SQL.add(',c.reestr, c.def_ats ');
  ZQuery1.SQL.add('FROM av_shedule AS a, av_shedule_atp c ');
  ZQuery1.SQL.add('WHERE a.del=0 AND a.datepo>current_date ');
  if Checkbox1.Checked then
    ZQuery1.SQL.add(' and a.active=1 ');
  ZQuery1.SQL.add('AND c.del=0 and c.id_shedule=a.id ');
  ZQuery1.SQL.add(') z ');
  ZQuery1.SQL.add('WHERE z.type_route=2 ');
   if (stroka<>'') and (filter_type=1) then
      ZQuery1.SQL.add('and ((id='+stroka+') OR (id_kontr='+stroka+'))');
   if (stroka<>'') and (filter_type=2) then
      ZQuery1.SQL.add('and ((pname ilike '+quotedstr(stroka+'%')+') OR (reestr ilike '+quotedstr(stroka+'%')+') OR (name_shedule ilike '+quotedstr(stroka+'%')+'))');
  ZQuery1.SQL.add(' and z.personal=1 ');
  ZQuery1.SQL.add(' ORDER BY name_shedule,pname');
  //-конец запроса :-)
  //showmessage(ZQuery1.SQL.Text);//;$
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;

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
      //Маршруты
   //   m_route[n,0]:=trim(ZQuery1.FieldByName('id_route').asString); //id маршрута
      //StringGrid1.Cells[0,n]:=trim(ZQuery1.FieldByName('kod_route').asString); //код маршрута

      //if ZQuery1.FieldByName('type_route').asInteger=0 then m_route[n,3]:=cMezhgorod;
      //if ZQuery1.FieldByName('type_route').asInteger=1 then m_route[n,3]:=cPrigorod;
      //if ZQuery1.FieldByName('type_route').asInteger=2 then m_route[n,3]:=cKray;
      //if ZQuery1.FieldByName('type_route').asInteger=3 then m_route[n,3]:=cGos;
      //m_route[n,5]:=trim(ZQuery1.FieldByName('active').asString); //Тип 0-неактивно,1-активно
      //Расписания
      StringGrid1.Cells[0,n]:=trim(ZQuery1.FieldByName('id').asString); //id расписания
      //StringGrid1.Cells[0,n]:=trim(ZQuery1.FieldByName('name_route').asString); //наименование маршрута
      //m_route[n,7]:=trim(ZQuery1.FieldByName('kod').asString); //код расписания
      StringGrid1.Cells[1,n]:=trim(ZQuery1.FieldByName('name_shedule').asString); //наименование расписания
      StringGrid1.Cells[2,n]:=trim(ZQuery1.FieldByName('id_kontr').asString); //перевозчик
      StringGrid1.Cells[3,n]:=trim(ZQuery1.FieldByName('pname').asString);    //перевозчик имя
      StringGrid1.Cells[4,n]:=trim(ZQuery1.FieldByName('reestr').asString); //номер в реестре
      StringGrid1.Cells[5,n]:=trim(ZQuery1.FieldByName('def_ats').asString); //номер в реестре
      StringGrid1.Cells[6,n]:='';
      ZQuery1.Next;
    end;

   //StringGrid1.Repaint;
   ZQuery1.Close;
   Zconnection1.disconnect;
   //StringGrid1.Refresh;
   Label7.Caption:=inttostr(cnt);
  end;
end;

procedure TForm28.save();
begin
with Form28 do
   begin
    If currow<1 then exit;
       //Stringgrid1.Cells[6,1]:='0';
   //If Stringgrid1.Focused=false then exit;
   If utf8length(Stringgrid1.Cells[4,currow])>20 then
        Stringgrid1.Cells[4,currow]:=utf8copy(Stringgrid1.Cells[4,currow],1,20);

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
       ZQuery1.SQL.add('UPDATE av_shedule_atp SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE del=0 and id_kontr='+Stringgrid1.Cells[2,currow]+' and id_shedule='+Stringgrid1.Cells[0,currow]+';'); //  +' and id_kontr='+kontrID+' and del=0;');
       //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.ExecSQL;


       //создание записи
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('INSERT INTO av_shedule_atp(id_kontr,def_ats,id_shedule,reestr,createdate,id_user,createdate_first,id_user_first,del) VALUES (');

       ZQuery1.SQL.add(Stringgrid1.Cells[2,currow]+','+Stringgrid1.Cells[5,currow]+','+Stringgrid1.Cells[0,currow]+','+Quotedstr(Stringgrid1.Cells[4,currow]));

       ZQuery1.SQL.add(',now(),'+inttostr(id_user)+',now(),'+inttostr(id_user)+',0);');

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

   Stringgrid1.Cells[6,currow]:='';
   currow:=-1;
   end;
end;


//--сохранение результатов редактирования
procedure TForm28.StringGrid1EditingDone(Sender: TObject);
begin
    form28.save();
end;

procedure TForm28.StringGrid1Enter(Sender: TObject);
begin
   Edit1.Visible:=false;
end;

procedure TForm28.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    currow:=-1;
  If form28.Stringgrid1.Col=4 then
    begin
     currow:=form28.Stringgrid1.Row;
     form28.Stringgrid1.Cells[6,currow]:='*';
    //Stringgrid1.Cells[6,1]:='*';
    end;
end;




//***********************************************       ВЫХОД     **********************************************************
procedure TForm28.BitBtn4Click(Sender: TObject);
begin
  Form28.Close;
end;

procedure TForm28.CheckBox1Change(Sender: TObject);
begin
    UpdateGrid(datatyp,'');
    Stringgrid1.Row:=1;
    Stringgrid1.SetFocus;
end;

procedure TForm28.Edit1Change(Sender: TObject);
var
 n:integer=0;
 ss:string;
begin
  with Form28 do
  begin
     ss:=trimleft(Edit1.Text);
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

procedure TForm28.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
with form28 do
   begin
//showmessage(
  If (currow>0) and (Stringgrid1.Cells[6,currow]='*') then
  begin
    label5.Caption:=inttostr(currow);
    Stringgrid1.SetFocus;
    Stringgrid1.Row:=1;
    label7.Caption:=inttostr(currow);
  //Stringgrid1.Selection := tgridrect(rect(0,0,0,0));
   CloseAction := caNone;
  //form28.StringGrid1.SetFocus;
  form28.save();
  end;
  end;

end;


//************************************************* HOTKEYS ********************************************************************
procedure TForm28.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   res:integer;
begin
    with Form28 do
  begin
      //поле поиска
  If Edit1.Visible then
    begin
    // ESC поиск // Вверх по списку   // Вниз по списку
     If key=27 then
        begin
          datatyp:= 0;
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
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ESC] - Отмена\Выход');

    // ESC
    if Key=27 then BitBtn4.Click;

       // Контекcтный поиск
   if (Edit1.Visible=false) AND (stringgrid1.Focused) and (stringgrid1.Col<>4) then
     begin
       If (get_type_char(key)>0) or (key=8) or (key=46) or (key=96) then //8-backspace 46-delete 96- numpad 0
       begin
         Edit1.text:='';
         Edit1.Visible:=true;
         Edit1.SetFocus;
       end;
     end;
      if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=120) or (Key=27) or (Key=13)  then Key:=0;
      end;
end;


//***********************************   ОТРИСОВКА ГРИДА ****************************************************
//procedure TForm28.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
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



//procedure TForm28.StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
//  var Value: string);
//begin
//    if (ARow > 0) and ((ACol = 1) or (ACol = 2)) then
//        Value := '!00/00/0000;1;_';
//end;

//procedure TForm28.StringGrid1KeyPress(Sender: TObject; var Key: char);
//begin
//  If Form28.StringGrid1.Col>0 then
//   Form28.StringGrid1.Cells[8,Form28.StringGrid1.Row]:='*';
//end;

//procedure TForm28.StringGrid1PickListSelect(Sender: TObject);
//begin
//    Form28.StringGrid1.Cells[8,Form28.StringGrid1.Row]:='*';
//end;

//procedure TForm28.StringGrid1SelectEditor(Sender: TObject; aCol, aRow: Integer;
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

//procedure TForm28.StringGrid1ValidateEntry(sender: TObject; aCol,
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


//procedure TForm28.StringGrid1ButtonClick(Sender: TObject; aCol, aRow: Integer);
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
//      StringGrid1.Cells[aCol, aRow] := Datetostr(Form28.CalendarDialog1.Date);
//    end;
//    If datebefore<>CalendarDialog1.Date then
//        Form28.StringGrid1.Cells[8,Form28.StringGrid1.Row]:='*';
//  end;
//end;

//procedure TForm28.StringGrid1CheckboxToggled(sender: TObject; aCol,
//  aRow: Integer; aState: TCheckboxState);
//begin
//   Form28.StringGrid1.Cells[8,Form28.StringGrid1.Row]:='*';
//end;

procedure TForm28.FormActivate(Sender: TObject);
begin
  if not FormActivated then begin
    FormActivated := True;
     UpdateGrid(datatyp,'');
     Stringgrid1.Row:=1;
     Stringgrid1.SetFocus;
  end;
end;

end.

