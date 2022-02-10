
unit shedule_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, ComCtrls, Spin, EditBtn, report_main,
  StrUtils, types, dateutils;

type Tmas = array of array of string;

type

  { TForm16 }

  TForm16 = class(TForm)
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn23: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn25: TBitBtn;
    BitBtn26: TBitBtn;
    BitBtn27: TBitBtn;
    BitBtn28: TBitBtn;
    BitBtn29: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckGroup1: TCheckGroup;
    CheckGroup2: TCheckGroup;
    CheckGroup3: TCheckGroup;
    CheckGroup4: TCheckGroup;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DateEdit3: TDateEdit;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit16: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    FloatSpinEdit3: TFloatSpinEdit;
    FloatSpinEdit4: TFloatSpinEdit;
    FloatSpinEdit5: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Shape1: TShape;
    Shape10: TShape;
    Shape19: TShape;
    Shape8: TShape;
    SpinEdit1: TSpinEdit;
    StaticText1: TStaticText;
    StringGrid1: TStringGrid;
    StringGrid10: TStringGrid;
    StringGrid11: TStringGrid;
    StringGrid12: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    StringGrid6: TStringGrid;
    StringGrid7: TStringGrid;
    StringGrid8: TStringGrid;
    StringGrid9: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn13Exit(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn1Exit(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn23Click(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn25Click(Sender: TObject);
    procedure BitBtn26Click(Sender: TObject);
    procedure BitBtn27Click(Sender: TObject);
    procedure BitBtn28Click(Sender: TObject);
    procedure BitBtn29Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure DateEdit2Change(Sender: TObject);
    procedure DateEdit3Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure FloatSpinEdit1EditingDone(Sender: TObject);
    procedure FloatSpinEdit2EditingDone(Sender: TObject);
    procedure FloatSpinEdit3EditingDone(Sender: TObject);
    procedure FloatSpinEdit4EditingDone(Sender: TObject);
    procedure FloatSpinEdit5EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);
    procedure RadioButton5Change(Sender: TObject);
    procedure rascet();     //Пересчет всех параметров текущего состава расписания
    procedure perescet();   //Пересчет всех параметров для каждого элемента расписания
    procedure SpinEdit1Change(Sender: TObject);
    procedure StringGrid10DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure StringGrid10EditingDone(Sender: TObject);
    procedure StringGrid10Enter(Sender: TObject);
    procedure StringGrid10GetEditMask(Sender: TObject; ACol, ARow: Integer;      var Value: string);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;aRect: TRect; aState: TGridDrawState);
 //   procedure main_tarif(); //Вывод параметров основного тарифа
    procedure fill_array(old_id: string); //Заполнение массива данными по составу расписания и основным реквизитам
    procedure save_shedule(); //Запись массива данными по составу расписания и основным реквизитам
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid1SetCheckboxState(Sender: TObject; ACol, ARow: Integer;
      const Value: TCheckboxState);
    procedure StringGrid6BeforeSelection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid6ButtonClick(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid6MouseEnter(Sender: TObject);
    procedure StringGrid6Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid6SetCheckboxState(Sender: TObject; ACol, ARow: Integer;       const Value: TCheckboxState);
    procedure StringGrid8Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid9Enter(Sender: TObject);
    procedure StringGrid9SetCheckboxState(Sender: TObject; ACol, ARow: Integer;const Value: TCheckboxState);
    procedure TabSheet7Enter(Sender: TObject);
    procedure TabSheet7Exit(Sender: TObject);
    procedure TabSheet8Enter(Sender: TObject);
    procedure TabSheet9Enter(Sender: TObject);
    procedure UpdateGridATS();                            // Обновление АТС
    procedure UpdateGridATP();                            // Обновление АТП
    procedure Check_sezon();                              // Временные характеристики расписания
    procedure GetNorma();                                 // загрузка нормативов из основного тарифа
    procedure Update_uslugi_list();                       // Обновление сетки льгот тарифа
    // Основные процедуры для массивов и grid-ов тарифов
    procedure Refresh_arrays(id_atp:string; flag_erase:boolean);    // //Обновляем из всех массивов все записи по условию id АТП
    procedure Refresh_all_grid(id_atp:string);//Обновляем все Grid-ы тарифов по условию id АТП
    procedure MasFree(); //освобождение памяти занимаемой массивами
    procedure FillRepArray();
    procedure ShowMas(var mas : Tmas); //показать содержимое двумерного массива
    function Tarif_auto(atp:string):boolean; //автоматический расчет тарифа для перевозчика
 //   procedure Load_date(id_atp:string); //загрузка в массив сезонности
    procedure crossgraf();  //ОтЧЕТ ПЕРЕСЕЧЕНИЯ ПЕРЕВОЗЧИКОВ НА РАСПИСАНИИ
    procedure get_newid;//рассчитать новый код маршрута
    procedure get_infoedit(idshed: string);//запросить инфу по изменениям
  private
    { private declarations }
  public
    { public declarations }
end;


var
  Form16: TForm16;

  m_sostav:array of array of String;
  mas_date:array of array of string;
  atp_sostav:array of array of String;
  ats_sostav:array of array of String;
  tarif_sostav:array of array of string;
  tarif_uslugi:array of array of string;
  // Основные массивы для тарифа
  tarif_all, uslugi_all, lgoty_all:array of array of string;
  arSATP : array of array of String;
  flag_edit_sostav, norma_KMH, norma_Deti :integer;
  idshed :string;
  result_dog:string;
  new_id :string;
  flcritical:boolean;//флаг изменения критических данных при редактировании состава


const
  sostav_size = 15;

  //tarif_sostav:array of array of string;

implementation
uses
  mainopp,platproc,shedule_edit_sostav,shedule_main,route_main,kontr_main,shedule_grafik,htmldoc,uslugi_main,lgot_main,users_main,shedule_tarif,dogovor;
{$R *.lfm}

//======================================= m_sostav
  //  m_sostav - Описание
//-------------------------------------------------------
         //m_sostav[n,0]:=form16.zquery1.FieldByName('id_point').asString;
         //m_sostav[n,1]:=form16.zquery1.FieldByName('name').asString;
         //m_sostav[n,2]:=form16.zquery1.FieldByName('form').asString;
         //m_sostav[n,3]:=form16.zquery1.FieldByName('plat_o').asString;
         //m_sostav[n,4]:=form16.zquery1.FieldByName('plat_p').asString;
         //m_sostav[n,5]:=form16.zquery1.FieldByName('t_o').asString;
         //m_sostav[n,7]:=form16.zquery1.FieldByName('t_s').asString;
         //m_sostav[n,8]:=form16.zquery1.FieldByName('km').asString;
         //m_sostav[n,9]:=form16.zquery1.FieldByName('t_d').asString;
         //m_sostav[n,12]:=form16.zquery1.FieldByName('timering').asString;
         //m_sostav[n,6]:=form16.zquery1.FieldByName('t_p').asString;
         //m_sostav[n,13]:=form16.zquery1.FieldByName('backout').asString;
         //m_sostav[n,10]:=form16.zquery1.FieldByName('kmh_n').asString;
         //m_sostav[n,11]:=form16.zquery1.FieldByName('kmh_r').asString;
         //m_sostav[n,14]:=form16.zquery1.FieldByName('deny_sale').asString;

//======================================= atp_sostav
  //  atp_sostav - Описание
//-------------------------------------------------------
 //atp_sostav[n,0] - id_kontr
 //atp_sostav[n,1] - name atp
 //atp_sostav[n,2] // Код АТС по умолчанию
 //atp_sostav[n,3] //тип расчета тарифа 0-авто 1-ручной для АТП
 //atp_sostav[n,4] //код в реестре маршрутов

//======================================= ats_sostav
  //  ats_sostav - Описание
//-------------------------------------------------------
//ats_sostav[n,0] - id ats
//ats_sostav[n,1] - name ats
//ats_sostav[n,2] - количество этажей
//ats_sostav[n,2] - гос.номер
//ats_sostav[n,3] - всего мест
//ats_sostav[n,4] - тип атс
//ats_sostav[n,5] - активность атс
//ats_sostav[n,6] - код АТП
////////////////удалить //ats_sostav[n,7] - АТС по умолчанию

const
  atp_size = 10;
  ats_size = 7;
  tarif_size = 15;
  uslugi_size = 6;
  lgoty_size = 7;
  sezon_size = 63;
var
  tmp_arr:array of array of String;
  //флаги изменений
  flchange,flsostav,flatp,fltarif,flsezon,fluslugi,flblock,flactiv: boolean;
   sdate, past_id : string;
   copy_shed,  old_id :string;
  activDay : TDate;
  schange:boolean=true;
  rfresh:boolean=false;

{ TForm16 }

procedure Tform16.get_infoedit(idshed: string);
var
   n:integer;
begin
     With Form16 do
  begin
   //обнулить инфо поля
  form16.Label28.Caption:='';
  form16.Label29.Caption:='';
   form16.StringGrid4.RowCount:=1;
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
    form16.ZQuery1.SQL.Clear;
    form16.ZQuery1.SQL.add('SELECT get_shedule_history(''idsh'','+idshed+');');
    form16.ZQuery1.SQL.add('FETCH ALL IN idsh;');
      try
      ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.text);
      ZQuery1.close;
      ZConnection1.disconnect;
      Exit;
     end;
     If ZQuery1.recordcount=0 then
       begin
         ZQuery1.close;
         ZConnection1.disconnect;
         Exit;
        end;
     for n:=0 to ZQuery1.recordcount-1 do
       begin
         if n=0 then
           begin
              form16.Label28.Caption:=formatdatetime('YYYY-MM-DD hh:nn:ss',form16.ZQuery1.FieldByName('createdate').AsDatetime);
              form16.Label29.Caption:=form16.ZQuery1.FieldByName('uname').AsString;
               ZQuery1.Next;
               continue;
           end;
         form16.StringGrid4.RowCount:=form16.StringGrid4.RowCount+1;
         form16.StringGrid4.cells[0,form16.StringGrid4.RowCount-1]:=form16.ZQuery1.FieldByName('info').AsString;
         form16.StringGrid4.cells[1,form16.StringGrid4.RowCount-1]:=formatdatetime('YYYY-MM-DD hh:nn:ss',form16.ZQuery1.FieldByName('createdate').AsDatetime);
         form16.StringGrid4.cells[2,form16.StringGrid4.RowCount-1]:=form16.ZQuery1.FieldByName('uname').AsString;
          ZQuery1.Next;
         end;


      ZQuery1.close;
      ZConnection1.disconnect;

  end;
end;

procedure Tform16.get_newid;//рассчитать новый код маршрута
begin

   With Form16 do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
    form16.ZQuery1.SQL.Clear;
    form16.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_shedule where del=0;');
      try
      ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Невозможно получить новый номер расписания !');
      ZQuery1.close;
      ZConnection1.disconnect;
      Exit;
     end;
     If ZQuery1.recordcount<>1 then
       begin
         showmessagealt('Невозможно получить новый номер расписания !');
         ZQuery1.close;
         ZConnection1.disconnect;
         Exit;
        end;
       //если кто-то уже вводит расписание с таким номером, то меняем на новый max
     new_id:=intTostr(form16.ZQuery1.FieldByName('new_id').asInteger+1);
       ZQuery1.close;
      ZConnection1.disconnect;
   Label4.caption:=new_id;

   If new_id='0' then
     begin
       showmessagealt('ОШИБКА создания нового номера расписания !');
     end;
 end;
end;



procedure TForm16.ShowMas(var mas : Tmas); //показать содержимое двумерного массива
var
  n,m:integer;
  s:string;
begin
 //showmessage(floattostr((strtofloat(form16.StringGrid2.Cells[0,form16.StringGrid10.Row])*strtoint(form16.StringGrid10.Cells[2,form16.StringGrid10.Row]))));
// showmessage(floattostr(strtofloat(form16.StringGrid10.Cells[3,form16.StringGrid10.Row])));
 s:='';
  for n:=low(mas) to high(mas) do
     begin
      for m:=low(mas[low(mas)]) to high(mas[low(mas)]) do
         begin
           s := s + ' | ' + mas[n,m];
         end;
      s:=s+#13;
     end;
  showmessagealt(inttostr(length(mas))+#13+s);
  //showmessagealt('grid '+inttostr(form16.StringGrid10.RowCount)+' , '+inttostr(form16.StringGrid10.ColCount));
end;


//****************   // ЗАПОЛНЕНИЕ МАССИВА ПЕРЕМЕННЫХ ОТЧЕТОВ *********************************************
procedure TForm16.FillRepArray();
var
  i: integer;
begin
  with Form16 do
 begin

    FillReportVars(Zconnection1,ZQuery1);
  //заполняем доступные значения в массив переменных отчета (таблица report_vars)
     for i:=Low(ar_report) to High(ar_report) do
                begin
                  If trim(ar_report[i,0]) = 'mar_kod' then ar_report[i,2]:= Edit3.Text;
                  If trim(ar_report[i,0]) = 'mar_name' then ar_report[i,2]:= Edit2.Text;
                  If trim(ar_report[i,0]) = 'mar_type' then ar_report[i,2]:= Edit3.Text;
                  If trim(ar_report[i,0]) = 'rasp_kod' then ar_report[i,2]:= Edit6.Text;
                  If trim(ar_report[i,0]) = 'rasp_name' then ar_report[i,2]:= Edit5.Text;
                  If trim(ar_report[i,0]) = 'rasp_dates' then ar_report[i,2]:= DateEdit1.Text;
                  If trim(ar_report[i,0]) = 'rasp_datepo' then ar_report[i,2]:= DateEdit2.Text;
                  If trim(ar_report[i,0]) = 'rasp_date_active' then ar_report[i,2]:= DateEdit3.Text;
                  If trim(ar_report[i,0]) = 'rasp_station_kod' then
                     begin
                      If PageControl1.ActivePageIndex=0 then
                       ar_report[i,2]:= Stringgrid1.Cells[0,Stringgrid1.row];
                      If PageControl1.ActivePageIndex=2 then
                       ar_report[i,2]:= Stringgrid10.Cells[0,Stringgrid10.row];
                     end;
                   If trim(ar_report[i,0]) = 'rasp_station_name' then
                     begin
                      If PageControl1.ActivePageIndex=0 then
                       ar_report[i,2]:= Stringgrid1.Cells[1,Stringgrid1.row];
                      If PageControl1.ActivePageIndex=2 then
                       ar_report[i,2]:= Stringgrid10.Cells[1,Stringgrid10.row];
                     end;
                  If (trim(ar_report[i,0])='rasp_atp_kod') AND (PageControl1.ActivePageIndex=1) then ar_report[i,2]:= Stringgrid8.Cells[0,Stringgrid8.row];
                  If trim(ar_report[i,0]) = 'rasp_atp_name' then
                     begin
                      If PageControl1.ActivePageIndex=1 then
                       ar_report[i,2]:= Stringgrid8.Cells[1,Stringgrid8.row];
                      If PageControl1.ActivePageIndex=2 then
                       ar_report[i,2]:= Stringgrid6.Cells[1,Stringgrid6.row];
                     end;
                end;
 end;
end;



///********************* ОСВОБОЖДЕНИЕ МАССИВОВ ***************************************
procedure TForm16.MasFree();
begin
  //освобождение памяти, занимаемой массивами
   SetLength(m_sostav,0,0);
   m_sostav := nil;
   SetLength(mas_date,0,0);
   mas_date := nil;
   SetLength(tarif_all,0,0);
   tarif_all := nil;
   SetLength(uslugi_all,0,0);
   uslugi_all := nil;
   SetLength(lgoty_all,0,0);
   lgoty_all := nil;
   SetLength(atp_sostav,0,0);
   atp_sostav := nil;
   SetLength(ats_sostav,0,0);
   ats_sostav := nil;
   SetLength(tmp_arr,0,0);
   tmp_arr := nil;
   SetLength(tarif_sostav,0,0);
   tarif_sostav := nil;
   SetLength(tarif_uslugi,0,0);
   tarif_uslugi := nil;
end;


//==================Обновляем все Grid-ы тарифов по условию id АТП =======================
procedure TForm16.Refresh_all_grid(id_atp:string);
 var
   n,m:integer;
   flt: byte=0;

begin
   IF trim(id_atp)='0' then exit;
  IF trim(id_atp)='' then exit;
  If form16.StringGrid6.RowCount<3 then exit;
 If form16.PageControl1.ActivePageIndex<>2 then
  begin
   exit;
  end;
  rfresh:=true;//флаг обновления данных на гриде
   //showmessage('2');//$
// ================================================= TARIF_ALL=========================================
  //  tarif_all - Описание
//-------------------------------------------------------
//  tarif_all[n,0]:= ;  id остановочного пункта
//  tarif_all[n,1]:= ;  Наименование остановочного пункта
//  tarif_all[n,2]:= ;  Путь в км.
//  tarif_all[n,3]:= ;  Жесткий М2
//  tarif_all[n,4]:= ;  Жесткий М3
//  tarif_all[n,5]:= ;  Мягкий М2
//  tarif_all[n,6]:= ;  Мягкий М3
//  tarif_all[n,7]:= ;  Цена БАГАЖ
//  tarif_all[n,8]:= ;  Тариф Жесткий М2
//  tarif_all[n,9]:= ;  Тариф Жесткий М3
// tarif_all[n,10]:= ;  Тариф Мягкий М2
// tarif_all[n,11]:= ;  Тариф Мягкий М3
// tarif_all[n,12]:= ;  тип расчета Багажа 0-автоматом,1-сумма,2-процент от билета
// tarif_all[n,13]:= ;  id АТП
// tarif_all[n,14]:= ;  flag редактирования 0-автомат,1-ручной

   form16.StringGrid10.RowCount:=1;
   form16.StringGrid2.RowCount:=1;
   If Form16.Stringgrid6.cells[3,Form16.Stringgrid6.row]='1' then form16.GroupBox2.Enabled:=true
   else form16.GroupBox2.Enabled:=false;
   form16.FloatSpinEdit1.value:=0.00;
   form16.FloatSpinEdit2.value:=0.00;
   form16.FloatSpinEdit3.value:=0.00;
   form16.FloatSpinEdit4.value:=0.00;
   form16.FloatSpinEdit5.value:=0.00;

   flt:=0;
   for n:=0 to length(tarif_all)-1 do
       begin
         if trim(tarif_all[n,13])=trim(id_atp) then
          begin
           flt:=1;
         //Stringgrid10
         form16.StringGrid10.RowCount:=form16.StringGrid10.RowCount+1;
         form16.StringGrid10.cells[0,form16.StringGrid10.RowCount-1]:=tarif_all[n,0];
         form16.StringGrid10.cells[1,form16.StringGrid10.RowCount-1]:=tarif_all[n,1];
         form16.StringGrid10.cells[2,form16.StringGrid10.RowCount-1]:=tarif_all[n,2];
         form16.StringGrid10.cells[3,form16.StringGrid10.RowCount-1]:=tarif_all[n,3];
         form16.StringGrid10.cells[4,form16.StringGrid10.RowCount-1]:=tarif_all[n,4];
         form16.StringGrid10.cells[5,form16.StringGrid10.RowCount-1]:=tarif_all[n,5];
         form16.StringGrid10.cells[6,form16.StringGrid10.RowCount-1]:=tarif_all[n,6];
          // тип расчета багажа
          form16.StringGrid10.cells[7,form16.StringGrid10.RowCount-1]:=tarif_all[n,7]+'p';
          Radiobutton1.Checked:=true;
          //если ручной тариф
          If Form16.Stringgrid6.cells[3,Form16.Stringgrid6.row]='1' then
           begin
            form16.FloatSpinEdit2.text:= tarif_all[n,7];
          if trim(tarif_all[n,12])='2' then
           begin
            If pos('.',tarif_all[n,7])>0 then
             form16.StringGrid10.cells[7,form16.StringGrid10.RowCount-1]:=copy(tarif_all[n,7],1,pos('.',tarif_all[n,7])-1)+'%'
             else
              form16.StringGrid10.cells[7,form16.StringGrid10.RowCount-1]:=tarif_all[n,7]+'%';
           Radiobutton2.Checked:=true;
         end;
          end;

         // StringGrid2 скрытый
         form16.StringGrid2.RowCount:=form16.StringGrid2.RowCount+1;
         form16.StringGrid2.cells[0,form16.StringGrid2.RowCount-1]:=tarif_all[n,8];
         form16.StringGrid2.cells[1,form16.StringGrid2.RowCount-1]:=tarif_all[n,9];
         form16.StringGrid2.cells[2,form16.StringGrid2.RowCount-1]:=tarif_all[n,10];
         form16.StringGrid2.cells[3,form16.StringGrid2.RowCount-1]:=tarif_all[n,11];
         //form16.StringGrid2.cells[4,form16.StringGrid2.RowCount-1]:=tarif_all[n,12];


         form16.FloatSpinEdit3.text:=tarif_all[n,8];
         form16.FloatSpinEdit5.text:=tarif_all[n,9];
         form16.FloatSpinEdit1.text:=tarif_all[n,10];
         form16.FloatSpinEdit4.text:=tarif_all[n,11];
         //если тарифы для разных пунктов отличаются, то отображать нули на счетчиках
         If  (not fltarif) and (n>0) then
          begin
          //showmessage(floattostr(form16.FloatSpinEdit3.value)+'<>'+(tarif_all[n,8])+#13+
          //trim(stringreplace(FloatSpinEdit5.text,',','.',[]))+'<>'+trim(tarif_all[n,9])+#13+
          //trim(stringreplace(FloatSpinEdit1.text,',','.',[]))+'<>'+trim(tarif_all[n,10])+#13+
          //trim(stringreplace(FloatSpinLabel4.caption,',','.',[]))+'<>'+trim(tarif_all[n,11])+#13);
          //If floattostrf(form16.FloatSpinEdit3.value,fffixed,15,2)<>floattostrf(strtofloat(tarif_all[n,8])),fffixed,15,2)  then showmessage(floattostr(form16.FloatSpinEdit3.value)+'<1>'+(tarif_all[n,8]));
          //If form16.FloatSpinEdit5.value<>strtofloat(tarif_all[n,9])  then showmessage(floattostr(form16.FloatSpinEdit5.value)+'<2>'+(tarif_all[n,9]));
          //If form16.FloatSpinEdit1.value=strtofloat(tarif_all[n,10]) then showmessage(floattostr(form16.FloatSpinEdit1.value)+'<3>'+(tarif_all[n,10]));
          //If floattostrf(form16.FloatSpinEdit4.value,fffixed,15,2)<>floattostrf(strtofloat(tarif_all[n,11]),fffixed,15,2) then showmessage(floattostr(form16.FloatSpinEdit4.value)+'<4>'+(tarif_all[n,11]));
          //
          If floattostrf(form16.FloatSpinEdit3.value,fffixed,15,2)<>floattostrf(strtofloat(tarif_all[n,8]),fffixed,15,2) then form16.FloatSpinEdit3.value:=0.00;
          If floattostrf(form16.FloatSpinEdit5.value,fffixed,15,2)<>floattostrf(strtofloat(tarif_all[n,9]),fffixed,15,2) then form16.FloatSpinEdit5.value:=0.00;
          If floattostrf(form16.FloatSpinEdit1.value,fffixed,15,2)<>floattostrf(strtofloat(tarif_all[n,10]),fffixed,15,2) then form16.FloatSpinEdit1.value:=0.00;
          If floattostrf(form16.FloatSpinEdit4.value,fffixed,15,2)<>floattostrf(strtofloat(tarif_all[n,11]),fffixed,15,2) then form16.FloatSpinEdit4.value:=0.00;
         end;
      end;
    end;
   //showmessage(inttostr(n));
   //если не нашли перевозчика в массиве тарифов, то рассчитываем автоматом
  { If (flt=0) and (flag_edit_shedule<>1) then
    begin
    //showmessage(id_atp);//$
    If not(tarif_auto(id_atp)) then
     begin
     rfresh:=false;//флаг обновления данных на гриде
     exit;
     end;
    If (length(tarif_all)>1) then
    Refresh_all_grid(id_atp);
    end;
   }
   // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ TARIF_ALL^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  // ================================ LGOTY_ALL=========================================
  //  lgoty_all - Описание
  //-------------------------------------------------------
  //  lgoty_all[n,0]:= ;  активность
  //  lgoty_all[n,1]:= ;  id льготы
  //  lgoty_all[n,2]:= ;  Наименование Льготы
  //  lgoty_all[n,3]:= ;  Закон
  //  lgoty_all[n,4]:= ;  Сумма
  //  lgoty_all[n,5]:= ;  Процент
  //  lgoty_all[n,6]:= ;  id АТП
  form16.StringGrid12.RowCount:=1;
  for n:=0 to length(lgoty_all)-1 do
      begin
        if trim(lgoty_all[n,6])=trim(id_atp) then
         begin
           form16.StringGrid12.RowCount:=form16.StringGrid12.RowCount+1;
           form16.StringGrid12.cells[0,form16.StringGrid12.RowCount-1]:=lgoty_all[n,0];
           form16.StringGrid12.cells[1,form16.StringGrid12.RowCount-1]:=lgoty_all[n,1];
           form16.StringGrid12.cells[2,form16.StringGrid12.RowCount-1]:=lgoty_all[n,2];
           form16.StringGrid12.cells[3,form16.StringGrid12.RowCount-1]:=lgoty_all[n,3];
           form16.StringGrid12.cells[4,form16.StringGrid12.RowCount-1]:=lgoty_all[n,4];
           form16.StringGrid12.cells[5,form16.StringGrid12.RowCount-1]:=lgoty_all[n,5];
         end;
      end;
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ LGOTY_ALL ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  // ================================ USLUGI_ALL=========================================
  //  uslugi_all - Описание
  //-------------------------------------------------------
  //  uslugi_all[n,0]:= ;  активность
  //  uslugi_all[n,1]:= ;  id льготы
  //  uslugi_all[n,2]:= ;  Наименование Льготы
  //  uslugi_all[n,3]:= ;  Сумма
  //  uslugi_all[n,4]:= ;  Процент
  //  uslugi_all[n,5]:= ;  id АТП
  form16.StringGrid11.RowCount:=1;
  for n:=0 to length(uslugi_all)-1 do
      begin
        if trim(uslugi_all[n,5])=trim(id_atp) then
         begin
           form16.StringGrid11.RowCount:=form16.StringGrid11.RowCount+1;
           form16.StringGrid11.cells[0,form16.StringGrid11.RowCount-1]:=uslugi_all[n,0];
           form16.StringGrid11.cells[1,form16.StringGrid11.RowCount-1]:=uslugi_all[n,1];
           form16.StringGrid11.cells[2,form16.StringGrid11.RowCount-1]:=uslugi_all[n,2];
           form16.StringGrid11.cells[3,form16.StringGrid11.RowCount-1]:=uslugi_all[n,3];
           form16.StringGrid11.cells[4,form16.StringGrid11.RowCount-1]:=uslugi_all[n,4];
         end;
      end;
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ USLUGI_ALL ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  // ================================= MAS_DATE=========================================
  //  mas_date - Описание
  //-------------------------------------------------------
  //   mas_date[n,0]:= ;  id АТП
  //   mas_date[n,1]-[n,12]:= ;  Номера месяцев
  //   mas_date[n,13]:= ;        Категория /Дни месяца
  //   mas_date[n,15]:= ;        Категория /Переодичность\недели
  //   mas_date[n,16]-[n,19]:= ; Недели
  //   mas_date[n,20]-[n,26]:= ; Дни недели
  //   mas_date[n,27]-[n,29]:= ; Периодичность
  //   mas_date[n,30]-[n,60]:= ; Дни месяца
  //   mas_date[n,61]:= ;        Категория /Осуществление перевозки каждый n день
  //   mas_date[n,62]:= ;        Каждый n день

    //k := length(mas_date);
    If id_atp='0' then
     begin
     rfresh:=false;//флаг обновления данных на гриде
     exit;
     end;
    for n:=low(mas_date) to high(mas_date) do
      begin
        if trim(mas_date[n,0])=trim(id_atp) then
         begin
        // Месяцы
        for m:=1 to 12 do
          begin
            if trim(mas_date[n,m])='1' then form16.CheckGroup3.Checked[m-1]:=true else form16.CheckGroup3.Checked[m-1]:=false;
          end;
         // Категория /Дни месяца
          if trim(mas_date[n,13])='1' then form16.RadioButton5.Checked:=true else form16.RadioButton5.Checked:=false;
        // Категория /Переодичность\недели
        if trim(mas_date[n,15])='1' then form16.RadioButton4.Checked:=true else form16.RadioButton4.Checked:=false;
        // недели
        for m:=16 to 19 do
          begin
            if trim(mas_date[n,m])='1' then form16.CheckGroup1.Checked[m-16]:=true else form16.CheckGroup1.Checked[m-16]:=false;
          end;
        // дни недели
        for m:=20 to 26 do
          begin
           if trim(mas_date[n,m])='1' then form16.CheckGroup2.Checked[m-20]:=true else form16.CheckGroup2.Checked[m-20]:=false;
          end;
        // Периодичность
        if trim(mas_date[n,27])='1' then form16.CheckBox3.Checked:=true else form16.CheckBox3.Checked:=false;
        if trim(mas_date[n,28])='1' then form16.CheckBox4.Checked:=true else form16.CheckBox4.Checked:=false;
        if trim(mas_date[n,29])='1' then form16.CheckBox5.Checked:=true else form16.CheckBox5.Checked:=false;
        //Дни месяца
        for m:=30 to 60 do
          begin
           if trim(mas_date[n,m])='1' then form16.Checkgroup4.Checked[m-30]:=true else form16.Checkgroup4.Checked[m-30]:=false;
          end;
         // Категория /Осуществление перевозки каждый n день
        if not(trim(mas_date[n,61])='0') then
            form16.RadioButton3.Checked:=true else form16.RadioButton3.Checked:=false;
        // каждый n день
          try
           form16.SpinEdit1.Value:=strtoint(mas_date[n,62]);
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x01');
               rfresh:=false;//флаг обновления данных на гриде
               exit;
             end;
          end;
         end;
      end;
    rfresh:=false;//флаг обновления данных на гриде
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ MAS_DATE ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /// обновление гридов - КОНЕЦ
end;



//==================Обновляем все массивы tarif_all,mas_date,uslugi_all,lgoty_all все записи по условию id АТП + дата =======================
procedure TForm16.Refresh_arrays(id_atp:string; flag_erase:boolean);
 var
   tmp_mas:array of array of string;
   n,m,mn,max:integer;
   ss:string;
begin
  //если нет ни одного перевозчика - выход
  If form16.StringGrid6.RowCount<3 then exit;
  IF trim(id_atp)='0' then exit;
  IF trim(id_atp)='' then exit;
  //showmessage(inttostr(form16.PageControl1.ActivePageIndex));
  If form16.PageControl1.ActivePageIndex<>2 then
   begin
   exit;
   end;
  //If trim(id_atp)='105' then exit;

//:::::::::::::::::::::::   удаляем запись искомого АТП во всех массивах ::::::::::::::::::

  //showmessage('1');//$
  // ================================================= TARIF_ALL=========================================
  //  tarif_all - Описание
  //-------------------------------------------------------
  //  tarif_all[n,0]:= ;  id остановочного пункта
  //  tarif_all[n,1]:= ;  Наименование остановочного пункта
  //  tarif_all[n,2]:= ;  Путь в км.
  //  tarif_all[n,3]:= ;  Жесткий М2
  //  tarif_all[n,4]:= ;  Жесткий М3
  //  tarif_all[n,5]:= ;  Мягкий М2
  //  tarif_all[n,6]:= ;  Мягкий М3
  //  tarif_all[n,7]:= ;  Цена БАГАЖ
  //  tarif_all[n,8]:= ;  Тариф Жесткий М2
  //  tarif_all[n,9]:= ;  Тариф Жесткий М3
  // tarif_all[n,10]:= ;  Тариф Мягкий М2
  // tarif_all[n,11]:= ;  Тариф Мягкий М3
 // tarif_all[n,12]:= ;  тип расчета Багажа 0-автоматом,1-сумма,2-процент от билета
// tarif_all[n,13]:= ;  id АТП
// tarif_all[n,14]:= ;  flag редактирования 0-автомат,1-ручной

// Удалить элемент массива по коду атп
 // Если массив не определен то отваливаемся
 if (length(tarif_all)>0) then
     begin
  // Формируем tmp_mas
  SetLength(tmp_mas,0,0);
  for n:=0 to length(tarif_all)-1 do
    begin
      if not(trim(tarif_all[n,13])=trim(id_atp)) then
        begin
         SetLength(tmp_mas,length(tmp_mas)+1, tarif_size);
         for m:=0 to tarif_size-1 do
           begin
             tmp_mas[length(tmp_mas)-1,m]:=tarif_all[n,m];
           end;
        end;
    end;
  // Формируем новый tarif_all
  SetLength(tarif_all,0,0);
  for n:=0 to length(tmp_mas)-1 do
    begin
      SetLength(tarif_all,length(tarif_all)+1, tarif_size);
      for m:=0 to tarif_size-1 do
        begin
           tarif_all[length(tarif_all)-1,m]:=tmp_mas[n,m];
        end;
    end;
  end;
  // ********************************************** TARIF_ALL*******************************************

  // ================================================= LGOTY_ALL=========================================
  // Удалить элемент массива по коду атп
  //  lgoty_all - Описание
  //-------------------------------------------------------
  //  lgoty_all[n,0]:= ;  активность
  //  lgoty_all[n,1]:= ;  id льготы
  //  lgoty_all[n,2]:= ;  Наименование Льготы
  //  lgoty_all[n,3]:= ;  Закон
  //  lgoty_all[n,4]:= ;  Сумма
  //  lgoty_all[n,5]:= ;  Процент
  //  lgoty_all[n,6]:= ;  id АТП
   // Если массив не определен то отваливаемся
  if length(lgoty_all)>0 then
     begin
  // Формируем tmp_mas
  SetLength(tmp_mas,0,0);
  for n:=0 to length(lgoty_all)-1 do
    begin
      if not(trim(lgoty_all[n,6])=trim(id_atp)) then
        begin
         SetLength(tmp_mas,length(tmp_mas)+1, lgoty_size);
         for m:=0 to lgoty_size-1 do
           begin
             tmp_mas[length(tmp_mas)-1,m]:=lgoty_all[n,m];
           end;
        end;
    end;
  // Формируем новый lgoty_all
  SetLength(lgoty_all,0,0);
  for n:=0 to length(tmp_mas)-1 do
    begin
      SetLength(lgoty_all,length(lgoty_all)+1, lgoty_size);
      for m:=0 to lgoty_size-1 do
        begin
           lgoty_all[length(lgoty_all)-1,m]:=tmp_mas[n,m];
        end;
    end;
  end;
  // ********************************************** LGOTY_ALL*******************************************

  // ================================================= USLUGI_ALL=========================================
   // Удалить элемент массива по коду атп
  //  uslugi_all - Описание
  //-------------------------------------------------------
  //  uslugi_all[n,0]:= ;  активность
  //  uslugi_all[n,1]:= ;  id льготы
  //  uslugi_all[n,2]:= ;  Наименование Льготы
  //  uslugi_all[n,3]:= ;  Сумма
  //  uslugi_all[n,4]:= ;  Процент
  //  uslugi_all[n,5]:= ;  id АТП
  // Если массив не определен то отваливаемся
   if length(uslugi_all)>0 then
      begin
   // Формируем tmp_mas
   SetLength(tmp_mas,0,0);
   for n:=0 to length(uslugi_all)-1 do
     begin
       if not(trim(uslugi_all[n,5])=trim(id_atp)) then
         begin
          SetLength(tmp_mas,length(tmp_mas)+1, uslugi_size);
          for m:=0 to uslugi_size-1 do
            begin
              tmp_mas[length(tmp_mas)-1,m]:=uslugi_all[n,m];
            end;
         end;
     end;
   // Формируем новый uslugi_all
   SetLength(uslugi_all,0,0);
   for n:=0 to length(tmp_mas)-1 do
     begin
       SetLength(uslugi_all,length(uslugi_all)+1, uslugi_size);
       for m:=0 to uslugi_size-1 do
         begin
            uslugi_all[length(uslugi_all)-1,m]:=tmp_mas[n,m];
         end;
     end;
   end;
  // ********************************************** USLUGI_ALL*******************************************

  // ================================================= MAS_DATE=========================================
  // Удалить элемент массива по коду атп
  // Если массив не определен то отваливаемся
   if length(mas_date)>0 then
      begin
   // Формируем tmp_mas
   SetLength(tmp_mas,0,0);
   for n:=0 to length(mas_date)-1 do
     begin
       if not(trim(mas_date[n,0])=trim(id_atp)) then
         begin
          SetLength(tmp_mas,length(tmp_mas)+1, sezon_size);
          for m:=0 to sezon_size-1 do
            begin
              tmp_mas[length(tmp_mas)-1,m]:=mas_date[n,m];
            end;
         end;
     end;
   // Формируем новый mas_date
   SetLength(mas_date,0,0);
   for n:=0 to length(tmp_mas)-1 do
     begin
       SetLength(mas_date,length(mas_date)+1, sezon_size);
       for m:=0 to sezon_size-1 do
         begin
            mas_date[length(mas_date)-1,m]:=tmp_mas[n,m];
         end;
     end;
   end;
  //--------  MAS_DATE
 SetLength(tmp_mas,0,0);
 //tmp_mas := nil;

 If flag_erase then
  begin
   //sleep(1);
   //showmessage('OO-hhh');//$
   exit; //если только удалить атп из массивов, то выход
  end;

 //============    записываем новые значения  ===========================

 // ======== TARIF_ALL=========================================
  if (form16.StringGrid10.RowCount>1) then
     begin
       for n:=1 to form16.StringGrid10.RowCount-1 do
         begin
           SetLength(tarif_all,length(tarif_all)+1, tarif_size);

           //Stringgrid10
           tarif_all[length(tarif_all)-1,0]:=form16.StringGrid10.cells[0,n];
           tarif_all[length(tarif_all)-1,1]:=form16.StringGrid10.cells[1,n];
           tarif_all[length(tarif_all)-1,2]:=form16.StringGrid10.cells[2,n];
           tarif_all[length(tarif_all)-1,3]:=form16.StringGrid10.cells[3,n];
           tarif_all[length(tarif_all)-1,4]:=form16.StringGrid10.cells[4,n];
           tarif_all[length(tarif_all)-1,5]:=form16.StringGrid10.cells[5,n];
           tarif_all[length(tarif_all)-1,6]:=form16.StringGrid10.cells[6,n];
            //цена багажа
            If (pos('%',trim(form16.StringGrid10.cells[7,n]))>0) or (pos('p',trim(form16.StringGrid10.cells[7,n]))>0) then
           tarif_all[length(tarif_all)-1,7]:=copy(trim(form16.StringGrid10.cells[7,n]),1,length(trim(form16.StringGrid10.cells[7,n]))-1);
           // StringGrid2 скрытый
           tarif_all[length(tarif_all)-1,8]:=form16.StringGrid2.cells[0,n];
           tarif_all[length(tarif_all)-1,9]:=form16.StringGrid2.cells[1,n];
           tarif_all[length(tarif_all)-1,10]:=form16.StringGrid2.cells[2,n];
           tarif_all[length(tarif_all)-1,11]:=form16.StringGrid2.cells[3,n];
           //tarif_all[length(tarif_all)-1,12]:=form16.StringGrid2.cells[4,n];
           tarif_all[length(tarif_all)-1,13]:=trim(id_atp);
           tarif_all[length(tarif_all)-1,14]:=form16.StringGrid6.cells[3,form16.StringGrid6.row];//тип расчета 0-авто 1-ручной
           tarif_all[length(tarif_all)-1,12]:='0';//тип рассчета багажа
            //если ручной тариф
           If form16.StringGrid6.cells[3,form16.StringGrid6.row]='1' then
              begin
           if form16.RadioButton1.Checked then tarif_all[length(tarif_all)-1,12]:='1';//багаж сумма
           if form16.RadioButton2.Checked then tarif_all[length(tarif_all)-1,12]:='2';//багаж процент от билета
              end;
         end;
     end;
  //form16.FloatSpinEdit1.value:=1.11;
  //form16.FloatSpinEdit2.value:=10;
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ TARIF_ALL ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  // ================================ LGOTY_ALL=========================================

  if form16.StringGrid12.RowCount>1 then
     begin
       for n:=1 to form16.StringGrid12.RowCount-1 do
         begin
           SetLength(lgoty_all,length(lgoty_all)+1, lgoty_size);
           lgoty_all[length(lgoty_all)-1,0]:=form16.StringGrid12.cells[0,n];
           lgoty_all[length(lgoty_all)-1,1]:=form16.StringGrid12.cells[1,n];
           lgoty_all[length(lgoty_all)-1,2]:=form16.StringGrid12.cells[2,n];
           lgoty_all[length(lgoty_all)-1,3]:=form16.StringGrid12.cells[3,n];
           lgoty_all[length(lgoty_all)-1,4]:=StringReplace(form16.StringGrid12.cells[4,n],',','.',[rfReplaceAll]);
           lgoty_all[length(lgoty_all)-1,5]:=StringReplace(form16.StringGrid12.cells[5,n],',','.',[rfReplaceAll]);
           lgoty_all[length(lgoty_all)-1,6]:=trim(id_atp);
         end;
     end;
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ LGOTY_ALL ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  // ================================ USLUGI_ALL=========================================
   if form16.StringGrid11.RowCount>1 then
     begin
       for n:=1 to form16.StringGrid11.RowCount-1 do
         begin
           SetLength(uslugi_all,length(uslugi_all)+1, uslugi_size);
           uslugi_all[length(uslugi_all)-1,0]:=form16.StringGrid11.cells[0,n];
           uslugi_all[length(uslugi_all)-1,1]:=form16.StringGrid11.cells[1,n];
           uslugi_all[length(uslugi_all)-1,2]:=form16.StringGrid11.cells[2,n];
           uslugi_all[length(uslugi_all)-1,3]:=StringReplace(form16.StringGrid11.cells[3,n],',','.',[rfReplaceAll]);
           uslugi_all[length(uslugi_all)-1,4]:=StringReplace(form16.StringGrid11.cells[4,n],',','.',[rfReplaceAll]);
           uslugi_all[length(uslugi_all)-1,5]:=trim(id_atp);
         end;
     end;
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ USLUGI_ALL ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// ================================= Mas_DATE =========================================
 //  mas_date - Описание
 //-------------------------------------------------------
 //   mas_date[n,0]:= ;  id АТП
 //   mas_date[n,1]-[n,12]:= ;  Номера месяцев
 //   mas_date[n,13]:= ;        Категория /Дни месяца
 //   mas_date[n,15]:= ;        Категория /Переодичность\недели
 //   mas_date[n,16]-[n,19]:= ; Недели
 //   mas_date[n,20]-[n,26]:= ; Дни недели
 //   mas_date[n,27]-[n,29]:= ; Переодичность
 //   mas_date[n,30]-[n,60]:= ; Дни месяца
 //   mas_date[n,61]:= ;        Категория /Осуществление перевозки каждый n день
 //   mas_date[n,62]:= ;        Каждый n день
   If id_atp='0' then exit;
    //showmas(mas_date);//$
       SetLength(mas_date,length(mas_date)+1, sezon_size);
       // Код АТП
       mas_date[length(mas_date)-1,0]:=trim(id_atp);
       // Месяцы
       for n:=1 to 12 do
         begin
          mas_date[length(mas_date)-1,n]:=ifthen(form16.CheckGroup3.Checked[n-1]=true,'1','0');
         end;
       //Категория /Дни месяца
       mas_date[length(mas_date)-1,13]:=ifthen(form16.RadioButton5.Checked=true,'1','0');

       mas_date[length(mas_date)-1,14]:='0'; //резерв
       // Категория /Переодичность\недели
       mas_date[length(mas_date)-1,15]:=ifthen(form16.RadioButton4.Checked=true,'1','0');
       // недели
       for n:=16 to 19 do
         begin
          mas_date[length(mas_date)-1,n]:=ifthen(form16.CheckGroup1.Checked[n-16]=true,'1','0');
         end;
       ss:='';
       // дни недели
       for n:=20 to 26 do
         begin
          mas_date[length(mas_date)-1,n]:=ifthen(form16.CheckGroup2.Checked[n-20]=true,'1','0');
          ss:=ss+ifthen(form16.CheckGroup2.Checked[n-20]=true,'1','0');
         end;
       //showmessage(id_atp+#13+ss);//$
       // Переодичность
       mas_date[length(mas_date)-1,27]:=ifthen(form16.CheckBox3.Checked=true,'1','0');
       mas_date[length(mas_date)-1,28]:=ifthen(form16.CheckBox4.Checked=true,'1','0');
       mas_date[length(mas_date)-1,29]:=ifthen(form16.CheckBox5.Checked=true,'1','0');
       // Дни месяца
       for n:=30 to 60 do
         begin
           mas_date[length(mas_date)-1,n]:=ifthen(form16.Checkgroup4.Checked[n-30]=true,'1','0');
         end;

   // Категория-  Осуществление перевозки каждый n день\
     // каждый n день
     mas_date[length(mas_date)-1,61]:='0';
     mas_date[length(mas_date)-1,62]:='0';

     If form16.RadioButton3.Checked then
        begin
         //если один перевозчик, то порядок у него всегда - 1, может менять через сколько дней он осуществляет перевозку
          mas_date[length(mas_date)-1,61]:='1';
          mas_date[length(mas_date)-1,62]:= inttostr(form16.SpinEdit1.Value);//Осуществление перевозки каждый n день

          //если перевозчиков больше одного, тогда это уже параметр порядка первозчиков выполения расписания
         If (length(atp_sostav)>1) then
           begin
             max:=0;
             //определяем максимальное значение очереди у перевозчиков
            for n:=low(mas_date) to high(mas_date) do
             begin
               //showmessage(mas_date[n,0]+' | '+mas_date[n,62]);
               mn:=0;
                  try
                     mn:= strtoINt(mas_date[n,62]);
                  except
                     on exception: EConvertError do
                     begin
                       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x02');
                       exit;
                     end;
                  end;
                   If mn>length(atp_sostav) then mn:=length(atp_sostav); //значение спина не может превышать кол-во перевозчиков
                   If mn>max then max:=mn;
             end;
            mas_date[length(mas_date)-1,61]:=inttostr(max);  // максимальный порядок перевозчика
            mas_date[length(mas_date)-1,62]:=inttostr(form16.SpinEdit1.Value); // Порядок первозчиков выполения расписания
            ////корректируем значения порядка перевозчиков
            //for n:=low(mas_date) to high(mas_date)-1 do
            // begin
            //   //если порядок 2-х перевозчиков совпадает, то ставим второму маскимальный
            //   If mas_date[n,61]=mas_date[n+1,61] then
            //     begin
            //     mas_date[n+1,61]:= inttostr(max);
            //     max:=max-1;
            //     end;
            // end;
           end;
           end;

        //возвращаем значение из массива в спин
         //form16.SpinEdit1.Text:= mas_date[length(mas_date)-1,62];
end;



//======================== Обновляем сетку ТАРИФА УСЛУГ СОСТАВА РАСПИСАНИЯ =======================
procedure TForm16.Update_uslugi_list();
 var
   n:integer;
begin
  With Form16 do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
    //===============ПРОВЕРКА НА РЕДАКТИРОВАНИЕ
    // Если новая запись расписания то берем данные из ТАРИФА на ЭТУ дату
    Form16.ZQuery1.SQL.Clear;
    Form16.ZQuery1.SQL.add('SELECT b.activ,b.id_uslugi,b.sum,b.proc FROM av_tarif a,av_tarif_uslugi b WHERE a.id = b.id_tarif and a.del=0 and b.del=0 and ');
    //Form16.ZQuery1.SQL.add('a.datetarif='+quotedstr(trim(form16.ComboBox4.Text))+' //2022-02-02 убить datetarif
    Form16.ZQuery1.SQL.add(' a.id_point=0;');
    try
      Form16.ZQuery1.open;
    except
     showmessagealt('ОШИБКА запроса к базе данных !'+#13+Form16.ZQuery1.SQL.Text);
     Form16.ZQuery1.Close;
     Form16.Zconnection1.disconnect;
    end;
    If  Form16.ZQuery1.RecordCount<1 then
     begin
      showmessagealt('ОШИБКА ! Невозможно выбрать уникальный тариф ! Отредактируйте основной тариф!');
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;


    // Если частный случай тарифа Услуг или льгот то удаляем из массива записи с текущем АТП
    if length(tarif_uslugi)>0 then
       begin

       end;

    // Сохраняем все в массиве
    SetLength(tarif_uslugi,0,0);
    for n:=0 to form16.ZQuery1.RecordCount-1 do
      begin
         SetLength(tarif_uslugi,length(tarif_uslugi)+1,5);
         tarif_uslugi[length(tarif_uslugi)-1,0]:='0'; //id АТП
         tarif_uslugi[length(tarif_uslugi)-1,1]:=form16.ZQuery1.FieldByName('activ').asString; //Activ
         tarif_uslugi[length(tarif_uslugi)-1,2]:=form16.ZQuery1.FieldByName('id_uslugi').asString; //id услуги
         tarif_uslugi[length(tarif_uslugi)-1,3]:=form16.ZQuery1.FieldByName('sum').asString; // Сумма услуги
         tarif_uslugi[length(tarif_uslugi)-1,4]:=form16.ZQuery1.FieldByName('proc').asString; //Процент услуги
         form16.ZQuery1.next;
      end;
    end;
  end;


//***************  взять нормативы из основного тарифа ******************************************
procedure TForm16.getNorma();
var
  n:integer=0;
begin
  with Form16 do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('SELECT kmh,deti FROM av_tarif WHERE del=0 AND datetarif=(Select MAX(datetarif) as newest FROM av_tarif WHERE del=0);');
    try
      ZQuery1.open;
    except
     showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
    end;
    If  ZQuery1.RecordCount<>1 then
     begin
      showmessagealt('ОШИБКА ! Невозможно выбрать уникальный тариф ! Отредактируйте основной тариф!');
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;
   norma_KMH := ZQuery1.FieldByName('kmh').asInteger;
   norma_Deti := ZQuery1.FieldByName('deti').asInteger;

   // Определяем список доступных ДАТ начала действия тарифов
      ComboBox4.Items.Clear;
   // Максимальная для текущего тарифа
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT max(datetarif) as datetarif FROM av_tarif WHERE del=0 and datetarif<='+quotedstr(datetostr(date()))+';');
   try
     ZQuery1.open;
   except
    showmessagealt('ОШИБКА ! ОТСУТСТВУЕТ действующий ТАРИФ!'+#13+ZQuery1.SQL.Text);
    //ZQuery1.Close;
    //Zconnection1.disconnect;
   end;
   if ZQuery1.RecordCount>0 then
     begin
       ComboBox4.Items.Add(ZQuery1.FieldByName('datetarif').asString);
       combobox4.Text:=trim(ZQuery1.FieldByName('datetarif').asString);
     end;

   // Дата будущего тарифа
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT datetarif FROM av_tarif WHERE del=0 and datetarif>'+quotedstr(datetostr(date()))+';');
   try
     ZQuery1.open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
   end;
  for n:=1 to ZQuery1.RecordCount do
     begin
      ComboBox4.Items.Add(ZQuery1.FieldByName('datetarif').asString);
      Zquery1.Next;
    end;

   form16.ZQuery1.close;
   form16.ZConnection1.disconnect;
   ComboBox4.ItemIndex:=0;
 end;
end;

//Временные характеристики расписания
procedure TForm16.Check_sezon();
  begin
    //Если выбрано RB3 каждые n дней
    if form16.RadioButton3.Checked then
       begin
         form16.GroupBox9.enabled:=false;
         form16.CheckBox3.Enabled:=false;
         form16.CheckBox4.Enabled:=false;
         form16.CheckGroup1.Enabled:=false;
         form16.CheckGroup2.Enabled:=false;
         form16.CheckGroup4.Enabled:=false;
         form16.CheckBox5.Enabled:=false;
         form16.Label36.Enabled:=true;
         form16.Label37.Enabled:=true;
         form16.SpinEdit1.Enabled:=true;
       end;
    //Если выбрано RB4 недели
    if form16.RadioButton4.Checked then
       begin
         form16.GroupBox9.enabled:=true;
         form16.CheckBox3.Enabled:=true;
         form16.CheckBox4.Enabled:=true;
         form16.CheckGroup1.Enabled:=true;
         form16.CheckGroup2.Enabled:=true;
         form16.CheckGroup4.Enabled:=false;
         form16.CheckBox5.Enabled:=true;
         form16.Label36.Enabled:=false;
         form16.Label37.Enabled:=false;
         form16.SpinEdit1.Enabled:=false;
       end;
    //Если выбрано RB5 числа месяца
    if form16.RadioButton5.Checked then
       begin
         form16.GroupBox9.enabled:=false;
         form16.CheckBox3.Enabled:=false;
         form16.CheckBox4.Enabled:=false;
         form16.CheckGroup1.Enabled:=false;
         form16.CheckGroup2.Enabled:=false;
         form16.CheckGroup4.Enabled:=true;
         form16.CheckBox5.Enabled:=false;
         form16.Label36.Enabled:=false;
         form16.Label37.Enabled:=false;
         form16.SpinEdit1.Enabled:=false;
       end;
  end;

// =============================Сетка АТП ==========================================
procedure TForm16.UpdateGridATP();
 var
   n:integer;
begin
  with form16 do
  begin
     form16.StringGrid6.Columns[3].ValueChecked:='1';
     form16.StringGrid6.Columns[3].ValueUnchecked:='0';
     form16.StringGrid6.RowCount:=2;
     form16.StringGrid8.RowCount:=1;

      for n:=low(atp_sostav) to high(atp_sostav) do
          begin
           StringGrid8.RowCount := StringGrid8.RowCount+1;
            form16.StringGrid8.cells[0,StringGrid8.RowCount-1]:=atp_sostav[n,0];
            form16.StringGrid8.cells[1,StringGrid8.RowCount-1]:=atp_sostav[n,1];
            form16.StringGrid6.RowCount:=form16.StringGrid6.RowCount+1;
           form16.StringGrid6.cells[0,form16.StringGrid6.RowCount-1]:=atp_sostav[n,0]; //ид перевозчика
           form16.StringGrid6.cells[1,form16.StringGrid6.RowCount-1]:=atp_sostav[n,1]; //наименование перевозчика
           form16.StringGrid6.cells[2,form16.StringGrid6.RowCount-1]:=atp_sostav[n,4]; //код реестра
           form16.StringGrid6.cells[3,form16.StringGrid6.RowCount-1]:=atp_sostav[n,3]; //тип расчета тарифа
           //form16.StringGrid6.Row := form16.StringGrid6.RowCount-1;
          end;
      //form16.StringGrid8.Repaint;
      form16.StringGrid8.Row := form16.StringGrid8.RowCount-1;
      form16.StringGrid6.Row := form16.StringGrid6.RowCount-1;//^
      //Категория-  Порядок перевозчиков выполения расписания
     If (length(atp_sostav)>1) then
       begin
         form16.Label36.Caption := 'Порядок выхода перевозчика: ';
         form16.Label37.Visible:= false;
         form16.SpinEdit1.MaxValue := length(atp_sostav);
       end
      else
      begin
        form16.Label36.Caption := 'Осуществление перевозки каждый:';
        form16.Label37.Visible:= true;
        form16.SpinEdit1.MaxValue := 365;
      end;
  end;
end;

procedure TForm16.StringGrid8Selection(Sender: TObject; aCol, aRow: Integer);
begin
  form16.UpdateGridATS();
end;

procedure TForm16.StringGrid9Enter(Sender: TObject);
begin
  //вкладка атп изменения машин
   flatp := true;
end;

procedure TForm16.StringGrid9SetCheckboxState(Sender: TObject; ACol,ARow: Integer; const Value: TCheckboxState);
 var
   n:integer;
begin
    // Устанавливаем АТС по умолчанию
    if form16.StringGrid9.Col=6 then
      begin
              //for n:=0 to length(ats_sostav)-1 do
              //    begin
              //      if trim(ats_sostav[n,6])=trim(form16.StringGrid8.Cells[0,form16.StringGrid8.Row]) then
              //        begin
              //         ats_sostav[n,7]:='0';
              //        end;
              //    end;
              //for n:=0 to length(ats_sostav)-1 do
              //    begin
              //      if (trim(ats_sostav[n,6])=trim(form16.StringGrid8.Cells[0,form16.StringGrid8.Row])) and (trim(ats_sostav[n,0])=trim(form16.StringGrid9.Cells[0,form16.StringGrid9.Row])) then
              //        begin
              //         ats_sostav[n,7]:='1';
              //        end;
              //    end;

              atp_sostav[form16.StringGrid8.row-1,2]:=trim(form16.StringGrid9.Cells[0,form16.StringGrid9.Row]);//атс по умолчанию в массиве атп

              for n:=1 to form16.StringGrid9.rowcount-1 do
                  begin
                    form16.StringGrid9.cells[6,n]:='0';
                  end;
              form16.StringGrid9.cells[6,form16.StringGrid9.row]:='1';
      end;
    // Устанавливаем активное АТС
    if form16.StringGrid9.Col=5 then
      begin
              for n:=0 to length(ats_sostav)-1 do
                  begin
                    if (trim(ats_sostav[n,6])=trim(form16.StringGrid8.Cells[0,form16.StringGrid8.Row])) and (trim(ats_sostav[n,0])=trim(form16.StringGrid9.Cells[0,form16.StringGrid9.Row])) then
                      begin
                       if trim(form16.StringGrid9.cells[5,form16.StringGrid9.row])='1' then ats_sostav[n,5]:='0' else ats_sostav[n,5]:='1';
                      end;
                  end;
              if form16.StringGrid9.cells[5,form16.StringGrid9.row]='1' then form16.StringGrid9.cells[5,form16.StringGrid9.row]:='0' else form16.StringGrid9.cells[5,form16.StringGrid9.row]:='1';
      end;
end;



procedure TForm16.PageControl1Change(Sender: TObject);
begin
  with form16 do
  begin
  //вкладка опции
  If PageControl1.ActivePage=TabSheet6 then
    begin
     Refresh_all_grid(trim(StringGrid6.cells[0,StringGrid6.row]));  //Обновляем все Grid-ы тарифов по условию id АТП
    end;
  end;
end;



//багаж проценты/рубли
procedure TForm16.RadioButton1Change(Sender: TObject);
 var
    n : integer;
    bag:string;
 begin
  If rfresh then exit;//флаг обновления данных на гриде
   fltarif:= true;
 bag:= stringreplace(form16.FloatSpinEdit2.text,',','.',[]);
    for n:=0 to length(tarif_all)-1 do
     begin
       If tarif_all[n,13]=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
        begin
        tarif_all[n,7]:=bag;
        if form16.RadioButton1.Checked then tarif_all[n,12]:='1';
        if form16.RadioButton2.Checked then tarif_all[n,12]:='2';
        end;
   end;
   Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));
end;

//багаж проценты/рубли
procedure TForm16.RadioButton2Change(Sender: TObject);
  var
   n : integer;
   bag:string;
begin
 If rfresh then exit;//флаг обновления данных на гриде
  fltarif:= true;
 bag:= stringreplace(form16.FloatSpinEdit2.text,',','.',[]);
    for n:=0 to length(tarif_all)-1 do
     begin
       If tarif_all[n,13]=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
        begin
        tarif_all[n,7]:=bag;
        if form16.RadioButton1.Checked then tarif_all[n,12]:='1';
        if form16.RadioButton2.Checked then tarif_all[n,12]:='2';
        end;
   end;
   Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));
