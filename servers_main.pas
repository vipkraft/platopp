unit servers_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls, platproc, report_main, LazUtf8;

type

  { TForm_servers }

  TForm_servers = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Image3: TImage;
    ImageList1: TImageList;
    Label2: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form_servers: TForm_servers;
  flag_edit_point:integer;
  result_srv_id, result_srv_name:string;

implementation
uses
  mainopp;
{$R *.lfm}

{ TForm_servers }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

 procedure TForm_servers.UpdateGrid(filter_type:byte; stroka:string);
 var
   n:integer;
begin
  //  with Form_servers do
  //  begin
  // // Подключаемся к серверу
  // If not(Connect2(Zconnection1, flagProfile)) then
  //   begin
  //    showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
  //    Close;
  //    exit;
  //   end;
  // //запрос списка
  // ZQuery1.SQL.Clear;
  // ZQuery1.SQL.add('SELECT a.id,a.active,a.activedate,a.usetarif,a.point_id,a.ip,a.ip2,a.info,a.del,b.name  FROM av_servers a ');
  // ZQuery1.SQL.add('LEFT JOIN av_spr_point b ON b.del=0 AND b.id=a.point_id ');
  // //Выбирать удаленных или нет
  // If not(CheckBox1.Checked) then  ZQuery1.SQL.add('WHERE a.del=0 ');
  // ZQuery1.SQL.add('ORDER BY b.name; ');
  ////showmessage(ZQuery1.SQL.text);
  //try
  // ZQuery1.open;
  //except
  //  showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
  //  ZQuery1.Close;
  //  Zconnection1.disconnect;
  //end;
  //
  // if Form_servers.ZQuery1.RecordCount=0 then
  //   begin
  //    Form_servers.ZQuery1.Close;
  //    Form_servers.Zconnection1.disconnect;
  //    exit;
  //   end;
  // // Заполняем stringgrid
  // StringGrid1.RowCount:=ZQuery1.RecordCount+1;
  // for n:=1 to ZQuery1.RecordCount do
  //  begin
  //    StringGrid1.Cells[0,n]:=ZQuery1.FieldByName('id').asString;
  //    StringGrid1.Cells[1,n]:=ZQuery1.FieldByName('name').asString;
  //    StringGrid1.Cells[2,n]:=ZQuery1.FieldByName('active').asString;
  //    StringGrid1.Cells[3,n]:=ZQuery1.FieldByName('activedate').asString;
  //    StringGrid1.Cells[4,n]:=ZQuery1.FieldByName('usetarif').asString;
  //    StringGrid1.Cells[5,n]:=ZQuery1.FieldByName('ip').asString;
  //    StringGrid1.Cells[6,n]:=ZQuery1.FieldByName('ip2').asString;
  //    StringGrid1.Cells[7,n]:=ZQuery1.FieldByName('info').asString;
  //    StringGrid1.Cells[8,n]:=ZQuery1.FieldByName('del').asString;
  //    ZQuery1.Next;
  //  end;
  // Form_servers.ZQuery1.Close;
  // Form_servers.Zconnection1.disconnect;
  //// Form_servers.StringGrid1.Refresh;
  //// Form_servers.StringGrid1.SetFocus;
  // end;

  with Form_servers do
    begin
      StringGrid1.RowCount:=1;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT a.id,a.active,a.activedate,a.usetarif,a.point_id,a.ip,a.ip2,a.info,a.del,b.name  FROM av_servers a ');
   ZQuery1.SQL.add('LEFT JOIN av_spr_point b ON b.del=0 AND b.id=a.point_id where a.id=a.id ');

   if (stroka<>'') and (filter_type=2) then ZQuery1.SQL.add('and b.name ilike '+quotedstr(stroka+'%'));
   if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('and cast(a.id as text) like '+quotedstr(stroka+'%'));

   //Выбирать удаленных или нет
   If not(CheckBox1.Checked) then  ZQuery1.SQL.add('and a.del=0 ');
   ZQuery1.SQL.add('ORDER BY b.name; ');
  //showmessage(ZQuery1.SQL.text);
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;

   if Form_servers.ZQuery1.RecordCount=0 then
     begin
      Form_servers.ZQuery1.Close;
      Form_servers.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   StringGrid1.RowCount:=ZQuery1.RecordCount+1;
   for n:=1 to ZQuery1.RecordCount do
    begin
      StringGrid1.Cells[0,n]:=ZQuery1.FieldByName('id').asString;
      StringGrid1.Cells[1,n]:=ZQuery1.FieldByName('name').asString;
      StringGrid1.Cells[2,n]:=ZQuery1.FieldByName('active').asString;
      StringGrid1.Cells[3,n]:=ZQuery1.FieldByName('activedate').asString;
      StringGrid1.Cells[4,n]:=ZQuery1.FieldByName('usetarif').asString;
      StringGrid1.Cells[5,n]:=ZQuery1.FieldByName('ip').asString;
      StringGrid1.Cells[6,n]:=ZQuery1.FieldByName('ip2').asString;
      StringGrid1.Cells[7,n]:=ZQuery1.FieldByName('info').asString;
      StringGrid1.Cells[8,n]:=ZQuery1.FieldByName('del').asString;
      ZQuery1.Next;
    end;
   Form_servers.ZQuery1.Close;
   Form_servers.Zconnection1.disconnect;
   Form_servers.StringGrid1.Refresh;
  // Form_servers.StringGrid1.SetFocus;
   end;

end;

