unit ticketShablon;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, ComCtrls, Spin, EditBtn, LazUtf8,
  StrUtils, ticket,
  {$IFDEF UNIX}
   FMemo, FMemo_Type,
  {$ENDIF}
  MouseAndKeyInput;

type

  { TformTT }

  TformTT = class(TForm)
    BitBtn10: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn6: TBitBtn;
    Button1: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    ImageList4: TImageList;
    Label1: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    PageControl1: TPageControl;
    Shape5: TShape;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    StaticText1: TStaticText;
    StatusBar1: TStatusBar;
    StringGrid2: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    //procedure Memo2Change(Sender: TObject);
    //procedure Memo2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure Memo2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton20Click(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure ToolButton24Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure UpdateFMemo(); //вывод грида шаблона
    procedure FillArray24(); //заполнение массивов опций
    procedure UpdateGrid2(); //обновить грид опций шаблона
    procedure UpdateCombo2();// обновить КОМБО С СЕРВЕРАМИ
    procedure Update2(); //обновить доп мемо
    procedure FMemoInsert(str:string); //вставить текст с мемо с сохранением форматирования
    procedure StrAlign(alin:string); //выравнивание строки в мемо
  private
    { private declarations }
  public
    { public declarations }
end;
var
  formTT: TformTT;

implementation
uses
  mainopp,platproc,ticketTypes;
{$R *.lfm}
var
  ar_lgot,ar_uslug, ar_common,ar_tarif,ar_personal : array of array of string;
  n,m : integer;
  fl_Change:boolean=false;
  fl_new : boolean= false;
  fl_dop_new : boolean=false;
  fl_dop_change : boolean=false;
  dop_id: string= '';

  pos:tpoint;

{ TformTT }

procedure TFOrmTT.FMemoInsert(str:string); //вставить текст с мемо с сохранением форматирования
var
  //{$IFDEF UNIX}
  //fp:TFontDesc;
  //{$ENDIF}
 ss,sl :integer;
 prefix: string='';
 stmp : string;
begin
  With FormTT do
  begin
  //если в текст шаблона
  If PageControl1.ActivePageIndex=0 then
    begin
    //{$IFDEF UNIX}
    Memo1.SetFocus;
    ss:=Memo1.SelStart;
    sl:=Memo1.CaretPos.x;
    //Memo1.GetFormat(fp);
    If trim(Memo1.SelText)='' then
     stmp := utf8copy(Memo1.Lines[Memo1.CaretPos.Y],1,sl)+str+Utf8copy(Memo1.Lines[Memo1.CaretPos.Y],sl+1,Utf8length(Memo1.Lines[Memo1.CaretPos.Y])-sl)
    else stmp := StringReplace(Memo1.Lines[Memo1.CaretPos.Y],Memo1.SelText,str, [rfReplaceAll, rfIgnoreCase]);
    Memo1.Lines.Delete(Memo1.CaretPos.Y);
    Memo1.Lines.Insert(Memo1.CaretPos.Y,stmp);
   //выделяем всю строку
   // Ставим в начало строки
   Memo1.SetFocus;
   pos.x:=0;
   sl:= Memo1.Lines.IndexOf(stmp);
   pos.y:=sl;
   Memo1.CaretPos:=pos;
   //восстанавливаем форматирование
   Memo1.SelLength := UTF8Length(Memo1.Lines[sl]);
   //fp.BackColor:=clWhite;
   //Memo1.SetFormat(fp, Memo1.SelStart, Memo1.SelLength);
   Memo1.SelLength:=0;
   Memo1.SelStart:=ss;
   //{$ENDIF}
   fl_change := true; //флаг внесения изменений
   end;

  //если в дополнительный текст шаблона
  If PageControl1.ActivePageIndex=1 then
    begin
    //{$IFDEF UNIX}
    Memo2.SetFocus;
    ss:=Memo2.SelStart;
    sl:=Memo2.CaretPos.x;
    //Memo2.GetFormat(fp);
    If trim(Memo2.SelText)='' then
     stmp := utf8copy(Memo2.Lines[Memo2.CaretPos.Y],1,sl)+str+Utf8copy(Memo2.Lines[Memo2.CaretPos.Y],sl+1,Utf8length(Memo2.Lines[Memo2.CaretPos.Y])-sl)
    else stmp := StringReplace(Memo2.Lines[Memo2.CaretPos.Y],Memo2.SelText,str, [rfReplaceAll, rfIgnoreCase]);
    Memo2.Lines.Delete(Memo2.CaretPos.Y);
    Memo2.Lines.Insert(Memo2.CaretPos.Y,stmp);
   //выделяем всю строку
   // Ставим в начало строки
   Memo2.SetFocus;
   pos.x:=0;
   sl:= Memo2.Lines.IndexOf(stmp);
   pos.y:=sl;
   Memo2.CaretPos:=pos;
   //восстанавливаем форматирование
   Memo2.SelLength := UTF8Length(Memo2.Lines[sl]);
   //fp.BackColor:=clWhite;
   //Memo2.SetFormat(fp, Memo2.SelStart, Memo2.SelLength);
   Memo2.SelLength:=0;
   Memo2.SelStart:=ss;
   //{$ENDIF}
   fl_dop_change := true; //флаг внесения изменений
   end;
end;

end;

