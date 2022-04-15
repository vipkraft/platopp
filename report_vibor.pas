unit report_vibor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, DateTimePicker, FileUtil, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, Spin, EditBtn,
  Grids, Platproc;

type

  { TFormRepV }

  TFormRepV = class(TForm)
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckGroup2: TCheckGroup;
    CheckGroup3: TCheckGroup;
    CheckGroup4: TCheckGroup;
    ComboBox2: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
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
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    SpinEdit1: TSpinEdit;
    SpinEdit10: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    SpinEdit8: TSpinEdit;
    SpinEdit9: TSpinEdit;
    StaticText1: TStaticText;
    StringGrid6: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure fillotd; // Список отделений
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormRepV: TFormRepV;

implementation
uses
  mainopp,report_main,shedule_main,route_main,kontr_main,shedule_grafik,htmldoc,uslugi_main,lgot_main,users_main;

{$R *.lfm}

{ TFormRepV }

// Список отделений
procedure tformRepV.fillotd;
 var
   n:integer;
begin
  with FOrmRepV do
  begin
  ComboBox2.Clear;
   // -------------------- Соединяемся с локальным сервером ----------------------
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
       showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
       exit;
     end;
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT * FROM av_1c_otd_podr a ');
   ZQuery1.SQL.add('WHERE kodpodr!=0 AND kodotd>1200 ORDER BY a.name ASC; ');
   try
       ZQuery1.open;
   except
       showmessagealt('Нет соединения с сервером !!!'+#13+'Обратитесь к администратору или попробуйте снова !!!');
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
   end;

   // Если нет отделений
   if ZQuery1.RecordCount=0 then
      begin
        showmessagealt('Нет доступных отделений !!!');
        ComboBox2.Clear;
        ZQuery1.Close;
        Zconnection1.disconnect;
        exit;
      end;
   // Заполняем Combo2
   for n:=0 to ZQuery1.RecordCount-1 do
      begin
        ComboBox2.Items.Add(trim(ZQuery1.FieldByName('name').asString)+' | '+trim(ZQuery1.FieldByName('kodpodr').asString));
        ZQuery1.Next;
      end;
   // Закрываем соединение
   ZQuery1.Close;
   Zconnection1.disconnect;
  end;
end;



procedure TFormRepV.BitBtn4Click(Sender: TObject);
begin
  FormRepV.Close;
end;

//***************************** ГОТОВО **********************************************
procedure TFormRepV.BitBtn5Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
  With FormRepV do
  begin
    //заполняем доступные значения в массив переменных отчета (таблица report_vars)
     for i:=Low(ar_report) to High(ar_report) do
                begin
                  If lowercase(trim(ar_report[i,0])) = 'dates' then ar_report[i,2]:= DateEdit1.Text;
                  If lowercase(trim(ar_report[i,0])) = 'datepo' then ar_report[i,2]:= DateEdit2.Text;
                  If lowercase(trim(ar_report[i,0])) = 'times' then ar_report[i,2]:= padl(inttostr(SpinEdit5.Value),'0',2)+':'+padl(inttostr(SpinEdit6.Value),'0',2);
                  If lowercase(trim(ar_report[i,0])) = 'timepo' then ar_report[i,2]:= padl(inttostr(SpinEdit7.Value),'0',2)+':'+padl(inttostr(SpinEdit8.Value),'0',2);

                  //If lowercase(trim(ar_report[i,0])) = 'mar_kod' then ar_report[i,2]:= Edit3.Text;
                  //If trim(ar_report[i,0]) = 'mar_name' then ar_report[i,2]:= Edit2.Text;
                  //If trim(ar_report[i,0]) = 'mar_type' then ar_report[i,2]:= Edit3.Text;
                  //If trim(ar_report[i,0]) = 'rasp_kod' then ar_report[i,2]:= Edit6.Text;
                  //If trim(ar_report[i,0]) = 'rasp_name' then ar_report[i,2]:= Edit5.Text;
                  //If trim(ar_report[i,0]) = 'rasp_dates' then ar_report[i,2]:= DateEdit1.Text;
                  //If trim(ar_report[i,0]) = 'rasp_datepo' then ar_report[i,2]:= DateEdit2.Text;
                  //If trim(ar_report[i,0]) = 'rasp_date_active' then ar_report[i,2]:= DateEdit3.Text;
                  //If trim(ar_report[i,0]) = 'rasp_station_kod' then
                  //   begin
                  //    If PageControl1.ActivePageIndex=0 then
                  //     ar_report[i,2]:= Stringgrid1.Cells[0,Stringgrid1.row];
                  //    If PageControl1.ActivePageIndex=2 then
                  //     ar_report[i,2]:= Stringgrid10.Cells[0,Stringgrid10.row];
                  //   end;
                  // If trim(ar_report[i,0]) = 'rasp_station_name' then
                  //   begin
                  //    If PageControl1.ActivePageIndex=0 then
                  //     ar_report[i,2]:= Stringgrid1.Cells[1,Stringgrid1.row];
                  //    If PageControl1.ActivePageIndex=2 then
                  //     ar_report[i,2]:= Stringgrid10.Cells[1,Stringgrid10.row];
                  //   end;
                  //If (trim(ar_report[i,0])='rasp_atp_kod') AND (PageControl1.ActivePageIndex=1) then ar_report[i,2]:= Stringgrid8.Cells[0,Stringgrid8.row];
                  //If trim(ar_report[i,0]) = 'rasp_atp_name' then
                  //   begin
                  //    If PageControl1.ActivePageIndex=1 then
                  //     ar_report[i,2]:= Stringgrid8.Cells[1,Stringgrid8.row];
                  //    If PageControl1.ActivePageIndex=2 then
                  //     ar_report[i,2]:= Stringgrid6.Cells[1,Stringgrid6.row];
                  //   end;
                end;
  end;
  //отобразить
  for i:=low(ar_report) to high(ar_report) do
     begin
       s:=s+ar_report[i,0]+', '+ar_report[i,2]+ #13;
     end;
  //showmessagealt(inttostr(Length(ar_report))+#13+s);
  Close;
end;

procedure TFormRepV.CheckBox1Change(Sender: TObject);
begin
  If formRepV.CheckBox1.Checked then FormRepV.ComboBox2.Enabled:=false
  else FormRepV.ComboBox2.Enabled:=true;
end;

procedure TFormRepV.CheckBox2Change(Sender: TObject);
begin
  If formRepV.CheckBox2.Checked then FormRepV.Edit3.Enabled:=false
  else FormRepV.Edit3.Enabled:=true;
end;


procedure TFormRepV.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ENTER] - Выбор'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then  BitBtn4.Click;
    // ПРОБЕЛ  -  печатать
    if (Key=32) then  BitBtn5.Click;
    //отбой
    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=13) then Key:=0;
