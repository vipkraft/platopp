unit dogovor_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls, EditBtn
  //, Calendar
  ,Spin, ComCtrls,platproc, ZConnection, ZDataset;

type

  { TForm24 }

  TForm24 = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn7: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox10: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    ComboBox9: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DateEdit3: TDateEdit;
    DateEdit4: TDateEdit;
    DateEdit5: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit6: TEdit;
    Edit8: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit10: TFloatSpinEdit;
    FloatSpinEdit11: TFloatSpinEdit;
    FloatSpinEdit12: TFloatSpinEdit;
    FloatSpinEdit13: TFloatSpinEdit;
    FloatSpinEdit14: TFloatSpinEdit;
    FloatSpinEdit15: TFloatSpinEdit;
    FloatSpinEdit16: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    FloatSpinEdit21: TFloatSpinEdit;
    FloatSpinEdit22: TFloatSpinEdit;
    FloatSpinEdit23: TFloatSpinEdit;
    FloatSpinEdit24: TFloatSpinEdit;
    FloatSpinEdit25: TFloatSpinEdit;
    FloatSpinEdit26: TFloatSpinEdit;
    FloatSpinEdit27: TFloatSpinEdit;
    FloatSpinEdit3: TFloatSpinEdit;
    FloatSpinEdit4: TFloatSpinEdit;
    FloatSpinEdit5: TFloatSpinEdit;
    FloatSpinEdit6: TFloatSpinEdit;
    FloatSpinEdit7: TFloatSpinEdit;
    FloatSpinEdit8: TFloatSpinEdit;
    FloatSpinEdit9: TFloatSpinEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    SpinEdit8: TSpinEdit;
    SpinEdit9: TSpinEdit;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RefreshKontr(); //Обновить инфу по контрагенту на форме

  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form24: TForm24;
  vibor_dog:byte;

implementation
 uses
   mainopp,kontr_main,kontr_edit,dogovor,dogovor1c;
 {$R *.lfm}
 var
   type_read:byte;
  new_id,n:integer;
  kontrID, dogovorID : string;
  //arV : array[0..200] of array[0..1] of string;
  arV : array of array of string;

{ TForm24 }

//******************************** //Обновить инфу по контрагенту на форме *****************************************
 procedure TForm24.RefreshKontr();
