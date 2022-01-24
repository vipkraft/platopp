unit shedule_tarif;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, Spin, LazUtf8;

type

  { TFormST }

  TFormST = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Button1: TButton;
    CheckBox1: TCheckBox;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label43: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FloatSpinEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;      var CanSelect: Boolean);
    procedure UpdateGrid();  //обновить данные состава расписания
    procedure Tarif_Load(); //загрузка данных текущего тарифа на грид
    function DenyCell(nCol, nRow: Integer):boolean;//*************** проверка на валидность редактирования ячейки
    procedure Edit_Cell(vCol, vRow: Integer); //редактирование ячейки
    procedure Change_Cell(Confirm:boolean); //сохранить в массиве новое значение тарифа и багажа

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormST: TFormST;

implementation
uses
  mainopp,platproc,shedule_edit;
const
    arr_price_size=6;
var
  n,index : integer;
  shed_id,kontr_id,tarif,bagag : string;
  arr_price : array of array of string;

  flagedit :boolean=false;

  //******* arr_price *************
  //------- описание  -------------
  //arr_price[n,0] - id пункта отправления
  //arr_price[n,1] - id пункта назначения
  //arr_price[n,2] - тариф
  //arr_price[n,3] - багаж
  //arr_price[n,4] - порядковый номер пункта отправления
  //arr_price[n,5] - порядковый номер пункта прибытия

{ TFormST }

//************************* изменить значение тарифа и багажа в массиве **********************************
procedure TFormSt.Change_Cell(Confirm:boolean);
begin
   with FormSt do
   begin
   //showmas(arr_price);
    If not Confirm then
       begin
        //возвращаем прежние значения
        If index>-1 then
           begin
            arr_price[index,2]:=tarif;
            arr_price[index,3]:=bagag;
            end;
        exit;
        end;
//если нет еще элемента массива
          If index=-1 then
             begin
                index := length(arr_price);
                setlength(arr_price,index+1,arr_price_size);
                arr_price[index,0] := Stringgrid1.Cells[1,Stringgrid1.Row];
                arr_price[index,1] := Stringgrid1.Cells[Stringgrid1.Col,1];
                arr_price[index,4] := inttostr(Stringgrid1.Row-Stringgrid1.FixedRows+1);
                arr_price[index,5] := inttostr(Stringgrid1.Col-Stringgrid1.FixedCols+1);
               end;
          //записываем новые значения в массив
          tarif:='';
          bagag:='';
          //arr_price[index,2] := stringreplace(FloatSpinEdit1.text,',','.',[]);
          //arr_price[index,3] := stringreplace(FloatSpinEdit2.text,',','.',[]);
          arr_price[index,2] := FloattostrF(FloatSpinEdit1.Value,fffixed,4,2);
          arr_price[index,3] := FloattostrF(FloatSpinEdit2.Value,fffixed,4,2);
       end;
   //button1.click
   end;



//*********************************    редактирование ячейки  *************************************
procedure TFormST.Edit_Cell(vCol, vRow: Integer);
begin
    index := -1;
    FloatSpinEdit1.Value:=0; //тариф
    FloatSpinEdit2.Value:=0; //багаж
    tarif := '';
    bagag := '';
   for n:=low(arr_price) to high(arr_price) do
   begin
     If (trim(arr_price[n,2])='') or (trim(arr_price[n,3])='') then continue;
     If (trim(arr_price[n,2])='0.00') and (trim(arr_price[n,3])='0.00') then continue;
     If (arr_price[n,0]=Stringgrid1.Cells[1,vRow])
     AND (arr_price[n,1]=Stringgrid1.Cells[vCol,1])
     AND (arr_price[n,4]=inttostr(vRow-Stringgrid1.FixedRows+1))
     AND (arr_price[n,5]=inttostr(vCol-Stringgrid1.FixedCols+1)) then
       begin
         index := n;
         tarif := arr_price[n,2];
         bagag := arr_price[n,3];
         try
         FloatSpinEdit1.Value:=strtofloat(tarif); //тариф
         FloatSpinEdit2.Value:=strtofloat(bagag); //багаж
         except
              showmessage('Ошибка конвертации!');
             end;
         arr_price[n,2] := ''; //убираем значение из грида для перерисовки
         arr_price[n,3] := '';
         break;
       end;
   end;

    Stringgrid1.Enabled:=false;
    Panel1.Visible := true;
    FloatSpinEdit1.SetFocus;

end;



//*************** проверка на валидность редактирования ячейки   **********************************************
function TFormST.DenyCell(nCol, nRow: Integer):boolean;
var
  nR: byte=0;
  nC: byte=0;
  m:integer;
