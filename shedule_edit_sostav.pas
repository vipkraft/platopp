unit shedule_edit_sostav;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Spin, EditBtn, shedule_path;


type

  { TForm22 }

  TForm22 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label31: TLabel;
    SpinEdit9: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
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
    Label19: TLabel;
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
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape15: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    SpinEdit1: TSpinEdit;
    SpinEdit10: TSpinEdit;
    SpinEdit11: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    SpinEdit8: TSpinEdit;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit7EditingDone(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure check_param(); // Расчет параметров отправления,прибытия и т.д.
    procedure SpinEdit10Change(Sender: TObject);
    procedure SpinEdit11Change(Sender: TObject);
    procedure SpinEdit7Change(Sender: TObject);
    procedure SpinEdit8Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form22: TForm22; 

implementation
uses
  mainopp,platproc,point_main,shedule_edit;
{$R *.lfm}

var
   first_point:byte=0;
{ TForm22 }

// Расчет параметров отправления,прибытия и т.д.
procedure TForm22.check_param();
   var
     otpr_h,otpr_m,shift_time:integer;
begin
  //если режим добавления
  if flag_edit_sostav=1 then
   begin
     If (form16.StringGrid1.RowCount<2) then exit; //*если первый остановчный - выход

    // Смещение во времени +-
   if not(trim(form22.Edit7.Text)='0') and not(trim(form22.Edit5.text)='') then
     begin
     try
       shift_time:=strtoint(copy(m_sostav[Length(m_sostav)-1,5],1,2))+(strtoint(form22.Edit7.Text));
     except
        on exception: EConvertError do
           begin
             showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x01');
             exit;
           end;
     end;
     //showmessage(inttostr(shift_time));
       if shift_time<0 then shift_time:=24+shift_time;
       if shift_time=24 then shift_time:=0;
       if shift_time>24 then shift_time:=shift_time mod 24;
       otpr_h:=shift_time+form22.SpinEdit10.Value;  //Время отправления из предыдущего пункта-часы + часы в пути
       try
       otpr_m:=strtoint(copy(m_sostav[Length(m_sostav)-1,5],4,2))+form22.SpinEdit11.Value;   //Время отправления из предыдущего пункта-минуты + минуты в пути
       except
          on exception: EConvertError do
           begin
             showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x02');
               exit;
             end;
          end;
       //m_sostav[Length(m_sostav)-1,5]:=padl(trim(inttostr(shift_time)),'0',2)+':'+copy(m_sostav[Length(m_sostav)-1,5],4,2);
     end
   else
     begin
      //Расчет времени прибытия
         If trim(m_sostav[Length(m_sostav)-1,5])='' then
           begin
             otpr_h:=form22.SpinEdit10.Value;  //Время отправления из предыдущего пункта-часы + часы в пути
             otpr_m:=form22.SpinEdit11.Value;   //Время отправления из предыдущего пункта-минуты + минуты в пути
           end
         else
         begin
         try
         otpr_h:=strtoint(copy(m_sostav[Length(m_sostav)-1,5],1,2))+form22.SpinEdit10.Value;  //Время отправления из предыдущего пункта-часы + часы в пути
         otpr_m:=strtoint(copy(m_sostav[Length(m_sostav)-1,5],4,2))+form22.SpinEdit11.Value;   //Время отправления из предыдущего пункта-минуты + минуты в пути
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x03');
               exit;
             end;
          end;
         end;
     end;
   end;
  //если режим редактирования
  if flag_edit_sostav=2 then
   begin
    If (form16.StringGrid1.Row=1) then exit;//*если первый - выход
    // Смещение во времени +-
   if not(trim(form22.Edit7.Text)='0') and not(trim(form22.Edit5.text)='') then
     begin
     try
       shift_time:=strtoint(copy(m_sostav[form16.StringGrid1.row-1,5],1,2))+(strtoint(form22.Edit7.Text));
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x04');
               exit;
             end;
          end;
       //showmessage(inttostr(shift_time));
       if shift_time<0 then shift_time:=24+shift_time;
       if shift_time=24 then shift_time:=0;
       if shift_time>24 then shift_time:=shift_time mod 24;

       otpr_h:=shift_time+form22.SpinEdit10.Value;  //Время отправления из предыдущего пункта-часы + часы в пути
       try
       otpr_m:=strtoint(copy(m_sostav[form16.StringGrid1.row-1,5],4,2))+form22.SpinEdit11.Value;   //Время отправления из предыдущего пункта-минуты + минуты в пути
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x05');
               exit;
             end;
          end;
       //m_sostav[Length(m_sostav)-1,5]:=padl(trim(inttostr(shift_time)),'0',2)+':'+copy(m_sostav[Length(m_sostav)-1,5],4,2);
     end
   else
     begin
      //Расчет времени прибытия
       try
      otpr_h:=strtoint(copy(m_sostav[form16.StringGrid1.row-1,5],1,2))+form22.SpinEdit10.Value;  //Время отправления из предыдущего пункта-часы + часы в пути
      otpr_m:=strtoint(copy(m_sostav[form16.StringGrid1.row-1,5],4,2))+form22.SpinEdit11.Value;   //Время отправления из предыдущего пункта-минуты + минуты в пути
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x06');
               exit;
             end;
          end;
     end;
   end;

   if otpr_m>59 then
      begin
        otpr_h:=otpr_h+(otpr_m div 60);
        otpr_m:=otpr_m mod 60;
      end;
   if otpr_h>24 then
      begin
        form22.SpinEdit5.Value:=otpr_h mod 24;
      end
   else
      begin
       form22.SpinEdit5.Value:=otpr_h;
      end;
   if otpr_h=24 then form22.SpinEdit5.Value:=0;
   form22.SpinEdit6.Value:=otpr_m; //минуты

   //Расчет времени отправления
   otpr_h:=form22.SpinEdit5.Value+form22.SpinEdit7.Value;  //Время прибытия-часы + часы стоянка
   otpr_m:=form22.SpinEdit6.Value+form22.SpinEdit8.Value;   //Время прибытия-минуты + минуты стоянка
   if otpr_m>59 then
      begin
        otpr_h:=otpr_h+(otpr_m div 60);
        otpr_m:=otpr_m mod 60;
      end;
   if otpr_h>24 then
      begin
        form22.SpinEdit3.Value:=otpr_h mod 24;
      end
   else
      begin
       form22.SpinEdit3.Value:=otpr_h;
      end;
   if otpr_h=24 then form22.SpinEdit3.Value:=0;
   form22.SpinEdit4.Value:=otpr_m; //минуты
end;

procedure TForm22.SpinEdit10Change(Sender: TObject);
begin
  form22.check_param();
end;

procedure TForm22.SpinEdit11Change(Sender: TObject);
begin
   form22.check_param();
end;

procedure TForm22.SpinEdit7Change(Sender: TObject);
begin
   form22.check_param();
end;

procedure TForm22.SpinEdit8Change(Sender: TObject);
begin
   form22.check_param();
end;

procedure TForm22.BitBtn1Click(Sender: TObject);
begin
  //type_read:=1;

  form9:=Tform9.create(self);
  form9.ShowModal;
  FreeAndNil(form9);
  //Добавляем остановочный пункт
  if not(result_point_id='') then
   begin
     With Form22 do
     begin
      //изменился пункт
        if form22.edit2.Text<>result_point_id then
           flcritical:=true;

          form22.edit2.Text:=result_point_id;
       // Определяем наименование остановочного пункта
       // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
          // Определяем данные
          form22.ZQuery1.SQL.clear;
          form22.ZQuery1.SQL.add('select id,name,timering from av_spr_point where id='+trim(result_point_id)+' and del=0;');
          form22.ZQuery1.open;
          if form22.ZQuery1.RecordCount<1 then
            begin
             form22.ZQuery1.Close;
             form22.Zconnection1.disconnect;
             exit;
            end;
          form22.Edit7.Text:=trim(inttostr(form22.ZQuery1.FieldByName('timering').asInteger));
          try
          if strtoint(form22.Edit7.text)>0 then form22.Edit7.text:='+'+form22.Edit7.text;
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x07');
               exit;
             end;
          end;
          form22.Edit1.Text:=trim(form22.ZQuery1.FieldByName('name').asString);
          form22.ZQuery1.Close;
          form22.Zconnection1.disconnect;
     end;
   end;
end;

//***********************-*************************     СОХРАНИТЬ  ********************************************
procedure TForm22.BitBtn3Click(Sender: TObject);
var
  m,n:integer;
begin
  if form22.GroupBox1.Enabled=false then
    begin
     showmessagealt('Сохранение невозможно !'+#13+'Запонены не все обязательные поля.');
     exit;
    end;
  // Проверка на нормативную скорость
  if (form22.GroupBox3.Enabled=true) and (Form16.StringGrid1.Row>1) then
    begin
     if (form22.SpinEdit9.Value=0) or ((form22.SpinEdit10.Value=0) and (form22.SpinEdit11.Value=0)) then
        begin
          showmessagealt('Расстояние и/или время в пути не может быть нулевым !'+#13+'Запонены не все обязательные поля.');
          exit;
        end;
     if norma_kmh>0 then
        begin
         if round(form22.SpinEdit9.value/(form22.SpinEdit10.value*60+form22.SpinEdit11.value)*60)>norma_kmh then
            begin
              showmessagealt('СКОРОСТЬ движения на данном участке пути НЕДОПУСТИМА !'+#13+'Текущая скорость движения: '
                +floattostr(round(form22.SpinEdit9.value/(form22.SpinEdit10.value*60+form22.SpinEdit11.value)*60))+' км\ч.'+#13+'Нормативная скорость: '+ intToStr(norma_kmh) +' км\ч.');
              exit;
            end;
        end;
    end;

  //Проверка на нулевую остановку если не первый в составе
  If (Form16.StringGrid1.Row>1) AND (form22.CheckBox3.Checked=false) AND (form22.SpinEdit7.Value=0) AND (form22.SpinEdit8.Value=0) then
     begin
      //showmessagealt('Нулевое время стоянки !'+#13+'Если это последний пункт, отметье соответствующий флажок.');
      If dialogs.MessageDlg('В Н И М А Н И Е !'+#13+'Нулевое время стоянки !'+#13+'Если это последний пункт,'+#13+'отметье соответствующий флажок'+#13+'ВСЕ РАВНО ПРОДОЛЖИТЬ ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
      exit;
     end;

   //Проверяем обязательные данные
           if (trim(form22.Edit2.text)='') or
              (trim(form22.Edit1.text)='') then
              begin
                showmessagealt('Введите наименование остановочного пункта !'+#13+'Сохранение невозможно !');
                exit;
              end;

  // Сохраняем изменения в массиве - НОВАЯ ЗАПИСЬ
  if flag_edit_sostav=1 then
       begin
           SetLength(m_sostav,Length(m_sostav)+1,sostav_size);
           m_sostav[Length(m_sostav)-1,0]:=trim(form22.Edit2.text);  //код остановочного пункта
           m_sostav[Length(m_sostav)-1,1]:=trim(form22.Edit1.text);  //Наименование остановочного пункта
           if form22.CheckBox1.Checked then m_sostav[Length(m_sostav)-1,2]:='1' else m_sostav[Length(m_sostav)-1,2]:='0'; //Формирующийся
           m_sostav[Length(m_sostav)-1,3]:=inttostr(form22.SpinEdit2.value); //Платформа отправления
           m_sostav[Length(m_sostav)-1,4]:=inttostr(form22.SpinEdit1.value); //Платформа прибытия
           m_sostav[Length(m_sostav)-1,5]:=padl(inttostr(form22.SpinEdit3.value),'0',2)+':'+padl(inttostr(form22.SpinEdit4.value),'0',2); //Время отправления
             //если последний пункт
           If (form22.CheckBox3.Checked=true) then
              begin
                  m_sostav[Length(m_sostav)-1,6]:='00:00';  //Время прибытия
                  m_sostav[Length(m_sostav)-1,7]:='00:00';  //Время стоянки
              end
           else
            begin
              m_sostav[Length(m_sostav)-1,6]:=padl(inttostr(form22.SpinEdit5.value),'0',2)+':'+padl(inttostr(form22.SpinEdit6.value),'0',2); //Время прибытия
              m_sostav[Length(m_sostav)-1,7]:=padl(inttostr(form22.SpinEdit7.value),'0',2)+':'+padl(inttostr(form22.SpinEdit8.value),'0',2); //Время стоянки
            end;
           m_sostav[Length(m_sostav)-1,8]:=floattostr(form22.SpinEdit9.value); //Расстояние
           m_sostav[Length(m_sostav)-1,9]:=padl(inttostr(form22.SpinEdit10.value),'0',2)+':'+padl(inttostr(form22.SpinEdit11.value),'0',2); //Время в пути
           if (form22.SpinEdit9.Value=0) then      //Скорость нормативная
              begin
               m_sostav[Length(m_sostav)-1,10]:=intToStr(norma_kmh);
              end;
           if form22.SpinEdit9.Value>0 then
              begin
               m_sostav[Length(m_sostav)-1,10]:=floattostr(round(form22.SpinEdit9.value/(form22.SpinEdit10.value*60+form22.SpinEdit11.value)*60));
              end;
           m_sostav[Length(m_sostav)-1,11]:='0';

           // Смещение часового пояса
           m_sostav[Length(m_sostav)-1,12]:=trim(form22.Edit7.Text);

           // Точка возврата
           if form22.CheckBox2.Checked then m_sostav[Length(m_sostav)-1,13]:='1' else m_sostav[Length(m_sostav)-1,13]:='0';

       end;


  // Сохраняем изменения в массиве - РЕДАКТИРУЕМАЯ ЗАПИСЬ
  if flag_edit_sostav=2 then
       begin
           //Проверяем обязательные данные
           if (form16.StringGrid1.Row>1) AND (form22.SpinEdit9.Value=0) then
              begin
                showmessagealt('Введите расстояние между пунктами !'+#13+'Сохранение невозможно !');
                exit;
              end;
           m_sostav[form16.StringGrid1.row,0]:=trim(form22.Edit2.text); //код остановочного пункта
           m_sostav[form16.StringGrid1.row,1]:=trim(form22.Edit1.text); //Наименование остановочного пункта
           if form22.CheckBox1.Checked then m_sostav[form16.StringGrid1.row,2]:='1' else m_sostav[form16.StringGrid1.row,2]:='0'; //Формирующийся
           m_sostav[form16.StringGrid1.row,3]:=inttostr(form22.SpinEdit2.value); //Платформа отправления
           m_sostav[form16.StringGrid1.row,4]:=inttostr(form22.SpinEdit1.value); //Платформа прибытия
           m_sostav[form16.StringGrid1.row,5]:=PAdl(inttostr(form22.SpinEdit3.value),'0',2)+':'+padl(inttostr(form22.SpinEdit4.value),'0',2); //Время отправления
            //если последний пункт
           If (form22.CheckBox3.Checked=true) then
              begin
                  m_sostav[form16.StringGrid1.row,6]:='00:00';  //Время прибытия
                  m_sostav[form16.StringGrid1.row,7]:='00:00'; //Время стоянки
              end
           else
            begin
              m_sostav[form16.StringGrid1.row,6]:=padl(inttostr(form22.SpinEdit5.value),'0',2)+':'+padl(inttostr(form22.SpinEdit6.value),'0',2); //Время прибытия
              m_sostav[form16.StringGrid1.row,7]:=padl(inttostr(form22.SpinEdit7.value),'0',2)+':'+padl(inttostr(form22.SpinEdit8.value),'0',2); //Время стоянки
            end;

           m_sostav[form16.StringGrid1.row,8]:=floattostr(form22.SpinEdit9.value); //Расстояние
           m_sostav[form16.StringGrid1.row,9]:=padl(inttostr(form22.SpinEdit10.value),'0',2)+':'+padl(inttostr(form22.SpinEdit11.value),'0',2); //Время в пути
           // Смещение часового пояса
           m_sostav[form16.StringGrid1.row,12]:=trim(form22.Edit7.Text);
           // Точка возврата
           if form22.CheckBox2.Checked then m_sostav[form16.StringGrid1.row,13]:='1' else m_sostav[form16.StringGrid1.row,13]:='0';
       end;
  form22.Close;
end;

procedure TForm22.BitBtn4Click(Sender: TObject);
begin
  form22.Close;
end;

procedure TForm22.BitBtn5Click(Sender: TObject);
begin
  //Редактируем нормативы расстояний
  formpath:=Tformpath.create(self);
  formpath.ShowModal;
  FreeAndNil(formpath);
  With Form22 do
  begin
  // Используем новый норматив по умолчанию
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
     //Делаем запрос к справочнику расстояний
     form22.ZQuery1.SQL.Clear;
     form22.ZQuery1.SQL.add('select * from av_spr_path where ((id1='+trim(form22.Edit5.text)+' and id2='+trim(form22.Edit6.text)+') or (id1='+trim(form22.Edit6.text)+' and id2='+trim(form22.Edit5.text)+')) and del=0;');
     try
      ZQuery1.open;
   except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
   end;
     if form22.ZQuery1.RecordCount=0 then
         begin
            form22.ZQuery1.close;
            form22.ZConnection1.disconnect;
            form22.StaticText1.Visible:=true;
            form22.Image4.Visible:=true;
            exit;
         end;
     // Заполняем поля данными на форме
     form22.SpinEdit9.Value:=form22.ZQuery1.FieldByName('km').asFloat; // km
     try
     form22.SpinEdit10.Value:=strtoint(copy(trim(form22.ZQuery1.FieldByName('path_time').asString),1,2)); // hour
     form22.SpinEdit11.Value:=strtoint(copy(trim(form22.ZQuery1.FieldByName('path_time').asString),4,2)); // min
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x08');
               exit;
             end;
          end;
     // Новая нормативная скорость
     m_sostav[form16.StringGrid1.row,10]:=floattostr(round(form22.SpinEdit9.value/(form22.SpinEdit10.value*60+form22.SpinEdit11.value)*60));
     form22.StaticText1.Visible:=false;
     form22.Image4.Visible:=false;
     form22.ZQuery1.close;
     form22.ZConnection1.disconnect;
     form22.check_param();
    end;
end;

procedure TForm22.CheckBox1Change(Sender: TObject);
begin
  flcritical:=true;
end;

procedure TForm22.CheckBox2Change(Sender: TObject);
begin
  flcritical:=true;
end;

//************************* ПОСЛЕДНИЙ ПУНКТ В СОСТАВЕ ****************************
procedure TForm22.CheckBox3Change(Sender: TObject);
begin
  flcritical:=true;
  //If flag_edit_sostav=2 then exit;
  //если последний пункт ставим флаг последнего пункта в составе
            if  form22.CheckBox3.Checked=true  then
              begin
                form22.SpinEdit3.value := 0;
                form22.SpinEdit4.value := 0;
                form22.SpinEdit7.value := 0;
                form22.SpinEdit8.value := 0;
              end;
end;


procedure TForm22.Edit1Change(Sender: TObject);
begin
    With Form22 do
    begin
    // Если добавляем или редактируем следующий
    If ((flag_edit_sostav=1) and (form16.StringGrid1.RowCount>1)) or
       ((flag_edit_sostav=2) and (form16.StringGrid1.Row>1)) then
       begin
        // Проверяем предыдущий пункт на совпадение текущему
           if trim(form22.edit2.text)=trim(form22.edit5.text) then
              begin
                 // Отключаем все кроме выбора  ост.пункта
                 form22.GroupBox1.Enabled:=false;
                 form22.GroupBox2.Enabled:=false;
                 form22.GroupBox3.Enabled:=false;
                 form22.CheckBox1.Enabled:=false;
                 form22.CheckBox2.Enabled:=false;
                 //form22.edit1.text:='';
                 //form22.edit2.text:='';
                 showmessagealt('Новый остановочный пункт совпадает с предыдущим'+#13+'в составе расписания.'+#13+'Для редактирования выберите другой остановочный пункт.');
                 form22.SpinEdit9.Value:=0; // km
                 form22.SpinEdit10.Value:=0; // hour
                 form22.SpinEdit11.Value:=0; // min
                 form22.Edit7.Text:='0';
                 exit;
              end;

         // Отключаем все кроме выбора  ост.пункта
         form22.GroupBox1.Enabled:=true;
         form22.GroupBox2.Enabled:=true;
         form22.GroupBox3.Enabled:=true;
         form22.CheckBox1.Enabled:=true;
         form22.CheckBox2.Enabled:=true;
         form22.SpinEdit5.Enabled:=false;
         form22.SpinEdit6.Enabled:=false;
         form22.SpinEdit3.Enabled:=false;
         form22.SpinEdit4.Enabled:=false;
         form22.SpinEdit9.Value:=0; // km
         form22.SpinEdit10.Value:=0; // hour
         form22.SpinEdit11.Value:=0; // min

         // Рисуем информацию об ост.пунктах
         // Тек. ост. пункт
         form22.edit6.text:=trim(form22.edit2.text);
         form22.edit4.text:=trim(form22.edit1.text);

    // Производим поиск по справочнику расстояний
     if (form22.SpinEdit9.value=0) then
         begin

         // Подключаемся к серверу
         If not(Connect2(Zconnection1, flagProfile)) then
            begin
               showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
               exit;
            end;
          //Делаем запрос к справочнику расстояний
           form22.ZQuery1.SQL.Clear;
           form22.ZQuery1.SQL.add('select * from av_spr_path where ((id1='+trim(form22.Edit5.text)+' and id2='+trim(form22.Edit6.text)+') or (id1='+trim(form22.Edit6.text)+' and id2='+trim(form22.Edit5.text)+')) and del=0;');
           form22.ZQuery1.open;
           if form22.ZQuery1.RecordCount=0 then
                begin
                 form22.ZQuery1.close;
                 form22.ZConnection1.disconnect;
                 form22.GroupBox3.Enabled:=true;
                 form22.StaticText1.Visible:=true;
                 form22.Image4.Visible:=true;
                 // Заполняем поля данными на форме
                 form22.SpinEdit9.Value:=0; // km
                 form22.SpinEdit10.Value:=0; // hour
                 form22.SpinEdit11.Value:=0; // min
                 form22.check_param();
                 form22.ZQuery1.close;
                 form22.ZConnection1.disconnect;
                 exit;
                end;
          // Заполняем поля данными на форме
          form22.SpinEdit9.Value:=form22.ZQuery1.FieldByName('km').asFloat; // km
          try
          form22.SpinEdit10.Value:=strtoint(copy(trim(form22.ZQuery1.FieldByName('path_time').asString),1,2)); // hour
          form22.SpinEdit11.Value:=strtoint(copy(trim(form22.ZQuery1.FieldByName('path_time').asString),4,2)); // min
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x09');
               exit;
             end;
          end;
          form22.StaticText1.Visible:=false;
          form22.Image4.Visible:=false;
          form22.GroupBox3.Enabled:=true;
          form22.ZQuery1.close;
          form22.ZConnection1.disconnect;
        end;
      form22.check_param();
    end;
   end;
end;

procedure TForm22.Edit7EditingDone(Sender: TObject);
begin
  //flcritical:=true;
   // Изменения часового пояса
  Form22.check_param();
end;

procedure TForm22.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState     );
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[F4] - Норматив'+#13+'[ESC] - Отмена\Выход');
    //F2 - Сохранить
    if (Key=113) and (form22.bitbtn3.enabled=true) then  form22.bitbtn3.click;
    //F4 - Норматив
    if (Key=115) and (form22.bitbtn5.enabled=true) then  form22.bitbtn5.click;
    // ESC
    if Key=27 then form22.Close;

    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) then Key:=0;
end;

procedure TForm22.FormShow(Sender: TObject);
var
  tmplogical:boolean;
begin
  //сохранить состояние флага изменения состава
     tmplogical:=flcritical;
     decimalseparator:='.';
     With Form22 do
     begin
    if flag_edit_sostav=2 then
       begin
        // Заполняем форму значениями
           form22.edit5.text:=trim(form16.StringGrid1.Cells[0,form16.StringGrid1.row-1]);
           form22.edit3.text:=trim(form16.StringGrid1.Cells[1,form16.StringGrid1.row-1]);
           form22.Edit2.text:=m_sostav[form16.StringGrid1.row,0];  //код остановочного пункта
           form22.Edit1.text:=m_sostav[form16.StringGrid1.row,1];  //Наименование остановочного пункта
            if m_sostav[form16.StringGrid1.row,2]='1' then form22.CheckBox1.Checked:=true else form22.CheckBox1.Checked:=false; //Формирующийся
            try
            form22.SpinEdit2.value:=strtoint(m_sostav[form16.StringGrid1.row ,3]); //Платформа отправления
            form22.SpinEdit1.value:=strtoint(m_sostav[form16.StringGrid1.row ,4]); //Платформа прибытия
            form22.SpinEdit3.value:=strtoint(copy(trim(m_sostav[form16.StringGrid1.row ,5]),1,2));  //Время отправления
            form22.SpinEdit4.value:=strtoint(copy(trim(m_sostav[form16.StringGrid1.row ,5]),4,2));  //Время отправления
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x10');
               exit;
             end;
          end;

            form22.CheckBox3.Enabled:=false;
            form22.CheckBox3.Checked:=false;
            form22.GroupBox1.enabled := true;
            form22.GroupBox2.enabled := true;
            //если последний пункт ставим флаг последнего пункта в составе
            if form16.StringGrid1.Row=form16.StringGrid1.RowCount-1 then
              begin
                form22.CheckBox3.Checked:=true;
                form22.SpinEdit3.value := 0;
                form22.SpinEdit4.value := 0;
                form22.SpinEdit7.value := 0;
                form22.SpinEdit8.value := 0;
                form22.SpinEdit3.enabled := false;
                form22.SpinEdit4.enabled := false;
                form22.SpinEdit7.enabled := false;
                form22.SpinEdit8.enabled := false;
              end;
              //если первый пункт
            if (form16.StringGrid1.Row=1) then
              begin
                //form22.SpinEdit3.enabled := false;
                //form22.SpinEdit4.enabled := false;
                form22.SpinEdit7.enabled := false;
                form22.SpinEdit8.enabled := false;
                form22.Edit7.Enabled:=false;//нельзя менять часовой пояс первого пункта
              end;

           try
            form22.SpinEdit7.value:=strtoint(copy(trim(m_sostav[form16.StringGrid1.row ,7]),1,2));  //Время стоянки
            form22.SpinEdit8.value:=strtoint(copy(trim(m_sostav[form16.StringGrid1.row ,7]),4,2));  //Время стоянки
            form22.SpinEdit10.value:=strtoint(copy(trim(m_sostav[form16.StringGrid1.row ,9]),1,2)); //Время в пути
            form22.SpinEdit11.value:=strtoint(copy(trim(m_sostav[form16.StringGrid1.row ,9]),4,2)); //Время в пути
            form22.SpinEdit9.value:=strtofloat(m_sostav[form16.StringGrid1.row ,8]);                  //Расстояние
          except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x11');
               exit;
             end;
          end;

            form22.Edit7.text:=trim(m_sostav[form16.StringGrid1.row,12]);     //Смещение часового пояса
            if  not(trim(form22.Edit7.text)='0') then
                 form22.check_param()
            else
                 begin
                   try
                 form22.SpinEdit5.value:=strtoint(copy(trim(m_sostav[form16.StringGrid1.row ,6]),1,2));  //Время прибытия
                   except
                      on exception: EConvertError do
                      begin
                      showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x12');
                      exit;
                      end;
                   end;
                 end;
            try
             form22.SpinEdit6.value:=strtoint(copy(trim(m_sostav[form16.StringGrid1.row ,6]),4,2));  //Время прибытия
           except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'x13');
               exit;
             end;
          end;
            if m_sostav[form16.StringGrid1.row,13]='1' then form22.CheckBox2.Checked:=true else form22.CheckBox2.Checked:=false; //Точка возврата
       end;
    if flag_edit_sostav=1 then
       begin
         GroupBox1.Enabled:=true;
         CheckBox3.Enabled:=true;
         // Если первый пункт в составе
           if form16.StringGrid1.RowCount=1 then
              begin
                form22.CheckBox1.Checked:=true;
                first_point:=1;
                form22.CheckBox3.Enabled:=false;
                form22.Edit7.Enabled:=false;//нельзя менять часовой пояс первого пункта
              end;
         // Если следующий пункт то сразу километраж
           if form16.StringGrid1.RowCount>1 then
              begin
               // Отключаем все кроме выбора  ост.пункта
               // Рисуем информацию об ост.пунктах
               // Пред. ост. пункт
               first_point:=0;
               form22.edit5.text:=trim(form16.StringGrid1.Cells[0,form16.StringGrid1.rowcount-1]);
               form22.edit3.text:=trim(form16.StringGrid1.Cells[1,form16.StringGrid1.rowcount-1]);
              end;
           //сбрасываем флаг последнего пункта в составе
           form22.CheckBox3.Checked:=false;
       end;

      flcritical:=tmplogical;
     end;
end;

end.

