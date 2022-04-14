unit point_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls,platproc,point_edit,report_main,LazUtf8;

type

  { TForm9 }

  TForm9 = class(TForm)
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
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    //procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
  private
    { private declarations }
    formActivated: boolean;
  public
    { public declarations }
  end; 

var
  Form9: TForm9;
  flag_edit_point:integer;
  result_point_name, result_point_id:string;

implementation
uses
  mainopp;
{$R *.lfm}

{ TForm9 }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

 procedure TForm9.UpdateGrid(filter_type:byte; stroka:string);
 var
   n:integer;
begin
  //with Form9 do
  //begin
  // // Подключаемся к серверу
  // If not(Connect2(Zconnection1, flagProfile)) then
  //   begin
  //    showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
  //    Close;
  //    exit;
  //   end;
  // //запрос списка
  // ZQuery1.SQL.Clear;
  // ZQuery1.SQL.add('select a.id,c.name as name_group,a.name,b.name as locality,b.rajon,b.region,b.land ');
  // ZQuery1.SQL.add('from av_spr_point a,av_spr_locality b,av_spr_point_group c ');
  // ZQuery1.SQL.add('where a.kod_locality=b.id AND a.id_group=c.id AND a.del=0 AND b.del=0 AND c.del=0 ORDER BY a.name;');
  //
  //try
  // ZQuery1.open;
  //except
  //  showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
  //  ZQuery1.Close;
  //  Zconnection1.disconnect;
  //end;
  //
  // if form9.ZQuery1.RecordCount=0 then
  //   begin
  //    form9.ZQuery1.Close;
  //    form9.Zconnection1.disconnect;
  //    exit;
  //   end;
  // // Заполняем stringgrid
  // form9.StringGrid1.RowCount:=form9.ZQuery1.RecordCount+1;
  // for n:=1 to form9.ZQuery1.RecordCount do
  //  begin
  //    form9.StringGrid1.Cells[0,n]:=form9.ZQuery1.FieldByName('id').asString;
  //    form9.StringGrid1.Cells[1,n]:=form9.ZQuery1.FieldByName('name_group').asString;
  //    form9.StringGrid1.Cells[2,n]:=form9.ZQuery1.FieldByName('name').asString;
  //    form9.StringGrid1.Cells[3,n]:=form9.ZQuery1.FieldByName('locality').asString;
  //    form9.StringGrid1.Cells[4,n]:=form9.ZQuery1.FieldByName('rajon').asString;
  //    form9.StringGrid1.Cells[5,n]:=form9.ZQuery1.FieldByName('region').asString;
  //    form9.StringGrid1.Cells[6,n]:=form9.ZQuery1.FieldByName('Land').asString;
  //    form9.ZQuery1.Next;
  //  end;
  // form9.ZQuery1.Close;
  // form9.Zconnection1.disconnect;
  // form9.StringGrid1.Refresh;
  // form9.StringGrid1.SetFocus;
  // end;
  with Form9 do
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
   ZQuery1.SQL.add('SELECT * FROM (select a.id, a.createdate, trim(a.name) pname ');
   ZQuery1.SQL.add(',(select trim(b.name) from av_spr_locality b where b.id=a.kod_locality order by del asc,createdate desc limit 1) as locality ');
   ZQuery1.SQL.add(',(select trim(b.rajon) from av_spr_locality b where b.id=a.kod_locality order by del asc,createdate desc limit 1) as rajon ');
   ZQuery1.SQL.add(',(select trim(b.region) from av_spr_locality b where b.id=a.kod_locality order by del asc,createdate desc limit 1) as region ');
   ZQuery1.SQL.add(',(select trim(b.land) from av_spr_locality b where b.id=a.kod_locality order by del asc,createdate desc limit 1) as land ');
   //ZQuery1.SQL.add(',(select c.name from av_spr_point_group c where c.id=a.id_group order by c.del asc,c.createdate desc limit 1) as name_group ');
   ZQuery1.SQL.add(',(SELECT id_dest FROM av_pdp_dest_point b where b.id_point=a.id order by del asc,createdate desc limit 1) as iddest ');
   ZQuery1.SQL.add('from av_spr_point a ');
   ZQuery1.SQL.add('where a.del=0 ) z ');
   if (stroka<>'') and (filter_type=2)
     then begin
       ZQuery1.SQL.add('WHERE z.pname ilike '+quotedstr(stroka+'%')+' OR z.locality ilike '+quotedstr(stroka+'%')+' OR z.land ilike '+quotedstr(stroka+'%'));
       //ZQuery1.SQL.add(+' OR z.rajon ilike '+quotedstr(stroka+'%')+' OR z.region ilike '+quotedstr(stroka+'%'));
     end;
   if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('WHERE z.id='+stroka +' OR z.iddest='+stroka);

   if (stroka='') then
      ZQuery1.SQL.add('ORDER BY z.createdate desc;')
   else
     ZQuery1.SQL.add('ORDER BY z.pname asc;');

      //showmessage(ZQuery1.SQL.Text);//$
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;

   if form9.ZQuery1.RecordCount=0 then
     begin
      form9.ZQuery1.Close;
      form9.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   form9.StringGrid1.RowCount:=form9.ZQuery1.RecordCount+1;
   for n:=1 to form9.ZQuery1.RecordCount do
    begin
      form9.StringGrid1.Cells[0,n]:=form9.ZQuery1.FieldByName('id').asString;
      form9.StringGrid1.Cells[1,n]:=form9.ZQuery1.FieldByName('iddest').asString;
      //form9.StringGrid1.Cells[1,n]:=form9.ZQuery1.FieldByName('name_group').asString;
      form9.StringGrid1.Cells[2,n]:=form9.ZQuery1.FieldByName('pname').asString;
      form9.StringGrid1.Cells[3,n]:=form9.ZQuery1.FieldByName('locality').asString;
      form9.StringGrid1.Cells[4,n]:=form9.ZQuery1.FieldByName('rajon').asString;
      form9.StringGrid1.Cells[5,n]:=form9.ZQuery1.FieldByName('region').asString;
      form9.StringGrid1.Cells[6,n]:=form9.ZQuery1.FieldByName('Land').asString;
      form9.ZQuery1.Next;
    end;
   form9.ZQuery1.Close;
   form9.Zconnection1.disconnect;
   form9.StringGrid1.Refresh;
   //form9.StringGrid1.SetFocus;
   end;
