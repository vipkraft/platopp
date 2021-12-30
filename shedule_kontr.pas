unit shedule_kontr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Grids, Buttons;

type

  { TFormsk }

  TFormsk = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image3: TImage;
    ImageList1: TImageList;
    Label2: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid();
    procedure UpdateGridATS();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formsk: TFormsk;

implementation
uses
  mainopp,platproc,shedule_edit,ats_main,dogovor;
var
  per:integer;
{$R *.lfm}


procedure TFormsk.UpdateGridATS();
var
  n,m:integer;
begin
  // Подключаемся к серверу
  if flagprofile=1 then MConnect(Formsk.Zconnection1,ConnectINI[3],ConnectINI[1]);
  if flagprofile=2 then MConnect(Formsk.Zconnection1,ConnectINI[6],ConnectINI[4]);
  try
    Formsk.Zconnection1.connect;
  except
    showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
    Formsk.Close;
    exit;
  end;

  // Запрос АТС
  Formsk.ZQuery1.SQL.clear;
  Formsk.ZQuery1.SQL.add('SELECT av_spr_kontr_ats.id_kontr,av_spr_kontr_ats.id_ats,av_spr_ats."name",av_spr_ats.gos,av_spr_ats.m_down,av_spr_ats.m_up,av_spr_ats.m_lay,');
  Formsk.ZQuery1.SQL.add('av_spr_ats.m_down_two,av_spr_ats.m_up_two,av_spr_ats.m_lay_two,av_spr_ats."level",av_spr_ats.type_ats,av_spr_ats.comfort,av_spr_ats.god');
  Formsk.ZQuery1.SQL.add('FROM public.av_spr_ats,public.av_spr_kontr_ats ');
  Formsk.ZQuery1.SQL.add('WHERE av_spr_kontr_ats.id_ats = av_spr_ats.id and av_spr_ats.del=0 and av_spr_kontr_ats.del=0 and av_spr_kontr_ats.id_kontr='+trim(formsk.StringGrid1.Cells[1,formsk.StringGrid1.row]));
  Formsk.ZQuery1.open;
  if Formsk.ZQuery1.RecordCount=0 then
     begin
       formsk.StringGrid2.RowCount:=1;
       Formsk.ZQuery1.close;
       Formsk.ZConnection1.Disconnect;
       exit;
     end;
  // Заполняем АТС контрагентов
  formsk.StringGrid2.RowCount:=Formsk.ZQuery1.RecordCount+1;
  for n:=1 to  Formsk.ZQuery1.RecordCount do
   begin
    // Заполняем stringgrid
       Formsk.StringGrid2.Cells[0,n]:=formsk.ZQuery1.FieldByName('id_ats').asString;
       Formsk.StringGrid2.Cells[1,n]:=formsk.ZQuery1.FieldByName('name').asString;
       Formsk.StringGrid2.Cells[2,n]:=formsk.ZQuery1.FieldByName('gos').asString;;
       if  formsk.ZQuery1.FieldByName('type_ats').asInteger=1 then Formsk.StringGrid2.Cells[3,n]:='М2';
       if  formsk.ZQuery1.FieldByName('type_ats').asInteger=2 then Formsk.StringGrid2.Cells[3,n]:='М3';
       Formsk.StringGrid2.Cells[4,n]:=formsk.ZQuery1.FieldByName('level').asString;
       Formsk.StringGrid2.Cells[5,n]:=inttostr(formsk.ZQuery1.FieldByName('m_up').asinteger+formsk.ZQuery1.FieldByName('m_down').asinteger+formsk.ZQuery1.FieldByName('m_lay').asinteger+formsk.ZQuery1.FieldByName('m_up_two').asinteger+formsk.ZQuery1.FieldByName('m_down_two').asinteger+formsk.ZQuery1.FieldByName('m_lay_two').asinteger);
       Formsk.ZQuery1.Next;
   end;
   Formsk.ZQuery1.Close;
   Formsk.Zconnection1.disconnect;
   Formsk.StringGrid2.Refresh;
   formsk.StringGrid1.SetFocus;
end;



procedure TFormsk.UpdateGrid();
var
  n,m:integer;
