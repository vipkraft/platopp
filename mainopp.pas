unit mainopp;

{$mode objfpc}{$H+}

interface

uses
  Classes, ZConnection, ZDataset, SysUtils, LazFileUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Grids, StdCtrls, IniPropStorage
  //,fullmap
  ,platproc
  //,profilerun, sprregion
  ,version_info
  ,nas, getopts, point_main, types,
  {$IFDEF UNIX}
  unix,
 {$ENDIF}
  DB, tarif_main, kontr_main,
  kontr_edit, ats_main, group, route_main, shedule_main, lgot_main,
  uslugi_main, path_main, datalog, report_main, dateutils, users_main, servers_main, ticketTypes, kontr_Tarif, facelist,
  Auth, servers_points, spr_shed_kontr, pdp_destination_points;
type

  { TForm1 }

  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    IdleTimer1: TIdleTimer;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    ImageList1: TImageList;
    IniPropStorage1: TIniPropStorage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PaintBox1: TPaintBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Timer1: TTimer;
    Timer2: TTimer;
    Active_app: TTimer;
    ZConnection1: TZConnection;
    ZConnection2: TZConnection;
    ZConnection3: TZConnection;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    ZQuery3: TZQuery;
    procedure Active_appTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;        aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1Exit(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;               Shift: TShiftState);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;      var CanSelect: Boolean);
    procedure StringGrid2DrawCell(Sender: TObject; aCol, aRow: Integer;        aRect: TRect; aState: TGridDrawState);
    procedure StringGrid2Exit(Sender: TObject);
    procedure StringGrid2KeyDown(Sender: TObject; var Key: Word;               Shift: TShiftState);
    procedure StringGrid2SelectCell(Sender: TObject; aCol, aRow: Integer;      var CanSelect: Boolean);
    procedure StringGrid2Selection(Sender: TObject; aCol, aRow: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure run_form(); //Разбираем и запускаем процесс меню
    procedure subMenuLoad();//Загрузка подменю выбранного меню
  private
    { private declarations }
  public
    { public declarations }
    procedure MyExceptionHandler(Sender : TObject; E : Exception); //ОБРАБОТЧИК ИСКЛЮЧЕНИЙ  *********
  end; 

const
   timeout_signal=300; //предудпреждение перед закрытием

var
  Form1: TForm1;
  defpath:string;
  flagprofile:byte;
  X:integer;
  id_user,id_arm:integer;
  flag_access:byte;
  name_user_active,user_ip:string;
  flag1:byte;
  t1 : TDateTime;
  users_mode:byte=0; //режим открытия формы с пользователями
  timeout_global:integer=0;  //счетчик таймер бездействия (перед окном закрытия форм операций)
  timeout_local:integer=0;
  Info:string='';
  flclose:boolean=true; //закрывать формы
  filter_shedule:byte;//флаг фильтрации расписаний
  //filter_shedule=1;//фильтр РАСПИСАНИЙ межобластных и межгосударственных
  //filter_shedule=2;//фильтр РАСПИСАНИЙ муниципальных
  //filter_shedule=3;//фильтр РАСПИСАНИЙ пригородных
  //filter_shedule=4;//фильтр РАСПИСАНИЙ муниципальных через connectini[14]
  //filter_shedule=5;//фильтр РАСПИСАНИЙ муниципальных НЕ через connectini[14]
  my_local_serv: string;
  tekkontr:string;
  sort_col,sort_direction: byte;  //сортируемый столбец, флаг направления сортировки



implementation

{$R *.lfm}

{ TForm1 }


//************************************ ОБРАБОТЧИК ИСКЛЮЧЕНИЙ  **************************************
procedure TForm1.MyExceptionHandler(Sender : TObject; E : Exception);
begin
  showmessagealt('Ошибка программы !!!'+#13+'Сообщение: '+E.Message+#13+'Модуль: '+E.UnitName);
  E.Free;
end;

//**********  ***************    Разбираем и запускаем пункты меню   *******************************************
procedure TForm1.run_form();
begin
  with Form1 do
begin
    //Определяем доступ
   flag_access:=1; //только чтение
  if trim( Stringgrid2.Cells[0, Stringgrid2.row])='2' then
     begin
       flag_access:=2; //доступ на чтение и запись
     end;

  // Запускаем модули

  // Справочник населенных пунктов
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='1') then
     begin
        form5:=Tform5.create(self);
        form5.Showmodal;
        FreeAndNil(form5);
     end;
  // Справочник остановочных пунктов
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='2') then
     begin
         form9:=Tform9.create(self);
         form9.Showmodal;
         FreeAndNil(form9);
     end;
  // Справочник автотранспортных средств
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='3') then
     begin
       form13:=Tform13.create(self);
       //Mode:=1;
       form13.Showmodal;
       FreeAndNil(form13);
     end;

    // Справочник групп остановочных пунктов
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='4') then
     begin
       form11:=Tform11.create(self);
       form11.ShowModal;
       FreeAndNil(form11);
     end;

   // Справочник контрагентов и договоров
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='5') then
     begin
       formsk:=Tformsk.create(self);
       formsk.ShowModal;
       FreeAndNil(formsk);
     end;

  // Справочник льготников
 if (trim( stringgrid1.Cells[2, stringgrid1.row])='9') then
    begin
      formlgot:=Tformlgot.create(self);
      formlgot.ShowModal;
      FreeAndNil(formlgot);
    end;

 // Справочник услуг
