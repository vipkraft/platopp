unit shedule_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, LazFileUtils, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids,StrUtils,TicketTypes, LazUtf8;

type

  { TForm15 }

  TForm15 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure CheckBox7Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    //procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1SetCheckboxState(Sender: TObject; ACol, ARow: Integer;
      const Value: TCheckboxState);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateGrid(filter_type:byte; stroka:string);
    procedure EditCheck(); //проверка ввода брони
  private
    { private declarations }
    formActivated: boolean;
  public
    { public declarations }
  end; 

var
  Form15: TForm15;
  flag_edit_shedule:integer;
  result_name_shedule, result_shedule :string;
  m_route:array of array of String;


implementation
uses
  mainopp,platproc,point_main,shedule_edit,route_main,kontr_main,shedule_bron;
{$R *.lfm}

{ TForm15 }
const
  mas_size = 26;
var
  //s_zapros : string;
  n_idroute: integer;
  n_atp : integer=0;
  datatyp : byte=0;
  ss:string='';
  filtr,flagupdate :boolean;
  ar_seats : array of string;
  //флаг первичной выборки
  first_flag: boolean;

 // ================================= M_route =========================================
  //  m_route - Основной массив данных расписаний
  //-------------------------------------------------------
  //  m_route[n,1] //код маршрута
  //  m_route[n,2] //наименование маршрута
  //  m_route[n,3]:=
  //  m_route[n,4]:='1'; //Тип 1-маршрут,2-расписание
  //  m_route[n,5] //Тип 0-неактивно,1-активно
 ////Расписания
  //  m_route[n,6] //id расписания
  //  m_route[n,7] //код расписания
  //  m_route[n,8] //наименование расписания
  //  m_route[n,9]:='';
  //  m_route[n,10]:='2'; //Тип 1-маршрут,2-расписание
  //  m_route[n,11]:='0'; //Тип 0-неактивно,1-активно
  //  m_route[n,12] //признак удалено или нет
  //  m_route[n,13] //дата активности расписания
  //  m_route[n,14] //заказной - признак
  //  m_route[n,15] //признак существования тарифа
  //  m_route[n,16] //id предыдущего расписания
  //  m_route[n,17] //кол-во записей брони
  //  m_route[n,18] //кол-во записей фиксированного тарифа
    //m_route[n,19] //продавать удаленку
    //m_route[n,20] //продавать через инет
    //m_route[n,21] //обязательный телефон
  //  m_route[n,22] //запрет продажи по ВОИНСКИМ ПЕРЕВОЗОЧНЫМ ДОКУМЕНТАМ (ВПД)
   //m_route[n,23] //невидимые расписания для интернета
   //m_route[n,24] //перевозчик код
   //m_route[n,25] //перевозчик имя