begin
  // Подключаемся к серверу
  if flagprofile=1 then MConnect(Formsk.Zconnection1,ConnectINI[3],ConnectINI[1]);
  if flagprofile=2 then MConnect(Formsk.Zconnection1,ConnectINI[6],ConnectINI[4]);
  try
    Formsk.Zconnection1.connect;
  except
    showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
    Formsk.Close;
    exit;
  end;

  // Запрос маршрутов и расписаний
  Formsk.ZQuery1.SQL.clear;
  if per=2 then
     begin
       Formsk.ZQuery1.SQL.add('SELECT a.id,a.name,a.vidkontr,a.kod1c,a.inn,a.tel,a.adrur,');
       Formsk.ZQuery1.SQL.add('(select distinct(b.viddog) from av_spr_kontr_dog as b where b.viddog='+quotedstr('00002')+' and a.id=b.id_kontr) as ndog ');
       Formsk.ZQuery1.SQL.add('FROM public.av_spr_kontragent AS a WHERE a.del = 0;');
     end
  else
      begin
      Formsk.ZQuery1.SQL.add('SELECT a.id,a.name,a.vidkontr,a.kod1c,a.inn,a.tel,a.adrur,');
      Formsk.ZQuery1.SQL.add(quotedstr('00002')+' as ndog ');
      Formsk.ZQuery1.SQL.add('FROM public.av_spr_kontragent AS a WHERE a.del = 0 and ');
      Formsk.ZQuery1.SQL.add('a.id in (select c.id_kontr from av_spr_kontr_dog as c where trim(c.viddog)='+quotedstr('00002')+' and c.id_kontr=a.id AND c.del = 0 ORDER BY id);');
      end;
  Formsk.ZQuery1.open;
  if Formsk.ZQuery1.RecordCount=0 then
     begin
       Formsk.ZQuery1.close;
       Formsk.ZConnection1.Disconnect;
       exit;
     end;

  // Заполняем контрагенты
  formsk.StringGrid1.RowCount:=Formsk.ZQuery1.RecordCount+1;
  for n:=1 to  Formsk.ZQuery1.RecordCount do
   begin
    // Заполняем stringgrid
       Formsk.StringGrid1.Cells[0,n]:='';
       Formsk.StringGrid1.Cells[1,n]:=formsk.ZQuery1.FieldByName('id').asString;
       Formsk.StringGrid1.Cells[2,n]:=formsk.ZQuery1.FieldByName('name').asString;;
       Formsk.StringGrid1.Cells[3,n]:=formsk.ZQuery1.FieldByName('vidkontr').asString;
       Formsk.StringGrid1.Cells[4,n]:=formsk.ZQuery1.FieldByName('kod1c').asString;
       Formsk.StringGrid1.Cells[5,n]:=formsk.ZQuery1.FieldByName('ndog').asString;
       Formsk.StringGrid1.Cells[6,n]:=formsk.ZQuery1.FieldByName('tel').asString;
       Formsk.StringGrid1.Cells[7,n]:=formsk.ZQuery1.FieldByName('inn').asString;
       Formsk.StringGrid1.Cells[8,n]:=formsk.ZQuery1.FieldByName('adrur').asString;
       Formsk.ZQuery1.Next;
   end;
   Formsk.ZQuery1.Close;
   Formsk.Zconnection1.disconnect;
   Formsk.StringGrid1.Refresh;
   formsk.StringGrid1.ColWidths[0]:=-1;
   formsk.StringGrid1.ColWidths[4]:=-1;
   formsk.StringGrid1.ColWidths[5]:=-1;
   formsk.StringGrid1.ColWidths[6]:=-1;
   formsk.StringGrid1.ColWidths[7]:=-1;
   formsk.StringGrid1.ColWidths[8]:=-1;
   formsk.StringGrid1.SetFocus;
end;

procedure TFormsk.FormShow(Sender: TObject);
begin
   Centrform(Formsk);
  formsk.Updategrid();
  formsk.Updategridats();
  formsk.StringGrid1.ColWidths[0]:=-1;
  formsk.StringGrid1.ColWidths[4]:=-1;
  formsk.StringGrid1.ColWidths[5]:=-1;
  formsk.StringGrid1.ColWidths[6]:=-1;
  formsk.StringGrid1.ColWidths[7]:=-1;
  formsk.StringGrid1.ColWidths[8]:=-1;
end;

procedure TFormsk.RadioButton1Change(Sender: TObject);
begin
      if formsk.RadioButton2.Checked then
       begin
         per:=1;
         formsk.UpdateGrid();
         formsk.UpdateGridAts();
       end;
