unit point_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, MaskEdit, Spin,
  pdp_destination_points,
  platproc;

type

  { TForm10 }

  TForm10 = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Image3: TImage;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    SpinEdit1: TSpinEdit;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure get_dest_info();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form10: TForm10;
  id_locality,razbor:string;


implementation
  uses
    point_main,mainopp,nas,group,read_nas;

  { TForm10 }

procedure TForm10.get_dest_info();
begin
  with Form10 do
  begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

  // Запрос маршрутов и расписаний
  ZQuery1.SQL.clear;
  ZQuery1.SQL.add('SELECT dname, idek, location, owner  ');
  ZQuery1.SQL.add('  FROM av_spr_destination ');
  ZQuery1.SQL.add('WHERE idek='+quotedstr(self.Edit12.text));

  //-конец запроса :-)
  //showmessage(ZQuery1.SQL.Text);//;$
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
  end;

   if ZQuery1.RecordCount=0 then
      begin
        ZQuery1.close;
        ZConnection1.Disconnect;
        exit;
      end;
   Self.Edit10.Text:=trim(ZQuery1.FieldByName('owner').asString);
   Self.Edit11.Text:=trim(ZQuery1.FieldByName('location').asString);
   Self.Edit16.Text:=trim(ZQuery1.FieldByName('dname').asString);

   //StringGrid1.Repaint;
   ZQuery1.Close;
   Zconnection1.disconnect;

  end;
end;

procedure TForm10.FormShow(Sender: TObject);
 var
   tmp_id_user,n:integer;
begin
  with Form10 do
  begin
   if flag_access=1 then BitBtn3.Enabled:=false;
  // Режим новой записи
   if flag_edit_point=1 then
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;

  //Определяем первую группу остановочных пунктов
 { id_group:='0';
     // Определяем список групп
     Form10.ZQuery1.SQL.Clear;
     Form10.ZQuery1.SQL.add('Select id,name from av_spr_point_group where del=0 limit 1;');
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
     if Form10.ZQuery1.RecordCount>0 then
      begin
        id_group:=Form10.ZQuery1.FieldByName('id').asString;
          Form10.edit12.text:=trim(Form10.ZQuery1.FieldByName('name').asString);
      end;
       ZQuery1.Close;
  }
     // Определяем пользователя
     Form10.ZQuery1.SQL.Clear;
     Form10.ZQuery1.SQL.add('Select * from av_users where id='+inttostr(id_user)+';');
     try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
     Form10.Label12.caption:='Последняя редакция: '+trim(Form10.ZQuery1.FieldByName('fullname').asString)+'  '+trim(Form10.ZQuery1.FieldByName('dolg').asString);
     ZQuery1.Close;
     Form10.Zconnection1.disconnect;
  end;

  // Режим редактирования
  if flag_edit_point=2 then
   begin
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   // Определяем пользователя
   Form10.ZQuery1.SQL.clear;
   Form10.ZQuery1.SQL.add('   select ');
   Form10.ZQuery1.SQL.add('case when btrim(adres)='''' then dlocation else btrim(adres) end as plocation ');
Form10.ZQuery1.SQL.add(',case when btrim(fio_owner)='''' then downer else btrim(fio_owner) end as powner ');
Form10.ZQuery1.SQL.add(',* ');
Form10.ZQuery1.SQL.add(' FROM ( ');
 Form10.ZQuery1.SQL.add('SELECT * ');
 Form10.ZQuery1.SQL.add(',(SELECT c.dname FROM av_spr_destination c where c.idek=m.iddest limit 1) dname ');
