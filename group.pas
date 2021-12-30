unit group;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Buttons, ComCtrls, StdCtrls, Grids, ExtCtrls,platproc,group_edit, LazUtf8;

type

  { TForm11 }

  TForm11 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
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
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1Enter(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form11: TForm11; 
  flag_edit:integer;
  result_name:string;

implementation
 uses
   mainopp;
{$R *.lfm}

{ TForm11 }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

procedure TForm11.UpdateGrid(filter_type:byte; stroka:string);
 var
   n:integer;
begin
  //with Form11 do
  //begin
  //   // Подключаемся к серверу
  // If not(Connect2(Zconnection1, flagProfile)) then
  //   begin
  //    showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
  //    Close;
  //    exit;
  //   end;
  // // Определяем пользователя
  // form11.ZQuery1.SQL.clear;
  // form11.ZQuery1.SQL.add('select id,name from av_spr_point_group where del=0;');
  // form11.ZQuery1.open;
  //
  // // Заполняем stringgrid
  // form11.StringGrid1.RowCount:=form11.ZQuery1.RecordCount+1;
  // for n:=1 to form11.ZQuery1.RecordCount do
  //  begin
  //    form11.StringGrid1.Cells[0,n]:=form11.ZQuery1.FieldByName('id').asString;
  //    form11.StringGrid1.Cells[1,n]:=form11.ZQuery1.FieldByName('name').asString;
  //    form11.ZQuery1.Next;
  //  end;
  // form11.ZQuery1.Close;
  // form11.Zconnection1.disconnect;
  // form11.StringGrid1.Refresh;
  //end;
  with Form11 do
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
   form11.ZQuery1.SQL.clear;
   form11.ZQuery1.SQL.add('select id,name from av_spr_point_group where del=0 ');
   if (stroka<>'') and (filter_type=2) then ZQuery1.SQL.add('and name ilike '+quotedstr(stroka+'%'));
   if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('and cast(id as text) like '+quotedstr(stroka+'%'));
   form11.ZQuery1.open;

   // Заполняем stringgrid
   form11.StringGrid1.RowCount:=form11.ZQuery1.RecordCount+1;
   for n:=1 to form11.ZQuery1.RecordCount do
    begin
      form11.StringGrid1.Cells[0,n]:=form11.ZQuery1.FieldByName('id').asString;
      form11.StringGrid1.Cells[1,n]:=form11.ZQuery1.FieldByName('name').asString;
      form11.ZQuery1.Next;
    end;
   form11.ZQuery1.Close;
   form11.Zconnection1.disconnect;
   form11.StringGrid1.Refresh;
  end;
end;


procedure TForm11.BitBtn4Click(Sender: TObject);
begin
  form11.Close;
end;

procedure TForm11.BitBtn5Click(Sender: TObject);
begin
          result_name:=form11.StringGrid1.Cells[0,form11.StringGrid1.row];
        form11.close;
end;

procedure TForm11.Edit1Change(Sender: TObject);
 var
   n:integer=0;
 begin
   with FOrm11 do
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

procedure TForm11.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
   //// Автоматический контекстный поиск
   // if (GetSymKey(char(Key))=true) then
   //   begin
   //     form11.Edit1.SetFocus;
   //   end;
   // //enter - ПОИСК
   // if (Key=13) and (form11.Edit1.Focused) then Form11.ToolButton8.Click;

  With form11 do
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
    if (Key=115) and (form11.bitbtn12.enabled=true) then form11.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (form11.bitbtn1.enabled=true) then form11.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then form11.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (form11.bitbtn2.enabled=true) then form11.BitBtn2.Click;
    // ESC
    if Key=27 then form11.Close;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32)  and  (form11.StringGrid1.Focused) then
     begin
        result_name:=form11.StringGrid1.Cells[0,form11.StringGrid1.row];
        form11.close;
      end;

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

procedure TForm11.FormShow(Sender: TObject);
begin
   Centrform(form11);
   form11.UpdateGrid(datatyp,'');
   if flag_access=1 then
     begin
      with form11 do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
   StringGrid1.SetFocus;
end;

procedure TForm11.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TForm11.BitBtn1Click(Sender: TObject);
begin
  //Создаем новую запись населенного пункта
  flag_edit:=1;
  form12:=Tform12.create(self);
  form12.ShowModal;
  FreeAndNil(form12);
  form11.UpdateGrid(datatyp,'');
end;

procedure TForm11.BitBtn2Click(Sender: TObject);
 var
   resF : byte;
   res_flag:integer;
begin
  with FOrm11 do
  begin
      //Удаляем запись
   if (trim(form11.StringGrid1.Cells[0,form11.StringGrid1.row])='') or (form11.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

    res_flag := dialogs.MessageDlg('Удалить выбранную группу ?',mtConfirmation,[mbYes,mbNO], 0);
    if res_flag<>6 then exit;

     //**************** проверка на возможность удаления записи  *****************************************
  resF := DelCheck(Form11.StringGrid1, 0, Form11.ZConnection1, Form11.ZQuery1, 'av_spr_point.id_group,');
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
     form11.ZQuery1.SQL.Clear;
     form11.ZQuery1.SQL.add('UPDATE av_spr_point_group SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(form11.StringGrid1.Cells[0,form11.StringGrid1.row])+' and del=0;');
     form11.ZQuery1.ExecSQL;
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
     form11.UpdateGrid(datatyp,'');

  end;
end;

procedure TForm11.BitBtn12Click(Sender: TObject);
begin
  //Создаем новую запись населенного пункта
  flag_edit:=2;
  form12:=Tform12.create(self);
  form12.ShowModal;
  FreeAndNil(form12);
  form11.UpdateGrid(datatyp,'');
end;

procedure TForm11.ToolButton1Click(Sender: TObject);
begin
  SortGrid(form11.StringGrid1,form11.StringGrid1.col,form11.ProgressBar1,0,1);
end;

procedure TForm11.ToolButton8Click(Sender: TObject);
begin
   GridPoisk(form11.StringGrid1,form11.Edit1);
end;

end.

