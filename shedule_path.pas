unit shedule_path;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, Spin, Buttons;

type

  { TFormPath }

  TFormPath = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    SpinEdit1: TFloatSpinEdit;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Enter(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formpath: TFormpath;

implementation
uses
  platproc,mainopp,shedule_edit_sostav;

var
  record_id : string;
{ TFormPath }


procedure TFormPath.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+ #13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then formpath.Close;
    // F2 - Сохранить
    if (Key=113) and (formpath.BitBtn3.Enabled=true) then formpath.BitBtn3.Click;

    if (Key=112) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=13)  then Key:=0;
end;

procedure TFormPath.SpinEdit1Enter(Sender: TObject);
begin
    try
      strToInt(record_id);
    except
     exit;
    end;
  //вывести инфу о создании и редактировании записи
   If strToInt(record_id)>0 then
   ShowEditLog(FormPath,FormPath.Panel1,FormPath.ZQuery1,FormPath.ZConnection1,'av_spr_path',record_id,0);
end;

procedure TFormPath.BitBtn4Click(Sender: TObject);
begin
  formpath.close;
end;

procedure TFormPath.FormCreate(Sender: TObject);
begin
  decimalseparator:='.';
end;

procedure TFormPath.FormShow(Sender: TObject);
begin
    Centrform(FormPath);
    With FormPath do
    begin
    // Заполняем поля данными из предыдущей формы
      formpath.Label9.Caption:=trim(form22.Edit5.text);
      formpath.Label10.Caption:=trim(form22.Edit6.text);
      formpath.Edit1.text:=trim(form22.Edit3.text);
      formpath.Edit2.text:=trim(form22.Edit4.text);
      formpath.SpinEdit1.value:=form22.SpinEdit9.value;
      formpath.SpinEdit2.value:=form22.SpinEdit10.value;
      formpath.SpinEdit3.value:=form22.SpinEdit11.value;

  // Ищем норматив если корректировка
   if form22.StaticText1.visible=true then exit;
          // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
          //Делаем запрос к справочнику расстояний
          try
           formpath.ZQuery1.SQL.Clear;
           formpath.ZQuery1.SQL.add('select * from av_spr_path where ((id1='+trim(form22.Edit5.text)+' and id2='+trim(form22.Edit6.text)+') or (id1='+trim(form22.Edit6.text)+' and id2='+trim(form22.Edit5.text)+')) and del=0;');
           //showmessage(formpath.ZQuery1.SQL.Text);
           formpath.ZQuery1.open;
          except
           formpath.ZQuery1.close;
           formpath.ZConnection1.disconnect;
           form22.StaticText1.Visible:=true;
           form22.Image4.Visible:=true;
           exit;
          end;

          If NOT(formpath.ZQuery1.RecordCount=1) then
             begin
             showmessagealt('ОШИБКА! В базе нормативов найдено более 1 записи по данным населенным пунктам !!!'+#13+
                          'Следует отредактировать записи по ним в базе нормативов !');
             exit;
             end;
          If formpath.ZQuery1.RecordCount>0 then
          begin
           showmessagealt('           В Н И М А Н И Е !!!'+#13+
                      'В справочнике нормативов найдены данные для следующих остановочных  пунктов:'+#13+
                      'ОТ:  '+trim(form22.edit3.text)+#13+
                      'ДО:  '+trim(form22.edit4.text)+#13+
                      'Протяженность пути: '+inttostr(formpath.ZQuery1.FieldByName('km').asInteger)+' километров.'+#13+
                      'Время в пути: '+copy(trim(formpath.ZQuery1.FieldByName('path_time').asString),1,2)+' часов '+copy(trim(formpath.ZQuery1.FieldByName('path_time').asString),4,2)+' минут.'+#13+
                      'Средняя скорость движения: '+floattostr(round(formpath.SpinEdit1.value/(formpath.SpinEdit2.value*60+formpath.SpinEdit3.value)*60))+' км\ч.'+#13+#13+
                      'Если изменить нормативные показатели на данной форме, они изменятся для всей системы вцелом !!!'+#13+#13+
                      'Если требуется ввести показатели, отличные от нормативных только для этого расписания,'+#13+
                      'необходимо закрыть данную форму и ввести их в предыдущей форме вручную.');
            formpath.SpinEdit1.value:=formpath.ZQuery1.FieldByName('km').asFloat;
            formpath.SpinEdit2.value:=strtoint(copy(trim(formpath.ZQuery1.FieldByName('path_time').asString),1,2));
            formpath.SpinEdit3.value:=strtoint(copy(trim(formpath.ZQuery1.FieldByName('path_time').asString),4,2));
            record_id := formpath.ZQuery1.FieldByName('id').asString;
            formpath.ZQuery1.close;
          end;
    end;
