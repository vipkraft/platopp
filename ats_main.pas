unit ats_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Buttons, ComCtrls, Grids, StdCtrls, ExtCtrls,platproc,DB, LazUtf8;

type

  { TForm13 }

  TForm13 = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ProgressBar1: TProgressBar;
    Shape1: TShape;
    Shape2: TShape;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
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
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;        aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;      var CanSelect: Boolean);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid2DrawCell(Sender: TObject; aCol, aRow: Integer;       aRect: TRect; aState: TGridDrawState);
    procedure StringGrid3DrawCell(Sender: TObject; aCol, aRow: Integer;       aRect: TRect; aState: TGridDrawState);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
    procedure Update_Shema();
    procedure Update_Atp();    //загризить список перевозчиков этого АТС
  private
    { private declarations }
    formActivated: boolean;
  public
    { public declarations }
  end; 

var
  Form13: TForm13;
  result_name_ats:string;
   flag_edit_ats:byte;
  type_mesto1:array[1..5,1..25,1..2] of Integer;
  type_mesto2:array[1..5,1..25,1..2] of Integer;

implementation
uses
  mainopp,ats_edit;
{$R *.lfm}


{ TForm13 }

var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //ar_seats : array of string;

procedure TForm13.Update_Shema();
 var
   n,m:integer;
   namepole:array[1..10] of string;
   kolmest:array[1..6] of integer;
   BlobStream: TStream;
   FileStream: TStream;
 begin
   With Form13 do
   begin
   If (trim(form13.StringGrid1.Cells[0,form13.StringGrid1.row])='') OR (form13.StringGrid1.row=0) then exit;
   if form13.StringGrid1.RowCount=1 then
     begin
      form13.StringGrid4.Cells[1,1]:='';
      form13.StringGrid4.Cells[1,2]:='';
      form13.StringGrid4.Cells[1,3]:='';
      form13.StringGrid4.Cells[2,1]:='';
      form13.StringGrid4.Cells[2,2]:='';
      form13.StringGrid4.Cells[2,3]:='';
          for n:=1 to 5 do
            begin
              for m:=1 to 25 do
               begin
                 form13.StringGrid2.cells[n-1,m-1]:='';
                 form13.StringGrid3.cells[n-1,m-1]:='';
                 type_mesto1[n,m,1]:=0;
                 type_mesto1[n,m,2]:=0;
                 type_mesto2[n,m,1]:=0;
                 type_mesto2[n,m,2]:=0;
               end;
            end;
       form13.image1.Picture:=nil;
      exit;
    end;
    namepole[1]:= 'one_one';
    namepole[2]:= 'one_two';
    namepole[3]:= 'one_three';
    namepole[4]:= 'one_four';
    namepole[5]:= 'one_five';
    namepole[6]:= 'two_one';
    namepole[7]:= 'two_two';
    namepole[8]:= 'two_three';
    namepole[9]:= 'two_four';
    namepole[10]:='two_five';

   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   //запрос списка
   form13.ZQuery1.SQL.Clear;
   form13.ZQuery1.SQL.add('SELECT * FROM av_spr_ats where id='+trim(form13.StringGrid1.Cells[0,form13.StringGrid1.row])+' and del=0;');
   form13.ZQuery1.open;
   if form13.ZQuery1.RecordCount<>1 then
     begin
      form13.ZQuery1.Close;
      form13.Zconnection1.disconnect;
      exit;
     end;
    for n:=1 to 6 do
     begin
      kolmest[n]:=0;
     end;
    //КАРТА ПЕРВОГО И ВТОРОГО ЭТАЖА АВТОБУСА
    for n:=1 to 5 do
         begin
          for m:=1 to 25 do
            begin
               if strtoint(trim(copy(form13.ZQuery1.FieldByName(namepole[n]).asString,((m-1)*4+2),3)))=0 then
                   begin
                    type_mesto1[n,m,1]:=0;
                    type_mesto1[n,m,2]:=0;
                    form13.StringGrid2.Cells[n-1,m-1]:='';
                   end
               else
                   begin
                     type_mesto1[n,m,1]:=strtoint(copy(form13.ZQuery1.FieldByName(namepole[n]).asString,((m-1)*4+2),3));
                     type_mesto1[n,m,2]:=strtoint(copy(form13.ZQuery1.FieldByName(namepole[n]).asString,((m-1)*4+1),1));
                     form13.StringGrid2.Cells[n-1,m-1]:=inttostr(strtoint(copy(form13.ZQuery1.FieldByName(namepole[n]).asString,((m-1)*4+2),3)));
                     if type_mesto1[n,m,2]=1 then kolmest[1]:=kolmest[1]+1;
                     if type_mesto1[n,m,2]=2 then kolmest[2]:=kolmest[2]+1;
                     if type_mesto1[n,m,2]=3 then kolmest[3]:=kolmest[3]+1;
                   end;

               if strtoint(trim(copy(form13.ZQuery1.FieldByName(namepole[n+5]).asString,((m-1)*4+2),3)))=0 then
                   begin
                     type_mesto2[n,m,1]:=0;
                     type_mesto2[n,m,2]:=0;
                     form13.StringGrid3.Cells[n-1,m-1]:='';
                   end
               else
                   begin
                     type_mesto2[n,m,1]:=strtoint(copy(form13.ZQuery1.FieldByName(namepole[n+5]).asString,((m-1)*4+2),3));
                     type_mesto2[n,m,2]:=strtoint(copy(form13.ZQuery1.FieldByName(namepole[n+5]).asString,((m-1)*4+1),1));
                     form13.StringGrid3.Cells[n-1,m-1]:=inttostr(strtoint(copy(form13.ZQuery1.FieldByName(namepole[n+5]).asString,((m-1)*4+2),3)));
                     if type_mesto2[n,m,2]=1 then kolmest[4]:=kolmest[4]+1;
                     if type_mesto2[n,m,2]=2 then kolmest[5]:=kolmest[5]+1;
                     if type_mesto2[n,m,2]=3 then kolmest[6]:=kolmest[6]+1;
                   end;
            end;
         end;

    // Загрузка фото
       if form13.ZQuery1.FieldByName('foto').IsBlob then
        begin
          BlobStream := form13.ZQuery1.CreateBlobStream(form13.ZQuery1.FieldByName('foto'), bmRead);
         If BlobStream.Size>10 then
             begin
              //удаляем старый файл
              If FileExistsUTF8('foto_ats.jpg') then DeleteFileUTF8('foto_ats.jpg');
           try
             FileStream:= TFileStream.Create('foto_ats.jpg', fmCreate);
               try
                FileStream.CopyFrom(BlobStream, BlobStream.Size);
               finally
                FileStream.Free;
               end;
           finally
            BlobStream.Free;
           end;
           //If filesize(ExtractFilePath(Application.ExeName)+'foto_ats.jpg')>10 then
             //begin
               form13.image1.Picture.LoadFromFile('foto_ats.jpg');
               //end;
             end
         else
         begin
           If FileExistsUTF8(ExtractFilePath(Application.ExeName)+'foto_ats_1.jpg') then
             form13.image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'foto_ats_1.jpg');
         end;
        end;


    // Обновляем информацию о количестве мест
    form13.StringGrid4.Cells[1,1]:=inttostr(kolmest[1]);
    form13.StringGrid4.Cells[1,2]:=inttostr(kolmest[2]);
    form13.StringGrid4.Cells[1,3]:=inttostr(kolmest[3]);
    form13.StringGrid4.Cells[2,1]:=inttostr(kolmest[4]);
    form13.StringGrid4.Cells[2,2]:=inttostr(kolmest[5]);
    form13.StringGrid4.Cells[2,3]:=inttostr(kolmest[6]);

  form13.ZQuery1.Close;
  form13.ZConnection1.Disconnect;
  form13.repaint;