Form10.ZQuery1.SQL.add(',(SELECT c.location FROM av_spr_destination c where c.idek=m.iddest limit 1) dlocation ');
Form10.ZQuery1.SQL.add(',(SELECT c.owner FROM av_spr_destination c where c.idek=m.iddest limit 1) downer ');
Form10.ZQuery1.SQL.add('FROM ( ');
Form10.ZQuery1.SQL.add('select a.* ');
Form10.ZQuery1.SQL.add(',trim(b.name) as locality,b.rajon,b.region,b.land,b.typ_locality,b.typ_region ');
Form10.ZQuery1.SQL.add(',(SELECT trim(to_char(id_dest,''00000'')) FROM av_pdp_dest_point b where b.id_point=a.id order by del asc,createdate desc limit 1) as iddest ');
Form10.ZQuery1.SQL.add('from av_spr_point a ');
Form10.ZQuery1.SQL.add('left join av_spr_locality b ON a.kod_locality=b.id and b.del=0 ');
Form10.ZQuery1.SQL.add('where a.del=0  ');
Form10.ZQuery1.SQL.add('and a.id='+trim(form9.StringGrid1.Cells[0,form9.StringGrid1.row]));
Form10.ZQuery1.SQL.add(') m ');
Form10.ZQuery1.SQL.add(') z ');
   //Form10.ZQuery1.SQL.add(',(select c.name from av_spr_point_group c where a.id_group=c.id order by c.del asc, createdate desc limit 1) as name_group ');
 //showmessage(ZQuery1.SQL.Text);//$
   try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
   // Определяем текущие данные
   Form10.Edit1.Text:=Form10.ZQuery1.FieldByName('id').asString;
   Form10.Edit6.Text:=Form10.ZQuery1.FieldByName('name').asString;
   //Form10.edit12.Text:=Form10.ZQuery1.FieldByName('name_group').asString;
   Form10.Edit2.Text:=Form10.ZQuery1.FieldByName('locality').asString;
   Form10.Edit8.Text:=Form10.ZQuery1.FieldByName('typ_locality').asString;
   Form10.Edit3.Text:=Form10.ZQuery1.FieldByName('land').asString;
   Form10.Edit4.Text:=Form10.ZQuery1.FieldByName('region').asString;
   Form10.Edit7.Text:=Form10.ZQuery1.FieldByName('typ_region').asString;
   Form10.edit5.Text:=Form10.ZQuery1.FieldByName('rajon').asString;
   Form10.edit9.Text:=Form10.ZQuery1.FieldByName('owner').asString;
   //Form10.edit10.Text:=Form10.ZQuery1.FieldByName('fio_owner').asString;
   //Form10.edit11.Text:=Form10.ZQuery1.FieldByName('adres').asString;
   Form10.edit10.Text:=Form10.ZQuery1.FieldByName('downer').asString;
   Form10.edit11.Text:=Form10.ZQuery1.FieldByName('dlocation').asString;
   Form10.SpinEdit1.value:=Form10.ZQuery1.FieldByName('timering').asInteger;
   Form10.edit12.Text:=Form10.ZQuery1.FieldByName('iddest').asString;
   tmp_id_user:=Form10.ZQuery1.FieldByName('id_user').asInteger;
   id_locality:=Form10.ZQuery1.FieldByName('kod_locality').asString;
   Form10.edit13.Text:=Form10.ZQuery1.FieldByName('postadress').asString;
   Form10.edit14.Text:=Form10.ZQuery1.FieldByName('powner').asString;
   Form10.edit15.Text:=Form10.ZQuery1.FieldByName('plocation').asString;
   Form10.edit16.Text:=Form10.ZQuery1.FieldByName('dname').asString;

   //id_group:=Form10.ZQuery1.FieldByName('id_group').asString;
   Form10.ZQuery1.SQL.Clear;
   Form10.ZQuery1.SQL.add('Select * from av_users where id='+inttostr(tmp_id_user));
   try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
   Form10.Label12.caption:='Последняя редакция: '+trim(Form10.ZQuery1.FieldByName('fullname').asString)+'  '+trim(Form10.ZQuery1.FieldByName('dolg').asString);
    end;
   end;
  form10.BitBtn6.SetFocus;
end;

procedure TForm10.BitBtn3Click(Sender: TObject);
 var
   new_id,n:integer;
   razbor:string;
