unit route_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, platproc, ZConnection, ZDataset, LConvEncoding, Spin, DB,
  types, Variants;

type

  { TForm18 }

  TForm18 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Image1: TImage;
    Image3: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape8: TShape;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    StaticText1: TStaticText;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit6Enter(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GetNas(aEdit : TEdit; aSpin : TSpinEdit); //выбрать населенный пункт из справочника
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form18: TForm18; 

implementation
uses
  mainopp,route_main,nas;
var
  fl_ch,fl_chkod : byte;
  route_id : string;

{ TForm18 }

procedure TFOrm18.GetNas(aEdit : TEdit; aSpin : TSpinEdit);
begin
   form5:=Tform5.create(self);
  form5.ShowModal;
  FreeAndNil(form5);
  with Form18 do
  begin
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
     try
      form18.ZQuery1.SQL.Clear;
      form18.ZQuery1.SQL.add('select id,name from av_spr_locality where id='+trim(result_kod_nas)+';');
      form18.ZQuery1.open;
     except
      showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
      form18.ZQuery1.close;
      form18.ZConnection1.disconnect;
      exit;
     end;
     // Заполняем все поля edit
     aEdit.Text := form18.ZQuery1.FieldByName('name').asString;
     aSpin.Value := form18.ZQuery1.FieldByName('id').asInteger;
     form18.ZQuery1.Close;
     form18.ZConnection1.Disconnect;
   end;
  end;
end;

procedure TForm18.BitBtn4Click(Sender: TObject);
begin
  form18.Close;
end;

procedure TForm18.BitBtn5Click(Sender: TObject);
begin
     GetNas(FOrm18.Edit8, Form18.SpinEdit3);
      If SpinEdit2.Value = SpinEdit3.Value then
      begin
        showmessagealt('НЕКОРРЕКТНО ! Населенные пункты маршрута совпадают !');
        SpinEdit3.value:=0;
        Edit8.Text:='';
        exit;
      end;
end;

procedure TForm18.Edit1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  If flag_edit_route=2 then
    fl_chkod:=1;
end;


procedure TForm18.Edit6Enter(Sender: TObject);
begin
    if (trim(form18.Edit6.text)='') or (trim(form18.Edit7.text)='') then
      begin
        form18.Edit8.Enabled:=false;
      end
  else
      begin
       form18.Edit8.Enabled:=true;
      end;
end;

procedure TForm18.Edit6Exit(Sender: TObject);
begin
      if (trim(form18.Edit6.text)='') or (trim(form18.Edit7.text)='') then
      begin
        form18.Edit8.Enabled:=false;
        form18.Edit8.Enabled:=false;
      end
  else
      begin
       form18.Edit8.Enabled:=true;
      end;
end;

procedure TForm18.Edit7Exit(Sender: TObject);
begin
      if (trim(form18.Edit6.text)='') or (trim(form18.Edit7.text)='') then
      begin
        form18.Edit8.Enabled:=false;
      end
  else
      begin
       form18.Edit8.Enabled:=true;
      end;
end;

//*****************************************  СОХРАНИТЬ *********************************************************
procedure TForm18.BitBtn3Click(Sender: TObject);
begin
  With FOrm18 do
  begin
   //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
   if (trim(form18.Edit1.text)='') then
      begin
       showmessagealt('Введите код маршрута !');
       exit;
      end;
   if (trim(form18.Edit6.text)='') or (trim(form18.Edit7.text)='') or (SpinEdit1.Value=0) or (SpinEdit2.Value=0) then
      begin
       showmessagealt('Запись данных невозможна.'+#13+'Заполните все обязательные поля с данными !');
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
      Zconnection1.disconnect;
      exit;
     end;

  //Проверка, что код не совпадает
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('SELECT id FROM av_route WHERE del=0 AND kod='+QuotedSTR(trim(Edit1.Text))+';');
     ZQuery1.open;
     If (ZQuery1.RecordCount>0) then
       begin
      if (flag_edit_route=1) OR (fl_chkod=1) then  //если режим добавления или изменен код
      begin
      ZConnection1.Rollback;
      showmessagealt('Маршрут с таким кодом уже существует !'+#13+'Сохранение невозможно !');
      ZQuery1.Close;
      Zconnection1.disconnect;
      exit;
      end;
      end;

  if flag_edit_route=1 then
     begin
  //Проверка, что такие населенные пункты уже есть
 { ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT id FROM av_route WHERE del=0 AND id_nas1='+intTOstr(SpinEdit1.Value)+'AND id_nas2='+intTOstr(SpinEdit2.Value)+';');
//  showmessagealt(ZQuery1.SQL.text);
  ZQuery1.open;
  If ZQuery1.RecordCount>0 then
     begin
      ZConnection1.Rollback;
      showmessagealt('Маршрут с такими населенными пунктами уже существует !'+#13+'Сохранение невозможно !');
      ZQuery1.Close;
      Zconnection1.disconnect;
      exit;
     end;
}
  //Определяем новый максимальный id
        form18.ZQuery1.SQL.Clear;
        form18.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_route;');
        form18.ZQuery1.open;
        route_id:= inttostr(form18.ZQuery1.FieldByName('new_id').asInteger+1);
     end;

 //если меняется тип маршрута, то сбрасываем тариф расписания, если он автоматический
     //if (ComboBox1.ItemIndex<>fl_ch) AND (flag_edit_route=2) then
     //  begin
     //     ZQuery1.SQL.Clear;
     //      ZQuery1.SQL.add('SELECT id_shedule FROM av_shedule_tarif WHERE id_shedule IN ');
     //      ZQuery1.SQL.add('(SELECT id FROM av_shedule WHERE del=0 AND id_route='+route_id+') ');
     //      ZQuery1.SQL.add('and del=0 AND calculation_type=1; ');
     //        //try
     //          ZQuery1.open;
     //        //except
     //        //  showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
     //        //  ZQuery1.Close;
     //        //  Zconnection1.disconnect;
     //        //  exit;
     //        //end;
     //  If  Zquery1.RecordCount>0 then
     //  begin
     //   If dialogs.MessageDlg('Изменение типа маршрута приведет к сбросу тарифа для связанных с ним расписаний !'+#13+'Все равно продолжить ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
     //   begin
     //     ZConnection1.Rollback;
     //     ZQuery1.Close;
     //     ZConnection1.Disconnect;
     //     exit;
     //   end;
     //   fl_ch := ComboBox1.ItemIndex;
     //      ZQuery1.SQL.Clear;
     //      ZQuery1.SQL.add('UPDATE av_shedule_tarif SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule IN ');
     //      ZQuery1.SQL.add('(SELECT id FROM av_shedule WHERE del=0 AND id_route='+route_id+') ');
     //      ZQuery1.SQL.add('and del=0 AND calculation_type=1; ');
     //     // showmessage(ZQuery1.SQL.text);
     //        //try
     //          ZQuery1.open;
     //        //except
     //        //  showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
     //        //  ZQuery1.Close;
     //        //  Zconnection1.disconnect;
     //        //  exit;
     //        //end;
     //    end;
     //  end;

  //Маркируем запись на удаление если режим редактирования
  if flag_edit_route=2 then
      begin
       form18.ZQuery1.SQL.Clear;
       form18.ZQuery1.SQL.add('UPDATE av_route SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+route_id+' and del=0;');
      // showmessagealt(ZQuery1.SQL.text);
       form18.ZQuery1.ExecSQL;
      end;
//Производим запись новых данных
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_route(id_user,createdate,del,kod,type_route,id_nas1,id_nas2,id_nas3,id,id_user_first,createdate_first) VALUES (');
  ZQuery1.SQL.add(inttostr(id_user)+',now(),0, Upper('+QuotedSTR(trim(Edit1.text))+'),'+inttostr(ComboBox1.ItemIndex)+',');
  ZQuery1.SQL.add(intToStr(SpinEdit1.Value)+','+intToStr(SpinEdit2.Value)+','+intToStr(SpinEdit3.Value)+','+route_id+',');

 if flag_edit_route=1 then
  ZQuery1.SQL.add(inttostr(id_user)+',now());');
 if flag_edit_route=2 then
  ZQuery1.SQL.add('NULL,NULL);');
//showmessagealt(ZQuery1.SQL.text);
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

procedure TForm18.BitBtn1Click(Sender: TObject);
begin
  GetNas(FOrm18.Edit6, Form18.SpinEdit1);
  With Form18 do
  begin
  if (trim(Edit6.text)='') or (SpinEdit1.Value=0) then
       BitBtn2.Enabled:=false
  else
    begin
       BitBtn2.Enabled:=true;
       BitBtn2.SetFocus;
    end;
  end;
end;

procedure TForm18.BitBtn2Click(Sender: TObject);
begin
 GetNas(FOrm18.Edit7, Form18.SpinEdit2);
 With Form18 do
  begin
  If SpinEdit1.Value = SpinEdit2.Value then
      begin
        showmessagealt('НЕКОРРЕКТНО ! Населенные пункты маршрута совпадают !');
        SpinEdit2.value:=0;
        Edit7.Text:='';
        exit;
      end;
  if (trim(Edit7.text)='') or (SpinEdit2.Value=0) then
       BitBtn5.Enabled:=false
  else
    begin
       BitBtn5.Enabled:=true;
       BitBtn5.SetFocus;
    end;
  end;
end;

procedure TForm18.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then form18.Close;
    // F2 - Сохранить
    if (Key=113) and (form18.BitBtn3.Enabled=true) then form18.BitBtn3.Click;

     if (Key=112) or (Key=113) or (Key=27) then Key:=0;
end;

// **************************** ВОЗНИКНОВЕНИЕ ФОРМЫ *******************************************
procedure TForm18.FormShow(Sender: TObject);
begin
     fl_ch:= 0;
     route_id := '0';
 With FOrm18 do
 begin
 if flag_access=1 then
     begin
        BitBtn3.Enabled:=false;
     end;
  // Режим редактирования
  if flag_edit_route=2 then
   begin
   BitBtn2.Enabled:=true;
   BitBtn5.Enabled:=true;
   route_id := trim(form17.StringGrid1.Cells[1,form17.StringGrid1.Row]);
      // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   // Определяем данные
   form18.ZQuery1.SQL.clear;
   ZQuery1.SQL.add('select a.id,b.name AS name1,c.name AS name2,d.name AS name3,a.id_nas1,a.id_nas2,a.id_nas3,a.kod,a.type_route from av_route AS a');
   ZQuery1.SQL.add('Left JOIN av_spr_locality AS b ON a.id_nas1=b.id AND b.del=0');
   ZQuery1.SQL.add('Left JOIN av_spr_locality AS c ON a.id_nas2=c.id AND c.del=0');
   ZQuery1.SQL.add('Left JOIN av_spr_locality AS d ON a.id_nas3=d.id AND d.del=0');
   ZQuery1.SQL.add('where a.del=0 AND a.id='+route_id+' ORDER by name1;');
   try
   form18.ZQuery1.open;
   except
     showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+Form18.ZQuery1.SQL.Text);
     Zconnection1.disconnect;
     exit;
   end;

   If ZQuery1.RecordCount<1 then exit;
   If ZQuery1.RecordCount>1 then
    begin
      showmessagealt('Внимание ! В списке маршрутов более одного маршрута с ID='+route_id+' !');
    end;
   // Определяем текущие данные
   Edit1.Text:=ZQuery1.FieldByName('kod').asString;
   Edit6.Text:=form18.ZQuery1.FieldByName('name1').asString;
   Edit7.Text:=form18.ZQuery1.FieldByName('name2').asString;
   Edit8.Text:=form18.ZQuery1.FieldByName('name3').asString;
   SpinEdit1.Value:=ZQuery1.FieldByName('id_nas1').asInteger;
   SpinEdit2.Value:=ZQuery1.FieldByName('id_nas2').asInteger;
   SpinEdit3.Value:=ZQuery1.FieldByName('id_nas3').asInteger;
//   if not(trim(form18.Edit8.Text)='') then form18.Edit8.Enabled:=true;
   ComboBox1.ItemIndex:=ZQuery1.FieldByName('type_route').asInteger;

   ZQuery1.Close;
   Zconnection1.disconnect;

   fl_ch:= ComboBox1.ItemIndex; //запоминаем тип маршрута
   BitBtn1.SetFocus;
   fl_chkod:=0; //флаг изменения кода маршрута
   end;
 end;
 end;



{$R *.lfm}

end.

