unit uslugi_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids,platproc,uslugi_edit, LazUtf8;

type

  { TFormuslugi }

  TFormuslugi = class(TForm)
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
    Memo1: TMemo;
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
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;      var CanSelect: Boolean);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
    procedure selected_row();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formuslugi: TFormuslugi;
  flag_edit_uslugi:integer;
  result_name_uslugi, result_id_uslugi:string;

implementation
uses
  mainopp;
{$R *.lfm}

{ TFormuslugi }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

procedure TFormuslugi.Selected_row();
begin
  With Formuslugi do
  begin

  Formuslugi.Memo1.Clear;
  if (trim(Formuslugi.StringGrid1.Cells[0,Formuslugi.StringGrid1.row])='') or (Formuslugi.StringGrid1.row=0) then exit;
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
  // Определяем дополнительное описание закона
  Formuslugi.ZQuery1.SQL.clear;
  Formuslugi.ZQuery1.SQL.add('select swed from av_spr_uslugi where del=0 and id='+trim(Formuslugi.StringGrid1.Cells[0,Formuslugi.StringGrid1.row])+';');
  Formuslugi.ZQuery1.open;
  if Formuslugi.ZQuery1.RecordCount=0 then
     begin
       Formuslugi.ZQuery1.close;
       Formuslugi.ZConnection1.Disconnect;
       exit;
     end;
   Formuslugi.Memo1.Clear;
   Formuslugi.Memo1.Text:=Formuslugi.ZQuery1.FieldByName('swed').asString;
   Formuslugi.ZQuery1.close;
   Formuslugi.ZConnection1.Disconnect;
   form1.StringGrid1.Refresh;
   end;
end;

procedure TFormuslugi.UpdateGrid(filter_type:byte; stroka:string);
var
  n:integer;
begin
  //With Formuslugi do
  //begin
  //StringGrid1.RowCount:=1;
  // // Подключаемся к серверу
  // If not(Connect2(Zconnection1, flagProfile)) then
  //   begin
  //    showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
  //    Close;
  //    exit;
  //   end;
  //// Определяем данные
  //Formuslugi.ZQuery1.SQL.clear;
  //Formuslugi.ZQuery1.SQL.add('select id,name,short_name,sposob,swed from av_spr_uslugi where del=0;');
  //Formuslugi.ZQuery1.open;
  //if Formuslugi.ZQuery1.RecordCount=0 then
  //   begin
  //     Formuslugi.ZQuery1.close;
  //     Formuslugi.ZConnection1.Disconnect;
  //     exit;
  //   end;
  //// Заполняем stringgrid
  //Formuslugi.StringGrid1.RowCount:=Formuslugi.ZQuery1.RecordCount+1;
  //for n:=1 to Formuslugi.ZQuery1.RecordCount do
  // begin
  //   Formuslugi.StringGrid1.Cells[0,n]:=Formuslugi.ZQuery1.FieldByName('id').asString;
  //   Formuslugi.StringGrid1.Cells[1,n]:=Formuslugi.ZQuery1.FieldByName('name').asString;
  //   Formuslugi.StringGrid1.Cells[2,n]:=trim(Formuslugi.ZQuery1.FieldByName('short_name').asString);
  //   Formuslugi.StringGrid1.Cells[3,n]:=trim(Formuslugi.ZQuery1.FieldByName('sposob').asString);
  //   Formuslugi.ZQuery1.Next;
  //end;
  //Formuslugi.memo1.Text:=trim(Formuslugi.ZQuery1.FieldByName('swed').asString);
  //Formuslugi.ZQuery1.Close;
  //Formuslugi.Zconnection1.disconnect;
  //Formuslugi.selected_row();
  //Formuslugi.StringGrid1.Refresh;
  //end;
  With Formuslugi do
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
  Formuslugi.ZQuery1.SQL.clear;
  Formuslugi.ZQuery1.SQL.add('select id,name,short_name,sposob,swed from av_spr_uslugi where del=0');
  if (stroka<>'') and (filter_type=2) then ZQuery1.SQL.add('and name ilike '+quotedstr(stroka+'%'));
  if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('and cast(id as text) like '+quotedstr(stroka+'%'));
  Formuslugi.ZQuery1.open;
  if Formuslugi.ZQuery1.RecordCount=0 then
     begin
       Formuslugi.ZQuery1.close;
       Formuslugi.ZConnection1.Disconnect;
       exit;
     end;
  // Заполняем stringgrid
  Formuslugi.StringGrid1.RowCount:=Formuslugi.ZQuery1.RecordCount+1;
  for n:=1 to Formuslugi.ZQuery1.RecordCount do
   begin
     Formuslugi.StringGrid1.Cells[0,n]:=Formuslugi.ZQuery1.FieldByName('id').asString;
     Formuslugi.StringGrid1.Cells[1,n]:=Formuslugi.ZQuery1.FieldByName('name').asString;
     Formuslugi.StringGrid1.Cells[2,n]:=trim(Formuslugi.ZQuery1.FieldByName('short_name').asString);
     Formuslugi.StringGrid1.Cells[3,n]:=trim(Formuslugi.ZQuery1.FieldByName('sposob').asString);
     Formuslugi.ZQuery1.Next;
  end;
  Formuslugi.memo1.Text:=trim(Formuslugi.ZQuery1.FieldByName('swed').asString);
  Formuslugi.ZQuery1.Close;
  Formuslugi.Zconnection1.disconnect;
  Formuslugi.selected_row();
  Formuslugi.StringGrid1.Refresh;
  end;
