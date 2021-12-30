unit fullmap;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, math;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    PaintBox1: TPaintBox;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form2: TForm2;
  step,stepx,stepy:integer;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
 var
 n,x,y:integer;
 z:Float;
begin

  form2.ZQuery1.SQL.Clear;
  form2.ZQuery1.SQL.Add('SELECT name, kod, typnas, id, lat, lon FROM av_geonas where kod like '+Quotedstr('26%')+'  and not(lat='+Quotedstr('0')+');');
  form2.ZQuery1.Open;
  for n:=1 to form2.ZQuery1.RecordCount do
     begin
       z:=StrToFloat(form2.ZQuery1.FieldByName('lat').asString);
       x:=strtoint(copy(form2.ZQuery1.FieldByName('lat').asString,1,2)+copy(form2.ZQuery1.FieldByName('lat').asString,4,40)) div (form2.PaintBox1.Width div 40);
       y:=strtoint(copy(form2.ZQuery1.FieldByName('lon').asString,1,2)+copy(form2.ZQuery1.FieldByName('lon').asString,4,40)) div (form2.PaintBox1.height div 40);
  //     showmessagealt(inttostr(x)+'   '+inttostr(y));
       form2.PaintBox1.Canvas.Brush.Color :=clRed;
       // Эллипс
       form2.PaintBox1.Canvas.Ellipse(x,y,x+10,y+10);
       form2.ZQuery1.Next;
     end;
  form2.ZQuery1.Close;

  {SELECT "name", kod, typnas, id, lat, lon
    FROM av_geonas
    where kod like '26%';}
   //form2.PaintBox1.Canvas.Pen.Color:=clBlue;
   //form2.PaintBox1.Canvas.MoveTo(0,200);
   //form2.PaintBox1.Canvas.Line(10,10,100,100);
   {  var x:integer;
   begin
   Form1.Canvas.Pen.Color:=clBlue; // Цвет синусоиды
   Form1.Canvas.MoveTo(0,200); // Начальная точка по оси Y
   for x:=0 to Form1.ClientWidth-1 do
   begin
     Form1.Canvas.LineTo(x, trunc(20*sin(x + 10)) + 200); // В цикле рисуем синусоиду. trunc(20*sin(x + 10)) + 200 - это хитрое выражение необходимо для того, чтобы график не был бы таким суженым
   end;}
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  step:=0;
  stepx:=0;
  stepy:=0;
end;

procedure TForm2.PaintBox1Click(Sender: TObject);
begin
end;

procedure TForm2.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // если значения есть
  if step=1 then
   begin
      form2.PaintBox1.Canvas.Line(stepx,stepy,x,y);
      step:=0;
   end;
  // если значений нет
  if step=0 then
   begin
      stepx:=x;
      stepy:=y;
      step:=1;
   end;

end;

end.

