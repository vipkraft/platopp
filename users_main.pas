unit users_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls, LazUtf8, DB;

type

  { TForm_users }

  TForm_users = class(TForm )
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;      Shift: TShiftState; X, Y: Integer);
    procedure UpdateGrid(filter_type:byte; stroka:string);
  private
    { private declarations }
    formActivated: boolean;
  public
    { public declarations }
  end; 


var
  Form_users : TForm_users;
  //flag_edit_point : integer;
  result_user, result_usname : string;
  fl_open:byte=0;

implementation
uses
  platproc,mainopp;
{$R *.lfm}

{ TForm_users }


//******************************************************** ОБНОВИТЬ ДАННЫЕ НА ГРИДЕ **********************************
procedure TForm_users.UpdateGrid(filter_type:byte; stroka:string);
var
   n:integer;
begin
   with Form_users do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      exit;
     end;

   //* просто все юзеры
   If users_mode=0 then
     begin
   //запрос списка
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT * FROM av_users as u ');
     end;

   //Выбирать удаленных или нет
   If not(CheckBox1.Checked) then  ZQuery1.SQL.add('WHERE u.del=0 ');
   If (CheckBox1.Checked) then  ZQuery1.SQL.add('WHERE u.del=2 ');
 //осуществлять контекстный поиск или нет
 If filter_type=1 then
   begin
   ZQuery1.SQL.add('AND ((u.id='+stroka+') OR (u.kodpodr='+stroka+') OR (u.kod1c='+stroka+')) ');
   end;
 If filter_type=2 then
   begin
   ZQuery1.SQL.add('AND ((UPPER(substr(u.name,1,'+inttostr(Utf8length(stroka))+'))=UPPER('+Quotedstr(stroka)+')) ');
   ZQuery1.SQL.add('OR (UPPER(substr(u.fullname,1,'+inttostr(Utf8length(stroka))+'))=UPPER('+Quotedstr(stroka)+')) ');
   ZQuery1.SQL.add('OR (UPPER(substr(u.dolg,1,'+inttostr(Utf8length(stroka))+'))=UPPER('+Quotedstr(stroka)+'))) ');
   end;

  ZQuery1.SQL.add('ORDER BY u.name; ');
  //showmessage(ZQuery1.SQL.text);
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;

  Label3.Caption := '-';
 StringGrid1.RowCount:=1;

   if Form_users.ZQuery1.RecordCount=0 then
     begin
      Form_users.ZQuery1.Close;
      Form_users.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   StringGrid1.RowCount:=ZQuery1.RecordCount+1;
   for n:=1 to ZQuery1.RecordCount do
    begin
      StringGrid1.Cells[0,n]:=ZQuery1.FieldByName('id').asString;
      StringGrid1.Cells[1,n]:=ZQuery1.FieldByName('name').asString;
      StringGrid1.Cells[2,n]:=ZQuery1.FieldByName('fullname').asString;
      //StringGrid1.Cells[3,n]:=ZQuery1.FieldByName('grupa').asString;
      StringGrid1.Cells[4,n]:=ZQuery1.FieldByName('dolg').asString;
      //StringGrid1.Cells[5,n]:=ZQuery1.FieldByName('nameserv').asString;
      //StringGrid1.Cells[6,n]:=ZQuery1.FieldByName('namepodr').asString;
      StringGrid1.Cells[7,n]:=ZQuery1.FieldByName('birthday').asString;
      StringGrid1.Cells[8,n]:=ZQuery1.FieldByName('status').asString;
      StringGrid1.Cells[9,n]:=ZQuery1.FieldByName('tip').asString;
      StringGrid1.Cells[10,n]:=ZQuery1.FieldByName('pol').asString;
      StringGrid1.Cells[11,n]:=ZQuery1.FieldByName('kod1c').asString;
      StringGrid1.Cells[12,n]:=ZQuery1.FieldByName('del').asString;
      ZQuery1.Next;
    end;
   Form_users.ZQuery1.Close;
   Form_users.Zconnection1.disconnect;
   Label3.Caption := inttostr(StringGrid1.RowCount-1);
  // Form_users.StringGrid1.Refresh;
  // Form_users.StringGrid1.SetFocus;
   end;
end;

// выход
procedure TForm_users.BitBtn3Click(Sender: TObject);
begin
  result_user:='';
  result_usname:='';
  Form_users.Close;
end;

//********************************** отфильтровать грид ******************
procedure TForm_users.Edit1Change(Sender: TObject);
var
  typ:byte=0;
  ss:string='';
  n:integer=0;
begin
  with FOrm_users do
begin
  ss:=trimleft(Edit1.Text);
  if UTF8Length(ss)>0 then
       begin
         //определяем тип данных для поиска
         for n:=1 to UTF8Length(ss) do
           begin
             //если хоть один нецифровой символ, тогда отвал и поиск строковых значений
              if not(ss[n] in ['0'..'9']) then
                begin
                typ:=2;
                break;
                end;
           end;
            if typ=2 then  updategrid(2,ss)
           else updategrid(1,ss);
       end
  else
     begin
      updategrid(0,'');
      Edit1.Visible:=false;
     end;