end;

 end;

//загризить список перевозчиков этого АТС
procedure TForm13.Update_Atp();
var
  n:integer;
begin
   With form13 do
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   form13.ZQuery1.SQL.Clear;
   form13.ZQuery1.SQL.add('select b.id_kontr,c.name as atp from av_spr_kontragent as c, av_spr_kontr_ats b ');
   form13.ZQuery1.SQL.add('where c.del=0 AND b.del=0 AND b.id_kontr=c.id AND b.id_ats='+Stringgrid1.Cells[0,Stringgrid1.Row]+';');
   //showmessage(zquery1.SQL.Text);
   try
     ZQuery1.Open;
   except
   showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
 end;
   // Заполняем комбо
   Combobox1.Clear;
   for n:=1 to ZQuery1.RecordCount do
    begin
      Combobox1.items.Add(ZQuery1.FieldByName('atp').AsString);
      ZQuery1.Next;
    end;
   ComboBox1.ItemIndex:= 0;
   ZQuery1.Close;
   Zconnection1.disconnect;
   end;
end;


procedure TForm13.UpdateGrid(filter_type:byte; stroka:string);
 var
   n,vsego,sidya:integer;
   stmp,orderby:string;
begin

   orderby := stringgrid1.Columns[sort_col].Title.Caption;
   form13.StringGrid1.RowCount := 1;
   With form13 do
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   form13.ZQuery1.SQL.Clear;
   form13.ZQuery1.SQL.add('select a.id,a.name,a.m_down+a.m_up+a.m_lay+a.m_down_two+a.m_up_two+a.m_lay_two as mest,a.god,a.gos ');
   form13.ZQuery1.SQL.add(',case (select Count(b.id_kontr) from av_spr_kontr_ats b where b.del=0 AND b.id_ats=a.id) WHEN 1 ');
   form13.ZQuery1.SQL.add('THEN (select b.id_kontr ||'',''|| ');
   form13.ZQuery1.SQL.add('(SELECT c.name FROM av_spr_kontragent as c WHERE c.del=0 AND b.id_kontr=c.id ORDER BY c.del ASC, c.createdate DESC LIMIT 1) as name ');
   form13.ZQuery1.SQL.add('from av_spr_kontr_ats b WHERE b.id_ats=a.id and b.del=0 LIMIT 1) ');
   form13.ZQuery1.SQL.add('WHEN 0 THEN ''''  ELSE ''99999'' END id_kontr ');
   form13.ZQuery1.SQL.add('from av_spr_ats as a ');
   form13.ZQuery1.SQL.add('where a.del=0');
   if (stroka<>'') then ZQuery1.SQL.add('and (');
   if (stroka<>'') then ZQuery1.SQL.add(' (a.gos ilike '+quotedstr('%'+stroka+'%')+')');

   if (stroka<>'') then ZQuery1.SQL.add(' OR (a.name ilike '+quotedstr('%'+stroka+'%')+')');
   if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add(' OR (cast(a.id as text) like '+quotedstr('%'+stroka+'%')+')');

  if (stroka<>'') then form13.ZQuery1.SQL.add(')');
  form13.ZQuery1.SQL.add(' ORDER BY '+orderby);
   If sort_direction=1 then form13.ZQuery1.SQL.add(' ASC;') else form13.ZQuery1.SQL.add(' DESC;');
   // form13.ZQuery1.SQL.add('select a.id,a.name,a.m_down,a.m_up,a.m_lay,a.m_down_two,a.m_up_two,a.m_lay_two,a.god,a.gos,b.id_kontr,c.name as atp from av_spr_ats as a ');
   //form13.ZQuery1.SQL.add('LEFT JOIN av_spr_kontr_ats as b ON b.del=0 AND b.id_ats=a.id ');
   //form13.ZQuery1.SQL.add('LEFT JOIN av_spr_kontragent as c ON c.del=0 AND b.id_kontr=c.id ');
   //form13.ZQuery1.SQL.add('where a.del=0;');
   //showmessage(zquery1.SQL.Text);//$
   try
 ZQuery1.Open;
 except
   showmessage('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
 end;
   // Заполняем stringgrid
   form13.StringGrid1.RowCount:=form13.ZQuery1.RecordCount+1;
   for n:=1 to form13.ZQuery1.RecordCount do
    begin
      form13.StringGrid1.Cells[0,n]:=form13.ZQuery1.FieldByName('id').asString;
      form13.StringGrid1.Cells[1,n]:=form13.ZQuery1.FieldByName('name').asString;
      //vsego:=ZQuery1.FieldByName('m_up').asInteger+ZQuery1.FieldByName('m_down').asInteger+ZQuery1.FieldByName('m_lay').asInteger+ZQuery1.FieldByName('m_up_two').asInteger+
      //ZQuery1.FieldByName('m_down_two').asInteger+ZQuery1.FieldByName('m_lay_two').asInteger;
      form13.StringGrid1.Cells[2,n]:=form13.ZQuery1.FieldByName('mest').asString;
      form13.StringGrid1.Cells[3,n]:=form13.ZQuery1.FieldByName('god').asString;
      form13.StringGrid1.Cells[4,n]:=form13.ZQuery1.FieldByName('gos').asString;
      //form13.StringGrid1.Cells[5,n]:=form13.ZQuery1.FieldByName('atp').asString;
      stmp := form13.ZQuery1.FieldByName('id_kontr').asString;
      If trim(stmp)='99999' then form13.StringGrid1.Cells[6,n]:='несколько';
      If utf8pos(',',stmp)>0 then
        begin
        form13.StringGrid1.Cells[5,n]:= utf8copy(stmp,utf8pos(',',stmp)+1,utf8length(stmp));
        form13.StringGrid1.Cells[6,n]:= utf8copy(stmp,1,utf8pos(',',stmp)-1);
        end;
      form13.ZQuery1.Next;
    end;
   form13.ZQuery1.Close;
   form13.Zconnection1.disconnect;
   form13.StringGrid1.Refresh;
   end;
   Update_Shema(); //обновить схему автобуса
end;


procedure TForm13.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;  aRect: TRect; aState: TGridDrawState);
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

      if (aRow>0) AND (aCol>2) then
         begin
          font.Size:=10;
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
           font.Size:=9;
           font.Style:=[fsBold];
           TextOut(aRect.Left + 5, aRect.Top+15, Cells[aCol, aRow]);
           //Рисуем значки сортировки и активного столбца
           If sort_col=aCol then Canvas_Triangle(canvas,sort_direction,aRect.left);
          end;
     end;
end;

procedure TForm13.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;


procedure TForm13.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  n,Col,Row : integer;
begin
  Stringgrid1.MouseToCell(X,Y,col,row);
   if row>0 then exit;
   //Если щелкнули по той же колонке, то изменить порядок сортировки, иначе сортировка по другому столбцу
   If Col=sort_col then sort_direction:=sort_direction+1
   else sort_direction :=1;
   If sort_direction=3 then sort_direction :=1;

   sort_col := Col;
   Stringgrid1.Row:=1;
  UpdateGrid(datatyp,'');
end;

// ************* Отображаем комбо при наведении на ячейку если больше одного перевозчика для атс  *********************************
procedure TForm13.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;  var CanSelect: Boolean);
 var
   R: TRect;
   n:integer;
 begin
 with form13 do
 begin
   ComboBox1.Visible := False;
   ComboBox1.Clear;
   CanSelect := False;
   if ((aCol=5) AND (aRow>0) AND (stringgrid1.Cells[6,aRow]='несколько')) then
   begin
      With form13 do
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   form13.ZQuery1.SQL.Clear;
   form13.ZQuery1.SQL.add('select b.id_kontr,c.name as atp from av_spr_kontragent as c, av_spr_kontr_ats b ');
   form13.ZQuery1.SQL.add('where c.del=0 AND b.del=0 AND b.id_kontr=c.id AND b.id_ats='+Stringgrid1.Cells[0,aRow]+';');
   //showmessage(zquery1.SQL.Text);//$
   try
     ZQuery1.Open;
   except
   showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
 end;
   // Заполняем комбо
   Combobox1.Clear;
   for n:=1 to ZQuery1.RecordCount do
    begin
      Combobox1.items.Add(ZQuery1.FieldByName('atp').AsString);
      ZQuery1.Next;
    end;
   ComboBox1.ItemIndex:= 0;
   ZQuery1.Close;
   Zconnection1.disconnect;
   end;

    //Размер и расположение combobox подгоняем под ячейку
     R := stringgrid1.CellRect(aCol, aRow);
     R.Left := R.Left + stringgrid1.Left;
     R.Right := R.Right + stringgrid1.Left;
     R.Top := R.Top + stringgrid1.Top;
     R.Bottom := R.Bottom + stringgrid1.Top;
     ComboBox1.Left := R.Left + 1;
     ComboBox1.Top := R.Top + 1;
     ComboBox1.Width := (R.Right + 1) - R.Left;
     ComboBox1.Height := (R.Bottom + 1) - R.Top;

     ComboBox1.Visible := True;
     ComboBox1.SetFocus;
   end;
   CanSelect := True;
 end;
end;

// ************* Обновить схему автобуса при наведении на ячейку грида  *********************************
procedure TForm13.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
   //If (stringgrid1.Cells[6,aRow]='несколько') then Stringgrid1.Col:=5;
   Update_shema();
end;

procedure TForm13.StringGrid2DrawCell(Sender: TObject; aCol, aRow: Integer;  aRect: TRect; aState: TGridDrawState);
begin
with Sender as TStringGrid, Canvas do
  begin
  if (type_mesto1[aCol+1,aRow+1,2]=1) then Brush.Color:=clBlue;
  if (type_mesto1[aCol+1,aRow+1,2]=2) then Brush.Color:=clPurple;
  if (type_mesto1[aCol+1,aRow+1,2]>2) then Brush.Color:=clTeal;
       FillRect(aRect);
       Font.Color := clWhite;
       font.Size:=8;
       Font.Style := [fsBold];
       TextOut(aRect.Left + 5, aRect.Top, Cells[aCol, aRow]);
  end;
end;


procedure TForm13.StringGrid3DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
 with Sender as TStringGrid, Canvas do
  begin
   if (type_mesto2[aCol+1,aRow+1,2]=1) then Brush.Color:=clBlue;
   if (type_mesto2[aCol+1,aRow+1,2]=2) then Brush.Color:=clPurple;
   if (type_mesto2[aCol+1,aRow+1,2]>2) then Brush.Color:=clTeal;
       FillRect(aRect);
       Font.Color := clWhite;
       font.Size:=8;
       Font.Style := [fsBold];
       TextOut(aRect.Left + 5, aRect.Top, Cells[aCol, aRow]);
  end;
end;

procedure TForm13.ToolButton1Click(Sender: TObject);
begin
  SortGrid(form13.StringGrid1,form13.StringGrid1.col,form13.ProgressBar1,0,1);
end;

procedure TForm13.ToolButton8Click(Sender: TObject);
begin
   GridPoisk(form13.StringGrid1,form13.Edit1);
end;

procedure TForm13.BitBtn4Click(Sender: TObject);
begin
  form13.Close;
end;

procedure TForm13.BitBtn5Click(Sender: TObject);
begin
  if form13.StringGrid1.RowCount=1 then
   begin
    result_name_ats:='';
    exit;
   end;
  result_name_ats:=form13.StringGrid1.Cells[0,form13.StringGrid1.row];
  form13.close;
end;

procedure TForm13.Edit1Change(Sender: TObject);
 var
  n:integer=0;
begin
  with FOrm13 do
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


procedure TForm13.BitBtn1Click(Sender: TObject);
begin
  with Form13 do
  begin
    //Создаем новую запись АТС
  flag_edit_ats:=1;
 If (StringGrid1.RowCount>1) AND (trim(StringGrid1.Cells[0,StringGrid1.Row])<>'') then
  begin
  if dialogs.MessageDlg('Добавить новое АТС на базе выбранной марки ?',mtConfirmation,[mbYes,mbNO], 0)=6 then
   begin
    flag_edit_ats := 3;
   end;
  end;

  form14:=Tform14.create(self);
  form14.ShowModal;
  FreeAndNil(form14);
  UpdateGrid(datatyp,'');

  end;
end;

procedure TForm13.BitBtn2Click(Sender: TObject);
 var
   res_flag,n:integer;
   smess : string;
begin
  With Form13 do
  begin
    //Удаляем запись
   if (trim(form13.StringGrid1.Cells[0,form13.StringGrid1.row])='') or (form13.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

 res_flag := dialogs.MessageDlg('Удалить выбранное автотранспортное средство ?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag<>6 then exit;
  //-------------------------- проверка на возможность удаления записи из справочника АТС расписания
  //If DelCheck(Formsk.StringGrid2,0,Formsk.ZConnection1,Formsk.ZQuery1,'av_shedule_ats.id_ats:id_shedule,')<>1  then exit;
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('Select a.id_shedule,b.name_shedule FROM av_shedule_ats as a ');
    ZQuery1.SQL.add('Left Join av_shedule as b ON b.del=0 AND b.id=a.id_shedule ');
    ZQuery1.SQL.add('Where a.del=0 AND a.flag=1 AND a.id_ats='+Stringgrid1.Cells[0,Stringgrid1.Row]+';');
    //showmessage(Zquery1.SQL.text);
    try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
   end;
     if ZQuery1.RecordCount>0 then
       begin
         smess := '';
       for n:=1 to ZQuery1.RecordCount do
       begin
       smess := smess + ZQuery1.FieldByName('id_shedule').asString +' - ' + ZQuery1.FieldByName('name_shedule').asString +',  '+#13;
       ZQuery1.Next;
       end;
        showmessagealt('Операция НЕВОЗМОЖНА !'+#13+'Сначала отметьте как неактивное АТС в следующих расписаниях:'+#13+smess);
        exit;
       end;

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
    //удаляем АТС из справочника АТС расписаний если АТС там неактивно
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('UPDATE av_shedule_ats SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id_ats=');
     ZQuery1.SQL.add(StringGrid1.Cells[0,StringGrid1.row]+' AND flag=0;');
     ZQuery1.ExecSQL;
     //удаляем АТС из справочника АТС контрагентов
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('UPDATE av_spr_kontr_ats SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id_ats=');
     ZQuery1.SQL.add(StringGrid1.Cells[0,StringGrid1.row]+';');
     ZQuery1.ExecSQL;
     //удаляем АТС из справочника АТС
     form13.ZQuery1.SQL.Clear;
     form13.ZQuery1.SQL.add('UPDATE av_spr_ats SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+StringGrid1.Cells[0,StringGrid1.row]+' and del=0;');
     form13.ZQuery1.ExecSQL;
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
     UpdateGrid(datatyp,'');


 end;
end;

procedure TForm13.BitBtn12Click(Sender: TObject);
begin
    if (trim(form13.StringGrid1.Cells[0,form13.StringGrid1.row])='') or (form13.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для изменения !');
       exit;
     end;
  //Создаем новую запись АТС
  flag_edit_ats:=2;
  form14:=Tform14.create(self);
  form14.ShowModal;
  FreeAndNil(form14);
  UpdateGrid(datatyp,'');

end;

procedure TForm13.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   // // Автоматический контекстный поиск
   //if (GetSymKey(char(Key))=true) then
   //   begin
   //     form13.Edit1.SetFocus;
   //   end;
   ////ENTER - ПОИСК
   // if (Key=13) and (form13.Edit1.Focused) then Form13.ToolButton8.Click;

  With form13 do
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
    if (Key=115) and (form13.bitbtn12.enabled=true) then form13.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (form13.bitbtn1.enabled=true) then form13.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then form13.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (form13.bitbtn2.enabled=true) then form13.BitBtn2.Click;
    // ESC
    if Key=27 then form13.Close;
    //ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32)  and  (form13.StringGrid1.Focused) then
      begin
       form13.BitBtn5.Click;
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

procedure TForm13.FormShow(Sender: TObject);
begin
   Centrform(form13);
   sort_col := 1;
   sort_direction := 1;
    if flag_access=1 then
     begin
      with form13 do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;

end;

procedure TForm13.FormActivate(Sender: TObject);
begin
  if not FormActivated then begin
    FormActivated := True;
   UpdateGrid(datatyp,'');
   form13.StringGrid1.SetFocus;
  end;
end;

end.

