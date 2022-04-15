unit read_nas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, StdCtrls, ComCtrls, ExtCtrls, platproc, LazUtf8;

type

  { TForm7 }

  TForm7 = class(TForm)
    BitBtn3: TBitBtn;
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
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form7: TForm7;
  result_name_full:string;
  type_read:integer;

implementation
 uses
   mainopp,nas_edit,point_edit,ats_edit;
{$R *.lfm}

{ TForm7 }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;


procedure TForm7.UpdateGrid(filter_type:byte; stroka:string);
var
  n:integer;
begin

    With Form7 do
 begin
 // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   form7.ZQuery1.SQL.Clear;
   // Выбор нас.пункта
   if type_read=1 then form7.ZQuery1.SQL.add('select distinct(name) as name from av_spr_locality ');
   // Выбор государство
   if type_read=2 then form7.ZQuery1.SQL.add('select distinct(land) as name from av_spr_locality ');
   // Выбор регион
   if type_read=3 then form7.ZQuery1.SQL.add('select distinct(region) as name from av_spr_locality ');
   // Выбор район
   if type_read=4 then form7.ZQuery1.SQL.add('select distinct(rajon) as name from av_spr_locality ');
   // Выбор ip
   if type_read=5 then form7.ZQuery1.SQL.add('select distinct(name) from av_spr_point ');
   // Выбор марки АТС
   if type_read=6 then form7.ZQuery1.SQL.add('select distinct(name) from av_spr_ats ');

   form7.ZQuery1.SQL.add(' WHERE del=0 ');

   if (stroka<>'') then ZQuery1.SQL.add('and name ilike '+quotedstr(stroka+'%'));

   form7.ZQuery1.SQL.add('ORDER BY name;');
   form7.ZQuery1.open;
   if form7.ZQuery1.RecordCount=0 then
     begin
      form7.ZQuery1.Close;
      form7.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   form7.StringGrid1.RowCount:=form7.ZQuery1.RecordCount+1;
   for n:=1 to form7.ZQuery1.RecordCount do
    begin
      form7.StringGrid1.Cells[0,n]:=form7.ZQuery1.FieldByName('name').asString;
      form7.ZQuery1.Next;
    end;
   form7.ZQuery1.Close;
   form7.Zconnection1.disconnect;
 end;

end;

procedure TForm7.ToolButton1Click(Sender: TObject);
begin
 SortGrid(form7.StringGrid1,form7.StringGrid1.col,form7.ProgressBar1,0,1);
end;

procedure TForm7.BitBtn4Click(Sender: TObject);
begin
  form7.close;
end;

procedure TForm7.BitBtn5Click(Sender: TObject);
begin
  if form7.StringGrid1.RowCount=1 then
    begin
      showmessagealt('Нельзя выбрать из пустого списка !');
      exit;
    end
  else
    begin
      result_name_full:=form7.StringGrid1.Cells[0,form7.StringGrid1.Row];
      form7.Close;
    end;
end;

procedure TForm7.Edit1Change(Sender: TObject);
var
   n:integer=0;
 begin
   with FOrm7 do
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

procedure TForm7.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
    //// Автоматический контекстный поиск
    //if (GetSymKey(char(Key))=true) then
    // begin
    //  form7.Edit1.SetFocus;
    // end;
    //if (Key=13) and (form7.Edit1.Focused) then Form7.ToolButton8.Click;
  With form7 do
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
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then form7.Close;
    //F7 - Поиск
    //if (Key=118) then form7.ToolButton8.Click;
    // ENTER
   if (Key=13)  and  (form7.StringGrid1.Focused) then
      begin
        result_name_full:=form7.StringGrid1.Cells[0,form7.StringGrid1.row];
        form7.close;
      end;
    //if (Key=112) or (Key=13) or (Key=27) then Key:=0;
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

procedure TForm7.FormShow(Sender: TObject);
 var
   n:integer;
begin
 result_name_full:='';
 Form7.UpdateGrid(datatyp,'');
 //With Form7 do
 //begin
 //// Подключаемся к серверу
 //  If not(Connect2(Zconnection1, flagProfile)) then
 //    begin
 //     showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
 //     Close;
 //     exit;
 //    end;
 //  //запрос списка
 //  form7.ZQuery1.SQL.Clear;
 //  // Выбор нас.пункта
 //  if type_read=1 then form7.ZQuery1.SQL.add('select distinct(name) as name from av_spr_locality ');
 //  // Выбор государство
 //  if type_read=2 then form7.ZQuery1.SQL.add('select distinct(land) as name from av_spr_locality ');
 //  // Выбор регион
 //  if type_read=3 then form7.ZQuery1.SQL.add('select distinct(region) as name from av_spr_locality ');
 //  // Выбор район
 //  if type_read=4 then form7.ZQuery1.SQL.add('select distinct(rajon) as name from av_spr_locality ');
 //  // Выбор ip
 //  if type_read=5 then form7.ZQuery1.SQL.add('select distinct(name) from av_spr_point ');
 //  // Выбор марки АТС
 //  if type_read=6 then form7.ZQuery1.SQL.add('select distinct(name) from av_spr_ats ');
 //
 //  form7.ZQuery1.SQL.add(' WHERE del=0 ORDER BY name;');
 //  form7.ZQuery1.open;
 //  if form7.ZQuery1.RecordCount=0 then
 //    begin
 //     form7.ZQuery1.Close;
 //     form7.Zconnection1.disconnect;
 //     exit;
 //    end;
 //  // Заполняем stringgrid
 //  form7.StringGrid1.RowCount:=form7.ZQuery1.RecordCount+1;
 //  for n:=1 to form7.ZQuery1.RecordCount do
 //   begin
 //     form7.StringGrid1.Cells[0,n]:=form7.ZQuery1.FieldByName('name').asString;
 //     form7.ZQuery1.Next;
 //   end;
 //  form7.ZQuery1.Close;
 //  form7.Zconnection1.disconnect;
 //end;
end;

procedure TForm7.ToolButton8Click(Sender: TObject);
begin
    GridPoisk(form7.StringGrid1,form7.Edit1);
end;

end.

