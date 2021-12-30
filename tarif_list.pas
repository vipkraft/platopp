unit tarif_list;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  Buttons, ExtCtrls, StdCtrls, ComCtrls,platproc;

type

  { TForml }

  TForml = class(TForm)
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
    StringGrid2: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1Exit(Sender: TObject);
    procedure StringGrid2Enter(Sender: TObject);
    procedure StringGrid2Exit(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid1();
    procedure UpdateGrid2();
 private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Forml: TForml;
  tmpkat:array of array of string;
  tmpopt:array of array of string;
  tekgrid:byte;

implementation

{$R *.lfm}

{ TForml }

// Обновление GRID1
procedure TForml.UpdateGrid1();
 var
   n:integer;
 begin
   forml.StringGrid1.rowcount:=1;
   for n:=0 to length(tmpkat)-1 do
     begin
        forml.StringGrid1.rowcount:=forml.StringGrid1.rowcount+1;
        forml.StringGrid1.Cells[0,forml.StringGrid1.RowCount-1]:=tmpkat[n,0];
        forml.StringGrid1.Cells[1,forml.StringGrid1.RowCount-1]:=tmpkat[n,1];
     end;
 end;

// Обновление GRID2
procedure TForml.UpdateGrid2();
 var
   n:integer;
 begin
   forml.StringGrid2.rowcount:=1;
   for n:=0 to length(tmpopt)-1 do
     begin
        forml.StringGrid2.rowcount:=forml.StringGrid2.rowcount+1;
        forml.StringGrid2.Cells[0,forml.StringGrid2.RowCount-1]:=tmpopt[n,0];
        forml.StringGrid2.Cells[1,forml.StringGrid2.RowCount-1]:=tmpopt[n,1];
        forml.StringGrid2.Cells[2,forml.StringGrid2.RowCount-1]:=tmpopt[n,2];
     end;
 end;


procedure TForml.ToolButton1Click(Sender: TObject);
begin
  SortGrid(forml.StringGrid2,forml.StringGrid2.col,forml.ProgressBar1);
end;

procedure TForml.ToolButton8Click(Sender: TObject);
begin
    GridPoisk(forml.StringGrid2,forml.Edit1);
end;

procedure TForml.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
     // Автоматический контекстный поиск
    if (GetSymKey(char(Key))=true) then
       begin
        forml.Edit1.SetFocus;
       end;
    if (Key=13) and (forml.Edit1.Focused) then Forml.ToolButton8.Click;
    // F1
    if Key=112 then showmessage('F1 - Справка'+#13+'F4 - Изменить'+#13+'F5 - Добавить'+#13+'F7 - Поиск'+#13+'F8 - Удалить'+#13+'ESC - Отмена\Выход');

    //F4 - Изменить
    if (Key=115) and (forml.bitbtn12.enabled=true) then forml.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (forml.bitbtn1.enabled=true) then forml.BitBtn1.Click;
    //F7 - Поиск
    if (Key=118) then Forml.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (forml.bitbtn2.enabled=true) then forml.BitBtn2.Click;
    // ESC
    if Key=27 then forml.Close;
    // ENTER
    {if (Key=13)  and  (formtarif.StringGrid1.Focused) then
      begin
        result_name_lgot:=formtarif.StringGrid1.Cells[1,formtarif.StringGrid1.row];
        formtarif.close;
      end;}
    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) then Key:=0;
end;

procedure TForml.StringGrid1Enter(Sender: TObject);
begin
 forml.StringGrid1.Color:=clCream;
  tekgrid:=1;
end;

procedure TForml.StringGrid1Exit(Sender: TObject);
begin
  forml.StringGrid1.Color:=clWhite;
end;

procedure TForml.StringGrid2Enter(Sender: TObject);
begin
   forml.StringGrid2.Color:=clCream;
   tekgrid:=2;
end;

procedure TForml.StringGrid2Exit(Sender: TObject);
begin
   forml.StringGrid2.Color:=clWhite;
end;

procedure TForml.BitBtn4Click(Sender: TObject);
begin
  forml.close;
end;

procedure TForml.BitBtn1Click(Sender: TObject);
 var
   s,ss:string;
begin
   // Добавляем категорию
   if  tekgrid=1 then
     begin
        if MessageDlg('Вы действительно хотите добавить КАТЕГОРИЮ ТАРИФА ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;
        if not(tmpkat[0,0]='') then
          begin
            s:='';
            if inputQuery('Новая категория тарифа','Введите наименование категории тарифа',s) then
              begin
                setlength(tmpkat,length(tmpkat)+1,2);
                tmpkat[length(tmpkat)-1,0]:=inttostr(strtoint(tmpkat[length(tmpkat)-2,0])+1);
                tmpkat[length(tmpkat)-1,1]:=s;
              end;
          end
        else
          begin
            s:='';
            if inputQuery('Новая категория тарифа','Введите наименование категории тарифа',s) then
              begin
                tmpkat[0,0]:='1';
                tmpkat[0,1]:=s;
              end;
          end;
       forml.updategrid1;
     end;

   // Добавляем опцию

   if tekgrid=2 then
     begin
       if trim(forml.StringGrid1.Cells[0,forml.StringGrid1.row])='' then
         begin
           showmessage('Не выбрана КАТЕГОРИЯ ТАРИФА !');
           exit;
         end;
       if MessageDlg('Вы действительно хотите добавить ОПЦИЮ ТАРИФА ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;
       if not(tmpopt[0,0]='') then
         begin
           s:='';
           ss:='';
           if inputQuery('Новая опция тарифа','Введите наименование опции тарифа',s) and inputQuery('Новая абревиатура опции тарифа','Введите абревиатуру опции тарифа',ss) then
             begin
               setlength(tmpopt,length(tmpopt)+1,3);
               tmpopt[length(tmpopt)-1,0]:=inttostr(strtoint(tmpopt[length(tmpopt)-2,0])+1);
               tmpopt[length(tmpopt)-1,1]:=s;
               tmpopt[length(tmpopt)-1,2]:=ss;
             end;
         end
       else
         begin
           s:='';
           ss:='';
           if inputQuery('Новая опция тарифа','Введите наименование опции тарифа',s) and inputQuery('Новая абревиатура опции тарифа','Введите абревиатуру опции тарифа',ss) then
             begin
               tmpopt[0,0]:='1';
               tmpopt[0,1]:=s;
               tmpopt[0,2]:=ss;
             end;
         end;
      forml.updategrid2;
     end;

end;

procedure TForml.FormCreate(Sender: TObject);
begin
  setlength(tmpkat,1,2);
  setlength(tmpopt,1,3);
  tekgrid:=1;
end;

end.

