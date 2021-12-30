unit nas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, nas_edit, platproc, LMessages, report_main,
  ExtCtrls,  LazUtf8;

type

  { TForm5 }

  TForm5 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
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
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    //procedure UpdateGrid();
    procedure UpdateGrid(filter_type:byte; stroka:string);
    procedure FillReportVars();// ЗАПОЛНЕНИЕ МАССИВА ПЕРЕМЕННЫХ ОТЧЕТОВ *********************************************
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form5: TForm5; 
  flag_edit:byte;
  result_kod_nas,result_name_nas, result_:string;

implementation
uses
  mainopp;

{$R *.lfm}

{ TForm5 }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

//****************   // ЗАПОЛНЕНИЕ МАССИВА ПЕРЕМЕННЫХ ОТЧЕТОВ *********************************************
procedure TForm5.FillReportVars();
var
  m: integer;
begin
  with Form5 do
 begin
  //заполняем доступные значения в массив переменных отчета (таблица report_vars)
     for m:=Low(ar_report) to High(ar_report) do
                begin
                   If trim(ar_report[m,0]) = 'city_id'  then ar_report[m,2]:= result_kod_nas;
                   If trim(ar_report[m,0]) = 'city_name' then ar_report[m,2]:= result_name_nas;
                   If trim(ar_report[m,0]) = 'city_type' then ar_report[m,2]:= Stringgrid1.Cells[2,Stringgrid1.Row];
                   If trim(ar_report[m,0]) = 'city_rajon' then ar_report[m,2]:= Stringgrid1.Cells[3,Stringgrid1.Row];
                   If trim(ar_report[m,0]) = 'city_region' then ar_report[m,2]:= Stringgrid1.Cells[4,Stringgrid1.Row];
                   If trim(ar_report[m,0]) = 'city_land' then ar_report[m,2]:= Stringgrid1.Cells[5,Stringgrid1.Row];
                   If trim(ar_report[m,0]) = 'city_region_type' then ar_report[m,2]:= Stringgrid1.Cells[6,Stringgrid1.Row];
                end;
 end;
end;

procedure TForm5.UpdateGrid(filter_type:byte; stroka:string); //TForm5.UpdateGrid();
 var
   n:integer;
   twodot:string=':';
