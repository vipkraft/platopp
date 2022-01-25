unit tarif_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids, ActnList, platproc, LazUtf8,
  tarif_edit;

type

  { TFormtarif }

  TFormtarif = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel7: TBevel;
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
    procedure UpdateGridOther();
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formtarif: TFormtarif;
  flag_edit_tarif:integer;
  result_name_tarif:string;
  max_date:string;

implementation
 uses
   mainopp;
{$R *.lfm}

{ TFormtarif }


var
  //s_zapros : string;
  //n_idroute: integer;
  //n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flag :boolean;
  //tek_tarif_ind:integer;
  //tarif_id:string;
  //ar_seats : array of string;
  editstamp:Tdatetime;
  mysett:TFormatSettings;

 procedure Tformtarif.UpdateGridOther();
 var
   n:integer;
 begin
  with FormTarif do
  begin
   decimalseparator:='.';
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
  // -------------------------- Обновляем СЕТКУ НОРМЫ ТАРИФА--------------------------
  formtarif.ZQuery1.SQL.Clear;
  formtarif.ZQuery1.SQL.add('Select * from av_tarif_local where del=0 and id_tarif='+trim(formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.Row])+' and id_point=0;');
  //showmessage(ZQuery1.SQL.Text);//$
  try
      formtarif.ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
     end;
  if formtarif.ZQuery1.RecordCount<1 then
     begin
       //showmessagealt('Нет данных для редактирования !');
       formtarif.ZQuery1.close;
       formtarif.Zconnection1.disconnect;
       exit;
     end;
  formtarif.StringGrid2.rowcount:=1;
  for n:=0 to formtarif.ZQuery1.RecordCount-1 do
     begin
      formtarif.StringGrid2.rowcount:=formtarif.StringGrid2.rowcount+1;
      formtarif.StringGrid2.Cells[0,formtarif.StringGrid2.RowCount-1]:=trim(formtarif.ZQuery1.FieldByName('id_n').asString);
      formtarif.StringGrid2.Cells[1,formtarif.StringGrid2.RowCount-1]:=trim(formtarif.ZQuery1.FieldByName('name').asString);
      // Тип МАРШРУТА
      if formtarif.ZQuery1.FieldByName('typpath').asInteger=0 then  formtarif.StringGrid2.Cells[2,formtarif.StringGrid2.RowCount-1]:='-любой-';
      if formtarif.ZQuery1.FieldByName('typpath').asInteger=1 then  formtarif.StringGrid2.Cells[2,formtarif.StringGrid2.RowCount-1]:=cMezhgorod;
      if formtarif.ZQuery1.FieldByName('typpath').asInteger=2 then  formtarif.StringGrid2.Cells[2,formtarif.StringGrid2.RowCount-1]:=cPrigorod;
      if formtarif.ZQuery1.FieldByName('typpath').asInteger=3 then  formtarif.StringGrid2.Cells[2,formtarif.StringGrid2.RowCount-1]:='Межобластной\Межкраевой';
      if formtarif.ZQuery1.FieldByName('typpath').asInteger=4 then  formtarif.StringGrid2.Cells[2,formtarif.StringGrid2.RowCount-1]:=cGos;
      // Класс АТС
      if formtarif.ZQuery1.FieldByName('klassats').asInteger=0 then  formtarif.StringGrid2.Cells[3,formtarif.StringGrid2.RowCount-1]:='-любой-';
      if formtarif.ZQuery1.FieldByName('klassats').asInteger=1 then  formtarif.StringGrid2.Cells[3,formtarif.StringGrid2.RowCount-1]:='Мягкий';
      if formtarif.ZQuery1.FieldByName('klassats').asInteger=2 then  formtarif.StringGrid2.Cells[3,formtarif.StringGrid2.RowCount-1]:='Жесткий';
      // Тип АТС
      if formtarif.ZQuery1.FieldByName('typats').asInteger=0 then  formtarif.StringGrid2.Cells[4,formtarif.StringGrid2.RowCount-1]:='-любой-';
      if formtarif.ZQuery1.FieldByName('typats').asInteger=1 then  formtarif.StringGrid2.Cells[4,formtarif.StringGrid2.RowCount-1]:='М2';
      if formtarif.ZQuery1.FieldByName('typats').asInteger=2 then  formtarif.StringGrid2.Cells[4,formtarif.StringGrid2.RowCount-1]:='М3';
      // Сумма
      if pos('.',trim(formtarif.ZQuery1.FieldByName('sum').asString))>0 then
         formtarif.StringGrid2.Cells[5,formtarif.StringGrid2.RowCount-1]:=trim(formtarif.ZQuery1.FieldByName('sum').asString)
      else
         formtarif.StringGrid2.Cells[5,formtarif.StringGrid2.RowCount-1]:=trim(formtarif.ZQuery1.FieldByName('sum').asString)+'.00';
      formtarif.ZQuery1.Next;
     end;
  // -------------------------- Обновляем СЕТКУ НОРМЫ БАГАЖА--------------------------
  formtarif.ZQuery1.SQL.Clear;
  formtarif.ZQuery1.SQL.add('Select * from av_tarif_bagag where del=0 and id_tarif='+trim(formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.Row])+' and id_point=0 ORDER by km_ot;');
  try
      formtarif.ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
     end;
  if formtarif.ZQuery1.RecordCount<1 then
     begin
       //showmessagealt('Нет данных для редактирования !');
       formtarif.ZQuery1.close;
       formtarif.Zconnection1.disconnect;
       exit;
     end;
  formtarif.StringGrid3.rowcount:=1;
  for n:=0 to formtarif.ZQuery1.RecordCount-1 do
     begin
      formtarif.StringGrid3.rowcount:=formtarif.StringGrid3.rowcount+1;
      formtarif.StringGrid3.Cells[0,formtarif.StringGrid3.RowCount-1]:=trim(formtarif.ZQuery1.FieldByName('km_ot').asString);
      formtarif.StringGrid3.Cells[1,formtarif.StringGrid3.RowCount-1]:=trim(formtarif.ZQuery1.FieldByName('km_do').asString);
      formtarif.StringGrid3.Cells[2,formtarif.StringGrid3.RowCount-1]:=trim(formtarif.ZQuery1.FieldByName('sum').asString);
      formtarif.StringGrid3.Cells[3,formtarif.StringGrid3.RowCount-1]:=trim(formtarif.ZQuery1.FieldByName('proc').asString);
      formtarif.ZQuery1.Next;
     end;
  formtarif.ZQuery1.close;
  formtarif.ZConnection1.Disconnect;
  end;
 end;

 procedure Tformtarif.UpdateGrid(filter_type:byte; stroka:string);
 var
   n:integer;
 begin
   //// Подключаемся к серверу
   //If not(Connect2(Zconnection1, flagProfile)) then
   //  begin
   //   showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
   //   exit;
   //  end;
   //// Определяем пользователя
   //formtarif.ZQuery1.SQL.clear;
   //formtarif.ZQuery1.SQL.add('select * from av_tarif where del=0 ORDER BY datetarif;');
   ////showmessage(ZQuery1.SQL.text);//$
   //try
   //   formtarif.ZQuery1.open;
   //  except
   //    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
   //    ZQuery1.Close;
   //    Zconnection1.disconnect;
   //    exit;
   //  end;
   //
   //if formtarif.ZQuery1.RecordCount=0 then
   //   begin
   //     formtarif.ZQuery1.close;
   //     formtarif.ZConnection1.Disconnect;
   //     exit;
   //   end;
   //
   //// Заполняем stringgrid
   //formtarif.StringGrid1.RowCount:=formtarif.ZQuery1.RecordCount+1;
   //for n:=1 to formtarif.ZQuery1.RecordCount do
   // begin
   //   formtarif.StringGrid1.Cells[0,n]:=formtarif.ZQuery1.FieldByName('id').asString;
   //   formtarif.StringGrid1.Cells[1,n]:=formtarif.ZQuery1.FieldByName('datetarif').asString;
   //   formtarif.StringGrid1.Cells[2,n]:=formtarif.ZQuery1.FieldByName('dateraschet').asString;
   //   formtarif.ZQuery1.Next;
   //end;
   ////formtarif.memo1.Text:=trim(formtarif.ZQuery1.FieldByName('swed').asString);
   //// Определяем текущий тариф
   //formtarif.ZQuery1.SQL.clear;
   //formtarif.ZQuery1.SQL.add('select max(datetarif) as maxtarif from av_tarif where del=0;');
   //try
   //   formtarif.ZQuery1.open;
   //  except
   //    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
   //    ZQuery1.Close;
   //    Zconnection1.disconnect;
   //    exit;
   //  end;
   //max_date:='';
   //if formtarif.ZQuery1.RecordCount>0 then max_date:=formtarif.ZQuery1.FieldByName('maxtarif').asString;
   //formtarif.ZQuery1.Close;
   //formtarif.Zconnection1.disconnect;
   ////formtarif.selected_row();
   //
   //// Обновляем СЕТКИ
   //formtarif.StringGrid1.Refresh;
   //formtarif.StringGrid1.SetFocus;
   //formtarif.StringGrid1.Row:=formtarif.StringGrid1.RowCount-1;
   //formtarif.UpdateGridOther();

  // Подключаемся к серверу
  StringGrid1.RowCount:=1;
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   // Определяем пользователя
   formtarif.ZQuery1.SQL.clear;
   formtarif.ZQuery1.SQL.add('select * from av_tarif where del=0 ');

   //if (stroka<>'') and (filter_type=2) then ZQuery1.SQL.add('and b.name ilike '+quotedstr(stroka+'%'));
   if (stroka<>'') and (filter_type=1) then ZQuery1.SQL.add('and cast(id as text) like '+quotedstr(stroka+'%'));

   formtarif.ZQuery1.SQL.add('ORDER BY datetarif;');

   //showmessage(ZQuery1.SQL.text);//$
   try
      formtarif.ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
     end;

   if formtarif.ZQuery1.RecordCount=0 then
      begin
        formtarif.ZQuery1.close;
        formtarif.ZConnection1.Disconnect;
        exit;
      end;
   editstamp:=strtodatetime('02-04-1985 06:30:00',mysett);
   // Заполняем stringgrid
   formtarif.StringGrid1.RowCount:=formtarif.ZQuery1.RecordCount+1;
   for n:=1 to formtarif.ZQuery1.RecordCount do
    begin
      If editstamp<formtarif.ZQuery1.FieldByName('createdate').AsDateTime then
        editstamp:=formtarif.ZQuery1.FieldByName('createdate').AsDateTime;
      formtarif.StringGrid1.Cells[0,n]:=formtarif.ZQuery1.FieldByName('id').asString;
      formtarif.StringGrid1.Cells[1,n]:=formtarif.ZQuery1.FieldByName('datetarif').asString;
      formtarif.StringGrid1.Cells[2,n]:=formtarif.ZQuery1.FieldByName('dateraschet').asString;
      formtarif.ZQuery1.Next;
   end;

   label6.Caption:=label6.Caption+#32+formatdatetime('dd-mm-yyyy hh:nn',editstamp);
   //formtarif.memo1.Text:=trim(formtarif.ZQuery1.FieldByName('swed').asString);
   // Определяем текущий тариф
   formtarif.ZQuery1.SQL.clear;
   formtarif.ZQuery1.SQL.add('select max(datetarif) as maxtarif from av_tarif where del=0;');

   //showmessage(ZQuery1.SQL.text);//$
   try
      formtarif.ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
     end;
   max_date:='';
   if formtarif.ZQuery1.RecordCount>0 then max_date:=formtarif.ZQuery1.FieldByName('maxtarif').asString;
   formtarif.ZQuery1.Close;
   formtarif.Zconnection1.disconnect;
   //formtarif.selected_row();

   // Обновляем СЕТКИ
   formtarif.StringGrid1.Refresh;
   //formtarif.StringGrid1.SetFocus;
   formtarif.StringGrid1.Row:=formtarif.StringGrid1.RowCount-1;
   formtarif.UpdateGridOther();

 end;

 procedure TFormtarif.ToolButton8Click(Sender: TObject);
 begin
   GridPoisk(formtarif.StringGrid1,formtarif.Edit1);
 end;

 procedure TFormtarif.ToolButton1Click(Sender: TObject);
 begin
   SortGrid(formtarif.StringGrid1,formtarif.StringGrid1.col,formtarif.ProgressBar1,0,1);
 end;

 procedure TFormtarif.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;   aRect: TRect; aState: TGridDrawState);
 begin
    with Sender as TStringGrid, Canvas do
    begin
   if Arow=0 then Formtarif.StringGrid1.Canvas.Font.Size:=8;
   if Arow>0 then Formtarif.StringGrid1.Canvas.Font.Size:=12;
   //if ARow=0 then Formtarif.StringGrid1.Canvas.Brush.Color:=clCream;
   if ARow>0 then Formtarif.StringGrid1.Canvas.Brush.Color:=clWhite;
   Formtarif.StringGrid1.Canvas.FillRect(aRect);
   if (trim(Formtarif.StringGrid1.Cells[1,ARow])=trim(max_date)) then
      begin
       //showmessagealt(trim(Formtarif.StringGrid1.Cells[ACol,ARow])+'='+trim(max_date));
       Formtarif.StringGrid1.Canvas.Brush.Color:=clMoneyGreen;
       Formtarif.StringGrid1.Canvas.FillRect(aRect);
       Formtarif.StringGrid1.Canvas.Font.Style:=[fsBold];
      end
   else
      begin
       Formtarif.StringGrid1.Canvas.Font.Style:=[];
      end;
   if (gdSelected in aState) then
          begin
            Formtarif.StringGrid1.Canvas.Brush.Color:=clBlue;
            Formtarif.StringGrid1.Canvas.Font.Color := clWhite;
            Formtarif.StringGrid1.Canvas.FillRect(aRect);
          end;
    if (aRow>0) and (aCol=2) then
         begin
          Font.Size:=9;
     //     Font.Color := clBlack;
     //     TextOut(aRect.Left + 10, aRect.Top+8, Cells[aCol, aRow]);
         end;

   Formtarif.StringGrid1.Canvas.TextOut(aRect.Left + 5, aRect.Top+5, Formtarif.StringGrid1.Cells[aCol, aRow]);

    end;
 end;

