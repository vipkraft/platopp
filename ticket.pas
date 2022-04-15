unit ticket;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons, EditBtn, Strutils;

type

  { TFormAdd }

  TFormAdd = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    EditButton1: TEditButton;
    EditButton2: TEditButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    StaticText1: TStaticText;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton2ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RadioButton7Change(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ToggleBox2Change(Sender: TObject);
    procedure Combo6Update(); //обновить комбо с услугами
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormAdd: TFormAdd;



implementation

uses
  mainopp, platproc, tickettypes, shedule_main, kontr_main;



{$R *.lfm}

{ TFormAdd }


procedure TFormAdd.Combo6Update(); //обновить комбо с услугами
var
  n:integer;
begin
  with formAdd do
  begin
   ComboBox6.Clear;
   If Combobox5.Items[Combobox5.ItemIndex]='СПРАВКА' then
    begin
      Combobox6.Items.Add('УСТНАЯ');
      Combobox6.Items.Add('СТОИМОСТЬ ПРОЕЗДА');
      exit;
    end;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT * FROM av_spr_uslugi WHERE del=0 ORDER BY id;');
  try
  ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      Zconnection1.disconnect;
      ZQuery1.Close;
      exit;
  end;
  for n:=1 to ZQuery1.RecordCount do
     begin
       Combobox6.Items.Add(ZQuery1.FieldByName('name').AsString);
       ZQuery1.Next;
     end;

  ZQuery1.Close;
  ZConnection1.Disconnect;

  end;
end;


procedure TFormAdd.ComboBox2Change(Sender: TObject);
begin
  with FormAdd do
  begin
    Label1.Visible:=false;
    ToggleBox1.Visible:=false;
    ToggleBox2.Visible:=false;
    GroupBox1.Visible:=false;
    GroupBox2.Visible:=false;
    FOrmAdd.CheckBox1.Visible:=false;
    FOrmAdd.CheckBox2.Visible:=false;
   FOrmAdd.EditButton1.Visible:=false;
   FOrmAdd.EditButton2.Visible:=false;
   ToggleBox1.Checked:=false;
   ToggleBox2.Checked:=false;

  //определяем принадлежность шаблона пользователю
  tusr:=-1;
  If trim(FOrmAdd.ComboBox2.text)='' then exit;
  tusr:= FOrmAdd.ComboBox2.ItemIndex;
  //если агент, открываем далее
  If tusr=2 then
  begin
    BitBtn1.Enabled:=true;
    exit;
  end
  else
  begin
    BitBtn1.Enabled:=false;
    Label1.Visible:=true;
    ToggleBox1.Visible:=true;
    ToggleBox2.Visible:=true;
  end;
  end;
end;

//***************** ДАЛЕЕ************************
procedure TFormAdd.BitBtn1Click(Sender: TObject);
  function FindDuplicate(sname:string):integer;
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

 //Проверка на дубликат
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT id FROM av_tick_shablon WHERE del=0 AND name='+QuotedStr(sname)+' AND category='+QuotedStr(tcat)+' AND type_sale='+inttostr(ttype)+' AND usr_category='+inttostr(tusr)+';');
  //showmessage(ZQuery1.SQL.Text);//$
  //ZQuery1.SQL.Text;//$
  try
  ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      Zconnection1.disconnect;
      ZQuery1.Close;
      exit;
  end;
   result:=1;
  If ZQuery1.RecordCount>0 then
  //begin
    result:=0;
     Zconnection1.disconnect;
     ZQuery1.Close;
    end;
begin
  flname :=true;
  with formAdd do
  begin
   If RadioButton6.Checked then
  begin
   tname := ComboBox3.Text + IFTHEN(trim(EditButton1.Text)='','','/'+trim(EditButton1.Text)) + IFTHEN(trim(EditButton2.Text)='','','/'+trim(EditButton2.Text));
   tcat :=  ComboBox4.Text;
   end
   else
   begin
    tname := ComboBox5.Text + IFTHEN(trim(EditButton1.Text)='','','/'+trim(EditButton1.Text)) + IFTHEN(trim(EditButton2.Text)='','','/'+trim(EditButton2.Text));
    tcat :=  ComboBox6.Text;
   end;
  end;

  If tusr=2 then
   begin
    formAdd.Close;
    exit; //если выбран АГЕНТ - выход
   end;

  //end;
      If RadioButton6.Checked then
      begin
         If FindDuplicate(tname)=0 then
         begin
            showmessagealt('Сохранение невозможно ! Такой шаблон уже существует !');
            tname :='';
            exit;
          end;
       end;
      If RadioButton7.Checked then
      begin
           while FindDuplicate(tname)=0 do
            begin
            tname:= InputBox('Такой шаблон уже существует !','ВВЕДИТЕ ИМЯ ШАБЛОНА','');
        //until
            end;
        end;

  FormAdd.Close;
end;

procedure TFormAdd.BitBtn2Click(Sender: TObject);
begin
  formAdd.Close;
end;

procedure TFormAdd.CheckBox1Change(Sender: TObject);
begin
  If formAdd.CheckBox1.Checked then FormAdd.EditButton1.Enabled:=true else FormAdd.EditButton1.Enabled:=false;
end;

procedure TFormAdd.CheckBox2Change(Sender: TObject);
begin
   If formAdd.CheckBox2.Checked then FormAdd.EditButton2.Enabled:=true else FormAdd.EditButton2.Enabled:=false;
end;

procedure TFormAdd.ComboBox3Change(Sender: TObject);
begin
  FOrmAdd.GroupBox2.Visible:=false;
  FOrmAdd.BitBtn1.Enabled:=false;
  //определяем наименование шаблона
  If trim(FOrmAdd.ComboBox3.text)='' then exit;
  FOrmAdd.GroupBox2.Visible:=true;
  FormAdd.ComboBox4.ItemIndex:=0;
  FOrmAdd.BitBtn1.Enabled:=true;
  FOrmAdd.CheckBox1.Visible:=true;
  FOrmAdd.CheckBox2.Visible:=true;
  FOrmAdd.EditButton1.Visible:=true;
  FOrmAdd.EditButton2.Visible:=true;
end;

procedure TFormAdd.ComboBox4Change(Sender: TObject);
begin
  FOrmAdd.BitBtn1.Enabled:=false;
  //определяем категорию шаблона
  If trim(FOrmAdd.ComboBox4.text)='' then exit;
  FOrmAdd.CheckBox1.Visible:=true;
  FOrmAdd.CheckBox2.Visible:=true;
  FOrmAdd.EditButton1.Visible:=true;
  FOrmAdd.EditButton2.Visible:=true;
  FOrmAdd.BitBtn1.Enabled:=true;
end;

procedure TFormAdd.ComboBox5Change(Sender: TObject);
begin
  FOrmAdd.GroupBox2.Visible:=false;
  FOrmAdd.BitBtn1.Enabled:=false;
  //определяем наименование шаблона
 If trim(FOrmAdd.ComboBox5.text)='' then exit;
  FOrmAdd.GroupBox2.Visible:=true;
  FormAdd.ComboBox4.ItemIndex:=0;
  FOrmAdd.BitBtn1.Enabled:=true;
  FOrmAdd.GroupBox2.Visible:=true;
  Combo6Update();
end;

procedure TFormAdd.ComboBox6Change(Sender: TObject);
begin
  FOrmAdd.BitBtn1.Enabled:=false;
  //определяем категорию шаблона
  If trim(FOrmAdd.ComboBox6.text)='' then exit;
  FOrmAdd.CheckBox1.Visible:=true;
  FOrmAdd.CheckBox2.Visible:=true;
  FOrmAdd.EditButton1.Visible:=true;
  FOrmAdd.EditButton2.Visible:=true;
  FOrmAdd.BitBtn1.Enabled:=true;
end;


//********************* ВЫБРАТЬ ПЕРЕВОЗЧИКА **********************
procedure TFormAdd.EditButton1ButtonClick(Sender: TObject);
begin
  with formADD do
  begin
  //сбрасываем шаблон по расписанию
  nshedule :=0;
  sshedule :='';
  checkbox2.Checked:=false;
  editbutton2.Text:='';
  //сбрасываем переменные
  nkontr := 0;
  skontr := '';
     //Добавляем контрагента
    result_kontr_id:='';
    //showmessagealt('Выберите контрагента...');
    formsk:=Tformsk.create(self);
    formsk.ShowModal;
    FreeAndNil(formsk);
     if  trim(result_kontr_id)='' then exit;
       // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
      begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
      end;
     //запрос списка
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('SELECT id,name FROM av_spr_kontragent WHERE del=0 AND id='+result_kontr_id+';');
     try
      ZQuery1.open;
     except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
       //ZQuery1.Close;
       //Zconnection1.disconnect;
       //Close;
       exit;
     end;
     if ZQuery1.RecordCount=1 then
     begin
       skontr := ZQuery1.FieldByName('name').asString;
       nkontr := ZQuery1.FieldByName('id').asInteger;
       EditButton1.Text:= skontr;
     end;
     ZQuery1.Close;
     Zconnection1.disconnect;
  end;
end;

//**************************** ВЫБРАТЬ РАСПИСАНИЕ ***********************
procedure TFormAdd.EditButton2ButtonClick(Sender: TObject);
begin
  with formADD do
  begin

   result_name_shedule := '';
   nshedule :=  0;
   // showmessagealt('Выберите расписание...');
   form15:=Tform15.create(self);
   form15.ShowModal;
   FreeAndNil(form15);
   if (result_name_shedule='') then exit;
   try
   nshedule := strtoint(result_name_shedule);
   except
     showmessagealt('Ошибка конвертирования !');
     exit;
   end;
   sshedule := result_shedule;
   EditButton2.Text:= '['+result_name_shedule+']'+ sshedule;
  end;
end;

//*************************** ЗАКРЫТИЕ ФОРМЫ *********************************
procedure TFormAdd.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  If tusr=2 then exit;
  If (ttype=0) OR (tusr=-1) OR (trim(tname)='') then
   flname:=false;
end;

procedure TFormAdd.FormKeyDown(Sender: TObject; var Key: Word;    Shift: TShiftState);
begin
   with FormAdd do
  begin
     // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Далее'+#13+'[TAB] - Переход между пунктами'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    //F2 - Далее
    if (Key=113) and (bitbtn1.enabled=true) then bitbtn1.click;
    //ESC
    If (Key=27) then FormAdd.Close;

    if (Key=112) or (Key=113) or (Key=115) or (Key=116) or (Key=119) or (Key=27) then Key:=0;
  end;
end;


procedure TFormAdd.ToggleBox1Change(Sender: TObject);
begin
  ttype:=0;
  With FormADD do
  begin
   if ToggleBox1.Checked=true then
   begin
    ToggleBox2.Checked:=false;
   end
  else
   begin
    ToggleBox2.Checked:=true;
   end;
  //определить тип шаблона чека
  IF ToggleBox1.Checked then ttype:=1;
  IF ToggleBox2.Checked then ttype:=2;
   GroupBox1.Visible:=true;
   //GroupBox2.Visible:=true;
  end;
end;


procedure TFormAdd.ToggleBox2Change(Sender: TObject);
begin
  ttype:=0;
   With FormADD do
  begin
  if ToggleBox2.Checked=true then
   begin
    ToggleBox1.Checked:=false;
   end
  else
   begin
    ToggleBox1.Checked:=true;
   end;
  //определить тип шаблона чека
  IF ToggleBox1.Checked then ttype:=1;
  IF ToggleBox2.Checked then ttype:=2;
   GroupBox1.Visible:=true;
   //GroupBox2.Visible:=true;
  end;
end;

//*********************************************      ВОЗНИКНОВЕНИЕ ******************************************************************
procedure TFormAdd.FormShow(Sender: TObject);
var
  fl:boolean=false;
  n:integer=0;
begin
   with FormAdd do
  begin
  // Редактируем запись
  if Fl_Edit_TT=2 then
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
   //принадлежность пользователя
   ttype:=ZQuery1.FieldByName('type_sale').asInteger ;
   tname := trim(ZQuery1.FieldByName('name').asString);
   tcat := trim(ZQuery1.FieldByName('category').asString);
   tusr := ZQuery1.FieldByName('usr_category').AsInteger;

    //приводим комбо в соответсвтие принадлежностью пользователя
    Combobox2.ItemIndex:= tusr;

   //приводим комбо ТИПОВ билетов в соответсвтие с наименованием шаблона
   for n:=0 to ComboBox3.Items.Count-1 do
    begin
     ComboBox3.ItemIndex:=n;
     //showmessage(ComboBox3.text);
      If tname=trim(ComboBox3.text) then
        begin
          fl:=true;
          RadioButton6.Checked:=true;
          break;
        end;
    end;
   if not fl then
     begin
      Combobox3.ItemIndex:=-1;
         for n:=0 to ComboBox5.Items.Count-1 do
            begin
             ComboBox5.ItemIndex:=n;
             If tname=trim(ComboBox5.text) then
               begin
               fl:=true;
               RadioButton7.Checked:=true;
               break;
               end;
            end;
     end;
   If not fl then
     begin
      Combobox5.ItemIndex:=-1;
        showmessagealt('Имя шаблона не соответствует возможным значениям !');
        Combobox3.Text:=tname;
     end;
    //приводим комбо в соответсвтие с категорией шаблона
    fl:=false;
   for n:=0 to ComboBox4.Items.Count-1 do
    begin
     ComboBox4.ItemIndex:=n;
     //showmessage(ComboBox3.text);
      If tcat=trim(ComboBox4.text) then
        begin
          fl:=true;
          break;
        end;
    end;
   if not fl then
     begin
      Combobox4.ItemIndex:=-1;
       Combo6update();
         for n:=0 to ComboBox6.Items.Count-1 do
            begin
             ComboBox6.ItemIndex:=n;
             If tcat=trim(ComboBox6.text) then
               begin
               fl:=true;
               break;
               end;
            end;
     end;
   If not fl then
     begin
      Combobox6.ItemIndex:=-1;
        showmessagealt('Категория шаблона не соответствует возможным значениям !');
        Combobox4.Text := tcat;
     end;
   ZQuery1.Close;
   Zconnection1.disconnect;

   Label1.Visible:=true;
   ToggleBox1.Visible:=true;
   ToggleBox2.Visible:=true;
   GroupBox1.Visible:=true;
   GroupBox2.Visible:=true;
   FOrmAdd.CheckBox1.Visible:=true;
   FOrmAdd.CheckBox2.Visible:=true;
   FOrmAdd.EditButton1.Visible:=true;
   FOrmAdd.EditButton2.Visible:=true;
   Bitbtn1.Enabled:=true;
   end;
  end;
end;

procedure TFormAdd.RadioButton7Change(Sender: TObject);
begin
  with FormAdd do
  begin
   if RadioButton6.Checked=true then
    begin
     ComboBox3.Enabled:=true;
     ComboBox4.Enabled:=true;
     ComboBox5.Enabled:=false;
     ComboBox6.Enabled:=false;
    end
  else
    begin
     ComboBox3.Enabled:=false;
     ComboBox4.Enabled:=false;
     ComboBox5.Enabled:=true;
     ComboBox6.Enabled:=true;
    end;
  end;
end;



end.