end;

procedure TFormsk.RadioButton2Change(Sender: TObject);
begin
    if formsk.RadioButton1.Checked then
       begin
         per:=2;
         formsk.UpdateGrid();
         formsk.UpdateGridAts();
       end;
end;

procedure TFormsk.RadioButton2Click(Sender: TObject);
begin
end;

procedure TFormsk.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  // Рисуем GRID
  with Sender as TStringGrid, Canvas do
 begin
      Brush.Color:=clWhite;
      FillRect(aRect);
      {font.Name:='default';
      font.Pitch:=fpDefault;
      font.Quality:=fqDefault;}

    if (gdSelected in aState) then
          begin
           pen.Width:=4;
           pen.Color:=clBlue;
           MoveTo(aRect.left,aRect.bottom-1);
           LineTo(aRect.right,aRect.Bottom-1);
           MoveTo(aRect.left,aRect.top-1);
           LineTo(aRect.right,aRect.Top);
           Font.Color := clGreen;
           font.Size:=10;
           font.Style:= [];
          end
        else
         begin
           font.Style:= [];
           Font.Color := clBlack;
           font.Size:=10;
         end;

     //Перевозчики
     if (aRow>0) and (aCol=3) and not(trim(cells[5,aRow]) = '') then
      begin
        Font.Size:=10;
        Font.Color := clGreen;
        TextOut(aRect.Left + 5, aRect.Top+18, 'Имеет договор перевозки');
      end;

     // Остальные поля
     if (aRow>0) and not(aCol=0) then
        begin
         Font.Size:=11;
         Font.Color := clBlack;
         TextOut(aRect.Left + 2, aRect.Top+2, Cells[aCol, aRow]);
       end;

     // Реквизиты
     if (aRow>0) and (aCol=2) then
        begin
         //tel+inn+adrur
         Font.Size:=10;
         Font.Color := clBlue;
         TextOut(aRect.Left + 2, aRect.Top+18,'Тел: '+trim(Formsk.StringGrid1.Cells[6,aRow])+' ИНН: '+trim(Formsk.StringGrid1.Cells[7,aRow]));
         TextOut(aRect.Left + 2, aRect.Top+30,'Адр.Юр.: '+trim(Formsk.StringGrid1.Cells[8,aRow]));
        end;

     // Заголовок
      if aRow=0 then
        begin
          Brush.Color:=clDefault;
          FillRect(aRect);
          Font.Color := clBlack;
          font.Size:=10;
          TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
         end;
  end;
end;

procedure TFormsk.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
  formsk.UpdateGridATS();
end;

procedure TFormsk.ToolButton1Click(Sender: TObject);
begin
  SortGrid(formsk.StringGrid1,formsk.StringGrid1.col,formsk.ProgressBar1);
end;

procedure TFormsk.ToolButton8Click(Sender: TObject);
begin
   GridPoisk(formsk.StringGrid1,formsk.Edit1);
end;

procedure TFormsk.BitBtn4Click(Sender: TObject);
begin
  formsk.Close;
end;