if (trim( stringgrid1.Cells[2, stringgrid1.row])='10') then
   begin
     formuslugi:=Tformuslugi.create(self);
     formuslugi.ShowModal;
     FreeAndNil(formuslugi);
   end;

// Справочник НОРМАТИВОВ РАССТОЯНИЙ И ВРЕМЕНИ ДВИЖЕНИЯ
if (trim( stringgrid1.Cells[2, stringgrid1.row])='15') then
  begin
    formpm:=Tformpm.create(self);
    formpm.ShowModal;
    FreeAndNil(formpm);
  end;

// Справочник пользователей
if (trim( stringgrid1.Cells[2, stringgrid1.row])='18') then
  begin
    users_mode := 0;
    form_users:=Tform_users.create(self);
    form_users.ShowModal;
    FreeAndNil(form_users);
  end;

// Справочник ПОДРАЗДЕЛЕНИЙ АСПБ
if (trim( stringgrid1.Cells[2, stringgrid1.row])='19') then
  begin
    Form_servers:=TForm_servers.create(self);
    Form_servers.ShowModal;
    FreeAndNil(Form_servers);
  end;

  // Список МАРШРУТОВ
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='7') then
     begin
       form17:=Tform17.create(self);
       form17.Showmodal;
       FreeAndNil(form17);
     end;

  // Список РАСПИСАНИЙ межобластных и межгосударственных
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='8') then
     begin
       filter_shedule:=1;//фильтр РАСПИСАНИЙ межобластных и межгосударственных
       form15:=Tform15.create(self);
       form15.Showmodal;
       FreeAndNil(form15);
     end;
   // Список РАСПИСАНИЙ
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='87') then
     begin
       filter_shedule:=2;//фильтр РАСПИСАНИЙ межмуниципальных
       form15:=Tform15.create(self);
       form15.Showmodal;
       FreeAndNil(form15);
     end;
   // Список РАСПИСАНИЙ
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='88') then
     begin
       filter_shedule:=3;//фильтр РАСПИСАНИЙ пригородные
       form15:=Tform15.create(self);
       form15.Showmodal;
       FreeAndNil(form15);
     end;
   // Список РАСПИСАНИЙ
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='89') then
     begin
       filter_shedule:=4;//фильтр РАСПИСАНИЙ межмуниципальных и пригородных через  ConnectINI
       form15:=Tform15.create(self);
       form15.Showmodal;
       FreeAndNil(form15);
     end;
    // Список РАСПИСАНИЙ
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='90') then
     begin
       filter_shedule:=5;//фильтр РАСПИСАНИЙ межмуниципальных и пригородных НЕ через  ConnectINI
       form15:=Tform15.create(self);
       form15.Showmodal;
       FreeAndNil(form15);
     end;

      //reestr Классификатор межрегиональных маршрутов
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='128') or (trim(stringgrid1.Cells[2, stringgrid1.row])='163')
  then
     begin
       form28:=Tform28.create(self);
       form28.Showmodal;
       FreeAndNil(form28);
     end;

      //EKOP Единый классификатор остановочных пунктов
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='137')
  then
     begin
       form29:=Tform29.create(self);
       form29.Showmodal;
       FreeAndNil(form29);
     end;


  // Основной тариф
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='11') then
     begin
       formTarif:=TformTarif.create(self);
       formTarif.Showmodal;
       FreeAndNil(formTarif);
     end;
  // Правила формирования цены
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='12') then
     begin
       formTicket:=TformTicket.create(self);
       formTicket.Showmodal;
       FreeAndNil(formTicket);
     end;

    // Журнал изменений в данных
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='16') then
     begin
       FormDLog:=TFormDLog.create(self);
       FormDLog.Showmodal;
       FreeAndNil(FormDLog);
     end;
    // Отчеты ОПП
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='17') then
     begin
       FormReport:=TFormReport.create(self);
       FormReport.Showmodal;
       FreeAndNil(FormReport);
     end;
     // Фиксированные тарифы перевозчиков
  if (trim( stringgrid1.Cells[2, stringgrid1.row])='60') then
     begin
       FormKontrTarif:=TFormKontrTarif.create(self);
       FormKontrTarif.Showmodal;
       FreeAndNil(FormKontrTarif);
     end;

    // разыскиваемые ФСБ
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='115') then
     begin
       FormFace:=TFormFace.create(self);
       FormFace.Showmodal;
       FreeAndNil(FormFace);
     end;

    // севера - пункты
  if (trim(stringgrid1.Cells[2, stringgrid1.row])='160') then
     begin
       Form26:=TForm26.create(self);
       Form26.Showmodal;
       FreeAndNil(Form26);
     end;

  end;