//***************************************   обновить доп мемо  ***************************
procedure TFormTT.Update2();
begin
  fl_dop_new := false;
   With FormTT do
  begin
  //{$IFDEF UNIX}
    Memo2.Clear;
  //{$ENDIF}
    dop_id := Utf8copy(ComboBox2.Text,UTF8pos('--',ComboBox2.Text)+3,Utf8Length(ComboBox2.text));
    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      exit;
     end;
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT * FROM av_tick_addition AS a WHERE a.del=0 AND a.id_subject='+ dop_id +' ;');
  //Заполняем grid1 АРМ
  try
    ZQuery1.Open;
  except
    showmessagealt('Выполнение команды SQL Select - ОШИБКА !'+#13+'Команда: '+ ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;
 if ZQuery1.RecordCount>1 then
     begin
       showmessagealt('Найдено более одного доп шаблона для данного Сервера/Пользователя !');
     end;
 if ZQuery1.RecordCount=1 then
     begin
     //{$IFDEF UNIX}
       Memo2.Text:=ZQuery1.FieldByName('stext').AsString;
     //{$ENDIF}
       //dop_id := ZQuery1.FieldByName('id_subject').AsInteger;
       fl_dop_new:= true;
     end;

  ZQuery1.Close;
  Zconnection1.disconnect;
 end;
end;

//*************************************** //обновить КОМБО С СЕРВЕРАМИ ********************************************
procedure TFormTT.UpdateCombo2();
var
  n : integer;
begin
  With FormTT do
  begin
    combobox2.Clear;

    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      exit;
     end;
  ZQuery1.SQL.Clear;
  //Если доп текст и услуги Агентов
  if tusr=2 then
  begin
   Label5.Caption:= 'Пользователи-Агенты:';
   ZQuery1.SQL.add('SELECT a.id,a.name FROM av_users AS a WHERE a.del=0 AND a.category='+inttostr(tusr) +' ORDER BY a.name ASC;');
  end
  else
    // Если организация или перевозчик
   begin
      ZQuery1.SQL.add('SELECT a.id,b.name,a.active,a.activedate,a.usetarif,a.point_id,a.ip,a.ip2,a.info,a.base_name FROM av_servers AS a, av_spr_point AS b ');
      ZQuery1.SQL.add('WHERE a.del=0 AND b.del=0 AND a.point_id=b.id ORDER BY b.name;');
   end;

  //Заполняем grid1 АРМ
  try
    ZQuery1.Open;
  except
    showmessage('Выполнение команды SQL Select - ОШИБКА !'+#13+'Команда: '+ ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;
 if ZQuery1.RecordCount<1 then
     begin
       ZQuery1.close;
       ZConnection1.Disconnect;
       exit;
     end;

 // Заполняем combo
 for n:=1 to ZQuery1.RecordCount do
   begin
      combobox2.Items.Add(ZQuery1.FieldByName('name').asString+' -- ' + ZQuery1.FieldByName('point_id').asString);
      ZQuery1.Next;
     end;
   combobox2.ItemIndex:=-1;
  ZQuery1.Close;
  Zconnection1.disconnect;
 end;
end;


//************************************ Заполнить грид опций шаблона ********************
procedure TFormTT.UpdateGrid2();
begin
  FormTT.StringGrid2.RowCount := 1;
  with FormTT do
  begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   // Запрос общих переменных
    If ComboBox1.ItemIndex=0 then
    begin
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT * FROM av_tick_vars WHERE del=0 AND cat=0 order BY id;');
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
    end;
   If ZQuery1.RecordCount>0 then
   begin
   for n:=1 to ZQuery1.RecordCount do
    begin
      StringGrid2.RowCount:=StringGrid2.RowCount+1;
      StringGrid2.Cells[0,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('id').AsString;
      StringGrid2.Cells[1,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('label').AsString;
      //StringGrid2.Cells[2,StringGrid2.RowCount-1]:=
       ZQuery1.Next;
     end;
    end;
   end;

     // Запрос переменных персональных
    If ComboBox1.ItemIndex=1 then
    begin
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT * FROM av_tick_vars WHERE del=0 AND cat=1 ;');
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
    end;
   If ZQuery1.RecordCount>0 then
   begin
   for n:=1 to ZQuery1.RecordCount do
    begin
      StringGrid2.RowCount:=StringGrid2.RowCount+1;
      StringGrid2.Cells[0,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('id').AsString;
      StringGrid2.Cells[1,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('label').AsString;
      //StringGrid2.Cells[2,StringGrid2.RowCount-1]:=
       ZQuery1.Next;
     end;
    end;
   end;

  // Запрос услуг
    If ComboBox1.ItemIndex=2 then
    begin
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT * FROM av_spr_uslugi WHERE del=0 ORDER BY id ASC;');
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
    end;
   If ZQuery1.RecordCount>0 then
   begin
   for n:=1 to ZQuery1.RecordCount do
    begin
      StringGrid2.RowCount:=StringGrid2.RowCount+1;
      StringGrid2.Cells[0,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('id').AsString;
      StringGrid2.Cells[1,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('name').AsString;
      StringGrid2.Cells[2,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('sposob').AsString;
       ZQuery1.Next;
     end;
    end;
   end;

   // Запрос льгот
    If ComboBox1.ItemIndex=3 then
    begin
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT * FROM av_spr_lgot WHERE del=0 ORDER BY id ASC;');
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
    end;
   If ZQuery1.RecordCount>0 then
   begin
   for n:=1 to ZQuery1.RecordCount do
    begin
      StringGrid2.RowCount:=StringGrid2.RowCount+1;
      StringGrid2.Cells[0,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('id').AsString;
      StringGrid2.Cells[1,StringGrid2.RowCount-1]:=ZQuery1.FieldByName('name').AsString;
      //StringGrid2.Cells[2,StringGrid2.RowCount-1]:=
       ZQuery1.Next;
     end;
   end;
    end;
      ZQuery1.Close;
      Zconnection1.disconnect;
  end;
end;

//************************************ ЗАПОЛНЕНИЕ МАССИВОВ ОПЦИЙ *************************
procedure TFormTT.FillArray24();
begin
  SetLength(ar_common,28,2);
  //общее
  ar_common[1,0]:='Ведомость №';
  ar_common[1,1]:='ВДМСТ';
  ar_common[2,0]:='Остановочный пункт продажи';
  ar_common[2,1]:='ГРДБ';
  ar_common[3,0]:='Билет №';
  ar_common[3,1]:='БЛТ';
  ar_common[4,0]:='Рейс Наименование';
  ar_common[4,1]:='РС';
  ar_common[5,0]:='Рейс №';
  ar_common[5,1]:='РСН';
  ar_common[6,0]:='Остановочный пункт отправления';
  ar_common[6,1]:='ГРДОТ';
  ar_common[7,0]:='Остановочный пункт назначения';
  ar_common[7,1]:='ГРДПР';
  ar_common[8,0]:='Отправление ДАТА';
  ar_common[8,1]:='ДАТО';
  ar_common[9,0]:='Отправление ВРЕМЯ';
  ar_common[9,1]:='ВРМО';
  ar_common[10,0]:='Отправление Платформа №';
  ar_common[10,1]:='ПЛТФО';
  ar_common[11,0]:='Место №';
  ar_common[11,1]:='МСТ';
  ar_common[12,0]:='Прибытие ДАТА';
  ar_common[12,1]:='ДАТПР';
  ar_common[13,0]:='Прибытие ВРЕМЯ';
  ar_common[13,1]:='ВРМПР';
  ar_common[14,0]:='Прибытие Платформа №';
  ar_common[14,1]:='ПЛТФПР';
  ar_common[15,0]:='Кассир №';
  ar_common[15,1]:='КСРН';
  ar_common[16,0]:='Кассир ИМЯ';
  ar_common[16,1]:='КСР';
  ar_common[17,0]:='БИЛЕТ общая стоимость';
  ar_common[17,1]:='БОС';
  //ar_common[18,0]:='ЧЕК общая стоимость';
  //ar_common[18,1]:='ИТОГ';
  ar_common[19,0]:='ДОПОЛНИТЕЛЬНЫЕ УСЛУГИ';
  ar_common[19,1]:='ДОПУСЛ';
  ar_common[20,0]:='Билет Багажный №';
  ar_common[20,1]:='БГЖНОМ';
  //ar_common[21,0]:='Билет Багажный Количество';
  //ar_common[21,1]:='БГЖКОЛ';
  ar_common[21,0]:='Билет Багажный Цена';
  ar_common[21,1]:='БГЖЦЕН';
  ar_common[22,0]:='Билет Багажный Общая стоимость';
  ar_common[22,1]:='ББЖСУМ';
  ar_common[23,0]:='Билет Багажный Ценность объявленная';
  ar_common[23,1]:='БГЖЦО';
  ar_common[24,0]:='Билет Багажный Ценность Доплата';
  ar_common[24,1]:='БГЖДОП';
  ar_common[25,0]:='Перевозчик Наименование';
  ar_common[25,1]:='АТП';
  ar_common[26,0]:='Перевозчик Реквизиты';
  ar_common[26,1]:='АТПРЕК';

 //**** массив переменных персональных данных
  SetLength(ar_personal,11,2);
  ar_personal[0,0]:='Документ ТИП';
  ar_personal[0,1]:='ДОКТ';
  ar_personal[1,0]:='Документ Реквизиты';
  ar_personal[1,1]:='ДОКРЕК';
  ar_personal[2,0]:='ФИО пассажира';
  ar_personal[2,1]:='ФИО';
  ar_personal[3,0]:='ТЕЛЕФОН пассажира';
  ar_personal[3,1]:='ТЕЛ';
  ar_personal[4,0]:='Место Рождения';
  ar_personal[4,1]:='РОЖД';
  //ar_personal[5,0]:='Место Рождения ОБЛАСТЬ\КРАЙ';
  //ar_personal[5,1]:='МРОБЛ';
  //ar_personal[6,0]:='Место Рождения Населенный пункт';
  //ar_personal[6,1]:='МРНАС';
  //ar_personal[7,0]:='Дата Рождения';
  //ar_personal[7,1]:='ДРОЖ';
  ar_personal[8,0]:='МИНИСТЕРСТВО ОБОРОНЫ';
  ar_personal[8,1]:='МИНО';
  ar_personal[9,0]:='ПОГРАНИЧНИКИ';
  ar_personal[9,1]:='ПОГР';
  //ar_personal[2,0]:='ТИП БИЛЕТА (взрослый,детский,воинский,льготный)';
  //ar_personal[2,1]:='ТБИ';
  ar_personal[10,0]:='ВИД ВОИНСКОГО (отпуск,лечение\прочее)';
  ar_personal[10,1]:='ВВИ';

  SetLength(ar_tarif,9,2);
  //тариф
  ar_tarif[1,0]:='Тариф>Пригород.АТС М2.Мягкий';
  ar_tarif[1,1]:='ПМ2М';
  ar_tarif[2,0]:='Тариф>Пригород.АТС М2.Жесткий';
  ar_tarif[2,1]:='ПМ2Ж';
  ar_tarif[3,0]:='Тариф>Пригород.АТС М3.Мягкий';
  ar_tarif[3,1]:='ПМ3М';
  ar_tarif[4,0]:='Тариф>Пригород.АТС М3.Жесткий';
  ar_tarif[4,1]:='ПМ3Ж';
  ar_tarif[5,0]:='Тариф>Межгород.АТС М2.Мягкий';
  ar_tarif[5,1]:='ММ2М';
  ar_tarif[6,0]:='Тариф>Межгород.АТС М2.Жесткий';
  ar_tarif[6,1]:='ММ2Ж';
  ar_tarif[7,0]:='Тариф>Межгород.АТС М3.Мягкий';
  ar_tarif[7,1]:='ММ3М';
  ar_tarif[8,0]:='Тариф>Межгород.АТС М3.Жесткий';
  ar_tarif[8,1]:='ММ3Ж';

  //заполняем массивы услуг и льгот
  with FormTT do
  begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   // Запрос услуг
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT name,short_name FROM av_spr_uslugi WHERE del=0');
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
    end;
   If ZQuery1.RecordCount>0 then
   begin
   SetLength(ar_uslug,ZQuery1.RecordCount+1,3);
   for n:=0 to ZQuery1.RecordCount-1 do
    begin
     ar_uslug[n,0]:=ZQuery1.FieldByName('name').AsString;
     ar_uslug[n,1]:=ZQuery1.FieldByName('short_name').AsString;
     ZQuery1.Next;
    end;
   end;
   // Запрос льгот
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT name,short_name FROM av_spr_lgot WHERE del=0');
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
    end;
   If ZQuery1.RecordCount>0 then
   begin
   SetLength(ar_lgot,ZQuery1.RecordCount+1,3);
   for n:=0 to ZQuery1.RecordCount-1 do
    begin
     ar_lgot[n,0]:=ZQuery1.FieldByName('name').AsString;
     ar_lgot[n,1]:=ZQuery1.FieldByName('short_name').AsString;
     ZQuery1.Next;
    end;
   end;
end;
end;

procedure TformTT.ComboBox1Change(Sender: TObject);
begin
  UpdateGrid2();
end;

procedure TformTT.ComboBox2Change(Sender: TObject);
begin
  Update2();
end;

procedure TformTT.Memo1Change(Sender: TObject);
begin
  fl_change:=true;
end;

procedure TformTT.Memo1Click(Sender: TObject);
//var
  //fp:TFontDesc;
begin
  //formTT.Memo1.GetFormat(fp);
  //formTT.StatusBar1.Canvas.Clear;
  //formTT.StatusBar1.Canvas.Font.Size:=10;
  //formTT.StatusBar1.Canvas.TextOut(5,0,'Текущая позиция. Символ:'+inttostr(formTT.Memo1.CaretPos.x)+' Строка:'+inttostr(formTT.Memo1.CaretPos.Y)+' Шрифт='+inttostr(fp.Size));
end;

procedure TformTT.Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
//var
  //fp:TFontDesc;
begin
  //formTT.Memo1.GetFormat(fp);
  //formTT.StatusBar1.Canvas.Clear;
  //formTT.StatusBar1.Canvas.Font.Size:=10;
  //formTT.StatusBar1.Canvas.TextOut(5,0,'Текущая позиция. Символ:'+inttostr(formTT.Memo1.CaretPos.x)+' Строка:'+inttostr(formTT.Memo1.CaretPos.Y)+ ' Шрифт='+inttostr(fp.Size));
end;

procedure TformTT.Memo2Change(Sender: TObject);
begin
  fl_dop_change:=true;
end;

procedure TformTT.Memo2KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  fl_dop_change:=true;
end;


//*********************************************** ЗАКРЫТИЕ ФОРМЫ *******************************************************
procedure TformTT.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    If fl_change then
      begin
       If dialogs.MessageDlg('Сохранить внесенные изменения ?',mtConfirmation,[mbYes,mbNO], 0)=6 then formTT.BitBtn1.Click;
      end;
  //очистка памяти от массива
  SetLength(ar_lgot,0,0);
  ar_lgot := nil;
  //очистка памяти от массива
  SetLength(ar_uslug,0,0);
  ar_uslug := nil;
end;


//***********************************  ВЫВОД ШАБЛОНА ********************************
procedure TFormTT.UpdateFMemo();
var
  fl:boolean=false;
  slist:TStringlist;
  grp:string='';
  stmp: string='';
  //fp:TFontDesc;
begin
  slist :=Tstringlist.Create;
  with FormTT do
  begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   // Запрос на редактируюмую запись
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('SELECT * FROM av_tick_shablon WHERE id='+shablon_id+' AND del=0');
     //showmessage(ZQuery1.SQL.Text);//$
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
    end;
   If ZQuery1.RecordCount<1 then
     begin
     ZQuery1.Close;
      Zconnection1.disconnect;
      exit;
     end;
   If ZQuery1.RecordCount>1 then
     begin
      showmessagealt('Найдено более одного шаблона с данным ID !');
     ZQuery1.Close;
      Zconnection1.disconnect;
      exit;
     end;
   tusr:=0;
   ttype:=0;
   nkontr:=0;
   nshedule:=0;
   //принадлежность пользователя
   tusr := ZQuery1.FieldByName('usr_category').asInteger;
   ttype:=ZQuery1.FieldByName('type_sale').asInteger ;
   tname :=ZQuery1.FieldByName('name').asString;
   tcat := ZQuery1.FieldByName('category').asString;
   SpinEdit1.Value:=  ZQuery1.FieldByName('width_normal').asInteger;
   SpinEdit2.Value:=  ZQuery1.FieldByName('width_bold').asInteger;
   nkontr:= ZQuery1.FieldByName('id_kontr').asInteger;
   nshedule:= ZQuery1.FieldByName('id_shedule').asInteger;
   Memo1.Clear;
   //slist.Clear;
   slist.Text:=trim(ZQuery1.FieldByName('shablon').asString);
   Memo1.SetFocus;
  for n:=0 to slist.Count-1 do
   begin
    stmp := '';
     //Memo1.SetFocus;
     //Memo1.GetFormat(fp);
     //Ставим в начало строки
     //pos.x:=0;
     //pos.y:=n;
     //Memo1.CaretPos:=pos;

     ////разделитель
     //IF utf8pos('[f45]',Memo1.Lines[n])>0 then bold:=1;
     // begin
     // If bold=1 then BitBtn6.Click;
     // end;
     //
    //выравнивание слева
//     IF utf8pos('[fleft]',slist[n])>0 then fp.Justify:=fjLeft;
//     //выравнивание справа
//     IF utf8pos('[fright]',slist[n])>0 then fp.Justify:=fjRight;
//     //выравнивание по центру
//     IF utf8pos('[fcenter]',slist[n])>0 then fp.Justify:=fjCenter;
//  //шрифт № 6
//   IF utf8pos('[f6]',slist[n])>0 then
//     begin
//     fp.Size  :=11;
//     fp.Weight:=fwNormal;
//     fp.Style :=fpItalic;
//     end;
////шрифт № 1
//  IF utf8pos('[f1]',slist[n])>0 then
//  begin
//    fp.Size  :=12;
//    fp.Weight:=fwNormal;
//    fp.Style :=fpNormal;
//  end;
////шрифт № 4
// IF utf8pos('[f4]',slist[n])>0 then
//  begin
//    fp.Size  :=14;
//    fp.Weight:=fwBold;
//    fp.Style :=fpNormal;
//  end;
////шрифт № 2
//  IF utf8pos('[f2]',slist[n])>0 then
//begin
//  fp.Size  :=16;
//  fp.Weight:=fwBold;
//  fp.Style :=fpNormal;
//end;
////шрифт № 5
// IF utf8pos('[f5]',slist[n])>0 then
//begin
//  fp.Size  :=8;
//  fp.Weight:=fwNormal;
//  fp.Style :=fpNormal;
//end;
//  //шрифт № 3
// IF utf8pos('[f3]',slist[n])>0 then
// begin
//    fp.Size  :=10;
//    fp.Weight:=fwNormal;
//    fp.Style :=fpNormal;
//  end;
//
//  fp.BackColor:=clWhite;
//  fp.FontColor:=clBlack;
  stmp := slist[n];
 //If n>20 then showmessage(stmp);
  //убираем переменные из текста
     stmp := StringReplace(stmp,'[f1]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[f2]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[f3]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[f4]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[f5]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[f6]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[fbold]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[fleft]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[fcenter]','',[rfReplaceAll, rfIgnoreCase]);
     stmp := StringReplace(stmp,'[fright]','',[rfReplaceAll, rfIgnoreCase]);
  //Memo1.Lines.Delete(Memo1.CaretPos.Y);
  Memo1.Lines.add(stmp);
  pos.x:=0;
  pos.y:=Memo1.Lines.IndexOf(stmp);
  Memo1.CaretPos:=pos;
  //Memo1.SetFormat(fp,Memo1.SelStart-Memo1.CaretPos.X,UTF8Length(Memo1.Lines[Memo1.CaretPos.Y]));
  end;

   ZQuery1.Close;
   Zconnection1.disconnect;
   fl_change:=false;
  end;
end;


procedure TformTT.BitBtn2Click(Sender: TObject);
begin
  formTT.close;
end;

//********************** Добавить опцию в Шаблон *******************************************
procedure TformTT.BitBtn3Click(Sender: TObject);
var
 ss,sl :integer;
 prefix: string='';
 stmp,str : string;
begin
  With FormTT do
  begin
  If trim(StringGrid2.Cells[1,StringGrid2.row])='' then exit;
  //определяем префикс по типу переменной
  case ComboBox1.ItemIndex of
  0: prefix:='c';
  1: prefix:='c';
  2: prefix:='u';
  3: prefix:='l';
  end;
  //добавляемая переменную
  stmp := '['+prefix+trim(StringGrid2.Cells[0,StringGrid2.row])+']';
  FMemoINsert(stmp);
  end;
end;

//******************* СДВИНУТЬ СТРОЧКУ ШАБЛОНА ВВЕРХ  ****************************************
procedure TformTT.BitBtn4Click(Sender: TObject);
var
 position1:TPoint;
 //fp:TFontDesc;
begin
  With FormTT do
  begin
  //если в текст шаблона
  If PageControl1.ActivePageIndex=0 then
  begin
    Memo1.SetFocus;
    //Memo1.GetFormat(fp);
  // Если нет пунктов или первый то ничего не делаем
  if (Memo1.Lines.Count<2) or (Memo1.CaretPos.Y=0) then exit;
  //сохранить новую позицию курсора
  position1.x:=Memo1.CaretPos.x;
  position1.y:=Memo1.CaretPos.y-1;
  //Меняем местами строчки грида
  Memo1.Lines.Exchange(Memo1.CaretPos.Y,Memo1.CaretPos.Y-1);
  Memo1.CaretPos := position1;
  //восстанавливаем форматирование
  //Memo1.SetFormat(fp,Memo1.SelStart-Memo1.CaretPos.X,UTF8Length(Memo1.Lines[Memo1.CaretPos.Y]));
  fl_change := true; //флаг внесения изменений
  end;

  // Если Доп. текст
    If PageControl1.ActivePageIndex=1 then
  begin
    Memo2.SetFocus;
    //Memo2.GetFormat(fp);
  // Если нет пунктов или первый то ничего не делаем
  if (Memo2.Lines.Count<2) or (Memo2.CaretPos.Y=0) then exit;
  //сохранить новую позицию курсора
  position1.x:=Memo2.CaretPos.x;
  position1.y:=Memo2.CaretPos.y-1;
  //Меняем местами строчки грида
  Memo2.Lines.Exchange(Memo2.CaretPos.Y,Memo2.CaretPos.Y-1);
  Memo2.CaretPos := position1;
  //восстанавливаем форматирование
  //Memo2.SetFormat(fp,Memo2.SelStart-Memo2.CaretPos.X,UTF8Length(Memo2.Lines[Memo2.CaretPos.Y]));
  fl_dop_change := true; //флаг внесения изменений
  end;
  end;
end;

//******************* СДВИНУТЬ СТРОЧКУ ШАБЛОНА ВНИЗ  ****************************************
procedure TformTT.BitBtn5Click(Sender: TObject);
var
 position2:TPoint;
 //fp:TFontDesc;
begin
  With FormTT do
  begin
  //если в текст шаблона
  If PageControl1.ActivePageIndex=0 then
  begin
    Memo1.SetFocus;
    //Memo1.GetFormat(fp);
   // Если нет пунктов или первый то ничего не делаем
    if (Memo1.Lines.Count<2) or (Memo1.CaretPos.Y=Memo1.Lines.Count-1) then exit;
    //сохранить новую позицию курсора
    position2.x:=Memo1.CaretPos.x;
    position2.y:=Memo1.CaretPos.y+1;
    //Меняем местами строчки грида
    Memo1.Lines.Exchange(Memo1.CaretPos.Y,Memo1.CaretPos.Y+1);
    Memo1.CaretPos := position2;
    //восстанавливаем форматирование
    //Memo1.SetFormat(fp,Memo1.SelStart-Memo1.CaretPos.X,UTF8Length(Memo1.Lines[Memo1.CaretPos.Y]));
    fl_change := true; //флаг внесения изменений
    end;
  //если Доп текст
  If PageControl1.ActivePageIndex=1 then
  begin
    Memo2.SetFocus;
    //Memo2.GetFormat(fp);
   // Если нет пунктов или первый то ничего не делаем
    if (Memo2.Lines.Count<2) or (Memo2.CaretPos.Y=Memo2.Lines.Count-1) then exit;
    //сохранить новую позицию курсора
    position2.x:=Memo2.CaretPos.x;
    position2.y:=Memo2.CaretPos.y+1;
    //Меняем местами строчки грида
    Memo2.Lines.Exchange(Memo2.CaretPos.Y,Memo2.CaretPos.Y+1);
    Memo2.CaretPos := position2;
    //восстанавливаем форматирование
    //Memo2.SetFormat(fp,Memo2.SelStart-Memo2.CaretPos.X,UTF8Length(Memo2.Lines[Memo2.CaretPos.Y]));
    fl_dop_change := true; //флаг внесения изменений
    end;
  end;
end;

//**************************** СОХРАНИТЬ КАК НОВЫЙ ШАБЛОН  ********************************
procedure TformTT.BitBtn10Click(Sender: TObject);
//var
 //sm1:string;
 //m,k:integer;
begin
  //IF fl_edit_TT=1 then exit;
  //sm1:= InputBox('Создание нового шаблона', 'Введите наименование нового шаблона билета...','');
  //IF EMPTYSTR=sm1 then exit;
  //FormTT.ComboBox3.Text:=sm1;

  flname := false; //флаг корректной работы формы с наименованием шаблона
  FormAdd := TFormAdd.create(self);
  FormAdd.ShowModal;
  FreeAndNil(FormAdd);
  If not flname then exit;
  fl_new:= true;
  fl_change := true; //флаг внесения изменений
  FormTT.BitBtn1.Click;
end;


//*********************  СОХРАНИТЬ ******************************************************
procedure TformTT.BitBtn1Click(Sender: TObject);
var
   endflag:boolean=false;
   stmp,usl :string;
   i : integer;
   //fp:TFontDesc;
begin
  With FormTT do
  begin
  //Сохраняем шаблон
   If PageControl1.ActivePageIndex=0 then
   begin
    If not fl_change then
    begin
     showmessagealt('Сначала измените что-нибудь !');
     exit;
    end;

  // Проверяем на соответствие введенным данным
  if (trim(Edit1.text)='') AND (fl_edit_TT=2) then
      begin
      showmessagealt('Поле ID пустое !'+#13+'Сохранение невозможно !');
      exit;
      end;

  If trim(Memo1.Lines.Text)='' then
    begin
     showmessagealt('Сохранение невозможно !'+#13+'Текст шаблона пустой !');
    exit;
    end;

  //ищем конец шаблона чека
   for n:=0 to Memo1.Lines.Count-1 do
   begin
    stmp := trim(Memo1.Lines[n]);
    If utf8pos('&',stmp)>0 then
    begin
    endflag:=true;
    break;//конец шаблона
    end;
   end;
   If not endflag then
   begin
     If dialogs.MessageDlg('Не найден конец шаблона !'+#13+'Добавить автоматически ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;
     Button1.Click;
   end;
  //if (StringGrid1.RowCount<2) then
  //    begin
  //    showmessagealt('В шаблоне билета нет ни одной строки !'+#13+'Сохранение невозможно !');
  //    exit;
  //    end;
  //Если не было изменений - выход
  //If not fl_change then exit;
  If (fl_edit_TT=2) AND fl_new then
  If dialogs.MessageDlg('Будет создан новый шаблон !'+#13+' Продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;

   // Подключаемся к серверу
   If Connect2(Zconnection1, flagProfile)=false then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

   If (Fl_Edit_TT=1) or (fl_new) then
  begin
 //Проверка на дубликат
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT id FROM av_tick_shablon WHERE del=0 AND name='+QuotedStr(tname)+' AND category='+QuotedStr(tcat)+' AND type_sale='+inttostr(ttype)+' AND usr_category='+inttostr(tusr)+';');
  //showmessage('1 '+ZQuery1.SQL.Text);//$
  try
  ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      Zconnection1.disconnect;
      ZQuery1.Close;
      exit;
  end;
  If ZQuery1.RecordCount>0 then
  begin
     showmessagealt('Сохранение невозможно ! Такой шаблон уже существует !');
      Zconnection1.disconnect;
      ZQuery1.Close;
      exit;
  end;
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
 If (Fl_Edit_TT=1) or (fl_new) then
 begin
  //Определяем текущий id+1
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_tick_shablon;');
  ZQuery1.open;
  shablon_id:= inttostr(ZQuery1.FieldByName('new_id').asInteger+1);
 end;

  //Маркируем запись на удаление если режим редактирования
  if (Fl_Edit_TT=2) then
      begin
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('UPDATE av_tick_shablon SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+shablon_id+' and del=0;');
      ZQuery1.open;
      end;

  //добавляем заглавную запись ШАБЛОНА
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_tick_shablon(id,name,category,type_sale,usr_category,createdate_first,id_user_first,createdate,id_user,del,shablon,id_kontr,id_shedule,width_normal,width_bold) VALUES (');
  ZQuery1.SQL.add(shablon_id+','+QuotedStr(tname)+','+QuotedStr(tcat)+','+inttostr(ttype)+','+inttostr(tusr));
  //режим добавления
  if (Fl_Edit_TT=1) or (fl_new) then
    ZQuery1.SQL.add(',now(),'+inttostr(id_user)+',now(),'+inttostr(id_user)+',0,''');
  //режим редактирования
  if (Fl_Edit_TT=2) and (not fl_new) then
    ZQuery1.SQL.add(',null,null,now(),'+inttostr(id_user)+',0,''');

  //svars:='';//сброс строки переменных-услуг
  //разбор форматирования и поиск конца чека
  // Ставим каретку в начало
   Memo1.SetFocus;
  for n:=0 to Memo1.Lines.Count-1 do
   begin
    // Ставим в середину строки
     pos.x:=Utf8length(Memo1.Lines[n]) div 2;
     pos.y:=n;
     Memo1.CaretPos:=pos;
     //Memo1.GetFormat(fp);
     stmp:='';
     //пишем размер шрифта
    //case fp.size of
      //8:
      stmp := '[f5]'+trimleft(Memo1.Lines[n]);
     //10: stmp := '[f3]'+trimleft(Memo1.Lines[n]);
     //11: stmp := '[f6]'+trimleft(Memo1.Lines[n]);
     //12: stmp := '[f1]'+trimleft(Memo1.Lines[n]);
     //14: stmp := '[f4]'+trimleft(Memo1.Lines[n]);
     //16: stmp := '[f2]'+trimleft(Memo1.Lines[n]);
    //end;
    //выравнивание
    //case fp.Justify of
    //fjLeft :
    //stmp := '[fleft]'+stmp;
    //fjCenter : stmp := '[fcenter]'+stmp;
    //fjRight :  stmp := '[fright]'+stmp;
    //end;
    If utf8pos('&',stmp)>0 then
    begin
    ZQuery1.SQL.add(stmp);
    break;//конец шаблона
    end;

    ZQuery1.SQL.add(stmp);
   end;
  //showmessage(svars);
  ZQuery1.SQL.add(''','+inttostr(nkontr)+','+inttostr(nshedule)+','+SpinEdit1.Text+','+SpinEdit2.Text+');');
  //showmessage(Zquery1.SQL.Text);//$
  ZQuery1.open;

  // Завершение транзакции
  Zconnection1.Commit;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     Zconnection1.disconnect;
     ZQuery1.Close;
 end;
  Zconnection1.disconnect;
  ZQuery1.Close;
  fl_change:=false;
  fl_new:= false;
  end;

  If PageControl1.ActivePageIndex=1 then
  begin
  If not fl_dop_change then
    begin
     showmessagealt('Сначала измените что-нибудь !');
     exit;
    end;
   //************ если есть доп текст ****************
  If (trim(Combobox2.text)='') AND  (trim(Memo2.Text)='') then exit;
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
  IF fl_dop_new then
  begin
   //Маркируем запись на удаление если она уже есть
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('UPDATE av_tick_addition SET del=1, createdate=now(),id_user='+inttostr(id_user)+' WHERE id_subject='+dop_id+' and del=0;');
      ZQuery1.open;
   end;
  //добавляем запись
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_tick_addition(id_subject,stext,id_user,createdate,del) VALUES (');
  ZQuery1.SQL.add(dop_id+','+QuotedStr(Memo2.Text)+','+inttostr(id_user)+',now(),0);');
  ZQuery1.open;

  // Завершение транзакции
  Zconnection1.Commit;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     Zconnection1.disconnect;
     ZQuery1.Close;
 end;
  Zconnection1.disconnect;
  ZQuery1.Close;
  fl_dop_new:=false;
  fl_dop_change:=false;
  end;

  FormTT.Close;
 end;
end;

procedure TformTT.BitBtn6Click(Sender: TObject);
var
   stmp : string;
begin
  with formTT do
  begin
  stmp := '[x'+edit2.Text+']';
   FMemoInsert(stmp);
  end;
end;

procedure TformTT.BitBtn7Click(Sender: TObject);
begin
  FormAdd:=TFormAdd.create(self);
  FormAdd.ShowModal;
  FreeAndNil(FormAdd);
end;

//******************************* конец чека ***********************************
procedure TformTT.Button1Click(Sender: TObject);
begin
  FormTT.Memo1.Append('&Конец чека');
end;

procedure TformTT.Button2Click(Sender: TObject);
var
 pos:tpoint;
 n:integer;
 dl:integer;
 s:string;
 //fp:TFontDesc;
begin
  with formTT do
  begin
  // Ставим в начало
  pos.x:=0;
  pos.y:=1;
  Memo1.SetFocus;
  Memo1.CaretPos:=pos;
  // Определяем длину строки
  Memo1.SetFocus;
  KeyInput.Press(35);
  dl:=Memo1.CaretPos.x;
  //Showmessagealt('Длина = '+inttostr(dl);
  // Ставим в начало
  pos.x:=0;
  pos.y:=1;
  Memo1.SetFocus;
  Memo1.CaretPos:=pos;
  // Цикл по длине строки
  s:='Длина = '+inttostr(dl)+#13;
  for n:=0 to dl-1 do
    begin
         pos.x:=n;
         pos.y:=1;
         Memo1.SetFocus;
         Memo1.SelLength:=0;
         Memo1.SetFocus;
         Memo1.CaretPos:=pos;
         Memo1.SetFocus;
         Memo1.SelLength:=0;
         // Берем атрибуты
         Memo1.SetFocus;
         //Memo1.GetFormat(fp);
         //s:=s+'X:='+inttostr(n)+' Caret X='+inttostr(Memo1.CaretPos.x)+' len_select='+inttostr(Memo1.SelLength)+' fp.name='+fp.name+' text='+Memo1.SelText+#13;
    end;
  Memo1.SetFocus;

  end;
  //showmessagealt(s);
end;


 //**********************************  HOT KEYS  ********************************************************
procedure TformTT.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  with FormTT do
  begin
     // F1
    //if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F7] - Поиск'+#13+'[F8] - Удалить'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F7] - Поиск'+#13+'[F8] - Удалить'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    //F2 - Сохранить
    if (Key=113) and (formTT.bitbtn1.enabled=true) then formTT.bitbtn1.click;
    //F4 - Изменить
  //  if (Key=115) (formTT.bitbtn12.enabled=true) then formTT.BitBtn12.Click;
    //F5 - Добавить
 //   if (Key=116) and (formTT.bitbtn2.enabled=true) then formTT.BitBtn2.Click;
    //F8 - Удалить
 //   if (Key=119) and (formTT.bitbtn3.enabled=true) then formTT.BitBtn3.Click;
    // ESC
    if Key=27 then formTT.Close;
    // ENTER на гриде шаблона
    //if (Key=13) AND (StringGrid1.Row=(StringGrid1.RowCount-1)) then
    //  begin
    //    //Если это последняя строчка, то добавить строчку
    //    IF StringGrid1.RowCount=(StringGrid1.Row+1) then
    //      begin
    //      StringGrid1.RowCount:=StringGrid1.RowCount+1;
    //      StringGrid1.Cells[0,StringGrid1.RowCount-1]:=intTOstr(StringGrid1.RowCount-1);
    //      Stringgrid1.Col:=1;
    //      StringGrid1.Row:=StringGrid1.RowCount;
    //      StringGrid1.SetFocus;
    //      fl_change := true; //флаг внесения изменений
    //      end;
    //  end;
     if (Key=112) or (Key=113) or (Key=115) or (Key=116) or (Key=119) or (Key=27) then Key:=0;
  end;
end;


//*********************   ВОЗНИКНОВЕНИЕ ФОРМЫ  *************************************************
procedure TformTT.FormShow(Sender: TObject);
begin
  with FormTT do
  begin
  PageControl1.ActivePageIndex:=0;
  //инициализация массивов опций
  //FillArray24();
  //сбрасываем флаг СОХРАНИТЬ КАК
  fl_new := false;
  //StringGrid1.RowHeights[0]:=0;
  //заполнить грид опций шаблона
  UpdateGrid2();
  //обновить поле доп текста
  //Update2();

  // Редактируем запись
  if Fl_Edit_TT=2 then
   begin
   Edit1.Text := shablon_id;
   //заполняем FMemo шаблона
   UpdateFMemo();
   end;
   // Заполняем COMBO5 услугами (по умолчанию)
   //for n:=0 to length(ar_uslug)-1 do
   //   begin
   //     combobox5.Items.Add(ar_uslug[n,0]);
   //   end;
   //combobox5.text:=ar_uslug[1,0];

 UpdateCombo2(); //обновить КОМБО С СЕРВЕРАМИ/Пользователями

  Label2.Caption := '';
  case tusr of
  0: Label2.Caption:='ОРГАНИЗАЦИЯ ';
  1: Label2.Caption:='ПЕРЕВОЗЧИК ';
  2: Label2.Caption:='АГЕНТ ';
  end;
  IF ttype=1 then Label2.Caption:= Label2.Caption +'/ ПРОДАЖА ';
  IF ttype=2 then Label2.Caption:= Label2.Caption +'/ ВОЗВРАТ ';
  Label2.Caption := Label2.Caption + IFTHEN(trim(tname)='','','/ '+tname) + IFTHEN(trim(tcat)='','',' / ' + tcat) ;

  //Если доп текст и услуги Агентов
  if tusr=2 then
  begin
    PageControl1.ActivePageIndex:=1;
    PageControl1.Pages[0].Visible:=false;
    PageControl1.Pages[0].Enabled:=false;
  end
  else
    // Если организация или перевозчик
   begin
    PageControl1.ActivePageIndex:=0;
   end;

  end;
end;

//СДВИНУТЬ СТРОЧКУ ВВЕРХ
procedure TformTT.ToolButton10Click(Sender: TObject);
begin
  formTT.BitBtn4.Click;
end;

//СДВИНУТЬ СТРОЧКУ ВНИЗ
procedure TformTT.ToolButton12Click(Sender: TObject);
begin
  formTT.BitBtn5.Click;
end;

//*********************************************************************************************************
//*************************************** ФОРМАТИРОВАНИЕ МЕМО 2 ******************************************
//*********************************************************************************************************
procedure TformTT.ToolButton13Click(Sender: TObject);
begin
 formTT.ToolButton1.Click;
end;

procedure TformTT.ToolButton16Click(Sender: TObject);
begin
   // Делаем выравнивание СЛЕВА
  StrAlign('left');
end;

procedure TformTT.ToolButton18Click(Sender: TObject);
begin
// Делаем выравнивание ПО ЦЕНТРУ
 StrAlign('center');
end;

procedure TformTT.ToolButton20Click(Sender: TObject);
begin
  // Делаем выравнивание СПРАВА
  StrAlign('right');
end;

//ВВЕРХ СТРОЧКУ
procedure TformTT.ToolButton22Click(Sender: TObject);
begin
  formTT.BitBtn4.click;
end;

//********************* СТРОЧКУ ВНИЗ
procedure TformTT.ToolButton24Click(Sender: TObject);
begin
  formTT.BitBtn5.Click;
end;


//*********************************************************************************************************
//*************************************** ФОРМАТИРОВАНИЕ МЕМО ******************************************
//*********************************************************************************************************
procedure TFormTT.StrAlign(alin:string);
//var
 //fp:TFontDesc;
begin
    With FOrmTT do
  begin

    //если в текст шаблона
 // If PageControl1.ActivePageIndex=0 then
 // begin
 //// Ставим в начало
 //   //pos.x:=0;
 //   //pos.y:=Memo1.CaretPos.Y;
 //   Memo1.SetFocus;
 //   //Memo1.CaretPos:=pos;
 //   //Memo1.SelStart := Memo1.SelStart-Memo1.CaretPos.X;
 //  //выделяем всю строку
 //  //Memo1.SelLength := UTF8Length(Memo1.Lines[Memo1.CaretPos.Y]);
 //    Memo1.GetFormat(fp);
 // end;
 //    //если в текст шаблона
 // If PageControl1.ActivePageIndex=1 then
 // begin
 //   Memo2.SetFocus;
 //   //Memo2.GetFormat(fp);
 // end;
 //
 // //case alin of
 // //   'left': fp.Justify:=fjLeft;
 // //   'right': fp.Justify:=fjRight;
 // //   'center': fp.Justify:=fjCenter;
 // //end;
 // //
 // //   fp.BackColor:=clWhite;
 // //   fp.FontColor:=clBlack;
 //
 ////если в текст шаблона
 // If PageControl1.ActivePageIndex=0 then
 // begin
 //    //Memo1.SetFormat(fp,Memo1.SelStart,Memo1.SelLength);
 //    Memo1.SetFormat(fp,Memo1.SelStart-Memo1.CaretPos.X,UTF8Length(Memo1.Lines[Memo1.CaretPos.Y]));
 //    Memo1.SelLength:=0;
 //    fl_change := true; //флаг внесения изменений
 // end;
 //  //если в текст шаблона
 // If PageControl1.ActivePageIndex=1 then
 // begin
 //    //Memo2.SetFormat(fp,Memo2.SelStart-Memo2.CaretPos.X,UTF8Length(Memo2.Lines[Memo2.CaretPos.Y]));
 //    Memo2.SelLength:=0;
 //    fl_dop_change := true; //флаг внесения изменений
 // end;
  end;
end;

//**************** меняем шрифт ******************************************
procedure TformTT.ToolButton1Click(Sender: TObject);
var
lffind :boolean=true;
//fp:TFontDesc;
begin
  // Меняем размер шрифта
  With FOrmTT do
  begin
     //если в текст шаблона
//  If PageControl1.ActivePageIndex=0 then
//  begin
//  Memo1.SetFocus;
//  Memo1.GetFormat(fp);
//  end;
//     //если в доп текст
//  If PageControl1.ActivePageIndex=1 then
//  begin
//  Memo2.SetFocus;
//  //Memo2.GetFormat(fp);
//  end;
//  // Ставим в начало
//     //pos.x:=0;
//     //pos.y:=Memo1.CaretPos.Y;
//
//     //Memo1.CaretPos:=pos;
//     //Memo1.SelStart := Memo1.SelStart-Memo1.CaretPos.X;
//    //выделяем всю строку
//    //Memo1.SelLength := UTF8Length(Memo1.Lines[Memo1.CaretPos.Y]);
//    If PageControl1.ActivePageIndex=0 then
//  begin
////шрифт № 6
//if lffind and (fp.Size=10) then
//begin
//  fp.Size  :=11;
//  fp.Weight:=fwNormal;
//  fp.Style :=fpItalic;
//  lffind := false;
//end;
////шрифт № 1
//  if lffind and (fp.Size=11) then
//  begin
//    fp.Size  :=12;
//    fp.Weight:=fwNormal;
//    fp.Style :=fpNormal;
//    lffind := false;
//  end;
////шрифт № 4
//  if lffind and (fp.Size=12) then
//  begin
//    fp.Size  :=14;
//    fp.Weight:=fwBold;
//    fp.Style :=fpNormal;
//      lffind := false;
//  end;
////шрифт № 2
//  if lffind and (fp.Size=14) then
//begin
//  fp.Size  :=16;
//  fp.Weight:=fwBold;
//  fp.Style :=fpNormal;
//    lffind := false;
//end;
////шрифт № 5
//  if lffind and (fp.Size=16) then
//begin
//  fp.Size  :=8;
//  fp.Weight:=fwNormal;
//  fp.Style :=fpNormal;
//    lffind := false;
//end;
//  //шрифт № 3
//  if lffind and (fp.Size=8) then
// begin
//    fp.Size  :=10;
//    fp.Weight:=fwNormal;
//    fp.Style :=fpNormal;
//    lffind := false;
//  end;
//  fp.BackColor:=clWhite;
//  fp.FontColor:=clBlack;
//
// //если в текст шаблона
//  //If PageControl1.ActivePageIndex=0 then
//  //begin
//  Memo1.SetFormat(fp, Memo1.SelStart-Memo1.CaretPos.X,UTF8Length(Memo1.Lines[Memo1.CaretPos.Y]));
//  Memo1.SelLength:=0;
//  fl_change := true; //флаг внесения изменений
//  end;
//  //если в текст шаблона
//  If PageControl1.ActivePageIndex=1 then
//  begin
//  //Memo2.SetFormat(fp, Memo2.SelStart-Memo2.CaretPos.X,UTF8Length(Memo2.Lines[Memo2.CaretPos.Y]));
//  Memo2.SelLength:=0;
//  fl_dop_change := true; //флаг внесения изменений
//  end;
//
//// Ставим в конец
//   //pos.x:=UTF8Length(Memo1.Lines[Memo1.CaretPos.Y])-1;
//   //pos.y:=Memo1.CaretPos.Y;
//   //Memo1.CaretPos:=pos;
 end;
end;


procedure TformTT.ToolButton4Click(Sender: TObject);
begin
  // Делаем выравнивание СЛЕВА
  StrAlign('left');
end;

procedure TformTT.ToolButton6Click(Sender: TObject);
begin
  // Делаем выравнивание ПО ЦЕНТРУ
  StrAlign('center');
end;

procedure TformTT.ToolButton8Click(Sender: TObject);
begin
    // Делаем выравнивание СПРАВА
  StrAlign('right');
end;



end.

