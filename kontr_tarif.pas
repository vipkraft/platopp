unit kontr_tarif;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, LazUtf8, Spin;

type

  { TFormKontrTarif }

  TFormKontrTarif = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    FloatSpinEdit3: TFloatSpinEdit;
    FloatSpinEdit4: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    Label2: TLabel;
    Label4: TLabel;
    Label43: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;  var CanSelect: Boolean);
     procedure UpdateGrid(filter_type:byte; stroka:string);
     procedure EditCell(nCol,nRow: Integer);
     procedure refresh_memo;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormKontrTarif: TFormKontrTarif;

implementation
uses
   mainopp,platproc;

{$R *.lfm}

{ TFormKontrTarif }

var
  datatyp : byte=0;
  ss:string='';
  flagedit:boolean=false;
  n : integer;
  shedule_changed: array of integer;

   //**************************************************  ОТОБРАЖЕНИЕ ИЗМЕНЕННЫХ РАСПИСАНИЙ ******************
procedure TFormKontrTarif.refresh_memo;
var
  i,j,k:integer;
begin
  with FormKontrTarif do
  begin
    Memo1.Clear;
    If length(shedule_changed)>0 then
      begin
         GroupBox3.Height:=116;

    for i := 0 to length(shedule_changed)-1 do
        for j := 0 to length(shedule_changed)-i-1 do
            if shedule_changed[j] > shedule_changed[j+1] then
            begin
                k := shedule_changed[j];
                shedule_changed[j] := shedule_changed[j+1];
                shedule_changed[j+1] := k;
            end;

  for n:=0 to length(shedule_changed)-1 do
         begin
           Memo1.Text:=Memo1.Text+(inttostr(shedule_changed[n])+', ');
         end;
      end
    else
     GroupBox3.Height:=1;
  end;
  end;

  //**************************************************  РЕДАКТИРОВАНИЕ ЗНАЧЕНИЯ ТАРИФА ******************
procedure TFormKontrTarif.EditCell(nCol,nRow: Integer);
begin
   With FormKontrTarif do
   begin
    FloatSpinEdit1.Value := 0;
    FloatSpinEdit2.Value := 0;
    FloatSpinEdit3.Value := 0;
    FloatSpinEdit4.Value := 0;
    FormKontrTarif.Panel1.Visible:=true;
    FormKontrTarif.CheckBox1.SetFocus;
    If StringGrid1.Cells[10,nRow]='1' then
    begin
        CheckBox1.Checked:=true;
        CheckBox2.Checked:=true;
    end
    else
    begin
        CheckBox1.Checked:=false;
        CheckBox2.Checked:=false;
    end;
    If StringGrid1.Cells[9,nRow]='1' then RadioButton1.Checked:=true else RadioButton1.Checked:=false;
    If StringGrid1.Cells[9,nRow]='2' then RadioButton2.Checked:=true else RadioButton2.Checked:=false;
    If StringGrid1.Cells[11,nRow]='1' then RadioButton3.Checked:=true else RadioButton3.Checked:=false;
    If StringGrid1.Cells[11,nRow]='2' then RadioButton4.Checked:=true else RadioButton4.Checked:=false;
    try
     strtofloat(StringGrid1.Cells[3,nRow]);//редактирование ячейки
     FloatSpinEdit1.Value:= strtofloat(StringGrid1.Cells[3,nRow]);//редактирование ячейки
    except
             on exception: EConvertError do
             begin
               //showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x01');
               FloatSpinEdit1.Value := 0;
             end;
    end;
     try
     strtofloat(StringGrid1.Cells[4,nRow]);//редактирование ячейки
     FloatSpinEdit2.Value:= strtofloat(StringGrid1.Cells[4,nRow]);//редактирование ячейки
    except
             on exception: EConvertError do
             begin
               //showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x02');
               FloatSpinEdit2.Value := 0;
             end;
    end;
     try
     strtofloat(StringGrid1.Cells[5,nRow]);//редактирование ячейки
     FloatSpinEdit3.Value:= strtofloat(StringGrid1.Cells[5,nRow]);//редактирование ячейки
    except
             on exception: EConvertError do
             begin
               //showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x03');
               FloatSpinEdit3.Value := 0;
             end;
    end;
     try
     strtofloat(StringGrid1.Cells[6,nRow]);//редактирование ячейки
     FloatSpinEdit4.Value:= strtofloat(StringGrid1.Cells[6,nRow]);//редактирование ячейки
    except
             on exception: EConvertError do
             begin
               //showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x04');
               FloatSpinEdit4.Value := 0;
             end;
    end;

     FormKontrTarif.Stringgrid1.Enabled:= false;
   end;
