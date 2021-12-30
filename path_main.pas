unit path_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Grids,platproc,path_edit, LazUtf8;

type

  { TFormpm }

  TFormpm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
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
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formpm: TFormpm;
  flag_edit_path: integer;

implementation
  uses
    mainopp;
{$R *.lfm}

{ TFormpm }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

procedure TFormpm.UpdateGrid(filter_type:byte; stroka:string);
var
  n:integer;
begin
 // With FormPm do
 // begin
 // // Подключаемся к серверу
 //  If not(Connect2(Zconnection1, flagProfile)) then
 //    begin
 //     showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
 //     Close;
 //     exit;
 //    end;
 // // Определяем данные
 // ZQuery1.SQL.clear;
 // ZQuery1.SQL.add('SELECT a.id,a.id1,a.id2,a.km,a.path_time,b.name as name1,c.name as name2 ');
 // ZQuery1.SQL.add('FROM av_spr_path AS a ');
 // ZQuery1.SQL.add('LEFT JOIN av_spr_point as b ON a.id1=b.id and b.del=0 and a.del=0 ');
 // ZQuery1.SQL.add('LEFT JOIN av_spr_point as c ON a.id2=c.id and c.del=0 and a.del=0 ');
 // ZQuery1.SQL.add('WHERE a.del=0 ORDER by name1; ');
 ////showmessagealt(formpm.ZQuery1.SQL.text);
 //
 // try
 //  ZQuery1.open;
 // except
 //   showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
 //   ZQuery1.Close;
 //   Zconnection1.disconnect;
 // end;
 // end;
 // if formpm.ZQuery1.RecordCount=0 then
 //    begin
 //      formpm.ZQuery1.close;
 //      formpm.ZConnection1.Disconnect;
 //      exit;
 //    end;
 // // Заполняем stringgrid
 // formpm.StringGrid1.RowCount:=formpm.ZQuery1.RecordCount+1;
 // for n:=1 to formpm.ZQuery1.RecordCount do
 //  begin
 //    formpm.StringGrid1.Cells[0,n]:=formpm.ZQuery1.FieldByName('id').asString;
 //    formpm.StringGrid1.Cells[1,n]:=formpm.ZQuery1.FieldByName('id1').asString;
 //    formpm.StringGrid1.Cells[2,n]:=formpm.ZQuery1.FieldByName('name1').asString;
 //    formpm.StringGrid1.Cells[3,n]:=trim(formpm.ZQuery1.FieldByName('id2').asString);
 //    formpm.StringGrid1.Cells[4,n]:=trim(formpm.ZQuery1.FieldByName('name2').asString);
 //    formpm.StringGrid1.Cells[5,n]:=trim(formpm.ZQuery1.FieldByName('km').asString);
 //    formpm.StringGrid1.Cells[6,n]:=trim(formpm.ZQuery1.FieldByName('path_time').asString);
 //    formpm.ZQuery1.Next;
 // end;
 // formpm.ZQuery1.Close;
 // formpm.Zconnection1.disconnect;
 // formpm.StringGrid1.Refresh;
 // formpm.StringGrid1.SetFocus;
  With FormPm do
  begin
  StringGrid1.RowCount:=1;
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
  // Определяем данные
  ZQuery1.SQL.clear;
  ZQuery1.SQL.add('SELECT a.id,a.id1,a.id2,a.km,a.path_time,b.name as name1,c.name as name2 ');
  ZQuery1.SQL.add('FROM av_spr_path AS a ');
  ZQuery1.SQL.add('LEFT JOIN av_spr_point as b ON a.id1=b.id and b.del=0 and a.del=0 ');
  ZQuery1.SQL.add('LEFT JOIN av_spr_point as c ON a.id2=c.id and c.del=0 and a.del=0 ');
  ZQuery1.SQL.add('WHERE a.del=0 ');
  if (stroka<>'') and (filter_type=2) then ZQuery1.SQL.add('and b.name ilike '+quotedstr(stroka+'%'));
  if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('and (a.id='+stroka+' OR a.id1='+stroka+' OR a.id2='+stroka+')');
  ZQuery1.SQL.add(' ORDER by name1; ');
 //showmessage(formpm.ZQuery1.SQL.text);//$

  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
  end;
  if formpm.ZQuery1.RecordCount=0 then
     begin
       formpm.ZQuery1.close;
       formpm.ZConnection1.Disconnect;
       exit;
     end;
  // Заполняем stringgrid
  formpm.StringGrid1.RowCount:=formpm.ZQuery1.RecordCount+1;
  for n:=1 to formpm.ZQuery1.RecordCount do
   begin
     formpm.StringGrid1.Cells[0,n]:=formpm.ZQuery1.FieldByName('id').asString;
     formpm.StringGrid1.Cells[1,n]:=formpm.ZQuery1.FieldByName('id1').asString;
     formpm.StringGrid1.Cells[2,n]:=formpm.ZQuery1.FieldByName('name1').asString;
     formpm.StringGrid1.Cells[3,n]:=trim(formpm.ZQuery1.FieldByName('id2').asString);
     formpm.StringGrid1.Cells[4,n]:=trim(formpm.ZQuery1.FieldByName('name2').asString);
     formpm.StringGrid1.Cells[5,n]:=trim(formpm.ZQuery1.FieldByName('km').asString);
     formpm.StringGrid1.Cells[6,n]:=trim(formpm.ZQuery1.FieldByName('path_time').asString);
     formpm.ZQuery1.Next;
  end;
  formpm.ZQuery1.Close;
  formpm.Zconnection1.disconnect;
  formpm.StringGrid1.Refresh;
  //formpm.StringGrid1.SetFocus;