end;



procedure TFormPath.BitBtn3Click(Sender: TObject);
var
  new_id,old_id:integer;
  flag_edit_path:byte;
begin
  With FOrmPath do
  begin
  // Проверяем что такая запись уже существует
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

          //Делаем запрос к справочнику расстояний
           formpath.ZQuery1.SQL.Clear;
           formpath.ZQuery1.SQL.add('select * from av_spr_path where ((id1='+trim(form22.Edit5.text)+' and id2='+trim(form22.Edit6.text)+') or (id1='+trim(form22.Edit6.text)+' and id2='+trim(form22.Edit5.text)+')) and del=0;');
           formpath.ZQuery1.open;
           flag_edit_path:=0;
          // Проверяем что запрос нашел информацию
           if formpath.ZQuery1.RecordCount>0 then
               begin
                if not(dialogs.MessageDlg('Вы действительно хотите переписать существующий норматив протяженности пути ?',mtConfirmation,[mbYes,mbNO], 0)=6) then
                    begin
                     formpath.ZQuery1.close;
                     formpath.ZConnection1.disconnect;
                     exit;
                    end;
                flag_edit_path:=1;
                old_id:=formpath.ZQuery1.FieldByName('id').asInteger;
               end;

  // Записываем данные
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
  //Определяем текущий id+1
  formpath.ZQuery1.SQL.Clear;
  formpath.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_path;');
  formpath.ZQuery1.open;
  new_id:=formpath.ZQuery1.FieldByName('new_id').asInteger+1;
  if flag_edit_path=1 then
     begin
       new_id:=new_id-1;
     end;
  //Производим запись новых данных
  //Маркируем запись на удачение если режим редактирования
  if flag_edit_path=1 then
      begin
       formpath.ZQuery1.SQL.Clear;
       formpath.ZQuery1.SQL.add('UPDATE av_spr_path SET del=1,createdate=now(),id_user='+inttostr(new_id)+' WHERE id='+inttostr(old_id)+' and del=0;');
       formpath.ZQuery1.ExecSQL;
      end;

  //Определяем id населенного пункта и id группы
  formpath.ZQuery1.SQL.Clear;
  formpath.ZQuery1.SQL.add('INSERT INTO av_spr_path(id, id_user, id1, id2, km, path_time');
  if flag_edit_path=0 then formpath.ZQuery1.SQL.add(',createdate_first,id_user_first');
  formpath.ZQuery1.SQL.add(') VALUES (');
  formpath.ZQuery1.SQL.add(inttostr(new_id)+','+inttostr(id_user)+','+trim(formpath.label9.caption)+','+trim(formpath.label10.caption)+','+floattostr(formpath.spinedit1.value)+','+
                           QuotedSTR(padl(inttostr(formpath.SpinEdit2.value),'0',2)+':'+padl(inttostr(formpath.SpinEdit3.value),'0',2)));
  if flag_edit_path=0 then formpath.ZQuery1.SQL.add(',now(),'+inttostr(id_user));
  formpath.ZQuery1.SQL.add(');');
  formpath.ZQuery1.ExecSQL;
  // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  Close;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
 end;
end;


{$R *.lfm}

end.

