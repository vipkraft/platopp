unit dogovor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, platproc, ExtCtrls, kontr_edit,
  dogovor1c, dogovor_edit;

type

  { TForm23 }

  TForm23 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    Shape1: TShape;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);


    procedure UpdateGrid();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form23: TForm23;
  fl_edit_dog: byte;


implementation
uses
  mainopp,kontr_main,shedule_edit;

{$R *.lfm}
var
   n: integer;

{ TForm23 }

//********************************* ОБНОВЛЕНИЕ ДАННЫХ НА ГРИДЕ ******************************************
procedure TForm23.UpdateGrid();
var
   dd : TDateTime;
begin
  With Form23 do
  begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('(select a.id,a.name,a.datazak,a.datavoz,a.datapog,a.kod1c,a.createdate ');
   ZQuery1.SQL.add(',(select b.name from av_spr_kontr_viddog b where del=0 ');
   ZQuery1.SQL.add('and (cast(case when coalesce(trim(a.viddog),''0'')='''' then ''0'' else coalesce(trim(a.viddog),''0'') end as integer))=b.kod1c ');
   ZQuery1.SQL.add('order by b.createdate desc limit 1) as viddog ');
   ZQuery1.SQL.add(' FROM av_spr_kontr_dog AS a ');
   ZQuery1.SQL.add('WHERE a.del=0 ');
   If tekkontr<>'0' then
   ZQuery1.SQL.add(' AND a.ID_kontr IN ('+tekkontr+')');
   ZQuery1.SQL.add(' ORDER by a.id desc);');
   //showmessage(ZQuery1.SQL.Text);//$
   try
      ZQuery1.open;
   except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
   end;
   if ZQuery1.RecordCount=0 then
     begin
      Form23.ZQuery1.Close;
      Form23.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   StringGrid1.RowCount:=ZQuery1.RecordCount+1;
   for n:=1 to ZQuery1.RecordCount do
    begin
      Form23.StringGrid1.Cells[0,n]:=Form23.ZQuery1.FieldByName('id').asString;
      Form23.StringGrid1.Cells[1,n]:=Form23.ZQuery1.FieldByName('name').asString;
      Form23.StringGrid1.Cells[2,n]:=Form23.ZQuery1.FieldByName('viddog').asString;
      Form23.StringGrid1.Cells[3,n]:=Form23.ZQuery1.FieldByName('datazak').asString;
      Form23.StringGrid1.Cells[4,n]:=Form23.ZQuery1.FieldByName('datavoz').asString;
      Form23.StringGrid1.Cells[5,n]:=Form23.ZQuery1.FieldByName('datapog').asString;
      Form23.StringGrid1.Cells[6,n]:=Form23.ZQuery1.FieldByName('kod1c').asString;
      Form23.StringGrid1.Cells[7,n]:=Form23.ZQuery1.FieldByName('createdate').asString;

      dd:= Form23.ZQuery1.FieldByName('datapog').AsDateTime;
      //Ставим 1, если договор просрочен
      If dd<Date then
       Form23.StringGrid1.Cells[8,n]:='1';
      //договор истекает
      If ((dd-Date)>0) AND ((dd-Date)<30) then
       Form23.StringGrid1.Cells[8,n]:='Договор истекает '+DateToStr(dd)+' !';


      Form23.ZQuery1.Next;
    end;

   Form23.ZQuery1.Close;
   Form23.Zconnection1.disconnect;
   Form23.StringGrid1.Refresh;
   StringGrid1.ColWidths[7]:=0;
   StringGrid1.ColWidths[8]:=0;
  end;
end;

//*********************************************** ДОБАВИТЬ **********************************************
procedure TForm23.BitBtn1Click(Sender: TObject);
begin
  fl_edit_dog:=1; //флаг операции
  Form24:=TForm24.create(self);
  Form24.ShowModal;
  FreeAndNil(Form24);
  UpdateGrid();
end;


//********************************************** УДАЛИТЬ  *****************************************************
procedure TForm23.BitBtn2Click(Sender: TObject);
var
   res_flag:integer;
begin
  With Form23 do
  begin

  //Удаляем запись
   if (trim(Form23.StringGrid1.Cells[0,Form23.StringGrid1.row])='') or (Form23.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

  res_flag := dialogs.MessageDlg('Удалить запись данного договора ?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag<>6 then exit;
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
     Form23.ZQuery1.SQL.Clear;
     If trim(Form23.StringGrid1.Cells[2,Form23.StringGrid1.row])='*' then
     Form23.ZQuery1.SQL.add('UPDATE av_spr_kontr_dog2 SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(Form23.StringGrid1.Cells[0,Form23.StringGrid1.row])+' and del=0;')
       else
     Form23.ZQuery1.SQL.add('UPDATE av_spr_kontr_dog SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(Form23.StringGrid1.Cells[0,Form23.StringGrid1.row])+' and del=0;');
 //    showmessagealt(Form23.ZQuery1.SQL.Text);
     Form23.ZQuery1.ExecSQL;
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
   UpdateGrid();

  end;
end;


//**************************************************    ИЗМЕНИТЬ  ***************************************************
procedure TForm23.BitBtn12Click(Sender: TObject);
begin
 with Form23.StringGrid1 do
 begin
   //Редактируем запись населенного пункта
  //if (Cells[0,row]=EMPTYSTR) or (RowCount=1) then
  if (trim(Cells[0,row])='') or (RowCount=1) then
    begin
      showmessagealt('Не выбрана запись для редактирования !');
      exit;
    end;
  fl_edit_dog:=2; //флаг операции
  Form24:=TForm24.create(self);
  Form24.ShowModal;
  FreeAndNil(Form24);
  Form23.UpdateGrid();
 end;
end;

//***********************************************       ВЫХОД     **********************************************************
procedure TForm23.BitBtn4Click(Sender: TObject);
begin
  Form23.Close;
end;

//***********************************************      ВЫБРАТЬ  ***************************************************************
procedure TForm23.BitBtn5Click(Sender: TObject);
begin
  if (form23.StringGrid1.RowCount>1) then
    begin
     result_dog:=form23.StringGrid1.Cells[0,form23.StringGrid1.row]+'| '+form23.StringGrid1.Cells[1,form23.StringGrid1.row];
     form23.close;
    end;
end;


//************************************************* HOTKEYS ********************************************************************
procedure TForm23.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');

    //F4 - Изменить
    if (Key=115) and (Form23.bitbtn12.enabled=true) then Form23.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (Form23.bitbtn1.enabled=true) then Form23.BitBtn1.Click;
    //F8 - Удалить
    if (Key=119) and (Form23.bitbtn2.enabled=true) then Form23.BitBtn2.Click;
    // ESC
    if Key=27 then Form23.Close;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32) AND (Form23.StringGrid1.Focused=true) then Form23.BitBtn5.Click;
    if (Key=112) or (Key=113) or (Key=115) or (Key=116) or (Key=119) or (Key=27)   then Key:=0;
end;


//***********************************   ОТРИСОВКА ГРИДА ****************************************************
procedure TForm23.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
const
  sAlarm = 'Договор ПРОСРОЧЕН !';
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

   //Если есть договор истек
     if (ARow > 0) AND (ACol=1) AND (trim(Cells[8,aRow])='1') AND (trim(Cells[2,aRow])<>'*') then
      begin
        Font.Color := cAl;
        Font.Style := [fsBold];
        TextOut(aRect.Left+40, aRect.Top+25, sAlarm);
      end;

   //Если есть договор скоро истечет
     if (ARow > 0) AND (ACol=1) AND (trim(Cells[8,aRow])<>'1') then
      begin
        Font.Color := cAl;
        Font.Style := [];
        TextOut(aRect.Left+40, aRect.Top+25, Cells[8, ARow]);
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



  // **************************************  ВОЗНИКНОВЕНИЕ ФОРМЫ ****************************************
procedure TForm23.FormShow(Sender: TObject);
begin
 //Centrform(Form23);
 Form23.StringGrid1.RowHeights[0]:=30;
 //Form23.Label3.Caption:=formsk.StringGrid1.Cells[2,formsk.StringGrid1.Row];
 //определить уровень доступа
    if flag_access=1 then
     begin
      with Form23 do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
  Form23.UpdateGrid();

end;

end.