begin
   with Form24 do
    begin
     //try
     //SpinEdit9.value:=strtoint(kontrID);//код контрагента
     //except
     //  showmessage('ОШИБКА КОНВЕРТАЦИИ код контрагента !');
     //  exit;
     // end;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

   // Запрос на редактируюмую запись
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('Select * FROM av_spr_kontr_dog where id_kontr='+kontrID+' AND id='+dogovorID+' AND kod1c='+Form23.StringGrid1.Cells[6,Form23.StringGrid1.row]+' and del=0 limit 1;');
    //showmessage(ZQuery1.SQL.Text);//$
    try
        ZQuery1.open;
    except
       showmessage('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
        ZQuery1.Close;
        Zconnection1.disconnect;
       exit;
    end;
    If  ZQuery1.RecordCount<1 then
     begin
       ZQuery1.Close;
       Zconnection1.disconnect;
       exit;
      end;
   // Определяем текущие данные
      Edit2.Text:=ZQuery1.FieldByName('name').asString;//наименование
      DateEdit1.Text:=ZQuery1.FieldByName('datazak').asString;//дата заключения договора
      DateEdit2.Text:=ZQuery1.FieldByName('datavoz').asString;//дата возникновения обязательств
      DateEdit3.Text:=ZQuery1.FieldByName('datapog').asString;//дата погашения обязательств

      SpinEdit8.value:=ZQuery1.FieldByName('kod1c').asInteger;//код 1С
      FloatSpinEdit21.value:=ZQuery1.FieldByName('otcblm').AsFloat;//отчисления билетов МЖГ
      FloatSpinEdit22.value:=ZQuery1.FieldByName('otcbagm').AsFloat;//отчисления багажа МЖГ
      FloatSpinEdit23.value:=ZQuery1.FieldByName('otcblp').AsFloat;//отчисления билетов ПРГ
      FloatSpinEdit24.value:=ZQuery1.FieldByName('otcbagp').AsFloat;//отчисления багажа ПРГ
      FloatSpinEdit25.value:=ZQuery1.FieldByName('lgot').AsFloat;//льготы
      FloatSpinEdit26.value:=ZQuery1.FieldByName('voin').AsFloat;//воинские
      FloatSpinEdit27.value:=ZQuery1.FieldByName('dopus').AsFloat;//доп услуги
      FloatSpinEdit1.value:=ZQuery1.FieldByName('komotd').AsFloat;//комната отдыха
      FloatSpinEdit2.value:=ZQuery1.FieldByName('med').AsFloat;//медосмотр
      FloatSpinEdit3.value:=ZQuery1.FieldByName('ubor').AsFloat;//уборка
      FloatSpinEdit4.value:=ZQuery1.FieldByName('stop').AsFloat;//стоянка
      FloatSpinEdit5.value:=ZQuery1.FieldByName('disp').AsFloat;//диспетчеризация
      FloatSpinEdit6.value:=ZQuery1.FieldByName('sumar').AsFloat;//сумма аренды
      Edit3.Text:=Trim(ZQuery1.FieldByName('vidar').asString);//вид аренды
      Edit6.Text:=ZQuery1.FieldByName('val').asString;//валюта договора
      DateEdit4.Text:=ZQuery1.FieldByName('datanacsh').asString;//дата начала начисления штрафных санкций
      DateEdit5.Text:=ZQuery1.FieldByName('dataprsh').asString;//дата конца начисления штрафных санкций
      FloatSpinEdit6.value:=ZQuery1.FieldByName('stav').AsFloat;////ставка штрафных санкций
      Edit8.Text:=ZQuery1.FieldByName('podr').asString;//подразделение
      FloatSpinEdit8.value:=ZQuery1.FieldByName('shtr1').AsFloat ;//срыв рейса межгород
      FloatSpinEdit9.value:=ZQuery1.FieldByName('shtr11').AsFloat;//срыв рейса пригород
      FloatSpinEdit10.value:=ZQuery1.FieldByName('shtr2').AsFloat;//незаход
      FloatSpinEdit11.value:=ZQuery1.FieldByName('shtr3').AsFloat;//неостановка на жезл
      FloatSpinEdit12.value:=ZQuery1.FieldByName('shtr4').AsFloat;//опоздание до 1 часа
      FloatSpinEdit13.value:=ZQuery1.FieldByName('shtr41').AsFloat;//опоздание после 1 часа
      FloatSpinEdit14.value:=ZQuery1.FieldByName('shtr5').AsFloat;//алкогольное опьянение
      FloatSpinEdit15.value:=ZQuery1.FieldByName('shtr8').AsFloat;//экипировка   //незаявленное ТС
      FloatSpinEdit16.value:=ZQuery1.FieldByName('shtr7').AsFloat;//провоз безбилетных
      ComboBox2.Text:=ZQuery1.FieldByName('edizm1').asString;//единица измерения;
      ComboBox3.Text:=ZQuery1.FieldByName('edizm11').asString;//единица измерения;
      ComboBox4.Text:=ZQuery1.FieldByName('edizm2').asString;//единица измерения;
      ComboBox5.Text:=ZQuery1.FieldByName('edizm3').asString;//единица измерения;
      ComboBox6.Text:=ZQuery1.FieldByName('edizm4').asString;//единица измерения;
      ComboBox7.Text:=ZQuery1.FieldByName('edizm41').asString;//единица измерения;
      ComboBox8.Text:=ZQuery1.FieldByName('edizm5').asString;//единица измерения;
      ComboBox9.Text:=ZQuery1.FieldByName('edizm8').asString;//единица измерения;
      ComboBox10.Text:=ZQuery1.FieldByName('edizm7').asString;//единица измерения;


//    вид договора
      for n:=0 to Length(arV)-1 do
      begin
      If strToInt(arV[n,0])=ZQuery1.FieldByName('viddog').asinteger then
      begin
      ComboBox1.ItemIndex:=n;//вид договора;
      break;
      end;
      end;

       If combobox2.ItemIndex<0 then combobox2.ItemIndex:=0;
       If combobox3.ItemIndex<0 then combobox3.ItemIndex:=0;
       If combobox4.ItemIndex<0 then combobox4.ItemIndex:=0;
       If combobox5.ItemIndex<0 then combobox5.ItemIndex:=0;
       If combobox6.ItemIndex<0 then combobox6.ItemIndex:=0;
       If combobox7.ItemIndex<0 then combobox7.ItemIndex:=0;
       If combobox8.ItemIndex<0 then combobox8.ItemIndex:=0;
       If combobox9.ItemIndex<0 then combobox9.ItemIndex:=0;
       If combobox10.ItemIndex<0 then combobox10.ItemIndex:=0;

     end;

    ZQuery1.Close;
    Zconnection1.disconnect;

end;


//***********************************************  ОТМЕНА *******************************************
procedure TForm24.BitBtn4Click(Sender: TObject);
begin
  Form24.close;
end;


//**********************************************  ДРУГОЙ ИСТОЧНИК (ДОГОВОРА 1С) *************************************
procedure TForm24.BitBtn7Click(Sender: TObject);
begin
  //Обнуляем флаг выбора
  vibor_dog := 0;
  Form25:=TForm25.create(self);
  Form25.ShowModal;
  FreeAndNil(Form25);
  //Если ничего не выбрано
    If vibor_dog=0 then exit;
    //ВЫВОДИМ  ДАННЫЕ ИЗ 1С
  //  RefreshKontr();

end;

procedure TForm24.Edit2Enter(Sender: TObject);
begin
  iF fl_edit_dog=1 then exit;
   //вывести инфу о создании и редактировании записи
   //ShowEditLog(Form24, Form24.Panel1, Form24.ZQuery1, Form24.ZConnection1,'av_spr_kontr_dog',dogovorID,1);
end;


//***********************************************  СОХРАНИТЬ ************************************************************************
procedure TForm24.BitBtn3Click(Sender: TObject);
var
  new_id: integer;
begin
  with Form24 do
  begin
  //Сохраняем данные
    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

  //*********** СОХРАНЕНИЕ ДОГОВОРОВ НА 2 ВКЛАДКЕ (АСТРА)
 //  If (PageControl1.ActivePageIndex=1) or ((fl_edit_dog=2) AND (Form23.StringGrid1.Cells[2,Form23.StringGrid1.row]='*')) then
 //  begin
 //    If Dateedit7.Date<Dateedit6.Date then
 //     begin
 //       showmessagealt('Дата окончания действия договора меньше даты его начала!');
 //       exit;
 //     end;
 //    If  (floatspinedit28.Value=0.00) and  (floatspinedit29.Value=0.00) and (floatspinedit30.Value=0.00) then
 //    begin
 //     showmessagealt('Все значения пусты!');
 //     exit;
 //    end;
 //

 //
 ////Открываем транзакцию
 //try
 //  If not Zconnection1.InTransaction then
 //     Zconnection1.StartTransaction
 //  else
 //    begin
 //     showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
 //     ZConnection1.Rollback;
 //     exit;
 //    end;
 // //режим добавления
 // if fl_edit_dog=1 then
 //     begin
 // //Определяем текущий id+1
 //       ZQuery1.SQL.Clear;
 //       ZQuery1.SQL.add('SELECT coalesce(max(id),0)+1 as new_id FROM av_spr_kontr_dog2;');
 //       ZQuery1.open;
 //       new_id:=ZQuery1.FieldByName('new_id').asInteger;
 //       Edit1.Text:=IntToStr(new_id);
 //     end;
 //  //режим редактирования
 // if fl_edit_dog=2 then
 //     begin
 //      ZQuery1.SQL.Clear;
 //      ZQuery1.SQL.add('UPDATE av_spr_kontr_dog2 SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+dogovorID+' and id_kontr='+kontrID+' and del=0;');
 //      ZQuery1.ExecSQL;
 //     end;
 //
 //      //создание записи
 //      ZQuery1.SQL.Clear;
 //      ZQuery1.SQL.add('INSERT INTO av_spr_kontr_dog2(id,id_kontr,datavoz,datapog,active,type1,type2,type3,createdate,id_user,createdate_first,id_user_first,del) VALUES (');
 //      //режим добавления
 // if fl_edit_dog=1 then
 //      ZQuery1.SQL.add(inttostr(new_id)+',');
 //  //режим редактирования
 // if fl_edit_dog=2 then
 //      ZQuery1.SQL.add(dogovorID+',');
 //
 //     ZQuery1.SQL.add(kontrID+','+Quotedstr(Dateedit6.Text)+','+Quotedstr(Dateedit7.Text));
 //
 //     If checkbox1.Checked then
 //           ZQuery1.SQL.add(',1,')
 //         else
 //          ZQuery1.SQL.add(',0,');
 //    ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit28.Value,fffixed,5,2)+',');
 //    ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit29.Value,fffixed,5,2)+',');
 //    ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit30.Value,fffixed,5,2)+',');
 //
 //    if fl_edit_dog=1 then
 //      ZQuery1.SQL.add('now(),'+inttostr(id_user)+',now(),'+inttostr(id_user)+',0);');
 //    if fl_edit_dog=2 then
 //      ZQuery1.SQL.add('now(),'+inttostr(id_user)+',NULL,NULL,0);');
 //
 //      //showmessage(ZQuery1.SQL.Text);//$
 //      ZQuery1.open;
 //
 ////Завершение транзакции
 //   Zconnection1.Commit;
 //   ZConnection1.Disconnect;
 //   //showmessagealt('Транзакция завершена УСПЕШНО !!!');
 //  except
 //    If ZConnection1.InTransaction then Zconnection1.Rollback;
 //    showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
 //    ZQuery1.Close;
 //    Zconnection1.disconnect;
 //    exit;
 //  end;
 //  //ZQuery1.Close;
 //  //Zconnection1.disconnect;
 //  //Form24.Close;
 //
 //  end;

  //********** СОХРАНЕНИЕ ОБЫЧНОГО ДОГОВОРА *****************
  If (PageControl1.ActivePageIndex=0) then
   //если обычный договор
   begin

  //Проверяем на наличие всех данных в полях ввода
  if (trim(Edit2.text)='') then
   begin
     showmessagealt('Сначала заполните поле НАИМЕНОВАНИЕ ДОГОВОРА !');
     exit;
   end;
  if (trim(DateEdit1.text)='') then
   begin
     showmessagealt('Сначала заполните поле ДАТА ЗАКЛЮЧЕНИЯ ОБЯЗАТЕЛЬСТВ !');
     exit;
   end;
  if (trim(DateEdit2.text)='') then
   begin
     showmessagealt('Сначала заполните поле ДАТА ВОЗНИКНОВЕНИЯ ОБЯЗАТЕЛЬСТВ !');
     exit;
   end;
  if (trim(DateEdit3.text)='') then
   begin
     showmessagealt('Сначала заполните поле ДАТА ПОГАШЕНИЯ ОБЯЗАТЕЛЬСТВ !');
     exit;
   end;
  if (trim(ComboBox1.text)='') then
   begin
     showmessagealt('Сначала выберите ВИД ДОГОВОРА !');
     exit;
   end;

  If DateEdit2.Date>DateEdit3.Date then
   begin
     showmessagealt('Дата погашения обязательства меньше даты его возникновения !');
     exit;
   end;

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
  //режим добавления
  if fl_edit_dog=1 then
      begin
  //Определяем текущий id+1
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('SELECT coalesce(max(id),0)+1 as new_id FROM av_spr_kontr_dog;');
        ZQuery1.open;
        new_id:=ZQuery1.FieldByName('new_id').asInteger;
        Edit1.Text:=IntToStr(new_id);
      end;
   //режим редактирования
  if fl_edit_dog=2 then
      begin
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_spr_kontr_dog SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+dogovorID+' and id_kontr='+kontrID+' and del=0;');
        //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.ExecSQL;
      end;

       //создание записи
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('INSERT INTO av_spr_kontr_dog(id,id_kontr,del,createdate,id_user,createdate_first,id_user_first,kodkont,kod1c,name,datazak,datavoz,datapog,val,datanacsh,');
       ZQuery1.SQL.add('dataprsh,stav,viddog,podr,otcblm,otcbagm,otcblp,otcbagp,lgot,voin,dopus,komotd,med,ubor,stop,disp,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,shtr8,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm8,edizm7) VALUES (');
       //режим добавления
  if fl_edit_dog=1 then
       ZQuery1.SQL.add(inttostr(new_id)+','+kontrID+',0,now(),'+inttostr(id_user)+',now(),'+inttostr(id_user)+',');
   //режим редактирования
  if fl_edit_dog=2 then
      ZQuery1.SQL.add(dogovorID+','+kontrID+',0,now(),'+inttostr(id_user)+',NULL,NULL,');

       ZQuery1.SQL.add(intTOStr(SpinEdit9.Value)+','+intTOStr(SpinEdit8.Value)+','+QuotedSTR(trim(Edit2.text))+',');
       ZQuery1.SQL.add(QuotedSTR(DateToStr(DateEdit1.Date))+','+QuotedSTR(DateToStr(DateEdit2.Date))+','+QuotedSTR(DateToStr(DateEdit3.Date))+','+QuotedSTR(trim(Edit6.text))+','+QuotedSTR(DateToStr(DateEdit4.Date))+',');
       ZQuery1.SQL.add(QuotedSTR(DateToStr(DateEdit5.Date))+','+floatToStr(FloatSpinEdit7.value)+','+QuotedSTR(arV[ComboBox1.ItemIndex,0])+','+QuotedSTR(trim(Edit8.Text))+',');
       ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit21.Value,fffixed,5,2)+',');
       ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit22.Value,fffixed,5,2)+',');
       ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit23.Value,fffixed,5,2)+',');
       ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit24.Value,fffixed,5,2)+',');
       ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit25.Value,fffixed,5,2)+',');
       ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit26.Value,fffixed,5,2)+',');
       ZQuery1.SQL.add(floatTOStrf(FloatSpinEdit27.Value,fffixed,5,2)+',');
       ZQuery1.SQL.add(floatToStr(FloatSpinEdit1.value)+','+floatToStr(FloatSpinEdit2.value)+','+floatToStr(FloatSpinEdit3.value)+','+floatToStr(FloatSpinEdit4.value)+','+floatToStr(FloatSpinEdit5.value)+',');
       ZQuery1.SQL.add(QuotedSTR(Edit3.Text)+','+floatToStr(FloatSpinEdit6.value)+','+floatToStr(FloatSpinEdit8.value)+','+floatToStr(FloatSpinEdit9.value)+',');
       ZQuery1.SQL.add(floatToStr(FloatSpinEdit10.value)+','+floatToStr(FloatSpinEdit11.value)+','+floatToStr(FloatSpinEdit12.value)+','+floatToStr(FloatSpinEdit13.value)+','+floatToStr(FloatSpinEdit14.value)+','+floatToStr(FloatSpinEdit15.value)+',');
       ZQuery1.SQL.add(floatToStr(FloatSpinEdit16.value)+','+QuotedSTR(trim(ComboBox2.Text))+','+QuotedSTR(trim(ComboBox3.Text))+','+QuotedSTR(trim(ComboBox4.Text))+','+QuotedSTR(trim(ComboBox5.Text))+','+QuotedSTR(trim(ComboBox6.Text))+',');
       ZQuery1.SQL.add(QuotedSTR(trim(ComboBox7.Text))+','+QuotedSTR(trim(ComboBox8.Text))+','+QuotedSTR(trim(ComboBox9.Text))+','+QuotedSTR(trim(ComboBox10.Text))+');');