begin
   Result := true;
with formST.StringGrid1 do
begin
  If nCol=nRow then exit; //на пересечении одинаковых элементов
  If nRow>nCol then exit;
  //*проходим все колонки искомой строчки в поисках формирующихся
  for n:=4 to nCol-1 do
  begin
    If (Cells[n,0]='1') then nC := nC +1;
  end;
  //*проходим все строчки искомой колонки в поисках формирующихся
  for m:=4 to nRow do
    begin
      If (Cells[m,0]='1') then nR := nR +1;
    end;
  If (nC-nR) =0 then Result := false;//все нормально
end;
end;


//********************************* ВЫБОР ЯЧЕЙКИ НА РЕДАКТИРОВАНИЕ  **********************************************************
procedure TFormST.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer; var CanSelect: Boolean);
begin
   With Sender as TStringGrid do
   begin
      If aRow<4 then exit;
      If aCol<4 then exit;
      If DenyCell(aCol,aRow) then exit;
     //Cells[aCol,aRow]:='1';
   end;
end;

//****************************  //заргузка данных текущего тарифа в массив  ***********************************************
procedure TFormSt.Tarif_Load();
begin
   with formST do
begin
      // Подключаемся к серверу
         If not(Connect2(Zconnection1, flagProfile)) then
            begin
               showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
               exit;
            end;
   //Делаем запрос по ТАРИФУ
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('select * from av_shedule_price where del=0 and id_shedule='+ shed_id +' AND id_kontr='+kontr_id+' ORDER BY point_order ASC;');
   //showmessage(ZQuery1.SQL.Text);
   try
     ZQuery1.open;
   except
     showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
     exit;
   end;
   setlength(arr_price,0,arr_price_size);
   If ZQuery1.RecordCount=0 then
      begin
         //showmessagealt('Не определен состав для данного расписания !');
         ZQuery1.Close;
         Zconnection1.disconnect;
         exit;
      end;
   for n:=1 to ZQuery1.RecordCount do
   begin
      If Stringgrid1.RowCount>(ZQuery1.FieldByName('point_order').AsInteger+3) then
         begin
     //Проверяем на соответствие пункта и порядка
      If ZQuery1.FieldByName('id_point').AsString=Stringgrid1.Cells[1,ZQuery1.FieldByName('point_order').AsInteger+3] then
         begin
   setlength(arr_price,length(arr_price)+1,arr_price_size);
   arr_price[length(arr_price)-1,0] := ZQuery1.FieldByName('id_point').AsString;   //пункт отправления
   arr_price[length(arr_price)-1,1] := ZQuery1.FieldByName('id_point_destination').AsString;//пункт назначения
   arr_price[length(arr_price)-1,2] := ZQuery1.FieldByName('tarif').AsString; //тариф
   arr_price[length(arr_price)-1,3] := ZQuery1.FieldByName('bagazh').AsString;//багаж
   arr_price[length(arr_price)-1,4] := ZQuery1.FieldByName('point_order').AsString;//порядок
   arr_price[length(arr_price)-1,5] := ZQuery1.FieldByName('point_order_dest').AsString;//порядок
   end;
      // else
      //begin
      //    showmessage(ZQuery1.FieldByName('id_point').AsString+#13+inttostr(ZQuery1.FieldByName('point_order').AsInteger+3)+#13+Stringgrid1.Cells[1,ZQuery1.FieldByName('point_order').AsInteger+3]);
      end;
   ZQuery1.Next;
   end;
     ZQuery1.Close;
     Zconnection1.disconnect;
end;
end;



//****************************************     ОБНОВИТЬ ДАННЫЕ СОСТАВА РАСПИСАНИЯ НА ГРИДЕ *********************************
procedure TFormST.UpdateGrid();
var
  n: integer;
begin
   with formST do