end;


  //***********************************  ОБНОВИТЬ ДАННЫЕ НА ГРИДЕ **************************************************
procedure TFormKontrTarif.UpdateGrid(filter_type:byte; stroka:string);
 var
   n,m:integer;
 begin
  with FormKontrTarif do
  begin
   Stringgrid1.RowCount:=1;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
  // Запрос перевозчиков и их тарифов
   ZQuery1.SQL.clear;
   ZQuery1.SQL.add('SELECT distinct on (c.tarif_gorod,c.tarif_oblast,a.id_kontr) a.id_kontr,b.name,b.polname,b.kod1c,c.* FROM av_shedule_atp a ');
   ZQuery1.SQL.add('LEFT JOIN av_spr_kontragent b ON b.del=0 AND a.id_kontr=b.id  ');
   ZQuery1.SQL.add('LEFT JOIN av_kontr_tarif c ON c.del=0 AND c.id_kontr=a.id_kontr ');
   ZQuery1.SQL.add('WHERE a.del=0 ');

  //осуществлять контекстный поиск или нет
  //++++++++++++++++++++++++++++++++++++++++++++++++++++
 If filter_type=1 then
   begin
   //ZQuery1.SQL.add('AND ((a.id_kontr='+stroka+') OR (b.kod1c='+stroka+')) ');
    ZQuery1.SQL.add('and (cast(a.id_kontr as text) like '+quotedstr(stroka+'%')+' or cast(b.kod1c as text) like '+quotedstr(stroka+'%')+')');
   end;
 If filter_type=2 then
   begin
   //ZQuery1.SQL.add('AND ((UPPER(substr(b.name,1,'+inttostr(Utf8length(stroka))+'))=UPPER('+Quotedstr(stroka)+')) ');
   //ZQuery1.SQL.add('OR (UPPER(substr(b.polname,1,'+inttostr(Utf8length(stroka))+'))=UPPER('+Quotedstr(stroka)+'))) ');
    ZQuery1.SQL.add('and (b.name ilike '+quotedstr(stroka+'%')+' or b.polname ilike '+quotedstr(stroka+'%')+')');
   end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++

   ZQuery1.SQL.add('ORDER BY c.tarif_gorod,c.tarif_oblast,a.id_kontr ASC;');
  //-конец запроса :-)
  //showmessage(ZQuery1.SQL.Text);//$
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;
   if  ZQuery1.RecordCount=0 then
      begin
         ZQuery1.close;
         ZConnection1.Disconnect;
        exit;
      end;

   // Заполняем stringgrid
   for n:=1 to ZQuery1.RecordCount do
    begin
       Stringgrid1.RowCount:= Stringgrid1.RowCount + 1;
       StringGrid1.Cells[1,n]:=ZQuery1.FieldByName('id_kontr').asString;
       StringGrid1.Cells[2,n]:=ZQuery1.FieldByName('name').asString;
       If ZQuery1.FieldByName('tarif_gorod').AsFloat<>0 then
       StringGrid1.Cells[3,n]:=ZQuery1.FieldByName('tarif_gorod').asString;
       If ZQuery1.FieldByName('bagazh_gorod').AsFloat<>0 then
       StringGrid1.Cells[4,n]:=ZQuery1.FieldByName('bagazh_gorod').asString;
       If ZQuery1.FieldByName('tarif_oblast').AsFloat<>0 then
       StringGrid1.Cells[5,n]:=ZQuery1.FieldByName('tarif_oblast').asString;
       If ZQuery1.FieldByName('bagazh_oblast').AsFloat<>0 then
       StringGrid1.Cells[6,n]:=ZQuery1.FieldByName('bagazh_oblast').asString;
       StringGrid1.Cells[7,n]:=ZQuery1.FieldByName('polname').asString;
       StringGrid1.Cells[8,n]:=ZQuery1.FieldByName('kod1c').asString;
       StringGrid1.Cells[9,n]:=ZQuery1.FieldByName('bag_gorod_type').asString;
       StringGrid1.Cells[11,n]:=ZQuery1.FieldByName('bag_oblast_type').asString;
       StringGrid1.Cells[10,n]:='';//ячейка наличия редакции

       ZQuery1.next;
    end;
   // StringGrid1.Repaint;
    ZQuery1.Close;
    Zconnection1.disconnect;

    //StringGrid1.ColWidths[6]:= 0;
  end;
