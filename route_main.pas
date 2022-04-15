unit route_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids,platproc,route_edit,report_main, LazUtf8;

type

  { TForm17 }

  TForm17 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label2: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1HeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form17: TForm17; 
  flag_edit_route:integer;
  result_id_route, result_name_route : string;

implementation
uses
  mainopp;

{$R *.lfm}

{ TForm17 }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

procedure TForm17.BitBtn4Click(Sender: TObject);
begin
  form17.close;
end;

procedure TForm17.BitBtn5Click(Sender: TObject);
begin
   result_id_route:=form17.StringGrid1.Cells[1,form17.StringGrid1.row];
   result_name_route := form17.StringGrid1.Cells[2,form17.StringGrid1.row];
   form17.close;
end;

procedure TForm17.Edit1Change(Sender: TObject);
 var
    n:integer=0;
  begin
    with FOrm17 do
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

procedure TForm17.BitBtn1Click(Sender: TObject);
begin
   //Создаем новую запись
  flag_edit_route:=1;
  form18:=Tform18.create(self);
  form18.ShowModal;
  FreeAndNil(form18);
  form17.UpdateGrid(datatyp,'');
end;

procedure TForm17.BitBtn2Click(Sender: TObject);
 var
   res_flag : integer;
   //resf : byte ;
   //sstr: string;