end;

procedure TForm16.TabSheet7Enter(Sender: TObject);
begin
   //вкладка тарифа
   fltarif:= true;
end;

//уход с вкладки тарифа
procedure TForm16.TabSheet7Exit(Sender: TObject);
begin
   Refresh_arrays(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]),false);    // Обновляем все массивы по условию id АТП
end;

procedure TForm16.TabSheet8Enter(Sender: TObject);
begin
  //вкладка сезон
   flsezon:= true;
end;

procedure TForm16.TabSheet9Enter(Sender: TObject);
begin
  //вкладка услуг и льгот
   fluslugi := true;
end;


// =============================Сетка АТС ==========================================
procedure TForm16.UpdateGridATS();
 var
   n:integer;
begin
      form16.StringGrid9.RowCount:=1;
      If form16.StringGrid8.RowCount < 2 then exit;
      form16.StringGrid9.Columns[5].ValueChecked:='1';
      form16.StringGrid9.Columns[5].ValueUnchecked:='0';
      form16.StringGrid9.Columns[6].ValueChecked:='1';
      form16.StringGrid9.Columns[6].ValueUnchecked:='0';
      for n:=0 to length(ats_sostav)-1 do
          begin
           if trim(ats_sostav[n,6])=trim(form16.StringGrid8.Cells[0,form16.StringGrid8.row]) then
             begin
               form16.StringGrid9.RowCount:=form16.StringGrid9.RowCount+1;
               form16.StringGrid9.cells[0,form16.StringGrid9.RowCount-1]:=ats_sostav[n,0]; //Код
               // наименование АТС по умолчанию
               form16.StringGrid9.cells[1,form16.StringGrid9.RowCount-1]:=ats_sostav[n,1]; //Марка
               form16.StringGrid9.cells[2,form16.StringGrid9.RowCount-1]:=ats_sostav[n,2]; //Этажей  Госномер
               form16.StringGrid9.cells[3,form16.StringGrid9.RowCount-1]:=ats_sostav[n,3]; //Всего мест
               form16.StringGrid9.cells[4,form16.StringGrid9.RowCount-1]:=ats_sostav[n,4]; //Тип
               form16.StringGrid9.cells[5,form16.StringGrid9.RowCount-1]:=ats_sostav[n,5]; //Флаг активности
               //if not(trim(ats_sostav[n,7])='0') then
               //  form16.StringGrid9.cells[6,form16.StringGrid9.RowCount-1]:='1' //Флаг АТС по умолчанию
               //else
               //  form16.StringGrid9.cells[6,form16.StringGrid9.RowCount-1]:='0'; //Флаг АТС по умолчанию
               if (trim(ats_sostav[n,0])=trim(atp_sostav[form16.StringGrid8.row-1,2])) then
                 form16.StringGrid9.cells[6,form16.StringGrid9.RowCount-1]:='1' //Флаг АТС по умолчанию
               else
                 form16.StringGrid9.cells[6,form16.StringGrid9.RowCount-1]:='0'; //Флаг АТС по умолчанию
             end;
          end;
      // код АТС по умолчанию
      form16.StringGrid9.Repaint;