end;


//***************************** ВОЗНИКНОВЕНИЕ ФОРМЫ *******************************
procedure TFormKontrTarif.FormShow(Sender: TObject);
begin
  datatyp:=0;
  Updategrid(datatyp,'');
  If flag_access<2 then FormKontrTarif.BitBtn4.Enabled:= false;
  formKontrTarif.GroupBox3.Height:=1;
  stringgrid1.SetFocus;
end;

procedure TFormKontrTarif.StringGrid1Enter(Sender: TObject);
begin
  Edit1.Visible:=false;
end;


procedure TFormKontrTarif.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer; var CanSelect: Boolean);
begin
   If aRow<2 then exit;
end;


//******************************** hot keys  **********************************************
procedure TFormKontrTarif.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  With formKontrTarif do
   begin
    // на панели редактирования
    If (Panel1.Visible=true) then
       begin
          //ПРобел
          If (Key=32) then
             begin
             If CheckBox1.Focused then
              If CheckBox1.Checked then CheckBox1.Checked:=false else CheckBox1.Checked:=true;
             If CheckBox2.Focused then
              If CheckBox2.Checked then CheckBox2.Checked:=false else CheckBox2.Checked:=true;
               key:=0;
               exit;
             end;
         //ENTER
          If (Key=13) then
             begin
                Stringgrid1.Cells[9,Stringgrid1.Row]:='0';//тип рассчета багажа
             flagedit := true;  //флаг редактирования
             Stringgrid1.Cells[3,Stringgrid1.Row]:='0';
             Stringgrid1.Cells[4,Stringgrid1.Row]:='0';
             Stringgrid1.Cells[5,Stringgrid1.Row]:='0';
             Stringgrid1.Cells[6,Stringgrid1.Row]:='0';
             //Stringgrid1.Cells[3,Stringgrid1.Row]:=FloattostrF(FloatSpinEdit1.Value,fffixed,10,2);
             If CheckBox1.Checked then
                begin
             Stringgrid1.Cells[3,Stringgrid1.Row]:=stringreplace(FloatSpinEdit1.text,',','.',[]);
             Stringgrid1.Cells[4,Stringgrid1.Row]:=stringreplace(FloatSpinEdit2.text,',','.',[]);
             If RadioButton1.Checked then Stringgrid1.Cells[9,Stringgrid1.Row]:='1';
             If RadioButton2.Checked then Stringgrid1.Cells[9,Stringgrid1.Row]:='2';
                end;
           If CheckBox2.Checked then
              begin
             Stringgrid1.Cells[5,Stringgrid1.Row]:=stringreplace(FloatSpinEdit3.text,',','.',[]);
             Stringgrid1.Cells[6,Stringgrid1.Row]:=stringreplace(FloatSpinEdit4.text,',','.',[]);
             If RadioButton3.Checked then Stringgrid1.Cells[11,Stringgrid1.Row]:='1';
             If RadioButton4.Checked then Stringgrid1.Cells[11,Stringgrid1.Row]:='2';
              end;
             Stringgrid1.Cells[10,Stringgrid1.Row]:='1'; //ячейка наличия редактирования
             Stringgrid1.Enabled:=true;
             Stringgrid1.SetFocus;
             Panel1.Visible := false;
             FloatSpinEdit1.Value:= 0;
           FloatSpinEdit2.Value:= 0;
           FloatSpinEdit3.Value:= 0;
           FloatSpinEdit4.Value:= 0;
              key:=0;
              exit;
             end;
          //ESC
          If (Key=27) then
             begin
              Panel1.Visible := false;
              Stringgrid1.Enabled:=true;
              Stringgrid1.SetFocus;
              FloatSpinEdit1.Value:= 0;
           FloatSpinEdit2.Value:= 0;
           FloatSpinEdit3.Value:= 0;
           FloatSpinEdit4.Value:= 0;
              key:=0;
              exit;
             end;

       end;
  // //поле поиска
  //If Edit1.Visible then
  //  begin
  //  If (Panel1.Visible=false) then
  //  begin
  //  // ESC поиск // Вверх по списку   // Вниз по списку
  //   If key=27 then
  //      begin
  //        datatyp := 0;
  //        updategrid(datatyp,'');
  //        StringGrid1.SetFocus;
  //        key:=0;
  //        exit;
  //    end;
  //if (Key=38) OR (Key=40) then
  //   begin
  //     Edit1.Visible:=false;
  //     StringGrid1.SetFocus;
  //     key:=0;
  //     exit;
  //   end;
  //    // ENTER - остановить контекстный поиск
  // if (Key=13) then
  //   begin
  //     StringGrid1.SetFocus;
  //     key:=0;
  //     exit;
  //   end;
  // end;
  //  end;

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
    //F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Записать тарифы для перевозчика'+#13+'[ENTER] - Изменить значение тарифа'+#13+'[ESC] - Отмена\Выход');
    //F2 - Записать тарифы для перевозчика
    if (Key=113) and (bitbtn4.enabled=true) then BitBtn4.Click;
    //[ENTER] - Изменить значение тарифа
    if (Key=13) and (Stringgrid1.Focused) then EditCell(Stringgrid1.Col,Stringgrid1.Row);
    // ESC
    if (Key=27) then FormKontrTarif.close;
    If stringgrid1.Focused then
       begin
          //ENTER или SPACE
          If (Key=13) or (Key=32) then EditCell(FormKontrTarif.StringGrid1.Col,FormKontrTarif.StringGrid1.Row);//редактирование тарифа
          end;
   //  // Контекcтный поиск
   //if (Edit1.Visible=false) AND (stringgrid1.Focused) AND (Panel1.Visible=false) then
   //  begin
   //    If (get_type_char(key)>0) or (key=8) or (key=46) or (key=96) then //8-backspace 46-delete 96- numpad 0
   //    begin
   //      Edit1.text:='';
   //      Edit1.Visible:=true;
   //      Edit1.SetFocus;
   //    end;
   //  end;
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
    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=120) or (Key=32) or (Key=27) or (Key=13)  then Key:=0;
   end;