end;

procedure TFormRepV.FormShow(Sender: TObject);
begin
  With FormRepV do
  begin
   fillotd;
  Case fl_vibor of
     1: GroupBox1.Visible:=true;
     2: GroupBox2.Visible:=true;
     3: GroupBox8.Visible:=true;
     4: GroupBox4.Visible:=true;
  else
    begin
     showmessagealt('Не определен режим открытия формы!');
     Close;
    end;
  end;
  end;
end;

procedure TFormRepV.BitBtn2Click(Sender: TObject);
begin
   DelStringGrid(FormRepV.StringGrid6, FormRepV.StringGrid6.Row);
end;

//******************************* ДОБАВИТЬ МАРШРУТ **************************************************************************
procedure TFormRepV.BitBtn1Click(Sender: TObject);
var
  m: integer;
  sname : string;
begin
  form17:=Tform17.create(self);
  form17.ShowModal;
  FreeAndNil(form17);
  With FormRepV.StringGrid6 do
  begin
  // Заполняем поля для МАРШРУТОВ
  if (result_id_route='') then exit;

     //ищем дубликат
     For m:=0 to RowCount-1 do
       begin
         If Cells[0,Row]=result_id_route then
           begin
             showmessagealt('Данное значение уже присутствует в таблице!');
             exit;
           end;
       end;

     // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
     //Делаем запрос к маршрутам
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('select a.id,b.name AS name1,c.name AS name2,d.name AS name3,a.kod,a.type_route from av_route AS a');
      ZQuery1.SQL.add('Left JOIN av_spr_locality AS b ON a.id_nas1=b.id AND b.del=0');
      ZQuery1.SQL.add('Left JOIN av_spr_locality AS c ON a.id_nas2=c.id AND c.del=0');
      ZQuery1.SQL.add('Left JOIN av_spr_locality AS d ON a.id_nas3=d.id AND d.del=0');
      ZQuery1.SQL.add('WHERE a.id='+trim(result_id_route)+' AND a.del=0;');
//      showmessagealt(ZQuery1.SQL.Text);
     try
      ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
      ZQuery1.close;
      ZConnection1.disconnect;
      exit;
     end;

     If ZQuery1.RecordCount<>1 then exit;

     sname :=ZQuery1.FieldByName('name1').asString+' - '+ZQuery1.FieldByName('name2').asString;
     if not(trim(ZQuery1.FieldByName('name3').asString)='') then sname:=sname+' - '+ZQuery1.FieldByName('name3').asString;
     RowCount:= RowCount +1;
     Cells[0,RowCount-1] := result_id_route;
     Cells[1,RowCount-1] := sname;

     ZQuery1.Close;
     ZConnection1.Disconnect;

   end;
end;

end.