end;

//******************************  СОХРАНИТЬ ВСЕ **************************************************************
procedure TForm16.BitBtn5Click(Sender: TObject);
begin
  Form16.save_shedule();
end;

//********************************  записываем данные по расписанию ****************************************
procedure TForm16.save_shedule();
 var
   n,m,k,norder,j : integer;
   str_query,smess, kodatp, zdog:string;
   atplist:string=''; //строка с id перевозчиков
   flnosezon:boolean;
begin
  WIth FOrm16 do
  begin
    If not flchange and not flsostav and not flatp and not fltarif and not flsezon and not fluslugi and not flblock
     then
      begin
        showmessagealt('Сначала произведите изменения в расписании !');
        exit;
      end;

  // Проверяем на соответствие введенным данным
  smess:='';
  if (trim(form16.Edit1.text)='') then smess:=smess+'id маршрута '+#13;
  if (trim(form16.Edit3.text)='') then smess:=smess+'Код маршрута '+#13;
  if (trim(form16.Edit6.text)='') then smess:=smess+'Код расписания '+#13;
  if (trim(form16.Edit5.text)='') then smess:=smess+'Наименование расписания '+#13;
  if (trim(form16.Edit1.text)='') or
     (trim(form16.Edit3.text)='') or
     (trim(form16.Edit5.text)='') or
     (trim(form16.Edit6.text)='')
     then
          begin
            showmessagealt('Заполнены не все обязательные реквизиты расписания: '+#13+smess+'Сохранение невозможно !');
            exit;
          end;
   iF (form16.StringGrid1.RowCount<3) then
     begin
        showmessagealt('В составе расписания менее 2-х остановочных пунктов !'+#13+'Сохранение невозможно !');
        exit;
     end;
   //проверка перевозчика
   iF (form16.StringGrid8.RowCount=1) then
     begin
      showmessagealt('НЕ указан НИ один перевозчик к расписанию !'+#13+'Сохранение невозможно !');
      exit;
     end;
  {if (trim(form16.Edit18.text)='') or
     (trim(form16.Edit19.text)='') or
     (trim(form16.Edit21.text)='') or
     (trim(form16.Edit20.text)='')}
      {if (trim(form16.Edit18.text)='') or
     (trim(form16.Edit19.text)='')
     then
        begin
            showmessagealt('НЕ указано НИ одного АТС для расписания !'+#13+smess+'Сохранение невозможно !');
            exit;
        end;}

   Refresh_arrays(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]),false);    // Обновляем все массивы по условию id АТП

   //проверка активности АТС
  for m:=low(atp_sostav) to high(atp_sostav) do
    begin
      k := 0;
      j := 0;
      for n:=low(ats_sostav) to high(ats_sostav) do
       begin
         If trim(atp_sostav[m,0])=trim(ats_sostav[n,6]) then
         begin
           //проверка основного атс перевозчика
           If trim(atp_sostav[m,2])=trim(ats_sostav[n,0]) then
             begin
               j:=1;
               //атс основное но не активное - ошибка
               If trim(ats_sostav[n,5])='0' then break;
             end;
          If trim(ats_sostav[n,5])='1' then
            begin
              k:=1;
            end;
         end;
       end;
   If j=0 then
     begin
      showmessagealt('НЕ отмечено ОСНОВНОЕ транспортное средство для перевозчика: '+atp_sostav[m,1]+' !'+#13+'Сохранение невозможно !');
      exit;
     end;
   If (k=0) AND (j=0) then
     begin
      showmessagealt('Установите АКТИВНОСТЬ хотя бы одному транспортному средству перевозчика: '+atp_sostav[m,1]+' !'+#13+'Сохранение невозможно !');
      exit;
     end;
    If (k=0) AND (j=1) then
     begin
      showmessagealt('Основное транспортное средство НЕ является активным для перевозчика: '+atp_sostav[m,1]+' !'+#13+'Сохранение невозможно !');
      exit;
     end;
    end;

    //reestr ВЫЯСНЯЕМ БЫЛИ ЛИ ИЗМЕНЕНИЯ В КОДЕ РЕЕСТРА РАСПИСАНИЯ -ПЕРЕВОЗЧИК
   for n:=low(atp_sostav) to high(atp_sostav) do
          begin
           for k:=1 to Stringgrid6.RowCount-1 do
              begin
                If form16.StringGrid6.cells[0,k]=atp_sostav[n,0] then
                 If atp_sostav[n,4]<>form16.StringGrid6.cells[2,k] then
                  begin
                    flatp:= true;
                    atp_sostav[n,4]:=form16.StringGrid6.cells[2,k]; //код реестра reestr
                    end;
          end;
          end;

     //button3.click;
  //ПРОВЕРКА ТАРИФА И СЕЗОННОСТИ ДЛЯ КАЖДОГО ПЕРЕВОЗЧИКА
    //k:=0;
    //changes 21.05.2014 | n:=2
    for n:=1 to Stringgrid6.RowCount-1 do
      begin
       //проверка тарифа для каждого перевозчика

       for m:=low(tarif_all) to high(tarif_all) do
       begin
        If (StringGrid6.Cells[3,n]='0') then break; //тариф рассчитывается автоматически - ПРОПУСКАЕМ
         IF trim(StringGrid6.Cells[0,n])='0' then break; //ТАРИФ "ДЛЯ ВСЕХ" - ПРОПУСКАЕМ
     //если код перевозчика совпадает - все нормально
         If (trim(tarif_all[m,13])=trim(StringGrid6.Cells[0,n])) then  break;
       end;
       If m=high(tarif_all) then
         begin
           showmessagealt('Не рассчитан тариф для перевозчика: '+trim(StringGrid6.Cells[1,n])+#13+'Сохранение невозможно !');
           exit;
         end;

      //проверка сезонность для каждого перевозчика //сезонности "ДЛЯ ВСЕХ" - НЕТ
      flnosezon:=true;
      If (trim(StringGrid6.Cells[0,n])='0') OR (trim(StringGrid6.Cells[0,n])='') then continue; //сезонность "ДЛЯ ВСЕХ" - пропускаем
       for m:=0 to Length(mas_date)-1 do
         begin
       //если код перевозчика совпадает, все нормально
         If trim(mas_date[m,0])=trim(StringGrid6.Cells[0,n]) then flnosezon:=false;
       end;
       //если нет сеозонности для перевозчика
       If flnosezon then
         begin
          showmessagealt('Не определен календарный план для перевозчика: '+trim(StringGrid6.Cells[1,n])+' !'+#13+'Сохранение невозможно !');
          exit;
         end;
      end;

   //button3.Click;

  //********----------   Записываем основные данные по расписанию
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

   //!!!!!!!!!!   проверка на изменение даты активности       !!!!!!!!!!!!
  if (flag_edit_shedule=2) AND (activDay<>DateEdit3.Date) then
    begin
      //если старая дата активации меньше завтрашнего числа |||||||||||||
      If activDay<(Date()+1) then
        begin
          //и если новая дата активации больше текущей даты
          If (DateEdit3.Date>Date()) then
            begin
            // определяем есть ли у этого расписания будущее расписание
              ZQuery1.SQL.Clear;
              ZQuery1.SQL.add('SELECT id FROM av_shedule where del=0 AND id_past='+old_id+';');
              try
                ZQuery1.open;
              except
                showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
                ZQuery1.close;
                ZConnection1.disconnect;
                exit;
              end;
              //если (ТЕКУЩЕЕ) уже есть будущее расписание
              If ZQuery1.RecordCount>0 then
                begin
                  showmessagealt('СОХРАНЕНИЕ НЕВОЗМОЖНО !!!'+#13+'Данное расписание уже имеет связанное расписание с id='
                  +ZQuery1.FieldByName('id').AsString+#13+' с более поздней датой активации !'+#13+'Изменения даты активации следует производить в нем !!!');
                  exit;
                end
              else
              //если нет создадим новое на основе этого с привязкой к этому
              begin
              flag_edit_shedule := 1;
              past_id := old_id;
              flactiv := true;
              end;
            end;
        end;
      //если старая дата активации больше текущего числа |||||||||||||||
     //showmessage(datetostr(activDay));
     //showmessage(datetostr(Date()));
      If (activDay>Date()) then
        begin
          //и если новая дата активации больше старой
          If (DateEdit3.Date>activDay) then
            begin
              // определяем есть ли у этого расписания будущее расписание
              ZQuery1.SQL.Clear;
              ZQuery1.SQL.add('SELECT id FROM av_shedule where del=0 AND id_past='+old_id+';');
              try
                ZQuery1.open;
              except
                showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
                ZQuery1.close;
                ZConnection1.disconnect;
                exit;
              end;
              //если (ТЕКУЩЕЕ) уже есть будущее расписание
              If ZQuery1.RecordCount>0 then
                begin
                  showmessagealt('СОХРАНЕНИЕ НЕВОЗМОЖНО !!!'+#13+'Данное расписание уже имеет связанное расписание с id='
                  +ZQuery1.FieldByName('id').AsString+#13+' с более поздней датой активации !'+#13+'Изменения даты активации следует производить в нем !!!');
                  exit;
                end
              else
             begin
              //если нет определяем, есть ли у этого расписания текущее расписание, если есть отметка о текущем
                  try
                     strtoint(past_id);
                   except
                     on exception: EConvertError do
                     begin
                       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x03');
                       exit;
                     end;
                   end;

              If strtoint(past_id)>0 then
              begin
              ZQuery1.SQL.Clear;
              ZQuery1.SQL.add('SELECT id FROM av_shedule WHERE del=0 AND id='+past_id+';');
              try
                ZQuery1.open;
              except
                showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
                ZQuery1.close;
                ZConnection1.disconnect;
                exit;
              end;
              //If  ZQuery1.FieldByName('id').AsString
              //если (ТЕКУЩЕЕ) у этого расписания нет текущего , создаем будущее
              If ZQuery1.RecordCount=0 then
                begin
                  flag_edit_shedule := 1;
                  past_id := old_id;
                  flactiv := true;
                  end;
              end;
              end;
          end;
          //и если новая дата активации меньше старой and past_id>0
          If (DateEdit3.Date>activDay) AND (strtoint(past_id)>0) then
            begin
              //проверяем, есть ли у него текущее с датой активации больше новой
              ZQuery1.SQL.Clear;
              ZQuery1.SQL.add('SELECT id FROM av_shedule WHERE del=0 AND id='+past_id+' AND dateactive>'+QuotedStr(dateEdit3.Text)+';');
              try
                ZQuery1.open;
              except
                showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
                ZQuery1.close;
                ZConnection1.disconnect;
                exit;
              end;
              //если есть то отмена
              If ZQuery1.RecordCount>0 then
                begin
                  showmessagealt('СОХРАНЕНИЕ НЕВОЗМОЖНО !!!'+#13+'Данное расписание уже имеет действующее расписание с id='
                  +ZQuery1.FieldByName('id').AsString+#13+' с более поздней датой активации !'+#13+'Изменения даты активации следует производить в нем !!!');
                  exit;
                end;
              end;
        end;
    end;
  //!!!!!!!!!!!!!!!!!  конец проверки даты активации  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


  //Открываем транзакцию
  try
   If not Zconnection1.InTransaction then
      Zconnection1.StartTransaction
   else
     begin
      showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      ZConnection1.Rollback;
     end;

//\\\\\\\\\  проверка при изменении состава расписания удалять броню \\\\\\\\\\\\\\\\\\
  if (flag_edit_shedule=2) AND (flsostav) and flcritical then
    begin
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('SELECT id_shedule FROM av_shedule_bron WHERE del=0 AND id_shedule='+old_id+';');
      ZQuery1.open;

      If ZQuery1.RecordCount>0 then
      begin
       If (dialogs.MessageDlg('Изменение состава расписания приведет к УДАЛЕНИЮ БРОНИ на нем !'+#13+'Все равно продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=7) then
        begin
          ZConnection1.Rollback;
          ZQuery1.Close;
          ZConnection1.Disconnect;
          exit;
        end;
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('UPDATE av_shedule_bron SET del=2,createdate=now(),id_user='+inttostr(id_user)+' WHERE del=0 AND id_shedule='+old_id+';');
      ZQuery1.ExecSQL;
      end;
    end;


////помечаем на удаление устаревшие расписания, если это дата действия истекла Текущее или дата активации меньше завтрашнего числа
//If (flag_edit_shedule=2) AND (strtoint(past_id)>0) AND (dateEdit2.Date<(Date()+1)) AND (DateEdit3.Date<(Date()+1)) AND (flactiv=0) then
//  begin
//     form16.ZQuery1.SQL.Clear;
//     form16.ZQuery1.SQL.add('UPDATE av_shedule SET del=2,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+ past_id +' and del=0;');
//     form16.ZQuery1.ExecSQL;
//     //проставляем запись на удаление  СОСТАВ
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_sostav SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//     //проставляем запись на удаление АТП
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_atp SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//     //проставляем запись на удаление АТC
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_ats SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//     //проставляем запись на удаление СЕЗОННОСТИ
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_sezon SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//     //проставляем запись на удаление ТАРИФОВ
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_tarif SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//     //проставляем запись на удаление УСЛУГ расписания
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_uslugi SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//     //проставляем запись на удаление ЛЬГОТ расписания
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_lgot SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//     //проставляем запись на удаление Запрещенных пользователей расписания
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_denyuser SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//     //проставляем запись на удаление БРОНИ
//     form15.ZQuery1.SQL.Clear;
//     form15.ZQuery1.SQL.add('UPDATE av_shedule_bron SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id_shedule='+past_id+' and del=0;');
//     form15.ZQuery1.ExecSQL;
//  end;
/////////////////////////

  //Определяем текущий id+1 для расписания
  if flag_edit_shedule=1 then
     begin
        form16.ZQuery1.SQL.Clear;
        form16.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_shedule where del=0;');
        form16.ZQuery1.open;
        //если кто-то уже вводит расписание с таким номером, то меняем на новый max
        If new_id<>intTostr(form16.ZQuery1.FieldByName('new_id').asInteger+1) then
        new_id:=intTostr(form16.ZQuery1.FieldByName('new_id').asInteger+1);
     end;

  //Производим запись новых данных
  //Маркируем запись на удаление если режим редактирования
  if (flag_edit_shedule=2) and flchange then
      begin
       form16.ZQuery1.SQL.Clear;
       form16.ZQuery1.SQL.add('UPDATE av_shedule SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+ old_id +' and del=0;');
       form16.ZQuery1.ExecSQL;
      end;


  If form16.CheckBox6.Checked then
  zdog:=copy(form16.Edit14.Text,1,pos('|',form16.Edit14.Text)-1)
  else
    zdog:='0';

  //Записываем новые основные данные по расписанию
  if flchange then
  begin
  form16.ZQuery1.SQL.Clear;
  form16.ZQuery1.SQL.add('INSERT INTO av_shedule(id,id_past,createdate,id_user,del,createdate_first,id_user_first,kod,name_shedule,id_route,active,zakaz,dates,datepo,dateactive,typ_tarif,date_tarif,zdogovor) VALUES (');
  if flag_edit_shedule=1 then form16.ZQuery1.SQL.add(new_id+','+past_id+',now(),'+inttostr(id_user)+',0,now(),'+inttostr(id_user)+',');
  if flag_edit_shedule=2 then form16.ZQuery1.SQL.add(old_id+','+past_id+',now(),'+inttostr(id_user)+',0,NULL,NULL,');

  form16.ZQuery1.SQL.add(        quotedstr(trim(form16.Edit6.text))+','+
                                 quotedstr(trim(form16.Edit5.text))+','+
                                 trim(form16.Edit1.text)+','+
                                 IFTHEN(form16.CheckBox2.Checked,'1','0')+','+
                                 IFTHEN(form16.CheckBox6.Checked,'1','0')+','+
                                 quotedstr(trim(form16.DateEdit1.text))+','+
                                 quotedstr(trim(form16.DateEdit2.text))+','+
                                 quotedstr(trim(form16.DateEdit3.text))+
                                 ',0,current_date,'+zdog+');'); //2022-02-02 убить datetarif
  //showmessage(form16.ZQuery1.SQL.Text);//$
  form16.ZQuery1.ExecSQL;
  end;

  //=========================Записываем состав расписания============================
  If (flsostav) OR (flactiv) then //если были изменения или будущее расписание
     begin
  if flag_edit_shedule=2 then
     begin
       form16.ZQuery1.SQL.Clear;
       form16.ZQuery1.SQL.add('UPDATE av_shedule_sostav SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
       form16.ZQuery1.ExecSQL;
     end;
  for n:=1 to form16.StringGrid1.RowCount-1 do
   begin
     form16.ZQuery1.SQL.Clear;
     form16.ZQuery1.SQL.add('INSERT INTO av_shedule_sostav(id_user,id_shedule,id_point,name,form,plat_o,plat_p,t_o,t_s,km,t_d,timering,');
     form16.ZQuery1.SQL.add('t_p,backout,kmh_n,kmh_r,point_order,deny_sale,createdate_first,id_user_first) VALUES (');
     if flag_edit_shedule=1 then form16.ZQuery1.SQL.add(inttostr(id_user)+','+ new_id +',');
     if flag_edit_shedule=2 then form16.ZQuery1.SQL.add(inttostr(id_user)+','+ old_id +',');
     form16.ZQuery1.SQL.add(         trim(m_sostav[n,0])+','+
                                     quotedstr(trim(m_sostav[n,1]))+','+
                                     trim(m_sostav[n,2])+','+
                                     trim(m_sostav[n,3])+','+
                                     trim(m_sostav[n,4])+','+
                                     quotedstr(trim(m_sostav[n,5]))+','+
                                     quotedstr(trim(m_sostav[n,7]))+','+
                                     trim(m_sostav[n,8])+','+
                                     quotedstr(trim(m_sostav[n,9]))+','+
                                     trim(m_sostav[n,12])+','+
                                     quotedstr(trim(m_sostav[n,6]))+','+
                                     trim(m_sostav[n,13])+','+
                                     trim(m_sostav[n,10])+','+
                                     trim(m_sostav[n,11])+','+
                                     trim(inttostr(n))+',');
     If m_sostav[n,14]='1' then form16.ZQuery1.SQL.add('true') else form16.ZQuery1.SQL.add('false');
     if flag_edit_shedule=1 then form16.ZQuery1.SQL.add(',now(),'+inttostr(id_user)+');');
     if flag_edit_shedule=2 then form16.ZQuery1.SQL.add(',NULL,NULL);');

     //If n>3 then
     //showmessage(form16.ZQuery1.SQL.Text);//$
     form16.ZQuery1.ExecSQL;
   end;
  end;



   // =============================Записываем АТП======================================
  //выясняем изменения



   If (flatp) OR (flactiv) then //если были изменения или будущее расписание
      begin
  if flag_edit_shedule=2 then
     begin
       form16.ZQuery1.SQL.Clear;
       form16.ZQuery1.SQL.add('UPDATE av_shedule_atp SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
       form16.ZQuery1.ExecSQL;
     end;

  for n:=low(atp_sostav) to high(atp_sostav) do
   begin
     //создаем строку с id перевозчиков
     If n=low(atp_sostav) then atplist:=atp_sostav[n,0] else  atplist := atplist +','+ atp_sostav[n,0];
     form16.ZQuery1.SQL.Clear;
     form16.ZQuery1.SQL.add('INSERT INTO av_shedule_atp(id_user,createdate,del,id_kontr,def_ats,reestr,id_shedule,createdate_first,id_user_first) VALUES (');
     form16.ZQuery1.SQL.add(inttostr(id_user)+',now(),0,' + atp_sostav[n,0] + ',' + atp_sostav[n,2] + ',' + quotedstr(atp_sostav[n,4]) + ',');
     //режим добавление
     if flag_edit_shedule=1 then form16.ZQuery1.SQL.add(new_id+',now(),'+inttostr(id_user)+');');
     //режим редактирования
     if flag_edit_shedule=2 then form16.ZQuery1.SQL.add(old_id+',NULL,NULL);');

     form16.ZQuery1.ExecSQL;
   end;

  // =============================Записываем АТC   ЕСЛИ ФЛАГ АКТИВНОСТИ АТС УСТАНОВЛЕН ======================================
 if flag_edit_shedule=2 then
    begin
      form16.ZQuery1.SQL.Clear;
      form16.ZQuery1.SQL.add('UPDATE av_shedule_ats SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
      form16.ZQuery1.ExecSQL;
    end;
 for n:=0 to length(ats_sostav)-1 do
  begin
    iF trim(ats_sostav[n,5])='0' then continue;
    form16.ZQuery1.SQL.Clear;
    form16.ZQuery1.SQL.add('INSERT INTO av_shedule_ats(id_user,id_shedule,id_kontr,id_ats,flag,createdate_first,id_user_first) VALUES (');
    if flag_edit_shedule=1 then form16.ZQuery1.SQL.add(inttostr(id_user)+','+ new_id +',');
    if flag_edit_shedule=2 then form16.ZQuery1.SQL.add(inttostr(id_user)+','+ old_id +',');

//    form16.ZQuery1.SQL.add(trim(ats_sostav[n,6])+','+trim(ats_sostav[n,0])+','+quotedstr(trim(ats_sostav[n,1]))+','+trim(ats_sostav[n,2])+','+trim(ats_sostav[n,3])+',');
//if trim(ats_sostav[n,4])='М2' then form16.ZQuery1.SQL.add('1,') else form16.ZQuery1.SQL.add('2,');
    form16.ZQuery1.SQL.add(trim(ats_sostav[n,6])+','+trim(ats_sostav[n,0])+','+trim(ats_sostav[n,5]));
    //form16.ZQuery1.SQL.add(trim(ats_sostav[n,5]));
    if flag_edit_shedule=1 then form16.ZQuery1.SQL.add(',now(),'+inttostr(id_user)+ ');');
    if flag_edit_shedule=2 then form16.ZQuery1.SQL.add(',NULL,NULL);');

    form16.ZQuery1.ExecSQL;
  end;

//\\\\\\\\\  удалять броню у всех перевозчиков кроме текущих для данного расписания \\\\\\\\\\\\\\\\\\
  if (flag_edit_shedule=2) then
    begin
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('UPDATE av_shedule_bron SET del=2,createdate=now(),id_user='+inttostr(id_user)+' WHERE del=0 AND id_shedule='+old_id+' AND id_kontr NOT IN ('+atplist+');');
      //showmessage(ZQuery1.SQL.text);//$
      ZQuery1.ExecSQL;
      end;
 end;

 //\\\\\\\\   сезонность, тарифы, услуги и льготы для каждого атп в Гриде 6
 //помечаем на удаление записи этого расписания в соответствующих таблицах
 if (flag_edit_shedule=2) then
   begin
  If (flsezon) then
    begin
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('UPDATE av_shedule_sezon SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
      ZQuery1.ExecSQL;
    end;
 If (fltarif) then
  begin
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('UPDATE av_shedule_tarif SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
        ZQuery1.ExecSQL;
    end;

 If (fluslugi) then
  begin
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('UPDATE av_shedule_uslugi SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
      ZQuery1.ExecSQL;
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('UPDATE av_shedule_lgot SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
      ZQuery1.ExecSQL;
  end;

 end;


 //---------------------  Проходим всех перевозчиков  и записываем данные по ним  -----------------------------------
 for k:=low(atp_sostav) to high(atp_sostav) do
  begin
    kodatp := atp_sostav[k,0];

  // =============================Записываем Сезонность======================================
  If (flsezon) OR (flactiv) then //если были изменения или будущее расписание
     begin
     for n:=0 to length(mas_date)-1 do
     begin
       If kodatp<>mas_date[n,0] then continue;
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('INSERT INTO av_shedule_sezon(id_shedule,id_kontr,massezon,id_user,createdate,del,id_user_first,createdate_first) VALUES (');
    if flag_edit_shedule=1 then form16.ZQuery1.SQL.add(new_id +',');
    if flag_edit_shedule=2 then form16.ZQuery1.SQL.add(old_id +',');
    ZQuery1.SQL.add(kodatp+',');
    str_query:='';
    for m:=1 to sezon_size-1 do
     begin
       str_query:=str_query + mas_date[n,m];
     end;
    //showmessage(mas_date[n,0]+#13+str_query);//$
    ZQuery1.SQL.add(quotedstr(trim(str_query))+',');
    if flag_edit_shedule=1 then ZQuery1.SQL.add(inttostr(id_user)+',now(),0,'+inttostr(id_user)+',now());');
    if flag_edit_shedule=2 then ZQuery1.SQL.add(inttostr(id_user)+',now(),0,'+'NULL,NULL);');
    //showmessage(ZQuery1.SQL.Text);//$
    ZQuery1.ExecSQL;
    end;
   end;


  // =============================Записываем тарифную сетку ======================================
     //записываем тариф только там, где были ручные изменения
  If (fltarif) OR (flactiv) then //если были изменения или будущее расписание
  begin
   //if flag_edit_shedule=2 then
   //begin
   // for m:=0 to length(tarif_all)-1 do
   //   begin
   //    If trim(tarif_all[m,13])=kodatp then
   //    begin
   //     ZQuery1.SQL.Clear;
   //     ZQuery1.SQL.add('UPDATE av_shedule_tarif SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and id_kontr='+tarif_all[m,13]+' and del=0;');
   //     ZQuery1.ExecSQL;
   //     break;
   //    end;
   //   end;
   // end;
   norder :=0;
   //showmas(tarif_all);
  for m:=low(tarif_all) to high(tarif_all) do
   begin
   If trim(tarif_all[m,14])='0' then continue; //если тариф рассчитывается автоматом, то пропускаем запись в таблицу
     If kodatp<>trim(tarif_all[m,13]) then continue;
      for j:=3 to 12 do
       begin
         If trim(tarif_all[m,j])='' then tarif_all[m,j]:='0.00';
       end;
      norder:= norder + 1;
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('INSERT INTO av_shedule_tarif(id_shedule, id_kontr, id_point, point_order, bagazh, calculation_type, km, hardm2, hardm3, softm2, softm3,');
      ZQuery1.SQL.add('tarif_hardm2, tarif_hardm3, tarif_softm2, tarif_softm3, id_user, createdate, del, id_user_first, createdate_first) VALUES (');
    if flag_edit_shedule=1 then ZQuery1.SQL.add(new_id +',');
    if flag_edit_shedule=2 then ZQuery1.SQL.add(old_id +',');
     ZQuery1.SQL.add(kodatp+','+tarif_all[m,0]+','+inttostr(norder)+','+tarif_all[m,7]+','+tarif_all[m,12]+','+tarif_all[m,2]+','+tarif_all[m,3]+','+tarif_all[m,4]+','+tarif_all[m,5]+','+tarif_all[m,6]+',');
     ZQuery1.SQL.add(tarif_all[m,8]+','+tarif_all[m,9]+','+tarif_all[m,10]+','+tarif_all[m,11]+',');
    if flag_edit_shedule=1 then ZQuery1.SQL.add(inttostr(id_user)+',now(),0,'+inttostr(id_user)+',now());');
    if flag_edit_shedule=2 then ZQuery1.SQL.add(inttostr(id_user)+',now(),0,'+'NULL,NULL);');
    //showmessage(ZQuery1.SQL.text);//$
    ZQuery1.ExecSQL;
    end;
  end;
  //----------------------------------------------------------------------------------------

  If (fluslugi) OR (flactiv) then //если были изменения или будущее расписание
  begin
  // =============================Записываем услуги ======================================
  //if flag_edit_shedule=2 then
  //   begin
  //    for m:=0 to length(uslugi_all)-1 do
  //      begin
  //      If trim(uslugi_all[m,5])=kodatp then
  //         begin
  //    ZQuery1.SQL.Clear;
  //    ZQuery1.SQL.add('UPDATE av_shedule_uslugi SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and id_kontr='+uslugi_all[m,5]+' and del=0;');
  //    ZQuery1.ExecSQL;
  //    break;
  //         end;
  //      end;
  //   end;
  for m:=0 to length(uslugi_all)-1 do
   begin
     If kodatp<>trim(uslugi_all[m,5])  then continue;

      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('INSERT INTO av_shedule_uslugi(id_shedule,id_kontr,id_uslugi,active,summa,percent,id_user,createdate,del,id_user_first,createdate_first) VALUES (');
    if flag_edit_shedule=1 then ZQuery1.SQL.add(new_id +',');
    if flag_edit_shedule=2 then ZQuery1.SQL.add(old_id +',');

     ZQuery1.SQL.add(kodatp+','+uslugi_all[m,1]+','+uslugi_all[m,0]+','+uslugi_all[m,3]+','+uslugi_all[m,4]+',');

    if flag_edit_shedule=1 then ZQuery1.SQL.add(inttostr(id_user)+',now(),0,'+inttostr(id_user)+',now());');
    if flag_edit_shedule=2 then ZQuery1.SQL.add(inttostr(id_user)+',now(),0,'+'NULL,NULL);');
    ZQuery1.ExecSQL;

    end;
    //----------------------------------------------------------------------------------------
  // =============================Записываем льготы ======================================
   //if flag_edit_shedule=2 then
   // begin
   //   for m:=0 to length(lgoty_all)-1 do
   //  begin
   //  If trim(lgoty_all[m,6])=kodatp then
   //   begin
   //   ZQuery1.SQL.Clear;
   //   ZQuery1.SQL.add('UPDATE av_shedule_lgot SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and id_kontr='+lgoty_all[m,6]+' and del=0;');
   //   ZQuery1.ExecSQL;
   //   break;
   //   end;
   // end;
   // end;
  for m:=0 to length(lgoty_all)-1 do
   begin
     If kodatp<>trim(lgoty_all[m,6])  then continue;

      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('INSERT INTO av_shedule_lgot(id_shedule,id_kontr,id_lgot,active,summa,percent,id_user,createdate,del,id_user_first,createdate_first) VALUES (');
    if flag_edit_shedule=1 then ZQuery1.SQL.add(new_id +',');
    if flag_edit_shedule=2 then ZQuery1.SQL.add(old_id +',');

     ZQuery1.SQL.add(kodatp+','+lgoty_all[m,1]+','+lgoty_all[m,0]+','+lgoty_all[m,4]+','+lgoty_all[m,5]+',');

    if flag_edit_shedule=1 then ZQuery1.SQL.add(inttostr(id_user)+',now(),0,'+inttostr(id_user)+',now());');
    if flag_edit_shedule=2 then ZQuery1.SQL.add(inttostr(id_user)+',now(),0,'+'NULL,NULL);');
     //showmessage(ZQuery1.sql.Text);//$
    ZQuery1.ExecSQL;
    end;
  end;
  end;
 // закончился проход по атп в гриде

 //** записать запрещенных пользователей **********************************
 If (flblock) OR (flactiv) then //если были изменения или будущее расписание
 begin
  if flag_edit_shedule=2 then
    begin
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('UPDATE av_shedule_denyuser SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
      ZQuery1.ExecSQL;
    end;
  for n:=1 to Stringgrid3.RowCount-1 do
   begin
        If (Stringgrid3.cells[0,n])='' then continue;
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('INSERT INTO av_shedule_denyuser(id_shedule,denyuser_id,id_user,createdate,del,id_user_first,createdate_first) VALUES (');
        if flag_edit_shedule=1 then ZQuery1.SQL.add(new_id +','+Stringgrid3.Cells[0,n]+','+inttostr(id_user)+',now(),0,'+inttostr(id_user)+',now());');
        if flag_edit_shedule=2 then ZQuery1.SQL.add(old_id +','+Stringgrid3.Cells[0,n]+','+inttostr(id_user)+',now(),0,'+'NULL,NULL);');
        ZQuery1.ExecSQL;
   end;
  end;
  // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  //
  IF (flactiv) then showmessagealt('УСПЕШНО создано связанное расписание с отложенной датой активации !');
  Form16.Close;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
     exit;
 end;
  end;
  //сбрасываем флаги
    flchange := false;
    flsostav := false;
    flatp :=false;
    fltarif :=false;
    flsezon :=false;
    fluslugi :=false;
    flblock :=false;
    //fl_to :=0;  //переход на вкладку опции
    flactiv :=false; //флаг создания будущего расписания
    flcritical:=false;
end;
//=======================================   КОНЕЦ СОХРАНЕНИЯ =========================================================


procedure TForm16.StringGrid1Enter(Sender: TObject);
begin
   // Если выбран поворотный пункт то открываем кнопку автоматического расчета
  if trim(m_sostav[form16.StringGrid1.row,13])='1' then form16.BitBtn21.Enabled:=true else form16.BitBtn21.Enabled:=false;
  // Кнопка добавления наименования пункта к наименованию расписания если формирующийся
  if trim(m_sostav[form16.StringGrid1.row,2])='1' then form16.BitBtn26.Enabled:=true else form16.BitBtn26.Enabled:=false;
end;

//------------------------------------------------------------------------------------------------------------------------------------------------------------

procedure TForm16.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
  // Если выбран поворотный пункт то открываем кнопку автоматического расчета
  if trim(m_sostav[form16.StringGrid1.row,13])='1' then form16.BitBtn21.Enabled:=true else form16.BitBtn21.Enabled:=false;
  // Кнопка добавления наименования пункта к наименованию расписания если формирующийся
  if trim(m_sostav[form16.StringGrid1.row,2])='1' then form16.BitBtn26.Enabled:=true else form16.BitBtn26.Enabled:=false;
end;

procedure TForm16.StringGrid1SetCheckboxState(Sender: TObject; ACol,
  ARow: Integer; const Value: TCheckboxState);
begin
   with sender as TStringGrid do
   begin
   flsostav:=true;
     if (Cells[10,aRow]='0') then  cells[10,aRow]:='1' else cells[10,aRow]:='0';
     m_sostav[aRow,14]:=cells[10,aRow];
   end;
end;

procedure TForm16.StringGrid6BeforeSelection(Sender: TObject; aCol, aRow: Integer);
begin
  If aCol<2 then Refresh_arrays(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]),false);    // Обновляем все массивы по условию id АТП
end;

//************************************     КНОПКА РУЧНОГО РЕДАКТИРОВАНИЯ ТАРИФНОЙ СЕТКИ РАСПИСАНИЯ *********************************
procedure TForm16.StringGrid6ButtonClick(Sender: TObject; aCol, aRow: Integer);
var
  n:integer;
begin
  If flag_edit_shedule=2 then
   idshed := old_id
   else
     If copy_shed<>'0' then
       idshed := copy_shed
        else
          begin
           //If form16.StringGrid6.Cells[2,form16.StringGrid6.row]='1' then
           //form16.StringGrid6.Cells[2,form16.StringGrid6.row]:='0';
           showmessagealt('Сначала необходимо сохранить новое расписание !');
           exit;
          end;
  formST:=TformST.create(self);
  formST.ShowModal;
  FreeAndNil(formST);


   //showmessage('1');//$
  //If not tarif_auto(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row])) then exit;
  Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));  //Обновляем все Grid-ы тарифов по условию id АТП
end;

procedure TForm16.StringGrid6MouseEnter(Sender: TObject);
begin
  exit;
end;


procedure TForm16.StringGrid6Selection(Sender: TObject; aCol, aRow: Integer);
begin
  If aCol<2 then Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));  //Обновляем все Grid-ы тарифов по условию id АТП
end;

//************************************* СНЯТЬ/ПОСТАВИТЬ ГАЛОЧКУ УСТАНОВКИ РУЧНОГО ТАРИФА *****************************************
procedure TForm16.StringGrid6SetCheckboxState(Sender: TObject; ACol,   ARow: Integer; const Value: TCheckboxState);
var
  n:integer;
begin
  If pagecontrol2.ActivePageIndex<>0 then exit;
   with form16.StringGrid6 do
   begin
   if cells[3,row]='1' then
    begin
     if MessageDlg('Тариф будет рассчитан автоматически !'+#13+'для данного перевозчика на расписании !'+#13+'Продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;
     //рассчитывать тариф при продаже автоматом
    // РАССЧИТАТЬ ТАРИФ АВТОМАТИЧЕСКИ для последующей ручной корректировки **************************************************************
    //showmessage('2');//$
    If flsostav then
    begin
      showmessagealt('СНАЧАЛА НЕОБХОДИМО СОХРАНИТЬ'+#13+'ИЗМЕНЕНИЯ В СОСТАВЕ РАСПИСАНИЯ !');
      EXIT;
    end;
    If flag_edit_shedule<>1 then  If not tarif_auto(trim(Cells[0,row])) then exit;
     cells[3,row]:='0';
     form16.StringGrid10.Options := form16.StringGrid10.Options-[goEditing];
     form16.FloatSpinEdit1.Value:=0;
     form16.FloatSpinEdit2.Value:=0;
     form16.GroupBox2.Enabled:=false;
     Refresh_all_grid(trim(Cells[0,row]));
     fltarif:=true;
    end
   else
   begin
    cells[3,row]:='1';
    form16.StringGrid10.Options := form16.StringGrid10.Options+[goEditing];
    form16.StringGrid10.SetFocus;
    form16.GroupBox2.Enabled:=true;
    end;
   //обновляем массив atp
   for n:=low(atp_sostav) to high(atp_sostav) do
          begin
          If cells[0,Row]=atp_sostav[n,0] then
            atp_sostav[n,3] :=cells[3,Row]; //тип расчета тарифа
          end;

   end;
end;


//********************       Заполнение массива данными по составу расписания и основным реквизитам          ********************************
procedure TForm16.fill_array(old_id: string);
 var
   n,k,m:integer;
   //id_atp:integer;
   str_query,Stmp:string;
   //ar_pnt : array[1..100] of integer;
begin
  With Form16 do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
  //Делаем запрос расписанию
      form16.ZQuery1.SQL.Clear;
      Form16.ZQuery1.SQL.add('SELECT a.id,a.kod,a.name_shedule,a.active,a.zakaz,a.dates,a.datepo,a.dateactive,a.typ_tarif,a.date_tarif,a.id_past,b.id as id_route,b.kod as kod_route,');
      Form16.ZQuery1.SQL.add('(e.name || '' - '' || c.name || coalesce('' - '' || d.name,'''')) as name_route,b.type_route ');
      Form16.ZQuery1.SQL.add(',(case a.zdogovor when 0 then '''' else (SELECT c.name from av_spr_kontr_dog c where c.id=a.zdogovor order by c.del asc,c.createdate desc limit 1) end) name_dogovor ');
      Form16.ZQuery1.SQL.add(',a.zdogovor FROM av_shedule AS a ');
      Form16.ZQuery1.SQL.add('LEFT JOIN av_route AS b ON a.id_route=b.id AND b.del=0 ');
      Form16.ZQuery1.SQL.add('Left JOIN av_spr_locality AS e ON b.id_nas1=e.id AND e.del=0 ');
      Form16.ZQuery1.SQL.add('Left JOIN av_spr_locality AS c ON b.id_nas2=c.id AND c.del=0 ');
      Form16.ZQuery1.SQL.add('Left JOIN av_spr_locality AS d ON b.id_nas3=d.id AND d.del=0 ');
      Form16.ZQuery1.SQL.add('WHERE a.del=0 AND a.id='+ old_id +'; ');
     //showmessage(Form16.ZQuery1.SQL.Text);
      try
      ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      ZQuery1.close;
      ZConnection1.disconnect;
      Form16.Close;
      Exit;
     end;

 If form16.ZQuery1.RecordCount=0 then
     begin
      showmessagealt('ОШИБКА ! В базе данных НЕТ расписания с выбранными параметрами !');
      ZQuery1.close;
      ZConnection1.disconnect;
      Close;
      exit;
     end;

  If form16.ZQuery1.RecordCount>1 then
     begin
      showmessagealt('ОШИБКА !  Данное расписание НЕ уникально в системе !');
      ZQuery1.close;
      ZConnection1.disconnect;
      Form16.Close;
      exit;
     end;
     //===============================Заполняем Основные данные====================
     //заказной
     If form16.ZQuery1.FieldByName('zakaz').AsInteger=1 then
     form16.CheckBox6.Checked:=true
     else
       form16.CheckBox6.Checked:=false;
     //договор перевозки
     form16.Edit14.Caption:=form16.ZQuery1.FieldByName('zdogovor').asString+'| '+form16.ZQuery1.FieldByName('name_dogovor').asString;
     // id маршрута
     form16.Edit1.Text:=form16.ZQuery1.FieldByName('id_route').asString;
     // код маршрута
     form16.Edit3.Text:=form16.ZQuery1.FieldByName('kod_route').asString;
     // нименование маршрута
     form16.Edit2.Text:=form16.ZQuery1.FieldByName('name_route').asString;
     // id расписания
     form16.Label4.caption:=form16.ZQuery1.FieldByName('id').asString;
     //old_id := form16.ZQuery1.FieldByName('id').asInteger;
     // код расписания
     form16.Edit6.Text:=form16.ZQuery1.FieldByName('kod').asString;
     // наименование расписания
     form16.Edit5.Text := form16.ZQuery1.FieldByName('name_shedule').asString;
     // Дата действия с
     form16.DateEdit1.Text:=form16.ZQuery1.FieldByName('dates').asString;
     // Дата действия по
     form16.DateEdit2.Text:=form16.ZQuery1.FieldByName('datepo').asString;
     // Дата активации
     form16.DateEdit3.Text:=form16.ZQuery1.FieldByName('dateactive').asString;
     // id действующего расписания для связки с будущим
     past_id := form16.ZQuery1.FieldByName('id_past').asString;
     // Тип маршрута
     if form16.ZQuery1.FieldByName('type_route').asInteger=0 then form16.Edit13.Text:=cMezhgorod;
     if form16.ZQuery1.FieldByName('type_route').asInteger=1 then form16.Edit13.Text:=cPrigorod;
     if form16.ZQuery1.FieldByName('type_route').asInteger=2 then form16.Edit13.Text:=cKray;
     if form16.ZQuery1.FieldByName('type_route').asInteger=3 then form16.Edit13.Text:=cGos;
     // Активность
     if  trim(form16.ZQuery1.FieldByName('active').asString)='1' then form16.CheckBox2.checked:=true;
     if  not(trim(form16.ZQuery1.FieldByName('active').asString)='1') then form16.CheckBox2.checked:=false;
     //showmessage(ZQuery1.FieldByName('date_tarif').asString);


     //For n:=0 to ComboBox4.Items.Count-1 do
     // begin
     // if ComboBox4.Items[n]<>'' then
     //   begin
     //    IF (form16.ZQuery1.FieldByName('date_tarif').asDatetime) = strToDate(ComboBox4.Items[n]) then
     //       begin
     //       ComboBox4.ItemIndex:=n;
     //       break;
     //       end;
     //   end;
     // end;



     // Тип расписания
     //==================================АТП по умолчанию====================================================
     // form16.ZQuery1.SQL.Clear;
     // form16.ZQuery1.SQL.add('select name from av_spr_kontragent where del=0 and id='+trim(inttostr(id_atp))+';');
     //try
     // form16.ZQuery1.open;
     //except
     // showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
     // form16.ZQuery1.close;
     // form16.ZConnection1.disconnect;
     // exit;
     //end;
     {form16.edit18.Text:=inttostr(id_atp);
     form16.edit19.Text:=form16.ZQuery1.FieldByName('name').asString;}

     // ================================== Массив Перевозчиков ==================================================
     //запрос на Перевозчиков расписания, а также на тип тарифа для каждого (0-авто/1-измененный вручную)
      form16.ZQuery1.SQL.Clear;
      form16.ZQuery1.SQL.add('SELECT DISTINCT a.id_kontr,a.def_ats,b.name,a.reestr ');
      form16.ZQuery1.SQL.add(',case WHEN (select count(id_kontr) from av_shedule_tarif where del=0 and id_kontr=a.id_kontr and id_shedule='+old_id+')>0 THEN 1 ELSE 0 END tarif_type ');
      form16.ZQuery1.SQL.add('FROM av_shedule_atp as a ');
      form16.ZQuery1.SQL.add('LEFT JOIN av_spr_kontragent as b ON a.id_kontr=b.id and b.del=0 ');
      form16.ZQuery1.SQL.add('WHERE a.del=0 and a.id_shedule='+ old_id +';');
      //showmessage(Zquery1.SQL.text);//$
     try
      form16.ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;
  If  form16.ZQuery1.RecordCount=0 then
     begin
      showmessagealt('НЕ ОБНАРУЖЕНО ни одного перевозчика для данного расписания !');
     end;
   If  form16.ZQuery1.RecordCount>0 then
     begin
       stmp := '';
     // Создаем и заполняем массив
     setlength(atp_sostav,form16.ZQuery1.RecordCount, atp_size);
     for n:=0 to form16.ZQuery1.RecordCount-1 do
       begin
         atp_sostav[n,0]:=form16.ZQuery1.FieldByName('id_kontr').AsString;
         sTmp := sTmp + atp_sostav[n,0] + ','; //строка id АТП для запроса АТС
         atp_sostav[n,1]:=form16.ZQuery1.FieldByName('name').AsString;
         atp_sostav[n,2]:=form16.ZQuery1.FieldByName('def_ats').AsString; // Код АТС по умолчанию
         atp_sostav[n,3]:=form16.ZQuery1.FieldByName('tarif_type').AsString; //тип расчета тарифа 0-авто 1-ручной
         atp_sostav[n,4]:=form16.ZQuery1.FieldByName('reestr').AsString;//код реестра
         form16.ZQuery1.Next;
       end;
       stmp := copy(sTmp, 1, length(stmp)-1); //убираем последнюю запятую
     end;

     // ================================== Массив АТС перевозчика ==================================================
      form16.ZQuery1.SQL.Clear;
      //form16.ZQuery1.SQL.add('SELECT a.id_kontr,a.id_ats,a.flag,b.level,(b.m_down+b.m_up+b.m_lay+b.m_down_two+b.m_up_two+b.m_lay_two) as placeall,b.type_ats,b.name FROM av_shedule_ats as a ');
      //form16.ZQuery1.SQL.add('LEFT JOIN av_spr_ats as b ON b.del=0 AND b.id=a.id_ats ');
      //form16.ZQuery1.SQL.add('WHERE a.del=0 and a.id_shedule='+ old_id +' ORDER BY a.id_ats;');
      form16.ZQuery1.SQL.add('SELECT DISTINCT a.id_kontr,a.id_ats,b.gos,b.level,(b.m_down+b.m_up+b.m_lay+b.m_down_two+b.m_up_two+b.m_lay_two) as placeall,b.type_ats,b.name,c.flag FROM av_spr_kontr_ats as a ');
      form16.ZQuery1.SQL.add('LEFT JOIN av_spr_ats as b ON b.del=0 AND b.id=a.id_ats ');
      form16.ZQuery1.SQL.add('LEFT JOIN av_shedule_ats as c ON c.del=0 AND c.id_ats=a.id_ats AND c.id_kontr=a.id_kontr AND c.id_shedule='+ old_id );
      form16.ZQuery1.SQL.add('WHERE a.del=0 and a.id_kontr in ('+sTmp+') ORDER BY a.id_ats; ');
      //showmessage(Zquery1.SQL.text);//$
     try
      form16.ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;

     // Создаем и заполняем массив
       form16.StringGrid9.Columns[5].ValueChecked:='1';
       form16.StringGrid9.Columns[5].ValueUnchecked:='0';
       setlength(ats_sostav,form16.ZQuery1.RecordCount, ats_size);
       for n:=0 to form16.ZQuery1.RecordCount-1 do
          begin
            ats_sostav[n,0]:=form16.ZQuery1.FieldByName('id_ats').asString;
            ats_sostav[n,1]:=form16.ZQuery1.FieldByName('name').asString;
            ats_sostav[n,2]:=form16.ZQuery1.FieldByName('gos').asString;
            //ats_sostav[n,2]:=form16.ZQuery1.FieldByName('level').asString;
            ats_sostav[n,3]:=inttostr(form16.ZQuery1.FieldByName('placeall').asInteger);
            if form16.ZQuery1.FieldByName('type_ats').asInteger=1 then ats_sostav[n,4]:='М2' else ats_sostav[n,4]:='М3';
            If form16.ZQuery1.FieldByName('flag').asInteger=1 then
               ats_sostav[n,5]:='1'
            else
               ats_sostav[n,5]:='0';
            ats_sostav[n,6]:=form16.ZQuery1.FieldByName('id_kontr').asString;
            //ats_sostav[n,7]:=form16.ZQuery1.FieldByName('def_ats').asString;
            form16.ZQuery1.next;
          end;

       //проверяем актуально ли атс по умолчанию массива атп в массиве атс
         for k:=low(atp_sostav) to high(atp_sostav) do
              begin
                m:=0;
                for n:=low(ats_sostav) to high(ats_sostav) do
                  begin
                    //если в массиве атс находится атп с атс по умолчанию, то все нормально-отвал
                    IF (atp_sostav[k,0]=ats_sostav[n,6]) AND (atp_sostav[k,2]=ats_sostav[n,0]) AND (m=0) then
                      begin
                        m:=1;
                      end;
                  end;
                //если не нашли, то стираем атс по умолчанию у атп
                If m=0 then atp_sostav[k,2]:='0';
              end;
       //=============================================== Состав расписания=================================================
     //Делаем запрос расписанию

         form16.ZQuery1.SQL.Clear;
         form16.ZQuery1.SQL.add('select DISTINCT * from av_shedule_sostav where del=0 and id_shedule='+ old_id +' ORDER BY point_order ASC;');

       try
         form16.ZQuery1.open;
        except
         showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
         form16.ZQuery1.close;
         form16.ZConnection1.disconnect;
         exit;
        end;
    If  form16.ZQuery1.RecordCount<1 then
     begin
      showmessagealt('Не найдено ни одного элемента состава данного расписания !!!');
      ZQuery1.close;
      ZConnection1.disconnect;
      Close;
      exit;
     end;
     // Заполняем массив состава данными
     for n:=1 to form16.ZQuery1.RecordCount do
       begin
         setlength(m_sostav,n+1,sostav_size);
         m_sostav[n,0]:=form16.zquery1.FieldByName('id_point').asString;
         m_sostav[n,1]:=form16.zquery1.FieldByName('name').asString;
         m_sostav[n,2]:=form16.zquery1.FieldByName('form').asString;
         m_sostav[n,3]:=form16.zquery1.FieldByName('plat_o').asString;
         m_sostav[n,4]:=form16.zquery1.FieldByName('plat_p').asString;
         m_sostav[n,5]:=form16.zquery1.FieldByName('t_o').asString;
         m_sostav[n,6]:=form16.zquery1.FieldByName('t_p').asString;
         m_sostav[n,7]:=form16.zquery1.FieldByName('t_s').asString;
         m_sostav[n,8]:=form16.zquery1.FieldByName('km').asString;
         m_sostav[n,9]:=form16.zquery1.FieldByName('t_d').asString;
         m_sostav[n,10]:=form16.zquery1.FieldByName('kmh_n').asString;
         m_sostav[n,11]:=form16.zquery1.FieldByName('kmh_r').asString;
         m_sostav[n,12]:=form16.zquery1.FieldByName('timering').asString;
         m_sostav[n,13]:=form16.zquery1.FieldByName('backout').asString;
         If form16.zquery1.FieldByName('deny_sale').AsBoolean=true then
         m_sostav[n,14]:='1' else m_sostav[n,14]:='0';
         form16.ZQuery1.Next;
       end;
  //**************определяем сезонность, тарифы, улсуги и льготы для всех и каждого перевозчика в отдельности ****
  decimalseparator:='.';
  setlength(tarif_all,0, 0);
  setlength(mas_date,0,0);
  setlength(uslugi_all,0,0);
  setlength(lgoty_all,0,0);

  For k:=low(atp_sostav) to high(atp_sostav) do
    begin
     //===========================================     Сезонность       ==========================================
      form16.ZQuery1.SQL.Clear;
      form16.ZQuery1.SQL.add('SELECT DISTINCT id_kontr,massezon FROM av_shedule_sezon where del=0 and id_shedule='+ old_id +' AND id_kontr='+atp_sostav[k,0]+';');
      //If atp_sostav[k,0]='105' then showmessage(form16.ZQuery1.SQL.text);//&
     try
      form16.ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;
      If  form16.ZQuery1.RecordCount=0 then
     begin
       showmessagealt('Внимание !!! НЕ НАЙДЕНА СЕЗОННОСТЬ расписания'+#13+'для перевозчика: '+atp_sostav[k,1]+' !!!');
       continue;
     end;
     If  form16.ZQuery1.RecordCount>0 then
     begin
     // Заполняем массив сезонности
    //for n:=0 to form16.ZQuery1.RecordCount-1 do
    //begin
    setlength(mas_date,length(mas_date)+1, sezon_size);
    mas_date[length(mas_date)-1,0]:=form16.ZQuery1.FieldByName('id_kontr').AsString;
    str_query:=trim(form16.ZQuery1.FieldByName('massezon').AsString);
    //showmessage(str_query);
    If length(str_query)<(sezon_size-1) then
    begin
       showmessagealt('Длина поля сезонности (massezon) не соответствует массиву ! '+#13+'Обратитесь к Администратору !');
    end;
    for m:=1 to length(str_query) do
     begin
      mas_date[length(mas_date)-1,m] := str_query[m];
     end;
     //Zquery1.Next;
    //end;
     end;

     //showmessage('1'+#13+inttostr(length(mas_date)));//$
  //=========================================== Тарифы ==========================================

  //если тариф автоматический, то расчет динамический, если ручной, то берем из таблицы
  If atp_sostav[k,3]='1' then
  begin
      form16.ZQuery1.SQL.Clear;
      form16.ZQuery1.SQL.add('SELECT DISTINCT a.*,b.name FROM av_shedule_tarif AS a ');
      form16.ZQuery1.SQL.add('LEFT JOIN av_spr_point AS b ON b.id=a.id_point AND b.del=0 ');
      form16.ZQuery1.SQL.add('where a.del=0 and a.id_shedule='+ old_id +' AND a.id_kontr='+atp_sostav[k,0]+' ORDER BY a.point_order ASC;');
      //showmessage(ZQuery1.SQL.text);//$
     try
      form16.ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;
     //showmessage(inttostr(ZQuery1.RecordCount));
    If  form16.ZQuery1.RecordCount>0 then
     begin
     // Заполняем массив тарифов
   for n:=0 to form16.ZQuery1.RecordCount-1 do
    begin
       setlength(tarif_all,length(tarif_all)+1, tarif_size);
      If (n+1)<>form16.ZQuery1.FieldByName('point_order').AsInteger then
      begin
         showmessagealt('ТАРИФ. Поле очередности (point_order)'+#13+'НЕ соответствует итерации цикла ! '+#13+form16.ZQuery1.FieldByName('point_order').AsString+' <> '+inttostr(n+1));
         break;
      end;
       tarif_all[length(tarif_all)-1,0]:= form16.ZQuery1.FieldByName('id_point').AsString; // id остановочного пункта
       tarif_all[length(tarif_all)-1,1]:= form16.ZQuery1.FieldByName('name').AsString;//  Наименование остановочного пункта
       tarif_all[length(tarif_all)-1,2]:= form16.ZQuery1.FieldByName('km').AsString; // Путь в км.
       tarif_all[length(tarif_all)-1,3]:= form16.ZQuery1.FieldByName('hardm2').AsString; //  Жесткий М2
       tarif_all[length(tarif_all)-1,4]:= form16.ZQuery1.FieldByName('hardm3').AsString;//  Жесткий М3
       tarif_all[length(tarif_all)-1,5]:= form16.ZQuery1.FieldByName('softm2').AsString; //  Мягкий М2
       tarif_all[length(tarif_all)-1,6]:= form16.ZQuery1.FieldByName('softm3').AsString; //  Мягкий М3
       tarif_all[length(tarif_all)-1,7]:= form16.ZQuery1.FieldByName('bagazh').AsString; //  Цена БАГАЖ
       tarif_all[length(tarif_all)-1,8]:= form16.ZQuery1.FieldByName('tarif_hardm2').AsString; //  Тариф Жесткий М2
       tarif_all[length(tarif_all)-1,9]:= form16.ZQuery1.FieldByName('tarif_hardm3').AsString; //  Тариф Жесткий М3
       tarif_all[length(tarif_all)-1,10]:= form16.ZQuery1.FieldByName('tarif_softm2').AsString; //  Тариф Мягкий М2
       tarif_all[length(tarif_all)-1,11]:= form16.ZQuery1.FieldByName('tarif_softm3').AsString; //  Тариф Мягкий М3
       //tarif_all[length(tarif_all)-1,12]:= form16.ZQuery1.FieldByName('tarif_bagazh').AsString; // Тариф Багаж
       tarif_all[length(tarif_all)-1,13]:= form16.ZQuery1.FieldByName('id_kontr').AsString; //  id АТП
       tarif_all[length(tarif_all)-1,14]:= atp_sostav[k,3]; //тип расчета тарифа - 1-ручной
       tarif_all[length(tarif_all)-1,12]:= form16.ZQuery1.FieldByName('calculation_type').AsString; //тип расчета багажа:0-автоматически,1-сумма,2-процент от стоимости билета

       Zquery1.Next;
    end;
     end;

    end;
   //=========================================== УСЛУГИ  ==========================================
      form16.ZQuery1.SQL.Clear;
      form16.ZQuery1.SQL.add('SELECT DISTINCT a.id_kontr,a.id_uslugi,a.active,a.summa,a.percent,b.name FROM av_shedule_uslugi AS a ');
      form16.ZQuery1.SQL.add('JOIN av_spr_uslugi AS b ON a.id_uslugi=b.id WHERE a.del=0 AND b.del=0 AND a.id_shedule='+ old_id +' AND a.id_kontr='+atp_sostav[k,0]+';');
     try
      form16.ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;
     If  form16.ZQuery1.RecordCount>0 then
     begin
     // Заполняем массив тарифов
   for n:=0 to form16.ZQuery1.RecordCount-1 do
    begin
          setlength(uslugi_all,length(uslugi_all)+1, uslugi_size);
          uslugi_all[length(uslugi_all)-1,0]:= form16.ZQuery1.FieldByName('active').AsString; //  активность
          uslugi_all[length(uslugi_all)-1,1]:= form16.ZQuery1.FieldByName('id_uslugi').AsString; //  id uslugi
          uslugi_all[length(uslugi_all)-1,2]:= form16.ZQuery1.FieldByName('name').AsString; //  Наименование Льготы
          uslugi_all[length(uslugi_all)-1,3]:= form16.ZQuery1.FieldByName('summa').AsString; //  Сумма
          uslugi_all[length(uslugi_all)-1,4]:= form16.ZQuery1.FieldByName('percent').AsString; //  Процент
          uslugi_all[length(uslugi_all)-1,5]:= form16.ZQuery1.FieldByName('id_kontr').AsString; //  id АТП
      Zquery1.Next;
    end;
     end;
   //=========================================== ЛЬготы  ==========================================
      form16.ZQuery1.SQL.Clear;
      form16.ZQuery1.SQL.add('SELECT DISTINCT a.id_kontr,a.id_lgot,a.active,a.summa,a.percent,b.name,b.zakon FROM av_shedule_lgot AS a ');
      form16.ZQuery1.SQL.add('JOIN av_spr_lgot AS b ON a.id_lgot=b.id WHERE a.del=0 AND b.del=0 AND a.id_shedule='+ old_id +' AND a.id_kontr='+atp_sostav[k,0]+';');
     try
      form16.ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;
     If  form16.ZQuery1.RecordCount>0 then
     begin
     // Заполняем массив тарифов
   for n:=0 to form16.ZQuery1.RecordCount-1 do
    begin
         setlength(lgoty_all,length(lgoty_all)+1, lgoty_size);
          lgoty_all[length(lgoty_all)-1,0]:= form16.ZQuery1.FieldByName('active').AsString; //  активность
          lgoty_all[length(lgoty_all)-1,1]:= form16.ZQuery1.FieldByName('id_lgot').AsString; //  id uslugi
          lgoty_all[length(lgoty_all)-1,2]:= form16.ZQuery1.FieldByName('name').AsString; //  Наименование Льготы
          lgoty_all[length(lgoty_all)-1,3]:= form16.ZQuery1.FieldByName('zakon').AsString; //  Наименование Льготы
          lgoty_all[length(lgoty_all)-1,4]:= form16.ZQuery1.FieldByName('summa').AsString; //  Сумма
          lgoty_all[length(lgoty_all)-1,5]:= form16.ZQuery1.FieldByName('percent').AsString; //  Процент
          lgoty_all[length(lgoty_all)-1,6]:= form16.ZQuery1.FieldByName('id_kontr').AsString; //  id АТП
      Zquery1.Next;
    end;
     end;
   end;

  //*** определяем пользователей запрещенных на данном расписании
    form16.ZQuery1.SQL.Clear;
    form16.ZQuery1.SQL.add('SELECT DISTINCT a.denyuser_id,b.name FROM av_shedule_denyuser AS a JOIN av_users AS b on b.id=a.denyuser_id AND b.del=0 WHERE a.del=0 AND a.id_shedule='+ old_id +' ORDER BY b.name ASC;');
       try
         form16.ZQuery1.open;
        except
         showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
         form16.ZQuery1.close;
         form16.ZConnection1.disconnect;
         exit;
        end;
    If  form16.ZQuery1.RecordCount>1 then
     begin
       Form16.Stringgrid3.RowCount:= form16.ZQuery1.RecordCount+1;
       For n:=1 to form16.ZQuery1.RecordCount do
        begin
           Stringgrid3.Cells[0,n] := form16.ZQuery1.FieldByName('denyuser_id').AsString; //id запрещенного юзера
           Stringgrid3.Cells[1,n] := form16.ZQuery1.FieldByName('name').AsString; //имя запрещенного юзера
           Zquery1.next;
        end;
     end;

   //********************************
     form16.ZQuery1.close;
     form16.ZConnection1.disconnect;
     form16.UpdateGridATP();
     form16.UpdateGridATS();
end;
end;

procedure TForm16.perescet();   //Пересчет всех параметров для каждого пункта состава расписания
 var
   n:integer;
   otpr_h,otpr_m,shift_time:integer;
 begin
   otpr_h:=0;
   otpr_m:=0;
  if length(m_sostav)<3 then exit;
  for n:=2 to length(m_sostav)-1 do
        begin
          //form16.StringGrid1.RowCount-3
          // Время прибытия (отпр.пред+время в пути)
          try
            shift_time := strtoint(copy(m_sostav[n-1,5],1,2)) + strtoint(m_sostav[n,12]);
          except
             on exception: EConvertError do
              begin
                 showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x04');
                 exit;
               end;
          end;

       if shift_time<0 then shift_time:=24+shift_time;
       if shift_time=24 then shift_time:=0;
       if shift_time>24 then shift_time:=shift_time mod 24;
//          otpr_h:=strtoint(copy(m_sostav[n-1,5],1,2))+strtoint(copy(m_sostav[n,9],1,2));  //Время отправления из предыдущего пункта-часы + часы в пути
        otpr_h:=shift_time+strtoint(copy(m_sostav[n,9],1,2));  //Время отправления из предыдущего пункта-часы + часы в пути
        try
         otpr_m:=strtoint(copy(m_sostav[n-1,5],4,2))+strtoint(copy(m_sostav[n,9],4,2));  //Время отправления из предыдущего пункта-минуты + минуты в пути
        except
         on exception: EConvertError do
          begin
            showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x05');
            exit;
          end;
        end;
          if otpr_m>59 then
            begin
             otpr_h:=otpr_h+(otpr_m div 60);
             otpr_m:=otpr_m mod 60;
            end;
          if otpr_h>24 then
            begin
             otpr_h:=otpr_h mod 24;
            end
         else
            begin
             otpr_h:=otpr_h;
            end;
         if otpr_h=24 then otpr_h:=0;
         m_sostav[n,6]:=padl(inttostr(otpr_h),'0',2)+':'+padl(inttostr(otpr_m),'0',2);

        // Время отправления (время прибытия+время стоянки)
        try
         otpr_h:=strtoint(copy(m_sostav[n,6],1,2))+strtoint(copy(m_sostav[n,7],1,2));  //Время прибытия-часы + часы стоянка
        except
         on exception: EConvertError do
          begin
            showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x06');
            exit;
          end;
        end;
        try
         otpr_m:=strtoint(copy(m_sostav[n,6],4,2))+strtoint(copy(m_sostav[n,7],4,2));   //Время прибытия-минуты + минуты стоянка
        except
         on exception: EConvertError do
          begin
            showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x07');
            exit;
          end;
        end;

         if otpr_m>59 then
           begin
            otpr_h:=otpr_h+(otpr_m div 60);
            otpr_m:=otpr_m mod 60;
           end;
         if otpr_h>24 then
           begin
            otpr_h:=otpr_h mod 24;
           end
        else
           begin
            otpr_h:=otpr_h;
           end;
        if otpr_h=24 then otpr_h:=0;
        m_sostav[n,5]:=padl(inttostr(otpr_h),'0',2)+':'+padl(inttostr(otpr_m),'0',2);

        // Средняя скорость движения на участке
        if not((strtoint(copy(m_sostav[n,9],1,2))*60+strtoint(copy(m_sostav[n,9],4,2)))*60=0) then
             begin
               m_sostav[n,11]:=floattostr(round(strtofloat(m_sostav[n,8])/(strtoint(copy(m_sostav[n,9],1,2))*60+strtoint(copy(m_sostav[n,9],4,2)))*60));
             end
        else
            begin
               m_sostav[n,11]:='0';
            end;
      end;
end;

//******************************  СМЕНА ПОРЯДКА РАБОТЫ ПЕРЕВОЗЧИКА НА РАСПИСАНИИ *****************************************************
procedure TForm16.SpinEdit1Change(Sender: TObject);
var
  n,max,mn:integer;
begin
            //   //showmessage(mas_date[n,0]+' | '+mas_date[n,62]);
            //   mn:=0;
            //      try
            //         mn:= strtoINt(mas_date[n,62]);
            //      except
            //         on exception: EConvertError do
            //         begin
            //           showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x02');
            //           exit;
            //         end;
            //      end;
            //       If mn>length(atp_sostav) then mn:=length(atp_sostav); //значение спина не может превышать кол-во перевозчиков
            //       If mn>max then max:=mn;
            // end;
            ////корректируем значения порядка перевозчиков
            //for n:=low(mas_date) to high(mas_date)-1 do
            // begin
            //   //если порядок 2-х перевозчиков совпадает, то ставим второму маскимальный
            //   If mas_date[n,61]=mas_date[n+1,61] then
            //     begin
            //     mas_date[n+1,61]:= inttostr(max);
            //     max:=max-1;
            //     end;
            // end;
            //end;
         //form16.SpinEdit1.Text:= mas_date[length(mas_date)-1,62];
end;


//Пересчет всех параметров текущего состава расписания
procedure TForm16.rascet();
var
  n,m:integer;
  tsto1,tsto2,tsto3,tsto4,tsto5,kform:integer;
  tek_km:real;
begin
  // Заполняем stringgrid из массива
  form16.StringGrid1.RowCount:=1+length(m_sostav)-1;
  if length(m_sostav)>1 then
  begin
    for n:=1 to form16.StringGrid1.RowCount-1 do
      begin
        form16.StringGrid1.Cells[0,n]:=m_sostav[n,0]; //код остановочного пункта
        form16.StringGrid1.Cells[1,n]:=m_sostav[n,1]; //Наименование остановочного пункта
        if trim(m_sostav[n,2])='1' then form16.StringGrid1.Cells[2,n]:='ДА' else form16.StringGrid1.Cells[2,n]:='--'; //Формирующийся
        if (n>1) then form16.StringGrid1.Cells[3,n]:=m_sostav[n,4]; //Платформа прибытия
        if (n>1) then form16.StringGrid1.Cells[4,n]:=m_sostav[n,6]; //Время прибытия
        if (n>1) then form16.StringGrid1.Cells[5,n]:=m_sostav[n,7]; //Время стоянки
        form16.StringGrid1.Cells[6,n]:=m_sostav[n,3]; //Платформа отправления
        form16.StringGrid1.Cells[7,n]:=m_sostav[n,5]; //Время отправления
        if (n>1) and not(trim(m_sostav[n-1,8])='') and not(trim(m_sostav[n,8])='') then
            begin
             tek_km:=0;
             for m:=1 to n-1 do
                begin
                  tek_km:=tek_km+strtofloat(m_sostav[m,8]);
                end;
             form16.StringGrid1.Cells[8,n]:=FloatToStrF(tek_km+strtofloat(m_sostav[n,8]),fffixed,10,3); //Расстояние
             //form16.StringGrid1.Cells[8,n]:=inttostr(strtoint(m_sostav[n-1,8])+strtoint(m_sostav[n,8])); //Расстояние

            end;
        if (n>1) and (trim(form16.StringGrid1.Cells[8,n-1])='') then
            begin
             form16.StringGrid1.Cells[8,n]:=m_sostav[n,8];//Расстояние
            end;
        {if (n>1) and not(trim(form16.StringGrid1.Cells[8,n-1])='') then
             begin
              form16.StringGrid1.Cells[8,n]:=inttostr(strtoint(form16.StringGrid1.Cells[8,n-1])+strtoint(m_sostav[n,8])); //Расстояние
             end;}
        if (n>1) then form16.StringGrid1.Cells[9,n]:=m_sostav[n,11]; //Скорость на участке пути
        form16.StringGrid1.Cells[10,n]:=trim(m_sostav[n,14]); //Флаг запрета продажи до пункта
      end;
  end;

 ////----------------------------------------------------------------///
  // Обнуляем значения
    tsto1:=0;
    tsto2:=0;
    tsto3:=0;
    tsto4:=0;
    tsto5:=0;
    kform:=0;
    form16.Edit8.Text:='0';
    form16.Edit7.Text:='00:00';
    //form16.Edit9.Text:='0';

    // Рисуем итоговые показатели
  for n:=2 to form16.StringGrid1.rowcount-1 do
    begin
     //1.ВРЕМЯ ДВИЖЕНИИ*******************************
     // showmessagealt(trim(m_sostav[n,9]));
     try
        tsto3:=tsto3+strtoint(copy(trim(m_sostav[n,9]),1,2));
     except
       on exception: EConvertError do
          begin
           showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x08');
           exit;
          end;
     end;
     try
       tsto4:=tsto4+strtoint(copy(trim(m_sostav[n,9]),4,2));
     except
        on exception: EConvertError do
          begin
           showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x09');
           exit;
          end;
     end;

     //2.расстояние********************************
     form16.Edit8.Text:=floattostr(strtofloat(form16.Edit8.Text)+strtofloat(trim(m_sostav[n,8])));
     //3.Средняя скорость**************************
     tsto5:=tsto5+(strtoint(copy(trim(m_sostav[n,9]),1,2))*60+strtoint(copy(trim(m_sostav[n,9]),4,2)))+(strtoint(copy(trim(form16.StringGrid1.Cells[5,n]),1,2))*60+strtoint(copy(trim(form16.StringGrid1.Cells[5,n]),4,2)));
     //4.Время стоянок*****************************
     tsto1:=tsto1+strtoint(copy(trim(form16.StringGrid1.Cells[5,n]),1,2));
     tsto2:=tsto2+strtoint(copy(trim(form16.StringGrid1.Cells[5,n]),4,2));
     //5.Кол. остановочных пунктов*****************
     form16.Edit11.Text:=inttostr(form16.StringGrid1.rowcount-1);
     //6.Кол.формирующихся*************************
     if not(trim(form16.StringGrid1.Cells[2,n])='--') then
       begin
         kform:=kform+1;
       end;
    end;
    // Записываем итоги============================
    //1.ВРЕМЯ В ДВИЖЕНИИ
    form16.Edit7.Text:= padl(inttostr(tsto3+(tsto4 div 60)),'0',2)+':'+padl(inttostr((tsto4 mod 60)),'0',2);

    //2.Время стоянок
    form16.Edit10.Text:=padl(inttostr(tsto1+(tsto2 div 60)),'0',2)+':'+padl(inttostr((tsto2 mod 60)),'0',2);

    //3.Средняя скорость В ДВИЖЕНИИ
      //if strtofloat(form16.Edit8.Text)=0 then form16.Edit9.Text:='0' else form16.Edit9.Text:=floattostr(round(strtofloat(form16.Edit8.Text)/((tsto3*60+tsto4))*60));

    //4.Кол.формирующихся
    form16.Edit12.Text:=inttostr(kform);

    //5.ВРЕМЯ В ПУТИ
    tsto3:=tsto3+tsto1;
    tsto4:=tsto4+tsto2;
    form16.Edit16.Text:=padl(inttostr(tsto3+(tsto4 div 60)),'0',2)+':'+padl(inttostr((tsto4 mod 60)),'0',2);

    //6.СКОРОСТЬ В ПУТИ
    //form16.Edit17.Text:='0';
    //if strtofloat(form16.Edit8.Text)=0 then form16.Edit17.Text:='0' else form16.Edit17.Text:=floattostr(round(strtofloat(form16.Edit8.Text)/((tsto3*60+tsto4))*60));

    // Меняем наименование расписания
    if form16.StringGrid1.RowCount>1 then
       begin
        //form16.Edit5.text:=trim(form16.StringGrid1.Cells[1,1]+'-'+form16.StringGrid1.Cells[1,form16.StringGrid1.RowCount-1]);
       end;
end;


procedure TForm16.StringGrid10DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
 //var
   //s1,s2:string;
begin
  // рисуем тарифы
  with Sender as TStringGrid, Canvas do
  begin
    If (aRow>(length(m_sostav)-1)) then exit;
    Brush.Color:=clWhite;
    //если формирующийся, закрашиваем в желтый
    If (aRow>0) and (trim(m_sostav[aRow,2])='1') then Brush.Color:=clYellow;
       FillRect(aRect);
     if (gdSelected in aState) then
           begin
            pen.Width:=4;
            pen.Color:=clBlue;
            MoveTo(aRect.left,aRect.bottom-1);
            LineTo(aRect.right,aRect.Bottom-1);
            MoveTo(aRect.left,aRect.top-1);
            LineTo(aRect.right,aRect.Top);
            Font.Color := clBlack;
            font.Size:=12;
            font.Style:= [];
           end
         else
          begin
            font.Style:= [];
            Font.Color := clBlack;
            font.Size:=10;
          end;


          //***id_point
       if (aRow>0) AND (aCol=0) then
       begin
         font.Size:=11;
         // Точка возврата
         If (trim(m_sostav[aRow,13])='1') then
         begin
         Brush.Color:=clAqua;
         FillRect(aRect);
         end;
         TextOut(aRect.Left + 2, aRect.Top+3, Cells[aCol, aRow]);
         end;

       //наименование пункта
     if (aRow>0) AND (aCol=1) then
       begin
      //Формирующийся
      if (trim(m_sostav[aRow,2])='1') then
       begin
         Font.Style:=[fsBold];
         Font.Color := clRed;
         end
      else
       // Не формирующийся
        begin
         Font.Style:=[];
         Font.Color := clBlack;
       end;
         TextOut(aRect.Left + 5, aRect.Top+3, Cells[aCol, aRow]);
       end;

        // Превышение тарифа
        If (aRow>0) and (form16.StringGrid10.RowCount>1) and (aCol>1) then
           begin
          if  (aCol=3)  then
             begin
              Font.Color := clBlue;
              try
                if (strtofloat(form16.StringGrid2.Cells[0,aRow])*strtofloat(form16.StringGrid10.Cells[2,aRow])+0.01)<(strtofloat(form16.StringGrid10.Cells[3,aRow])) then
                  begin
                   Font.Color := clGreen;
                  end;
              except
                Font.Color := clAqua;
              end;
             end;

          if (aCol=4) then
            begin
            try
              if ((strtofloat(form16.StringGrid2.Cells[1,aRow])*strtofloat(form16.StringGrid10.Cells[2,aRow]))<strtofloat(form16.StringGrid10.Cells[4,aRow])) then
                begin
                  Font.Color := clRed;
                end;
              except
                    Font.Color := clBlack;
              end;
            end;

          if (aCol=5) then
            begin
             Font.Color := clBlue;
            try
             if ((strtofloat(form16.StringGrid2.Cells[2,aRow])*strtofloat(form16.StringGrid10.Cells[2,aRow]))<strtofloat(form16.StringGrid10.Cells[5,aRow])) then
                begin
                  Font.Color := clRed;
                end;
             except
              Font.Color := clAqua;
            end;
           end;

          if (aCol=6) then
            begin
            try
             if ((strtofloat(form16.StringGrid2.Cells[3,aRow])*strtofloat(form16.StringGrid10.Cells[2,aRow]))<strtofloat(form16.StringGrid10.Cells[6,aRow])) then
                begin
                  Font.Color := clRed;
                end;
            except
              Font.Color := clBlack;
            end;

          end;
            //if (aCol=7) then
            //begin
            //  Font.Color := clBlack;
            //end;
            TextOut(aRect.Left + 2, aRect.Top+3, Cells[aCol, aRow]);
          end;

      // Заголовок
       if aRow=0 then
         begin
           Font.Size:=10;
           Brush.Color:=clDefault;
           FillRect(aRect);
           //Font.Color := clBlack;
           TextOut(aRect.Left + 6, aRect.Top+3, form16.StringGrid10.Columns[aCol].Title.Caption);
          end;
   end;
end;

procedure TForm16.StringGrid10EditingDone(Sender: TObject);
begin
   //if (Form16.StringGrid10.col=3) or
   //   (Form16.StringGrid10.col=4) or
   //   (Form16.StringGrid10.col=5) or
   //   (Form16.StringGrid10.col=6) or
   //   (Form16.StringGrid10.col=7) then
   // begin
   //   Form16.StringGrid10.Cells[Form16.StringGrid10.col,Form16.StringGrid10.row]:=FormatNum(Form16.StringGrid10.Cells[Form16.StringGrid10.col,Form16.StringGrid10.row],2);
   //  end;
end;

procedure TForm16.StringGrid10Enter(Sender: TObject);
begin
  With Form16.Stringgrid10 do
  begin
   if Form16.Stringgrid6.cells[3,Form16.Stringgrid6.row]='1' then
    Options := Options+[goEditing]
   else
     Options := Options-[goEditing];
  end;
end;


procedure TForm16.StringGrid10GetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
begin
   if (ACol=3) or (ACol=4) or (ACol=5) or (ACol=6) then Value := '!9999999.99;1; ';
end;


procedure TForm16.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
    with Sender as TStringGrid, Canvas do
  begin
       Brush.Color:=clWhite;
       FillRect(aRect);

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

      //Формирующийся
      if (aRow>0) and (aCol=1) and (trim(cells[2,aRow]) = 'ДА') then
       begin
         Font.Size:=12;
         Font.Color := clRed;
         TextOut(aRect.Left + 5, aRect.Top+3, Cells[aCol, aRow]);
       end;

      // Не формирующиеся
      if (aRow>0) and (aCol=1) and (trim(cells[2,aRow]) = '--') then
         begin
          Font.Size:=12;
          Font.Color := clBlue;
          TextOut(aRect.Left + 25, aRect.Top+3, '> '+Cells[aCol, aRow]);
         end;

      // Остальные поля
      if (aRow>0) and not(aCol=1) then
         begin
          Font.Size:=10;
          Font.Color := clBlack;
          TextOut(aRect.Left + 5, aRect.Top+3, Cells[aCol, aRow]);
         end;


      // ===============================================================

      // Скоростные режимы
      //if (aRow>1) and (aCol=1) and (strtoint(m_sostav[aRow,11])>strtoint(m_sostav[aRow,10])) then
      //   begin
      //    Font.Size:=9;
      //    Font.Color := clPurple;
      //    TextOut(aRect.Left + 35, aRect.Top+22, 'ПРЕВЫШЕНИЕ СКОРОСТИ:');
      //    TextOut(aRect.Left + 35, aRect.Top+32, 'ТЕКУЩАЯ='+trim(m_sostav[aRow,11])+' км\ч НОРМА='+trim(m_sostav[aRow,10])+' км\ч)');
      //   end;

      // Часовой пояс
      if (aRow>0) and (aCol=0) and not(trim(m_sostav[aRow,12])='0') then
         begin
          Font.Size:=9;
          Font.Color := clRed;
          Font.Style:=[fsBold];
          //Brush.Color:=clMoneyGreen;
          //Pen.Color := clGreen;
          //Pen.Width := 1;
          //Ellipse(aRect.Left + 3,aRect.Top+18,aRect.right-4,aRect.bottom-3);
          TextOut(aRect.Left + 10, aRect.Top+20,trim(m_sostav[aRow,12])+' час');
          //TextOut(aRect.Left + 10, aRect.Top+30,'пояс: '+trim(m_sostav[aRow,12]));
         end;

      // Точка возврата
      if (aRow>1) and (aCol=0) and (trim(m_sostav[aRow,13])='1') then
         begin
          Font.Size:=16;
          Font.Color := clBLue;
          Brush.Color:=clYellow;
          Pen.Color := clBlue;
          Pen.Width := 1;
          Ellipse(aRect.right-20,aRect.Top+3,aRect.right-4,aRect.top+19);
          TextOut(aRect.right-20,aRect.Top+3,'^');
         end;

       // Чек бокс ЗАПРЕТ ПРОДАЖИ
            if (arow>0) and (acol=10) then
              begin
               font.Color:=clRed;
               font.size:=24;
               font.Style:=[];
               //form1.StringGrid1.Canvas.TextRect(aRect,arow+5,5,form1.StringGrid1.Cells[aCol, aRow]);
               if trim(Cells[aCol, aRow])='1' then
                begin
                 brush.Color:=clRed;
                 FillRect(aRect);
                 pen.Width:=1;
                 pen.Color:=clGray;
                 MoveTo(aRect.left,aRect.bottom-1);
                 LineTo(aRect.right,aRect.Bottom-1);
                 //textout(arow,acol,'*');
                  //textout(arect.Left+2,arect.Top+2,'*');
                 //DrawCellsAlign(form1.StringGrid1,2,2,form1.StringGrid1.Cells[aCol, aRow],aRect);
                 //DrawCellsAlign(form1.StringGrid1,2,2,'*',aRect);
                end
               else
                begin
                brush.Color:=clWhite;
                FillRect(aRect);
                pen.Width:=1;
                pen.Color:=clGray;
                MoveTo(aRect.left,aRect.bottom-1);
                LineTo(aRect.right,aRect.Bottom-1);
                 //DrawCellsAlign(form1.StringGrid1,2,2,'',aRect);
                 //textout(arow,acol,'');
                end;
            end;

      // Заголовок
       if aRow=0 then
         begin
           Brush.Color:=clDefault;
           FillRect(aRect);
           Font.Color := clBlack;
           font.Size:=10;
           TextOut(aRect.Left + 5, aRect.Top+3, Cells[aCol, aRow]);
          end;

       // первая строка
        if (aRow=1) and ((Acol=3) or (Acol=4) or (Acol=5) or (Acol=9)) then
          begin
            Brush.Color:=clWhite;
            FillRect(aRect.left,aRect.top+2,aRect.right,aRect.bottom-3);
          end;

        // последняя строка
        if (aRow=form16.StringGrid1.RowCount-1) and (aRow>1) and ((Acol=6) or (Acol=7)) then
          begin
            Brush.Color:=clWhite;
            FillRect(aRect.left,aRect.top+2,aRect.right,aRect.bottom-3);
          end;
   end;
end;

procedure TForm16.RadioButton3Change(Sender: TObject);
begin
  Form16.Check_sezon();
end;

procedure TForm16.RadioButton4Change(Sender: TObject);
begin
  Form16.Check_sezon();
end;

procedure TForm16.RadioButton5Change(Sender: TObject);
begin
  Form16.Check_sezon();
end;


//****************   ДОБАВИТЬ остановочный пункт в состав     ***********************************************
procedure TForm16.BitBtn2Click(Sender: TObject);
begin
  //If (length(m_sostav)>1) and schange and (dialogs.MessageDlg('Добавление пункта приведет к '+#13+'УДАЛЕНИЮ ручных изменений тарифа на расписании !'+#13+'Продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=7) then exit;
  schange:=false;
  flag_edit_sostav:=1;
  form22:=Tform22.create(self);
  form22.ShowModal;
  FreeAndNil(form22);
  //form16.StringGrid1.SetFocus;
  form16.perescet();
  form16.rascet();
  form16.StringGrid1.SetFocus;
  form16.StringGrid1.Row:=form16.StringGrid1.RowCount-1;
  flsostav:=true;//флаг изменения состава
  setlength(tarif_all,0,0);//удаляем тариф
end;



// ******************    УДАЛИТЬ  остановочный пункт из состава  ***************************************
procedure TForm16.BitBtn3Click(Sender: TObject);
var
  n,m:integer;
  tmp_ar : array of array of string;
begin
  form16.StringGrid1.SetFocus;
  if (trim(form16.StringGrid1.Cells[0,form16.StringGrid1.row])='') or (form16.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;
  // Нельзя удалить первый пока есть другие пункты
  if (form16.StringGrid1.row=1) and (form16.StringGrid1.rowcount>2) then
     begin
       showmessagealt('Невозможно удалить первый остановочный пункт'+#13+'так как существуют другие остановочные пункты в списке !');
       exit;
     end;
  //If schange and (dialogs.MessageDlg('Удаление пункта приведет к '+#13+'УДАЛЕНИЮ ручных изменений тарифа на расписании !'+#13+'Все равно удалить ?',mtConfirmation,[mbYes,mbNO], 0)=7) then exit;
     schange:=false;
     for n:=form16.StringGrid1.Row+1 to length(m_sostav)-1 do
      begin
       for m:=0 to sostav_size-1 do
         begin
           m_sostav[n-1,m]:=m_sostav[n,m];
         end;
      end;
     SetLength(m_sostav,length(m_sostav)-1,sostav_size);

     form16.rascet();
     form16.perescet();
     flsostav :=true; // флаг изменения состава
     //проставляем в массиве перевозчиков всем автоматический тариф
     //for n:=low(atp_sostav) to high(atp_sostav) do
     //  begin
     //   atp_sostav[n,3]:='0';
     //  end;
     //UpdateGridATP();
     //fltarif:=1;
     //setlength(tarif_all,0,0); //удаляем тариф

end;


//*-**************************   ВЫХОД  ************************************************************
procedure TForm16.BitBtn4Click(Sender: TObject);
begin
  form16.close;
end;


// ***********************************  ДОБАВИТЬ ПЕРЕВОЗЧИКА c автобусами ***************************************
procedure TForm16.BitBtn6Click(Sender: TObject);
var
  n:integer;
begin
  //Добавляем перевозчика
   flatp :=true;
  result_kontr_id:='';
  formsk:=Tformsk.create(self);
  formsk.ShowModal;
  FreeAndNil(formsk);
  if  trim(result_kontr_id)='' then exit;
  // Обновляем Stringgrid
  ///=========================================================================
  ///   Определяем перевозчика и список АТС
  ///=========================================================================
  With Form16 do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
     //Проверяем наличие активного договора перевозки
      form16.ZQuery1.SQL.Clear;
      form16.ZQuery1.SQL.add('SELECT a."name",a.id FROM av_spr_kontragent as a,av_spr_kontr_dog as b ');
      form16.ZQuery1.SQL.add('WHERE a.id = b.id_kontr and a.del=0 and b.del=0 and (cast(''0''||b.viddog as integer)=2) and a.id='+trim(result_kontr_id)+';');
//form16.ZQuery1.SQL.add('WHERE a.id = b.id_kontr and a.del=0 and b.del=0 and b.viddog='+quotedstr('00002')+' and b.datapog>=current_date and a.id='+trim(result_kontr_id)+';');
    //showmessage(ZQuery1.SQL.text);
     try
      form16.ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;
     if form16.ZQuery1.RecordCount=0 then
      begin
        showmessagealt('Для выбранного перевозчика отсутствует договор перевозки или срок его действия истек !'+#13+'Добавить данного перевозчика в список невозможно !');
        form16.ZQuery1.close;
        form16.ZConnection1.disconnect;
        exit;
      end;

      //Проверяем наличие АТС для данного перевозчика
       form16.ZQuery1.SQL.Clear;
       form16.ZQuery1.SQL.add('SELECT a."name",a.id FROM av_spr_kontragent as a,av_spr_kontr_ats as b ');
       form16.ZQuery1.SQL.add('WHERE a.id = b.id_kontr and a.del=0 and b.del=0 and a.id='+trim(result_kontr_id)+';');
       //showmessage(ZQuery1.SQL.text);
      try
       form16.ZQuery1.open;
      except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
       form16.ZQuery1.close;
       form16.ZConnection1.disconnect;
       exit;
      end;
      if form16.ZQuery1.RecordCount=0 then
       begin
         showmessagealt('Для выбранного перевозчика отсутствует список доступных АТС !'+#13+'Добавить данного перевозчика в список невозможно !');
         form16.ZQuery1.close;
         form16.ZConnection1.disconnect;
         exit;
       end;

      // проверяем что данного перевозчика еще нет в списке
      if form16.StringGrid8.RowCount>1 then
         begin
           for n:=1 to form16.StringGrid8.RowCount-1 do
             begin
               try
                 strtoint(form16.StringGrid8.Cells[0,n]);
                 strtoint(result_kontr_id);
               except
                 on exception: EConvertError do
                 begin
                   showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x10');
                   exit;
                end;
               end;
              if strtoint(form16.StringGrid8.Cells[0,n])=strtoint(result_kontr_id) then
                 begin
                   showmessagealt('Добавляемый контрагент уже присутствует в списке !'+#13+'Добавить данного перевозчика в список невозможно !');
                   form16.ZQuery1.close;
                   form16.ZConnection1.disconnect;
                   exit;
                 end;
             end;
         end;
       //=============================================================
       //Если все нормально, заполняем массивы перевозчиков и атс
       //=============================================================
       // Перевозчик
        form16.ZQuery1.SQL.Clear;
        form16.ZQuery1.SQL.add('SELECT a."name",a.id FROM av_spr_kontragent as a ');
        form16.ZQuery1.SQL.add('WHERE a.del=0 and a.id='+trim(result_kontr_id)+';');
       try
        form16.ZQuery1.open;
       except
        showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
        form16.ZQuery1.close;
        form16.ZConnection1.disconnect;
        exit;
       end;
       if form16.ZQuery1.RecordCount=0 then
        begin
          showmessagealt('ОШИБКА доступа к данным ! Попробуйте еще раз !');
          form16.ZQuery1.close;
          form16.ZConnection1.disconnect;
          exit;
        end;
       setlength(atp_sostav,length(atp_sostav)+1, atp_size);
       atp_sostav[length(atp_sostav)-1,0]:=form16.ZQuery1.FieldByName('id').AsString;
       atp_sostav[length(atp_sostav)-1,1]:=form16.ZQuery1.FieldByName('name').AsString;
       atp_sostav[length(atp_sostav)-1,2]:='0'; // Код АТС по умолчанию
       atp_sostav[length(atp_sostav)-1,3]:='0'; //тип расчета тарифа

       //АТС
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('SELECT b.id,b."name",b.m_down,b.m_up,b.m_lay,b.m_down_two,b.m_up_two,b.m_lay_two,b."level",b.type_ats FROM av_spr_kontr_ats as a,av_spr_ats as b');
        ZQuery1.SQL.add('WHERE a.id_ats = b.id and a.del=0 and b.del=0 and a.id_kontr='+trim(result_kontr_id)+' ORDER BY a.id_ats;') ;
       try
        ZQuery1.open;
       except
        showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
        ZQuery1.close;
        ZConnection1.disconnect;
        exit;
       end;
       if ZQuery1.RecordCount=0 then
        begin
          showmessagealt('ОШИБКА доступа к данным ! Попробуйте еще раз !');
          ZQuery1.close;
          ZConnection1.disconnect;
          exit;
        end;
       //если у перевозчика один автобус ставим его по умолчанию
       //if form16.ZQuery1.RecordCount=1 then
        //begin
          //atp_sostav[length(atp_sostav)-1,2]:=form16.ZQuery1.FieldByName('id').asString;
        //end;

        //ставим первый автобус автобусом по умолчанию
        atp_sostav[length(atp_sostav)-1,2]:=form16.ZQuery1.FieldByName('id').asString;
       // Дополняем массив
       form16.StringGrid9.Columns[5].ValueChecked:='1';
       form16.StringGrid9.Columns[5].ValueUnchecked:='0';
       for n:=1 to form16.ZQuery1.RecordCount do
          begin
            setlength(ats_sostav,length(ats_sostav)+1, ats_size);
            ats_sostav[length(ats_sostav)-1,0]:=form16.ZQuery1.FieldByName('id').asString;
            ats_sostav[length(ats_sostav)-1,1]:=form16.ZQuery1.FieldByName('name').asString;
            ats_sostav[length(ats_sostav)-1,2]:=form16.ZQuery1.FieldByName('level').asString; //кол-во этажей
            //общее количество мест
            ats_sostav[length(ats_sostav)-1,3]:=inttostr(ZQuery1.FieldByName('m_down').asInteger+ZQuery1.FieldByName('m_up').asInteger+ZQuery1.FieldByName('m_lay').asInteger+ZQuery1.FieldByName('m_down_two').asInteger+ZQuery1.FieldByName('m_up_two').asInteger+ZQuery1.FieldByName('m_lay_two').asInteger);
            if form16.ZQuery1.FieldByName('type_ats').asInteger=1 then ats_sostav[length(ats_sostav)-1,4]:='М2' else ats_sostav[length(ats_sostav)-1,4]:='М3';
            ats_sostav[length(ats_sostav)-1,5]:='0'; //признак активности АТС
            ats_sostav[length(ats_sostav)-1,6]:=trim(result_kontr_id); //код АТП
            form16.ZQuery1.next;
          end;
       ZQuery1.close;
      ZConnection1.disconnect;

      flsezon:=true;
      fltarif:=true;
        UpdateGridATP();
        UpdateGridATS();

  end;
end;

procedure TForm16.BitBtn8Click(Sender: TObject);
begin
  //Report_sostav_shedule();
end;

//добавить в список запрещенных пользователей
procedure TForm16.BitBtn9Click(Sender: TObject);
var
  n : integer;
begin
 //ОТКРЫВАЕМ справочник юзеров
  users_mode :=0;
  form_Users:=Tform_users.create(self);
  form_Users.ShowModal;
  FreeAndNil(form_users);
 //обрабатываем выбор
  if (result_user = '') then exit;
 //проверка на совпадающие
  with Form16.Stringgrid3 do
  begin
  for n:=1 to RowCount-1 do
    begin
      If Cells[0,n]=result_user then
      begin
       showmessagealt('Добавляемый пользователь уже есть в списке !');
       exit;
      end;
    end;
   // Columns[0].ValueChecked:='1';
  //  Columns[0].ValueUnchecked:='0';
    n := RowCount;
    RowCount:= RowCount + 1;
    Cells[0,n] := result_user;
    Cells[1,n] := result_usname;
    flblock := true;
  end;
end;

procedure TForm16.Button1Click(Sender: TObject);
 //var
  //n,m:integer;
  // s:string;
begin
   if form16.GroupBox5.Height<10 then
   begin
     form16.GroupBox5.Height:=65;
     form16.Button1.Caption:='ИНФО (показать)';
   end
   else
   begin
    form16.GroupBox5.Height:=1;
    form16.Button1.Caption:='ИНФО (скрыть)';
   end;
   application.ProcessMessages;
end;

procedure TForm16.Button2Click(Sender: TObject);
var
   n,m:integer;
   s,sss:string;
begin
  s:=inttostr(length(mas_date))+#13;
  for n:=low(mas_date) to High(mas_date) do
begin

   //sss:='month: '+(mas_date[n,0]);
      //for m:=0 to 13 do
      //   begin
      //     sss:=sss+' | '+(mas_date[n,m]);
      //   end;
       // sss:=sss+#13+'weeks: ';
       //for m:=14 to 19 do
       //  begin
       //    sss:=sss+' | '+(mas_date[n,m]);
       //  end;
        sss:='atp: '+(mas_date[n,0])+#13;
        sss:=sss+'months:';
        for m:=1 to 12 do
         begin
           sss:=sss+' | '+(mas_date[n,m]);
         end;
         sss:=sss+#13+'days of week:';
          for m:=13 to 26 do
         begin
           sss:=sss+' | '+(mas_date[n,m]);
         end;
       // sss:=sss+#13+'чет\нечет: ';
       // for m:=27 to 29 do
       //  begin
       //    sss:=sss+' | '+(mas_date[n,m]);
       //  end;
       // sss:=sss+#13+'days: ';
       // for m:=30 to 60 do
       //  begin
       //    sss:=sss+' | '+(mas_date[n,m]);
       //  end;
         sss:=sss+#13+'n-day: ';
        for m:=61 to 62 do
         begin
           sss:=sss+' | '+(mas_date[n,m]);
         end;
       s := s+sss+#13;
  end;
  showmessagealt(s);
end;

procedure TForm16.Button3Click(Sender: TObject);
begin
  showmas(tarif_all);
   //showmessage(inttostr(stringgrid10.RowCount));
end;

procedure TForm16.Button4Click(Sender: TObject);
begin
  showmas(atp_sostav);

end;

procedure TForm16.Button5Click(Sender: TObject);
begin
  //переключить на вкладку журнал изменений
  form16.PageControl1.ActivePageIndex:=3;
end;


procedure TForm16.CheckBox1Change(Sender: TObject);
begin
  If FOrm16.CheckBox1.Checked then
    FOrm16.GroupBox3.Visible:= true
   else
    Form16.GroupBox3.Visible:= false;
end;

// ****************************   Активность  ********************************
procedure TForm16.CheckBox2Change(Sender: TObject);
begin
    flchange:=true;
   If Form16.CheckBOx2.Checked then Form16.DateEdit3.Enabled := true
    else Form16.DateEdit3.Enabled:= false;
end;


procedure TForm16.CheckBox3Change(Sender: TObject);
begin
  if form16.CheckBox3.Checked then
     begin
       form16.CheckBox4.Checked:=false;
       form16.CheckBox5.Checked:=false;
     end;
  if (form16.CheckBox4.Checked=false) and (form16.CheckBox3.Checked=false) and (form16.CheckBox5.Checked=false) then form16.CheckBox3.Checked:=true;
end;

procedure TForm16.CheckBox4Change(Sender: TObject);
begin
    if form16.CheckBox4.Checked then
     begin
       form16.CheckBox3.Checked:=false;
       form16.CheckBox5.Checked:=false;
     end;
     if (form16.CheckBox4.Checked=false) and (form16.CheckBox3.Checked=false) and (form16.CheckBox5.Checked=false) then form16.CheckBox3.Checked:=true;
end;

procedure TForm16.CheckBox5Change(Sender: TObject);
begin
    if form16.CheckBox5.Checked then
     begin
       form16.CheckBox4.Checked:=false;
       form16.CheckBox3.Checked:=false;
     end;
     if (form16.CheckBox4.Checked=false) and (form16.CheckBox3.Checked=false) and (form16.CheckBox5.Checked=false) then form16.CheckBox3.Checked:=true;
end;

procedure TForm16.CheckBox6Change(Sender: TObject);
begin
      flchange:=true;
  If form16.CheckBox6.Checked then
   begin
      form16.Edit14.Visible:=true;
      form16.BitBtn13.Visible:=true;
   end
  else
  begin
      form16.Edit14.Visible:=false;
      form16.BitBtn13.Visible:=false;
   end
end;

//редактирование периода
procedure TForm16.DateEdit1Change(Sender: TObject);
begin
  flchange:=true;        //редактирование периода
end;

procedure TForm16.DateEdit2Change(Sender: TObject);
begin
    flchange:=true;        //редактирование периода
end;

procedure TForm16.DateEdit3Change(Sender: TObject);
begin
    flchange:=true;        //редактирование периода
end;


procedure TForm16.Edit2Change(Sender: TObject);
begin
 with Form16 do
 begin
  //if (trim(Edit2.text)='') OR (trim(Edit1.Text)='') OR (trim(Edit3.text)='') OR (trim(Edit13.text)='') //OR (trim(Edit6.text)='')
    //then PageControl1.Enabled:=false
    //else PageControl1.Enabled:=true;
 end;
end;

//редактирование имени расписания
procedure TForm16.Edit5Change(Sender: TObject);
begin
  flchange:=true;
end;

//редактирование кода расписания
procedure TForm16.Edit6Change(Sender: TObject);
begin
  flchange:=true;
end;


procedure TForm16.FloatSpinEdit1EditingDone(Sender: TObject);
//********************************************************** ПЕРЕСЧИТАТЬ ТАРИФ М2-мягкий С НОВЫМ КОЭФФИЦИЕНТОМ *********************************
var
   n:integer;
   tD : double=0;
begin
 fltarif :=true;
   for n:=0 to length(tarif_all)-1 do
     begin
       If tarif_all[n,13]=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
        begin
         td:=strtofloat(tarif_all[n,2])*FloatSpinEdit1.Value;
         tarif_all[n,5]:=floattostrF(round(td*100)/100,fffixed,12,2);
         tarif_all[n,10]:=stringreplace(FloatSpinEdit1.text,',','.',[]);
     end;
       end;
  Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));
end;

//********************************************************** ПЕРЕСЧИТАТЬ багаж С НОВЫМ КОЭФФИЦИЕНТОМ *********************************
procedure TForm16.FloatSpinEdit2EditingDone(Sender: TObject);
var
   n : integer;
   bag:string;
begin
 fltarif :=true;
 bag:= stringreplace(form16.FloatSpinEdit2.text,',','.',[]);
    for n:=0 to length(tarif_all)-1 do
     begin
       If tarif_all[n,13]=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
        begin
        tarif_all[n,7]:=bag;
        if form16.RadioButton1.Checked then tarif_all[n,12]:='1';
        if form16.RadioButton2.Checked then tarif_all[n,12]:='2';
        end;
   end;
   Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));
end;


procedure TForm16.FloatSpinEdit3EditingDone(Sender: TObject);
//********************************************************** ПЕРЕСЧИТАТЬ ТАРИФ М2-жесткий С НОВЫМ КОЭФФИЦИЕНТОМ *********************************
var
   n : integer;
   tD : double=0;
begin
 fltarif :=true;
    for n:=0 to length(tarif_all)-1 do
     begin
       If tarif_all[n,13]=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
        begin
         td:=strtofloat(tarif_all[n,2])*FloatSpinEdit3.Value;
         tarif_all[n,3]:=floattostrF(round(td*100)/100,fffixed,12,2);
       tarif_all[n,8]:=stringreplace(FloatSpinEdit3.text,',','.',[]);
     end;
       end;
   Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));
end;

procedure TForm16.FloatSpinEdit4EditingDone(Sender: TObject);
//********************************************************** ПЕРЕСЧИТАТЬ ТАРИФ М3-мягкий С НОВЫМ КОЭФФИЦИЕНТОМ *********************************
var
   n : integer;
   tD : double=0;
begin
  //  tarif_all[n,3]:= ;  Жесткий М2
  //  tarif_all[n,4]:= ;  Жесткий М3
  //  tarif_all[n,5]:= ;  Мягкий М2
  //  tarif_all[n,6]:= ;  Мягкий М3
  //  tarif_all[n,7]:= ;  Цена БАГАЖ
//  tarif_all[n,8]:= ;  Тариф Жесткий М2
//  tarif_all[n,9]:= ;  Тариф Жесткий М3
// tarif_all[n,10]:= ;  Тариф Мягкий М2
// tarif_all[n,11]:= ;  Тариф Мягкий М3
 fltarif :=true;
   for n:=0 to length(tarif_all)-1 do
     begin
       If tarif_all[n,13]=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
        begin
         td:=strtofloat(tarif_all[n,2])*FloatSpinEdit4.Value;
         tarif_all[n,6]:=floattostrF(round(td*100)/100,fffixed,12,2);
      tarif_all[n,11]:=stringreplace(FloatSpinEdit4.text,',','.',[]);
     end;
       end;
  Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));
end;

procedure TForm16.FloatSpinEdit5EditingDone(Sender: TObject);
//********************************************************** ПЕРЕСЧИТАТЬ ТАРИФ М3-жесткий С НОВЫМ КОЭФФИЦИЕНТОМ *********************************
var
   n : integer;
   tD : double=0;
begin
  //  tarif_all[n,3]:= ;  Жесткий М2
  //  tarif_all[n,4]:= ;  Жесткий М3
  //  tarif_all[n,5]:= ;  Мягкий М2
  //  tarif_all[n,6]:= ;  Мягкий М3
  //  tarif_all[n,7]:= ;  Цена БАГАЖ
//  tarif_all[n,8]:= ;  Тариф Жесткий М2
//  tarif_all[n,9]:= ;  Тариф Жесткий М3
// tarif_all[n,10]:= ;  Тариф Мягкий М2
// tarif_all[n,11]:= ;  Тариф Мягкий М3
// tarif_all[n,12]:= ;  тип расчета Багажа 0-автоматом,1-сумма,2-процент от билета
// tarif_all[n,13]:= ;  id АТП
// tarif_all[n,14]:= ;  flag редактирования 0-автомат,1-ручной
  fltarif :=true;
   for n:=0 to length(tarif_all)-1 do
     begin
       If tarif_all[n,13]=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
        begin
         td:=strtofloat(tarif_all[n,2])*FloatSpinEdit5.Value;
         tarif_all[n,4]:=floattostrF(round(td*100)/100,fffixed,12,2);
      tarif_all[n,9]:=stringreplace(FloatSpinEdit5.text,',','.',[]);
         end;
     end;
  Refresh_all_grid(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]));
end;


//***   закрытие формы *********************************
procedure TForm16.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  If (flchange) and (fl_print<>1) then
      if dialogs.MessageDlg('Изменения в расписании НЕ будут СОХРАНЕНЫ !!!'+#13+'Продолжить выход ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
        begin
          CloseAction := caNone;
          exit;
        end;

  //если открыт не в режиме печати отчета - exit
 If fl_print=1 then exit;
 MasFree();//очистить память от массивов
end;

procedure TForm16.FormCreate(Sender: TObject);
begin

end;



procedure TForm16.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
 n,srow:integer;
begin
    // F1
    //if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F7] - Поиск'+#13+'[F8] - Удалить'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F7] - Поиск'+#13+'[F8] - Удалить'+#13+'[ПРОБЕЛ] - Отметить'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    //F2 - Сохранить
    if (Key=113) and (form16.bitbtn5.enabled=true) then form16.bitbtn5.click;
    //F4 - Изменить
    if (Key=115) and (form16.bitbtn12.enabled=true) then form16.BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (form16.bitbtn2.enabled=true) then form16.BitBtn2.Click;
    //F8 - Удалить
    if (Key=119) and (form16.bitbtn3.enabled=true) then form16.BitBtn3.Click;
    //SPACE
    {if (Key=32) then
      begin
        // Меняем check и ats_sostav
        if (form16.StringGrid9.RowCount>1) then
         begin
         // Поиск в массиве
           for n:=0 to length(ats_sostav)-1 do
              begin
                if (trim(ats_sostav[n,6])=trim(form16.StringGrid8.Cells[0,form16.StringGrid8.row])) and (trim(ats_sostav[n,0])=trim(form16.StringGrid9.Cells[0,form16.StringGrid9.row])) then
                  begin
                    srow:=form16.StringGrid9.Row;
                    if form16.StringGrid9.cells[5,form16.StringGrid9.Row]='1' then ats_sostav[n,5]:='0' else ats_sostav[n,5]:='1';
                 end
              end;
           form16.UpdateGridATS();
           form16.StringGrid9.Row:=srow;
         end;
      end;}
    // ESC
    if Key=27 then form16.BitBtn4.Click;

    if (Key=112) or (Key=113) or (Key=115) or (Key=116) or (Key=119) or (Key=27) then Key:=0;
end;


// выбрать МАРШРУТ
procedure TForm16.BitBtn1Click(Sender: TObject);
var
  rid,rkod,rname,rtype : string;
  ntype,flc: byte;
begin
 flchange:=true;
 //Запоминаем маршрут
 If trim(form16.Edit1.Text)='' then tekroute:='' else  tekroute:=trim(form16.Edit1.Text);

  form17:=Tform17.create(self);
  form17.ShowModal;
  FreeAndNil(form17);

  tekroute:='';
  with Form16 do
  begin
    flc := 0;
  // Заполняем поля для МАРШРУТОВ
  if not(result_id_route='') then
   begin
     ntype:=99;
     //запоминаем тип маршрута
     If trim(form16.edit13.text) = cMezhgorod then ntype:=0;
     If trim(form16.edit13.text) = cPrigorod  then ntype:=1;
     If trim(form16.edit13.text) = cKray      then ntype:=2;
     If trim(form16.edit13.text) = cGos       then ntype:=3;

     // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
     //Делаем запрос к маршрутам
      form16.ZQuery1.SQL.Clear;
//    form16.ZQuery1.SQL.add('select * from av_route where id='+trim(result_id_route)+' and del=0;');
      form16.ZQuery1.SQL.add('SELECT a.id,b.name AS name1,c.name AS name2,d.name AS name3,a.kod,a.type_route from av_route AS a ');
      form16.ZQuery1.SQL.add('Left JOIN av_spr_locality AS b ON a.id_nas1=b.id AND b.del=0 ');
      form16.ZQuery1.SQL.add('Left JOIN av_spr_locality AS c ON a.id_nas2=c.id AND c.del=0 ');
      form16.ZQuery1.SQL.add('Left JOIN av_spr_locality AS d ON a.id_nas3=d.id AND d.del=0 ');
      form16.ZQuery1.SQL.add('WHERE a.id='+trim(result_id_route)+' AND a.del=0;');
      //showmessage(form16.ZQuery1.SQL.Text);
     try
      form16.ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+form16.ZQuery1.SQL.Text);
      form16.ZQuery1.close;
      form16.ZConnection1.disconnect;
      exit;
     end;
     If Zquery1.RecordCount=1 then
       begin
     // Запоминаем поля если
      rid:=form16.ZQuery1.FieldByName('id').asString;
      rkod:=form16.ZQuery1.FieldByName('kod').asString;
      rname:=form16.ZQuery1.FieldByName('name1').asString+' - '+form16.ZQuery1.FieldByName('name2').asString;
     if not(trim(form16.ZQuery1.FieldByName('name3').asString)='') then rname:= rname+' - '+form16.ZQuery1.FieldByName('name3').asString;
     if form16.ZQuery1.FieldByName('type_route').asInteger=0 then rtype:=cMezhgorod;
     if form16.ZQuery1.FieldByName('type_route').asInteger=1 then rtype:=cPrigorod;
     if form16.ZQuery1.FieldByName('type_route').asInteger=2 then rtype:=cKray;
     if form16.ZQuery1.FieldByName('type_route').asInteger=3 then rtype:=cGos;


     //если меняется тип маршрута, то сбрасываем тариф расписания, если он автоматический
   //  if (ZQuery1.FieldByName('type_route').asInteger<>ntype) AND (flag_edit_shedule=2) then
   //    begin
   //       ZQuery1.SQL.Clear;
   //        ZQuery1.SQL.add('SELECT id_shedule FROM av_shedule_tarif WHERE id_shedule='+ old_id +' and del=0 AND calculation_type=1;');
   //          try
   //            ZQuery1.open;
   //          except
   //            showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
   //            ZQuery1.Close;
   //            Zconnection1.disconnect;
   //            exit;
   //          end;
   //    If  Zquery1.RecordCount>0 then
   //    begin
   //     If (dialogs.MessageDlg('Изменение типа маршрута приведет к УДАЛЕНИЮ ручных изменений тарифа !'+#13+'Все равно продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=6) then
   //     begin
   //        ZQuery1.SQL.Clear;
   //        ZQuery1.SQL.add('UPDATE av_shedule_tarif SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+ old_id +' and del=0;');
   //          try
   //            ZQuery1.ExecSQL;
   //          except
   //            showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
   //            ZQuery1.Close;
   //            Zconnection1.disconnect;
   //            exit;
   //          end;
   //      end
   //     else
   //          flc:=1; //оставить все как было
   //    end;
   //end;
    ////////////
    If flc=0 then
    begin
    // Заполняем все поля edit
     form16.Edit1.Text:= rid;
     form16.Edit3.Text:= rkod;
     form16.Edit2.Text:= rname;
     form16.edit13.text:=rtype;
    //if form16.ZQuery1.FieldByName('type_route').asInteger=0 then :=cMezhgorod;
    //if form16.ZQuery1.FieldByName('type_route').asInteger=1 then form16.edit13.text:=cPrigorod;
    //if form16.ZQuery1.FieldByName('type_route').asInteger=2 then form16.edit13.text:=cKray;
    //if form16.ZQuery1.FieldByName('type_route').asInteger=3 then form16.edit13.text:=cGos;
     end;
     ZQuery1.Close;
     ZConnection1.Disconnect;
     PageControl1.Enabled:=true;
   end;
  end;
end;
end;

// кнопка теряет фокус - поднять флаг
procedure TForm16.BitBtn1Exit(Sender: TObject);
begin
   //flchange := true; //флаг изменений
end;


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//************************************************   РАССЧИТАТЬ ТАРИФ   *********************************************************************
function TForm16.tarif_auto(atp:string):boolean;
var
   n,m,t:integer;
   tmp_tarif:array of array of string;
   t1:tdatetime;
   //tmp_bagag:array of array of string;
   //tmp_perem:array of array of string;
   //tmp_tmp:array of array of string;
   //tmp_uslugi:array of array of string;
   //full_tarif:array of array of string;
   //full_bagag:array of array of string;
   //Tek_tarif:integer;

     //,m_typats,m_atp:integer;
   //flag_wibor_tarif,m_typshedule:integer;
   //s:string;
   //flag_prigorod_rajon:byte;
begin
 //decimalseparator:='.';
 result :=false;

  If form16.PageControl1.ActivePageIndex=0 then
  begin
    result:=true;
    exit;
  end;
 //Если мы не на вкладке тарифа, то ничего не рассчитывать
 If form16.PageControl2.ActivePageIndex<>0 then
  begin
    //result:=true;
    //exit;
  end;

 //form16.Panel1.Visible:=true;
 //application.ProcessMessages;
 // ------------- проверяем что определен состав расписания ----------------------------------
  if length(m_sostav)<3 then
     begin
       showmessagealt('Для расчета тарифной стоимости билетов необходимо определить состав расписания !');
       exit;
     end;

  // ------------- проверяем что определен состав АТП ----------------------------------
  if length(atp_sostav)=0 then
     begin
       showmessagealt('Для расчета тарифной стоимости билетов необходимо определить перевозчика !');
       exit;
     end;

 with form16 do
 begin
 // ------------- проверяем что выбрана дата тарифа ----------------------------------
  //if trim(combobox4.Text)='' then
  //   begin
  //     showmessagealt('Для расчета цен билетов необходимо выбрать ДАТУ действия ТАРИФА !');
  //     exit;
  //   end;

  // Удалить элемент массива по коду атп
 // Если массив не определен то отваливаемся
 if (length(tarif_all)>0) then
     begin
  // Формируем tmp_tarif
  SetLength(tmp_tarif,0,0);
  for n:=0 to length(tarif_all)-1 do
    begin
      if not(trim(tarif_all[n,13])=atp) then
        begin
         SetLength(tmp_tarif,length(tmp_tarif)+1, tarif_size);
         for m:=0 to tarif_size-1 do
           begin
             tmp_tarif[length(tmp_tarif)-1,m]:=tarif_all[n,m];
           end;
        end;
    end;
  // Формируем новый tarif_all
  SetLength(tarif_all,0,0);
  //записываем туда старые значения без текущего перевозчика
  for n:=0 to length(tmp_tarif)-1 do
    begin
      SetLength(tarif_all,length(tarif_all)+1, tarif_size);
      for m:=0 to tarif_size-1 do
        begin
           tarif_all[length(tarif_all)-1,m]:=tmp_tarif[n,m];
        end;
    end;
  end;
   //StringGrid10.RowCount:=1;
   //StringGrid2.RowCount:=1;
 t:=0; //сбрасываем счетчик запросов
 // Цикл по составу расписания
 //проходим состав расписания (кроме последнего пункта) и если формирующийся, тогда делаем запрос на тарифы по остановочным пунктам до следующего формирующегося
  for n:=1 to length(m_sostav)-2 do
      begin

   //если не формирующийся то отвал
   If  (m_sostav[n,2]<>'1') then continue;
   t := t+1;
    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
      begin
        showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
        exit;
      end;
   //t1:=time();
    // Загружаем тарифы
   ZQuery1.Close;
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add('select * from gettarif('+quotedstr('tarif')+', '+Label4.caption+',current_date,'+atp+','+inttostr(n)+');');
   ZQuery1.sql.add('FETCH ALL IN tarif;');
   //showmessage(ZQuery1.SQL.Text);//$
   try
      ZQuery1.open;
    except
         showmessage('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
         ZQuery1.Close;
         Zconnection1.disconnect;
         exit;
    end;
   //showmessagealt(inttostr(t)+'|'+timetostr(time()-t1));//$
  If ZQuery1.RecordCount=0 then
    begin
      showmessagealt('Нет данных по тарифам расписания !!!'+#13+'Сообщите об этом АДМИНИСТРАТОРУ !!!');
       ZQuery1.Close;
       Zconnection1.disconnect;
      continue;
    end;

   for m:= 1 to Zquery1.RecordCount do
        begin
        //Если уже не первый запрос к составу расписания, то пропускаем первый остановочный пункт (который был последним в предыдущем запросе)
        If (m=1) and (t>1) then
          begin
           ZQuery1.Next;
          continue;
          end;
        // ************************** Рисуем GRID Тариф текущий ***********************************
        SetLength(tarif_all,length(tarif_all)+1, tarif_size);
       tarif_all[length(tarif_all)-1,0]:= form16.ZQuery1.FieldByName('id_point').AsString; // id остановочного пункта
       tarif_all[length(tarif_all)-1,1]:= form16.ZQuery1.FieldByName('name').AsString;//  Наименование остановочного пункта
       tarif_all[length(tarif_all)-1,2]:= form16.ZQuery1.FieldByName('km').AsString; // Путь в км.
       tarif_all[length(tarif_all)-1,3]:= form16.ZQuery1.FieldByName('hardm2').AsString; //  Жесткий М2
       tarif_all[length(tarif_all)-1,4]:= form16.ZQuery1.FieldByName('hardm3').AsString;//  Жесткий М3
       tarif_all[length(tarif_all)-1,5]:= form16.ZQuery1.FieldByName('softm2').AsString; //  Мягкий М2
       tarif_all[length(tarif_all)-1,6]:= form16.ZQuery1.FieldByName('softm3').AsString; //  Мягкий М3
       tarif_all[length(tarif_all)-1,7]:= form16.ZQuery1.FieldByName('bagazh').AsString; //  Цена БАГАЖ
       tarif_all[length(tarif_all)-1,8]:= form16.ZQuery1.FieldByName('thardm2').AsString; //  Тариф Жесткий М2
       tarif_all[length(tarif_all)-1,9]:= form16.ZQuery1.FieldByName('thardm3').AsString; //  Тариф Жесткий М3
       tarif_all[length(tarif_all)-1,10]:= form16.ZQuery1.FieldByName('tsoftm2').AsString; //  Тариф Мягкий М2
       tarif_all[length(tarif_all)-1,11]:= form16.ZQuery1.FieldByName('tsoftm3').AsString; //  Тариф Мягкий М3
       tarif_all[length(tarif_all)-1,12]:= '0'; //тип расчета багажа - автомат
       tarif_all[length(tarif_all)-1,13]:= atp; //  id АТП
       tarif_all[length(tarif_all)-1,14]:= '0'; //  flag редактирования 0-автомат,1-ручной
        //StringGrid10.RowCount:= StringGrid10.RowCount+1;
        //StringGrid10.cells[0, StringGrid10.rowcount-1]:= ZQuery1.FieldByName('id_point').AsString;
         //StringGrid10.cells[1, StringGrid10.rowcount-1]:= ZQuery1.FieldByName('name').AsString;
         //StringGrid10.cells[2, StringGrid10.rowcount-1]:= ZQuery1.FieldByName('km').AsString;
         //StringGrid10.cells[3, StringGrid10.rowcount-1]:= ZQuery1.FieldByName('hardm2').AsString;
         //StringGrid10.cells[4, StringGrid10.rowcount-1]:= ZQuery1.FieldByName('hardm3').AsString;
         //StringGrid10.cells[5, StringGrid10.rowcount-1]:= ZQuery1.FieldByName('softm2').AsString;
         //StringGrid10.cells[6, StringGrid10.rowcount-1]:= ZQuery1.FieldByName('softm3').AsString;
         //StringGrid10.cells[7, StringGrid10.rowcount-1]:= ZQuery1.FieldByName('bagazh').AsString;

         //// ************************** Рисуем GRID Тариф скрытый ***********************************
         //StringGrid2.RowCount:= StringGrid2.RowCount+1;
         //StringGrid2.cells[0, StringGrid2.rowcount-1]:= ZQuery1.FieldByName('thardm2').AsString;
         //StringGrid2.cells[1, StringGrid2.rowcount-1]:= ZQuery1.FieldByName('thardm3').AsString;
         //StringGrid2.cells[2, StringGrid2.rowcount-1]:= ZQuery1.FieldByName('tsoftm2').AsString;
         //StringGrid2.cells[3, StringGrid2.rowcount-1]:= ZQuery1.FieldByName('tsoftm3').AsString;
        ZQuery1.Next;
      end;

   ZQuery1.Close;
   Zconnection1.disconnect;
 end;
  form16.GroupBox2.Enabled:=false;
   result:=true;
   form16.Panel1.Visible:=false;
   setlength(tmp_tarif,0,0);
   tmp_tarif := nil;
 end;

//  //button3.Click;
//    Refresh_arrays(atp);    // Обновляем все массивы по условию id АТП
//
//  result:=true;

end;
//*****************************************************************************************************************************************************
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// ************* удалить запрещеннего пользователя из списка ********************************************
procedure TForm16.BitBtn25Click(Sender: TObject);
begin
  DelStringgrid(Form16.StringGrid3, Form16.StringGrid3.Row);
   flblock := true;
end;


procedure TForm16.BitBtn21Click(Sender: TObject);
 var
  n,k,m:integer;
   //s:string;
 begin
  //проверяем что после текущей точки возврата нет больше остановочных пунктов
  if length(m_sostav)>(form16.StringGrid1.Row+1) then
   begin
    //if not(dialogs.MessageDlg('   В составе расписания уже определены следующие'+#13+'остановочные пункты после точки возврата.'+#13+
    //                          '   Если продолжить процедуру автоматического формирования'+#13+'обратного списка остановочных пунктов то'+#13+
    //                          'существующие остановочные пункты, находящиеся [ниже] точки возврата'+#13+'будут удалены и заполнены следующими остановочными пунктами.'+#13+
    //                          '   Вы еще хотите выполнить автоматическое заполнение списка остановочных пунктов'+#13+'для обратного пути следования ?'
    //                          ,mtConfirmation,[mbYes,mbNO], 0)=6) then exit;
   if not(dialogs.MessageDlg('Остановочные пункты, нижестоящие от точки возврата БУДУТ УДАЛЕНЫ и перезаписаны с новыми параметрами !'+#13+
                              'Продолжить расчет списка и параметров остановочных пунктов для обратного пути следования ?',mtConfirmation,[mbYes,mbNO], 0)=6) then exit;
    end;

  // Создаем автоматический список остановочных пунктов в составе расписания после точки возврата
  SetLength(m_sostav,form16.StringGrid1.row+form16.StringGrid1.row,sostav_size);
  k:=0;
  for n:=form16.StringGrid1.row-1 downto 1 do
    begin
     k:=k+1;
     for m:=0 to sostav_size-1 do
         begin
          //m_sostav[form16.StringGrid1.row+k,m]:=m_sostav[n,m];
           //9,7,8
           if not(m=9) and not(m=8) and not(m=10) then m_sostav[form16.StringGrid1.row+k,m]:=m_sostav[n,m];
           if (m=9) or (m=8) or (m=10) then m_sostav[form16.StringGrid1.row+k,m]:=m_sostav[n+1,m];
         end;
    end;
  form16.StringGrid1.SetFocus;
  form16.perescet();
  form16.rascet();
  //SetLength(m_sostav,length(m_sostav)-1,14);

 { s:='';
  for n:=0 to 13 do
     begin
       s:=s+' | '+m_sostav[length(m_sostav)-1,n];
     end;
  showmessagealt(s);}
  showmessagealt('   Процедура расчета списка остановочных пунктов для'+#13+'обратного пути следования - ЗАВЕРШЕНА !'+#13+
              '   Проверьте параметры ВСЕХ добавленных остановочных пунктов !');
end;

// *************** показать календарный график работы расписания *******************************************
procedure TForm16.BitBtn22Click(Sender: TObject);
begin
  if (trim(form16.DateEdit1.text)='') or (trim(form16.DateEdit2.text)='') or (trim(form16.DateEdit3.text)='') then
     begin
      showmessagealt('Не определены даты работы расписания !');
      exit;
     end;
  Refresh_arrays(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]),false);    // Обновляем все массивы по условию id АТП
  formgr:=Tformgr.create(self);
  formgr.ShowModal;
  FreeAndNil(formgr);
end;


//***************     Двигаем остановочный пункт ВВЕРХ *******************************
procedure TForm16.BitBtn23Click(Sender: TObject);
 var
   tmp_set:array[0..1,0..sostav_size-1] of string;
   n:integer;
   tarif_manual:boolean;
begin
  // Если нет пунктов или первый то ничего не делаем
  if (form16.StringGrid1.RowCount=1) or (form16.StringGrid1.Row=2) then exit;
  //проверяем есть ли ручные корректировки тарифа
  tarif_manual:=false;
   for n:=low(atp_sostav) to high(atp_sostav) do
       begin
        If atp_sostav[n,3]<>'0' then tarif_manual:=true;
       end;
  //If schange AND tarif_manual and (dialogs.MessageDlg('Изменение состава расписания приведет к УДАЛЕНИЮ изменений в тарифе !'+#13+'Все равно продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=7) then
  //      begin
  //        ZQuery1.Close;
  //        ZConnection1.Disconnect;
  //        exit;
  //      end;
  schange:=false;
  //Меняем переменные в массиве местами
  for n:=0 to sostav_size-1 do
    begin
       tmp_set[0,n]:=m_sostav[form16.StringGrid1.row,n];
       m_sostav[form16.StringGrid1.row,n]:=m_sostav[form16.StringGrid1.row-1,n];
       m_sostav[form16.StringGrid1.row-1,n]:=tmp_set[0,n];
    end;
  form16.StringGrid1.Row:=form16.StringGrid1.Row-1;
  form16.StringGrid1.SetFocus;
  form16.perescet();
  form16.rascet();
  flsostav := true; // флаг изменения состава

   //проставляем в массиве перевозчиков всем автоматический тариф
     for n:=low(atp_sostav) to high(atp_sostav) do
       begin
        atp_sostav[n,3]:='0';
       end;
     UpdateGridATP();
     fltarif:= true;
     setlength(tarif_all,0,0); //удаляем тариф
end;


//***************        Двигаем остановочный пункт ВНИЗ   ***************************************
procedure TForm16.BitBtn24Click(Sender: TObject);
 var
   tmp_set:array[0..1,0..13] of string;
   n:integer;
   tarif_manual:boolean;
begin

  // Если нет пунктов или первый то ничего не делаем
  if (form16.StringGrid1.RowCount=form16.StringGrid1.Row+1) or (form16.StringGrid1.Row=1) then exit;
 //проверяем есть ли ручные корректировки тарифа
  tarif_manual:=false;
   for n:=low(atp_sostav) to high(atp_sostav) do
       begin
        If atp_sostav[n,3]<>'0' then tarif_manual:=true;
       end;
  //If schange AND tarif_manual and (dialogs.MessageDlg('Изменение состава расписания приведет к УДАЛЕНИЮ изменений в тарифе !'+#13+'Все равно продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=7) then
  //      begin
  //        ZQuery1.Close;
  //        ZConnection1.Disconnect;
  //        exit;
  //      end;
   schange:=false;
  //Меняем переменные в массиве местами
  for n:=0 to sostav_size-1 do
    begin
       tmp_set[0,n]:=m_sostav[form16.StringGrid1.row,n];
       m_sostav[form16.StringGrid1.row,n]:=m_sostav[form16.StringGrid1.row+1,n] ;
       m_sostav[form16.StringGrid1.row+1,n]:=tmp_set[0,n];
    end;
  form16.StringGrid1.Row:=form16.StringGrid1.Row+1;
  form16.StringGrid1.SetFocus;
  form16.perescet();
  form16.rascet();
  flsostav := true; // флаг изменения состава
   //проставляем в массиве перевозчиков всем автоматический тариф
     for n:=low(atp_sostav) to high(atp_sostav) do
       begin
        atp_sostav[n,3]:='0';
       end;
     UpdateGridATP();
     fltarif:= true;
     setlength(tarif_all,0,0); //удаляем тариф
end;


procedure TForm16.BitBtn26Click(Sender: TObject);
begin
  if not(trim(form16.edit5.Text)='') then form16.edit5.Text:=form16.edit5.Text+' - '+m_sostav[form16.StringGrid1.Row,1] else form16.edit5.Text:=form16.edit5.Text+m_sostav[form16.StringGrid1.Row,1];
end;


//*****************************************************  ОтЧЕТ ПЕРЕСЕЧЕНИЯ ПЕРЕВОЗЧИКОВ НА РАСПИСАНИИ   *******************************************
procedure TForm16.BitBtn27Click(Sender: TObject);
begin
   crossgraf();
end;


procedure TForm16.crossgraf();  //ОтЧЕТ ПЕРЕСЕЧЕНИЯ ПЕРЕВОЗЧИКОВ НА РАСПИСАНИИ
var
  k,n,m,x : integer;
  lg:boolean=false;
  priz1,priz2:integer;
  //arSezon : array of array of String;
  tDate1 : string;
begin
  If form16.StringGrid6.RowCount<4 then
    begin
      showmessagealt('Отчет рассчитывается при 2-х и более перевозчиках на расписании!');
      exit;
    end;
  if (trim(form16.DateEdit1.text)='') or (trim(form16.DateEdit2.text)='') or (trim(form16.DateEdit3.text)='') then
     begin
      showmessagealt('Не определены даты работы расписания !');
      exit;
     end;

  Refresh_arrays(trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]),false);    // Обновляем все массивы по условию id АТП

 //  arSATP - Описание
  //-------------------------------------------------------
  //  arSATP[n,0]:= ;  дата
  //  arSATP[n,1]:= ;  признак пересечения
  //  arSATP[n,....]:= ;  дни с даты активации по дату окончания работы расписания
  SetLength(arSATP,0,0);
  SetLength(arSATP,dateutils.daysbetween(Form16.DateEdit2.Date,Form16.DateEdit3.Date),form16.StringGrid6.Rowcount-2+2); //дата+признак+количество АТП

  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

 //пробегаем всех перевозчиков
 For n:=0 to length(atp_sostav)-1 do
   begin
   //SetLength(arSezon,0,2);
   k:= -1;
   sdate := '';
   //ищем соответствие сезонности перевозчика с гридом
   For x:=0 to Length(mas_date)-1 do
     begin
     If atp_sostav[n,0]=mas_date[x,0] then
     begin
        k:=x;
        break;
     end;
     end;
   //если у перевозчика нет массива с сезонностью - отвал
   If k=-1 then
   begin
    showmessagealt('Не определен календарный план '+#13+'для перевозчика: '+atp_sostav[n,1]+' !');
    exit;
    //For x:=0 to Length(mas_date)-1 do
    //  begin
    //  If mas_date[x,0]= '0' then
    //  begin
    //   k:=x;
    //   break;
    //  end;
    //  end;
   end;
   For x:=1 to 62 do
     begin
        sdate := sdate + mas_date[k,x];
     end;
    //showmessage(inttostr(n)+' | '+inttostr(length(arSatp)));
   for m:=0 to length(arSatp)-1 do
    begin
    try
    tDate1 := datetostr(form16.DateEdit1.date+m);
    except
      //on exception: EConvertError do
       //begin
          showmessagealt('ОШИБКА КОНВЕРТАЦИИ ДАТЫ !!!'+#13+form16.DateEdit1.Text+'x01');
          continue;
       //end;
    end;
    Form16.ZQuery1.SQL.Clear;
    Form16.ZQuery1.SQL.add('SELECT getsezon('+quotedstr(sdate)+','+quotedstr(datetostr(form16.DateEdit3.date))+','+quotedstr(tDate1)+') as res;');
    //showmessage(Form16.ZQuery1.SQL.Text);
    try
      Form16.ZQuery1.open;
    except
     showmessagealt('ОШИБКА запроса к базе данных !'+#13+Form16.ZQuery1.SQL.Text);
     Form16.ZQuery1.Close;
     Form16.Zconnection1.disconnect;
     break;
    end;
     arSatp[m,0] :=datetostr(form16.DateEdit1.date+m);
     arSatp[m,n+2] :=Ifthen(form16.ZQuery1.FieldByName('res').AsBoolean=true,'1','0');
    end;
    //GetSezon(Form16.DateEdit3.Date,Form16.DateEdit2.Date,sdate,arSezon);
    //If length(arSezon)>length(arSatp) then
    //  begin
    //    showmessagealt('Ошибка ! Несоответствие длины массивов.');
    //    lg:=true;
    //    break;
    //  end;
    //for x:=0 to Length(arSezon)-1 do
    //  begin
    //     arSATP[x,0] := arSezon[x,0]; //дата
    //     arSatp[x,n] := arSezon[x,1]; //признак осуществления перевозки АТП
    //  end;
   end;
  //showmas(arsatp);
   Form16.ZQuery1.Close;
   Form16.Zconnection1.disconnect;

 If lg then exit;
 //определяем пересечение
 //showmessage(inttostr(high(arSatp[low(arsatp)])));
 for x:=0 to Length(arSATP)-1 do
      begin
        priz1:=0;
        priz2:=0;
       for n:=2 to high(arSatp[low(arsatp)]) do
            begin
             If trim(arSatp[x,n])='' then arSatp[x,n]:='0';
               try
               priz1:= strtoINt(arSatp[x,n]);
               except
                 on exception: EConvertError do
                 begin
                   showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x12');
                   exit;
                 end;
               end;
            priz2:=priz2 + priz1;
            end;
       If priz2>1 then arSatp[x,1]:='2' else arSatp[x,1]:='0'; //признак пересечения
      end;

 //showmessage(intTostr(length(arSezon)));
 Report_SezonATP(); //вывод отчета

 SetLength(arSATP,0,0);
 arSatp := nil;
end;

procedure TForm16.BitBtn28Click(Sender: TObject);
begin
   DelStringgrid(Form16.StringGrid11, Form16.StringGrid11.Row);
end;

procedure TForm16.BitBtn29Click(Sender: TObject);
begin
  DelStringgrid(Form16.StringGrid12, Form16.StringGrid12.Row);
end;


//*******************************    ИЗМЕНИТЬ СОСТАВ          **********************************************
procedure TForm16.BitBtn12Click(Sender: TObject);
begin
    if (trim(form16.StringGrid1.Cells[0,form16.StringGrid1.row])='') or (form16.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для редактирования !');
       exit;
     end;
   //Если первый пункт в составе
  //if (form16.StringGrid1.RowCount>0) and (form16.StringGrid1.Row=1) then
  //     begin
  //       showmessagealt('Нельзя редактировать первую запись в составе, ее можно только удалить !');
  //       exit;
  //     end;
  flcritical:=false;
  flag_edit_sostav:=2;
  form22:=Tform22.create(self);
  form22.ShowModal;
  FreeAndNil(form22);
  form16.StringGrid1.SetFocus;
  form16.perescet();
  form16.rascet();
  //If flcritical then
  flsostav := true; // флаг изменения состава
end;

// выбрать договор для заказной перевозки
procedure TForm16.BitBtn13Click(Sender: TObject);
var
  n:integer;
begin
  flchange:=true;
 tekkontr:='';
 If length(atp_sostav)=0 then
  begin
    tekkontr:='0';
  end;
 If length(atp_sostav)=1 then
  begin
    tekkontr:=atp_sostav[0,0];
  end;
 If length(atp_sostav)>1 then
  begin
    tekkontr:='';
     for n:=0 to length(atp_sostav)-2 do
      begin
          tekkontr:=tekkontr+atp_sostav[n,0]+',';
        end;
     tekkontr:=tekkontr+atp_sostav[n+1,0];
  end;
 If tekkontr='' then exit;
 result_dog:='';
  Form23:=TForm23.create(self);
  Form23.ShowModal;
  FreeAndNil(Form23);
  If result_dog<>'' then
   form16.Edit14.Text:=result_dog;
end;

procedure TForm16.BitBtn13Exit(Sender: TObject);
begin

end;


//************************ ПЕЧАТЬ ОТЧЕТА *************************************
procedure TForm16.BitBtn14Click(Sender: TObject);
begin
   FillRepArray();
 // Открыть на выбор для отчета
  if fl_print=1 then
   begin
     flchange := false;
     Close;
   end
  else
  begin
   BeginReport(Form16.ZConnection1, FOrm16.ZQuery1,6,0);
  end;
end;

procedure TForm16.BitBtn10Click(Sender: TObject);
var
  n : integer;
begin
 //ОТКРЫВАЕМ УСЛУГИ
  formUslugi:=TformUslugi.create(self);
  formUslugi.ShowModal;
  FreeAndNil(formUslugi);
 //обрабатываем выбор
 //проверка на совпадающие
  with Form16.Stringgrid11 do
  begin
  for n:=1 to RowCount-1 do
    begin
      If Cells[1,n]=result_id_uslugi then
      begin
       showmessagealt('Такая услуга уже есть в списке !');
       exit;
      end;
    end;
   if (result_id_uslugi = '') then exit;

    Columns[0].ValueChecked:='1';
    Columns[0].ValueUnchecked:='0';
    n := RowCount;
    RowCount:= RowCount + 1;
    Cells[0,n] := '1';
    Cells[1,n] := result_id_uslugi;
    Cells[2,n] := result_name_uslugi;
    Cells[3,n] := '0.00';
    Cells[4,n] := '0';
  end;
end;

procedure TForm16.BitBtn11Click(Sender: TObject);
var
  n : integer;
begin
 //ОТКРЫВАЕМ справочник льгот
  formLgot:=TformLgot.create(self);
  formLgot.ShowModal;
  FreeAndNil(formLgot);
 //обрабатываем выбор
  if (result_id_lgot = '') then exit;
 //проверка на совпадающие
  with Form16.Stringgrid12 do
  begin
  for n:=1 to RowCount-1 do
    begin
      If Cells[1,n]=result_id_lgot then
      begin
       showmessagealt('Такая льготная категория уже есть в списке !');
       exit;
      end;
    end;
    Columns[0].ValueChecked:='1';
    Columns[0].ValueUnchecked:='0';
    n := RowCount;
    RowCount:= RowCount + 1;
    Cells[0,n] := '1';
    Cells[1,n] := result_id_lgot;
    Cells[2,n] := result_name_lgot;
    Cells[4,n] := '0.00';
    Cells[5,n] := '0';
  end;
end;

//*************************************** УДАЛЕНИЕ АТП ИЗ СПИСКА *********************
procedure TForm16.BitBtn19Click(Sender: TObject);
var
  n,m:integer;
  kodatp : string='';
begin

 with Form16 do
 begin
  // Удаление перевозчика и АТС
  if StringGrid8.RowCount=1 then  exit;

  kodatp := trim(StringGrid8.Cells[0,StringGrid8.Row]);
  if kodatp='' then
       begin
         showmessagealt('Не выбрана запись для удаления !');
         exit;
       end;
  if dialogs.MessageDlg('При удалении перевозчика: '+trim(StringGrid8.Cells[1,StringGrid8.Row])+
     #13+'будут удалены также его тариф,'+#13+'календарный план выхода, услуги, льготы.'+#13' Продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;

{  if (trim(form16.edit18.Text)=trim(form16.StringGrid8.Cells[0,form16.StringGrid8.row])) then
       begin
         form16.Edit18.text:='';
         form16.Edit19.text:='';
      end;}
  SetLength(tmp_arr,0,ats_size);

  // Если был один перевозчик, то просто чистим все массивы
  if form16.StringGrid8.Rowcount=2 then
       begin
        SetLength(atp_sostav,0,0);
        SetLength(ats_sostav,0,0);
        SetLength(tarif_all,0,0);
        SetLength(lgoty_all,0,0);
        SetLength(uslugi_all,0,0);
{        form16.Edit18.text:='';
        form16.Edit19.text:='';}
        //exit;
       end;
   // Удаляем перевозчика из массива перевозчиков
     for n:=0 to length(atp_sostav)-1 do
       begin
        If not(trim(atp_sostav[n,0])=kodatp) then
          begin
            SetLength(tmp_arr,length(tmp_arr)+1,atp_size);
            for m:=0 to atp_size-1 do
              tmp_arr[length(tmp_arr)-1,m]:=atp_sostav[n,m];
          end;
        end;
      SetLength(atp_sostav,0, atp_size);
     for n:=0 to length(tmp_arr)-1 do
       begin
        SetLength(atp_sostav,length(atp_sostav)+1,atp_size);
         for m:=0 to atp_size-1 do
           begin
             atp_sostav[length(atp_sostav)-1,m]:=tmp_arr[n,m];
           end;
       end;
     //showmas(atp_sostav);
  // Удаляем перевозчика из массива АТC
  SetLength(tmp_arr,0,ats_size);
  for n:=0 to length(ats_sostav)-1 do
    begin
       if not(trim(ats_sostav[n,6])=kodatp) then
            begin
                SetLength(tmp_arr,length(tmp_arr)+1,ats_size);
                for m:=0 to ats_size-1 do
                  tmp_arr[length(tmp_arr)-1,m]:=ats_sostav[n,m];
            end;
     end;
  SetLength(ats_sostav,0, ats_size);
     for n:=0 to length(tmp_arr)-1 do
       begin
        SetLength(ats_sostav,length(ats_sostav)+1,ats_size);
         for m:=0 to ats_size-1 do
           begin
             ats_sostav[length(ats_sostav)-1,m]:=tmp_arr[n,m];
           end;
       end;
 //showmas(atp_sostav);
  flatp := true;

  Refresh_arrays(kodatp, true);    // удаляем из всех массивов этого перевозчика

   UpdateGridATP();
   UpdateGridATS();
    end;
end;


//****************************************** ВОЗНИКНОВЕНИЕ ФОРМЫ **********************************************************
procedure TForm16.FormShow(Sender: TObject);
begin
 decimalseparator:='.';
 copy_shed:='0';
 new_id:='0';
 norma_KMH:=110;
 norma_Deti:=110;
//try
//  raise EExternal.Create('Test');
//except
//   on EConvertError do showmessage('ошибочка вышла :)');
//   on EExternal do showmessage('!!!');
// else
//  showmessage('УПС..., ошибочка вышла :)');
//end;
 With Form16 do
 begin
    MasFree(); //очистка массивов
    Stringgrid6.RowHeights[1]:=0; //прячем строчку для всех

   schange:=true;
    //параметры доступа
     if flag_access<2 then Bitbtn5.Enabled:=false;
    SetLength(m_sostav,1,sostav_size);
    //Form16.getNorma(); //2022-02-02 убить datetarif

  // Открыть на выбор для отчета
  if fl_print=1 then
   begin
    //BitBtn14.Visible:= true;
    BitBtn1.Visible:= false;
    BitBtn5.Visible:= false;
    form16.fill_array(result_name_shedule);
    form16.perescet();
    form16.rascet();
    exit;
   end;

  form16.PageControl1.ActivePageIndex:=0;
  //form16.PageControl2.ActivePageIndex:=1;
  Form16.BitBtn1.SetFocus;

    past_id:='0'; //сбрасываем связку с действующим расписанием
     //сбрасываем флаги
    flchange:= false;
    flsostav := false;
    flatp := false;
    fltarif := false;
    flsezon :=false;
    fluslugi :=false;
    flblock :=false;
    //fl_to :=0;  //переход на вкладку опции
    flactiv :=false; //флаг создания будущего расписания


  // Новая запись
  if flag_edit_shedule=1 then
   begin
    form16.get_newid;//рассчитать новый код маршрута
    form16.DateEdit1.date:=now();
    form16.DateEdit2.date:=now()+365;
    form16.DateEdit3.date:=now();
    form16.PageControl1.Enabled:=false;
    FOrm16.CheckBox1.Checked := true;
    form16.perescet();
    flchange:= true;
    flsostav :=true;
    flatp :=true;
    fltarif :=true;
    flsezon :=true;
    fluslugi :=true;
    flblock :=true;
   end;

    // Новая запись + данные из текущей
  if flag_edit_shedule>=3 then
   begin
    form16.get_newid;//рассчитать новый код маршрута
    old_id := trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row]);
    form16.fill_array(old_id);
    form16.perescet();
    form16.rascet();
    form16.DateEdit1.date:=now();
    form16.DateEdit2.date:=now()+365;
    form16.DateEdit3.date:=now();
    //form16.perescet();
    flchange:= true;
    flsostav :=true;
    flatp :=true;
    fltarif :=true;
    flsezon :=true;
    fluslugi :=true;
    flblock :=true;

    //If flag_edit_shedule=4 then
     copy_shed:=old_id;//копировать данные по ручным тарифам
    old_id :='';
    past_id:='0'; //сбрасываем связку с действующим расписанием
    flag_edit_shedule:=1;
   end;


  // Редактируем запись
  if flag_edit_shedule=2 then
   begin
    old_id := trim(form15.StringGrid1.Cells[0,form15.StringGrid1.row]);
    form16.fill_array(old_id);
    form16.perescet();
    form16.rascet();
    activDay:=form16.DateEdit3.date;
    get_infoedit(old_id);
    //сбрасываем флаги
    flchange:= false;
    flsostav := false;
    flatp := false;
    fltarif := false;
    flsezon :=false;
    fluslugi :=false;
    flblock :=false;
   end;
 end;
end;


end.

