unit license;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, nas_edit, platproc, ExtCtrls,
  EditBtn, Spin;

type

  { TFormLic }

  TFormLic = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ProgressBar1: TProgressBar;
    Shape1: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    SpinEdit1: TSpinEdit;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure ToolButton1Click(Sender: TObject);

    procedure UpdateGrid();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormLic: TFormLic;

implementation
uses
  mainopp,kontr_main;

{$R *.lfm}
var
   n,new_id: integer;
   fl_edit : byte;
{ TFormLic }

//********************************* ОБНОВЛЕНИЕ ДАННЫХ НА ГРИДЕ ******************************************
procedure TFormLic.UpdateGrid();
begin
  With FormLic do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   FormLic.ZQuery1.SQL.Clear;
   FormLic.ZQuery1.SQL.add('select * from av_spr_kontr_license WHERE del=0 AND ID_kontr='+formsk.StringGrid1.Cells[1,formsk.StringGrid1.Row]+' ORDER by id;');

   FormLic.ZQuery1.open;
   if FormLic.ZQuery1.RecordCount=0 then
     begin
      FormLic.ZQuery1.Close;
      FormLic.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   FormLic.StringGrid1.RowCount:=FormLic.ZQuery1.RecordCount+1;
   for n:=1 to FormLic.ZQuery1.RecordCount do
    begin
      FormLic.StringGrid1.Cells[0,n]:=FormLic.ZQuery1.FieldByName('id').asString;
      FormLic.StringGrid1.Cells[1,n]:=FormLic.ZQuery1.FieldByName('name').asString;
      FormLic.StringGrid1.Cells[3,n]:=FormLic.ZQuery1.FieldByName('datanach').asString;
      FormLic.StringGrid1.Cells[4,n]:=FormLic.ZQuery1.FieldByName('dataok').asString;
      FormLic.StringGrid1.Cells[5,n]:=FormLic.ZQuery1.FieldByName('kod1c').asString;
      FormLic.ZQuery1.Next;
    end;

   FormLic.ZQuery1.Close;
   FormLic.Zconnection1.disconnect;
   FormLic.StringGrid1.Refresh;
  end;
end;

//*********************************************** ДОБАВИТЬ **********************************************
procedure TFormLic.BitBtn1Click(Sender: TObject);
begin
  FOrmlic.Edit1.Text:='';
  FOrmlic.SpinEdit1.value:=0;
  FOrmlic.DateEdit1.Text:='';
  FOrmlic.DateEdit2.Text:='';
  FOrmlic.GroupBox1.Enabled:=true;
  fl_edit:=0;
  formlic.GroupBox1.Enabled:=true;
end;

//**************************************************    ИЗМЕНИТЬ  ***************************************************
procedure TFormLic.BitBtn12Click(Sender: TObject);
begin
 with FormLic.StringGrid1 do
 begin
   //Редактируем запись населенного пункта
  //if (Cells[0,row]=EMPTYSTR) or (RowCount=1) then
  if (trim(Cells[0,row])='') or (RowCount=1) then
    begin
      showmessagealt('Не выбрана запись для редактирования !');
      exit;
    end;
  FOrmlic.Edit1.Text:=Cells[1,row];
  FOrmlic.SpinEdit1.value:=strToInt(Cells[5,row]);
  FOrmlic.DateEdit1.Text:=Cells[3,row];
  FOrmlic.DateEdit2.Text:=Cells[4,row];
  FOrmlic.GroupBox1.Enabled:=true;
  fl_edit:=1;
  formlic.GroupBox1.Enabled:=true;
 end;
end;