//***********************************  ОБНОВИТЬ ДАННЫЕ НА ГРИДЕ **************************************************
procedure TForm15.UpdateGrid(filter_type:byte; stroka:string);
 var
   n,m,cnt:integer;
   orderby,sstr,stp,sal,stmp : string;
 begin
   flagupdate:=true;
  with FOrm15 do
  begin
   label1.Caption:='';

   orderby := stringgrid1.Columns[sort_col].Title.Caption;

   Stringgrid1.RowCount:=1;
   panel2.Visible:=true;
   application.ProcessMessages;

   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

   stmp:='';
  //||=====================  фильтр расписаний

  // Запрос маршрутов и расписаний
  Form15.ZQuery1.SQL.clear;
  Form15.ZQuery1.SQL.add(' SELECT g.* FROM ( SELECT m.* ');
  Form15.ZQuery1.SQL.add(',(SELECT c.name FROM av_spr_locality AS c WHERE m.nas1=c.id ORDER BY c.del ASC, c.createdate DESC limit 1) ');
  Form15.ZQuery1.SQL.add('|| '' - '' ||');
  Form15.ZQuery1.SQL.add(' (SELECT c.name FROM av_spr_locality AS c WHERE m.nas2=c.id ORDER BY c.del ASC, c.createdate DESC limit 1) ');
  Form15.ZQuery1.SQL.add('|| (case when nas3>0 then ('' - '' || (SELECT c.name FROM av_spr_locality AS c WHERE m.nas3=c.id ORDER BY c.del ASC, c.createdate DESC limit 1))');
  Form15.ZQuery1.SQL.add(' ELSE '''' end) as name_route ');
  Form15.ZQuery1.SQL.add(',coalesce((SELECT t.name FROM av_spr_kontragent AS t WHERE t.id=m.atpid AND t.del=0 ORDER BY t.createdate DESC limit 1),'''') as atpname ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((SELECT 1 FROM av_shedule_bron  WHERE del=0 AND m.id=id_shedule LIMIT 1),0) END as bron ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((SELECT 1 FROM av_shedule_price WHERE del=0 AND m.id=id_shedule LIMIT 1),0) END as price ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((select 1 FROM av_shedule_tarif WHERE del=0 AND id_shedule=m.id limit 1),0) END as tarif ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((SELECT 1 FROM av_shedule_fio    WHERE del=0 AND m.id=id_shedule LIMIT 1),0) END as personal ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((SELECT 1 FROM av_shedule_tel    WHERE del=0 AND m.id=id_shedule LIMIT 1),0) END as tel ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((SELECT 1 FROM av_shedule_voin_deny  WHERE del=0 AND m.id=id_shedule LIMIT 1),0) END as vpd ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((SELECT 1 FROM av_shedule_invisible  WHERE del=0 AND m.id=id_shedule LIMIT 1),0) END as invis ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((SELECT remote_sale FROM av_shedule_remote_sale_permition WHERE del=0 AND m.id=id_shedule LIMIT 1),0) END as rsale ');
  Form15.ZQuery1.SQL.add(',case WHEN active=0 then 0 ELSE coalesce((SELECT inet_sale FROM av_shedule_remote_sale_permition WHERE del=0 AND m.id=id_shedule LIMIT 1),0) END as isale ');
  //Form15.ZQuery1.SQL.add('
  Form15.ZQuery1.SQL.add('FROM ( ');
  Form15.ZQuery1.SQL.add('SELECT DISTINCT z.* FROM (select k.* ');
  Form15.ZQuery1.SQL.add(',coalesce((SELECT b.kod        from av_route AS b WHERE k.id_route=b.id ORDER BY b.del ASC, b.createdate DESC limit 1),'''') as kod_route ');
  Form15.ZQuery1.SQL.add(',coalesce((SELECT b.type_route from av_route AS b WHERE k.id_route=b.id ORDER BY b.del ASC, b.createdate DESC limit 1),0) as type_route ');
  Form15.ZQuery1.SQL.add(',coalesce((SELECT id_kontr FROM av_shedule_atp AS g WHERE k.id=g.id_shedule AND g.del=0 ORDER BY g.createdate DESC limit 1),0) as atpid ');
  Form15.ZQuery1.SQL.add(',coalesce((SELECT b.id_nas1    from av_route AS b WHERE k.id_route=b.id ORDER BY b.del ASC, b.createdate DESC limit 1),0) as nas1 ');
  Form15.ZQuery1.SQL.add(',coalesce((SELECT b.id_nas2    from av_route AS b WHERE k.id_route=b.id ORDER BY b.del ASC, b.createdate DESC limit 1),0) as nas2 ');
  Form15.ZQuery1.SQL.add(',coalesce((SELECT b.id_nas3    from av_route AS b WHERE k.id_route=b.id ORDER BY b.del ASC, b.createdate DESC limit 1),0) as nas3 ');
  Form15.ZQuery1.SQL.add('FROM ( ');
  Form15.ZQuery1.SQL.add('SELECT a.id,a.kod,trim(a.name_shedule) name_shedule,a.active,a.del,a.dateactive,a.typ_tarif,a.date_tarif,a.zakaz,a.id_past, a.id_route ');
  Form15.ZQuery1.SQL.add('FROM av_shedule AS a ');

  //||=====================  фильтр расписаний
   //filter_shedule=1;//фильтр РАСПИСАНИЙ межобластных и межгосударственных
  //filter_shedule=2;//фильтр РАСПИСАНИЙ междугородных
  //filter_shedule=3;//фильтр РАСПИСАНИЙ пригородных
  //filter_shedule=4;//фильтр РАСПИСАНИЙ междугородных и пригородных через
  //filter_shedule:=5;//фильтр РАСПИСАНИЙ межмуниципальных и пригородных НЕ через  ConnectINI

//||---------------------------------------------------------
//||=====================  фильтр расписаний
//||
  // фильтр по остановочному пункту
  IF CheckBox4.Checked then
    begin
    cnt:=0;
      If (trim(Edit3.Text)<>'') then
        begin
         sstr:=trim(Edit3.Text);
         while utf8pos(',',sstr)>0 do
begin
        stp:=utf8copy(sstr,1,utf8pos(',',sstr)-1);
        If trim(stp)<>'' then
          begin
           cnt:=cnt+1;
           sal:='f'+inttostr(cnt);
        ZQuery1.SQL.add('Join av_shedule_sostav AS '+sal+' ON '+sal+'.id_point='+ stp +' AND a.id='+sal+'.id_shedule AND '+sal+'.del=0 ');
          end;
        sstr:=utf8copy(sstr,utf8pos(',',sstr)+1,utf8length(sstr));
end;
        end;
    end;
  // фильтр по АТП
  //если форма вызывается из шаблонов
  If nkontr>0 then
    begin
    CheckBox5.Checked:=true;
    n_atp:=nkontr;
    Edit4.Text := skontr;
    end;
  //фильтр по перевозчикам
  IF CheckBox5.Checked then
    begin
      If (trim(Edit4.Text)<>'') AND (n_atp>0) then
        ZQuery1.SQL.add('Join av_shedule_atp AS g ON g.id_kontr='+ IntToStr(n_atp) +' AND a.id=g.id_shedule AND g.del=0 ');
      If (trim(Edit4.Text)='') then
        n_atp := 0;
    end;
  //фильтр по типу АТС
  If CheckBox6.Checked then
      begin
         ZQuery1.SQL.add('Join av_shedule_ats AS h ON a.id=h.id_shedule AND h.del=0 ');
         ZQuery1.SQL.add('Join av_spr_ats AS i ON i.id=h.id_ats AND i.type_ats='+ IntToStr(RadioGroup2.ItemIndex+1) +' AND i.del=0 ');
      end;

   //фильтр на удаленные
 If not(Form15.CheckBox7.Checked) then
   Form15.ZQuery1.SQL.add('WHERE a.del=0 ')
  else
   Form15.ZQuery1.SQL.add('WHERE a.del=2 ');

   //флаг первичной выборки
 If first_flag then
   begin
   Form15.ZQuery1.SQL.add(' AND a.datepo>current_date ');
   //Form15.ZQuery1.SQL.add(' AND a.active=1 ');
   first_flag:=false;
   end;
   //осуществлять контекстный поиск или нет
  //++++++++++++++++++++++++++++++++++++++++++++++++++++
 If filter_type=1 then
   begin
   ZQuery1.SQL.add('AND ((a.id='+stroka+') OR (substr(a.kod,1,'+inttostr(Utf8length(stroka))+')='+Quotedstr(stroka)+')) ');
   end;
 If filter_type=2 then
   begin
     stroka:=stringreplace(trim(stroka),#32,'% ',[])+'%';
   //If length(stroka)>2 then  showmessage(stroka);
   ZQuery1.SQL.add('AND ((UPPER(a.name_shedule) LIKE UPPER('+Quotedstr(stroka)+')) OR (UPPER(a.name_shedule) LIKE UPPER('+Quotedstr('%- '+stroka)+'))) ');
   end;


  If filter_shedule=0 then
    begin
    label2.Caption:='Список Расписаний';
    stmp:=' 1=1 ';
    end;

  If filter_shedule=1 then
    begin
  label2.Caption:='Расписания межобластные и межгосударственные';
   stmp:=' (z.type_route=2 or z.type_route=3) ';
    end;

   If filter_shedule=2 then
  begin
  label2.Caption:='Расписания межмуниципальные ';
  //Form15.ZQuery1.SQL.add('JOIN av_route AS b ON a.id_route=b.id AND b.del=0 AND (b.type_route=0 or b.type_route=1) ');
  //ZQuery1.SQL.add('and a.id in (select distinct w.id_shedule from av_shedule_sostav AS w where w.form=1 and w.id_point=815 AND a.id=w.id_shedule AND w.del=0) ');
  stmp:='  z.type_route=0 ';
  end;

   If filter_shedule=3 then
  begin
  label2.Caption:='Расписания пригордные ';
  //Form15.ZQuery1.SQL.add('JOIN av_route AS b ON a.id_route=b.id AND b.del=0 AND (b.type_route=0 or b.type_route=1) ');
  //ZQuery1.SQL.add('and a.id in (select distinct w.id_shedule from av_shedule_sostav AS w where w.form=1 and w.id_point=816 AND a.id=w.id_shedule AND w.del=0) ');
  stmp:='  z.type_route=1 ';
  end;

    If filter_shedule=4 then
  begin
  label2.Caption:='Расписания межмуниципальные и пригородные через '+ConnectINI[14];
  //Form15.ZQuery1.SQL.add('JOIN av_route AS b ON a.id_route=b.id AND b.del=0 AND (b.type_route=0 or b.type_route=1) ');
  ZQuery1.SQL.add('and a.id in (select distinct w.id_shedule from av_shedule_sostav AS w where w.id_point='+ConnectINI[14]+' AND a.id=w.id_shedule AND w.del=0) ');
  stmp:='  (z.type_route=0 or z.type_route=1) ';
  end;

    If filter_shedule=5 then
  begin
  label2.Caption:='Расписания межмуниципальные и пригородные НЕ через '+ConnectINI[14];
  ZQuery1.SQL.add(' and a.id not in (select distinct(id_shedule) FROM av_shedule_sostav AS w where id_point='+ConnectINI[14]+' AND a.id=w.id_shedule AND del=0)  ');
  stmp:=' (z.type_route=0 or z.type_route=1) ';
  end;

  // фильтр по АКТИВНЫЙ/НЕАКТИВНЫЙ
    If CheckBox3.Checked then
      begin
        ZQuery1.SQL.add(' AND a.active=' + intToStr(RadioGroup1.ItemIndex));
      end;

   Form15.ZQuery1.SQL.add(') k ) z ');

     //фильтр по маршруту
    If CheckBox1.Checked then
      begin
      If (trim(Edit2.Text)<>'') AND (n_idroute>0) then
        ZQuery1.SQL.add(' AND id_route=' + intToStr(n_idroute));
      If (trim(Edit2.Text)='') then
        n_idroute := 0;
      end;
    // фильтр по типу маршрута
    If CheckBox2.Checked then
     begin
      If (trim(ComboBox1.Text)<>'') then
        begin
         ZQuery1.SQL.add(' AND id_route in (SELECT b.id FROM av_route b WHERE b.del=0 and b.type_route=' + intToStr(ComboBox1.ItemIndex)+') ');
        end;
     end;

    //Form15.ZQuery1.SQL.add(') z ');
    Form15.ZQuery1.SQL.add(' WHERE 1=1 ');
    //добавляем фильтр по типу расписаний
    Form15.ZQuery1.SQL.add(' AND '+stmp);

    Form15.ZQuery1.SQL.add(') m ) g');

     //фильтр на наличие брони
 If Form15.CheckBox8.Checked then
    Form15.ZQuery1.SQL.add('AND g.bron>0 ');
     //фильтр на наличие фиксированной цены
 If Form15.CheckBox10.Checked then
    Form15.ZQuery1.SQL.add('AND g.price>0 ');
      //фильтр на наличие измененного тарифа
 If Form15.CheckBox9.Checked then
    Form15.ZQuery1.SQL.add('AND g.tarif>0 ');

    //Form15.ZQuery1.SQL.add('ORDER BY '+orderby);
    Form15.ZQuery1.SQL.add('ORDER BY id');
  If sort_direction=1 then
           ZQuery1.SQL.add(' ASC')
      else ZQuery1.SQL.add(' DESC');

  If orderby<>'dateactive' then
           ZQuery1.SQL.add(',dateactive DESC;')
      else ZQuery1.SQL.add(' ;');

  //-конец запроса :-)
  //showmessage(ZQuery1.SQL.Text);//$
  try
   ZQuery1.open;
  except
     panel2.Visible:=false;
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;

  panel2.Visible:=false;

   if Form15.ZQuery1.RecordCount=0 then
      begin
        Form15.ZQuery1.close;
        Form15.ZConnection1.Disconnect;
        exit;
      end;
   label1.Caption:='Найдено всего: '+inttostr(Form15.ZQuery1.RecordCount);
   setlength(m_route,0,0);
   // Создаем массив
   setlength(m_route,ZQuery1.RecordCount,mas_size);
   for n:=0 to  Form15.ZQuery1.RecordCount-1 do
    begin
      //Маршруты
   //   m_route[n,0]:=trim(Form15.ZQuery1.FieldByName('id_route').asString); //id маршрута
      m_route[n,1]:=trim(Form15.ZQuery1.FieldByName('kod_route').asString); //код маршрута
      m_route[n,2]:=trim(Form15.ZQuery1.FieldByName('name_route').asString); //наименование маршрута
      if form15.ZQuery1.FieldByName('type_route').asInteger=0 then m_route[n,3]:=cMezhgorod;
      if form15.ZQuery1.FieldByName('type_route').asInteger=1 then m_route[n,3]:=cPrigorod;
      if form15.ZQuery1.FieldByName('type_route').asInteger=2 then m_route[n,3]:=cKray;
      if form15.ZQuery1.FieldByName('type_route').asInteger=3 then m_route[n,3]:=cGos;
      m_route[n,4]:='1'; //Тип 1-маршрут,2-расписание
      m_route[n,5]:=trim(Form15.ZQuery1.FieldByName('active').asString); //Тип 0-неактивно,1-активно
      //Расписания
      m_route[n,6]:=trim(Form15.ZQuery1.FieldByName('id').asString); //id расписания
      m_route[n,7]:=trim(Form15.ZQuery1.FieldByName('kod').asString); //код расписания
      m_route[n,8]:=trim(Form15.ZQuery1.FieldByName('name_shedule').asString); //наименование расписания
      m_route[n,9]:=Form15.ZQuery1.FieldByName('personal').asString; //передовать персональные данные - признак;
      m_route[n,10]:='2'; //Тип 1-маршрут,2-расписание
      m_route[n,11]:='0'; //Тип 0-неактивно,1-активно
      m_route[n,12]:=Form15.ZQuery1.FieldByName('del').asString;  //признак удалено или нет
      m_route[n,13]:=Form15.ZQuery1.FieldByName('dateactive').asString; //дата активности расписания
      m_route[n,14]:=Form15.ZQuery1.FieldByName('zakaz').asString; //заказной - признак
      m_route[n,15]:=Form15.ZQuery1.FieldByName('tarif').asString; //ручной тариф - признак
      m_route[n,16]:=Form15.ZQuery1.FieldByName('id_past').asString; //id предыдущего расписания
      m_route[n,17]:=Form15.ZQuery1.FieldByName('bron').asString; //количество записей брони на это расписание
      m_route[n,18]:=Form15.ZQuery1.FieldByName('price').asString; //количество записей фиксированной тарифной стоимости билетов и багажа
      m_route[n,19]:=Form15.ZQuery1.FieldByName('rsale').asString; //продавать удаленку
      m_route[n,20]:=Form15.ZQuery1.FieldByName('isale').asString; //продавать через инет
      m_route[n,21]:=Form15.ZQuery1.FieldByName('tel').asString; //обязательный телефон
      m_route[n,22]:=Form15.ZQuery1.FieldByName('vpd').asString; //запрет продажи воинских
      m_route[n,23]:=Form15.ZQuery1.FieldByName('invis').asString; //невидимое расписание
      m_route[n,24]:=Form15.ZQuery1.FieldByName('atpid').asString; //перевозчик код
      m_route[n,25]:=Form15.ZQuery1.FieldByName('atpname').asString; //перевозчик имя
      form15.ZQuery1.Next;
    end;

   //ЗАПРОС на расписания, у которых тариф рассчитан руками
   //ZQuery1.SQL.clear;
   //ZQuery1.SQL.add('select id from av_shedule WHERE del=0 AND id IN (Select id_shedule FROM av_shedule_tarif WHERE del=0);');
   //try
   //  ZQuery1.open;
   //except
   //  showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
   //  ZQuery1.Close;
   //  Zconnection1.disconnect;
   //  exit;
   //end;
   //If Zquery1.RecordCount>0 then
   //  begin
   //    for m:=1 to Zquery1.RecordCount do
   //      begin
   //        for n:=low(m_route) to high(m_route) do
   //          begin
   //            //находим и помечаем id расписания без тарифа
   //            If strtoint(m_route[n,6])=ZQuery1.FieldByName('id').AsInteger then
   //              m_route[n,15]:='1';
   //          end;
   //        Zquery1.Next;
   //      end;
   //  end;

   // Заполняем stringgrid
   Form15.StringGrid1.RowCount:=length(m_route)+1;
   //form15.StringGrid1.Columns[3].ValueChecked:='ДА';
   //form15.StringGrid1.Columns[3].ValueUnchecked:='НЕТ';
   for n:=0 to length(m_route)-1 do
    begin
      Form15.StringGrid1.Cells[0,n+1]:=m_route[n,6];
      Form15.StringGrid1.Cells[1,n+1]:=m_route[n,7];
      Form15.StringGrid1.Cells[2,n+1]:=m_route[n,8];
      Form15.StringGrid1.Cells[3,n+1]:=m_route[n,5]; //IFTHEN(m_route[n,5]='1','ДА','НЕТ'); //активность расписания
      Form15.StringGrid1.Cells[4,n+1]:=m_route[n,12];
      Form15.StringGrid1.Cells[5,n+1]:=m_route[n,13]; //дата активации
      //If m_route[n,14]='1' then  Form15.StringGrid1.Cells[6,n+1]:= '*'; //заказной
      Form15.StringGrid1.Cells[6,n+1]:= m_route[n,14]; //заказной
      If m_route[n,16]<>'0' then
      Form15.StringGrid1.Cells[7,n+1]:=m_route[n,16]; //id текущего расписания

      If trim(m_route[n,9])='1' then Form15.StringGrid1.Cells[8,n+1]:='1' else Form15.StringGrid1.Cells[8,n+1]:='0'; //ПДП
      If trim(m_route[n,19])='1' then Form15.StringGrid1.Cells[10,n+1]:='1' else Form15.StringGrid1.Cells[10,n+1]:='0'; //удаленка
      If trim(m_route[n,20])='1' then Form15.StringGrid1.Cells[11,n+1]:='1' else Form15.StringGrid1.Cells[11,n+1]:='0'; //интернет
      If (m_route[n,15]='1') or (m_route[n,18]='1')  then Form15.StringGrid1.Cells[9,n+1]:='1';
      If m_route[n,21]='1' then Form15.StringGrid1.Cells[12,n+1]:='1' else Form15.StringGrid1.Cells[12,n+1]:='0'; //телеф
      If m_route[n,22]='1' then Form15.StringGrid1.Cells[13,n+1]:='1' else Form15.StringGrid1.Cells[13,n+1]:='0'; //воин
      If m_route[n,23]='1' then Form15.StringGrid1.Cells[14,n+1]:='1' else Form15.StringGrid1.Cells[14,n+1]:='0'; //невидимые расписания

    end;

   //form15.StringGrid1.Repaint;
   Form15.ZQuery1.Close;
   Form15.Zconnection1.disconnect;

   //Form15.StringGrid1.Refresh;
  end;
  form15.StringGrid1.ColWidths[9]:=0;
  flagupdate:=false;
end;

procedure TForm15.BitBtn1Click(Sender: TObject);
begin
 //Создаем новую запись
  flag_edit_shedule := 1;
  If (Form15.StringGrid1.RowCount>1) AND (trim(Form15.StringGrid1.Cells[0,form15.StringGrid1.Row])<>'') then
  begin
  if dialogs.MessageDlg('Перенести данные с текущего РАСПИСАНИЯ в новое ?',mtConfirmation,[mbYes,mbNO], 0)=6 then
   begin
    flag_edit_shedule := 3;
    //if trim(Form15.StringGrid1.Cells[9,form15.StringGrid1.Row])='1' then
      //If dialogs.MessageDlg('Перенести данные по фиксированному тарифу в новое РАСПИСАНИЕ?',mtConfirmation,[mbYes,mbNO], 0)=6 then
    //flag_edit_shedule := 4;
  end;
  end;

  form16:=Tform16.create(self);
  form16.ShowModal;
  FreeAndNil(form16);
  datatyp := 0;
  form15.UpdateGrid(datatyp,'');
  Form15.StringGrid1.Row:=form15.StringGrid1.RowCount-1;
end;

//**********************   УДАЛИТЬ  *************************************************
procedure TForm15.BitBtn2Click(Sender: TObject);
begin
  with FOrm15 do
  begin
  // Удаляем расписание
  if (form15.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Нет записей для удаления !');
       exit;
     end;

  if not(dialogs.MessageDlg('Вы действительно хотите удалить текущее РАСПИСАНИЕ ?',mtConfirmation,[mbYes,mbNO], 0)=6) then exit;

  //**************** проверка на возможность удаления записи  *****************************************
 // sstr :='av_shedule.id,av_shedule_sostav.id_shedule,av_shedule_atp.id_shedule,av_shedule_ats.id_shedule,av_shedule_sezon.id_shedule';
 // resF := DelCheck(Form15.StringGrid1, 0, Form15.ZConnection1, Form15.ZQuery1, sstr);
 // IF resF<>1 then exit;

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
     //помачаем на удаление запис  РАСПИСАНИЯ
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи  СОСТАВ
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_sostav SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи АТП
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_atp SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи АТC
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_ats SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи СЕЗОННОСТИ
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_sezon SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи ТАРИФОВ
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_tarif SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи УСЛУГ расписания
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_uslugi SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи ЛЬГОТ расписания
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_lgot SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи Запрещенных пользователей расписания
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_denyuser SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи БРОНИ
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_bron SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //помачаем на удаление записи тарифной стоимости билетов и багажа расписания, введенных вручную
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_price SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_fio SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_tel SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;

     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_voin_deny SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;
     //
     form15.ZQuery1.SQL.Clear;
     form15.ZQuery1.SQL.add('UPDATE av_shedule_invisible SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+' and del=0;');
     form15.ZQuery1.ExecSQL;

    // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
 end;
   datatyp := 0;
     form15.UpdateGrid(datatyp,'');
end;

//  добавить фильтр по маршруту
procedure TForm15.BitBtn3Click(Sender: TObject);
begin
  form17:=Tform17.create(self);
  form17.ShowModal;
  FreeAndNil(form17);
  // Заполняем поля для МАРШРУТОВ
  if (result_id_route='') then exit;
     n_idroute := 0;
     n_idroute := StrToInt(result_id_route);
  with Form15 do
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

     //Делаем запрос к населенным пунктам
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('select a.id,b.name AS name1,c.name AS name2,d.name AS name3,a.kod,a.type_route from av_route AS a');
      ZQuery1.SQL.add('Left JOIN av_spr_locality AS b ON a.id_nas1=b.id AND b.del=0');
      ZQuery1.SQL.add('Left JOIN av_spr_locality AS c ON a.id_nas2=c.id AND c.del=0');
      ZQuery1.SQL.add('Left JOIN av_spr_locality AS d ON a.id_nas3=d.id AND d.del=0');
      ZQuery1.SQL.add('WHERE a.id='+intToStr(n_idroute)+' AND a.del=0;');
//      showmessagealt(ZQuery1.SQL.Text);
     try
      ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
      ZQuery1.close;
      ZConnection1.disconnect;
      exit;
     end;
     If ZQuery1.RecordCount=1 then
      begin
     Edit2.Text:=ZQuery1.FieldByName('name1').asString+' - '+ZQuery1.FieldByName('name2').asString;
     if not(trim(ZQuery1.FieldByName('name3').asString)='') then Edit2.Text:=Edit2.Text+' - '+ZQuery1.FieldByName('name3').asString;
      end
     else
       showmessagealt('ОШИБКА Целостности данных !');

     ZQuery1.Close;
     ZConnection1.Disconnect;
   end;
end;

procedure TForm15.BitBtn4Click(Sender: TObject);
begin
  form15.close;
end;


procedure TForm15.BitBtn12Click(Sender: TObject);
var
  n:integer;
begin
  //Редактируем запись
  flag_edit_shedule:=2;
  n:= form15.StringGrid1.Row;
  form16:=Tform16.create(self);
  form16.ShowModal;
  FreeAndNil(form16);
  updategrid(datatyp,ss);
  form15.StringGrid1.Row:=n;
end;

//установка неснимаемой брони
procedure TForm15.BitBtn13Click(Sender: TObject);
begin
  with FOrm15 do
   begin
   Stringgrid1.Enabled:=false;
    Panel1.Visible:=true;
    Edit5.Text:='';
    label8.Caption:='';
    label10.Caption:='';
    label12.Caption:='';
    label14.Caption:='';

    // Подключаемся к серверу
    If not(Connect2(Zconnection1, flagProfile)) then
      begin
       showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
       exit;
      end;
   // Запрос маршрутов и расписаний
   ZQuery1.SQL.clear;
   ZQuery1.SQL.add('SELECT a.*,(SELECT name FROM av_users WHERE del=0 AND a.id_user=id ORDER BY createdate DESC LIMIT 1) as redactor,');
   ZQuery1.SQL.add('(SELECT name FROM av_users WHERE del=0 AND a.id_user_first=id ORDER BY createdate DESC LIMIT 1) as creator');
   ZQuery1.SQL.add('FROM av_shedule_hard_bron a WHERE a.del=0 AND a.id_shedule='+(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+';');
   //showmessage(ZQuery1.SQL.Text);//$
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
     Stringgrid1.Enabled:=false;
    exit;
  end;

   if Form15.ZQuery1.RecordCount>0 then
      begin
        Edit5.Text:=ZQuery1.FieldByName('seats').AsString;
        label8.Caption:=trim(ZQuery1.FieldByName('creator').AsString);
        label10.Caption:=FormatDateTime('hh:nn dd/mm/yyyy',ZQuery1.FieldByName('createdate_first').AsDateTime);
        label12.Caption:=trim(ZQuery1.FieldByName('redactor').AsString);
        label14.Caption:=FormatDateTime('hh:nn dd/mm/yyyy',ZQuery1.FieldByName('createdate').AsDateTime);
      end;
   end;
   Form15.ZQuery1.close;
   Form15.ZConnection1.Disconnect;
   form15.Edit5.SetFocus;
end;


//**************** изменение СТРОКИ БРОНИ *************************
procedure TForm15.EditCheck();
VAR
  ss,snum,sss : string;
  n,m,k,comma,tn1,tn2,j,i,bis: integer;
  ar_temp:array of integer;
begin
  With Form15 do
  begin
    If trim(edit5.Text)='' then exit;
    sS := edit5.Text;
   k:=0;
   comma := 0;

   //проверка на корректность каждый символ
   For n:=1 to length(ss) do
    begin
     //если первый символ запятая, удаляем
     If (sS[n]=',') then
       begin
         If (k=0) then sS[n] := '-';
         If comma=1 then sS[n] := '-';
         If (comma=0) AND (k>0) then
           begin
             comma := 1;
             k:=0;
             end;
         continue;
       end;
     If not(sS[n] in ['0'..'9',',']) then
       begin
           ss[n]:='-';
           continue;
       end;
     If (sS[n] in ['0'..'9']) then
       begin
         If k>1 then sS[n] := '-';
         If k<2 then
           begin
             k := k + 1;
             comma := 0;
           end;
       end;
    end;
   edit5.Text:= '';
   snum:='';
   If (length(sS)>0) AND (sS[length(sS)]<>',') then sS:=sS+',';
 /// очистка строки брони от неправильных символов   // подсчет количества мест брони
   for n:=1 to length(sS) do
     begin
       If sS[n]='-' then continue;
       If (sS[n]=',') and (trim(snum)<>'') then
        begin
          setlength(ar_temp,length(ar_temp)+1);
        try
         ar_temp[length(ar_temp)-1]:=strtoint(snum);
        except
        showmessagealt('ОШИБКА преобразования в целое !'+#13+snum);
        continue;
        end;
          //showmessage(snum);
          snum:='';
        end
       else
       begin
        snum:=snum+sS[n];
       end;
     end;

   bis := High(ar_temp);
   k := bis div 2;
  while k > 0 do
   begin
     for i:= 0 to bis-k do
     begin
       j := i;
       while (j >= 0) and (ar_temp[j] > ar_temp[j+k]) do
       begin
         tn1:= ar_temp[j];
         ar_temp[j] := ar_temp[j+k];
         ar_temp[j+k] := tn1;
         if j > k then
           Dec(j, k)
         else
           j:= 0;
       end; // {end while]

      //sss:='';
      // for n:=0 to length(ar_temp)-1 do
      // begin
      //    sss:=sss+inttostr(n)+'- '+inttostr(ar_temp[n])+#13;
      // end;
      // showmessage(inttostr(i)+','+inttostr(j)+','+inttostr(k)+#13+sss);
    end; // { end for}
    k := k div 2;
  end;  // {end while}

   edit5.Text:='';
   for n:=0 to length(ar_temp)-1 do
     begin
       edit5.text:=edit5.text+inttostr(ar_temp[n])+',';
     end;
end;
end;

// сохранить данные неснимаемой брони
procedure TForm15.BitBtn14Click(Sender: TObject);
var
  ss:string;
begin
   With Form15 do
  begin
   EditCheck();
  If trim(Edit5.Text)<>'' then
    begin
     //проверка ввода мест брони
  sS := Edit5.text;
  If ss[length(sS)]=',' then
  sS:=copy(sS,1,length(sS)-1); //убираем последнюю запятую
  Edit5.Text:= sS;
     end;

   //Сохраняем данные
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
  //Маркируем запись на удачение если режим редактирования
      ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_shedule_hard_bron SET del=1,id_user='+inttostr(id_user)+',createdate=now() WHERE id_shedule='+form15.StringGrid1.Cells[0,form15.StringGrid1.row]+' and del=0;');
          //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.ExecSQL;

   If trim(edit5.Text)<>'' then
     begin
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('INSERT INTO av_shedule_hard_bron(createdate, id_user, del, createdate_first, id_user_first, id_shedule, seats) VALUES (now(),');
   ZQuery1.SQL.add(inttostr(id_user)+',0,');
   If trim(label8.Caption)='' then ZQuery1.SQL.add('now(),'+inttostr(id_user)+',')
   else ZQuery1.SQL.add('null,null,');

   ZQuery1.SQL.add(form15.StringGrid1.Cells[0,form15.StringGrid1.row]+','+QuotedSTR(trim(Edit5.text))+');');
   //showmessage(ZQuery1.SQL.Text);//$
   ZQuery1.ExecSQL;
   end;

//  showmessagealt(ZQuery1.SQL.Text);

  // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  showmessagealt('Данные успешно сохранены !');
  Panel1.Visible:=false;
  Stringgrid1.Enabled:=true;
  Stringgrid1.SetFocus;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
end;
end;

//***********************************************    кнопка ФИЛЬТРАЦИИ ***************************************
procedure TForm15.BitBtn10Click(Sender: TObject);
begiN
  with form15 do
begin
  If GroupBox1.Height>45 then
  begin
  //Stringgrid1.Height:=665;
  BitBtn11.visible:=false;
  BitBtn8.visible:=false;
  //GroupBox1.Top:=696;
  GroupBox1.Height:=40;
  end
  else
  begin
    //Stringgrid1.Height:=665;//525
    //BitBtn10.Top:=560;
    //GroupBox1.Top:= 545;
    GroupBox1.Height:=183;
    BitBtn11.visible:=true;
  BitBtn8.visible:=true;
  end;
end;
end;

procedure TForm15.BitBtn11Click(Sender: TObject);
begin
  with form15 do
   begin
    filter_shedule:=0;
            CheckBox1.Checked:= false;
            CheckBox2.Checked:= false;
            CheckBox3.Checked:= false;
            CheckBox4.Checked:= false;
            CheckBox5.Checked:= false;
            CheckBox6.Checked:= false;
            CheckBox7.Checked:= false;
            CheckBox8.Checked:= false;
            Edit1.Visible:=false;
            Edit1.Text:='';
            Edit2.Text:='';
            Edit3.Text:='';
            Edit4.Text:='';
            filtr := false;
            updategrid(datatyp,'');
   end;
end;


//********************************* Выбрать ********************************
procedure TForm15.BitBtn5Click(Sender: TObject);
begin
   if (form15.StringGrid1.RowCount>1) AND (trim(form15.StringGrid1.Cells[2,form15.StringGrid1.Row])<>'') then
    begin
     result_name_shedule := form15.StringGrid1.Cells[0,form15.StringGrid1.row];
     result_shedule :=trim(form15.StringGrid1.Cells[2,form15.StringGrid1.row]);
     //form15.close;
    end;
end;


// добавляем фильтр по остановочному пункту
procedure TForm15.BitBtn6Click(Sender: TObject);
begin
  form9:=Tform9.create(self);
  form9.ShowModal;
  FreeAndNil(form9);
  //остановочный пункт
  if (result_point_id='') then exit;
   form15.Edit3.Text:=form15.Edit3.Text+result_point_id+',';
   with Form15 do
   begin
   // Подключаемся к серверу
   //If not(Connect2(Zconnection1, flagProfile)) then
   //  begin
   //   showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
   //   exit;
   //  end;
   //
   //   // Определяем данные
   //   ZQuery1.SQL.clear;
   //   ZQuery1.SQL.add('select name from av_spr_point where id='+intToStr(n_idPoint)+' and del=0;');
   //   try
   //   ZQuery1.open;
   //  except
   //   showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
   //   ZQuery1.close;
   //   ZConnection1.disconnect;
   //   exit;
   //   end;
   //  if ZQuery1.RecordCount=1 then
   //   begin
   //   Edit3.Text:=trim(ZQuery1.FieldByName('name').asString);
   //   end
   //  else
   //    showmessagealt('ОШИБКА Целостности данных !');

     //ZQuery1.Close;
     //ZConnection1.Disconnect;
   end;
end;

procedure TForm15.BitBtn7Click(Sender: TObject);
begin
   //Добавляем контрагента
  result_kontr_id:='';
  formsk:=Tformsk.create(self);
  formsk.ShowModal;
  FreeAndNil(formsk);
  if  trim(result_kontr_id)='' then exit;
  ///=========================================================================
  ///   Определяем перевозчика и список АТС
   n_atp := 0;
   n_atp := StrToInt(result_kontr_id);
    With Form15 do
     begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

     //Проверяем наличие договора перевозки
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('SELECT DISTINCT a.name,a.id FROM av_spr_kontragent as a,av_spr_kontr_dog as b ');
      ZQuery1.SQL.add('WHERE a.id = b.id_kontr and a.del=0 and b.del=0 and substr(trim(b.viddog),length(trim(b.viddog)),1)='+quotedstr('2')+' and a.id='+intToStr(n_atp)+';');   //and b.datapog>=current_date
    try
     // showmessagealt(ZQuery1.SQL.Text);
      ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
      ZQuery1.close;
      ZConnection1.disconnect;
      exit;
     end;
     if ZQuery1.RecordCount=0 then
      begin
        showmessagealt('Для выбранного контрагента отсутствует договор перевозки !'+#13+'Добавить данного контрагента в список невозможно !');
        n_atp := 0;
      end;
      if ZQuery1.RecordCount=1 then
      begin
      Edit4.Text:=trim(ZQuery1.FieldByName('name').asString);
      end
     else
       showmessagealt('ОШИБКА Целостности данных !');

     ZQuery1.Close;
     ZConnection1.Disconnect;
   end;
end;

procedure TForm15.BitBtn8Click(Sender: TObject);
begin
  filtr := true;
  updategrid(datatyp,ss);
end;


  //*********************  БРОНЬ ************************************
procedure TForm15.BitBtn9Click(Sender: TObject);
begin
  If trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row])='' then exit;
  form_bron:=Tform_bron.create(self);
  form_bron.ShowModal;
  FreeAndNil(form_bron);
  //form15.UpdateGrid();

end;


procedure TForm15.CheckBox1Change(Sender: TObject);
begin
  If Form15.CheckBox1.Checked then
   begin
     Form15.Edit2.Enabled:=true;
     Form15.BitBtn3.Enabled:=true;
     Form15.BitBtn3.SetFocus;
     Form15.BitBtn8.Enabled:=true;
   end
  else
  begin
    Form15.Edit2.Enabled:=false;
    Form15.BitBtn3.Enabled:=false;
  end;
end;

procedure TForm15.CheckBox2Change(Sender: TObject);
begin
  If Form15.CheckBox2.Checked then
   begin
     Form15.ComboBox1.Enabled:=true;
     Form15.ComboBox1.SetFocus;
     Form15.BitBtn8.Enabled:=true;
   end
  else
    Form15.ComboBox1.Enabled:=false;
end;

procedure TForm15.CheckBox3Change(Sender: TObject);
begin
  If Form15.CheckBox3.Checked then
   begin
     Form15.RadioGroup1.Enabled:=true;
     Form15.RadioGroup1.SetFocus;
     Form15.BitBtn8.Enabled:=true;
   end
  else
    Form15.RadioGroup1.Enabled:=false;
end;

procedure TForm15.CheckBox4Change(Sender: TObject);
begin
  If Form15.CheckBox4.Checked then
   begin
     Form15.Edit3.Enabled:=true;
     Form15.BitBtn6.Enabled:=true;
     Form15.BitBtn6.SetFocus;
     Form15.BitBtn8.Enabled:=true;
   end
  else
  begin
    Form15.Edit3.Enabled:=false;
    Form15.BitBtn6.Enabled:=false;
  end;
end;

procedure TForm15.CheckBox5Change(Sender: TObject);
begin
  If Form15.CheckBox5.Checked then
   begin
     Form15.Edit4.Enabled:=true;
     Form15.BitBtn7.Enabled:=true;
     Form15.BitBtn7.SetFocus;
     Form15.BitBtn8.Enabled:=true;
   end
  else
  begin
    Form15.Edit4.Enabled:=false;
    Form15.BitBtn7.Enabled:=false;
  end;
end;

procedure TForm15.CheckBox6Change(Sender: TObject);
begin
  If Form15.CheckBox6.Checked then
   begin
     Form15.RadioGroup2.Enabled:=true;
     Form15.RadioGroup2.SetFocus;
     Form15.BitBtn8.Enabled:=true;
   end
  else
    Form15.RadioGroup2.Enabled:=false;
end;

// показываеть \ непоказывать удаленных
procedure TForm15.CheckBox7Change(Sender: TObject);
begin
  //Form15.Updategrid();
end;




//фильтрация грида на основе контекстного поиска
procedure TForm15.Edit1Change(Sender: TObject);
  var
  n:integer=0;
begin
  with FOrm15 do
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


procedure TForm15.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SetLength(m_route,0,0);
  m_route := nil;
end;

procedure TForm15.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  With form15 do
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
       // showmessage('1-'+inttostr(key));//$
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
  //если на редактировании брони
  If Panel1.Visible then
    begin
      // ESC
     If key=27 then
        begin
       // showmessage('2-'+inttostr(key));//$
          Panel1.Visible:=false;
          Stringgrid1.Enabled:=true;
          key:=0;
          exit;
       end;
    //F2 - Сохранить бронь
    if (Key=113) then
      begin
       key:=0;
       form15.BitBtn14.Click;
       exit;
      end;
    end;

    // Enter - поиск
    //if (Key=13) and (form15.Edit1.Focused) then Form15.ToolButton8.Click;
    //F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[F9] - Бронь'+#13+'[F10] - Бронь неснимаемая'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');

    //F4 - Изменить
    if (Key=115) and (form15.bitbtn12.enabled=true) then form15.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (form15.bitbtn1.enabled=true) then form15.BitBtn1.Click;
    //F8 - Удалить
    if (Key=119) and (form15.bitbtn2.enabled=true) then form15.BitBtn2.Click;
    //F9 - Открыть бронь расписания
    if (Key=120) and (form15.bitbtn9.enabled=true) then form15.BitBtn9.Click;
    //F10 - Неснимаемая бронь расписания
    if (Key=121) and (form15.bitbtn13.enabled=true) then form15.BitBtn13.Click;

    // ESC
    if (Key=27) then
      begin
       //*сброс фильтра
        If filtr then
          begin
            CheckBox1.Checked:= false;
            CheckBox2.Checked:= false;
            CheckBox3.Checked:= false;
            CheckBox4.Checked:= false;
            CheckBox5.Checked:= false;
            CheckBox6.Checked:= false;
            CheckBox7.Checked:= false;
            CheckBox8.Checked:= false;
            Edit2.Text:='';
            Edit3.Text:='';
            Edit4.Text:='';
            filtr := false;
            updategrid(datatyp,ss);
          end
        else form15.Close;
      end;

    // ПРОБЕЛ - выбрать
    if (Key=32)  and  (form15.StringGrid1.Focused) then form15.BitBtn5.Click;
  { // ENTER - фильтр
    if (Key=13)  and  (form15.BitBtn3.Focused) then form15.BitBtn3.Click;
    // ENTER - фильтр
    if (Key=13)  and  (form15.BitBtn6.Focused) then form15.BitBtn6.Click;
    // ENTER - фильтр
    if (Key=13)  and  (form15.BitBtn7.Focused) then form15.BitBtn7.Click;
    }
     // Контекcтный поиск
   if (Edit1.Visible=false) AND (stringgrid1.Focused) then
     begin
   //  showmessage('3-'+inttostr(key));//$
       If (get_type_char(key)>0) or (key=8) or (key=46) or (key=96) then //8-backspace 46-delete 96- numpad 0
       begin
         Edit1.text:='';
         Edit1.Visible:=true;
         Edit1.SetFocus;
       end;
     end;
    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=120) or (Key=27) or (Key=13)  then Key:=0;
   end;
  // showmessage(inttostr(key));
  // key:=0;
end;



//--------------- ОТРИСОВКА ГРИДА  -----------------------------------------------
procedure TForm15.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
const
  cInactive = $CDD0D8;
  cDlt = $C6D6E6;
  //sDLt := $E8E8E8;
  cZkz = $BBEDBB;
  kolons = [0,2,5,7];
var
   //sDlt : Tcolor;
   n:integer;
   //kolons : Set of 0, 2, 5, 7;

begin
   if length(m_route)<1 then exit;
   with Sender as TStringGrid, Canvas do
    begin
    //закрашиваем все белым
       Brush.Color:=clWhite;
       FillRect(aRect);

       if Cells[aCol, aRow]='1' then
       begin
            //ПДП
            if (acol=8) then  brush.Color:=clMaroon;

            //Доступность расписания для удаленной продажи
            if (acol=10) then brush.Color:=clGreen;

               //form1.StringGrid1.Canvas.TextRect(aRect,arow+5,5,form1.StringGrid1.Cells[aCol, aRow]);
                 //DrawCellsAlign(form1.StringGrid1,2,2,form1.StringGrid1.Cells[aCol, aRow],aRect);

           //Доступность расписания для ИНТЕРНЕТ продажи
            if (acol=11) then brush.Color:=clOlive;

           //Обязательный телефон для продажи
            if (acol=12) then brush.Color:=clPurple;

          //Воинские ВПД
            if (acol=13) then brush.Color:=$001678FD;

            //невидимые расписания
            If (aCol=14) then brush.Color:=clSkyBlue;

             //закрашиваем клетку
         If (acol=8) or (acol=10) or (acol=11) or (acol=12) or (acol=13) or (acol=14) then
          begin
           FillRect(aRect);
           pen.Width:=1;
           pen.Color:=clGray;
           MoveTo(aRect.left,aRect.bottom-1);
           LineTo(aRect.right,aRect.Bottom-1);
          end;
      end;

      //НЕАКТИВНЫЕ
       if Cells[3, aRow]='0' then
        begin
          Brush.Color:= cInactive;
          FillRect(aRect);
         end;
        //ЗАКАЗНОЙ
       if Cells[6, aRow]='1' then
        begin
          Brush.Color:= cZkz;
          FillRect(aRect);
         end;
     //УДАЛЕННЫЕ
     If Cells[4, aRow]='2' then
       begin
         Brush.Color:= cDlt;
         FillRect(aRect);
       end;
     //красный цвет для расписаний с ручным изменением тарифа
     //For n:=low(m_route) to high(m_route) do
     // begin
     //   If (m_route[n,6]=Cells[0,aRow]) AND (aRow>0) and (m_route[n,15]='1') then
     //  begin
     //    Brush.Color:= $ABABFF;
     //    FillRect(aRect);
     //    break;
     //  end;
     // end;


     if (gdSelected in aState) then
           begin
            pen.Width:=4;
            pen.Color:=clRed;
            MoveTo(aRect.left,aRect.bottom-1);
            LineTo(aRect.right,aRect.Bottom-1);
            MoveTo(aRect.left,aRect.top-1);
            LineTo(aRect.right,aRect.Top);
            Font.Color := clBlue;
            font.Size:=14;
            Font.Style:=[fsBold];
           end
         else
          begin
            Font.Style:=[fsBold];
            Font.Color := clBlack;
            font.Size:=12;
          end;
      //если строчки
      If (aRow>0) then
        begin
          case aCol of
          0: font.Size:=11; //id расписания
          3: font.Size:=10; //признак активности
          5: font.Size:=10; //дата активации
          end;
      //выводим текст на всех полях
      If (aCol in kolons) then TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);

      //Выводим заказной
      If (aCol=6) and (Cells[aCol,aRow]='1') then
        begin
          Font.Size:=20;
          Font.Style:=[fsBold];
          Font.Color := clRed;
          TextOut(aRect.Left+10, aRect.Top+5,'3');
        end;
        //Выводим НЕКТИВНЫЙ
      If (aCol=3) then
        begin
          Font.Color := clRed;
          if (Cells[aCol,aRow]='1') then
            begin
             Font.Size:=12;
             Font.Style:=[fsBold];
             TextOut(aRect.Left+5, aRect.Top+5,'*')
            end
          else
            begin
              Font.Size:=20;
              Font.Style:=[fsBold];
             TextOut(aRect.Left+5, aRect.Top+5,'!')
            end;
        end;

      //добавляем информацию
      if (aRow>0) and (aCol=2) then
       begin
          Font.Size:=10;
          Font.Style:=[];
          Font.Color := clBlue;
           For n:=low(m_route) to high(m_route) do
             begin
               //о маршрутах
               If (m_route[n,6]=Cells[0,aRow]) then
                 begin
                 //ширина текста наименования расписания canvas.TextWidth(m_route[n,8]);
                   font.color:= clNavy;
                   //если в наименовании расписания меньше 40 символов
                  if utf8length(m_route[n,8])<40 then
                    begin
                    //если есть бронь
                   if m_route[n,17]='1' then
                      TextOut(aRect.right - canvas.TextWidth('обслуж: '+m_route[n,25]+' ['+m_route[n,24]+']')-120, aRect.Top+5,'обслуж: '+m_route[n,25]+' ['+m_route[n,24]+']')
                    else
                      TextOut(aRect.right - canvas.TextWidth('обслуж: '+m_route[n,25]+' ['+m_route[n,24]+']')-60, aRect.Top+5,'обслуж: '+m_route[n,25]+' ['+m_route[n,24]+']');
                   end
                  else
                    TextOut(aRect.right - canvas.TextWidth(m_route[n,25]+' ['+m_route[n,24]+']')-50, aRect.Top+5, m_route[n,25]+' ['+m_route[n,24]+']');
                   //'   МАРШРУТ: '+IFTHEN(copy(m_route[n,2],length(m_route[n,2]),1)='-', copy(m_route[n,2],1,length(m_route[aRow-1,2])-1),m_route[n,2])+
                   Font.Color := clBlue;
                   TextOut(aRect.Left + 10, aRect.Top+28,'Код:  '+m_route[n,1]+
                   '   МАРШРУТ:  '+m_route[n,2]+
                   '   тип:  '+trim(m_route[n,3]));



                   //есть броня
                   If m_route[n,17]<>'0' then
                     begin
                        pen.Width:=1;
                        font.color:=clGreen;
                        font.Size:=11;
                        font.Style:=[];
                        pen.Color:=clBlue;
                        canvas.Rectangle(aRect.Right-67,aRect.top+3,aRect.right-3,aRect.top+23);
                        TextOut(aRect.right-65, aRect.Top+5, 'БРОНЬ');
                     end;
                    //нет фиксированного тарифа
                   If (m_route[n,18]='0') and (Cells[3,aRow]='1') then
                     begin
                        pen.Width:=1;
                        font.color:=clMaroon;
                        font.Size:=11;
                        font.Style:=[];
                        pen.Color:=clBlack;
                        canvas.Rectangle(aRect.Right-100,aRect.bottom-22,aRect.right-3,aRect.bottom-3);
                        TextOut(aRect.right-97, aRect.bottom-20, 'НЕТ ТАРИФА');
                     end;
                   break;
                 end;
             end;
       end;

       brush.Color:=clWhite;
       end;

       // Заголовок
       if aRow=0 then
         begin
           Brush.Color:=clDefault;
           FillRect(aRect);
           Font.Color := clBlack;
           font.Size:=9;
           TextOut(aRect.Left+5, aRect.Top+15, Cells[aCol, aRow]);
           ////Рисуем значки сортировки и активного столбца
            //If sort_col=aCol then Canvas_Triangle(canvas,sort_direction,aRect.left);
          end;
      end;
end;


procedure TForm15.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;


//procedure TForm15.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//var
//  col,row : integer;
//begin
//  with form15 do
//   begin
//  Stringgrid1.MouseToCell(X,Y,col,row);
//  if row>0 then exit;
//  //Если щелкнули по той же колонке, то изменить порядок сортировки, иначе сортировка по другому столбцу
//  If Col=sort_col then sort_direction:=sort_direction+1
//  else sort_direction :=1;
//  If sort_direction=3 then sort_direction :=1;
//  sort_col := Col;
//  Stringgrid1.Row:=1;
//  updategrid(datatyp,ss);
//   end;
//end;

procedure TForm15.StringGrid1SetCheckboxState(Sender: TObject; ACol,
  ARow: Integer; const Value: TCheckboxState);
var
   currow: integer;
begin

  with sender as TStringGrid do
   begin
     currow := aRow;
    If flagupdate then exit;

       If (dialogs.MessageDlg('Подтверждаете изменение ?',mtConfirmation,[mbYes,mbNO], 0)= mrNo) then
        begin
          exit;
        end;

      if (Cells[aCol,currow]='0') then  cells[aCol,currow]:='1' else cells[aCol,currow]:='0';
     // Подключаемся к серверу
   If not(Connect2(form15.Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
    //Открываем транзакцию
  try
   If not form15.Zconnection1.InTransaction then
      form15.Zconnection1.StartTransaction
   else
     begin
      showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      form15.ZConnection1.Rollback;
     end;

   //showmessage(Cells[8,currow]);

    form15.ZQuery1.SQL.Clear;

  //ПДП
  If aCol=8 then
    begin
    form15.ZQuery1.SQL.add('UPDATE av_shedule_fio SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ Cells[0,currow] +' and del=0;');
      If Cells[aCol,currow]='1' then
   begin
    form15.ZQuery1.SQL.add('INSERT INTO av_shedule_fio(id_user,id_shedule,createdate_first,id_user_first,del) VALUES (');
    form15.ZQuery1.SQL.add(inttostr(id_user)+','+ Cells[0,currow] +',now(),'+inttostr(id_user)+ ',0);');
   end;
      try
      form15.ZQuery1.ExecSQL;
      except
      form15.Zconnection1.disconnect;
      form15.ZQuery1.Close;
       showmessagealt('Данные не записаны !'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
      end;
    end;


  //УДАЛЕНКА
  If (aCol=10) or (aCol=11) then
    begin
      form15.ZQuery1.SQL.add('UPDATE av_shedule_remote_sale_permition SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ Cells[0,currow] +' and del=0;');
       If Cells[aCol,currow]='1' then
      begin
    form15.ZQuery1.SQL.add('INSERT INTO av_shedule_remote_sale_permition(id_user,id_shedule,createdate_first,id_user_first,remote_sale,inet_sale,del) VALUES (');
    form15.ZQuery1.SQL.add(inttostr(id_user)+','+ Cells[0,currow] +',now(),'+inttostr(id_user)+','+Cells[10,currow]+','+Cells[11,currow]+',0);');
      end;
      //showmessage(ZQuery1.SQL.Text);//$
      try
      form15.ZQuery1.ExecSQL;
      except
      form15.Zconnection1.disconnect;
      form15.ZQuery1.Close;
       showmessagealt('Данные не записаны !'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
      end;
     end;


   //Обязательный телефон
  If aCol=12 then
    begin
      form15.ZQuery1.SQL.add('UPDATE av_shedule_tel SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ Cells[0,currow] +' and del=0;');
         If Cells[aCol,currow]='1' then
   begin
    form15.ZQuery1.SQL.add('INSERT INTO av_shedule_tel(id_user,id_shedule,createdate_first,id_user_first,del) VALUES (');
    form15.ZQuery1.SQL.add(inttostr(id_user)+','+ Cells[0,currow] +',now(),'+inttostr(id_user)+ ',0);');
   end;
      try
      form15.ZQuery1.ExecSQL;
      except
      form15.Zconnection1.disconnect;
      form15.ZQuery1.Close;
       showmessagealt('Данные не записаны !'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
      end;
    end;

   //Воинское
  If aCol=13 then
    begin
      form15.ZQuery1.SQL.add('UPDATE av_shedule_voin_deny SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ Cells[0,currow] +' and del=0;');
      If Cells[aCol,currow]='1' then
   begin
    form15.ZQuery1.SQL.add('INSERT INTO av_shedule_voin_deny(id_user,id_shedule,createdate_first,id_user_first,del) VALUES (');
    form15.ZQuery1.SQL.add(inttostr(id_user)+','+ Cells[0,currow] +',now(),'+inttostr(id_user)+ ',0);');
   end;
      try
      form15.ZQuery1.ExecSQL;
      except
      form15.Zconnection1.disconnect;
      form15.ZQuery1.Close;
       showmessagealt('Данные не записаны !'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
      end;
    end;

   //невидимые расписания
  If aCol=14 then
    begin
      form15.ZQuery1.SQL.add('UPDATE av_shedule_invisible SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ Cells[0,currow] +' and del=0;');
      If Cells[aCol,currow]='1' then
   begin
    form15.ZQuery1.SQL.add('INSERT INTO av_shedule_invisible(id_user,id_shedule,createdate_first,id_user_first,del) VALUES (');
    form15.ZQuery1.SQL.add(inttostr(id_user)+','+ Cells[0,currow] +',now(),'+inttostr(id_user)+ ',0);');
   end;
      try
      form15.ZQuery1.ExecSQL;
      except
      form15.Zconnection1.disconnect;
      form15.ZQuery1.Close;
       showmessagealt('Данные не записаны !'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
      end;
    end;

      // Завершение транзакции
  form15.Zconnection1.Commit;

  //
  except
     form15.ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     form15.ZQuery1.Close;
     form15.Zconnection1.disconnect;
     exit;
  end;

form15.ZQuery1.Close;
 form15.Zconnection1.disconnect;
end;
end;

procedure TForm15.ToolButton8Click(Sender: TObject);
begin
  GridPoisk(form15.StringGrid1,form15.Edit1);
end;


procedure TForm15.FormShow(Sender: TObject);
begin
  //флаг первичной выборки
  first_flag:=true;

 with form15 do
  begin
   if flag_access=1 then
     begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
     end;
  end;
 //определяем местоположение элементов на форме
 //Stringgrid1.Height:=665;
 //BitBtn10.Top:=697;
 //GroupBox1.Top:=697;
 BitBtn11.visible:=false;
  BitBtn8.visible:=false;
 GroupBox1.Height:=40;
  sort_col := 0;  //колонка сортировки
  sort_direction := 2;

end;

procedure TForm15.FormActivate(Sender: TObject);
begin
  if not FormActivated then begin
    FormActivated := True;
    datatyp:=0;
    form15.Updategrid(datatyp,'');
  end;
end;


end.

