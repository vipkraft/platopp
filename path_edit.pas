unit path_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Spin, Buttons,platproc, ZConnection, ZDataset;

type

  { TFormpme }

  TFormpme = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
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
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formpme: TFormpme;

implementation
  uses
    mainopp,path_main,point_main;
{$R *.lfm}

{ TFormpme }
var
  pnt_id1, pnt_id2 : integer;
  fl_change : byte;

procedure TFormpme.FormShow(Sender: TObject);
begin
     Centrform(formpme);
    //если добавление
   if flag_edit_path=1 then
       begin
         formpme.Label9.Caption:='';
         formpme.Label10.Caption:='';
         FormPME.BitBtn1.Enabled:=true;
       end;
    //если редактирование
    // Заполняем поля данными из предыдущей формы
    if flag_edit_path=2 then
       begin
         fl_change:=0;
         formpme.Label9.Caption:=trim(formpm.StringGrid1.cells[1,formpm.StringGrid1.row]);
         formpme.Label10.Caption:=trim(formpm.StringGrid1.cells[3,formpm.StringGrid1.row]);
         formpme.Edit1.text:=trim(formpm.StringGrid1.cells[2,formpm.StringGrid1.row]);
         formpme.Edit2.text:=trim(formpm.StringGrid1.cells[4,formpm.StringGrid1.row]);
         formpme.SpinEdit1.value:=strtoint(trim(formpm.StringGrid1.cells[5,formpm.StringGrid1.row]));
         formpme.SpinEdit2.value:=strtoint(copy(trim(formpm.StringGrid1.cells[6,formpm.StringGrid1.row]),1,2));
         formpme.SpinEdit3.value:=strtoint(copy(trim(formpm.StringGrid1.cells[6,formpm.StringGrid1.row]),4,2));
       end;
end;

procedure TFormpme.SpinEdit1Change(Sender: TObject);
begin
  fl_change:=1;
end;

procedure TFormpme.SpinEdit2Change(Sender: TObject);
begin
  fl_change:=1;
end;

procedure TFormpme.SpinEdit3Change(Sender: TObject);
begin
  fl_change:=1;
end;

procedure Tformpme.BitBtn4Click(Sender: TObject);
begin
  formpme.close;
end;


procedure TFormpme.Edit2Change(Sender: TObject);
begin
  //если режим добавления
  with FormPME do
  begin

  end;
end;




procedure TFormpme.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+ #13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then formpme.Close;
    // F2 - Сохранить
    if (Key=113) and (formpme.BitBtn3.Enabled=true) then formpme.BitBtn3.Click;
end;

procedure Tformpme.BitBtn3Click(Sender: TObject);
var
  new_id:integer;
begin
  With FormPME do
  begin
  //Проверяем не заполнение формы
  If (trim(Edit1.text)='') OR (trim(Edit2.text)='') then
     begin
       showmessagealt('Не заполнены поля остановочных пунктов !');
       exit;
     end;
  If SpinEdit1.Value=0  then
     begin
       showmessagealt('Не указано расстояние между остановочными пунктами !');
       exit;
     end;
  If SpinEdit1.Value=0  then
     begin
       showmessagealt('Не указано расстояние между остановочными пунктами !');
       exit;
     end;
  If (SpinEdit2.Value=0) AND (SpinEdit3.Value=0) then
     begin
       showmessagealt('Не указано время проходения между остановочными пунктами !');
       exit;
     end;
 //если режим редактирования
    IF flag_edit_path=2 then
     begin
       If fl_change=0 then exit;
       if (dialogs.MessageDlg('Вы действительно хотите изменить существующий норматив протяженности пути ?',mtConfirmation,[mbYes,mbNO], 0)=7)
       then   formpme.Close;
      end;

 // Проверяем что такая запись уже существует
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

 //если режим добавления
  IF flag_edit_path=1 then
     begin
          //Делаем запрос к справочнику расстояний
           ZQuery1.SQL.Clear;
           ZQuery1.SQL.add('select * from av_spr_path where ((id1='+trim(Label9.caption)+' and id2='+trim(Label10.caption)+') or (id1='+trim(Label10.caption)+' and id2='+trim(Label9.caption)+')) and del=0;');