end;




procedure TForm9.BitBtn4Click(Sender: TObject);
begin
  result_point_name:='';
  result_point_id:='';
  form9.Close;
end;

procedure TForm9.BitBtn5Click(Sender: TObject);
begin
   result_point_id:=form9.StringGrid1.Cells[0,form9.StringGrid1.row];
   result_point_name:=form9.stringgrid1.cells[2,form9.StringGrid1.Row];
   form9.close;
end;

//фильтрация грида на основе контекстного поиска
procedure TForm9.Edit1Change(Sender: TObject);
var
   n:integer=0;
begin
with FOrm9 do
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


procedure TForm9.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
begin
    //// Автоматический контекстный поиск
    //if (GetSymKey(char(Key))=true) then
    //  begin
    //    form9.Edit1.SetFocus;
    //  end;
    // if (Key=13) and (form9.Edit1.Focused) then Form9.ToolButton8.Click;
  With form9 do
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
    if (Key=115) and (form9.bitbtn12.enabled=true) then form9.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (form9.bitbtn1.enabled=true) then form9.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then form9.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (form9.bitbtn2.enabled=true) then form9.BitBtn2.Click;
    // ESC
    if Key=27 then form9.BitBtn4.Click;
    // ПРОБЕЛ
    if (Key=32) and  (form9.StringGrid1.Focused) then form9.BitBtn5.Click;
    //if (Key=32) and (form9.Edit1.Focused) then form9.Edit1.Text:=form9.Edit1.Text+' ';

     //If (Key=32) AND not(Edit1.Focused) then Key:=0;
     //if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27)  or (Key=13) then Key:=0;

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


procedure TForm9.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
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
            font.Size:=12;
            font.Style:= [];
           end
         else
          begin
            font.Style:= [];
            Font.Color := clBlack;
            font.Size:=11;
          end;

       // Остальные поля
    // if (aRow>0) and not(aCol=1) and not(aCol=2) and not(aCol=0) then
     if (aRow>0) and not(aCol=1) then
         begin
     //     Font.Size:=10;
     //     Font.Color := clBlack;
          TextOut(aRect.Left + 10, aRect.Top+5, Cells[aCol, aRow]);
         end;

      ////Остановочный пункт
      //if (aRow>0) and ((aCol=2) or (aCol=0))then
      // begin
      //   TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
      // end;

      // Группа
      if (aRow>0) and (aCol=1) then
         begin
          Font.Size:=10;
         // Font.Color := clBlack;
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
           TextOut(aRect.Left + 5, aRect.Top+10, Cells[aCol, aRow]);
           //Рисуем значки сортировки и активного столбца
            DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
          end;
     end;
end;

procedure TForm9.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TForm9.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Click_Header((Sender as TStringgrid),X,Y,Self.ProgressBar1);
end;

procedure TForm9.BitBtn1Click(Sender: TObject);
begin
   //Создаем новую запись населенного пункта
  flag_edit_point:=1;
  Form10:=TForm10.create(self);
  Form10.ShowModal;
  FreeAndNil(Form10);
  form9.UpdateGrid(datatyp,'');
end;

procedure TForm9.BitBtn12Click(Sender: TObject);
begin

//Редактируем запись населенного пункта
  flag_edit_point:=2;
  Form10:=TForm10.create(self);
  Form10.ShowModal;
  FreeAndNil(Form10);
  //form9.UpdateGrid(datatyp,'');
end;

procedure TForm9.BitBtn2Click(Sender: TObject);
 var
   resF : byte;
   res_flag:integer;
begin
  WIth FOrm9 do
  begin
  //Удаляем запись
   if (trim(form9.StringGrid1.Cells[0,form9.StringGrid1.row])='') or (form9.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

  res_flag := dialogs.MessageDlg('Удалить выбранный остановочный пункт ?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag<>6 then exit;

 //**************** проверка на возможность удаления записи  *****************************************
  resF := DelCheck(Form9.StringGrid1, 0, Form9.ZConnection1, Form9.ZQuery1, 'av_spr_path.id1,av_spr_path.id2,av_shedule_sostav.id_point,');
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
     form9.ZQuery1.SQL.Clear;
     form9.ZQuery1.SQL.add('UPDATE av_spr_point SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(form9.StringGrid1.Cells[0,form9.StringGrid1.row])+' and del=0;');
     form9.ZQuery1.ExecSQL;
//     showmessagealt('UF');
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
   form9.UpdateGrid(datatyp,'');
  end;
end;

procedure TForm9.FormShow(Sender: TObject);
begin
   //Centrform(form9);
   if (flag_access=1) OR (fl_print=1) then
     begin
      with form9 do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
end;

procedure TForm9.FormActivate(Sender: TObject);
begin
   if not FormActivated then begin
    FormActivated := True;
    form9.UpdateGrid(datatyp,'');
   form9.StringGrid1.Col:=2;
   form9.StringGrid1.SetFocus;
  end;
end;


end.

