unit sprregion;

{$mode objfpc}{$H+}

interface

uses
  //Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  //Dialogs, StdCtrls, Grids, DBGrids,platproc, dbf, db,LConvEncoding,strutils,unix,Variants,types;


Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
 StdCtrls, Buttons, ExtCtrls, types, dbf, ZConnection,
 ZDataset, LConvEncoding, Grids, Variants, platproc, unix, DB,LCLProc, LazHelpHTML, UTF8Process;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Datasource1: TDatasource;
    Dbf1: TDbf;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    Timer2: TTimer;
    ZConnection1: TZConnection;
    ZConnection2: TZConnection;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    ZQuery3: TZQuery;
    procedure Button10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form3: TForm3;
  da1,net1,da2,net2:integer;
  //My_Header:array of integer;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.Button1Click(Sender: TObject);
begin
end;

procedure TForm3.Button10Click(Sender: TObject);
 var
   n:integer;
begin
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT * FROM av_spr_locality;');
  form3.ZQuery1.open;
  form3.StringGrid1.RowCount:=form3.ZQuery1.RecordCount+1;
  for n:=0 to  form3.ZQuery1.RecordCount-1 do
    begin
      form3.StringGrid1.Cells[0,n+1]:=form3.ZQuery1.FieldByName('id').asString;
      form3.StringGrid1.Cells[1,n+1]:=form3.ZQuery1.FieldByName('name').asString;
      form3.StringGrid1.Cells[2,n+1]:=form3.ZQuery1.FieldByName('rajon').asString;
      form3.ZQuery1.Next;
    end;
  form3.ZQuery1.close;
  // Завершение транзакции
end;

procedure TForm3.Button2Click(Sender: TObject);
 var
   n:integer;
