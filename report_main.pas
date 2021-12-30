unit report_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls,platproc,report_edit,report_vibor;

type

  { TFormReport }

  TFormReport = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
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
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);  procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;  aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid();
    function ChoiceDecode(vibor: string):boolean; //разбор кода перечня таблиц, выбор значений из которых нужен для печати отчета

  private
    { private declarations }
    FormActivated: boolean;
  public
    { public declarations }
  end; 

var
  FormReport: TFormReport;
  fl_edit: byte = 0;
  newRow : string;
  fl_open : byte = 0; //режим открытия этой формы (форма может быть открыта для выбора запроса отчета)
  fl_print : byte = 0; //режим открытия форм в режиме печати
  fl_vibor : byte = 0; //режим отображения формы выбора данных

implementation
uses
  mainopp, htmldoc, shedule_main, shedule_edit, nas, point_main, route_main, kontr_main, servers_main;
{$R *.lfm}

{ TFormReport }

//***********     разбор кода перечня таблиц, выбор значений из которых нужен для печати отчета **********************
function TFormReport.ChoiceDecode(vibor: string):boolean;
var
  m : integer;
  s: string;
begin
  // таблица соответствия кодов запуска форм выбора условий отчетов
  // s[1] = '1' shedule
  // s[2] = '1' shedule_sostav
  // s[2] = '2' shedule_atp
  // s[2] = '3' shedule_tarif
  // s[2] = '4' shedule_ats
  // s[2] = '5' shedule_sezon
  // s[2] = '6' shedule_lgot
  // s[2] = '7' shedule_uslugi
  // s[2] = '8' shedule_denyuser
  // s[3] = '1' spr_locality
  // s[4] = '1' spr_point
  // s[5] = '1' route
  // s[6] = '1' spr_kontragent
  // s[7] = '1' spr_kontr_dog
  // s[7] = '2' spr_kontr_viddog
  // s[7] = '3' spr_kontr_license
  // s[7] = '4' spr_kontr_ats
  // s[8] = '1' spr_ats
  // s[9] = '1' spr_uslugi
  // s[10] = '1' spr_lgot
  // s[11] = '1' users
  // s[12] = '1' servers
  // s[13] = '1' tarif
  // s[14] = '1' tarif_bagag
  // s[14] = '2' tarif_lgot
  // s[14] = '3' tarif_local
  // s[14] = '4' tarif_predv
  // s[14] = '5' tarif_uslugi
  // s[15] = '1' report_vibor - date
  // s[15] = '2' report_vibor - time
  // s[15] = '3' report_vibor - sezon
  // s[15] = '4' report_vibor - kolvo

  Result := false;
  s := trim(vibor);
  If (trim(s)='') then exit;
  s := PADL(s, '0', 15);

  fl_print:=1;   //режим печати (при открытии других форм)
  //FillReportVars(FormReport.ZConnection1,FormReport.ZQuery1);  // ЗАПОЛНЕНИЕ МАССИВА ПЕРЕМЕННЫХ ОТЧЕТОВ

 //выбор расписания
  If s[1]='1' then
   begin
      result_name_shedule := '';
     // showmessagealt('Выберите расписание...');
      form15:=Tform15.create(FormReport);
      form15.Label2.Caption:= 'Выберите расписание для печати отчета...';
      form15.ShowModal;
      FreeAndNil(form15);
      if (result_name_shedule='') then exit;
   end;

  //выбор на вкладке редактирования расписания
  If not(s[2]='0') then
   begin
      if (result_name_shedule='') then exit;
      form16:=Tform16.create(FormReport);
      With Form16 do
      begin
      //тарифы расписания
      If s[2]='3' then
      begin
      showmessagealt('Выберите начальный остановочный пункт для расчета...');
      PageControl1.ActivePageIndex:=2;
      PageControl2.ActivePageIndex:=0;
      TabSheet1.Enabled:= false;
      TabSheet3.Enabled:= false;
      TabSheet5.Enabled:= false;
      TabSheet8.Enabled:= false;
      TabSheet9.Enabled:= false;
      ShowModal;
      end;
      FreeAndNil(form16);
      end;
   end;

  //выбор населенного пункта
   If s[3]='1' then
    begin
      result_kod_nas := '';
      result_name_nas := '';
      //showmessagealt('Выберите населенный пункт для расчета...');
      Form5:=Tform5.create(FormReport);
      Form5.ShowModal;
      FreeAndNil(Form5);
      if trim(result_kod_nas)='' then exit;
    end;

 //выбор остановочного пункта
   If s[4]='1' then
    begin
      result_point_id := '';
      result_point_name := '';
      showmessagealt('Выберите остановочный пункт для отчета...');
      Form9:=Tform9.create(FormReport);
      Form9.ShowModal;
      FreeAndNil(Form9);
      if trim(result_point_id)='' then exit;
      //заполняем доступные значения в массив переменных отчета (таблица report_vars)
     for m:=Low(ar_report) to High(ar_report) do
      begin
       If trim(ar_report[m,0]) = 'point_kod'  then ar_report[m,2]:= result_point_id;
       If trim(ar_report[m,0]) = 'point_name' then ar_report[m,2]:= result_point_name;
      end;
    end;

  //выбор маршрута
   If s[5]='1' then
    begin
      result_id_route := '';
      showmessagealt('Выберите маршрут для расчета...');
      Form17:=Tform17.create(FormReport);
      Form17.ShowModal;
      FreeAndNil(Form17);
      If trim(result_id_route)='' then exit;
      // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
      begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      //Close;
      exit;
      end;
     //запрос списка
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('SELECT * FROM av_route WHERE del=0 AND id='+result_id_route+';');
     try
      ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       //ZQuery1.Close;
       //Zconnection1.disconnect;
       //Close;
       exit;
     end;
   if ZQuery1.RecordCount=1 then
     begin
      //заполняем доступные значения в массив переменных отчета (таблица report_vars)
     for m:=Low(ar_report) to High(ar_report) do
      begin
       If trim(ar_report[m,0]) = 'mar_id'  then ar_report[m,2]:= ZQuery1.FieldByName('id').AsString;
       If trim(ar_report[m,0]) = 'mar_kod'  then ar_report[m,2]:= ZQuery1.FieldByName('kod').AsString;
       If trim(ar_report[m,0]) = 'mar_name' then ar_report[m,2]:= result_name_route;
       If trim(ar_report[m,0]) = 'mar_type'  then ar_report[m,2]:= ZQuery1.FieldByName('type_route').AsString;
      end;
     end;
     //ZQuery1.Close;
     //Zconnection1.disconnect;

   end;


  //выбор контрагента
  If not(s[6]='0') then
   begin
     //Добавляем контрагента
    result_kontr_id:='';
    showmessagealt('Выберите контрагента...');
    formsk:=Tformsk.create(self);
    formsk.ShowModal;
    FreeAndNil(formsk);
     if  trim(result_kontr_id)='' then exit;
       // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
      begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
      end;
     //запрос списка
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('SELECT * FROM av_spr_kontragent WHERE del=0 AND id='+result_kontr_id+';');
     try
      ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       //ZQuery1.Close;
       //Zconnection1.disconnect;
       //Close;
       exit;
     end;
     if ZQuery1.RecordCount=1 then
     begin
     for m:=Low(ar_report) to High(ar_report) do
      begin
       If trim(ar_report[m,0]) = 'atp_id'  then ar_report[m,2]:= ZQuery1.FieldByName('id').AsString;
       If trim(ar_report[m,0]) = 'atp_kod1c'  then ar_report[m,2]:= ZQuery1.FieldByName('kod1c').AsString;
       If trim(ar_report[m,0]) = 'atp_name' then ar_report[m,2]:= ZQuery1.FieldByName('name').asString;
       If trim(ar_report[m,0]) = 'atp_inn'  then ar_report[m,2]:= ZQuery1.FieldByName('inn').asString;
       If trim(ar_report[m,0]) = 'atp_vid'  then ar_report[m,2]:= ZQuery1.FieldByName('vidkontr').asString;
       If trim(ar_report[m,0]) = 'atp_okpo'  then ar_report[m,2]:=ZQuery1.FieldByName('okpo').asString;
       If trim(ar_report[m,0]) = 'atp_tel'  then ar_report[m,2]:=ZQuery1.FieldByName('tel').asString;
       If trim(ar_report[m,0]) = 'atp_adrur'  then ar_report[m,2]:=ZQuery1.FieldByName('adrur').asString;
       If trim(ar_report[m,0]) = 'atp_document'  then ar_report[m,2]:=ZQuery1.FieldByName('document').asString;
      end;
     end;
     //ZQuery1.Close;
     //Zconnection1.disconnect;

   end;

  //выбор серверов системы
  If s[12]='1' then
   begin
      result_srv_id := '';
      form_Servers:=Tform_Servers.create(FormReport);
      form_Servers.Label2.Caption:= 'Выберите подразделение для отчета...';
      form_Servers.ShowModal;
      FreeAndNil(form_Servers);
      if trim(result_srv_id)='' then exit;
   end;

  //универсальный выбор report_vibor
  If not(s[15]='0') then
    begin
      fl_vibor := strtoint(s[15]);
      FormRepV:=TformRepV.create(FormReport);
      FormRepV.ShowModal;
      FreeAndNil(FormRepV);
    end;

  fl_print:=0;  //открывать другие формы в обычном режиме
  Result := true;