end;

procedure TFormuslugi.BitBtn1Click(Sender: TObject);
begin
  //Создаем новую запись
  flag_edit_uslugi:=1;
  Formuslugi_edit:=TFormuslugi_edit.create(self);
  Formuslugi_edit.ShowModal;
  FreeAndNil(Formuslugi_edit);
  Formuslugi.UpdateGrid(datatyp,'');
end;

procedure TFormuslugi.BitBtn2Click(Sender: TObject);
begin
  With FOrmUslugi do
  begin
      //Удаляем запись
   if (trim(Formuslugi.StringGrid1.Cells[0,Formuslugi.StringGrid1.row])='') or (Formuslugi.StringGrid1.RowCount<2) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

 if dialogs.MessageDlg('Удалить выбранную льготу ?',mtConfirmation,[mbYes,mbNO], 0)=6 then
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
     Formuslugi.ZQuery1.SQL.Clear;
     Formuslugi.ZQuery1.SQL.add('UPDATE av_spr_uslugi SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(Formuslugi.StringGrid1.Cells[0,Formuslugi.StringGrid1.row])+' and del=0;');
     Formuslugi.ZQuery1.ExecSQL;
     //завершение транзакции
   Zconnection1.Commit;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
     ZQuery1.close;
     Zconnection1.disconnect;
     exit;
   end;
   ZQuery1.close;
   Zconnection1.disconnect;
     Formuslugi.UpdateGrid(datatyp,'');
   end;

  end;
end;

procedure TFormuslugi.BitBtn12Click(Sender: TObject);
begin
  //Редактируем запись
  flag_edit_uslugi:=2;
  Formuslugi_edit:=TFormuslugi_edit.create(self);
  Formuslugi_edit.ShowModal;
  FreeAndNil(Formuslugi_edit);
  Formuslugi.UpdateGrid(datatyp,'');
end;

procedure TFormuslugi.BitBtn4Click(Sender: TObject);
begin
  Formuslugi.close;
end;

procedure TFormuslugi.BitBtn5Click(Sender: TObject);
begin
   result_name_uslugi:=Formuslugi.StringGrid1.Cells[1,Formuslugi.StringGrid1.row];
   result_id_uslugi:=Formuslugi.StringGrid1.Cells[0,Formuslugi.StringGrid1.row];
   Formuslugi.close;
end;

procedure TFormuslugi.Edit1Change(Sender: TObject);
var
   n:integer=0;
 begin
   with FOrmuslugi do
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

procedure TFormuslugi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   //// Автоматический контекстный поиск
   //if (GetSymKey(char(Key))=true) then
   //  begin
   //   formuslugi.Edit1.SetFocus;
   //  end;
   //if (Key=13) and (formuslugi.Edit1.Focused) then Formuslugi.ToolButton8.Click;

  With formuslugi do
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
    if (Key=115) and (Formuslugi.bitbtn12.enabled=true) then Formuslugi.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (Formuslugi.bitbtn1.enabled=true) then Formuslugi.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then Formuslugi.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (Formuslugi.bitbtn2.enabled=true) then Formuslugi.BitBtn2.Click;
    // ESC
    if Key=27 then Formuslugi.Close;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32)  and  (formuslugi.StringGrid1.Focused) then Formuslugi.BitBtn5.Click;

    //if (Key=112) or (Key=13) or (Key=115) or (Key=116) or (Key=119) or (Key=27)   then  Key:=0;

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


procedure TFormuslugi.FormShow(Sender: TObject);
begin
     Formuslugi.UpdateGrid(datatyp,'');
     if flag_access=1 then
     begin
      with Formuslugi do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
end;

procedure TFormuslugi.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TFormuslugi.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
end;

procedure TFormuslugi.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
    Formuslugi.selected_row();
end;

procedure TFormuslugi.ToolButton1Click(Sender: TObject);
begin
   SortGrid(Formuslugi.StringGrid1,Formuslugi.StringGrid1.col,Formuslugi.ProgressBar1,0,1);
end;

procedure TFormuslugi.ToolButton8Click(Sender: TObject);
begin
  GridPoisk(Formuslugi.StringGrid1,Formuslugi.Edit1);
end;

end.