begin
  //av_region
  {form3.Zconnection1.connect;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT name, socr, code FROM kladr where code LIKE '+Quotedstr('%0000000000')+';');
  form3.ZQuery1.open;
  for n:=1 to form3.ZQuery1.RecordCount do
     begin
       fo rm3.ZQuery2.SQL.Clear;
       form3.ZQuery2.SQL.add('INSERT INTO av_region2(code,name,socr) VALUES ('+QuotedStr(form3.ZQuery1.FieldByName('code').AsString)+', '+QuotedStr(form3.ZQuery1.FieldByName('name').AsWideString)+','+QuotedStr(form3.ZQuery1.FieldByName('socr').asString)+');');
       form3.ZQuery2.ExecSQL;
       form3.ZQuery1.next;
     end;
  form3.ZQuery1.Close;
  form3.ZQuery2.Close;
  form3.Zconnection1.disconnect;}

  //av_rajon2
{  form3.Zconnection1.connect;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT name, socr, code FROM kladr where code LIKE '+Quotedstr('%0000000')+';');
  form3.ZQuery1.open;
  for n:=1 to form3.ZQuery1.RecordCount do
     begin
       form3.ZQuery2.SQL.Clear;
       if not(copy(form3.ZQuery1.FieldByName('code').AsString,3,3)='000') then
         begin
          form3.ZQuery2.SQL.add('INSERT INTO av_rajon2(code,name) VALUES ('+QuotedStr(form3.ZQuery1.FieldByName('code').AsString)+', '+QuotedStr(form3.ZQuery1.FieldByName('name').AsWideString)+');');
          form3.ZQuery2.ExecSQL;
         end;
       form3.ZQuery1.next;
     end;
  form3.ZQuery1.Close;
  form3.ZQuery2.Close;
  form3.Zconnection1.disconnect;}



  //kladr2
  {form3.Zconnection1.connect;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT a.code,a.name,a.socr,d.lat,d.long,a.isf,a.region,b."name" as name_region,b.socr as typ_region,c."name" as name_rajon ');
  form3.ZQuery1.SQL.add('FROM kladr a,kladr b,kladr c,av_geonas2 d ');
  form3.ZQuery1.SQL.add('WHERE b.isf=1 and a.isf=3 and c.isf=2 and ');
  form3.ZQuery1.SQL.add('(substring(a.code,1,2)=substring(b.code,1,2)) and ');
  form3.ZQuery1.SQL.add('(substring(a.code,3,3)=substring(c.code,3,3) and substring(c.code,1,2)=substring(b.code,1,2)) and (d.kod2=a.code);');
  form3.ZQuery1.open;
  for n:=1 to form3.ZQuery1.RecordCount do
     begin
       form3.label1.Caption:=inttostr(n)+' из '+inttostr(form3.ZQuery1.RecordCount);
       form3.Label1.Repaint;
       form3.ZQuery2.SQL.Clear;
       form3.ZQuery2.SQL.add('INSERT INTO av_spr_geokladr(id, name, typnas, land, region, rajon, code_kladr, typ_region) VALUES (');
       form3.ZQuery2.SQL.add(inttostr(n)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name').AsWideString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('socr').AsString)+',');
       form3.ZQuery2.SQL.add(QuotedStr('Россия')+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name_region').AsWideString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name_rajon').AsWideString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('code').AsString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('typ_region').AsString));
       form3.ZQuery2.SQL.add(');');
       form3.ZQuery2.ExecSQL;
       form3.ZQuery1.next;
     end;
  form3.ZQuery1.Close;
  form3.ZQuery2.Close;
  form3.Zconnection1.disconnect; }





    //av_locality
{  form3.Zconnection1.connect;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT * from av_geonas where fl>2;');
  form3.ZQuery1.open;
  for n:=1 to form3.ZQuery1.RecordCount do
     begin
       form3.label1.Caption:=inttostr(n)+' из '+inttostr(form3.ZQuery1.RecordCount);
       form3.ZQuery2.SQL.Clear;
       form3.ZQuery2.SQL.add('INSERT INTO av_locality(id,name,id_r,id_land,id_region,lat,lon,typ_loc) VALUES ('+copy(form3.ZQuery1.FieldByName('kod').asString,6,8)+', '+QuotedStr(form3.ZQuery1.FieldByName('name').asString)+','+copy(form3.ZQuery1.FieldByName('kod').asString,4,2)+',1,'+copy(form3.ZQuery1.FieldByName('kod').asString,1,3)+','+form3.ZQuery1.FieldByName('lat').asString+','+form3.ZQuery1.FieldByName('lon').asString+','+Quotedstr(form3.ZQuery1.FieldByName('typnas').asString)+');');
       form3.ZQuery2.ExecSQL;
       form3.ZQuery1.next;
     end;
  form3.ZQuery1.Close;
  form3.ZQuery2.Close;
  form3.Zconnection1.disconnect;}

  //av_locality_new
  {form3.Zconnection1.connect;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT av_locality.id,av_locality.name,av_locality.typ_loc,av_locality.lat,av_locality.lon,av_land.name AS name_land,av_region.name AS name_region,av_region.typ_region,');
  form3.ZQuery1.SQL.add('av_locality.id_land,av_locality.id_region,av_locality.id_r,av_rajon.name as name_rajon');
  form3.ZQuery1.SQL.add('FROM av_land,av_locality,av_region,av_rajon');
  form3.ZQuery1.SQL.add('WHERE av_locality.id_land = av_land.id AND av_locality.id_region = av_region.id AND av_locality.id_r = av_rajon.id_rajon AND av_rajon.id = av_region.id;');
  form3.ZQuery1.open;
  for n:=1 to form3.ZQuery1.RecordCount do
     begin
       form3.label1.Caption:=inttostr(n)+' из '+inttostr(form3.ZQuery1.RecordCount);
       form3.Label1.Repaint;
       form3.ZQuery2.SQL.Clear;
       form3.ZQuery2.SQL.add('INSERT INTO av_locality_new(');
       form3.ZQuery2.SQL.add('id,');
       form3.ZQuery2.SQL.add('name,');
       form3.ZQuery2.SQL.add('typ_loc,');
       form3.ZQuery2.SQL.add('lat,');
       form3.ZQuery2.SQL.add('lon,');
       form3.ZQuery2.SQL.add('name_land,');
       form3.ZQuery2.SQL.add('name_region,');
       form3.ZQuery2.SQL.add('typ_region,');
       form3.ZQuery2.SQL.add('id_land,');
       form3.ZQuery2.SQL.add('id_region,');
       form3.ZQuery2.SQL.add('id_r,');
       form3.ZQuery2.SQL.add('name_rajon)');
       form3.ZQuery2.SQL.add(' VALUES (');
       form3.ZQuery2.SQL.add(form3.ZQuery1.FieldByName('id').asString+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('typ_loc').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('lat').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('lon').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name_land').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name_region').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('typ_region').asString)+',');
       form3.ZQuery2.SQL.add(form3.ZQuery1.FieldByName('id_land').asString+',');
       form3.ZQuery2.SQL.add(form3.ZQuery1.FieldByName('id_region').asString+',');
       form3.ZQuery2.SQL.add(form3.ZQuery1.FieldByName('id_r').asString+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name_rajon').asString)+');');
       form3.ZQuery2.ExecSQL;
       form3.ZQuery1.next;
     end;
  form3.ZQuery1.Close;
  form3.ZQuery2.Close;
  form3.Zconnection1.disconnect;}

  //av_locality_new2
{  form3.Zconnection1.connect;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT av_locality.id,av_locality.name,av_locality.typ_loc,av_locality.lat,av_locality.lon,av_land.name AS name_land,av_region.name AS name_region,av_region.typ_region,');
  form3.ZQuery1.SQL.add('av_locality.id_land,av_locality.id_region,av_locality.id_r,av_rajon.name as name_rajon');
  form3.ZQuery1.SQL.add('FROM av_land,av_locality,av_region,av_rajon');
  form3.ZQuery1.SQL.add('WHERE av_locality.id_land = av_land.id AND av_locality.id_region = av_region.id AND av_locality.id_r = av_rajon.id_rajon AND av_rajon.id = av_region.id;');
  form3.ZQuery1.open;
  for n:=1 to form3.ZQuery1.RecordCount do
     begin
       form3.label1.Caption:=inttostr(n)+' из '+inttostr(form3.ZQuery1.RecordCount);
       form3.Label1.Repaint;
       form3.ZQuery2.SQL.Clear;
       form3.ZQuery2.SQL.add('INSERT INTO av_locality_new(');
       form3.ZQuery2.SQL.add('id,');
       form3.ZQuery2.SQL.add('name,');
       form3.ZQuery2.SQL.add('typ_loc,');
       form3.ZQuery2.SQL.add('lat,');
       form3.ZQuery2.SQL.add('lon,');
       form3.ZQuery2.SQL.add('name_land,');
       form3.ZQuery2.SQL.add('name_region,');
       form3.ZQuery2.SQL.add('typ_region,');
       form3.ZQuery2.SQL.add('id_land,');
       form3.ZQuery2.SQL.add('id_region,');
       form3.ZQuery2.SQL.add('id_r,');
       form3.ZQuery2.SQL.add('name_rajon)');
       form3.ZQuery2.SQL.add(' VALUES (');
       form3.ZQuery2.SQL.add(form3.ZQuery1.FieldByName('id').asString+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('typ_loc').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('lat').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('lon').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name_land').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name_region').asString)+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('typ_region').asString)+',');
       form3.ZQuery2.SQL.add(form3.ZQuery1.FieldByName('id_land').asString+',');
       form3.ZQuery2.SQL.add(form3.ZQuery1.FieldByName('id_region').asString+',');
       form3.ZQuery2.SQL.add(form3.ZQuery1.FieldByName('id_r').asString+',');
       form3.ZQuery2.SQL.add(QuotedStr(form3.ZQuery1.FieldByName('name_rajon').asString)+');');
       form3.ZQuery2.ExecSQL;
       form3.ZQuery1.next;
     end;
  form3.ZQuery1.Close;
  form3.ZQuery2.Close;
  form3.Zconnection1.disconnect;}


  // Перенос
  {form3.Zconnection1.connect;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT * ');
  form3.ZQuery1.SQL.add('FROM av_locality_new;');
  form3.ZQuery1.open;
  for n:=1 to form3.ZQuery1.RecordCount do
     begin
       form3.label1.Caption:=inttostr(n)+' из '+inttostr(form3.ZQuery1.RecordCount);
       form3.Label1.Repaint;
       form3.ZQuery2.SQL.Clear;
       form3.ZQuery2.SQL.add('INSERT INTO av_locality_new2(');
       form3.ZQuery2.SQL.add('id, createdate, "name", id_land, id_region, id_r, name_land,');
       form3.ZQuery2.SQL.add('name_region, name_rajon, lat, lon, typ_loc, typ_region) ');
       form3.ZQuery2.SQL.add('VALUES (');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?,');
       form3.ZQuery2.SQL.add('?);');
     end;
  form3.Zconnection1.connect;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.Add('UPDATE ');
  form3.Zconnection1.disconnect;}