end;
end;


// выбрать
procedure TForm_users.BitBtn2Click(Sender: TObject);
begin
  // проверки *--------------
  with Form_users.StringGrid1 do
  begin
  If (trim(Cells[1,Row])='') or (trim(Cells[2,Row])='') then
    begin
     showmessage('Сначала выберите пользователя !');
     exit;
    end;
  If (trim(Cells[8,Row])='0') then
    begin
     showmessage('Нельзя выбрать неактивного пользователя!'+#13+'Обратитесь к Администратору системы !');
     exit;
    end;
  If (trim(Cells[12,Row])<>'0') then
    begin
     showmessage('Нельзя выбрать удаленного пользователя!'+#13+'Обратитесь к Администратору системы !');
     exit;
    end;
  //---------------------------------------------------
  end;
   result_user:= Form_users.StringGrid1.Cells[0,Form_users.StringGrid1.row];
   result_usname:= Form_users.stringgrid1.cells[1,Form_users.StringGrid1.Row];
   Form_users.close;
end;

// обновить
procedure TForm_users.BitBtn1Click(Sender: TObject);
begin
  Form_users.UpdateGrid(0,'');
end;


procedure TForm_users.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
begin
//********************                    HOT KEYS  ******************************************
  With Form_users do
begin
  //поле поиска
  If Edit1.Visible then
    begin
    // ESC поиск // Вверх по списку   // Вниз по списку
  if (Key=27) OR (Key=38) OR (Key=40) then
     begin
       Edit1.Visible:=false;
       StringGrid1.SetFocus;
      exit;
     end;
      // ENTER - остановить контекстный поиск
   if (Key=13) then
     begin
       StringGrid1.SetFocus;
       //exit;
     end;
    end;

    // Контекcтный поиск
   if Edit1.Visible=false then
     begin
       If (get_type_char(key)>0) or (key=8) or (key=46) or (key=96) then //8-backspace 46-delete 96- numpad 0
       begin
         Edit1.text:='';
         Edit1.Visible:=true;
         Edit1.SetFocus;
       end;
     end;

    // F1
     if Key=112 then showmessage('F1 - Справка'+#13+'F5 - Обновить'+#13+'F7 - Поиск'+#13+'ENTER - Выбор'+#13+'ESC - Отмена\Выход');

    // ПРОБЕЛ
    if (Key=32) and  (StringGrid1.Focused) then BitBtn2.Click;
     //F5 - Обновить
    if (Key=116) and (bitbtn1.enabled=true) then  BitBtn1.Click;
    // ESC
    if Key=27 then BitBtn3.Click;
    // ENTER
    if (Key=13) and  (StringGrid1.Focused) then BitBtn2.Click;
end;
    if (Key=112) or (Key=115) or (Key=116) or (Key=118) or (Key=119) or (Key=27) or (Key=32) or (Key=13) then Key:=0;
end;


procedure TForm_users.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
     with Sender as TStringGrid, Canvas do
  begin
       //Если пользователь удален, закрашиваем строку серым цветом
      if (Cells[12,aRow]='0') then
        Brush.color := clWhite;
      if (Cells[12,aRow]='2') then
        Brush.Color := clSilver;
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
            font.Size:=11;
            font.Style:= [];
           end
         else
          begin
            font.Style:= [];
            Font.Color := clBlack;
            font.Size:=10;
          end;

          // имя
      if (aRow>0) and (aCol=1) then
         begin
          Font.Size:=12;
//        Font.Color := clBlack;
          TextOut(aRect.Left + 10, aRect.Top+5, Cells[aCol, aRow]);
         end;

         // Остальные поля
     if (aRow>0) and not(aCol=1) then
         begin
     //     Font.Size:=10;
     //     Font.Color := clBlack;
          TextOut(aRect.Left + 5, aRect.Top+8, Cells[aCol, aRow]);
         end;


      // Заголовок
       if aRow=0 then
         begin
           RowHeights[aRow]:=30;
           Brush.Color:=clCream;
           FillRect(aRect);
           Font.Color := clBlack;
           font.Size:=9;
           font.Style:=[fsBold];
           TextOut(aRect.Left + 5, aRect.Top+15, Cells[aCol, aRow]);
           //Рисуем значки сортировки и активного столбца
            DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
          end;
     end;
end;

procedure TForm_users.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
   Click_Header((Sender as TStringgrid),X,Y,Self.ProgressBar1);
end;


procedure TForm_users.FormActivate(Sender: TObject);
begin
  if not FormActivated then begin
    FormActivated := True;
     Form_users.UpdateGrid(0,'');
  // SortGrid(Form_users.StringGrid1,2,Form_users.ProgressBar1);
   Form_users.StringGrid1.Col := 2;
   Form_users.StringGrid1.SetFocus;
  end;
end;

end.