begin
  with Form17 do
  begin
  //Удаляем запись
   if (trim(form17.StringGrid1.Cells[1,form17.StringGrid1.row])='') or (form17.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

 res_flag := dialogs.MessageDlg('Удалить выбранный МАРШРУТ ?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag<>6 then exit;

  //**************** проверка на возможность удаления записи  *****************************************
  If DelCheck(Form17.StringGrid1, 1, Form17.ZConnection1, Form17.ZQuery1,'av_shedule.id_route:id,')<>1 then exit;

    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

 // Открываем транзакцию
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
     form17.ZQuery1.SQL.Clear;
     form17.ZQuery1.SQL.add('UPDATE av_route SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(form17.StringGrid1.Cells[1,form17.StringGrid1.row])+' and del=0;');
     form17.ZQuery1.ExecSQL;
   // Завершение транзакции
  Zconnection1.Commit;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;

  ZQuery1.close;
  Zconnection1.disconnect;
  UpdateGrid(datatyp,'');

  end;
end;

procedure TForm17.BitBtn12Click(Sender: TObject);
begin
  //Редактируем запись
  flag_edit_route:=2;
  form18:=Tform18.create(self);
  form18.ShowModal;
  FreeAndNil(form18);
  form17.UpdateGrid(datatyp,'');
end;


procedure TForm17.UpdateGrid(filter_type:byte; stroka:string);
 var
   n:integer;
begin
//   with FOrm17 do
//  begin
//   // Подключаемся к серверу
//   If not(Connect2(Zconnection1, flagProfile)) then
//     begin
//      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
//      Close;
//      exit;
//     end;
//
//   // Определяем список маршрутов
//   ZQuery1.SQL.clear;
////   ZQuery1.SQL.add('select id,name,name2,name3,kod,type_route from av_route where del=0 ORDER by kod;');
//   ZQuery1.SQL.add('select a.id,b.name AS name1,c.name AS name2,d.name AS name3,a.kod,a.type_route from av_route AS a');
//   ZQuery1.SQL.add('Left JOIN av_spr_locality AS b ON a.id_nas1=b.id AND b.del=0');
//   ZQuery1.SQL.add('Left JOIN av_spr_locality AS c ON a.id_nas2=c.id AND c.del=0');
//   ZQuery1.SQL.add('Left JOIN av_spr_locality AS d ON a.id_nas3=d.id AND d.del=0');
//   ZQuery1.SQL.add('where a.del=0 ORDER by name1;');
// //  showmessagealt('Команда: '+ZQuery1.SQL.Text);
//  try
//    ZQuery1.open;
//  except
//    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
//    ZQuery1.Close;
//    Zconnection1.disconnect;
//  end;
//  end;
//   if form17.ZQuery1.RecordCount=0 then
//      begin
//        form17.ZQuery1.close;
//        form17.ZConnection1.Disconnect;
//        exit;
//      end;
//   // Заполняем stringgrid
//   form17.StringGrid1.RowCount:=form17.ZQuery1.RecordCount+1;
//   for n:=1 to form17.ZQuery1.RecordCount do
//    begin
//      form17.StringGrid1.Cells[0,n]:=form17.ZQuery1.FieldByName('kod').asString;
//      form17.StringGrid1.Cells[1,n]:=form17.ZQuery1.FieldByName('id').asString;
//      form17.StringGrid1.Cells[2,n]:=trim(form17.ZQuery1.FieldByName('name1').asString)+' - '+trim(form17.ZQuery1.FieldByName('name2').asString);
//      if not(trim(form17.ZQuery1.FieldByName('name3').asString)='') then form17.StringGrid1.Cells[2,n]:=form17.StringGrid1.Cells[2,n]+' - '+trim(form17.ZQuery1.FieldByName('name3').asString);
//      if form17.ZQuery1.FieldByName('type_route').asInteger=0 then form17.StringGrid1.Cells[3,n]:=cMezhgorod;
//      if form17.ZQuery1.FieldByName('type_route').asInteger=1 then form17.StringGrid1.Cells[3,n]:=cPrigorod;
//      if form17.ZQuery1.FieldByName('type_route').asInteger=2 then form17.StringGrid1.Cells[3,n]:=cKray;
//      if form17.ZQuery1.FieldByName('type_route').asInteger=3 then form17.StringGrid1.Cells[3,n]:=cGos;
//      form17.ZQuery1.Next;
//    end;
//
//   // Определяем количество расписаний маршрута
//
//
//   form17.ZQuery1.Close;
//   form17.Zconnection1.disconnect;
//   form17.StringGrid1.Refresh;
//   form17.StringGrid1.SetFocus;
   with FOrm17 do
  begin
  StringGrid1.RowCount:=1;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;

   // Определяем список маршрутов
   ZQuery1.SQL.clear;
//   ZQuery1.SQL.add('select id,name,name2,name3,kod,type_route from av_route where del=0 ORDER by kod;');
   ZQuery1.SQL.add('select a.id,b.name AS name1,c.name AS name2,d.name AS name3,a.kod,a.type_route from av_route AS a');
   ZQuery1.SQL.add('Left JOIN av_spr_locality AS b ON a.id_nas1=b.id AND b.del=0');
   ZQuery1.SQL.add('Left JOIN av_spr_locality AS c ON a.id_nas2=c.id AND c.del=0');
   ZQuery1.SQL.add('Left JOIN av_spr_locality AS d ON a.id_nas3=d.id AND d.del=0');
   ZQuery1.SQL.add('where a.del=0 ');

   if (stroka<>'') and (filter_type=2) then ZQuery1.SQL.add('and ((b.name) ilike '+quotedstr(stroka+'%')+' or (c.name) ilike '+quotedstr(stroka+'%')+' or (d.name) ilike '+quotedstr(stroka+'%')+')');
   if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('and ( position('+quotedstr(stroka)+' in a.kod)>0 OR position('+quotedstr(stroka)+' in cast(a.id as text))>0 )');

   ZQuery1.SQL.add('ORDER by name1;');

   //showmessage(ZQuery1.SQL.Text);//$
  try
    ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
  end;
   if form17.ZQuery1.RecordCount=0 then
      begin
        form17.ZQuery1.close;
        form17.ZConnection1.Disconnect;
        exit;
      end;
   // Заполняем stringgrid
   form17.StringGrid1.RowCount:=form17.ZQuery1.RecordCount+1;
   for n:=1 to form17.ZQuery1.RecordCount do
    begin
      form17.StringGrid1.Cells[0,n]:=form17.ZQuery1.FieldByName('kod').asString;
      form17.StringGrid1.Cells[1,n]:=form17.ZQuery1.FieldByName('id').asString;
      form17.StringGrid1.Cells[2,n]:=trim(form17.ZQuery1.FieldByName('name1').asString)+' - '+trim(form17.ZQuery1.FieldByName('name2').asString);
      if not(trim(form17.ZQuery1.FieldByName('name3').asString)='') then form17.StringGrid1.Cells[2,n]:=form17.StringGrid1.Cells[2,n]+' - '+trim(form17.ZQuery1.FieldByName('name3').asString);
      if form17.ZQuery1.FieldByName('type_route').asInteger=0 then form17.StringGrid1.Cells[3,n]:=cMezhgorod;
      if form17.ZQuery1.FieldByName('type_route').asInteger=1 then form17.StringGrid1.Cells[3,n]:=cPrigorod;
      if form17.ZQuery1.FieldByName('type_route').asInteger=2 then form17.StringGrid1.Cells[3,n]:=cKray;
      if form17.ZQuery1.FieldByName('type_route').asInteger=3 then form17.StringGrid1.Cells[3,n]:=cGos;
      form17.ZQuery1.Next;
    end;

   // Определяем количество расписаний маршрута


   form17.ZQuery1.Close;
   form17.Zconnection1.disconnect;
   form17.StringGrid1.Refresh;
   //form17.StringGrid1.SetFocus;
end;


procedure TForm17.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState     );
begin
    //// Автоматический контекстный поиск
    //if (GetSymKey(char(Key))=true) then
    //  begin
    //    form17.Edit1.SetFocus;
    //  end;
    //if (Key=13) and (form17.Edit1.Focused) then Form17.ToolButton8.Click;

   With form17 do
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
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ENTER] - начать поиск'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');

    //F4 - Изменить
    if (Key=115) and (form17.bitbtn12.enabled=true) then form17.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (form17.bitbtn1.enabled=true) then form17.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then form17.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (form17.bitbtn2.enabled=true) then form17.BitBtn2.Click;
    // ESC
    if Key=27 then form17.Close;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32)  and  (form17.StringGrid1.Focused) then form17.BitBtn5.Click;

    If (Key=32) AND not(Edit1.Focused) then Key:=0;
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
    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=13)   then Key:=0;
    end;