end;

procedure TFormpm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
   //// Автоматический контекстный поиск
   //if (GetSymKey(char(Key))=true) then
   //  begin
   //   formpm.Edit1.SetFocus;
   //  end;
   ////ENTER
   //if (Key=13) and (formpm.Edit1.Focused) then Formpm.ToolButton8.Click;

  With formpm do
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
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');

    //F4 - Изменить
    if (Key=115) and (Formpm.bitbtn12.enabled=true) then Formpm.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (Formpm.bitbtn1.enabled=true) then Formpm.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then Formpm.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (Formpm.bitbtn2.enabled=true) then Formpm.BitBtn2.Click;
    // ESC
    if Key=27 then Formpm.Close;
    // ENTER
    //if (Key=13)  and  (formpath.StringGrid1.Focused) then
     // begin
        //result_:=formpm.StringGrid1.Cells[1,formpm.StringGrid1.row];
       // formpm.close;
      //end;

    If (Key=32) AND not(Edit1.Focused) then Key:=0;
    //if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=13) then Key:=0;
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

procedure TFormpm.BitBtn4Click(Sender: TObject);
begin
  formpm.Close;
end;

procedure TFormpm.Edit1Change(Sender: TObject);
var
   n:integer=0;
 begin
   with FOrmpm do
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

procedure TFormpm.BitBtn2Click(Sender: TObject);
begin
  with FORMpm do
  begin
    //Удаляем запись
   if (trim(Formpm.StringGrid1.Cells[0,Formpm.StringGrid1.row])='') or (Formpm.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

 if MessageDlg('Удалить выбранный норматив ?',mtConfirmation,[mbYes,mbNO], 0)=6 then
   begin
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
     formpm.ZQuery1.SQL.Clear;
     formpm.ZQuery1.SQL.add('UPDATE av_spr_path SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(formpm.StringGrid1.Cells[0,formpm.StringGrid1.row])+' and del=0;');
   //  showmessagealt('зАПРОС'+#13+ZQuery1.SQL.Text);

     formpm.ZQuery1.ExecSQL;
  //завершение транзакции
   Zconnection1.Commit;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
     formpm.UpdateGrid(datatyp,'');
   end;
 end;
end;

procedure TFormpm.BitBtn1Click(Sender: TObject);
begin
  //Создаем новую запись
  flag_edit_path:=1;
  Formpme:=TFormpme.create(self);
  Formpme.ShowModal;
  FreeAndNil(Formpme);
  Formpm.UpdateGrid(datatyp,'');
end;

procedure TFormpm.BitBtn12Click(Sender: TObject);
begin
   //редактируем запись
  flag_edit_path:=2;
  Formpme:=TFormpme.create(self);
  Formpme.ShowModal;
  FreeAndNil(Formpme);
  Formpm.UpdateGrid(datatyp,'');
end;

procedure TFormpm.FormShow(Sender: TObject);
begin
  Centrform(Formpm);
  FormPM.UpdateGrid(datatyp,'');
  if flag_access=1 then
     begin
      with Formpm do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
  formpm.StringGrid1.SetFocus;
end;

procedure TFormpm.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
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
           font.Size:=10;
           font.Style:=[fsBold];
           TextOut(aRect.Left + 5, aRect.Top+15, Cells[aCol, aRow]);
           //Рисуем значки сортировки и активного столбца
            DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
          end;
     end;
end;

procedure TFormpm.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TFormpm.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Click_Header((Sender as TStringgrid),X,Y,Self.ProgressBar1);
end;

procedure TFormpm.ToolButton1Click(Sender: TObject);
begin
    SortGrid(Formpm.StringGrid1,Formpm.StringGrid1.col,Formpm.ProgressBar1,0,1);
end;

procedure TFormpm.ToolButton8Click(Sender: TObject);
begin
   GridPoisk(Formpm.StringGrid1,Formpm.Edit1);
end;

end.

