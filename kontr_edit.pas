unit kontr_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls, EditBtn,platproc, ZConnection, LazUtf8, ZDataset;

type

  { TForm20 }

  TForm20 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn7: TBitBtn;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox1: TGroupBox;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Splitter1: TSplitter;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RefreshKontr(); //Обновить инфу по контрагенту на форме
    procedure CountryLoad();//загрузка данных стран на форму
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form20: TForm20;
  vibor:byte;

implementation
 uses
   mainopp,kontr_main,kontr1c;
{$R *.lfm}
var
  type_read:byte;
  new_id:integer;
  id_kontr : string;
 fl_fio:boolean;

{ TForm20 }


//******************************** //загрузить страны в комбик *****************************************
 procedure TForm20.CountryLoad();
 var
  n:integer;
begin
   with Form20 do
    begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('(Select id,short_name from av_country WHERE short_name like ''%РОССИ%'')');
    ZQuery1.SQL.add('UNION ALL');
    ZQuery1.SQL.add('(Select id,short_name from av_country order by short_name ASC); ');
     //showmessage(ZQuery1.SQL.Text);
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
      exit;
    end;
    If ZQuery1.RecordCount=0 then
    begin
     ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
    end;
     COmboBox1.Clear;
    for n:=0 to ZQuery1.RecordCount-1 do
      begin
       Combobox1.Items.Add(padl(ZQuery1.FieldByName('id').asString,#32,4)+'| '+ZQuery1.FieldByName('short_name').asString);
       ZQuery1.Next;
      end;
     COmboBox1.ItemIndex:=0;
    ZQuery1.Close;
    Zconnection1.disconnect;
    end;
end;

//******************************** //Обновить инфу по контрагенту на форме *****************************************
 procedure TForm20.RefreshKontr();
 var
  strana, n:integer;
begin
   with Form20 do
    begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   //
   // Запрос на редактируюмую запись
    ZQuery1.SQL.clear;
    ZQuery1.SQL.add('Select a.* ');
    ZQuery1.SQL.add(',(select egisid from av_spr_kontr_fio where del=0 and a.id=id_kontr order by createdate desc limit 1) egisid ');
    ZQuery1.SQL.add(',(select ogrnip from av_spr_kontr_fio where del=0 and a.id=id_kontr order by createdate desc limit 1) egrip ');
    ZQuery1.SQL.add(',(select ogrn from av_spr_kontr_fio where del=0 and a.id=id_kontr order by createdate desc limit 1) egrul ');
    ZQuery1.SQL.add(',(Select send_flag from av_spr_kontr_fio where del=0 and a.id=id_kontr order by createdate desc limit 1) sendflag ');
    ZQuery1.SQL.add('FROM av_spr_kontragent a where a.id='+id_kontr+' and a.del=0 order by a.createdate desc limit 1');
     //showmessage(ZQuery1.SQL.Text);
    try
      ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
      exit;
    end;
    If ZQuery1.RecordCount=1 then
    begin
      //ВЫВОДИМ УЖЕ ИЗВЕСТНЫЕ ДАННЫЕ
      Edit2.Text:=ZQuery1.FieldByName('name').asString;//наименование
      Edit3.Text:=ZQuery1.FieldByName('polname').asString;//полное имя
      Edit7.Text:=ZQuery1.FieldByName('kod1c').asString;//код 1с
      Edit5.Text:=ZQuery1.FieldByName('vidkontr').asString;//тип
      Edit8.Text:=ZQuery1.FieldByName('inn').asString;//инн
      Edit9.Text:=ZQuery1.FieldByName('okpo').asString;//окпо
      Edit4.Text:=ZQuery1.FieldByName('adrur').asString;//адрес юридический
      Edit10.Text:=ZQuery1.FieldByName('tel').asString;//телефон
      Memo1.Text:=ZQuery1.FieldByName('document').asString;//документ


      Edit11.Text:=ZQuery1.FieldByName('egisid').asString;
      Edit12.Text:=ZQuery1.FieldByName('egrip').asString;
      Edit13.Text:=ZQuery1.FieldByName('egrul').asString;
     If ZQuery1.FieldByName('sendflag').asINteger=1 then Checkbox1.Checked:=true else Checkbox1.Checked:=false;

     If (Utf8length(ZQuery1.FieldByName('adrpos').asString)<8) and (trim(ZQuery1.FieldByName('adrpos').asString)<>'') then
     begin
     try
       strana:=strtoint(ZQuery1.FieldByName('adrpos').asString);
     except
        on exception: EConvertError do
           begin
             strana:=0
           end;
     end;
     end
     else
       strana:=0;

    ZQuery1.Close;
    Zconnection1.disconnect;

   If strana=0 then
   begin
   Combobox1.ItemIndex:=0;
   end;
   for n:=0 to Combobox1.Items.Count-1 do
     begin
       If trim(utf8copy(Combobox1.Items[n],1,utf8pos('|',Combobox1.Items[n])-1))=inttostr(strana) then
       begin
         Combobox1.ItemIndex:=n;
       break;
       end;
     end;
   //Combobox1.ItemIndex:=strana;
   //tmp_id :=  ZQuery1.FieldByName('id_user').asString; //id_user
    end;


    end;
end;

//***********************************************  ОТМЕНА *******************************************
procedure TForm20.BitBtn4Click(Sender: TObject);
begin
  Form20.close;
end;

procedure TForm20.BitBtn1Click(Sender: TObject);
begin
  type_read:=2;
 { form7:=Tform7.create(self);
  form7.ShowModal;
  FreeAndNil(form7);
  if not(result_name_full='') then Form20.edit3.Text:=result_name_full;
  }
end;

procedure TForm20.BitBtn2Click(Sender: TObject);
begin
  type_read:=3;
 { form7:=Tform7.create(self);
  form7.ShowModal;
  FreeAndNil(form7);
  if not(result_name_full='') then Form20.edit4.Text:=result_name_full;
  }
end;


//**********************************************  ОКРЫТИЕ ФОРМЫ КОНТРАГЕНТЫ 1С *************************************
procedure TForm20.BitBtn7Click(Sender: TObject);
begin
  //Обнуляем флаг выбора
  vibor := 0;
  Form21:=TForm21.create(self);
  Form21.ShowModal;
  FreeAndNil(Form21);
  //Если ничего не выбрано
    If vibor=0 then exit;
  //ВЫВОДИМ  ДАННЫЕ ИЗ 1С
  //RefreshKontr();

end;

procedure TForm20.CheckBox1Change(Sender: TObject);
begin
  fl_fio:=true;
end;


//вывести инфу о создании и редактировании записи
procedure TForm20.Edit2Enter(Sender: TObject);
begin
    //if fl_edit_kontr=2 then    ShowEditLog(Form20, Form20.Panel1, Form20.ZQuery1, Form20.ZConnection1,'av_spr_kontragent',id_kontr,1);
end;




//***********************************************  СОХРАНИТЬ ************************************************************************
procedure TForm20.BitBtn3Click(Sender: TObject);
var
  new_id: integer;
begin
  with Form20 do
  begin
  //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if (trim(Edit2.text)='') then
   begin
     showmessagealt('Сначала заполните поле ИМЯ КОТРАГЕНТА !!!');
     exit;
   end;
  if (trim(Edit3.text)='') then
   begin
     showmessagealt('Сначала заполните поле ПОЛНОЕ ИМЯ КОТРАГЕНТА !!!');
     exit;
   end;
  if (trim(Edit4.text)='') then
   begin
     showmessagealt('Сначала заполните поле АДРЕС КОТРАГЕНТА !!!');
     exit;
   end;
  if (trim(Edit8.text)='') then
   begin
     showmessagealt('Сначала заполните поле ИНН КОТРАГЕНТА !!!');
     exit;
   end;
  If Checkbox1.Checked then
   begin
     If (trim(Edit11.Text)='') and (trim(Edit12.Text)='') and (trim(Edit13.Text)='') then
      begin
         showmessagealt('Заполните обязательные поля '+#13+'для передачи данных !');
      exit;
      end;
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

  //режим редактирования
  if fl_edit_kontr=2 then
      begin
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_spr_kontragent SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+id_kontr+' and del=0;');
       ZQuery1.ExecSQL;
    //If fl_fio then
       //begin
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_spr_kontr_fio SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_kontr='+id_kontr+' and del=0;');
       ZQuery1.ExecSQL;
      //end;
      //создание записи
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('INSERT INTO av_spr_kontragent(id,createdate,del,id_user,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,createdate_first,id_user_first) VALUES (');
       ZQuery1.SQL.add(trim(Edit1.text)+',DEFAULT,0,'+inttostr(id_user)+','+QuotedSTR(trim(Edit2.text))+','+QuotedSTR(trim(Edit3.text))+','+(trim(Edit7.text))+',');
       ZQuery1.SQL.add(QuotedSTR(trim(Edit5.text))+','+QuotedSTR(trim(Edit8.text))+','+QuotedSTR(trim(Edit9.text))+','+QuotedSTR(trim(Edit4.text))+',');
       ZQuery1.SQL.add(QuotedSTR(trim(utf8copy(Combobox1.text,1,utf8pos('|',Combobox1.text)-1)))+','+QuotedSTR(trim(Edit10.text))+','+QuotedSTR(trim(Memo1.text))+',NULL,NULL);');
         //showmessage(ZQuery1.SQL.Text);//&
       ZQuery1.ExecSQL;
     end;

  //режим добавления
  if fl_edit_kontr=1 then
      begin
  //Определяем текущий id+1
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_kontragent;');
        ZQuery1.open;
        new_id:=ZQuery1.FieldByName('new_id').asInteger+1;
        Edit1.Text:=IntToStr(new_id);
        //создание записи
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('INSERT INTO av_spr_kontragent(id,createdate,del,id_user,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,createdate_first,id_user_first) VALUES (');
       ZQuery1.SQL.add(inttostr(new_id)+',DEFAULT,0,'+inttostr(id_user)+','+QuotedSTR(trim(Edit2.text))+','+QuotedSTR(trim(Edit3.text))+','+(trim(Edit7.text))+',');
       ZQuery1.SQL.add(QuotedSTR(trim(Edit5.text))+','+QuotedSTR(trim(Edit8.text))+','+QuotedSTR(trim(Edit9.text))+','+QuotedSTR(trim(Edit4.text))+',');
       ZQuery1.SQL.add(QuotedSTR(trim(utf8copy(Combobox1.text,1,utf8pos('|',Combobox1.text)-1)))+','+QuotedSTR(trim(Edit10.text))+','+QuotedSTR(trim(Memo1.text))+',now(),'+inttostr(id_user)+');');
      //showmessage(ZQuery1.SQL.Text);//&
       ZQuery1.ExecSQL;
    end;
  //добавить запись если есть договор по передаче данных ПДП
  //If fl_fio and checkbox1.Checked then
     begin
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('INSERT INTO av_spr_kontr_fio(id_kontr,createdate,del,id_user,createdate_first,id_user_first,ogrn,ogrnip,egisid,send_flag) VALUES (');
       ZQuery1.SQL.add(trim(Edit1.text)+',DEFAULT,0,'+inttostr(id_user)+',NULL,NULL,'+quotedstr(Edit13.text)+','+quotedstr(Edit12.text)+','+quotedstr(Edit11.text)+',');
       If checkbox1.Checked then ZQuery1.SQL.add('1);') else ZQuery1.SQL.add('0);');
       ZQuery1.ExecSQL;
     end;
  // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  Close;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
 fl_fio:=false;
 end;
end;


//**************************************  ОБРАБОТЧИК НАЖАТИЯ КЛАВИШИ *******************************************
procedure TForm20.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState  );
begin
     // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'F9 - Выбор из другого источника'+#13+'[ESC] - Отмена\Выход');
    // F2 - Сохранить
    if (Key=113) and (Form20.BitBtn3.Enabled=true) then Form20.BitBtn3.Click;
   { //F3 - ATC
    if (Key=114) and (bitbtn6.enabled=true) then  bitbtn6.click;
    //F4 - Изменить
    if (Key=115) and (bitbtn12.enabled=true) then  BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (bitbtn1.enabled=true) then  BitBtn1.Click;
    //F8 - Удалить
    if (Key=119) and (bitbtn2.enabled=true) then  BitBtn2.Click;
    }
    // F9 - Другой источник
    if (Key=120) and (Form20.BitBtn7.Enabled=true) then Form20.BitBtn7.Click;
    // ESC
    if Key=27 then Form20.Close;

   if (Key=112) or (Key=113) or (Key=27) then Key:=0;

end;

procedure TForm20.FormShow(Sender: TObject);
  var
   tmp_id, tmp_id_first: string;
begin
  Centrform(Form20);
  fl_fio:=false;
   CountryLoad();
  with Form20 do
  begin

  // Режим редактирования
  if fl_edit_kontr=2 then
   begin
    //id редактируемого контрагента
    id_kontr := trim(Formsk.StringGrid1.Cells[1,Formsk.StringGrid1.row]);
    Edit1.Text:= id_kontr;//id
    RefreshKontr();
    //ShowEditLog(Form20, Form20.Panel1, Form20.ZQuery1, Form20.ZConnection1,'av_spr_kontragent',id_kontr,1);
   end
  else
    Edit7.Text:='0';
  end;

end;





end.