procedure TForm_servers.ToolButton8Click(Sender: TObject);
begin
    GridPoisk(Form_servers.StringGrid1,Form_servers.Edit1);
end;

procedure TForm_servers.ToolButton1Click(Sender: TObject);
begin
   SortGrid(StringGrid1,StringGrid1.col,ProgressBar1,0,1);
end;

// выход
procedure TForm_servers.BitBtn3Click(Sender: TObject);
begin
  result_srv_id:='';
  result_srv_name:='';
  Form_servers.Close;
end;

procedure TForm_servers.Edit1Change(Sender: TObject);
var
   n:integer=0;
 begin
   with form_servers do
 begin
   ss:=trimleft(Edit1.Text);
   if UTF8Length(ss)>0 then
        begin
          //определяем тип данных для поиска
        if (ss[1] in ['0'..'9']) then datatyp:=1
        else datatyp:=2;

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

// выбрать
procedure TForm_servers.BitBtn2Click(Sender: TObject);
var
  i: integer;
begin
  // проверки *--------------
  with Form_servers.StringGrid1 do
  begin
  If (trim(Cells[1,Row])='') or (trim(Cells[2,Row])='') then
    begin
     showmessagealt('Сначала выберите подразделение !');
     exit;
    end;
  //---------------------------------------------------
  end;
   result_srv_id:= Form_servers.StringGrid1.Cells[0,Form_servers.StringGrid1.row];
   result_srv_name:= Form_servers.stringgrid1.cells[1,Form_servers.StringGrid1.Row];
  //заполняем доступные значения в массив переменных отчета (таблица report_vars)
  for i:=Low(ar_report) to High(ar_report) do
      begin
       If trim(ar_report[i,0]) = 'server_id'  then ar_report[i,2]:= result_srv_id;
       If trim(ar_report[i,0]) = 'server_name' then ar_report[i,2]:= result_srv_name;
      end;

   Form_servers.close;
end;

// обновить
procedure TForm_servers.BitBtn1Click(Sender: TObject);
begin
  Form_servers.UpdateGrid(datatyp,'');
end;

procedure TForm_servers.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
begin
    //// Автоматический контекстный поиск
    //if (GetSymKey(char(Key))=true) then
    //  begin
    //    Form_servers.Edit1.SetFocus;
    //  end;
    ////ПОИСК
    // if (Key=13) and (Form_servers.Edit1.Focused) then Form_servers.ToolButton8.Click;
  With form_servers do
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
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F5] - Обновить'+#13+'[ENTER] - начать поиск'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');
    //F5 - Обновить
    if (Key=116) and (bitbtn1.enabled=true) then  Form_servers.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then Form_servers.ToolButton8.Click;
    // ESC
    if Key=27 then Form_servers.BitBtn3.Click;
    // ПРОБЕЛ -ВЫБРАТЬ
    if (Key=32) and  (Form_servers.StringGrid1.Focused) then Form_servers.BitBtn2.Click;

    If (Key=32) AND not(Edit1.Focused) then Key:=0;
    //if (Key=112) or (Key=116) or (Key=118) or (Key=27) or (Key=13)   then Key:=0;
    // Контекcтный поиск
   if (Edit1.Visible=false) AND (stringgrid1.Focused) then
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

procedure TForm_servers.FormShow(Sender: TObject);
begin
   Form_servers.UpdateGrid(datatyp,'');
   Form_servers.StringGrid1.Col := 2;
   Form_servers.StringGrid1.ColWidths[8] := 1;
   Form_servers.StringGrid1.SetFocus;
   {if flag_access=1 then
     begin
      with Form_servers do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
     }
end;

procedure TForm_servers.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
     with Sender as TStringGrid, Canvas do
  begin
       //Если сервер удален, закрашиваем строку серым цветом
      if (trim(Cells[8,aRow])='0') then
        Brush.color := clWhite;
      if (trim(Cells[8,aRow])<>'0') then
        Brush.Color := clSilver;
      FillRect(aRect);

       if (gdSelected in aState) then
           begin
            pen.Width:=4;
            pen.Color:=clRed;
            MoveTo(aRect.left,aRect.bottom-1);
            LineTo(aRect.right,aRect.Bottom-1);
            MoveTo(aRect.left,aRect.top-1);
            LineTo(aRect.right,aRect.Top);
            Font.Color := clBlue;
            font.Size:=11;
            font.Style:= [];
           end
         else
          begin
            font.Style:= [];
            Font.Color := clBlack;
            font.Size:=10;
          end;

          // имя
      if (aRow>0) and (aCol=1) then
         begin
          Font.Size:=12;
//        Font.Color := clBlack;
          TextOut(aRect.Left + 10, aRect.Top+5, Cells[aCol, aRow]);
         end;

         // Остальные поля
     if (aRow>0) and not(aCol=1) then
         begin
     //     Font.Size:=10;
     //     Font.Color := clBlack;
          TextOut(aRect.Left + 5, aRect.Top+8, Cells[aCol, aRow]);
         end;


      // Заголовок
       if aRow=0 then
         begin
           RowHeights[aRow]:=30;
           Brush.Color:=clCream;
           FillRect(aRect);
           Font.Color := clBlack;
           font.Size:=9;
           font.Style:=[fsBold];
           TextOut(aRect.Left + 5, aRect.Top+15, Cells[aCol, aRow]);
           //Рисуем значки сортировки и активного столбца
            DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
          end;
     end;
end;

procedure TForm_servers.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TForm_servers.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Click_Header((Sender as TStringgrid),X,Y,Self.ProgressBar1);
end;


end.