end;

procedure TForm3.Button3Click(Sender: TObject);
 var
  k,y:integer;
begin
  form3.Zconnection1.connect;
  // Цикл TDBF
  { form3.dbf1.Active:=true;
   form3.DBF1.First;
   form3.DBF1.DisableControls;
   //form1.Dbf1.ExactRecordCount;
   k:=0;
   y:=form3.Dbf1.ExactRecordCount;
   while not form3.DBF1.Eof do
     begin
       k:=k+1;
       //DBF
       //form3.Dbf1.Fields[''].value;
       // SQL
       form3.Label1.Caption:=inttostr(k)+' из '+inttostr(y);
       form3.Label1.Repaint;
       form3.ZQuery1.SQL.Clear;
       form3.ZQuery1.SQL.add('INSERT INTO kladr("NAME","SOCR","CODE","INDEX","GNINMB","UNO","OCATD","STATUS") VALUES (');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[0].asString)+', ');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[1].asString)+', ');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[2].asString)+', ');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[3].asString)+', ');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[4].asString)+', ');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[5].asString)+', ');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[6].asString)+', ');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[7].asString));
       form3.ZQuery1.SQL.add(');');
       form3.ZQuery1.SQL.Text:=CP866ToUTF8(form3.ZQuery1.SQL.Text);
       //showmessagealt(form3.ZQuery1.SQL.Text);
       form3.ZQuery1.open;
       form3.Dbf1.Next;
     end; }
   form3.ZQuery1.SQL.Clear;
   form3.ZQuery1.SQL.Add('select * from av_spr_geokladr;');
   form3.ZQuery1.Open;
   y:=form3.ZQuery1.RecordCount;
   for k:=1 to y do
       begin
         form3.Label1.Caption:=inttostr(k)+' из '+inttostr(y);
         form3.Label1.Repaint;
         form3.ZQuery2.SQL.Clear;
         form3.ZQuery2.SQL.Add('INSERT INTO av_spr_geokladr2(id, "name", typnas, land, region, rajon, code_kladr, typ_region,lat, lon) VALUES (');
         form3.ZQuery2.SQL.Add(inttostr(k)+','+quotedstr(form3.ZQuery1.FieldByName('name').asstring)+','+quotedstr(form3.ZQuery1.FieldByName('typnas').asstring));
         form3.ZQuery2.SQL.Add(','+quotedstr(form3.ZQuery1.FieldByName('land').asstring)+','+quotedstr(form3.ZQuery1.FieldByName('region').asstring));
         form3.ZQuery2.SQL.Add(','+quotedstr(form3.ZQuery1.FieldByName('rajon').asstring)+','+quotedstr(form3.ZQuery1.FieldByName('code_kladr').asstring));
         form3.ZQuery2.SQL.Add(','+quotedstr(form3.ZQuery1.FieldByName('typ_region').asstring)+','+quotedstr(form3.ZQuery1.FieldByName('lat').asstring));
         form3.ZQuery2.SQL.Add(','+quotedstr(form3.ZQuery1.FieldByName('lon').asstring)+');');
         form3.ZQuery2.Open;
         form3.ZQuery1.Next;
       end;
   form3.button3.Enabled:=false;
   form3.DBF1.EnableControls;
   form3.DBF1.Active:=false;
   form3.DBF1.close;
   form3.ZQuery1.Close;
   form3.ZQuery2.Close;

   form3.Zconnection1.disconnect;