begin
  With Form5 do
  begin
   //// Подключаемся к серверу
   //If not(Connect2(Zconnection1, flagProfile)) then
   //  begin
   //   showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
   //   Close;
   //   exit;
   //  end;
   ////запрос списка
   //form5.ZQuery1.SQL.Clear;
   //form5.ZQuery1.SQL.add('select * from av_spr_locality where del=0 Order by name;');
   //form5.ZQuery1.open;
   //if form5.ZQuery1.RecordCount=0 then
   //  begin
   //   form5.ZQuery1.Close;
   //   form5.Zconnection1.disconnect;
   //   exit;
   //  end;
   //// Заполняем stringgrid
   //form5.StringGrid1.RowCount:=form5.ZQuery1.RecordCount+1;
   //for n:=1 to form5.ZQuery1.RecordCount do
   // begin
   //   form5.StringGrid1.Cells[0,n]:=form5.ZQuery1.FieldByName('id').asString;
   //   form5.StringGrid1.Cells[1,n]:=form5.ZQuery1.FieldByName('name').asString;
   //   form5.StringGrid1.Cells[2,n]:=form5.ZQuery1.FieldByName('typ_locality').asString;
   //   form5.StringGrid1.Cells[3,n]:=form5.ZQuery1.FieldByName('rajon').asString;
   //   form5.StringGrid1.Cells[4,n]:=form5.ZQuery1.FieldByName('region').asString;
   //   form5.StringGrid1.Cells[5,n]:=form5.ZQuery1.FieldByName('Land').asString;
   //   form5.StringGrid1.Cells[6,n]:=form5.ZQuery1.FieldByName('typ_region').asString;
   //   form5.ZQuery1.Next;
   // end;
   //form5.ZQuery1.Close;
   //form5.Zconnection1.disconnect;
   //form5.StringGrid1.ColWidths[6]:=0; //не показывать тип региона
   //form5.StringGrid1.Refresh;
   //form5.StringGrid1.Row:=form5.StringGrid1.RowCount;
   //form5.Label1.Caption:='Количество населенных пунктов: '+inttostr(form5.StringGrid1.RowCount);
     // Подключаемся к серверу
     StringGrid1.RowCount:=1;
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;

   //запрос списка
   form5.ZQuery1.SQL.Clear;
   form5.ZQuery1.SQL.add('select * from av_spr_locality where del=0 ');
   if (stroka<>'') and (filter_type=2) then form5.ZQuery1.SQL.add('and name ilike '+quotedstr(stroka+'%'));
   if (stroka<>'') and (filter_type=1) then form5.ZQuery1.SQL.add('and cast(id as text) like '+quotedstr(stroka+'%'));
   form5.ZQuery1.SQL.add('Order by name;');
   form5.ZQuery1.open;
   if form5.ZQuery1.RecordCount=0 then
     begin
      form5.ZQuery1.Close;
      form5.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   form5.StringGrid1.RowCount:=form5.ZQuery1.RecordCount+1;
   for n:=1 to form5.ZQuery1.RecordCount do
    begin
      form5.StringGrid1.Cells[0,n]:=form5.ZQuery1.FieldByName('id').asString;
      form5.StringGrid1.Cells[1,n]:=form5.ZQuery1.FieldByName('name').asString;
      form5.StringGrid1.Cells[2,n]:=form5.ZQuery1.FieldByName('typ_locality').asString;
      form5.StringGrid1.Cells[3,n]:=form5.ZQuery1.FieldByName('rajon').asString;
      form5.StringGrid1.Cells[4,n]:=form5.ZQuery1.FieldByName('region').asString;
      form5.StringGrid1.Cells[5,n]:=form5.ZQuery1.FieldByName('Land').asString;
      form5.StringGrid1.Cells[6,n]:=form5.ZQuery1.FieldByName('typ_region').asString;
      form5.ZQuery1.Next;
    end;
   form5.ZQuery1.Close;
   form5.Zconnection1.disconnect;
   form5.StringGrid1.ColWidths[6]:=0; //не показывать тип региона
   form5.StringGrid1.Refresh;
   form5.StringGrid1.Row:=form5.StringGrid1.RowCount;
   form5.Label1.Caption:='Количество населенных пунктов: '+inttostr(form5.StringGrid1.RowCount);
  end;
end;

procedure TForm5.BitBtn1Click(Sender: TObject);
begin
  //Создаем новую запись населенного пункта
  flag_edit:=1;
  form6:=Tform6.create(self);
  form6.ShowModal;
  FreeAndNil(form6);
  form5.UpdateGrid(datatyp,'');
end;

procedure TForm5.BitBtn2Click(Sender: TObject);
 var
   resF : byte;
   res_flag:integer;