end;


procedure TForm17.FormShow(Sender: TObject);
begin
   form17.UpdateGrid(datatyp,'');
   if (flag_access=1) or (fl_print=1) then
     begin
      with form17 do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
   form17.StringGrid1.SetFocus;
   form17.StringGrid1.Col:=2;
   form17.StringGrid1.Row:=1;
     if tekroute<>'' then
     begin
      form17.Edit1.Text:=tekroute;
      form17.Edit1.Visible:=true;
      form17.Edit1.SetFocus;
     end;
end;


procedure TForm17.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin

with Sender as TStringGrid, Canvas do
  begin
       if trim(cells[3,aRow]) = cMezhgorod then Brush.Color := clBtnFace;
       if trim(cells[3,aRow]) = cPrigorod then Brush.Color:=clSkyBlue;
       if trim(cells[3,aRow]) = cKray then Brush.Color:=clMoneyGreen;
       if trim(cells[3,aRow]) = cGos then Brush.Color:=clSilver;
       FillRect(aRect);

       if (gdSelected in aState) then
         begin
            pen.Width:=4;
            pen.Color:=clRed;
            MoveTo(aRect.left,aRect.bottom-1);
            LineTo(aRect.right,aRect.Bottom-1);
            MoveTo(aRect.left,aRect.top-1);
            LineTo(aRect.right,aRect.Top);
            Font.Color:=clBlack;
            font.Size:=12;
            font.Style:=[fsBold];
         end
       else
         begin
            Font.Color:=clBlack;
            font.Size:=11;
            font.Style:=[];
         end;

      //if aCol=1 then Font.Color := brush.color;

      if aRow>0 then
         begin
          TextOut(aRect.Left+5,aRect.Top+5,Cells[aCol,aRow]);
         end;

       //заголовок
    if aRow=0 then
      begin
           Brush.Color:= clCream;
           Font.Color := clBlack;
           font.Size:=10;
           font.Style:=[fsBold];
           TextOut(aRect.Left + 18, aRect.Top + 4, Cells[aCol, aRow]);
         //  if not(aCol=1) then
         //   begin
         //     form17.ImageListSort.GetBitmap(0, form17.Image1.Picture.Bitmap);
         //     Draw(aRect.Left, aRect.Top, Image1.Picture.Graphic);
         //   end;

        // Рисуем значки сортировки и активного столбца
          DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
       end;
    end;
 end;

procedure TForm17.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TForm17.StringGrid1HeaderClick(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
begin
//  form17.ToolButton1.Click;
{const PreviousColumnIndex : integer = -1;
  if grdMain.DataSource.DataSet is TCustomADODataSet then
  with TCustomADODataSet(grdMain.DataSource.DataSet) do
  begin
    try
     grdMain.Columns[PreviousColumnIndex].title.Font.Style := grdMain.Columns[PreviousColumnIndex].title.Font.Style - [fsBold];
    except
    end;
    Column.title.Font.Style := Column.title.Font.Style + [fsBold];
    PreviousColumnIndex := Column.Index;
    if (Pos(Column.Field.FieldName, Sort) = 1)
    and (Pos(' DESC', Sort)= 0) then
     Sort := Column.Field.FieldName + ' DESC'
    else
     Sort := Column.Field.FieldName + ' ASC';
  end;}
end;

procedure TForm17.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Click_Header((Sender as TStringgrid),X,Y,Self.ProgressBar1);
end;

procedure TForm17.ToolButton8Click(Sender: TObject);
begin
   GridPoisk(form17.StringGrid1,form17.Edit1);
end;

end.

