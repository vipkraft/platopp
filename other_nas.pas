unit other_nas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls,platproc,LazUtf8;

type

  { TForm8 }

  TForm8 = class(TForm)
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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form8: TForm8;
  result_name:string;

implementation
 uses
  mainopp,nas_edit;
{$R *.lfm}

{ TForm8 }

procedure TForm8.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
begin
      // Автоматический контекстный поиск
    if (GetSymKey(char(Key))=true) then
      begin
        form8.Edit1.SetFocus;
      end;
    //ENTER \ ПОИСК
     if (Key=13) and (form8.Edit1.Focused) then Form8.ToolButton8.Click;
       //GridPoisk(form9.StringGrid1,form9.Edit1);

   // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then form8.Close;
    //F7 - Поиск
    if (Key=118) then form8.ToolButton8.Click;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=13)  and  (form8.StringGrid1.Focused) then form8.BitBtn5.Click;

    if (Key=112) or (Key=13) or (Key=27)   then Key:=0;
end;

procedure TForm8.ToolButton1Click(Sender: TObject);
begin
  SortGrid(form8.StringGrid1,form8.StringGrid1.col,form8.ProgressBar1,0,1);
end;

procedure TForm8.ToolButton8Click(Sender: TObject);
begin
   GridPoisk(form8.StringGrid1,form8.Edit1);
end;

procedure TForm8.BitBtn4Click(Sender: TObject);
begin
  form8.close;
end;

procedure TForm8.BitBtn5Click(Sender: TObject);
begin
  if  form8.StringGrid1.rowcount=1 then
     begin
        result_name:='';
        form8.close;
     end
  else
     begin
       result_name:=form8.StringGrid1.Cells[0,form8.StringGrid1.row];
       form8.close;
     end;
end;

procedure TForm8.FormShow(Sender: TObject);
var
   n:integer;
   select_str:string;
begin
  Centrform(form8);
 With form8 do
 begin
 result_name:='';
 // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   form8.ZQuery1.SQL.Clear;
   // Выбор всего списка
   form8.ZQuery1.SQL.add('Select id,name,typnas,rajon,region,typ_region,land from av_spr_geokladr ');
    select_str:='WHERE';
   if not(trim(form6.Edit2.text)='') then select_str:=select_str+' upper(name) LIKE upper('+Quotedstr(trim(form6.Edit2.text)+'%')+')';
   if not(trim(form6.Edit3.text)='') and not (select_str='WHERE') then select_str:=select_str+' AND upper(land) LIKE upper('+Quotedstr(trim(form6.Edit3.text)+'%')+')';
   if not(trim(form6.Edit3.text)='') and (select_str='WHERE') then select_str:=select_str+' upper(land) LIKE upper('+Quotedstr(trim(form6.Edit3.text)+'%')+')';
   if not(trim(form6.Edit4.text)='') and not (select_str='WHERE') then select_str:=select_str+' AND upper(region) LIKE upper('+Quotedstr(trim(form6.Edit4.text)+'%')+')';
   if not(trim(form6.Edit4.text)='') and (select_str='WHERE') then select_str:=select_str+' upper(region) LIKE upper('+Quotedstr(trim(form6.Edit4.text)+'%')+')';
   if not(trim(form6.Edit5.text)='') and not (select_str='WHERE') then select_str:=select_str+' AND upper(rajon) LIKE upper('+Quotedstr(trim(form6.Edit5.text)+'%')+')';
   if not(trim(form6.Edit5.text)='') and (select_str='WHERE') then select_str:=select_str+' upper(rajon) LIKE upper('+Quotedstr(trim(form6.Edit5.text)+'%')+')';
   form8.ZQuery1.SQL.add(select_str+' order by name;');
   form8.ZQuery1.open;
   if form8.ZQuery1.RecordCount=0 then
     begin
      form8.ZQuery1.Close;
      form8.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   form8.ProgressBar1.Max:=form8.ZQuery1.RecordCount;
   form8.ProgressBar1.Visible:=true;
   form8.StringGrid1.RowCount:=form8.ZQuery1.RecordCount+1;
   for n:=1 to form8.ZQuery1.RecordCount do
    begin
      form8.ProgressBar1.Position:=form8.ProgressBar1.Position+1;
      form8.ProgressBar1.Refresh;
      form8.StringGrid1.Cells[0,n]:=form8.ZQuery1.FieldByName('id').asString;
      form8.StringGrid1.Cells[1,n]:=form8.ZQuery1.FieldByName('Name').asString;
      form8.StringGrid1.Cells[2,n]:=form8.ZQuery1.FieldByName('typnas').asString;
      form8.StringGrid1.Cells[3,n]:=form8.ZQuery1.FieldByName('rajon').asString;
      form8.StringGrid1.Cells[4,n]:=form8.ZQuery1.FieldByName('region').asString;
      form8.StringGrid1.Cells[5,n]:=form8.ZQuery1.FieldByName('typ_region').asString;
      form8.StringGrid1.Cells[6,n]:=form8.ZQuery1.FieldByName('land').asString;
      form8.ZQuery1.Next;
    end;
   form8.ProgressBar1.Position:=0;
   form8.ProgressBar1.Visible:=false;
   form8.ZQuery1.Close;
   form8.Zconnection1.disconnect;
 end;
end;



end.