end;


{
procedure TForm1.Button1Click(Sender: TObject);
begin
  form5:=Tform5.create(self);
  form5.Showmodal;
  FreeAndNil(form5);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  form9:=Tform9.create(self);
  form9.Showmodal;
  FreeAndNil(form9);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  form13:=Tform13.create(self);
  form13.Showmodal;
  FreeAndNil(form13);
end;
 }
//*************************************************    HOT KEYS  *************************************************
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 // showmessagealt(inttostr(Key));
  // tab
  if Key=9 then
     begin
         if form1.StringGrid1.Focused=true then
            begin
             Form1.Stringgrid2.col:=1;
            end;
         if Form1.Stringgrid2.Focused=true then
            begin
             form1.StringGrid1.col:=1;
            end;
     end;
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ENTER] - Выбор'+#13+'TAB - Переход на левое\правое меню'+#13+'1 - Пункт [Основное]'+#13+'2 - Пункт [Сервер БД]'+#13+'3 - Пункт [Активные пользователи]'+#13+'4 - Пункт [Задачи]'+#13+'5 - Пункт [О программе]'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if (Key=27) and not(form1.StringGrid1.Focused) then halt;

    //1-Основное
    if Key=49 then
       begin
         form1.Label14.Font.Color:=clBlue;
         form1.Label15.Font.Color:=clSkyBlue;
         form1.Label16.Font.Color:=clSkyBlue;
         form1.Label17.Font.Color:=clSkyBlue;
         form1.Label19.Font.Color:=clSkyBlue;
         form1.Image2.Visible:=true;
         form1.Label5.Visible:=true;
         form1.Label20.Visible:=true;
         form1.GroupBox3.Visible:=true;
         form1.GroupBox2.Visible:=true;
         form1.GroupBox1.Visible:=false;
         form1.StringGrid3.Visible:=false;
       end;

    //2-Сервер БД
    if Key=50 then
       begin
         form1.Label14.Font.Color:=clSkyBlue;
         form1.Label15.Font.Color:=clBlue;
         form1.Label16.Font.Color:=clSkyBlue;
         form1.Label17.Font.Color:=clSkyBlue;
         form1.Label19.Font.Color:=clSkyBlue;
         form1.Label5.Visible:=false;
         form1.Image2.Visible:=false;
         form1.Label20.Visible:=false;
         form1.GroupBox3.Visible:=false;
         form1.GroupBox2.Visible:=false;
         form1.GroupBox1.Visible:=true;
         form1.StringGrid3.Visible:=false;
       end;


    //3-Активные пользователи
    if Key=51 then
       begin
         form1.Label14.Font.Color:=clSkyBlue;
         form1.Label15.Font.Color:=clSkyBlue;
         form1.Label16.Font.Color:=clBlue;
         form1.Label17.Font.Color:=clSkyBlue;
         form1.Label19.Font.Color:=clSkyBlue;
         form1.Label5.Visible:=false;
         form1.Image2.Visible:=false;
         form1.Label20.Visible:=false;
         form1.GroupBox3.Visible:=false;
         form1.GroupBox2.Visible:=false;
         form1.GroupBox1.Visible:=false;
         form1.StringGrid3.Visible:=true;
         grid_active_user(form1.StringGrid3,form1.ZConnection3,form1.ZQuery3);
       end;

    //4-Задачи
    if Key=52 then
       begin
         form1.Label14.Font.Color:=clSkyBlue;
         form1.Label15.Font.Color:=clSkyBlue;
         form1.Label16.Font.Color:=clSkyBlue;
         form1.Label17.Font.Color:=clBlue;
         form1.Label19.Font.Color:=clSkyBlue;
         form1.Label5.Visible:=false;
         form1.Image2.Visible:=false;
         form1.Label20.Visible:=false;
         form1.GroupBox3.Visible:=false;
         form1.GroupBox2.Visible:=false;
         form1.GroupBox1.Visible:=false;
         form1.StringGrid3.Visible:=false;
       end;

    //5-О программе
    if Key=53 then
       begin
         form1.Label14.Font.Color:=clSkyBlue;
         form1.Label15.Font.Color:=clSkyBlue;
         form1.Label16.Font.Color:=clSkyBlue;
         form1.Label17.Font.Color:=clSkyBlue;
         form1.Label19.Font.Color:=clBlue;
         form1.Label5.Visible:=false;
         form1.Image2.Visible:=false;
         form1.Label20.Visible:=false;
         form1.GroupBox3.Visible:=false;
         form1.GroupBox2.Visible:=false;
         form1.GroupBox1.Visible:=false;
         form1.StringGrid3.Visible:=false;
       end;

    // ENTER
    if Key=13 then
      begin
         if form1.StringGrid1.Focused then
            begin
              // Разбираем меню
              form1.run_form;
            end;
         if form1.StringGrid2.Focused then
            begin
                 form1.StringGrid1.SetFocus;
            end;
      end;
    // ESC
    if (Key=27) and form1.StringGrid1.Focused then
       begin
            form1.StringGrid2.SetFocus;
       end;