end;


  //фильтрация грида на основе контекстного поиска
procedure TFormKontrTarif.Edit1Change(Sender: TObject);
  var
  n:integer=0;
begin
  with FormKontrTarif do
begin
  ss:=trimleft(Edit1.Text);
  if UTF8Length(ss)>0 then
       begin
      //определяем тип данных для поиска
       if (ss[1] in ['0'..'9']) then datatyp:=1
       else datatyp:=2;
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


//*************************************** СОХРАНИТЬ  ******************************************************
procedure TFormKontrTarif.BitBtn4Click(Sender: TObject);
var
 nTarifGorod :string='';
 nTarifObl :string='';
 nBagazhGorod :string='';
 nBagazhObl :string='';
 flG,flO: byte;
 m,i:integer;
 flfind:boolean;
begin
  With FormKontrTarif do
   begin
   If not flagedit then
     begin
     showmessagealt('Сначала внесите изменения !');
     exit;
     end;
   If Stringgrid1.RowCount<1 then
     begin
     showmessagealt('Нет записей по перевозчикам !');
     exit;
     end;

  if dialogs.MessageDlg('     В Н И М А Н И Е !!!     '+#13+'На всех расписаниях будет изменена тарифная стоимость'+#13+'по измененным здесь коэффициентам для перевозчиков !'+#13+'Продолжить сохранение ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
        begin
          exit;
        end;
  setlength(shedule_changed,0);
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

  for n:=1 to Stringgrid1.RowCount-1 do
   begin
     //Если не было изменений в тарифе, то - отвал
        If trim(Stringgrid1.Cells[10,n])<>'1' then continue;
    //flO:=0;  //флаг необходимости изменений по межгороду
    //flG:=0; //флаг необходимости изменений по межобласти
  //помечаем на удаление предыдущее значение тарифа
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_kontr_tarif SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_kontr='+Stringgrid1.Cells[1,n]+' AND del=0;');
       ZQuery1.ExecSQL;

     //помечаем на удаление старые тарифы расписаний перевозчиков
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_shedule_tarif SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_kontr='+Stringgrid1.Cells[1,n]+' AND del=0;');
       ZQuery1.ExecSQL;

     nTarifGorod :=trim(Stringgrid1.Cells[3,n]);
     nTarifObl :=trim(Stringgrid1.Cells[5,n]);
     nBagazhGorod :=trim(Stringgrid1.Cells[4,n]);
     nBagazhObl :=trim(Stringgrid1.Cells[6,n]);
      //если тариф сброшен в 0 то, новые значения не записывать
    try
      strtofloat(nTarifGorod);
    except
        on exception: EConvertError do
             begin
               //showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x05');
               nTarifGorod:='0';
             end;
    end;
   try
      strtofloat(nBagazhGorod);
    except
        on exception: EConvertError do
             begin
               //showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x06');
               nBagazhGorod:='0';
             end;
    end;
    try
      strtofloat(nTarifObl);
    except
        on exception: EConvertError do
             begin
               //showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x07');
               nTarifObl:='0';
             end;
    end;
   try
      strtofloat(nBagazhObl);
    except
        on exception: EConvertError do
             begin
               //showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x08');
               nBagazhObl:='0';
             end;
    end;

    //****Запись тарифов междугородных расписаний
     ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('INSERT INTO av_shedule_tarif(id_shedule,id_kontr,id_point,point_order,');
    ZQuery1.SQL.add('km,hardm2,hardm3,softm2,softm3,tarif_hardm2,tarif_hardm3,tarif_softm2,tarif_softm3,');
    ZQuery1.SQL.add('bagazh,calculation_type,');
    ZQuery1.SQL.add('id_user,createdate,del,id_user_first,createdate_first) ');
    ZQuery1.SQL.add('SELECT a.id_shedule,b.id_kontr,a.id_point,a.point_order,a.km,');
    ZQuery1.SQL.add('(round('+nTarifGorod+'*a.km,2)) as hardm2,');
    ZQuery1.SQL.add('(round('+nTarifGorod+'*a.km,2)) as hardm3,');
    ZQuery1.SQL.add('(round('+nTarifGorod+'*a.km,2)) as softm2,');
    ZQuery1.SQL.add('(round('+nTarifGorod+'*a.km,2)) as softm3,');
    ZQuery1.SQL.add(nTarifGorod+','+nTarifGorod+','+nTarifGorod+','+nTarifGorod+',');
    ZQuery1.SQL.add(nBagazhGorod+','+Stringgrid1.Cells[9,n]+',');
    ZQuery1.SQL.add(intToStr(id_user)+',now(),0,'+intToStr(id_user)+',now() ');
    ZQuery1.SQL.add('FROM av_shedule_sostav a ');
    ZQuery1.SQL.add('JOIN av_shedule_atp b ON b.del=0 AND b.id_shedule=a.id_shedule ');
    ZQuery1.SQL.add('WHERE a.del=0 AND a.id_shedule IN ');
    ZQuery1.SQL.add('(Select id_shedule FROM av_shedule_atp WHERE del=0 AND id_kontr='+Stringgrid1.Cells[1,n]+' AND id_shedule IN ');
    ZQuery1.SQL.add('(select v.id from av_shedule v JOIN av_route b ON v.id_route=b.id AND b.del=0 AND b.type_route=0 WHERE v.del=0));');
    //showmessage(ZQuery1.SQL.text);//$
    ZQuery1.open;

    //****Запись тарифов межобластных расписаний
     ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('INSERT INTO av_shedule_tarif(id_shedule,id_kontr,id_point,point_order,');
    ZQuery1.SQL.add('km,hardm2,hardm3,softm2,softm3,tarif_hardm2,tarif_hardm3,tarif_softm2,tarif_softm3,');
    ZQuery1.SQL.add('bagazh,calculation_type,');
    ZQuery1.SQL.add('id_user,createdate,del,id_user_first,createdate_first) ');
    ZQuery1.SQL.add('SELECT a.id_shedule,b.id_kontr,a.id_point,a.point_order,a.km,');
    ZQuery1.SQL.add('(round('+nTarifObl+'*a.km,2)) as hardm2,');
    ZQuery1.SQL.add('(round('+nTarifObl+'*a.km,2)) as hardm3,');
    ZQuery1.SQL.add('(round('+nTarifObl+'*a.km,2)) as softm2,');
    ZQuery1.SQL.add('(round('+nTarifObl+'*a.km,2)) as softm3,');
    ZQuery1.SQL.add(nTarifObl+','+nTarifObl+','+nTarifObl+','+nTarifObl+',');
    ZQuery1.SQL.add(nBagazhObl+','+Stringgrid1.Cells[11,n]+',');
    ZQuery1.SQL.add(intToStr(id_user)+',now(),0,'+intToStr(id_user)+',now() ');
    ZQuery1.SQL.add('FROM av_shedule_sostav a ');
    ZQuery1.SQL.add('JOIN av_shedule_atp b ON b.del=0 AND b.id_shedule=a.id_shedule ');
    ZQuery1.SQL.add('WHERE a.del=0 AND a.id_shedule IN ');
    ZQuery1.SQL.add('(Select id_shedule FROM av_shedule_atp WHERE del=0 AND id_kontr='+Stringgrid1.Cells[1,n]+' AND id_shedule IN ');
    ZQuery1.SQL.add('(select v.id from av_shedule v JOIN av_route b ON v.id_route=b.id AND b.del=0 AND b.type_route=2 WHERE v.del=0));');
    //showmessage(ZQuery1.SQL.text);//$
    ZQuery1.open;


  //Производим запись новых данных
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('INSERT INTO av_kontr_tarif(id_kontr,tarif_gorod,bagazh_gorod,tarif_oblast,bagazh_oblast,bag_gorod_type,bag_oblast_type,createdate,id_user,del) VALUES (');
   ZQuery1.SQL.add(Stringgrid1.Cells[1,n]+','+Stringgrid1.Cells[3,n]+','+Stringgrid1.Cells[4,n]+','+Stringgrid1.Cells[5,n]+','+Stringgrid1.Cells[6,n]+',');
   ZQuery1.SQL.add(Stringgrid1.Cells[9,n]+','+Stringgrid1.Cells[11,n]+',now(),'+ intToStr(id_user)+',0);');
   ZQuery1.open;
    //showmessage(ZQuery1.SQL.text);//$

      //****Считаем междугородных расписаний
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('SELECT distinct a.id_shedule FROM av_shedule_sostav a ');
    ZQuery1.SQL.add('JOIN av_shedule_atp b ON b.del=0 AND b.id_shedule=a.id_shedule ');
    ZQuery1.SQL.add('WHERE a.del=0 AND a.id_shedule IN ');
    ZQuery1.SQL.add('(Select id_shedule FROM av_shedule_atp WHERE del=0 AND id_kontr='+Stringgrid1.Cells[1,n]+' AND id_shedule IN ');
    ZQuery1.SQL.add('(select v.id from av_shedule v JOIN av_route b ON v.id_route=b.id AND b.del=0 AND b.type_route=0 WHERE v.del=0)) ORDER BY a.id_shedule;');
    //showmessage(ZQuery1.SQL.text);//$
    ZQuery1.open;

    for m:=1 to ZQuery1.RecordCount do
     begin
      flfind := false;
        for i:=0 to length(shedule_changed)-1 do
         begin
           If Zquery1.FieldByName('id_shedule').AsInteger=shedule_changed[i] then flfind:=true;
         end;
        If not flfind then
         begin
           SetLength(shedule_changed,length(shedule_changed)+1);
           shedule_changed[length(shedule_changed)-1]:=Zquery1.FieldByName('id_shedule').AsInteger;
         end;
       ZQuery1.Next;
     end;
        //****Считаем межобластные расписаний
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('SELECT distinct a.id_shedule FROM av_shedule_sostav a ');
    ZQuery1.SQL.add('JOIN av_shedule_atp b ON b.del=0 AND b.id_shedule=a.id_shedule ');
    ZQuery1.SQL.add('WHERE a.del=0 AND a.id_shedule IN ');
    ZQuery1.SQL.add('(Select id_shedule FROM av_shedule_atp WHERE del=0 AND id_kontr='+Stringgrid1.Cells[1,n]+' AND id_shedule IN ');
    ZQuery1.SQL.add('(select v.id from av_shedule v JOIN av_route b ON v.id_route=b.id AND b.del=0 AND b.type_route=2 WHERE v.del=0)) ORDER BY a.id_shedule;');
    //showmessage(ZQuery1.SQL.text);//$
    ZQuery1.open;

    for m:=1 to ZQuery1.RecordCount do
     begin
      flfind := false;
        for i:=0 to length(shedule_changed)-1 do
         begin
           If Zquery1.FieldByName('id_shedule').AsInteger=shedule_changed[i] then flfind:=true;
         end;
        If not flfind then
         begin
           SetLength(shedule_changed,length(shedule_changed)+1);
           shedule_changed[length(shedule_changed)-1]:=Zquery1.FieldByName('id_shedule').AsInteger;
         end;
       ZQuery1.Next;
     end;


   end;

  // Завершение транзакции
  Zconnection1.Commit;
  //showmessagealt('Транзакция УСПЕШНО завершена !');
  ZQuery1.Close;
  Zconnection1.disconnect;
  //флаг внесения изменений
  flagedit := false;
  showmessagealt('УСПЕШНО изменен тариф для '+inttostr(length(shedule_changed))+' расписаний !');
  //Close;
  //Если первая вкладка - закрывать окно, иначе - нет
  //If PageControl1.ActivePageIndex=0 then Close;
//  else showmessagealt('Сохранение Успешно!');
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
     exit;
 end;
   for n:=1 to Stringgrid1.RowCount-1 do
   begin
     //Сбрасываем изменений в тарифе
        Stringgrid1.Cells[10,n]:='0';
   end;
   refresh_memo;
 end;
end;

procedure TFormKontrTarif.BitBtn3Click(Sender: TObject);
begin
  FormKontrTarif.Close;
end;

procedure TFormKontrTarif.CheckBox1Change(Sender: TObject);
begin
  with formKontrTarif do
   begin
  If CheckBox1.Checked then
    begin
      GroupBox1.Enabled:=true;
      FloatSpinEdit1.SetFocus;
      end
      else
      begin
       GroupBox1.Enabled:=false;
       CheckBox2.SetFocus;
       end;
  end;
end;

procedure TFormKontrTarif.CheckBox2Change(Sender: TObject);
begin
   with formKontrTarif do
   begin
  If CheckBox2.Checked then
     begin
      GroupBox2.Enabled:=true;
      FloatSpinEdit3.SetFocus;
      end
      else
      begin
       GroupBox2.Enabled:=false;
       CheckBox1.SetFocus;
       end;
  end;
end;

procedure TFormKontrTarif.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   If flagedit then
      if dialogs.MessageDlg('Изменения НЕ будут СОХРАНЕНЫ !!!'+#13+'Продолжить выход ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
        begin
          CloseAction := caNone;
          exit;
        end;
end;


end.