//       ZQuery1.SQL.add(floatToStr(FloatSpinEdit16.value)+','''','''','''','''','''','''','''','''','''')');
       //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.ExecSQL;

 //Завершение транзакции
    Zconnection1.Commit;
    ZConnection1.Disconnect;
    //showmessagealt('Транзакция завершена УСПЕШНО !!!');
   except
     If ZConnection1.InTransaction then Zconnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
     exit;
   end;


  end;
   ZQuery1.Close;
   Zconnection1.disconnect;
   Form24.Close;

  end;
end;

//**************************************  ОБРАБОТЧИК НАЖАТИЯ КЛАВИШИ *******************************************
procedure TForm24.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'F9 - Выбор из другого источника'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then Form24.Close;
    // F2 - Сохранить
    if (Key=113) and (Form24.BitBtn3.Enabled=true) then Form24.BitBtn3.Click;
    // F9 - Другой источник
    if (Key=120) and (Form24.BitBtn7.Enabled=true) then Form24.BitBtn7.Click;

    if (Key=112) or (Key=113) or (Key=120) or (Key=27) then Key:=0;
end;


/////*************************************** ВОЗНИКНОВЕНИЕ ФОРМЫ  *******************************************
procedure TForm24.FormShow(Sender: TObject);
 var
   tmp_id, tmp_id_first, dzm: string;