begin
    //Stringgrid1.RowCount:=2;
    //Stringgrid1.ColCount:=2;
      // Подключаемся к серверу
         If not(Connect2(Zconnection1, flagProfile)) then
            begin
               showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
               exit;
            end;
   //Делаем запрос по составу
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('select * from av_shedule_sostav where del=0 and id_shedule='+ shed_id +' ORDER BY point_order ASC;');
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
         showmessagealt('Не определен состав для данного расписания !');
         ZQuery1.Close;
         Zconnection1.disconnect;
         FormSt.Close;
         exit;
      end;
   //showmessage(inttostr(Stringgrid1.ColWidths[0])+'|'+inttostr(Stringgrid1.ColWidths[1]));
   Stringgrid1.ColWidths[0] := 0;
   Stringgrid1.RowHeights[0] :=0;
   Stringgrid1.ColWidths[1] := 36;
   Stringgrid1.ColWidths[2] := 145;
   Stringgrid1.ColWidths[3] := 50;
   //Stringgrid1.DefaultRowHeight := 30;
   Stringgrid1.DefaultColWidth:= (Stringgrid1.Width -Stringgrid1.ColWidths[1] -Stringgrid1.ColWidths[2] -Stringgrid1.ColWidths[3]-53) div (ZQuery1.RecordCount-1) ;
   If Stringgrid1.DefaultColWidth < 70 then Stringgrid1.DefaultColWidth:=70;

   for n:=1 to ZQuery1.RecordCount do
   begin
      If ZQuery1.FieldByName('point_order').AsInteger<>n then
         begin
            showmessagealt('Порядок остановочных пунктов НЕ КОРРЕКТЕН !'+#13+'Сначала отредактируйте состав расписания !');
            FormSt.Close;
            break;
         end;
      Stringgrid1.ColCount := Stringgrid1.ColCount +1;
      Stringgrid1.RowCount := Stringgrid1.RowCount +1;
      //заполнение колонок
      Stringgrid1.Cells[Stringgrid1.ColCount -1,0] := ZQuery1.FieldByName('form').AsString;  //формирующийся
      Stringgrid1.Cells[Stringgrid1.ColCount -1,1] := ZQuery1.FieldByName('id_point').AsString; //id остановочного пункта
      Stringgrid1.Cells[Stringgrid1.ColCount -1,2] := ZQuery1.FieldByName('name').AsString; //наименование остановчного пункта
      Stringgrid1.Cells[Stringgrid1.ColCount -1,3] := ZQuery1.FieldByName('t_o').AsString; //наименование остановчного пункта
      //заполнение строк
      Stringgrid1.Cells[0,Stringgrid1.RowCount -1] := ZQuery1.FieldByName('form').AsString; //формирующийся
      Stringgrid1.Cells[1,Stringgrid1.RowCount -1] := ZQuery1.FieldByName('id_point').AsString; //id остановочного пункта
      Stringgrid1.Cells[2,Stringgrid1.RowCount -1] := ZQuery1.FieldByName('point_order').AsString+'|'+ZQuery1.FieldByName('name').AsString; //наименование остановчного пункта
      //Stringgrid1.Cells[1,Stringgrid1.RowCount -1] := ZQuery1.FieldByName('name').AsString;
      Stringgrid1.Cells[3,Stringgrid1.RowCount -1] := ZQuery1.FieldByName('t_o').AsString;
      ZQuery1.Next;
   end;
   Stringgrid1.ColWidths[0] := 0;
   Stringgrid1.RowHeights[0] :=0;
   Stringgrid1.ColWidths[1] := 36;
   Stringgrid1.ColWidths[2] := 145;
   Stringgrid1.ColWidths[3] := 50;
   Stringgrid1.ColWidths[4] := 50;
   Stringgrid1.RowHeights[Stringgrid1.RowCount-1] :=25;
   ZQuery1.Close;
   Zconnection1.disconnect;
  end;
end;


//***********************************      hot keys ***************************************************************************
procedure TFormST.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState  );
begin
   with FormSt do
   begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[ESC] - Отмена\Выход');
    //ESC на панели редактирования
    //ENTER на панели редактирования
    If ((Key=13) or (Key=27)) AND (Panel1.Visible=true) then
       begin
          If (Key=13) then
             begin
             flagedit := true;  //флаг редактирования
             Change_Cell(true);
             end;
          If (Key=27) then
             begin
             Change_Cell(false);
             end;
          FloatSpinEdit1.Value:= 0;
          FloatSpinEdit2.Value:= 0;
          Panel1.Visible := false;
          Stringgrid1.Enabled:=true;
          Stringgrid1.SetFocus;
          key:=0;
         end;
    If stringgrid1.Focused and (Panel1.Visible=false)  then
       begin
          //ENTER или SPACE
          If (Key=13) or (Key=32) then Edit_Cell(stringgrid1.Col,stringgrid1.row);//редактирование ячейки
          end;
    //F2 - Сохранить
    if (Key=113) and (formST.bitbtn3.enabled=true) then  formST.bitbtn3.click;
    // ESC
    if Key=27 then formST.Close;

    if (Key=112) or (Key=113) or (Key=116) or (Key=119) or (Key=27) or (Key=13) or (Key=32) then Key:=0;
   end;