{
  id integer NOT NULL,
  "name" character(250) NOT NULL,
  typnas character(10) NOT NULL,
  land character(100) NOT NULL,
  region character(100) NOT NULL,
  rajon character(100) NOT NULL,
  code_kladr character(13) NOT NULL DEFAULT 0,
  typ_region character(10) NOT NULL,
  lat character(30) NOT NULL DEFAULT 0.00,
  lon character(30) NOT NULL DEFAULT 0.00
  =================================================================================================================
  NAME,C,40	SOCR,C,10   CODE,C,13	INDEX,C,6	GNINMB,C,4	UNO,C,4	  OCATD,C,11	STATUS,C,1 }

end;

procedure TForm3.Button4Click(Sender: TObject);
var
  v: THTMLBrowserHelpViewer;
  BrowserPath, BrowserParams: string;
  p: LongInt;
  URL: String;
  BrowserProcess: TProcessUTF8;
begin
  v:=THTMLBrowserHelpViewer.Create(nil);
  try
    v.FindDefaultBrowser(BrowserPath,BrowserParams);
    debugln(['Path=',BrowserPath,' Params=',BrowserParams]);
    URL:='http://maps.yandex.ru/-/CBQfYUOU';
    p:=System.Pos('%s', BrowserParams);
    System.Delete(BrowserParams,p,2);
    System.Insert(URL,BrowserParams,p);
     // start browser
    BrowserProcess:=TProcessUTF8.Create(nil);
    try
      BrowserProcess.CommandLine:=BrowserPath+' '+BrowserParams;
      BrowserProcess.Execute;
    finally
      BrowserProcess.Free;
    end;
  finally
    v.Free;
  end;end;