end;

//****************************  КНОПКА ПЕЧАТЬ   *****************************************************************************
procedure TFormReport.BitBtn5Click(Sender: TObject);
begin
  If (Stringgrid1.RowCount<1) or (trim(Stringgrid1.Cells[1,Stringgrid1.Row])='') then exit;
  try
    strtoint(Stringgrid1.Cells[3,Stringgrid1.Row]);
  except
    showmessagealt('ОШИБКА ! Выберите корректную строку отчета !');
    exit;
  end;
  If fl_open=0 then
  BeginReport(ZConnection1, ZQuery1, strtoint(Stringgrid1.Cells[3,Stringgrid1.Row]),1)
  else
    begin
      newRow := trim(StringGrid1.Cells[3,StringGrid1.row]);
      Close;
    end;
  Stringgrid1.SetFocus;
end;


procedure TFormReport.UpdateGrid();
 var
   gr,n:integer;
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
   ZQuery1.SQL.add('SELECT * FROM av_reports WHERE del=0 AND (id_arm=0 OR id_arm='+inttostr(id_arm)+') ORDER BY id_order;');

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
      StringGrid1.Cells[0,n]:=ZQuery1.FieldByName('id_order').asString;
      StringGrid1.Cells[1,n]:=ZQuery1.FieldByName('naim').asString;
      gr:=ZQuery1.FieldByName('grup').asInteger;
      If gr=0 then StringGrid1.Cells[2,n]:='Маршрутная сеть';
      If gr=1 then StringGrid1.Cells[2,n]:='Тарифы';
      If gr=2 then StringGrid1.Cells[2,n]:='Аналитика';
      If gr=3 then StringGrid1.Cells[2,n]:='Разное';
      StringGrid1.Cells[3,n]:=ZQuery1.FieldByName('id').asString;

      ZQuery1.Next;
    end;
   ZQuery1.Close;
   Zconnection1.disconnect;
   StringGrid1.Refresh;
   StringGrid1.SetFocus;

