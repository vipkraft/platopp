unit kontr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, nas_edit, platproc,ExtCtrls, kontr_edit,
  dogovor,ats_main;

type

  { TForm19 }

  TForm19 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn12: TBitBtn;
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
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    RadioGroup1: TRadioGroup;
    Shape1: TShape;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
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
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);

    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form19: TForm19;
  flag_edit, vibor:byte;
  n: integer;
  result_name_nas,kontrID,kontrN,kontr1c:string;
  masedit: Array[0..14] of string;

implementation
uses
  mainopp;

{$R *.lfm}

{ TForm19 }

//********************************* ОБНОВЛЕНИЕ ДАННЫХ НА ГРИДЕ ******************************************
procedure TForm19.UpdateGrid();
 var
   n,m,k:integer;
begin
   if flagprofile=1 then MConnect(Form19.Zconnection1,ConnectINI[3],ConnectINI[1]);
   if flagprofile=2 then MConnect(Form19.Zconnection1,ConnectINI[6],ConnectINI[4]);
   try
       Form19.Zconnection1.connect;
   except
       showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
       Form19.Close;
       exit;
   end;

   //запрос списка контрагентов
   Form19.ZQuery1.SQL.Clear;
//   Form19.ZQuery1.SQL.add('select * from av_spr_kontragent where del=0 ORDER by name;');
   Form19.ZQuery1.SQL.add('SELECT id,name,polname,kod1c,vidkontr,inn,okpo,adrur,tel,document,adrpos,0 AS flagper FROM av_spr_kontragent WHERE del=0 ORDER by name;');
   try
    Form19.ZQuery1.open;
   except
    showmessage('Выполнение команды SQL SELECT - ОШИБКА !'+#13+ZQuery1.SQL.Text);
    Form19.ZQuery1.Close;
    Form19.Zconnection1.disconnect;
   end;
   if Form19.ZQuery1.RecordCount>0 then
   begin
    //подготовка прогрессбара
   form19.ProgressBar1.Max:=Form19.stringgrid1.RowCount+500;
   form19.ProgressBar1.Position:=0;
   form19.ProgressBar1.visible:=true;
   // Заполняем stringgrid
   Form19.StringGrid1.RowCount:=Form19.ZQuery1.RecordCount+1;
   for n:=1 to Form19.ZQuery1.RecordCount do
    begin
      form19.ProgressBar1.Position:=form19.ProgressBar1.Position+1;
      form19.ProgressBar1.Repaint;

      Form19.StringGrid1.Cells[0,n]:=Form19.ZQuery1.FieldByName('id').asString;
      Form19.StringGrid1.Cells[1,n]:=Form19.ZQuery1.FieldByName('name').asString;
      Form19.StringGrid1.Cells[2,n]:=Form19.ZQuery1.FieldByName('polname').asString;
      Form19.StringGrid1.Cells[3,n]:=Form19.ZQuery1.FieldByName('kod1c').asString;
      Form19.StringGrid1.Cells[4,n]:=Form19.ZQuery1.FieldByName('vidkontr').asString;
      Form19.StringGrid1.Cells[5,n]:=Form19.ZQuery1.FieldByName('inn').asString;
      Form19.StringGrid1.Cells[6,n]:=Form19.ZQuery1.FieldByName('okpo').asString;
      Form19.StringGrid1.Cells[7,n]:=Form19.ZQuery1.FieldByName('adrur').asString;
      Form19.StringGrid1.Cells[8,n]:=Form19.ZQuery1.FieldByName('tel').asString;
      Form19.StringGrid1.Cells[9,n]:=Form19.ZQuery1.FieldByName('document').asString;
      Form19.StringGrid1.Cells[10,n]:=Form19.ZQuery1.FieldByName('adrpos').asString;
      Form19.StringGrid1.Cells[11,n]:=Form19.ZQuery1.FieldByName('flagper').asString;
      Form19.ZQuery1.Next;
    end;
   end;

//запрос списка договоров перевозки
   Form19.ZQuery1.SQL.Clear;
   Form19.ZQuery1.SQL.add('SELECT DISTINCT a.id FROM av_spr_kontragent AS a,av_spr_kontr_dog as b WHERE a.id=b.id_kontr AND trim(b.viddog)=''00002'' order by a.id;');
   try
    Form19.ZQuery1.open;
   except
    showmessage('Выполнение команды SQL SELECT - ОШИБКА !'+#13+ZQuery1.SQL.Text);
    Form19.ZQuery1.Close;
    Form19.Zconnection1.disconnect;
   end;
 //проставляем в гриде flagper
   if Form19.ZQuery1.RecordCount>0 then
   begin
   //расчет остатка для прогрессбара
      k:= 500 div Form19.ZQuery1.RecordCount;
      for n:=1 to Form19.ZQuery1.RecordCount do
      begin
        form19.ProgressBar1.Position:=form19.ProgressBar1.Position+1;
        form19.ProgressBar1.Repaint;

        for m:=1 to Form19.StringGrid1.RowCount-1 do
          begin
           If strToInt(Form19.StringGrid1.Cells[0,m])=Form19.ZQuery1.FieldByName('id').AsInteger then
            begin
               Form19.StringGrid1.Cells[11,m]:='1';
               break;
            end;
          end;
        Form19.ZQuery1.Next;
      end;
   end;

   form19.ProgressBar1.visible:=false;
   Form19.ZQuery1.Close;
   Form19.Zconnection1.disconnect;
   Form19.StringGrid1.Refresh;
end;


//***********************************************          ОБНОВИТЬ ИЗ 1С **************************************************
procedure TForm19.BitBtn3Click(Sender: TObject);
var
 szap,comma,stim,ttabl1,ttabl2: string;
 bCH,bDog: byte;
 chislo,kolvo, n: integer;
begin
   bCH:=0;
   bDog:=0;
   szap:='';
   comma:=',';
  if flagprofile=1 then MConnect(Form19.Zconnection1,ConnectINI[3],ConnectINI[1]);
  if flagprofile=2 then MConnect(Form19.Zconnection1,ConnectINI[6],ConnectINI[4]);
  with Form19 do
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
   //SELECT a.kod1c FROM av_1c_kontr AS a,av_spr_kontragent AS b
   // WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos
   // AND a.tel=b.tel AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || ',' || a.docnom || ',' || a.docorgv || ',' || coalesce('' || a.docdatv || '',''))=b.document);
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
  //CREATE TABLE ttabl2 (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL,polname character(200) NOT NULL,vidkontr character(50) NOT NULL,inn character(20) NOT NULL,okpo character(15) NOT NULL,adrur character(200) NOT NULL,
  //adrpos character(200) NOT NULL,tel character(50) NOT NULL,document character(200) NOT NULL) WITH (OIDS=FALSE);

  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl2+' SELECT b.id,a.kod1c,a.name,a.polname,a.vidkontr,a.inn,a.okpo,a.adrur,a.adrpos,a.tel,a.docsr || '+QuotedStr(comma));
  ZQuery1.SQL.Add(' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''','''') AS document FROM av_1c_kontr AS a ');
  ZQuery1.SQL.Add('LEFT JOIN av_spr_kontragent AS b USING (kod1c) ');
  ZQuery1.SQL.Add('WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname ');
  ZQuery1.SQL.Add('AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel ');
  ZQuery1.SQL.Add('AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || '+QuotedStr(comma)+' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''',''''))=b.document);');
  //INSERT INTO ttabl2 SELECT b.id,a.kod1c,a.name,a.polname,a.vidkontr,a.inn,a.okpo,a.adrur,a.adrpos,a.adrelect,a.tel,a.docsr || ','
  //|| a.docnom || ',' || a.docorgv || ',' || coalesce('' || a.docdatv || '','') AS document FROM av_1c_kontr AS a
  //LEFT JOIN av_spr_kontragent AS b USING (kod1c)
  //WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname
  //AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel
  //AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || ',' || a.docnom || ',' || a.docorgv || ',' || coalesce('' || a.docdatv || '',''))=b.document);
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
  {
  DROP TABLE ttabl1;
  CREATE TABLE  ttabl1  (id integer NOT NULL DEFAULT 0,id_kontr integer NOT NULL DEFAULT 0,kodkont integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(200) NOT NULL,datazak date,datavoz date,datapog date,
  val character(20) NOT NULL,datanacsh date,dataprsh date,stav numeric(5,2) NOT NULL DEFAULT 0,viddog character(20) NOT NULL,podr character(50) NOT NULL,otcblm numeric(5,2) NOT NULL DEFAULT 0,otcbagm numeric(5,2) NOT NULL DEFAULT 0,
  otcblp numeric(5,2) NOT NULL DEFAULT 0,otcbagp numeric(5,2) NOT NULL DEFAULT 0,komotd numeric(10,2) NOT NULL DEFAULT 0,med numeric(10,2) NOT NULL DEFAULT 0,ubor numeric(10,2) NOT NULL DEFAULT 0,stop numeric(10,2) NOT NULL DEFAULT 0,
  disp numeric(10,2) NOT NULL DEFAULT 0,voin numeric(5,2) NOT NULL DEFAULT 0,lgot numeric(5,2) NOT NULL DEFAULT 0,dopus numeric(5,2) NOT NULL DEFAULT 0,vidar character(200) NOT NULL,sumar numeric(20,2) NOT NULL DEFAULT 0,
  shtr1 numeric(10,2) NOT NULL DEFAULT 0,shtr11 numeric(10,2) NOT NULL DEFAULT 0,shtr2 numeric(10,2) NOT NULL DEFAULT 0,shtr3 numeric(10,2) NOT NULL DEFAULT 0,shtr4 numeric(10,2) NOT NULL DEFAULT 0,shtr41 numeric(10,2) NOT NULL DEFAULT 0,
  shtr5 numeric(10,2) NOT NULL DEFAULT 0,shtr6 numeric(10,2) NOT NULL DEFAULT 0,shtr7 numeric(10,2) NOT NULL DEFAULT 0,edizm1 character(20) NOT NULL,edizm11 character(20) NOT NULL,edizm2 character(20) NOT NULL,edizm3 character(20) NOT NULL,
  edizm4 character(20) NOT NULL,edizm41 character(20) NOT NULL,edizm5 character(20) NOT NULL,edizm6 character(20) NOT NULL,edizm7 character(20) NOT NULL) WITH (OIDS=FALSE);
   }
  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('insert into '+ ttabl1+' SELECT row_number() over (order by a.kodkont)+coalesce((select max(id) from av_spr_kontr_dog),0) as id,0,kodkont,kod1c,name,datazak,datavoz,datapog,val,datanacsh,dataprsh,stav,viddog,podr,');
  ZQuery1.SQL.Add('otcblm,otcbagm,otcblp,otcbagp,komotd,med,ubor,stop,disp,voin,lgot,dopus,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,shtr6,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm6,edizm7 FROM av_1c_kontr_dog AS a');
  ZQuery1.SQL.Add('WHERE NOT EXISTS (SELECT kodkont,kod1c FROM av_spr_kontr_dog AS b WHERE b.kodkont=a.kodkont AND b.kod1c=a.kod1c AND b.del=0);');
  ZQuery1.ExecSQL;
  {
  insert into ttabl1 SELECT row_number() over (order by a.kodkont)+coalesce((select max(id) from av_spr_kontr_dog),0) as id,0,kodkont,kod1c,name,datazak,datavoz,datapog,
  val,datanacsh,dataprsh,stav,viddog,podr,otcblm,otcbagm,otcblp,otcbagp,komotd,med,ubor,stop,disp,voin,lgot,dopus,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,
  shtr6,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm6,edizm7 FROM av_1c_kontr_dog AS a
  WHERE NOT EXISTS (SELECT kodkont,kod1c FROM av_spr_kontr_dog AS b WHERE b.kodkont=a.kodkont AND b.kod1c=a.kod1c AND b.del=0);
  }
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
  {
  INSERT INTO av_spr_kontr_dog (id,id_kontr,del,createdate,id_user,createdate_first,id_user_first,kodkont,kod1c,name,datazak,datavoz,datapog,val,datanacsh,
  dataprsh,stav,viddog,podr,otcblm,otcbagm,otcblp,otcbagp,komotd,med,ubor,stop,disp,voin,lgot,dopus,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,shtr6,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm6,edizm7)
SELECT a.id,b.id as id_kontr,0,now(), 1 ,now(), 1 , a.kodkont,a.kod1c,a.name,a.datazak,a.datavoz,a.datapog,a.val,a.datanacsh,a.dataprsh,a.stav,a.viddog,a.podr,
  a.otcblm,a.otcbagm,a.otcblp,a.otcbagp,a.komotd,a.med,a.ubor,a.stop,a.disp,a.voin,a.lgot,a.dopus,a.vidar,a.sumar,a.shtr1,a.shtr2,a.shtr11,a.shtr3,
  a.shtr4,a.shtr41,a.shtr5,a.shtr6,a.shtr7,a.edizm1,a.edizm11,a.edizm2,a.edizm3,a.edizm4,a.edizm41,a.edizm5,a.edizm6,a.edizm7
 FROM ttabl1 as a
  JOIN av_spr_kontragent AS b
 ON a.kodkont=b.kod1c AND b.del=0
 order by b.id;
 }
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
  {
   //ищем отредактированные в 1с   ********************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT a.kod1c FROM av_1c_kontr AS a,av_spr_kontragent AS b ');
   ZQuery1.SQL.add('WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos ');
   ZQuery1.SQL.add('AND a.tel=b.tel AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || '+QuotedStr(comma)+' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''',''''))=b.document);');
   //SELECT a.kod1c FROM av_1c_kontr AS a,av_spr_kontragent AS b
   // WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos
   // AND a.tel=b.tel AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || ',' || a.docnom || ',' || a.docorgv || ',' || coalesce('' || a.docdatv || '',''))=b.document);
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
  //CREATE TABLE ttabl2 (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL,polname character(200) NOT NULL,vidkontr character(50) NOT NULL,inn character(20) NOT NULL,okpo character(15) NOT NULL,adrur character(200) NOT NULL,
  //adrpos character(200) NOT NULL,tel character(50) NOT NULL,document character(200) NOT NULL) WITH (OIDS=FALSE);

  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl2+' SELECT b.id,a.kod1c,a.name,a.polname,a.vidkontr,a.inn,a.okpo,a.adrur,a.adrpos,a.tel,a.docsr || '+QuotedStr(comma));
  ZQuery1.SQL.Add(' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''','''') AS document FROM av_1c_kontr AS a ');
  ZQuery1.SQL.Add('LEFT JOIN av_spr_kontragent AS b USING (kod1c) ');
  ZQuery1.SQL.Add('WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname ');
  ZQuery1.SQL.Add('AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel ');
  ZQuery1.SQL.Add('AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || '+QuotedStr(comma)+' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''',''''))=b.document);');
  //INSERT INTO ttabl2 SELECT b.id,a.kod1c,a.name,a.polname,a.vidkontr,a.inn,a.okpo,a.adrur,a.adrpos,a.adrelect,a.tel,a.docsr || ','
  //|| a.docnom || ',' || a.docorgv || ',' || coalesce('' || a.docdatv || '','') AS document FROM av_1c_kontr AS a
  //LEFT JOIN av_spr_kontragent AS b USING (kod1c)
  //WHERE a.kod1c=b.kod1c AND b.del=0 AND NOT(a.name=b.name AND a.polname=b.polname
  //AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel
  //AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || ',' || a.docnom || ',' || a.docorgv || ',' || coalesce('' || a.docdatv || '',''))=b.document);
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
       showmessage('ДОГОВОРА. Транзакция завершена УСПЕШНО !'+#13+'Отредактировано  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       bDog:=1;
     end;
  end;
   }
 //  **************************************************
  If bCH=0 then
     showmessage('Изменений в справочнике контрагентов НЕ ОБНАРУЖЕНО!');

  If bDog=0 then
     showmessage('Изменений в справочнике договоров НЕ ОБНАРУЖЕНО!');
  Zconnection1.disconnect;
  UpdateGrid();
 end;
end;


//*********************************************** ДОБАВИТЬ **********************************************
procedure TForm19.BitBtn1Click(Sender: TObject);
begin
  flag_edit:=1; //флаг операции
  vibor:=0; //флаг выбора
  //обнуляем массив
  for n:=0 to 14 do
   begin
    masedit[n]:='';
   end;
  Form20:=TForm20.create(self);
  Form20.ShowModal;
  FreeAndNil(Form20);
  Form19.UpdateGrid();
end;


//********************************************** УДАЛИТЬ  *****************************************************
procedure TForm19.BitBtn2Click(Sender: TObject);
 var
   res_flag:integer;
begin
  //Удаляем запись
   if (trim(Form19.StringGrid1.Cells[0,Form19.StringGrid1.row])='') or (Form19.StringGrid1.RowCount=1) then
     begin
       showmessage('Не выбрана запись для удаления !');
       exit;
     end;
  res_flag := dialogs.MessageDlg('Удалить запись данного контрагента ?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag=6 then
   begin
      if flagprofile=1 then MConnect(Form19.Zconnection1,ConnectINI[3],ConnectINI[1]);
      if flagprofile=2 then MConnect(Form19.Zconnection1,ConnectINI[6],ConnectINI[4]);
     try
         Form19.Zconnection1.connect;
     except
         showmessage('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
         Form19.Close;
         exit;
     end;
     //проставляем запись на удаление
     Form19.ZQuery1.SQL.Clear;
     Form19.ZQuery1.SQL.add('UPDATE av_spr_kontragent SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(Form19.StringGrid1.Cells[0,Form19.StringGrid1.row])+' and del=0;');
     Form19.ZQuery1.open;
     Form19.Zconnection1.disconnect;
     Form19.UpdateGrid();
   end;
end;


//**************************************************    ИЗМЕНИТЬ  ***************************************************
procedure TForm19.BitBtn12Click(Sender: TObject);
begin
 with Form19.StringGrid1 do
 begin
   //Редактируем запись населенного пункта
  if (Form19.StringGrid1.Cells[0,Form19.StringGrid1.row]=EMPTYSTR) or (Form19.StringGrid1.RowCount=1) then
    begin
      showmessage('Не выбрана запись для редактирования !');
      exit;
    end;
  //обнуляем массив и заполняем данными записи
  for n:=0 to 14 do
   begin
    masedit[n]:='';
   end;
  masedit[0]:=Cells[0,row];//id
  masedit[1]:=Cells[1,row];//наименование
  masedit[2]:=Cells[2,row];//полное имя
  masedit[3]:=Cells[3,row];//код 1с
  masedit[4]:=Cells[4,row];//тип
  masedit[5]:=Cells[5,row];//инн
  masedit[6]:=Cells[6,row];//окпо
  masedit[7]:=Cells[7,row];//адрес юридический
  masedit[8]:=Cells[8,row];//телефон
  masedit[9]:=Cells[9,row];//документ
  masedit[10]:=Cells[10,row];//адрес почтовый

  flag_edit:=2; //флаг операции
  Form20:=TForm20.create(self);
  Form20.ShowModal;
  FreeAndNil(Form20);
  Form19.UpdateGrid();
 end;
end;

//***********************************************       ВЫХОД     **********************************************************
procedure TForm19.BitBtn4Click(Sender: TObject);
begin
  Form19.Close;
end;

//***********************************************      ВЫБРАТЬ  ***************************************************************
procedure TForm19.BitBtn5Click(Sender: TObject);
begin

end;

//***********************************************   команда отрисовки грида ***************************************************
procedure TForm19.Timer1Timer(Sender: TObject);
begin
   Form19.UpdateGrid();
   Form19.Timer1.Enabled:=false;
end;

//***************************************     договора перевозчика    ************************************************************
procedure TForm19.BitBtn6Click(Sender: TObject);
begin
  If trim(Form19.StringGrid1.Cells[0,Form19.StringGrid1.row])='' then
    begin
      showmessage('Сначала выберите контрагента !');
      exit;
    end;
  kontrID:=Form19.StringGrid1.Cells[0,Form19.StringGrid1.row];
  kontrN:=Form19.StringGrid1.Cells[1,Form19.StringGrid1.row];
  kontr1c:=Form19.StringGrid1.Cells[3,Form19.StringGrid1.row];
  Form23:=TForm23.create(self);
  Form23.ShowModal;
  FreeAndNil(Form23);
end;

//****************************************  АТС ПЕРЕВОЗЧИКА  *******************************************************************
procedure TForm19.BitBtn7Click(Sender: TObject);
begin
 with Form19 do
 begin
  If trim(StringGrid1.Cells[0,StringGrid1.row])='' then
    begin
      showmessage('Сначала выберите контрагента !');
      exit;
    end;
  kontrID:=StringGrid1.Cells[0,StringGrid1.row];
  kontrN:=trim(StringGrid1.Cells[1,StringGrid1.row]);

  //Mode:=2;
  Form13:=TForm13.create(self);
  Form13.ShowModal;
  FreeAndNil(Form13);
  //Mode:=1;
 end;
end;


//************************************************* HOTKEYS ********************************************************************
procedure TForm19.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   // F1
    if Key=112 then showmessage('F1 - Справка'+#13+'F2 - Договора'+#13+'F3 - АТС'+#13+'F4 - Изменить'+#13+'F5 - Добавить'+#13+'F8 - Удалить'+#13+'ENTER - Выбор'+#13+'ESC - Отмена\Выход');
    //F2 - Договора
    if (Key=113) and (form19.bitbtn6.enabled=true) then form19.bitbtn6.click;
    //F3 - ATC
    if (Key=114) and (form19.bitbtn7.enabled=true) then form19.bitbtn7.click;
    //F4 - Изменить
    if (Key=115) and (Form19.bitbtn12.enabled=true) then Form19.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (Form19.bitbtn1.enabled=true) then Form19.BitBtn1.Click;
    //F8 - Удалить
    if (Key=119) and (Form19.bitbtn2.enabled=true) then Form19.BitBtn2.Click;
    // ESC
    if Key=27 then Form19.Close;
    // ENTER
    if Key=13 then
      begin
       // result_name_nas:=Form19.StringGrid1.Cells[0,Form19.StringGrid1.row];
       // Form19.close;
      end;
end;

   /////********************************************     ОТРИСОВКА ГРИДА ************************************************
procedure TForm19.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
    cBrush,cFont,cPer,cCasual: TColor;
begin
 with Sender as TStringGrid,Canvas do
 begin
   cBrush:=clMenuHighLight;
   cFont:=clWhite;
   cPer :=clSkyBlue;
   cCasual := clWhite;
  //Если ячейка выбрана, закрашиваем другим цветом
  if (gdSelected in aState) then
  begin
    Brush.Color := cBrush;
    Font.Color := cFont;
    Font.Size := 9;
  end
  else //Если есть договор перевозки, закрашиваем строку
    if trim(Cells[11,aRow]) = '1' then
      Brush.color := cPer
    else
      Brush.Color := cCasual;
 //Закрашиваем грид
  if (ARow > 0) then
  begin
    //Закрашиваем бэкграунд
    FillRect(aRect);
    //Закрашиваем текст (Text). Также здесь можно добавить выравнивание и т.д..
    TextOut(aRect.Left, aRect.Top, Cells[ACol, ARow]);
  end;
 end;

end;


//************************************************* СОРТИРОВКА **********************************************
procedure TForm19.ToolButton1Click(Sender: TObject);
begin
   SortGrid(Form19.StringGrid1,Form19.StringGrid1.col,Form19.ProgressBar1);
end;

// ******************************************      ПОИСК  ******************************************************
procedure TForm19.ToolButton8Click(Sender: TObject);
begin
    GridPoisk(Form19.StringGrid1,Form19.Edit1);
end;

//**** ********************************  ФИЛЬТРАЦИЯ ОТОБРАЖАЕМЫХ КОНТРАГЕНТОВ *********************************
procedure TForm19.RadioGroup1Click(Sender: TObject);
var
  n,m: integer;
  arrS : array of array of string;
begin
  with Form19 do
  begin
  //Если только перевозчики
   If RadioGroup1.ItemIndex=1 then
    begin
     SetLength(arrS,Form19.StringGrid1.RowCount-1,12);
     m:=0;
      for n:=1 to Form19.StringGrid1.RowCount-1 do
          begin
           If trim(Form19.StringGrid1.Cells[11,n])='1' then
            begin
             m:=m+1;
             arrS[m,0]:=Form19.StringGrid1.Cells[0,n];
             arrS[m,1]:=Form19.StringGrid1.Cells[1,n];
             arrS[m,2]:=Form19.StringGrid1.Cells[2,n];
             arrS[m,3]:=Form19.StringGrid1.Cells[3,n];
             arrS[m,4]:=Form19.StringGrid1.Cells[4,n];
             arrS[m,5]:=Form19.StringGrid1.Cells[5,n];
             arrS[m,6]:=Form19.StringGrid1.Cells[6,n];
             arrS[m,7]:=Form19.StringGrid1.Cells[7,n];
             arrS[m,8]:=Form19.StringGrid1.Cells[8,n];
             arrS[m,9]:=Form19.StringGrid1.Cells[9,n];
             arrS[m,10]:=Form19.StringGrid1.Cells[10,n];
             arrS[m,11]:=Form19.StringGrid1.Cells[11,n];
            end;
           end;
      If m>0 then
       begin
        Form19.StringGrid1.RowCount:=m+1;
        for n:=1 to m do
          begin
            Form19.StringGrid1.Cells[0,n]:=arrS[n,0];
            Form19.StringGrid1.Cells[1,n]:=arrS[n,1];
            Form19.StringGrid1.Cells[2,n]:=arrS[n,2];
            Form19.StringGrid1.Cells[3,n]:=arrS[n,3];
            Form19.StringGrid1.Cells[4,n]:=arrS[n,4];
            Form19.StringGrid1.Cells[5,n]:=arrS[n,5];
            Form19.StringGrid1.Cells[6,n]:=arrS[n,6];
            Form19.StringGrid1.Cells[7,n]:=arrS[n,7];
            Form19.StringGrid1.Cells[8,n]:=arrS[n,8];
            Form19.StringGrid1.Cells[9,n]:=arrS[n,9];
            Form19.StringGrid1.Cells[10,n]:=arrS[n,10];
            Form19.StringGrid1.Cells[11,n]:=arrS[n,11];
          end;
       end;
    end;
   // Если отобразить всех
   If RadioGroup1.ItemIndex=0 then
    begin
     UpdateGrid();
    end;
  end;
  arrS:=nil;
end;

// **************************************  ВОЗНИКНОВЕНИЕ ФОРМЫ ****************************************
procedure TForm19.FormShow(Sender: TObject);
var
  n:integer;
begin
Centrform(Form19);
with Form19 do
    begin
       ProgressBar1.Position:=0;
       ProgressBar1.visible:=true;
//определить уровень доступа
   if flag_access=1 then
    begin
       BitBtn1.Enabled:=false;
       BitBtn2.Enabled:=false;
       BitBtn12.Enabled:=false;
    end;
    end;
end;


end.