begin
  With Form5 do
  begin
  //Удаляем запись
   if (trim(form5.StringGrid1.Cells[0,form5.StringGrid1.row])='') or (form5.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;
  res_flag := dialogs.MessageDlg('Удалить выбранный населенный пункт ?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag<>6 then exit;

 //**************** проверка на возможность удаления записи  *****************************************
  resF := DelCheck(Form5.StringGrid1, 0, Form5.ZConnection1, Form5.ZQuery1, 'av_spr_point.kod_locality,');
  IF resF<>1 then exit;
     // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
     //проставляем запись на удаление
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
     form5.ZQuery1.SQL.Clear;
     form5.ZQuery1.SQL.add('UPDATE av_spr_locality SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(form5.StringGrid1.Cells[0,form5.StringGrid1.row])+' and del=0;');
     form5.ZQuery1.ExecSQL;
             //завершение транзакции
   Zconnection1.Commit;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.close;
     Zconnection1.disconnect;
     exit;
   end;
   Zconnection1.disconnect;
     form5.UpdateGrid(datatyp,'');

 end;
end;

procedure TForm5.BitBtn12Click(Sender: TObject);
begin
   //Редактируем запись населенного пункта
  if (trim(form5.StringGrid1.Cells[0,form5.StringGrid1.row])='') or (form5.StringGrid1.RowCount=1) then
    begin
      showmessagealt('Не выбрана запись для редактирования !');
      exit;
    end;
  flag_edit:=2;
  form6:=Tform6.create(self);
  form6.ShowModal;
  FreeAndNil(form6);
  form5.UpdateGrid(datatyp,'');
end;

procedure TForm5.BitBtn4Click(Sender: TObject);
begin
  form5.Close;
end;

procedure TForm5.BitBtn5Click(Sender: TObject);
begin
   result_kod_nas:=form5.StringGrid1.Cells[0,form5.StringGrid1.row];
   result_name_nas:=form5.StringGrid1.Cells[1,form5.StringGrid1.row];
   If fl_print=1 then
     begin
        fillreportvars();
     end;
   form5.close;
end;

//фильтрация грида на основе контекстного поиска
procedure TForm5.Edit1Change(Sender: TObject);
  var
  n:integer=0;
begin
  with FOrm5 do
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



procedure TForm5.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
begin
    //  // Автоматический контекстный поиск
    //if (GetSymKey(char(Key))=true) then
    //  begin
    //    form5.Edit1.SetFocus;
    //  end;
    ////enter - ПОИСК
    // if (Key=13) and (form5.Edit1.Focused) then Form5.ToolButton8.Click;

With form5 do
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
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'F9 - Обновить данные'+#13+'[ENTER] - начать поиск'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');

    //F4 - Изменить
    if (Key=115) and (form5.bitbtn12.enabled=true) then form5.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (form5.bitbtn1.enabled=true) then form5.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then form5.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (form5.bitbtn2.enabled=true) then form5.BitBtn2.Click;
    // F9
    if Key=120 then form5.ToolButton4.Click;
    // ESC
    if Key=27 then form5.Close;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32)  and  (form5.StringGrid1.Focused) then form5.BitBtn5.Click;

    //If (Key=32) AND not(Edit1.Focused) then Key:=0;
    //if (Key=13) or (Key=115) or (Key=116) or (Key=119) or (Key=27) then Key:=0;
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

procedure TForm5.FormShow(Sender: TObject);
begin
 Centrform(form5);
 form5.UpdateGrid(datatyp,'');
 form5.StringGrid1.Col:=1;
 form5.StringGrid1.Row:=1;
    if (flag_access=1) or (fl_print=1) then
     begin
      with form5 do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
end;


procedure TForm5.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
    with Sender as TStringGrid, Canvas do
  begin
       Brush.Color:=clWhite;
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
            font.Size:=13;
            font.Style:= [];
           end
         else
          begin
            font.Style:= [];
            Font.Color := clBlack;
            font.Size:=12;
          end;

      // Остальные поля
      if (aRow>0) then
         begin
          TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
         end;

      // Заголовок
       if aRow=0 then
         begin
           RowHeights[aRow]:=35;
           Brush.Color:=clCream;
           FillRect(aRect);
           Font.Color := clBlack;
           font.Size:=11;
           font.style:=[fsBold];
           TextOut(aRect.Left + 10, aRect.Top+15, Cells[aCol, aRow]);
           //Рисуем значки сортировки и активного столбца
           DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
          end;
     end;
end;

procedure TForm5.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TForm5.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Click_Header((Sender as TStringgrid),X,Y,Self.ProgressBar1);
end;


procedure TForm5.ToolButton1Click(Sender: TObject);
begin
   SortGrid(form5.StringGrid1,form5.StringGrid1.col,form5.ProgressBar1,0,1);
end;

procedure TForm5.ToolButton4Click(Sender: TObject);
begin
  form5.UpdateGrid(datatyp,'');
end;

procedure TForm5.ToolButton8Click(Sender: TObject);
begin
    GridPoisk(form5.StringGrid1,form5.Edit1);
end;

end.

