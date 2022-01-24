unit lgot_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids,platproc,lgot_edit, LazUtf8;

type

  { TFormlgot }

  TFormlgot = class(TForm)
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
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure UpdateGrid(filter_type:byte; stroka:string);
    procedure selected_row();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formlgot: TFormlgot;
  flag_edit_lgot:integer;
  result_name_lgot, result_id_lgot :string;

implementation
uses
  mainopp;
{$R *.lfm}

{ TFormlgot }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

procedure TFormlgot.Selected_row();
begin
  With FormLgot do
  begin
  formlgot.Memo1.Clear;
  if (trim(formlgot.StringGrid1.Cells[0,formlgot.StringGrid1.row])='') or (formlgot.StringGrid1.row=0) then exit;
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
  // Определяем дополнительное описание закона
  formlgot.ZQuery1.SQL.clear;
  formlgot.ZQuery1.SQL.add('select swed from av_spr_lgot where del=0 and id='+trim(formlgot.StringGrid1.Cells[0,formlgot.StringGrid1.row])+';');
  formlgot.ZQuery1.open;
  if formlgot.ZQuery1.RecordCount=0 then
     begin
       formlgot.ZQuery1.close;
       formlgot.ZConnection1.Disconnect;
       exit;
     end;
   formlgot.Memo1.Clear;
   formlgot.Memo1.Text:=formlgot.ZQuery1.FieldByName('swed').asString;
   formlgot.ZQuery1.close;
   formlgot.ZConnection1.Disconnect;
   form1.StringGrid1.Setfocus;
  end;
end;

procedure TFormlgot.UpdateGrid(filter_type:byte; stroka:string);
var
  n:integer;
begin
  //With FormLgot do
  //begin
  // StringGrid1.RowCount:=1;
  //// Подключаемся к серверу
  // If not(Connect2(Zconnection1, flagProfile)) then
  //   begin
  //    showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
  //    Close;
  //    exit;
  //   end;
  //// Определяем пользователя
  //formlgot.ZQuery1.SQL.clear;
  //formlgot.ZQuery1.SQL.add('select id,name,short_name,zakon,swed from av_spr_lgot where del=0;');
  ////showmessage(formlgot.ZQuery1.SQL.Text);
  //formlgot.ZQuery1.open;
  //if formlgot.ZQuery1.RecordCount=0 then
  //   begin
  //     formlgot.ZQuery1.close;
  //     formlgot.ZConnection1.Disconnect;
  //     exit;
  //   end;
  //// Заполняем stringgrid
  //formlgot.StringGrid1.RowCount:=formlgot.ZQuery1.RecordCount+1;
  //for n:=1 to formlgot.StringGrid1.RowCount-1 do
  // begin
  //   formlgot.StringGrid1.Cells[0,n]:=formlgot.ZQuery1.FieldByName('id').asString;
  //   formlgot.StringGrid1.Cells[1,n]:=formlgot.ZQuery1.FieldByName('name').asString;
  //   formlgot.StringGrid1.Cells[2,n]:=trim(formlgot.ZQuery1.FieldByName('short_name').asString);
  //   formlgot.StringGrid1.Cells[3,n]:=formlgot.ZQuery1.FieldByName('zakon').asString;
  //   formlgot.ZQuery1.Next;
  //end;
  ////formlgot.memo1.Text:=trim(formlgot.ZQuery1.FieldByName('swed').asString);
  //formlgot.ZQuery1.Close;
  //formlgot.Zconnection1.disconnect;
  //formlgot.selected_row();
  //formlgot.StringGrid1.SetFocus;
  //end;
  With FormLgot do
  begin
   StringGrid1.RowCount:=1;
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
  // Определяем пользователя
  formlgot.ZQuery1.SQL.clear;
  formlgot.ZQuery1.SQL.add('select id,name,short_name,zakon,swed from av_spr_lgot where del=0 ');
  if (stroka<>'') and (filter_type=2) then ZQuery1.SQL.add('and name ilike '+quotedstr(stroka+'%'));
  if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('and cast(id as text) like '+quotedstr(stroka+'%'));
  //showmessage(formlgot.ZQuery1.SQL.Text);
  formlgot.ZQuery1.open;
  if formlgot.ZQuery1.RecordCount=0 then
     begin
       formlgot.ZQuery1.close;
       formlgot.ZConnection1.Disconnect;
       exit;
     end;
  // Заполняем stringgrid
  formlgot.StringGrid1.RowCount:=formlgot.ZQuery1.RecordCount+1;
  for n:=1 to formlgot.StringGrid1.RowCount-1 do
   begin
     formlgot.StringGrid1.Cells[0,n]:=formlgot.ZQuery1.FieldByName('id').asString;
     formlgot.StringGrid1.Cells[1,n]:=formlgot.ZQuery1.FieldByName('name').asString;
     formlgot.StringGrid1.Cells[2,n]:=trim(formlgot.ZQuery1.FieldByName('short_name').asString);
     formlgot.StringGrid1.Cells[3,n]:=formlgot.ZQuery1.FieldByName('zakon').asString;
     formlgot.ZQuery1.Next;
  end;
  //formlgot.memo1.Text:=trim(formlgot.ZQuery1.FieldByName('swed').asString);
  formlgot.ZQuery1.Close;
  formlgot.Zconnection1.disconnect;
  formlgot.selected_row();
  //formlgot.StringGrid1.SetFocus;
  end;