procedure TForm3.Button5Click(Sender: TObject);
var
 k,y:integer;
begin
   // Цикл TDBF
   form3.dbf1.Active:=true;
   form3.DBF1.First;
   form3.DBF1.DisableControls;
   //form1.Dbf1.ExactRecordCount;
   k:=0;
   y:=form3.Dbf1.ExactRecordCount;
   while not form3.DBF1.Eof do
     begin
       k:=k+1;
       //DBF
       //form3.Dbf1.Fields[''].value;
       // SQL
       form3.Label1.Caption:=inttostr(k)+' из '+inttostr(y);
       form3.Label1.Repaint;
       form3.ZQuery1.SQL.Clear;
       form3.ZQuery1.SQL.add('INSERT INTO a_hace(khp,naim) VALUES (');
       form3.ZQuery1.SQL.add(form3.Dbf1.Fields[0].asString+', ');
       form3.ZQuery1.SQL.add(QuotedStr(form3.Dbf1.Fields[1].asString));
       form3.ZQuery1.SQL.add(');');
       form3.ZQuery1.SQL.Text:=CP866ToUTF8(form3.ZQuery1.SQL.Text);
       //showmessagealt(form3.ZQuery1.SQL.Text);
       form3.ZQuery1.open;
       form3.Dbf1.Next;
     end;
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
    da1:=0;
    net1:=0;
    form3.Timer1.Enabled:=true;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
    da2:=0;
    net2:=0;
    form3.Timer2.Enabled:=true;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
      form3.Timer1.Enabled:=false;
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
      form3.Timer2.Enabled:=false;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
end;