procedure TFormtarif.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

 procedure TFormtarif.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
 begin
  formtarif.UpdateGridOther();
 end;

 procedure TFormtarif.FormCreate(Sender: TObject);
 begin
 end;

 procedure TFormtarif.BitBtn12Click(Sender: TObject);
 begin
  if StringGrid1.Row=0 then
  begin
       showmessage('Нечего редактировать');
       exit;
  end;
   //showmessage(inttostr(formtarif.StringGrid1.row));
  //Изменить текущую запись
  flag_edit_tarif:=2;
  formtarif_edit:=Tformtarif_edit.create(self);
  formtarif_edit.ShowModal;
  FreeAndNil(formtarif_edit);
  formtarif.UpdateGrid(datatyp,'');
 end;





 procedure TFormtarif.BitBtn2Click(Sender: TObject);
  var
   res_flag:integer;
begin
 With FormTarif do
 begin
  //Удаляем запись
   if (trim(formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.row])='') or (formtarif.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;
 res_flag := dialogs.MessageDlg('Удалить запись выбранного ОСНОВНОГО ТАРИФА ?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag=6 then
   begin
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
     // av_tarif
     formtarif.ZQuery1.SQL.Clear;
     formtarif.ZQuery1.SQL.add('UPDATE av_tarif SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.row])+' and del=0;');
     formtarif.ZQuery1.ExecSQL;

     // av_tarif_local
     formtarif.ZQuery1.SQL.Clear;
     formtarif.ZQuery1.SQL.add('UPDATE av_tarif_local SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_tarif='+trim(formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.row])+' and del=0;');
     formtarif.ZQuery1.ExecSQL;

     // av_tarif_bagag
     formtarif.ZQuery1.SQL.Clear;
     formtarif.ZQuery1.SQL.add('UPDATE av_tarif_bagag SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_tarif='+trim(formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.row])+' and del=0;');
     formtarif.ZQuery1.ExecSQL;

     // av_tarif_predv
     formtarif.ZQuery1.SQL.Clear;
     formtarif.ZQuery1.SQL.add('UPDATE av_tarif_predv SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_tarif='+trim(formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.row])+' and del=0;');
     formtarif.ZQuery1.ExecSQL;

     // av_tarif_uslugi
     formtarif.ZQuery1.SQL.Clear;
     formtarif.ZQuery1.SQL.add('UPDATE av_tarif_uslugi SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_tarif='+trim(formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.row])+' and del=0;');
     formtarif.ZQuery1.ExecSQL;

   //завершение транзакции
   Zconnection1.Commit;
   except
     If ZConnection1.InTransaction then Zconnection1.Rollback;
     ZConnection1.disconnect;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     exit;
   end;
   Zconnection1.disconnect;
   formtarif.UpdateGrid(datatyp,'');
   end;
 end;
 end;

 //*************************************************  ПЕРЕСЧИТАТЬ **************************************
 procedure TFormtarif.BitBtn3Click(Sender: TObject);
 var
   tempTable : string;
 begin
  with formtarif do
  begin
   //Проверка данных
   If formtarif.StringGrid1.rowcount < 2 then exit;
   If formtarif.StringGrid1.Cells[0,formtarif.StringGrid1.Row] =''  then exit;
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

  tempTable := 'tempT'+FormatDateTime('hhnnsszzz', time());
  //создаем временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('CREATE LOCAL TEMPORARY TABLE '+tempTable);
  ZQuery1.SQL.add(' (id integer NOT NULL DEFAULT 0,createdate timestamp without time zone NOT NULL DEFAULT now(),id_user integer NOT NULL DEFAULT 0,del integer NOT NULL DEFAULT 0,createdate_first timestamp without time zone,');
  ZQuery1.SQL.add('id_user_first integer,datetarif date NOT NULL DEFAULT now(),wozbild integer NOT NULL,wozbildproc integer NOT NULL,wozbilw integer NOT NULL,wozbilwproc integer NOT NULL,wozbilp integer NOT NULL,');
  ZQuery1.SQL.add('wozbilpproc integer NOT NULL,wozbagd integer NOT NULL,wozbagdproc integer NOT NULL,wozbagw integer NOT NULL,wozbagwproc integer NOT NULL,wozbagp integer NOT NULL,wozbagpproc integer NOT NULL,');
  ZQuery1.SQL.add('kmh integer NOT NULL,deti integer NOT NULL DEFAULT 0,dateraschet timestamp without time zone) WITH (OIDS=FALSE);');
 // showmessage(ZQuery1.SQL.text);
  try
    ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
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
  //копируем текущую запись тарифа в таблице во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO '+tempTable+' SELECT * FROM av_tarif WHERE del=0 AND id='+trim(Stringgrid1.Cells[0,Stringgrid1.Row])+';');
  ZQuery1.ExecSQL;
  //помечаем текущую запись тарифа на удаление
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('UPDATE av_tarif SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+trim(Stringgrid1.Cells[0,Stringgrid1.Row])+' and del=0;');
  ZQuery1.ExecSQL;
  //обновляем запись тарифа во временной таблице
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('UPDATE '+tempTable+' SET dateraschet=now(),createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+trim(Stringgrid1.Cells[0,Stringgrid1.Row])+';');
  ZQuery1.ExecSQL;

  //копируем запись из временной таблицы в реальную
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_tarif SELECT * FROM '+tempTable+' WHERE id='+trim(Stringgrid1.Cells[0,Stringgrid1.Row])+';');
  ZQuery1.ExecSQL;

  //удаляем запись во временной таблице
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('DELETE FROM '+tempTable+' WHERE id='+trim(Stringgrid1.Cells[0,Stringgrid1.Row])+';');
  ZQuery1.ExecSQL;

  //================= Завершение транзакции==============================
  formtarif.Zconnection1.Commit;
 //showmessagealt('Данные сохранены !');
 except
   If ZConnection1.InTransaction then Zconnection1.Rollback;
     formtarif.ZQuery1.Close;
     formtarif.Zconnection1.disconnect;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
 end;
 formtarif.ZQuery1.Close;
 formtarif.Zconnection1.disconnect;

 UpdateGrid(datatyp,'');
 end;
 end;

 procedure TFormtarif.Button1Click(Sender: TObject);
 begin
  showmessagealt('ПРИВЕТ !!!!'+#13+'Пока :)');
 end;

procedure TFormtarif.Edit1Change(Sender: TObject);
  var
    n:integer=0;
  begin
    with FOrmtarif do
  begin
    ss:=trimleft(Edit1.Text);
    if UTF8Length(ss)>0 then
         begin
          for n:=1 to UTF8Length(ss) do
        begin
       //определяем тип данных для поиска
     if not (ss[n] in ['0'..'9']) then
       begin
         datatyp:=2;
         break;
       end;
      datatyp:=1;
        end;

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



procedure TFormtarif.BitBtn1Click(Sender: TObject);
begin
   //Создаем новую запись
  flag_edit_tarif:=1;
  formtarif_edit:=Tformtarif_edit.create(self);
  formtarif_edit.ShowModal;
  FreeAndNil(formtarif_edit);
  formtarif.UpdateGrid(datatyp,'');
end;

procedure TFormtarif.BitBtn4Click(Sender: TObject);
begin
  formtarif.close;
end;

procedure TFormtarif.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //// Автоматический контекстный поиск
    //if (GetSymKey(char(Key))=true) then
    //   begin
    //    formtarif.Edit1.SetFocus;
    //   end;
    //if (Key=13) and (formtarif.Edit1.Focused) then Formtarif.ToolButton8.Click;

 With formtarif do
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
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ESC] - Отмена\Выход');

    //F4 - Изменить
    if (Key=115) and (formtarif.bitbtn12.enabled=true) then formtarif.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (formtarif.bitbtn1.enabled=true) then formtarif.BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then FormTarif.ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (formtarif.bitbtn2.enabled=true) then formtarif.BitBtn2.Click;
    // ESC
    if Key=27 then formtarif.Close;
    // ENTER
    {if (Key=13)  and  (formtarif.StringGrid1.Focused) then
      begin
        result_name_lgot:=formtarif.StringGrid1.Cells[1,formtarif.StringGrid1.row];
        formtarif.close;
      end;}

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

    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) then Key:=0;


   end;
end;

procedure TFormtarif.FormShow(Sender: TObject);
begin
  MySett.DateSeparator := '-';
  MySett.TimeSeparator := ':';
  MySett.ShortDateFormat := 'dd-mm-yyyy';
  MySett.ShortTimeFormat := 'hh:nn:ss';
   formtarif.UpdateGrid(datatyp,'');
   if flag_access=1 then
     begin
      with formtarif do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
     end;
end;

end.