end;


//******************************************* ДВОЙНОЙ КЛИК НА ПОДМЕНЮ ********************************************************
procedure TForm1.StringGrid1DblClick(Sender: TObject);
begin
  form1.run_form();
end;

//********************************************* ОТРИСОВКА ГРИДА ПОДМЕНЮ  ***************************************************
procedure TForm1.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;  aRect: TRect; aState: TGridDrawState);
begin
    SetRowColorMenu(form1.stringgrid1,aCol,aRow,aRect);
end;

// ***************************************   ПОТЕРЯ ФОКУСА 1 ГРИДА ПОДМЕНЮ **********************************************
procedure TForm1.StringGrid1Exit(Sender: TObject);
begin
  form1.StringGrid1.Color:=clWhite;
  form1.StringGrid1.Options:=[];
  Form1.Stringgrid2.Color:=clCream;
  Form1.Stringgrid2.Options:=[goRowSelect];
end;

// **************************************** НАЖАТИЕ КНОПКИ ВЛЕВО НА ГРИДЕ ПОДМЕНЮ *****************************************
procedure TForm1.StringGrid1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if key=37 then Form1.Stringgrid2.Col:=1;
end;

// ******************************************************  ПОТЕРЯ ФОКУСА ГРИДОМ ПОДМЕНЮ *************************************
procedure TForm1.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
    if (aCol=0) or (aCol=2) then form1.StringGrid1.Col:=1;
end;

//************************************************ ОТРИСОВКА 2 ГРИДА МЕНЮ  ********************************************
procedure TForm1.Stringgrid2DrawCell(Sender: TObject; aCol, aRow: Integer;aRect: TRect; aState: TGridDrawState);
begin
    SetRowColorMenu(Form1.Stringgrid2,aCol,aRow,aRect);
end;

