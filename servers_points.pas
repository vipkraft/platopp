unit servers_points;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, platproc, ZConnection, ZDataset,
   LazUtf8,
//  LConvEncoding, Spin,
  Grids
  ;
//  DB, types, Variants;

type

  { TForm26 }

  TForm26 = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    StaticText1: TStaticText;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure UpdateServers();
    procedure UpdateGrid(filter_type:byte; stroka:string);
    procedure SaveEdit();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form26: TForm26;

implementation
uses
  mainopp;
{$R *.lfm}
{ TForm26 }
var
  fl_ch,fl_chkod : byte;
  route_id : string;
  //ss:string='';
  datatyp : byte=0;
  arzon: array of array of integer;

procedure TForm26.SaveEdit();
var
  n,m:integer;
  find:boolean;
  ss:string;
begin
  ss:='';
  for n:=1 to Stringgrid1.RowCount-1 do
      begin
        find:=false;
      for m:=low(arzon) to high(arzon) do
        begin
          If strtoint(Stringgrid1.Cells[0,n])=arzon[m,0] then
            begin
              arzon[m,1]:=0;
              If Stringgrid1.Cells[5,n]='1' then arzon[m,1]:=3;
              If Stringgrid1.Cells[4,n]='1' then arzon[m,1]:=2;
              If Stringgrid1.Cells[3,n]='1' then arzon[m,1]:=1;
              //ss:=ss+inttostr(m)+'|'+Stringgrid1.Cells[1,n]+'/'+inttostr(arzon[m,1])+#13;
              //If arzon[m,1]=0 then showmessage('0');
              find:=true;
              break;
              end;
        end;
         If find then continue;
          If (Stringgrid1.Cells[3,n]='0') and (Stringgrid1.Cells[4,n]='0') and (Stringgrid1.Cells[5,n]='0') then continue;
             //showmessage(Stringgrid1.Cells[1,n]);
         //тип расстояния
         Setlength(arzon,length(arzon)+1,2);
         arzon[length(arzon)-1,0]:=strtoint(Stringgrid1.Cells[0,n]);
         arzon[length(arzon)-1,1]:=0;
         If Stringgrid1.Cells[5,n]='1' then arzon[length(arzon)-1,1]:=3;
         If Stringgrid1.Cells[4,n]='1' then arzon[length(arzon)-1,1]:=2;
         If Stringgrid1.Cells[3,n]='1' then arzon[length(arzon)-1,1]:=1;
         //ss:=ss+inttostr(length(arzon)-1)+'|'+Stringgrid1.Cells[1,n]+'/'+inttostr(arzon[length(arzon)-1,1])+#13;
      end;
  //showmessage(ss);
end;

procedure TForm26.UpdateGrid(filter_type:byte; stroka:string);
var
  n,m,serverid : integer;