begin
  With Form10 do
  begin
   //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if (trim(Form10.Edit2.text)='') or
     (trim(Form10.Edit6.text)='')
     //or (trim(id_group)='')
     then
      begin
       showmessagealt('Сохранение невозможно !!!'+#13+'Заполнены не все обязательные поля данных !');
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
  //Определяем текущий id+1
  if flag_edit_point=1 then
      begin
        Form10.ZQuery1.SQL.Clear;
        Form10.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_point;');
        Form10.ZQuery1.open;
        new_id:=Form10.ZQuery1.FieldByName('new_id').asInteger+1;
      end
  else
      begin
        new_id:=strtoint(trim(Form10.Edit1.Text));
      end;

    //Производим запись новых данных
  //Маркируем запись на удачение если режим редактирования
  if flag_edit_point=2 then
      begin
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_spr_point SET del=1,id_user='+inttostr(id_user)+',createdate=now() WHERE id='+trim(form9.StringGrid1.Cells[0,form9.StringGrid1.row])+' and del=0;');
       ZQuery1.ExecSQL;
      end;

  //Определяем id населенного пункта и id группы
  //if trim(id_group)='' then id_group:='0';
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('INSERT INTO av_spr_point(name,kod_locality,owner,fio_owner,adres,timering,postadress,id_user,createdate,id_user_first,createdate_first,del,id) VALUES (');
   ZQuery1.SQL.add(QuotedSTR(trim(Edit6.text))+','+trim(id_locality)+','+QuotedSTR(trim(Edit9.text))+','+QuotedSTR(trim(Edit14.text))+',');
   ZQuery1.SQL.add(QuotedSTR(trim(Edit15.text))+',');
   ZQuery1.SQL.add(inttostr(SpinEdit1.Value)+','+QuotedSTR(trim(Edit13.text))+','+intToStr(id_user)+',now(),');
   //режим добавления
  if flag_edit_point=1 then
      begin
        ZQuery1.SQL.add(intToStr(id_user)+',now(),0,'+intToStr(new_id)+');');
      end;
   //режим редактирования
  if flag_edit_point=2 then
      begin
        ZQuery1.SQL.add('NULL,NULL,0,'+intToStr(new_id)+');');
      end;
//  showmessagealt(ZQuery1.SQL.Text);
  ZQuery1.ExecSQL;

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
end;
end;


procedure TForm10.BitBtn4Click(Sender: TObject);
begin
  Form10.close;
end;

procedure TForm10.BitBtn6Click(Sender: TObject);
begin
  form5:=Tform5.create(self);
  form5.ShowModal;
  FreeAndNil(form5);
  // Заполняем поля для населенных пунктов
  if not(result_kod_nas='') then
     begin
     // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
     //Делаем запрос к населенным пунктам
     Form10.ZQuery1.SQL.Clear;
     Form10.ZQuery1.SQL.add('select * from av_spr_locality where id='+trim(result_kod_nas)+' AND del=0;');
     //showmessage(form10.ZQuery1.SQL.Text);//$
     Form10.ZQuery1.open;
     If form10.ZQuery1.RecordCount<>1 then
       begin
         showmessagealt('Найдено более одной записи по запросу !'+#13+'Обратитесь к Администратору !');
         Form10.ZQuery1.Close;
         Form10.ZConnection1.Disconnect;
         exit;
       end;
     // Заполняем все поля edit
     Form10.Edit6.Text:=Form10.ZQuery1.FieldByName('name').asString;
     Form10.Edit2.Text:=Form10.ZQuery1.FieldByName('name').asString;
     Form10.Edit8.Text:=Form10.ZQuery1.FieldByName('typ_locality').asString;
     Form10.Edit3.Text:=Form10.ZQuery1.FieldByName('land').asString;
     Form10.Edit4.Text:=Form10.ZQuery1.FieldByName('region').asString;
     Form10.Edit7.Text:=Form10.ZQuery1.FieldByName('typ_region').asString;
     Form10.edit5.Text:=Form10.ZQuery1.FieldByName('rajon').asString;
     //Form10.SpinEdit1.value:=Form10.ZQuery1.FieldByName('timering').asInteger;
     id_locality:=Form10.ZQuery1.FieldByName('id').asString;
     Form10.ZQuery1.Close;
     Form10.ZConnection1.Disconnect;
     form10.Edit6.SetFocus;
     end;
end;

procedure TForm10.BitBtn7Click(Sender: TObject);
begin
  self.Edit13.Text:=self.Edit11.text;
end;

procedure TForm10.BitBtn8Click(Sender: TObject);
begin
   result_dest:='';
   form29:=Tform29.create(self);
   form29.Edit1.Enabled:=false;
   //form29.Stringgrid1.Enabled:=false;
   if not (self.Edit6.Text = EmptyStr) then
    form29.Edit2.Text:=self.Edit6.Text;
   form29.Bitbtn5.Enabled:=true;
   form29.Showmodal;
   //form29.StringGrid2.SetFocus;
   self.Edit12.Text:=result_dest;
   FreeAndNil(Form29);

   if result_dest = EmptyStr then exit;
   get_dest_info();
end;

//procedure TForm10.BitBtn7Click(Sender: TObject);
//begin
//  form11:=Tform11.create(self);
//  form11.ShowModal;
//  FreeAndNil(form11);
//  if not(trim(result_name)='') then
//   begin
//    id_group:=trim(result_name);
//   // Подключаемся к серверу
//   If not(Connect2(Zconnection1, flagProfile)) then
//     begin
//      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
//      Close;
//      exit;
//     end;
//     // Определяем список групп
//     Form10.ZQuery1.SQL.Clear;
//     Form10.ZQuery1.SQL.add('Select * from av_spr_point_group where del=0 and id='+trim(result_name)+';');
//      try
//   form10.ZQuery1.open;
//  except
//    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
//    ZQuery1.Close;
//    Zconnection1.disconnect;
//  end;
//     if Form10.ZQuery1.RecordCount>0 then
//      begin
//          Form10.edit12.text:=trim(Form10.ZQuery1.FieldByName('name').asString);
//      end;
//     end;
//     Form10.Zconnection1.disconnect;
//end;


procedure TForm10.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F5] - Добавить'+#13+'[F7] - Поиск'+#13+'[ENTER] - Выбор'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then Form10.Close;
    // F2 - Сохранить
    if (Key=113) and (Form10.BitBtn3.Enabled=true) then Form10.BitBtn3.Click;

    if (Key=112) or (Key=113) or (Key=27) then  Key:=0;

end;


{$R *.lfm}

end.