//************************************************** ПОТЕРЯ ФОКУСА 2 ГРИДОМ МЕНЮ ***************************************
procedure TForm1.Stringgrid2Exit(Sender: TObject);
begin
  Form1.Stringgrid2.Color:=clWhite;
  Form1.Stringgrid2.Options:=[];
  form1.StringGrid1.Color:=clCream;
  form1.StringGrid1.Options:=[goRowSelect];
end;

//************************************************   НАЖАТИЕ КНОПКИ ВПРАВО НА 2 ГРИДЕ МЕНЮ ********************************
procedure TForm1.Stringgrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=39 then form1.StringGrid1.Col:=1;
end;

procedure TForm1.Stringgrid2SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  if (aCol=0) or (aCol=2) then Form1.Stringgrid2.Col:=1;
end;

//***********************************************   ВЫБОР ПУНКТА  МЕНЮ  **********************************************
procedure TForm1.Stringgrid2Selection(Sender: TObject; aCol, aRow: Integer);
begin
  //проверка грида
  IF form1.StringGrid2.RowCount<2 then exit;
  SubMenuLoad(); //загрузка подменю
end;

//******************************* ЗАГРУЗКА ПОДМЕНЮ ДЛЯ ВЫБРАННОГО МЕНЮ  *****************************
procedure TForm1.SubMenuLoad;
var
  n:integer=0;