end;


//************************************* ЗАКРЫТИЕ ФОРМЫ ******************************************************
procedure TFormST.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   If flagedit then
      if dialogs.MessageDlg('Изменения НЕ будут СОХРАНЕНЫ !!!'+#13+'Продолжить выход ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
        begin
          CloseAction := caNone;
          exit;
        end;
end;

procedure TFormST.BitBtn4Click(Sender: TObject);
begin
  FormSt.Close;
end;

//*************************************         СОХРАНИТЬ             ******************************
procedure TFormST.BitBtn3Click(Sender: TObject);
begin
  With FormST do
  begin
  //Сохраняем данные
   //если копия уже готового расписания
    If new_id<>'0' then shed_id:=new_id;

   //******** если удалить записи
   If CheckBox1.Checked then
     begin
      if dialogs.MessageDlg('ВСЕ измененные значения тарифной стоимости билета и багажа будут удалены !!!'+#13+'Продолжить удаление ?',mtConfirmation,[mbYes,mbNO], 0)=7 then exit;

      // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

         ZQuery1.SQL.Clear;
         ZQuery1.SQL.add('UPDATE av_shedule_price SET del=2,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+shed_id);
         ZQuery1.SQL.add(' AND id_kontr='+kontr_id+' and del=0;');
         //showmessage(' '+ZQuery1.SQL.Text);//$
         try
         ZQuery1.ExecSQL;
           //ZQuery1.open;
         except
           showmessagealt('Ошибка ! SQL запроса: '+ZQuery1.SQL.Text);
           ZQuery1.Close;
           Zconnection1.disconnect;
           exit;
         end;
        showmessagealt('УДАЛЕНО УСПЕШНО ! ');
        FormSt.Close;
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
      showmessage('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      ZConnection1.Rollback;
      exit;
     end;


    //помечаем на удаление записи стоимости тарифа и багажа для данного перевозчика на распсании
         ZQuery1.SQL.Clear;
         ZQuery1.SQL.add('UPDATE av_shedule_price SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+shed_id);
         ZQuery1.SQL.add(' AND id_kontr='+kontr_id+' and del=0;');
         //showmessage(ZQuery1.SQL.Text);//$
         //try
         ZQuery1.ExecSQL;
         //except
         //  showmessagealt('Ошибка ! SQL запроса: '+ZQuery1.SQL.Text);
         //  ZQuery1.Close;
         //  Zconnection1.disconnect;
         //  exit;
         //end;

       //showmessage(inttostr(length(arr_price)));

   for n:=0 to length(arr_price)-1 do
     begin
       If (trim(arr_price[n,2])='') and (trim(arr_price[n,3])='') then continue;
       If (trim(arr_price[n,2])='0.00') and (trim(arr_price[n,3])='0.00') then continue;
        //Проверяем на соответствие пункта и порядка
       If (arr_price[n,0]<>Stringgrid1.Cells[1,strtoint(arr_price[n,4])+3])  then
         begin
            //showmessage(inttostr(n)+#13+arr_price[n,0]+'|'+arr_price[n,1]+'|'+arr_price[n,4]+'|'+arr_price[n,5]+
                         //#13+Stringgrid1.Cells[1,strtoint(arr_price[n,4])+3]);//$
            continue;
          end;
           //Производим запись новых данных
           ZQuery1.SQL.Clear;
           ZQuery1.SQL.add('INSERT INTO av_shedule_price(createdate,id_user,del,id_shedule,id_kontr,id_point,id_point_destination,tarif,bagazh,point_order,point_order_dest) VALUES (');
           ZQuery1.SQL.add('now(),'+inttostr(id_user)+',0,'+shed_id+','+kontr_id+','+arr_price[n,0]+','+arr_price[n,1]+','+arr_price[n,2]+','+arr_price[n,3]+','+arr_price[n,4]+','+arr_price[n,5]+');');
           //showmessage(ZQuery1.SQL.text);//$
          ZQuery1.ExecSQL;
     end;
  // Завершение транзакции
  Zconnection1.Commit;
 except
     ZConnection1.Rollback;
     showmessage('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
  ZQuery1.Close;
  Zconnection1.disconnect;
  flagedit := false;
  showmessagealt('Сохранение Успешно !');
  FormSt.Close;
  end;

end;

procedure TFormST.Button1Click(Sender: TObject);
begin
  showmas(arr_price);
end;

procedure TFormST.FloatSpinEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  flagedit := true;
end;



//********************************************          ВОЗНИКНОВЕНИЕ ФОРМЫ **********************************************************
procedure TFormST.FormShow(Sender: TObject);
begin
   decimalseparator:='.';
   with formST do
begin
    shed_id := idshed;

     //form15.StringGrid1.Cells[0,form15.StringGrid1.row];
   Label2.Caption:= Form16.Edit5.Text;
   kontr_id :=  form16.StringGrid6.Cells[0,form16.StringGrid6.Row];
   Label4.Caption:= form16.StringGrid6.Cells[1,form16.StringGrid6.Row];
   UpdateGrid();
   Tarif_Load();
   Panel1.Visible:= false;
  end;
end;



//******************************** ОТРИСОВКА ГРИДА ********************************************************************************
procedure TFormST.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
  m,k : integer;
begin
  with Sender as TStringGrid, Canvas do
   begin
     AntialiasingMode:=amOff;
     //Font.Quality:=fqDraft;
         // Фон ячеек для редактирования
        //заголовок
           If ((aRow<4) OR (aCol<4)) then
              begin
                 //---Если формирующийся
               if (Cells[0,aRow]='1') or (Cells[aCol,0]='1') then
                  begin
                    Brush.Color:= clYellow;
                  end
               else Brush.Color:= clCream; //rgbtocolor(234,194,94);
               FillRect(aRect);
              end;

      If (aRow>3) and (aCol>3) then
       begin
          Brush.Color:= clWhite;
          FillRect(aRect);
           //при выделении
         if (gdSelected in aState) then
           begin
            pen.Width:=2;
            pen.Color:=clRed;
            canvas.Rectangle(aRect.left+1,aRect.top+1,aRect.right-1,aRect.bottom-1);
            MoveTo(aRect.left-5,aRect.bottom);
            LineTo(aRect.right,aRect.top);
           end
         else
         begin
         pen.Width:=1;
         pen.Color:=clBlack;
         canvas.Rectangle(aRect.left,aRect.top,aRect.right,aRect.bottom);
         MoveTo(aRect.left,aRect.bottom);
         LineTo(aRect.right,aRect.top);
         end;
       end;

           //---Если вариант недопустим - закрашиваем серым
           If (aCol>3) AND (aRow>3) then
             begin
               //на пересечении одинаковых элементов
               //if ((Cells[1,aRow]=Cells[aCol,1])) then //or (aRow>aCol) then
               //begin
               // Brush.Color:=clGray;
               // FillRect(aRect);
               //end
               //else
               //или если дальше следующего формирующегося
               If DenyCell(aCol,aRow) then
               begin
                 //showmessage(inttostr(aCol));
                   Brush.Color:=clSilver;
                   FillRect(aRect);
                   pen.Width:=1;
                   pen.Color:=clBlack;
                   canvas.Rectangle(aRect.left,aRect.top,aRect.right,aRect.bottom);
               end
               else
               begin
                  //---- данные тарифа и багажа

              font.Size:=10;
              font.Style:=[fsBold];

              //отрисовка данных текущего тарифа на гриде
               for m:=low(arr_price) to high(arr_price) do
               begin
                 If (arr_price[m,2]='0.00') and (arr_price[m,3]='0.00') then continue;
                 If (trim(arr_price[m,2])='') and (trim(arr_price[m,3])='') then continue;
                 //for n:=4 to Stringgrid1.RowCount-1 do
                 // begin
                 //   for k:=4 to Stringgrid1.ColCount-1 do
                 //     begin
                        If (Stringgrid1.Cells[1,aRow]=arr_price[m,0])
                        AND (Stringgrid1.Cells[aCol,1]=arr_price[m,1])
                        AND (arr_price[m,4]= inttostr(aRow-Stringgrid1.FixedRows+1))
                        AND (arr_price[m,5]= inttostr(aCol-Stringgrid1.FixedCols+1)) then
                        begin
               font.color:=clRed;
               TextOut(aRect.left+5, aRect.Top+5, arr_price[m,2]);
               font.color:=clBlue;
               TextOut(aRect.right-50, aRect.bottom-20, arr_price[m,3]);
               end;
               //end;
               //end;
               end;
               end;
             end;

       //--- заголовок
       If ((aRow<4) OR (aCol<4)) then
             begin
              font.color:=clBlack;
              font.Size:=11;
              font.Style:=[];
              If (aRow=2) or (aCol=2) then font.Size:=10; //наименование остановочных пунктов
              TextOut(aRect.left+3, aRect.Top+10, Cells[aCol,aRow]);
             end;
   end;
end;




{$R *.lfm}

end.