end;

procedure TFormlgot.BitBtn1Click(Sender: TObject);
begin
  //Создаем новую запись
  flag_edit_lgot:=1;
  formlgot_edit:=Tformlgot_edit.create(self);
  formlgot_edit.ShowModal;
  FreeAndNil(formlgot_edit);
  formlgot.UpdateGrid(datatyp,'');
end;

procedure TFormlgot.BitBtn2Click(Sender: TObject);
begin
  with FOrmLgot do
  begin
  //Удаляем запись
   if (trim(formlgot.StringGrid1.Cells[0,formlgot.StringGrid1.row])='') or (formlgot.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

 If dialogs.MessageDlg('Удалить выбранную льготу ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;

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
     formlgot.ZQuery1.SQL.Clear;
     formlgot.ZQuery1.SQL.add('UPDATE av_spr_lgot SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(formlgot.StringGrid1.Cells[0,formlgot.StringGrid1.row])+' and del=0;');
     formlgot.ZQuery1.ExecSQL;
       //завершение транзакции
   Zconnection1.Commit;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.close;
     Zconnection1.disconnect;
     exit;
   end;
   ZQuery1.close;
   Zconnection1.disconnect;
   formlgot.UpdateGrid(datatyp,'');
  end;
end;

procedure TFormlgot.BitBtn12Click(Sender: TObject);
begin
    //Создаем новую запись
  flag_edit_lgot:=2;
  formlgot_edit:=Tformlgot_edit.create(self);
  formlgot_edit.ShowModal;
  FreeAndNil(formlgot_edit);
  formlgot.UpdateGrid(datatyp,'');
end;

procedure TFormlgot.BitBtn4Click(Sender: TObject);
begin
  formlgot.close;
end;

procedure TFormlgot.BitBtn5Click(Sender: TObject);
begin
   result_name_lgot:=formlgot.StringGrid1.Cells[1,formlgot.StringGrid1.row];
   result_id_lgot:=formlgot.StringGrid1.Cells[0,formlgot.StringGrid1.row];
   formlgot.close;
end;

procedure TFormlgot.Edit1Change(Sender: TObject);
var
   n:integer=0;
 begin
   with FOrmlgot do
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

procedure TFormlgot.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //// Автоматический контекстный поиск
    //if (GetSymKey(char(Key))=true) then
    //  begin
    //    formlgot.Edit1.SetFocus;
    //  end;
    //if (Key=13) and (formlgot.Edit1.Focused) then Formlgot.ToolButton8.Click;

  With formlgot do
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
    if (Key=115) and (formlgot.bitbtn12.enabled=true) then formlgot.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (formlgot.bitbtn1.enabled=true) then formlgot.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then FormLgot.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (formlgot.bitbtn2.enabled=true) then formlgot.BitBtn2.Click;
    // ESC
    if Key=27 then formlgot.Close;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32)  and  (formlgot.StringGrid1.Focused) then  formlgot.BitBtn5.Click;

    //if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=13)   then Key:=0;

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


procedure TFormlgot.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TFormlgot.FormShow(Sender: TObject);
begin
   formlgot.UpdateGrid(datatyp,'');
   if flag_access=1 then
     begin
      with formlgot do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
end;

procedure TFormlgot.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TFormlgot.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
end;

procedure TFormlgot.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
    formlgot.selected_row();
end;


end.