procedure TFormsk.BitBtn19Click(Sender: TObject);
begin
    if (trim(formsk.StringGrid2.Cells[0,formsk.StringGrid1.row])='') or (formsk.StringGrid1.RowCount=1) then
     begin
       showmessage('Не выбрана запись для удаления !');
       exit;
     end;
   if not(dialogs.MessageDlg('Удалить АТС из списка ?',mtConfirmation,[mbYes,mbNO,mbCancel], 0)=6) then
     begin
       exit;
     end;
   // Удаляем АТС из списка контрагента
   if flagprofile=1 then MConnect(formsk.Zconnection1,ConnectINI[3],ConnectINI[1]);
   if flagprofile=2 then MConnect(formsk.Zconnection1,ConnectINI[6],ConnectINI[4]);
     try
         formsk.Zconnection1.connect;
     except
         showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
         //formsk.Close;
         exit;
     end;
     //проставляем запись на удаление
     formsk.Zconnection1.AutoCommit:=false;
     formsk.ZQuery1.SQL.Clear;
     formsk.ZQuery1.SQL.add('UPDATE av_spr_kontr_ats SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_ats='+trim(formsk.StringGrid2.Cells[0,formsk.StringGrid2.row])+' and id_kontr='+ trim(formsk.StringGrid1.Cells[1,formsk.StringGrid1.row])+' and del=0;');
     formsk.ZQuery1.open;
         // Завершение транзакции
     formsk.Zconnection1.Commit;
     formsk.Zconnection1.AutoCommit:=true;
     if formsk.ZConnection1.InTransaction then
        begin
          showmessage('Данные не удалены !'+#13+'Не удается завершить транзакцию !!!');
          formsk.ZConnection1.Rollback;
        end;

     formsk.ZQuery1.close;
     formsk.Zconnection1.disconnect;
     formsk.UpdateGridATS();
end;

procedure TFormsk.BitBtn1Click(Sender: TObject);
begin

end;

procedure TFormsk.BitBtn12Click(Sender: TObject);
begin

end;

procedure TFormsk.BitBtn3Click(Sender: TObject);
var
 szap,comma,stim,ttabl1,ttabl2: string;
 bCH,bDog: byte;
 chislo,kolvo, n: integer;
begin
   bCH:=0;
   bDog:=0;
   szap:='';
   comma:=',';
  if flagprofile=1 then MConnect(Formsk.Zconnection1,ConnectINI[3],ConnectINI[1]);
  if flagprofile=2 then MConnect(Formsk.Zconnection1,ConnectINI[6],ConnectINI[4]);
  with Formsk do
   begin
   try
       Zconnection1.connect;
   except
       showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
   end;

//****************************************************************  обновление контрагентов **************
 //ищем удаленных из 1С   ****************************************
   szap:='Select id FROM av_spr_kontragent as a WHERE a.del=0 AND NOT EXISTS (SELECT kod1c FROM av_1c_kontr AS b WHERE b.kod1c=a.kod1c)';
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add(szap+';');
   try
      ZQuery1.Open;
   except
       showmessage('Выполнение команды SQL SELECT - ОШИБКА !');
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
   end;

  if ZQuery1.RecordCount>0 then
  begin
   //Открываем транзакцию
   Zconnection1.AutoCommit:=false;
   kolvo:=ZQuery1.RecordCount;
   //помечаем на удаление
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add('UPDATE av_spr_kontragent SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id IN ('+szap+');');
   szap:='';
   ZQuery1.ExecSQL;

  // Завершение транзакции
  Zconnection1.Commit;
  Zconnection1.AutoCommit:=true;
  if ZConnection1.InTransaction then
     begin
       showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
       ZConnection1.Rollback;
     end
  else
     begin
       showmessage('КОНТРАГЕНТЫ. Транзакция завершена УСПЕШНО !'+#13+'УДАЛЕНО  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       bCH:=1;
     end;
  end;

  //ищем новые из 1С  ************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT kod1c FROM av_1c_kontr AS a WHERE NOT EXISTS (SELECT kod1c FROM av_spr_kontragent AS b WHERE a.kod1c=b.kod1c AND b.del=0);');
   try
    ZQuery1.Open;
   except
    showmessage('Выполнение команды SQL SELECT - ОШИБКА !');
    Zconnection1.disconnect;
    exit;
   end;
   if ZQuery1.RecordCount>0 then
   begin
   //Открываем транзакцию
   Zconnection1.AutoCommit:=false;
   kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'ddhhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   chislo:=ABS(chislo*StrToInt(stim));
   ttabl1:='tmpK'+IntToStr(chislo);

  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl1+' (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL,polname character(200) NOT NULL,vidkontr character(50) NOT NULL,inn character(20) NOT NULL,okpo character(15) NOT NULL,adrur character(200) NOT NULL,');
  ZQuery1.SQL.Add('adrpos character(200) NOT NULL,adrelect character(200) NOT NULL,tel character(50) NOT NULL,docsr character(30) NOT NULL,docnom character(30) NOT NULL,docorgv character(50) NOT NULL,');
  ZQuery1.SQL.Add('docdatv date,grprosv smallint NOT NULL DEFAULT 0,gorod character(60) NOT NULL,podr character(60) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;
  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl1+' SELECT row_number() over (order by a.kod1c)+(select max(id) from av_spr_kontragent) as id,* FROM av_1c_kontr AS a WHERE NOT EXISTS (SELECT kod1c FROM av_spr_kontragent AS b WHERE a.kod1c=b.kod1c AND b.del=0);');
  ZQuery1.ExecSQL;
  //добавляем новые записи в таблицу контрагентов
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO av_spr_kontragent(id,createdate,del,id_user,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,createdate_first,id_user_first) ');
  ZQuery1.SQL.Add('SELECT id,now(),0,'+intTostr(id_user)+',name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,docsr || '+QuotedStr(comma)+' || docnom || '+QuotedStr(comma)+' || docorgv || ');
  ZQuery1.SQL.Add(QuotedStr(comma)+' || coalesce('''' || docdatv || '''','''') AS document,now(),'+intTostr(id_user)+' FROM '+ttabl1+';');
  ZQuery1.Open;

  //удалить временную
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('DROP TABLE '+ttabl1+';');
  ZQuery1.ExecSQL;
  // Завершение транзакции
  Zconnection1.Commit;
  Zconnection1.AutoCommit:=true;
  if ZConnection1.InTransaction then
     begin
       showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
       ZConnection1.Rollback;
     end
  else
     begin
       showmessage('КОНТРАГЕНТЫ. Транзакция завершена УСПЕШНО !'+#13+'Добавлено  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       bCH:=1;
     end;
  end;

   //ищем отредактированные в 1с   ********************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT a.kod1c FROM av_1c_kontr AS a,av_spr_kontragent AS b ');
   ZQuery1.SQL.add('WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos ');
   ZQuery1.SQL.add('AND a.tel=b.tel AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || '+QuotedStr(comma)+' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''',''''))=b.document);');
  try
    ZQuery1.Open;
   except
    showmessage('Выполнение команды SQL SELECT - ОШИБКА !');
    Zconnection1.disconnect;
    exit;
   end;
   if ZQuery1.RecordCount>0 then
   begin
   //Открываем транзакцию
   Zconnection1.AutoCommit:=false;
  kolvo:=ZQuery1.RecordCount;
  DateTimeToString(stim,'ddhhmmzzz',now);
  Randomize;
  chislo:=Random(200)+1;
  chislo:=ABS(chislo*StrToInt(stim));
  ttabl2:='tmpK'+IntToStr(chislo);
  ZQuery1.SQL.Clear;
  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl2+' (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL,polname character(200) NOT NULL,');
  ZQuery1.SQL.Add('vidkontr character(50) NOT NULL,inn character(20) NOT NULL,okpo character(15) NOT NULL,adrur character(200) NOT NULL,');
  ZQuery1.SQL.Add('adrpos character(200) NOT NULL,tel character(50) NOT NULL,document character(200) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;

  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl2+' SELECT b.id,a.kod1c,a.name,a.polname,a.vidkontr,a.inn,a.okpo,a.adrur,a.adrpos,a.tel,a.docsr || '+QuotedStr(comma));
  ZQuery1.SQL.Add(' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''','''') AS document FROM av_1c_kontr AS a ');
  ZQuery1.SQL.Add('LEFT JOIN av_spr_kontragent AS b USING (kod1c) ');
  ZQuery1.SQL.Add('WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname ');
  ZQuery1.SQL.Add('AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel ');
  ZQuery1.SQL.Add('AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || '+QuotedStr(comma)+' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''',''''))=b.document);');
  ZQuery1.ExecSQL;

  //помечаем на удаление прежние записи
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('UPDATE av_spr_kontragent SET del=1,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id IN (SELECT id FROM '+ttabl2+');');
  ZQuery1.ExecSQL;
 //
  //добавляем новые записи в таблицу контрагентов
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO av_spr_kontragent(id,createdate,del,id_user,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,createdate_first,id_user_first) ');
  ZQuery1.SQL.Add('SELECT id,now(),0,'+intTostr(id_user)+',name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,now(),'+intTostr(id_user)+' FROM '+ttabl2+';');
  //INSERT INTO av_spr_kontragent(id,createdate,del,id_user,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,createdate_first,id_user_first)
  //SELECT id,now(),0,1,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,now(),1 FROM ttabl2;
  ZQuery1.ExecSQL;

  //удаляем временную
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('DROP TABLE '+ttabl2+';');
  ZQuery1.ExecSQL;
  // Завершение транзакции
  Zconnection1.Commit;
  Zconnection1.AutoCommit:=true;
  if ZConnection1.InTransaction then
     begin
       showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
       ZConnection1.Rollback;
     end
  else
     begin
       showmessage('КОНТРАГЕНТЫ. Транзакция завершена УСПЕШНО !'+#13+'Отредактировано  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       bCH:=1;
     end;
  end;
// *************************************************************


// ************************************************  обновление договоров ***************************
//ищем удаленных из 1С   ****************************************
   szap:='Select id FROM av_spr_kontr_dog as a WHERE a.del=0 AND NOT EXISTS (SELECT kod1c FROM av_1c_kontr_dog AS b WHERE b.kod1c=a.kod1c AND b.kodkont=a.kodkont )';
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add(szap+';');
   try
      ZQuery1.Open;
   except
       showmessage('Выполнение команды SQL SELECT - ОШИБКА !');
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
   end;

  if ZQuery1.RecordCount>0 then
  begin
   //Открываем транзакцию
   Zconnection1.AutoCommit:=false;
   kolvo:=ZQuery1.RecordCount;
   //помечаем на удаление
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add('UPDATE av_spr_kontragent SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id IN ('+szap+');');
   szap:='';
   ZQuery1.ExecSQL;

  // Завершение транзакции
  Zconnection1.Commit;
  Zconnection1.AutoCommit:=true;
  if ZConnection1.InTransaction then
     begin
       showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
       ZConnection1.Rollback;
     end
  else
     begin
       showmessage('ДОГОВОРА. Транзакция завершена УСПЕШНО !'+#13+'УДАЛЕНО  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       bDog:=1;
     end;
  end;

  //ищем новые из 1С  ************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT kodkont,kod1c FROM av_1c_kontr_dog AS a WHERE NOT EXISTS (SELECT kodkont,kod1c FROM av_spr_kontr_dog AS b WHERE b.kodkont=a.kodkont AND b.kod1c=a.kod1c AND b.del=0);');
   try
    ZQuery1.Open;
   except
    showmessage('Выполнение команды SQL SELECT - ОШИБКА !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;
   if ZQuery1.RecordCount>0 then
   begin
   //Открываем транзакцию
   Zconnection1.AutoCommit:=false;
   //kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'ddhhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   chislo:=ABS(chislo*StrToInt(stim));
   ttabl1:='tmpDog'+IntToStr(chislo);

  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ ttabl1 +' (id integer NOT NULL DEFAULT 0,id_kontr integer NOT NULL DEFAULT 0,kodkont integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(200) NOT NULL,datazak date,datavoz date,datapog date,');
  ZQuery1.SQL.Add('val character(20) NOT NULL,datanacsh date,dataprsh date,stav numeric(5,2) NOT NULL DEFAULT 0,viddog character(20) NOT NULL,podr character(50) NOT NULL,otcblm numeric(5,2) NOT NULL DEFAULT 0,otcbagm numeric(5,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('otcblp numeric(5,2) NOT NULL DEFAULT 0,otcbagp numeric(5,2) NOT NULL DEFAULT 0,komotd numeric(10,2) NOT NULL DEFAULT 0,med numeric(10,2) NOT NULL DEFAULT 0,ubor numeric(10,2) NOT NULL DEFAULT 0,stop numeric(10,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('disp numeric(10,2) NOT NULL DEFAULT 0,voin numeric(5,2) NOT NULL DEFAULT 0,lgot numeric(5,2) NOT NULL DEFAULT 0,dopus numeric(5,2) NOT NULL DEFAULT 0,vidar character(200) NOT NULL,sumar numeric(20,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('shtr1 numeric(10,2) NOT NULL DEFAULT 0,shtr11 numeric(10,2) NOT NULL DEFAULT 0,shtr2 numeric(10,2) NOT NULL DEFAULT 0,shtr3 numeric(10,2) NOT NULL DEFAULT 0,shtr4 numeric(10,2) NOT NULL DEFAULT 0,shtr41 numeric(10,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('shtr5 numeric(10,2) NOT NULL DEFAULT 0,shtr6 numeric(10,2) NOT NULL DEFAULT 0,shtr7 numeric(10,2) NOT NULL DEFAULT 0,edizm1 character(20) NOT NULL,edizm11 character(20) NOT NULL,edizm2 character(20) NOT NULL,edizm3 character(20) NOT NULL,');
  ZQuery1.SQL.Add('edizm4 character(20) NOT NULL,edizm41 character(20) NOT NULL,edizm5 character(20) NOT NULL,edizm6 character(20) NOT NULL,edizm7 character(20) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;

  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('insert into '+ ttabl1+' SELECT row_number() over (order by a.kodkont)+coalesce((select max(id) from av_spr_kontr_dog),0) as id,0,kodkont,kod1c,name,datazak,datavoz,datapog,val,datanacsh,dataprsh,stav,viddog,podr,');
  ZQuery1.SQL.Add('otcblm,otcbagm,otcblp,otcbagp,komotd,med,ubor,stop,disp,voin,lgot,dopus,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,shtr6,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm6,edizm7 FROM av_1c_kontr_dog AS a');
  ZQuery1.SQL.Add('WHERE NOT EXISTS (SELECT kodkont,kod1c FROM av_spr_kontr_dog AS b WHERE b.kodkont=a.kodkont AND b.kod1c=a.kod1c AND b.del=0);');
  ZQuery1.ExecSQL;

  //кол-во строк до заполнения
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT COUNT(*) FROM av_spr_kontr_dog;');
  ZQuery1.Open;
  kolvo:=0;
  if ZQuery1.RecordCount>0 then
   kolvo:= ZQuery1.FieldByName('count').AsInteger;

  //добавляем новые записи в таблицу договоров
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_spr_kontr_dog (id,id_kontr,del,createdate,id_user,createdate_first,id_user_first,kodkont,kod1c,name,datazak,datavoz,datapog,val,datanacsh,dataprsh,stav,viddog,podr,otcblm,');
  ZQuery1.SQL.add('otcbagm,otcblp,otcbagp,komotd,med,ubor,stop,disp,voin,lgot,dopus,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,shtr6,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm6,edizm7)');
  ZQuery1.SQL.add(' SELECT a.id,b.id as id_kontr,0,now(),'+inttostr(id_user)+',now(),'+inttostr(id_user)+',a.kodkont,a.kod1c,a.name,a.datazak,a.datavoz,a.datapog,a.val,a.datanacsh,a.dataprsh,a.stav,a.viddog,a.podr,a.otcblm,a.otcbagm,a.otcblp,a.otcbagp,');
  ZQuery1.SQL.add('a.komotd,a.med,a.ubor,a.stop,a.disp,a.voin,a.lgot,a.dopus,a.vidar,a.sumar,a.shtr1,a.shtr2,a.shtr11,a.shtr3,a.shtr4,a.shtr41,a.shtr5,a.shtr6,a.shtr7,a.edizm1,a.edizm11,a.edizm2,a.edizm3,a.edizm4,a.edizm41,a.edizm5,a.edizm6,a.edizm7');
  ZQuery1.SQL.add(' FROM '+ ttabl1+' as a JOIN av_spr_kontragent AS b ON a.kodkont=b.kod1c AND b.del=0 order by a.id;');
  ZQuery1.Open;

  //удалить временную
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('DROP TABLE '+ttabl1+';');
  ZQuery1.ExecSQL;

  //кол-во строк after заполнения
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT COUNT(*) FROM av_spr_kontr_dog;');
  ZQuery1.Open;
  if ZQuery1.RecordCount>0 then
   kolvo:= ZQuery1.FieldByName('count').AsInteger - kolvo;

  // Завершение транзакции
  Zconnection1.Commit;
  Zconnection1.AutoCommit:=true;
  if ZConnection1.InTransaction then
     begin
       showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
       ZConnection1.Rollback;
     end
  else
     begin
      If kolvo>0 then
       begin
       showmessage('ДОГОВОРА. Транзакция завершена УСПЕШНО !'+#13+'Добавлено  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       bDog:=1;
       end;
     end;
  end;
 //  **************************************************
  If bCH=0 then
     showmessage('Изменений в справочнике контрагентов НЕ ОБНАРУЖЕНО!');

  If bDog=0 then
     showmessage('Изменений в справочнике договоров НЕ ОБНАРУЖЕНО!');
  Zconnection1.disconnect;
  UpdateGrid();
 end;
end;

procedure TFormsk.BitBtn5Click(Sender: TObject);
begin
   if (formsk.StringGrid1.Focused) and (formsk.StringGrid1.RowCount>1) then
    begin
     result_shedule_kontr:=formsk.StringGrid1.Cells[1,formsk.StringGrid1.row];
     formsk.close;
    end;
end;

procedure TFormsk.BitBtn6Click(Sender: TObject);
begin
  form13:=Tform13.create(self);
  form13.ShowModal;
  FreeAndNil(form13);
  // Заполняем поля для АТС
  if not(result_name_ats='') then
   begin
     // Подключаемся к серверу
     if flagprofile=1 then MConnect(formsk.Zconnection1,ConnectINI[3],ConnectINI[1]);
     if flagprofile=2 then MConnect(formsk.Zconnection1,ConnectINI[6],ConnectINI[4]);
     try
         formsk.Zconnection1.connect;
     except
         showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
         exit;
     end;
     //Делаем запрос к населенным пунктам
     try
      formsk.ZQuery1.SQL.Clear;
      formsk.ZQuery1.SQL.add('select * from av_spr_ats where id='+trim(result_name_ats)+';');
      formsk.ZQuery1.open;
     except
      showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      formsk.ZQuery1.close;
      formsk.ZConnection1.disconnect;
      result_name_ats:='';
      exit;
     end;
     if formsk.ZQuery1.RecordCount=0 then
        begin
          formsk.ZQuery1.Close;
          formsk.ZConnection1.Disconnect;
          result_name_ats:='';
          exit;
        end;
     result_name_ats:='';
     // Записываем как новую запись
     //Открываем транзакцию
     formsk.Zconnection1.AutoCommit:=false;
     formsk.ZQuery2.SQL.Clear;
     formsk.ZQuery2.SQL.add('INSERT INTO av_spr_kontr_ats(id_kontr, id_ats, createdate, id_user, del, id_user_first, createdate_first');
     formsk.ZQuery2.SQL.add(') VALUES (');
     formsk.ZQuery2.SQL.add(trim(formsk.StringGrid1.Cells[1,formsk.StringGrid1.row])+',');
     formsk.ZQuery2.SQL.add(formsk.ZQuery1.FieldByName('id').asString+',');
     formsk.ZQuery2.SQL.add('now(),');
     formsk.ZQuery2.SQL.add(inttostr(id_user)+',');
     formsk.ZQuery2.SQL.add('0,');
     formsk.ZQuery2.SQL.add(inttostr(id_user)+',');
     formsk.ZQuery2.SQL.add('now()');
     formsk.ZQuery2.SQL.add(');');
     formsk.ZQuery2.open;

     // Завершение транзакции
     formsk.Zconnection1.Commit;
     formsk.Zconnection1.AutoCommit:=true;
     if formsk.ZConnection1.InTransaction then
        begin
          showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
          formsk.ZConnection1.Rollback;
        end;
     formsk.ZQuery1.Close;
     formsk.ZQuery2.Close;
     formsk.ZConnection1.Disconnect;
     formsk.UpdateGridATS();
   end;
end;

procedure TFormsk.BitBtn7Click(Sender: TObject);
begin
    If trim(Formsk.StringGrid1.Cells[1,Formsk.StringGrid1.row])='' then
    begin
      showmessage('Сначала выберите контрагента !');
      exit;
    end;
  Form23:=TForm23.create(self);
  Form23.ShowModal;
  FreeAndNil(Form23);

end;

procedure TFormsk.FormActivate(Sender: TObject);
begin
   formsk.StringGrid1.ColWidths[0]:=-1;
   formsk.StringGrid1.ColWidths[4]:=-1;
   formsk.StringGrid1.ColWidths[5]:=-1;
   formsk.StringGrid1.ColWidths[6]:=-1;
   formsk.StringGrid1.ColWidths[7]:=-1;
   formsk.StringGrid1.ColWidths[8]:=-1;
end;

procedure TFormsk.FormCreate(Sender: TObject);
begin
  per:=2;
end;

procedure TFormsk.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
     // Автоматический контекстный поиск
    if (GetSymKey(char(Key))=true) then
      begin
        formsk.Edit1.SetFocus;
      end;
     if (Key=13) and (formsk.Edit1.Focused) then Formsk.ToolButton8.Click;
    // F1
     if Key=112 then showmessage('F1 - Справка'+char(13)+'ENTER - Выбор'+char(13)+'ESC - Отмена\Выход');
     // ESC
     if Key=27 then formsk.Close;
    // ENTER
    if (Key=13) and  (formsk.StringGrid1.Focused) then
      begin
        result_shedule_kontr:=formsk.StringGrid1.Cells[1,formsk.StringGrid1.row];
        formsk.close;
      end;
end;




end.