procedure TForm3.StringGrid1Click(Sender: TObject);
begin

end;

procedure TForm3.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
with Sender as TStringGrid, Canvas do
  begin
       Brush.Color := clWhite;
       FillRect(aRect);
      if (gdSelected in aState) then
           begin
            pen.Width:=4;
            pen.Color:=clRed;
            MoveTo(aRect.left,aRect.bottom-1);
            LineTo(aRect.right,aRect.Bottom-1);
            MoveTo(aRect.left,aRect.top-1);
            LineTo(aRect.right,aRect.Top);
            Font.Color := clBlack;
            font.Size:=12;
           end
         else
          begin
            Font.Color := clBlack;
            font.Size:=12;
          end;

      if aRow>0 then
         begin
          TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
         end;

       if aRow=0 then
         begin
           Font.Color := clTeal;
           font.Size:=12;
           TextOut(aRect.Left + 25, aRect.Top, Cells[aCol, aRow]);
           //Рисуем значки сортировки и активного столбца
            DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
          end;
     end;
end;

procedure TForm3.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Col,Row: integer;
begin
  Click_Header((Sender as TStringgrid),X,Y,Self.ProgressBar1);
end;

procedure TForm3.Timer1Timer(Sender: TObject);
var
 new_id:integer;
begin

   //Открываем транзакцию
  form3.ZConnection1.StartTransaction;
  form3.Zconnection1.AutoCommit:=false;
  //Определяем текущий id+1
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM test;');
  form3.ZQuery1.open;
  new_id:=form3.ZQuery1.FieldByName('new_id').asInteger+1;
  form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('SELECT * FROM av_spr_geokladr limit 100;');
  form3.ZQuery1.open;
   form3.ZQuery1.SQL.Clear;
  form3.ZQuery1.SQL.add('INSERT INTO test(id) VALUES (');
  form3.ZQuery1.SQL.add(inttostr(new_id)+');');
  form3.ZQuery1.open;
  // Завершение транзакции

  form3.Zconnection1.Commit;
  form3.Zconnection1.AutoCommit:=true;
  if form3.ZConnection1.InTransaction then
     begin
       //showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
       form3.ZConnection1.Rollback;
       net1:=net1+1;
     end
  else
     begin
       //showmessagealt('Запись завершена УСПЕШНО !!!');
       da1:=da1+1;
     end;
  form3.Label1.Caption:='Да - '+inttostr(da1)+'Нет - '+inttostr(net1);

end;

procedure TForm3.Timer2Timer(Sender: TObject);
 var
 new_id:integer;
begin
   //Открываем транзакцию
  form3.ZConnection2.StartTransaction;
  form3.Zconnection2.AutoCommit:=false;
  //Определяем текущий id+1
  form3.ZQuery3.SQL.Clear;
  form3.ZQuery3.SQL.add('SELECT MAX(id) as new_id FROM test;');
  form3.ZQuery3.open;
  new_id:=form3.ZQuery3.FieldByName('new_id').asInteger+1;
  form3.ZQuery3.SQL.Clear;
  form3.ZQuery3.SQL.add('SELECT * FROM av_spr_geokladr limit 130;');
  form3.ZQuery3.open;
  form3.ZQuery3.SQL.Clear;
  form3.ZQuery3.SQL.add('INSERT INTO test(id) VALUES (');
  form3.ZQuery3.SQL.add(inttostr(new_id)+');');
  form3.ZQuery3.open;
  // Завершение транзакции
  form3.Zconnection2.Commit;
  form3.Zconnection2.AutoCommit:=true;
  if form3.ZConnection2.InTransaction then
     begin
       //showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
       form3.ZConnection2.Rollback;
       net2:=net2+1;
     end
  else
     begin
       //showmessagealt('Запись завершена УСПЕШНО !!!');
       da2:=da2+1;
     end;
  form3.Label2.Caption:='Да - '+inttostr(da2)+'Нет - '+inttostr(net2);
end;

end.

