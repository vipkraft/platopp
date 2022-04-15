unit facelist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls,platproc,report_edit,report_vibor;

type

  { TFormFace }

  TFormFace = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);  procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;  aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure UpdateGrid();
    procedure UsrParam();
    procedure PresetShow();

  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormFace: TFormFace;
  fl_edit: byte = 0;
  newRow : string;
  fl_open : byte = 0; //режим открытия этой формы (форма может быть открыта для выбора запроса отчета)
  fl_print : byte = 0; //режим открытия форм в режиме печати
  fl_vibor : byte = 0; //режим отображения формы выбора данных

implementation
uses
  mainopp, htmldoc, shedule_main, shedule_edit, nas, point_main, route_main, kontr_main, servers_main;
{$R *.lfm}

var
fledit,n: integer;
 nrow:integer=0;
 //nuser:string='';
 //oldopt:string;
 //lchange:boolean;

{ TFormFace }


//Отображение
procedure TFormFace.PresetShow();
begin
   fledit:=0;
  with FormFace do
  begin
   //lchange:=false;

     Edit1.Text:='';
     Edit2.Text:='';
     Memo1.Text:='';

     label7.Caption:='';
     label9.Caption:='';
     BitBtn5.Enabled:=false;
  end;
end;

//*******************************    Отображение данных ************************************************
procedure TFormFace.UsrParam();
var
 timeC : TDateTime;
 nrow:integer;
begin
   presetShow();
   with FormFace do
     begin
       nrow:=Stringgrid1.row;
  If (Stringgrid1.RowCount<2) or (nrow<1) or (Stringgrid1.Cells[1,nrow]='') then exit;
     //label6.Caption:=Stringgrid1.Cells[0,nrow];//id
     Edit1.Text:=Stringgrid1.Cells[1,nrow];
     Edit2.Text:=Stringgrid1.Cells[2,nrow];
     Memo1.Text:=Stringgrid1.Cells[3,nrow];
     label7.caption:=Stringgrid1.Cells[4,nrow];
     label9.caption:=Stringgrid1.Cells[6,nrow];
   end;
end;


//**************** СОХРАНИТЬ **********************
procedure TFormFace.BitBtn5Click(Sender: TObject);
 var
  snol: string;
  n:integer=0;
  lg:boolean=false;