//           showmessagealt(ZQuery1.SQL.text);
           try
            ZQuery1.open;
           except
            showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
            Zconnection1.disconnect;
            exit;
           end;
          // Проверяем что запрос нашел информацию
           if ZQuery1.RecordCount>0 then
               begin
                 showmessagealt('Данный норматив уже существует в базе !'+#13+'Для изменения параметров этого норматива откройте его на редактирование в справочнике нормативов.');
                 Zconnection1.disconnect;
                 exit;
               end;
     end;

  //Записываем данные
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
  if flag_edit_path=1 then
      begin
        //Определяем new_id
         ZQuery1.SQL.Clear;
         ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_path;');
         ZQuery1.open;
         new_id:=ZQuery1.FieldByName('new_id').asInteger+1;
      end;

  //Маркируем запись на удаление если режим редактирования
  if flag_edit_path=2 then
      begin
       formpme.ZQuery1.SQL.Clear;
       formpme.ZQuery1.SQL.add('UPDATE av_spr_path SET del=1,createdate=now(),id_user='+inttostr(new_id)+' WHERE id='+formPM.StringGrid1.Cells[0,formPM.StringGrid1.Row]+' and del=0;');
       formpme.ZQuery1.ExecSQL;
      end;

  //Определяем id населенного пункта и id группы
  formpme.ZQuery1.SQL.Clear;
  formpme.ZQuery1.SQL.add('INSERT INTO av_spr_path(id,id1,id2,km,path_time,id_user,createdate,id_user_first,createdate_first,del) VALUES (');

  //если режим добавления
  IF flag_edit_path=1 then
      begin
         ZQuery1.SQL.add(inttostr(new_id)+','+trim(label9.caption)+','+trim(label10.caption)+','+inttostr(formpme.spinedit1.value)+',');
         ZQuery1.SQL.add(QuotedSTR(padl(inttostr(formpme.SpinEdit2.value),'0',2)+':'+padl(inttostr(formpme.SpinEdit3.value),'0',2))+',');
         ZQuery1.SQL.add(inttostr(id_user)+',now(),'+inttostr(id_user)+',now(),0);');
      end;
  //если режим редактирования
  IF flag_edit_path=2 then
      begin
         ZQuery1.SQL.add(formPM.StringGrid1.Cells[0,formPM.StringGrid1.Row]+','+trim(label9.caption)+','+trim(label10.caption)+','+inttostr(spinedit1.value)+',');
         ZQuery1.SQL.add(QuotedSTR(padl(inttostr(SpinEdit2.value),'0',2)+':'+padl(inttostr(SpinEdit3.value),'0',2))+',');
         ZQuery1.SQL.add(inttostr(id_user)+',now(),NULL,NULL,0);');


      end;
//  showmessagealt(ZQuery1.SQL.text);

  ZQuery1.ExecSQL;
  // Завершение транзакции
   Zconnection1.Commit;
    //showmessagealt('Транзакция завершена УСПЕШНО !!!');
    FormPME.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
end;
end;

procedure TFormpme.BitBtn1Click(Sender: TObject);
begin
  With FormPME do
  begin
  Label9.caption:='';
  Edit1.text:='';
    form9:=Tform9.create(self);
    form9.ShowModal;
    FreeAndNil(form9);
  //Добавляем остановочный пункт
  if not(result_point_id='') then
   begin
      If result_point_id=trim(FormPME.Label10.caption) then
        begin
           showmessagealt('Остановочные пункты норматива совпадают !');
           FormPME.Label9.caption:='';
           FormPME.Edit1.text:='';
           exit;
        end;
        Label9.Caption:=result_point_id;
        Edit1.text:=result_point_name;


  IF (flag_edit_path=1) AND (trim(Edit2.Text)<>'')  then
     begin
          // Проверяем что такая запись уже существует
        // Подключаемся к серверу
        If not(Connect2(Zconnection1, flagProfile)) then
           begin
              showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
              exit;
           end;
          //Делаем запрос к справочнику расстояний
           ZQuery1.SQL.Clear;
           ZQuery1.SQL.add('select * from av_spr_path where ((id1='+trim(Label9.caption)+' and id2='+trim(Label10.caption)+') or (id1='+trim(Label10.caption)+' and id2='+trim(Label9.caption)+')) and del=0;');
        //   showmessagealt(ZQuery1.SQL.text);
           try
            ZQuery1.open;
           except
            showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
            Zconnection1.disconnect;
            exit;
           end;
          // Проверяем что запрос нашел информацию
           if ZQuery1.RecordCount>0 then
               begin
                 showmessagealt('Данный норматив уже существует в базе !'+#13+'Для изменения параметров этого норматива откройте его на редактирование в справочнике нормативов.');
                 Zconnection1.disconnect;
                 Edit1.Text:='';
                 Label9.caption:='';
                 exit;
               end;

     end;

   end;
  if trim(Edit1.text)='' then
       BitBtn2.Enabled:=false
  else
    begin
       BitBtn2.Enabled:=true;
       BitBtn2.SetFocus;
    end;
  end;
end;

procedure TFormpme.BitBtn2Click(Sender: TObject);
begin
  With FormPME do
  begin
  Label10.caption:='';
  Edit2.text:='';
    form9:=Tform9.create(self);
    form9.ShowModal;
    FreeAndNil(form9);
  //Добавляем остановочный пункт
  if not(result_point_id='') then
   begin
      If result_point_id=trim(FormPME.Label9.caption) then
        begin
               showmessagealt('Остановочные пункты норматива совпадают !');
               FormPME.Label10.caption:='';
               FormPME.Edit2.text:='';
               exit;
        end;
        Label10.Caption:=result_point_id;
        Edit2.text:=result_point_name;

   IF (flag_edit_path=1) AND (trim(Edit1.Text)<>'')  then
     begin
          // Проверяем что такая запись уже существует
     // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
       begin
          showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
          exit;
       end;
          //Делаем запрос к справочнику расстояний
           ZQuery1.SQL.Clear;
           ZQuery1.SQL.add('select * from av_spr_path where ((id1='+trim(Label9.caption)+' and id2='+trim(Label10.caption)+') or (id1='+trim(Label10.caption)+' and id2='+trim(Label9.caption)+')) and del=0;');
      //     showmessagealt(ZQuery1.SQL.text);
           try
            ZQuery1.open;
           except
            showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
            Zconnection1.disconnect;
            exit;
           end;
          // Проверяем что запрос нашел информацию
           if ZQuery1.RecordCount>0 then
               begin
                 showmessagealt('Данный норматив уже существует в базе !'+#13+'Для изменения параметров этого норматива откройте его на редактирование в справочнике нормативов.');
                 Zconnection1.disconnect;
                 Edit2.Text:='';
                 Label10.caption:='';
                 exit;
               end;
        SpinEdit1.SetFocus;
     end;

   end;
  end;
end;

end.