begin
  With Form26 do
  begin
    form26.label6.Caption:='';
    form26.label3.Caption:='';
    form26.StringGrid1.RowCount:=1;
    If form26.ComboBox1.ItemIndex<0 then exit;
    try
      serverid:= strtoint(utf8copy(form26.ComboBox1.Text, utf8pos('--',form26.ComboBox1.Text)+2, utf8length(form26.ComboBox1.Text)));
    except
          on exception: EConvertError do
         begin
          showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'НЕВЕРНОЕ ЗНАЧЕНИЕ СЕРВЕРА!');
          exit;
         end;
    end;
    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      exit;
     end;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT * FROM (select id_point,km,0 as ptype ');
  ZQuery1.SQL.add(',(select name from av_spr_point where del=0 and id=id_point order by createdate limit 1) pname ');
  ZQuery1.SQL.add(',1 as grp ');
  ZQuery1.SQL.add(',count(*) over() sss ');
  ZQuery1.SQL.add('FROM ( ');
  ZQuery1.SQL.add('select id_point,trunc(avg(km2),3) as km ');
  ZQuery1.SQL.add('FROM ( ');
  ZQuery1.SQL.add('Select *   ');
  ZQuery1.SQL.add('from ( ');
  ZQuery1.SQL.add('select * ');
  ZQuery1.SQL.add(',coalesce((select 1 from av_shedule_sostav c where del=0 and id_shedule=z.id_shedule and id_point='+inttostr(serverid)+' and c.point_order<verh and c.point_order>=niz order by c.point_order limit 1),0) xx ');
  ZQuery1.SQL.add(',(sum(z.km) OVER (partition by z.id_shedule,z.verh ORDER BY z.point_order RANGE UNBOUNDED PRECEDING)) as km2 ');
  ZQuery1.SQL.add('FROM ( ');
  ZQuery1.SQL.add('select a.point_order,a.id_point,a.id_shedule,a.km ');
  ZQuery1.SQL.add(',(select point_order from av_shedule_sostav where id_shedule=a.id_shedule and del=0 and form=1 and point_order>=a.point_order order by point_order limit 1) verh ');
  ZQuery1.SQL.add(',coalesce((select point_order from av_shedule_sostav where id_shedule=a.id_shedule and del=0 and form=1 and point_order<a.point_order order by point_order desc limit 1),0) niz ');
  ZQuery1.SQL.add('from av_shedule_sostav a where a.del=0 ');
  ZQuery1.SQL.add('and a.id_shedule in ');
  ZQuery1.SQL.add('(select id_shedule ');
  ZQuery1.SQL.add('from av_shedule_sostav where del=0 and id_point='+inttostr(serverid)+' group by id_shedule) ');
  ZQuery1.SQL.add('order by id_shedule, point_order ');
  ZQuery1.SQL.add(') z ');
     if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('WHERE id_point='+stroka);
  ZQuery1.SQL.add(') v ');
  ZQuery1.SQL.add('where xx=1 ');
  ZQuery1.SQL.add(') b ');
  ZQuery1.SQL.add('group by id_point ');
  ZQuery1.SQL.add(') m ');
  ZQuery1.SQL.add('where id_point not in (select id_point from av_spr_point_type where del=0 and id_serv='+inttostr(serverid)+')');
  ZQuery1.SQL.add(' order by pname) t ');
     if (stroka<>'') and (filter_type=2)
       then ZQuery1.SQL.add('where pname ilike '+quotedstr(stroka+'%'));
  ZQuery1.SQL.add('UNION ALL ');
  ZQuery1.SQL.add('SELECT * FROM (SELECT * from (select id_point,km,ptype ');
  ZQuery1.SQL.add(',(select name from av_spr_point where del=0 and id=id_point order by createdate limit 1) pname ');
  ZQuery1.SQL.add(',2 as grp ');
  ZQuery1.SQL.add(',count(*) over() sss ');
  ZQuery1.SQL.add(' from av_spr_point_type where del=0 and id_serv='+inttostr(serverid));
  if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add(' and id_point='+stroka);
  ZQuery1.SQL.add(') c ');
  ZQuery1.SQL.add(' order by pname) t ');
  if (stroka<>'') and (filter_type=2)
     then ZQuery1.SQL.add('WHERE pname ilike '+quotedstr(stroka+'%'));
   //showmessage(ZQuery1.SQL.Text);
  //Заполняем grid1 АРМ
  try
    ZQuery1.Open;
  except
    showmessagealt('ОШИБКА  ЗАПРОСА !!!');
    //+#13+'Команда: '+ ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;
 if ZQuery1.RecordCount<1 then
     begin
       ZQuery1.close;
       ZConnection1.Disconnect;
       exit;
     end;

 // Заполняем combo
 for n:=1 to ZQuery1.RecordCount do
   begin
     If  form26.ZQuery1.FieldByName('grp').AsInteger=1 then
       form26.label3.Caption:=form26.ZQuery1.FieldByName('sss').asString;
     If  form26.ZQuery1.FieldByName('grp').AsInteger=2 then
       form26.label6.Caption:=form26.ZQuery1.FieldByName('sss').asString;
      form26.StringGrid1.RowCount:=form26.ZQuery1.RecordCount+1;
      form26.StringGrid1.Cells[0,n]:=form26.ZQuery1.FieldByName('id_point').asString;
      form26.StringGrid1.Cells[1,n]:=form26.ZQuery1.FieldByName('pname').asString;
      form26.StringGrid1.Cells[2,n]:=form26.ZQuery1.FieldByName('km').asString;
      form26.StringGrid1.Cells[3,n]:='0';
      form26.StringGrid1.Cells[4,n]:='0';
      form26.StringGrid1.Cells[5,n]:='0';
      if form26.ZQuery1.FieldByName('ptype').asInteger=1 then form26.StringGrid1.Cells[3,n]:='1';
      if form26.ZQuery1.FieldByName('ptype').asInteger=2 then form26.StringGrid1.Cells[4,n]:='1';
      if form26.ZQuery1.FieldByName('ptype').asInteger=3 then form26.StringGrid1.Cells[5,n]:='1';
      for m:=low(arzon) to high(arzon) do
    begin
      If form26.ZQuery1.FieldByName('id_point').AsInteger=arzon[m,0] then
        begin
           form26.StringGrid1.Cells[5,n]:='0';
           form26.StringGrid1.Cells[4,n]:='0';
           form26.StringGrid1.Cells[3,n]:='0';
           if arzon[m,1]=3 then form26.StringGrid1.Cells[5,n]:='1';
           if arzon[m,1]=2 then form26.StringGrid1.Cells[4,n]:='1';
           if arzon[m,1]=1 then form26.StringGrid1.Cells[3,n]:='1';
           break;
          end;
    end;



      //if form26.ZQuery1.FieldByName('ptype').asInteger=3 then form26.StringGrid1.Cells[3,n]:=cGos;
      form26.ZQuery1.Next;
    end;


   ZQuery1.Close;
   Zconnection1.disconnect;
   //label7.Caption:=inttostr(length(arzon));
   end;

end;



//*************************************** //обновить КОМБО С СЕРВЕРАМИ ********************************************
procedure TForm26.UpdateServers();
var
  n : integer;
begin
  With Form26 do
  begin
    ComboBox1.Clear;

    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      exit;
     end;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT a.point_id,b.name FROM av_servers AS a, av_spr_point AS b WHERE a.del=0 and a.real_virtual=1 AND b.del=0 AND a.point_id=b.id ORDER BY b.name;');
  //Заполняем grid1 АРМ
  try
    ZQuery1.Open;
  except
    showmessagealt('ОШИБКА  ЗАПРОСА !!!'+#13+'Команда: '+ ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;
 if ZQuery1.RecordCount<1 then
     begin
       ZQuery1.close;
       ZConnection1.Disconnect;
       exit;
     end;

 // Заполняем combo
 for n:=1 to ZQuery1.RecordCount do
   begin
      combobox1.Items.Add(ZQuery1.FieldByName('name').asString+' -- ' + ZQuery1.FieldByName('point_id').asString);
      ZQuery1.Next;
     end;
   combobox1.ItemIndex:=0;
  ZQuery1.Close;
  Zconnection1.disconnect;
 end;
end;

procedure TForm26.FormShow(Sender: TObject);
begin
  Form26.UpdateServers();
  Form26.saveedit();
  Form26.UpdateGrid(datatyp,'');
  Stringgrid1.Row:=1;
  Stringgrid1.SetFocus;
end;


//----------------------------------------------- СОХРАНИТЬ ДАННЫЕ -----------------------
procedure TForm26.BitBtn3Click(Sender: TObject);
var
serverid,n: integer;
begin
  with Form26 do
  begin
   If form26.StringGrid1.RowCount=1 then exit;
    If form26.ComboBox1.ItemIndex<0 then exit;
    try
      serverid:= strtoint(utf8copy(form26.ComboBox1.Text, utf8pos('--',form26.ComboBox1.Text)+2, utf8length(form26.ComboBox1.Text)));
    except
          on exception: EConvertError do
         begin
          showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'НЕВЕРНОЕ ЗНАЧЕНИЕ СЕРВЕРА!');
          exit;
         end;
    end;
    form26.SaveEdit();
    form26.UpdateGrid(0,'');

     //exit;
    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

  //Открываем транзакцию
  try
   If not Zconnection1.InTransaction then
      Zconnection1.StartTransaction
   else
     begin
      showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      ZConnection1.Rollback;
      Zconnection1.disconnect;
      exit;
     end;

     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('UPDATE av_spr_point_type SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_serv='+inttostr(serverid)+' and del=0;');
       //showmessage(ZQuery1.SQL.text);
     ZQuery1.open;

   for n:=1 to Stringgrid1.RowCount-1 do
     begin
       If (Stringgrid1.Cells[3,n]='0') and (Stringgrid1.Cells[4,n]='0') and (Stringgrid1.Cells[5,n]='0') then continue;
//Производим запись новых данных
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_spr_point_type(id_serv,id_point,km,ptype,createdate,id_user,del,createdate_first,id_user_first) VALUES (');
  ZQuery1.SQL.add(inttostr(serverid)+','+Stringgrid1.Cells[0,n]+','+Stringgrid1.Cells[2,n]+',');
  //тип расстояния
  If Stringgrid1.Cells[3,n]='1' then
    begin
      //showmessage('1');
      ZQuery1.SQL.add('1,');
     end
  else
  begin
  If Stringgrid1.Cells[4,n]='1' then ZQuery1.SQL.add('2,')
  else
    If Stringgrid1.Cells[5,n]='1' then ZQuery1.SQL.add('3,');
  end;

  ZQuery1.SQL.add('now(),'+inttostr(id_user)+',0,now(),'+inttostr(id_user)+');');
  //showmessage(ZQuery1.SQL.text);
  ZQuery1.open;
  end;
 // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  //Close;
 except
     ZConnection1.Rollback;
     showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
  showmessage('Успешно!');
  setlength(arzon,0,0);
  Form26.UpdateGrid(datatyp,'');
 end;
end;

procedure TForm26.BitBtn4Click(Sender: TObject);
begin
  form26.Close;
end;

procedure TForm26.Button1Click(Sender: TObject);
var
m:integer;
ss:string;
begin
  for m:=low(arzon) to high(arzon) do
    begin
    ss:=ss+inttostr(m)+'|'+inttostr(arzon[m,0])+'/'+inttostr(arzon[m,1])+#13;
    end;
  showmessage(ss);
end;

procedure TForm26.ComboBox1Change(Sender: TObject);
begin
  setlength(arzon,0,0);
  Form26.UpdateGrid(datatyp,'');
end;

procedure TForm26.Edit1Change(Sender: TObject);
var
 n:integer=0;
 ss:string;
begin
  with Form26 do
  begin
     ss:=trimleft(Edit1.Text);
  if UTF8Length(ss)>0 then
     begin
       //определяем тип данных для поиска
     if (ss[1] in ['0'..'9']) then datatyp:=1
     else datatyp:=2;
     saveedit();
     updategrid(datatyp,ss);
    end
  else
   begin
    datatyp:=0;
    saveedit();
    updategrid(datatyp,'');
    Edit1.Visible:=false;
    Stringgrid1.SetFocus;
   end;
end;
end;

procedure TForm26.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  setlength(arzon,0,0);
end;

procedure TForm26.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  with Form26 do
  begin
      //поле поиска
  If Edit1.Visible then
    begin
    // ESC поиск // Вверх по списку   // Вниз по списку
     If key=27 then
       begin
          datatyp:= 0;
          form26.SaveEdit();
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
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[ESC] - Отмена\Выход');
    //F2 - Сохранить
    if (Key=113) and (bitbtn3.enabled=true) then  BitBtn3.Click;
    // ESC
    if Key=27 then BitBtn4.Click;

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


procedure TForm26.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin

with Sender as TStringGrid, Canvas do
  begin
       FillRect(aRect);
       Font.Color:=clBlack;
       //чекбоксы
         if (arow>0) and (acol>2) then
              begin
                 //pen.Width:=2;
                 //pen.Color:=clGray;

                 font.size:=16;
               //font.Style:=[];
               //form1.StringGrid1.Canvas.TextRect(aRect,arow+5,5,form1.StringGrid1.Cells[aCol, aRow]);
               if trim(Cells[aCol, aRow])='1' then
                begin
                 font.Color:=clBlue;
                 brush.Color:=clBlue;
                 //textout(arow,acol,'*');
                  //textout(arect.Left+2,arect.Top+2,'*');
                 //DrawCellsAlign(form1.StringGrid1,2,2,form1.StringGrid1.Cells[aCol, aRow],aRect);
                 //DrawCellsAlign(form1.StringGrid1,2,2,'*',aRect);
                end
               else
                begin
                  font.Color:=clWhite;
                  brush.Color:=clWhite;
                end;
                FillRect(aRect);
            end;

       //Brush.Color := clBtnFace;


       if (gdSelected in aState) then
         begin
            pen.Width:=4;
            pen.Color:=clRed;
            MoveTo(aRect.left,aRect.bottom-2);
            LineTo(aRect.right,aRect.Bottom);
            MoveTo(aRect.left,aRect.top-1);
            LineTo(aRect.right,aRect.Top);
            If aCol<3 then Font.Color:=clBlack;
            font.Size:=12;
            font.Style:=[fsBold];
         end
       else
         begin
            If aCol<3 then Font.Color:=clBlack;
            font.Size:=11;
            font.Style:=[];
         end;


      if aRow>0 then
         begin
          TextOut(aRect.Left+10,aRect.Top+8,Cells[aCol,aRow]);
         end;

       //заголовок
    if aRow=0 then
      begin
           Brush.Color:= clCream;
           FillRect(aRect);
           Font.Color := clBlack;
           font.Size:=11;
           font.Style:=[fsBold];
           TextOut(aRect.Left + 10, aRect.Top + 8, Cells[aCol, aRow]);

        // Рисуем значки сортировки и активного столбца
         // DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
       end;
    end;
end;

procedure TForm26.StringGrid1Enter(Sender: TObject);
begin
   Edit1.Visible:=false;
end;

//procedure TForm26.StringGrid1GetCheckboxState(Sender: TObject; ACol,
//  ARow: Integer; var Value: TCheckboxState);
//begin
//  If Value=cbChecked then
//   form26.Label2.Caption:=inttostr(Acol)+'/\'+inttostr(ARow)+'/\'
//   else
//     form26.Label2.Caption:=inttostr(Acol)+'\/'+inttostr(ARow)+'\/';
//     If form26.StringGrid1.Cells[aRow,3]='1' then
//    begin
//      form26.StringGrid1.Cells[aRow,4]:='0';
//      form26.StringGrid1.Cells[aRow,5]:='0';
//      end;
//  If form26.StringGrid1.Cells[aRow,4]='1' then
//    begin
//      form26.StringGrid1.Cells[aRow,3]:='0';
//      form26.StringGrid1.Cells[aRow,5]:='0';
//      end;
//  If form26.StringGrid1.Cells[aRow,5]='1' then
//    begin
//      form26.StringGrid1.Cells[aRow,3]:='0';
//      form26.StringGrid1.Cells[aRow,4]:='0';
//      end;
//end;






end.