begin
   If fledit=0 then exit;

  with FormFace do
   begin
  if (trim(Edit1.text)='') then
  begin
       showmessagealt('Обязательно для заполнения поле - ФИО - пустое !');
       exit;
   end;
  if (trim(Edit2.text)='') then
  begin
       showmessagealt('Обязательно для заполнения поле - ДОКУМЕНТ - пустое !');
       exit;
   end;



  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      exit;
     end;
    snol:=QuotedStr('');

  //****** проверяем на полный дубляж
       ZQuery1.SQL.Clear;
       ZQuery1.Sql.Add('Select fio from av_suspect WHERE del=0 AND ');
       ZQuery1.SQL.add(' fio ilike '+QuotedStr(StringReplace(trim(edit1.text),#32,'%',[rfReplaceAll, rfIgnoreCase])));
       //ZQuery1.SQL.add('OR fullname='+QuotedStr(trim(edit2.text)));
       ZQuery1.SQL.add(' and doc ilike '+QuotedStr(StringReplace(trim(edit1.text),#32,'%',[rfReplaceAll, rfIgnoreCase])));
       //ZQuery1.SQL.add('OR kod='+label23.caption);
       ZQuery1.SQL.add(';');
       try
      //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.Open;
       except
         showmessagealt('ОШИБКА  ЗАПРОСА !!!'+#13+'Команда: '+ ZQuery1.SQL.Text);
         Zconnection1.disconnect;
         exit;
       end;
       If ZQuery1.RecordCount>0 then
         begin
          ZQuery1.close;
          Zconnection1.Disconnect;
          showmessagealt('Операция СОХРАНЕНИЯ невозможна !'+#13+'Объект с такими параметрами уже существует !');
          exit;
         end;
       //**************************************************************

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

   //Если режим редактирования, сначала помечаем запись на удаление
    If fledit=1 then
     begin
         ZQuery1.SQL.Clear;
         ZQuery1.SQL.add('UPDATE av_suspect SET del=1,createdate=DEFAULT,id_user='+inttostr(id_user)+' WHERE del=0 AND date_trunc(''second'',createdate)='+QuotedStr(label9.Caption)+';');
     //showmessage(ZQuery1.SQL.text);//$
         ZQuery1.ExecSQL;
     end;

   //записываем в таблицу юзеров
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('INSERT INTO av_suspect(createdate,id_user,del,id_user_first,createdate_first,fio,doc,initiator) VALUES (');
   ZQuery1.SQL.add('now(),'+inttostr(id_user)+',0,');//id
   If fledit=1 then ZQuery1.SQL.add('null,null,')
   else ZQuery1.SQL.add(inttostr(id_user)+',now(),');

   ZQuery1.SQL.add(QuotedStr(trim(edit1.text))+','+ QuotedStr(trim(Edit2.Text))+',');
   ZQuery1.SQL.add(                                                        QuotedStr(trim(Memo1.text))+');');

  //showmessage(ZQuery1.SQL.text);//$
  ZQuery1.ExecSQL;

  // Завершение транзакции
  Zconnection1.Commit;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
     exit;
 end;
   ZQuery1.close;
   Zconnection1.disconnect;
  //lChange:=false;

  UpdateGrid();
  If fledit=1 then
      StringGrid1.Row := nRow;
  If fledit=2 then
      StringGrid1.Row := StringGrid1.RowCount-1;
  StringGrid1.SetFocus;

end;
end;


procedure TFormFace.UpdateGrid();
 var
   gr,n:integer;
begin
  StringGrid1.RowCount:=1;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT *,(select c.name from av_users c where c.id=a.id_user and c.del=0 order by c.createdate desc limit 1) as cname FROM av_suspect a WHERE a.del=0 ORDER BY a.createdate;');
    //showmessage(ZQuery1.SQL.text);
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;

   if ZQuery1.RecordCount=0 then
     begin
      ZQuery1.Close;
      Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   StringGrid1.RowCount:=ZQuery1.RecordCount+1;
   for n:=1 to ZQuery1.RecordCount do
    begin
      StringGrid1.Cells[0,n]:=inttostr(n);
      StringGrid1.Cells[1,n]:=ZQuery1.FieldByName('fio').asString;
      StringGrid1.Cells[2,n]:=ZQuery1.FieldByName('doc').asString;
      StringGrid1.Cells[3,n]:=ZQuery1.FieldByName('initiator').asString;
      StringGrid1.Cells[4,n]:=ZQuery1.FieldByName('cname').asString;
      StringGrid1.Cells[5,n]:=ZQuery1.FieldByName('id_user_first').asString;
      StringGrid1.Cells[6,n]:=ZQuery1.FieldByName('createdate').asString;
      ZQuery1.Next;
    end;
   ZQuery1.Close;
   Zconnection1.disconnect;
   StringGrid1.ColWidths[4]:=0;
   StringGrid1.ColWidths[5]:=0;
   StringGrid1.ColWidths[6]:=0;
   //StringGrid1.Refresh;
   StringGrid1.SetFocus;
end;

procedure TFormFace.BitBtn4Click(Sender: TObject);
begin
  Close;
end;

procedure TFormFace.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
begin
   with FormFace do
     begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ESC] - Отмена\Выход');
    //F2 - Сохранить
    if (Key=113) and ( bitbtn5.enabled=true) then  BitBtn5.Click;
    //F4 - Изменить
    if (Key=115) and ( bitbtn12.enabled=true) then  BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and ( bitbtn1.enabled=true) then  BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then  ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (bitbtn2.enabled=true) then  BitBtn2.Click;
    // ESC
    if Key=27 then
    begin
      If bitbtn5.Enabled then
      begin

     If fledit=1 then
       StringGrid1.Row := nRow;
     If fledit=2 then
       StringGrid1.Row := StringGrid1.RowCount-1;
      PresetShow();

       StringGrid1.SetFocus;
      end
      else
      begin
        BitBtn4.Click;
      end;
      end;
    // ПРОБЕЛ  -  печатать
    //if (Key=32) and (StringGrid1.Focused) then  BitBtn5.Click;
    //if (Key=32) and ( Edit1.Focused) then  Edit1.Text:= Edit1.Text+' ';
   end;
    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=13)  then Key:=0;
end;


procedure TFormFace.FormShow(Sender: TObject);
begin
    presetShow();
   UpdateGrid();
   If StringGrid1.RowCount>0 then StringGrid1.Row:=StringGrid1.RowCount-1;
   StringGrid1.SetFocus;

   //контроль доступа
   if flag_access=1 then
     begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
     end;
end;

procedure TFormFace.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
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
            font.Style:= [fsBold];
           end
         else
          begin
            font.Style:= [];
            Font.Color := clBlack;
            font.Size:=11;
          end;
        //Наименование
      if (aRow>0) and (aCol=1) then
         begin
          Font.Size:=12;
          Font.Color := clBlack;
          TextOut(aRect.Left + 10, aRect.Top+8, Cells[aCol, aRow]);
         end;

       // Остальные поля
     if (aRow>0) and not(aCol=1) then
         begin
     //     Font.Size:=10;
     //     Font.Color := clBlack;
          TextOut(aRect.Left + 10, aRect.Top+8, Cells[aCol, aRow]);
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
           TextOut(aRect.Left + 5, aRect.Top+10, Cells[aCol, aRow]);
           //Рисуем значки сортировки и активного столбца
            DrawCell_header(aCol,Canvas,aRect.left,(Sender as TStringgrid));
          end;
     end;
end;


procedure TFormFace.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer  );
begin
  UsrParam();
end;

//добавить
procedure TFormFace.BitBtn1Click(Sender: TObject);
begin
 If fledit=2 then exit;
 If fledit=1 then
   begin
       If dialogs.MessageDlg('Внесенные изменения НЕ будут сохранены !'+#13+'Продолжить все равно ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
         exit;
   end;
  presetshow();
  fledit:=2;
  FormFace.BitBtn5.Enabled:=true;
  Edit1.SetFocus;
end;

//изменить
procedure TFormFace.BitBtn12Click(Sender: TObject);
begin
 If fledit=1 then exit;
 If fledit=2 then
   begin
       If dialogs.MessageDlg('Внесенные изменения НЕ будут сохранены !'+#13+'Продолжить все равно ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
         exit;
   end;
  with FOrmFace do
  begin
  If (StringGrid1.RowCount=1) or (StringGrid1.Cells[0,StringGrid1.row]='') then
    begin
      showmessagealt('Сначала выберите запись для редактирования!');
      exit;
    end;
   nRow:= StringGrid1.Row;
   fledit:=1;
   formFace.BitBtn5.Enabled:=true;
   Edit1.SetFocus;
  end;
end;

//удалить
procedure TFormFace.BitBtn2Click(Sender: TObject);
 var
   sstr : string;
   resF : byte;
   res_flag:integer;
begin
 If fledit>0 then
   begin
       If dialogs.MessageDlg('Внесенные изменения НЕ будут сохранены !'+#13+'Продолжить все равно ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
         exit;
   end;

  WIth FormFace do
  begin
  //Удаляем запись
   if (trim(StringGrid1.Cells[0,StringGrid1.row])='') or (StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

  If dialogs.MessageDlg('Подтверждаете удаление записи: '+#13+inttostr(StringGrid1.row)+' | '+StringGrid1.Cells[1,StringGrid1.row]+' ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;

 // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
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
     FormFace.ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('UPDATE av_suspect SET del=2,createdate=DEFAULT,id_user='+inttostr(id_user)+' WHERE del=0 AND date_trunc(''second'',createdate)='+QuotedStr(label9.Caption)+';');
     //showmessage(ZQuery1.SQL.text);//$
     FormFace.ZQuery1.ExecSQL;

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
   UpdateGrid();
  end;
end;

end.