//********************************************** УДАЛИТЬ  *****************************************************
procedure TFormLic.BitBtn2Click(Sender: TObject);
begin
  With FormLic do
  begin
  //Удаляем запись
   if (trim(FormLic.StringGrid1.Cells[0,FormLic.StringGrid1.row])='') or (FormLic.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;
  If dialogs.MessageDlg('Удалить запись данной лицензии ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;
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
      exit;
     end;
     ZQuery1.SQL.Clear;
     FormLic.ZQuery1.SQL.add('UPDATE av_spr_kontr_license SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(FormLic.StringGrid1.Cells[0,FormLic.StringGrid1.row])+' and del=0;');
     ZQuery1.ExecSQL;
       //завершение транзакции
   Zconnection1.Commit;
 except
     ZConnection1.Rollback;
     Zconnection1.disconnect;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.close;
     exit;
 end;
     FormLic.Zconnection1.disconnect;
     FormLic.UpdateGrid();
  end;
end;

//**************************************************** СОХРАНИТЬ ***********************************
procedure TFormLic.BitBtn3Click(Sender: TObject);
var
  new_id: integer;
begin
  with FormLic, FormLic.StringGrid1 do
  begin
  //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if (trim(Edit1.text)='') then
   begin
     showmessagealt('Сначала заполните поле НАИМЕНОВАНИЕ Лицензии !!!');
     exit;
   end;
  if (trim(DateEdit1.text)='') then
   begin
     showmessagealt('Сначала заполните поле ДАТА НАЧАЛА !');
     exit;
   end;
  if (trim(DateEdit2.text)='') then
   begin
     showmessagealt('Сначала заполните поле ДАТА ОКОНЧАНИЯ !');
     exit;
   end;
  try
    strtodate(DateEdit1.text);
  except
    showmessagealt('Некорректно заполнена ДАТА НАЧАЛА !');
     exit;
  end;
  try
    strtodate(DateEdit2.text);
  except
    showmessagealt('Некорректно заполнена ДАТА ОКОНЧАНИЯ !');
     exit;
  end;

  If DateEdit1.Date>DateEdit2.Date then
   begin
     showmessagealt('ДАТА оконачания лицензии МЕНЬШЕ ДАТЫ ее начала !');
     exit;
   end;

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
      exit;
     end;
  //режим добавления
  if fl_edit=0 then
      begin
  //Определяем текущий id+1
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_kontr_license;');
        ZQuery1.open;
        new_id:=ZQuery1.FieldByName('new_id').asInteger+1;
      end;
   //режим редактирования
  if fl_edit=1 then
      begin
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_spr_kontr_license SET del=1,createdate=default WHERE id='+Cells[0,row]+' and del=0;');
       ZQuery1.ExecSQL;
      end;

       //создание записи
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.Add('INSERT INTO av_spr_kontr_license(id,id_kontr,kodkont,kod1c,name,datanach,dataok,id_user,createdate,id_user_first,createdate_first,del) VALUES (');
       //режим добавления
  if fl_edit=0 then
      ZQuery1.SQL.add(inttostr(new_id)+','+formsk.StringGrid1.Cells[1,formsk.StringGrid1.Row]+','+formsk.StringGrid1.Cells[4,formsk.StringGrid1.ROw]+','+intToStr(SpinEdit1.value)+','+QuotedSTR(Edit1.text)+','+QuotedSTR(DateEdit1.text)+','+QuotedSTR(DateEdit2.text)+','+inttostr(id_user)+',now(),'+inttostr(id_user)+',now(),0);');
   //режим редактирования
  if fl_edit=1 then
  ZQuery1.SQL.add(Cells[0,Row]+','+formsk.StringGrid1.Cells[1,formsk.StringGrid1.Row]+','+formsk.StringGrid1.Cells[4,formsk.StringGrid1.ROw]+','+intToStr(SpinEdit1.value)+','+QuotedSTR(Edit1.text)+','+QuotedSTR(DateEdit1.text)+','+QuotedSTR(DateEdit2.text)+','+inttostr(id_user)+',now(),NULL,NULL,0);');
//  ZQuery1.SQL.add(Cells[0,Row]+','+formsk.StringGrid1.Cells[1,formsk.StringGrid1.Row]+','+formsk.StringGrid1.Cells[4,formsk.StringGrid1.ROw]+','+intToStr(SpinEdit1.value)+','+QuotedSTR(Edit1.text)+','+QuotedSTR(DateEdit1.text)+','+QuotedSTR(DateEdit2.text)+','+inttostr(id_user)+',now(),now(),NULL,NULL,0);');
   //showmessage(ZQuery1.SQL.Text);//$
    ZQuery1.ExecSQL;
    Zconnection1.Commit;
    //showmessagealt('Транзакция завершена УСПЕШНО !!!');
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   ZQuery1.Close;
   Zconnection1.disconnect;
   formlic.GroupBox1.Enabled:=false;
  end;
  FormLic.UpdateGrid();
end;


//***********************************************       ВЫХОД     **********************************************************
procedure TFormLic.BitBtn4Click(Sender: TObject);
begin
  FormLic.Close;
end;

//***********************************************      ВЫБРАТЬ  ***************************************************************
procedure TFormLic.BitBtn5Click(Sender: TObject);
begin

end;


//************************************************* HOTKEYS ********************************************************************
procedure TFormLic.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');

    //F4 - Изменить
    if (Key=115) and (FormLic.bitbtn12.enabled=true) then FormLic.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (FormLic.bitbtn1.enabled=true) then FormLic.BitBtn1.Click;
    //F8 - Удалить
    if (Key=119) and (FormLic.bitbtn2.enabled=true) then FormLic.BitBtn2.Click;
    // ESC
    if Key=27 then FormLic.Close;
    // Пробел
    if (Key=32) AND (FormLic.StringGrid1.Focused=true) then FormLic.BitBtn5.Click;

    if (Key=112) or (Key=113) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=13)   then Key:=0;
end;


//***********************************   ОТРИСОВКА ГРИДА ****************************************************
procedure TFormLic.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
    cBrush,cFont,cFontOther,cDefault,cAl,cPen: TColor;
begin
   cBrush:=clMenuHighLight;
   cFont:=clBlack;
   cAl := $000505A8;
   cFontOther := clNavy;//$006868DE;
   cDefault := clCream;
   cPen := clBlue;
 with Sender as TStringGrid,Canvas do
  begin
       Brush.Color:=clWhite;
       //Закрашиваем бэкграунд
       FillRect(aRect);
     if (gdSelected in aState) then
           begin
            pen.Width:=6;
            pen.Color:=cPen;
            MoveTo(aRect.left,aRect.bottom-1);
            LineTo(aRect.right,aRect.Bottom-1);
            MoveTo(aRect.left,aRect.top-1);
            LineTo(aRect.right,aRect.Top);
            Font.Color := cFontOther;
            font.Size:=10;
            font.Style:= [];
           end
         else
          begin
            font.Style:= [];
            Font.Color := cFont;
            font.Size:=10;
          end;

     //Остальные поля
  if (ARow > 0) then
  begin
    TextOut(aRect.Left+10, aRect.Top+5, Cells[ACol, ARow]);
  end;

  //лицензия
     If (trim(Cells[4,aRow])<>'') AND (aCol=2) AND (aRow>0) then
      begin
        If StrToDate(Cells[4,aRow])<Date then
         begin
           Font.Size := 10;
           FOnt.COlor := clRed;
           font.Style:= [fsBold];
           TextOut(aRect.Left + 5, aRect.Top + 5, 'Лицензия ПРОСРОЧЕНА !!!');
         end;
        If (StrToDate(Cells[4,aRow])-Date)>29 then
         begin
           Font.Size := 10;
           FOnt.COlor := clGreen;
           font.Style:= [];
           TextOut(aRect.Left + 5, aRect.Top + 5, 'Лицензия истекает '+Cells[4,aRow]);
         end;

        If ((StrToDate(Cells[4,aRow])-Date)<30) AND ((StrToDate(Cells[4,aRow])-Date)>0) then
         begin
           Font.Size := 10;
           FOnt.COlor := clBlack;
           font.Style:= [];
           TextOut(aRect.Left + 5, aRect.Top + 5, 'ВНИМАНИЕ ! Лицензия истекает '+Cells[4,aRow]);
         end;
      end;

  // Заголовок
  if aRow=0 then
         begin
           Brush.Color:=cDefault;
           FillRect(aRect);
           Font.Color := cFont;
           font.Size:=9;
           TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
          end;

 end;

end;


procedure TFormLic.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
  FOrmlic.GroupBox1.Enabled:=false;
end;


//************************************************* СОРТИРОВКА **********************************************
procedure TFormLic.ToolButton1Click(Sender: TObject);
begin
   SortGrid(FormLic.StringGrid1,FormLic.StringGrid1.col,FormLic.ProgressBar1,0,1);
end;

  // **************************************  ВОЗНИКНОВЕНИЕ ФОРМЫ ****************************************
procedure TFormLic.FormShow(Sender: TObject);
begin
 //FormLic.StringGrid1.RowHeights[0]:=20;
 FormLic.Label3.Caption:=copy(formsk.StringGrid1.Cells[2,formsk.StringGrid1.Row],1,pos('     ',formsk.StringGrid1.Cells[2,formsk.StringGrid1.Row]));
 FOrmlic.GroupBox1.Enabled:=false;
 //определить уровень доступа
    if flag_access=1 then
     begin
      with FormLic do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
  FormLic.UpdateGrid();

end;

end.