begin
      //Основное меню
  // Подключаемся к серверу
   If not(Connect2(form1.Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      exit;
     end;

    //Основное меню > Дополнительное меню
    ZQuery1.sql.Clear;
    ZQuery1.SQL.add('SELECT ');
    ZQuery1.SQL.add('distinct(b.id_local),');
    //,a.permition,');
    ZQuery1.SQL.add(' b.loc_name as name,b.tab_loc ');
    ZQuery1.SQL.add('FROM av_arm_menu b ');
    //ZQuery1.SQL.add(' ,av_users_menu_perm a ');
    ZQuery1.SQL.add('WHERE ');
    //ZQuery1.SQL.add('a.id_menu_loc = b.id_local AND a.id_arm = b.id_arm AND a.permition>0 AND a.id_menu_loc>0 and a.id_menu_loc<>18');
    //ZQuery1.SQL.add(' AND a.del=0 AND a.id='+inttostr(id_user));
    ZQuery1.SQL.add(' b.id_arm='+inttostr(id_arm)+' AND b.id_public='+trim(Form1.Stringgrid2.Cells[2,Form1.Stringgrid2.Row]));
    ZQuery1.SQL.add(' and b.id_local>0 and b.del=0 order by b.tab_loc;');
    //showmessage(ZQuery1.SQL.text);//$
    try
      ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
     end;
    if ZQuery1.RecordCount>0 then
       begin
          //Заполнение и доступы к меню LOCAL(начальная загрузка)
            Stringgrid1.RowCount := ZQuery1.RecordCount;
            for n:=0 to ZQuery1.RecordCount-1 do
              begin
                //Если тип расписания через id_point

                Stringgrid1.Cells[2,n]:=ZQuery1.FieldByName('id_local').AsString;
                  If (ZQuery1.FieldByName('id_local').AsInteger=89)
                  or (ZQuery1.FieldByName('id_local').AsInteger=90) then
                  Stringgrid1.Cells[1,n]:=ZQuery1.FieldByName('Name').AsString+' '+my_local_serv
                  else Stringgrid1.Cells[1,n]:=ZQuery1.FieldByName('Name').AsString;
                //Stringgrid1.Cells[0,n]:=ZQuery1.FieldByName('permition').AsString;
                  Stringgrid1.Cells[0,n]:='2';
                ZQuery1.Next;
              end;
       end
    else
       begin
         form1.StringGrid1.RowCount:=1;
         form1.StringGrid1.cells[0,0]:='';
         form1.StringGrid1.cells[1,0]:='';
         form1.StringGrid1.cells[2,0]:='';
       end;
    ZQuery1.close;
    form1.ZConnection1.Disconnect;

    form1.StringGrid1.Row:=0;
end;


///////////////////////////////////////////////////***************************************************
procedure TForm1.Timer1Timer(Sender: TObject);
var
    myYear, myMonth, myDay : Word;
begin
  // Часы + Дата
  DecodeDate(Date, myYear, myMonth, myDay);
  form1.label1.caption:=TimeToStr(Time);
  form1.label2.caption:=IntToStr(myDay)+' '+GetMonthName(MonthOfTheYear(Date));//+' '+inttostr(myYear)+' г.';
  form1.label3.caption:=GetDayName(DayOftheWeek(Date));
end;

//////////////////////////****************************************************************************
procedure TForm1.Timer2Timer(Sender: TObject);
begin
  form1.PaintBox1.Canvas.Clear;
  Dec(X);
  form1.PaintBox1.Canvas.Font.Color:=clTeal;
  form1.PaintBox1.Canvas.Font.Size := 12;
  form1.PaintBox1.Canvas.TextOut(X,5,'Автоматизированная система продажи пассажирских билетов ПЛАТФОРМА');
  if X = (0-form1.PaintBox1.canvas.TextWidth('Автоматизированная система продажи пассажирских билетов ПЛАТФОРМА')) then X := form1.PaintBox1.Width;
end;


//******************************* УНИЧТОЖЕНИЕ ФОРМЫ - ЗАПИСЬ В ЖУРНАЛ ВХОДА-ВЫХОДА **************************************************
procedure TForm1.FormDestroy(Sender: TObject);
begin
   out_user_sql(form1.ZConnection2,form1.ZQuery2);
end;


procedure TForm1.Active_appTimer(Sender: TObject);
begin
  exit;
  // Обновляем информацию о активном пользователе
   if active_user_sql(form1.ZConnection2,form1.ZQuery2,inttostr(id_user))=1 then
      begin
       form1.Active_app.Enabled:=false;
       showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
       //halt;
      end;
end;


//*******************************    ВОЗНИКНОВЕНИЕ ФОРМЫ   ******************************************************************
procedure TForm1.FormShow(Sender: TObject);
var
    BlobStream: TStream;
    FileStream: TStream;
    dt,t2 : TDateTime;
    n:integer=0;
begin
   //t2 := time();
   //FormatDateTime('yyyy-mm-dd ss-mm-hh',dt);
   //глобальные установки
    decimalseparator:='.';
    DateSeparator := '.';
    ShortDateFormat := 'dd.mm.yyyy';
    LongDateFormat  := 'dd.mm.yyyy';
    ShortTimeFormat := 'hh:mm:ss';
    LongTimeFormat  := 'hh:mm:ss';
   //Выбираем профиль загрузки реального или эмулируемого сервера
   filter_shedule:=0;//фильтр расписаний отсутствует

   with Form1 do
   begin
   ////////////////////////////
   //Проверяем статус выбранного сервера
   if flagprofile<3 then
      begin
       form1.Label5.Font.Color:=clRed;
       form1.Label5.caption:='РЕЖИМ РЕАЛЬНОГО СЕРВЕРА';
       form1.Label6.caption:=ConnectINI[1]+' порт: '+ConnectINI[2];
       form1.Label7.caption:=ConnectINI[4]+' порт: '+ConnectINI[5];
       form1.Label8.caption:=ConnectINI[3];
       //MConnect(form1.Zconnection1,ConnectINI[3],ConnectINI[1]);
      end;
   if flagprofile>2 then
      begin
       form1.Label5.Font.Color:=clBlue;
       form1.Label5.caption:='РЕЖИМ ЭМУЛЯЦИИ';
       form1.Label6.caption:='ip-адрес Эмуляции ЦС: '+ConnectINI[8]+' порт: '+ConnectINI[9];
       form1.Label7.caption:='ip-адрес Эмуляции ЛС: '+ConnectINI[11]+' порт: '+ConnectINI[12];
       form1.Label8.caption:='Эмулируемая БД: '+ConnectINI[10];
       //MConnect(form1.Zconnection1,ConnectINI[6],ConnectINI[4]);
      end;

   // Определяем Имя пользователя

   // Подключаемся к серверу
   If not(Connect2(form1.Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      Form1.Close;
      halt;
      exit;
    end;

   ZQuery1.sql.Clear;
   ZQuery1.SQL.add('select dolg,name,fullname from av_users where id='+inttostr(id_user)+';');
   try
      ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
     end;
   If Zquery1.RecordCount>0 then
     begin
       name_user_active := trim(ZQuery1.FieldByName('fullname').asString);
       form1.label11.caption:='Пользователь: '+name_user_active;
       form1.label10.caption:='id пользователя:  '+inttostr(id_user);
       form1.label12.caption:='Должность: '+upperall(trim(ZQuery1.FieldByName('dolg').asString));
     end;


   //Определяем фото
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT foto from av_users where id='+inttostr(id_user)+';');
      try
        ZQuery1.open;
      except
         showmessagealt('Ошибка чтения фото из базы SQL - ОШИБКА');
         ZQuery1.Close;
      end;
    If ZQuery1.RecordCount>0 then
      begin
      if ZQuery1.FieldByName('foto').IsBlob then
         begin
           BlobStream := ZQuery1.CreateBlobStream(ZQuery1.FieldByName('foto'), bmRead);
           If BlobStream.Size>10 then
             begin
           try
             FileStream:= TFileStream.Create('foto.jpg', fmCreate);
               try
                FileStream.CopyFrom(BlobStream, BlobStream.Size);
               finally
                FileStream.Free;
               end;
           finally
            BlobStream.Free;
           end;
           //If filesize(ExtractFilePath(Application.ExeName)+'foto.jpg')>10 then
             //begin
               form1.image4.Picture.LoadFromFile('foto.jpg');
               //end;
             end;
         end;
      end;

   //Определяем текущий локальный IP
   user_ip := GetIPAddressOfInterface('eth0');
   If user_ip='0.0.0.0' then user_ip := GetIPAddressOfInterface('eth1');
   If user_ip='0.0.0.0' then user_ip := GetIPAddressOfInterface('eth2');
   form1.Label20.Caption:=user_ip;


   //ОПРЕДЕЛЯЕМ ИМЯ ЛОКАЛЬНОГО СЕРВЕРА
   my_local_serv := '';
   ZQuery1.sql.Clear;
   ZQuery1.SQL.add(' select name from av_spr_point where id='+connectINI[14]+' ORDER BY del ASC, createdate DESC LIMIT 1;');
   try
      ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
     end;
   If Zquery1.RecordCount>0 then
     begin
       my_local_serv := trim(ZQuery1.FieldByName('name').asString);

     end;





   ZQuery1.Close;
   Zconnection1.disconnect;
   ////////////////////////////////////////////////////////////////////
   //                             Загрузка меню                      //
   ////////////////////////////////////////////////////////////////////
   //Основное меню
   // Подключаемся к серверу
   If not(Connect2(form1.Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      form1.Close;
      halt;
      exit;
     end;
    //if flagprofile=1 then MConnect(form1.Zconnection1,ConnectINI[3],ConnectINI[1]);
    //if flagprofile=2 then MConnect(form1.Zconnection1,ConnectINI[6],ConnectINI[4]);
    //try
    //    form1.Zconnection1.connect;
    //  except
    //    showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
    //    halt;
    //  end;
    ZQuery1.sql.Clear;
    ZQuery1.SQL.add('SELECT distinct(a.id_menu_pub),a.permition,b.pub_name as name,b.tab_pub ');
    ZQuery1.SQL.add('FROM av_arm_menu b,av_users_menu_perm a ');
    ZQuery1.SQL.add('WHERE a.id_menu_pub = b.id_public AND a.id_arm = b.id_arm AND a.id_menu_loc=0 AND a.permition>0 ');
    ZQuery1.SQL.add(' AND b.id_arm='+inttostr(id_arm)+' AND a.id='+inttostr(id_user)+' and b.del=0 AND a.del=0 order by b.tab_pub;');
    //showmessage(ZQuery1.SQL.Text);//$
    try
        ZQuery1.open;
    except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
       Zconnection1.disconnect;
       form1.Close;
       halt;
       exit;
    end;
    if ZQuery1.RecordCount<1 then
       begin
         showmessagealt('Нет доступного меню для выбранного пользователя !');
         form1.ZConnection1.Disconnect;
         form1.Close;
         halt;
         exit;
       end;
    //Заполнение и доступы к меню PUBLIC(начальная загрузка)
  // Соединяемся с сервером и выбираем список доступных меню для пользователя + АРМ
   Stringgrid2.RowCount := ZQuery1.RecordCount;
  for n:=0 to ZQuery1.RecordCount-1 do
    begin
      Stringgrid2.Cells[2,n]:=ZQuery1.FieldByName('id_menu_pub').AsString;
      Stringgrid2.Cells[1,n]:=ZQuery1.FieldByName('Name').AsString;
      Stringgrid2.Cells[0,n]:=ZQuery1.FieldByName('permition').AsString;
     ZQuery1.Next;
    end;
  Stringgrid2.Row:=0;


  SubMenuLoad();//загрузка дополнительного меню
  Stringgrid2.SetFocus;

 // Входим в проГрамму
 if flag1=0 then
  begin
   flag1 := 1;
    if
    //(1<>1) and
    (in_user_sql('ОПП','platopp',inttostr(id_user),name_user_active,user_ip,form1.ZConnection2,form1.ZQuery2)=1) then
       begin
        //showmessagealt('Пользователь: '+upperall(trim(name_user_active))+' уже вошел в систему.'+#13+'Повторный вход невозможен !');
        showmessagealt('Пользователь: '+(trim(name_user_active))+' уже вошел в систему.'+#13+'Повторный вход невозможен !');
        form1.Close;
        halt;
        exit;
       end
    else
     begin
       form1.Active_app.Enabled:=true;
     end;
  end;
 end;
 //FreeAndNil(form4);
 //showmessage('всего: '+timetostr(time()-t1)+' сек. Возникновение: '+timetostr(time()-t2)+' сек.');
end;


// *********************************************   СОЗДАНИЕ формы *************************************************************
procedure TForm1.FormCreate(Sender: TObject);
var
  k:string;
  MajorNum : String;
  MinorNum : String;
  RevisionNum : String;
  BuildNum : String;
  Info: TVersionInfo;
  n:integer;
  sss:string;
begin
 //взять номер версии
 // initialize a bunch of stuff for this app when the form is first opened
// [0] = Major version, [1] = Minor ver, [2] = Revision, [3] = Build Number
// The above values can be found in the menu: Project > Project Options > Version Info
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  // grab just the Build Number
  MajorNum := IntToStr(Info.FixedInfo.FileVersion[0]);
  MinorNum := IntToStr(Info.FixedInfo.FileVersion[1]);
  RevisionNum := IntToStr(Info.FixedInfo.FileVersion[2]);
  BuildNum := IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;
 Label4.Caption := 'Версия:'+MajorNum+'.'+MinorNum+'.'+RevisionNum+'.'+BuildNum;//версия программы
     // Обработчик исключений
  Application.OnException:=@MyExceptionHandler;



   X:=form1.PaintBox1.Width;
  //Определяем начальные установки соединения с сервером
  if  ReadIniLocal(form1.IniPropStorage1, ExtractFilePath(Application.ExeName)+'local.ini')=false then
     begin
       showmessagealt('Не найден файл настроек по заданному пути!'+#13+'Дальнейшая загрузка программы невозможна !'+#13+'Обратитесь к Администратору !');
       halt;
     end;

  flagProfile:=1;  //профиль - центральный реальный сервер
  id_user := 1;
//  id_user := 595;
  id_arm  := 2;

     //принимаем начальные параметры
  If trim(ParamStr(1))<>'' then
  begin
  try
  id_user:=strtoint(copy(trim(ParamStr(1)),1,pos('+',ParamStr(1))-1));
  id_arm:=strtoint(copy(ParamStr(1),pos('+',ParamStr(1))+1,pos('_',ParamStr(1))-1-pos('+',ParamStr(1))));
  //flagProfile:=flagProfile+strtoint(copy(trim(ParamStr(1)),pos('_',ParamStr(1))+1,1));
  except
       on exception: EConvertError do
  begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'НЕВЕРНОЕ ЗНАЧЕНИЕ ПАРАМЕТРА ПРИЛОЖЕНИЯ !');
       halt;
       exit;
  end;
  end;
  end
  else
  begin
   If not FileExistsUTF8(ExtractFilePath(Application.ExeName)+'cheater') then
   begin
    //{$IFDEF WINDOWS}
     id_user:=0;
     //открыть форму регистрации
     FormAuth:=TFormAuth.create(self);
     FormAuth.ShowModal;
     FreeAndNil(FormAuth);
    //{$ENDIF}
    end;
   end;

  If id_user=0 then
  begin
    halt;
    exit;
  end;


  flag_access:=1;
  flag1:=0;
end;

end.