end;

procedure TFormReport.ToolButton8Click(Sender: TObject);
begin
    GridPoisk(StringGrid1,Edit1);
end;

procedure TFormReport.ToolButton1Click(Sender: TObject);
begin
   SortGrid(StringGrid1,StringGrid1.col,ProgressBar1,0,1);
end;

procedure TFormReport.BitBtn4Click(Sender: TObject);
begin
  Close;
end;


procedure TFormReport.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
begin
    // Автоматический контекстный поиск
    if (GetSymKey(char(Key))=true) then
      begin
        Edit1.SetFocus;
      end;
     if (Key=13) and ( Edit1.Focused) then  ToolButton8.Click;

    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ENTER] - начать поиск'+#13+'[ПРОБЕЛ] - Выбор/Печать'+#13+'[ESC] - Отмена\Выход');
    //F4 - Изменить
    if (Key=115) and ( bitbtn12.enabled=true) then  BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and ( bitbtn1.enabled=true) then  BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then  ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and ( bitbtn2.enabled=true) then  BitBtn2.Click;
    // ESC
    if Key=27 then  BitBtn4.Click;
    // ПРОБЕЛ  -  печатать
    if (Key=32) and (StringGrid1.Focused) then  BitBtn5.Click;
    //if (Key=32) and ( Edit1.Focused) then  Edit1.Text:= Edit1.Text+' ';

    If (Key=32) AND not(Edit1.Focused) then Key:=0;
    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=13)  then Key:=0;
end;




procedure TFormReport.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
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

procedure TFormReport.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Click_Header((Sender as TStringgrid),X,Y,Self.ProgressBar1);
end;

procedure TFormReport.BitBtn1Click(Sender: TObject);
begin
   //Создаем новую запись отчета
  fl_edit:=1;
  if dialogs.MessageDlg('Создать новый отчет на основе выделенного ?',mtConfirmation,[mbYes,mbNO], 0)=6 then
   begin
    fl_edit:=3;
   end;

  formRepEdit:=TformRepEdit.create(self);
  formRepEdit.ShowModal;
  FreeAndNil(formRepEdit);
  UpdateGrid();
end;

procedure TFormReport.BitBtn12Click(Sender: TObject);
begin
  If (StringGrid1.RowCount=1) or (StringGrid1.Cells[3,StringGrid1.row]='') then
    begin
      showmessagealt('Сначала выберите запись для редактирования!');
      exit;
    end;
//Редактируем запись отчета
  fl_edit:=2;
  formRepEdit:=TformRepEdit.create(self);
  formRepEdit.ShowModal;
  FreeAndNil(formRepEdit);
  UpdateGrid();
end;

procedure TFormReport.BitBtn2Click(Sender: TObject);
 var
   sstr : string;
   resF : byte;
   res_flag:integer;
begin
  WIth FormReport do
  begin
  //Удаляем запись
   if (trim(StringGrid1.Cells[0,StringGrid1.row])='') or (StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

  res_flag := dialogs.MessageDlg('Удалить отчет '+#13+inttostr(StringGrid1.row)+' | '+StringGrid1.Cells[1,StringGrid1.row]+'?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag<>6 then exit;

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
     FormReport.ZQuery1.SQL.Clear;
     FormReport.ZQuery1.SQL.add('UPDATE av_reports SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(FormReport.StringGrid1.Cells[3,FormReport.StringGrid1.row])+' and del=0;');
     //showmessage(ZQuery1.SQL.text);
     FormReport.ZQuery1.ExecSQL;

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


procedure TFormReport.FormShow(Sender: TObject);
begin
   if flag_access=1 then
     begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
     end;
end;

procedure TFormReport.FormActivate(Sender: TObject);
begin
  if not FormActivated then begin
    FormActivated := True;
    UpdateGrid();
   StringGrid1.Col:=2;
   StringGrid1.SetFocus;
  end;
end;

end.