begin
  //Centrform(Form24);
  dogovorID:='';
  new_id:=0;
  with Form24 do
    //наименование контрагента
  //showmessage(Formsk.StringGrid1.Cells[2,Formsk.StringGrid1.Row]);
    Label44.Caption:=Formsk.StringGrid1.Cells[2,Formsk.StringGrid1.Row];

  //id редактируемого контрагента
    kontrID := trim(Formsk.StringGrid1.Cells[1,Formsk.StringGrid1.row]);
  //код 1с контрагента
    SpinEdit9.value := strToInt(Formsk.StringGrid1.Cells[4,Formsk.StringGrid1.row]);
    //showmessage(inttostr(strToInt(Formsk.StringGrid1.Cells[4,Formsk.StringGrid1.row])));
    SetLength(arV,0,0);
    ComboBox1.clear;

  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
//   *******************************************************************************************************
    // Запрос на множество видов договоров
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('Select kod1c, name FROM av_spr_kontr_viddog WHERE del=0 AND (trim(name)!='''') ORDER BY kod1c;');
   // showmessagealt(ZQuery1.SQL.Text);
    try
       ZQuery1.open;
    except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       ZQuery1.Close;
    end;
    If ZQuery1.RecordCount>0 then
    begin
     SetLength(arV,ZQuery1.RecordCount,2);
     FOR n:=0 to ZQuery1.RecordCount-1 do
     begin
        arV[n,0]:= trim(ZQuery1.FieldByName('kod1c').asString);
        arV[n,1]:= trim(ZQuery1.FieldByName('name').asString);
        ComboBox1.Items.Add(arV[n,0]+' | '+arV[n,1]);
        ZQuery1.next;
     end;
    end;
    //добавляем значения по умолчанию, если нет справочника
    If (ZQuery1.RecordCount=0) or (ComboBox1.Items.Count=0) then
    begin
      SetLength(arV,2,2);
        arV[0,0]:= '999';
        arV[0,1]:= 'Другой';
        ComboBox1.Items.Add(arV[0,0]+' | '+arV[0,1]);
        arV[1,0]:= '2';
        arV[1,1]:= 'Перевозка';
        ComboBox1.Items.Add(arV[1,0]+' | '+arV[1,1]);
     end;
    //   *******************************************************************************************************
  ComboBox1.ItemIndex:=1;

    ComboBox2.clear;
    ComboBox3.clear;
    ComboBox4.clear;
    ComboBox5.clear;
    ComboBox6.clear;
    ComboBox7.clear;
    ComboBox8.clear;
    ComboBox9.clear;
    ComboBox10.clear;
     // Запрос на множество единиц измерения
    //ZQuery1.SQL.clear;
    //ZQuery1.SQL.add('Select Distinct edizm1 as edizm FROM av_spr_kontr_dog where del=0 and edizm1<>'''';');
    //try
    //    ZQuery1.open;
    //except
    //   showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    //end;
    //If  ZQuery1.RecordCount>0 then
    //begin
    // FOR n:=1 to ZQuery1.RecordCount do
    // begin
    //      If trim(ZQuery1.FieldByName('edizm').asString)<>'' then
    //      begin
    //       ComboBox2.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //       ComboBox3.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //       ComboBox4.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //       ComboBox5.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //       ComboBox6.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //       ComboBox7.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //       ComboBox8.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //       ComboBox9.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //       ComboBox10.Items.Add(trim(ZQuery1.FieldByName('edizm').asString));
    //      end;
    //      ZQuery1.next;
    // end;
    //end;
      //добавляем значения по умолчанию, если нет справочника
    If (ComboBox2.Items.Count=0) then
    begin
        FOR n:=1 to 5 do
     begin
          case n of
           1: dzm:='руб';
           2: dzm:='%';
           3: dzm:='шт';
           4: dzm:='бил';
           5: dzm:='МРОТ';
           end;
           ComboBox2.Items.Add(dzm);
           ComboBox3.Items.Add(dzm);
           ComboBox4.Items.Add(dzm);
           ComboBox5.Items.Add(dzm);
           ComboBox6.Items.Add(dzm);
           ComboBox7.Items.Add(dzm);
           ComboBox8.Items.Add(dzm);
           ComboBox9.Items.Add(dzm);
           ComboBox10.Items.Add(dzm);
       end;
     end;
    Zquery1.Close;
    Zconnection1.disconnect;

    ComboBox2.ItemIndex:=0;
    ComboBox3.ItemIndex:=0;
    ComboBox4.ItemIndex:=0;
    ComboBox5.ItemIndex:=0;
    ComboBox6.ItemIndex:=0;
    ComboBox7.ItemIndex:=0;
    ComboBox8.ItemIndex:=0;
    ComboBox9.ItemIndex:=0;
    ComboBox10.ItemIndex:=0;


  // Режим редактирования
  if fl_edit_dog=2 then
  begin
   dogovorID:= Form23.Stringgrid1.Cells[0,Form23.Stringgrid1.Row];
   Edit1.Text:=dogovorID;//id
    If (Form23.StringGrid1.Cells[2,Form23.StringGrid1.row]='*') then
     begin
       PageControl1.ActivePageIndex:=1;
       //PageControl1.Pages[1].Enabled:=true;
       PageControl1.Pages[0].Enabled:=false;
     end
     else
      begin
       PageControl1.ActivePageIndex:=0;
       PageControl1.Pages[0].Enabled:=true;
       //PageControl1.Pages[1].Enabled:=false;
      end;
   RefreshKontr();   //вывести значения на форму
  end;

  end;


end.

