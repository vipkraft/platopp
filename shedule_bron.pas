unit shedule_bron;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, strutils;

type

  { TForm_Bron }

  TForm_Bron = class(TForm)
    Bevel2: TBevel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    StaticText1: TStaticText;
    StaticText4: TStaticText;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid4: TStringGrid;
    StringGrid9: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid2DrawCell(Sender: TObject; aCol, aRow: Integer;      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid4BeforeSelection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid4Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid9Selection(Sender: TObject; aCol, aRow: Integer);
    procedure UpdateGridATP();   //  Все перевозчики на расписании
    procedure UpdateGridATS(); //все атс перевозчика на расписании
    procedure UpdateGridBron(); //обновить грид брони
    procedure Update_Schema(); //обновить схему расположения мест в автобусе
    procedure Update_Schema_Bron(); //обновить схему расположения мест БРОНИ в автобусе
    procedure Update_Bron();     //ОБНОВИТЬ ДАННЫЕ ПО БРОНИ
    procedure EditCheck(); //проверка ввода брони
    procedure Set_Bron(); //установка брони на схеме автобуса
    procedure SaveBr();
  private
    { private declarations }
  public
    { public declarations }

  end; 

var
  Form_Bron: TForm_Bron;

implementation

uses
  mainopp,platproc,shedule_main;
var
  shedule_id, copy1 : string;
  arpoints: array of array of string;
  type_mesto1:array[1..5,1..25,1..2] of Integer;
  arbron1,ar_lock: array of integer;
  //type_mesto2:array[1..5,1..25,1..2] of Integer;
  n,m, nbr, k, maxbr, maxBr2: integer;
  fl_ch, atprow,atsrow : byte;
  stmp : string;
  kols1,kols2:integer;


{$R *.lfm}

 // ================================ массив Остановочных =========================================
  //  arpoints - Описание
  //-------------------------------------------------------
  // arpoints[n,0] - порядок остановок
  // arpoints[n,1] - наименование остановки
  // arpoints[n,2] - признак формирования
  // arpoints[n,3] - id остановки
  // arpoints[n,4] - количество мест брони
  // arpoints[n,5] - пользователи
  // arpoints[n,6] - дата установки
  // arpoints[n,7] - забронированные места 1 этажа
  // arpoints[n,8] - забронированные места 2 этажа

  //********  записать в массив Остановочных пунктов кол-во и места брони *****************
procedure TForm_Bron.SaveBr();
var
  k:integer=0;
  chang1: boolean;
begin
  SetLength(arbron1,0);
  arpoints[Form_Bron.ComboBox1.ItemIndex,4]:='';
  sTMp:='';
  Fl_ch:=1;
 for n:=1 to 5 do
         begin
          for m:=1 to 25 do
            begin
              //если броня
              If (type_mesto1[n,m,2]>4) and (type_mesto1[n,m,2]<9) then
                     begin
                         SetLength(arbron1,length(arbron1)+1);
                         arbron1[length(arbron1)-1]:=type_mesto1[n,m,1];
                     end;
            end;
         end;

  // сортировка массива
    repeat
        k:=0;
         Chang1 := FALSE; // пусть в текущем цикле нет обменов
        for n:=low(arbron1) to high(arbron1)-1 do
          if arbron1[n] > arbron1[n+1] then
          begin // обменяем k-й и k+1-й элементы
            k := arbron1[n];
            arbron1[n] := arbron1[n +1];
            arbron1[n +1] := k;
            chang1 := TRUE;
          end;
        until not chang1; // если не было обменов, значит

      //вывод массива
      for n:=low(arbron1) to high(arbron1) do
        sTmp:=sTmp + inttostr(arbron1[n]) + ',';

     sTMp:= copy(STMp,1,length(sTmp)-1);//убираем последнюю запятую в строке

  //если первый этаж
   If Form_Bron.StringGrid9.Cells[3,Form_Bron.StringGrid9.row]='1' then
    begin
      kols1:=(length(arbron1));
      arpoints[Form_Bron.ComboBox1.ItemIndex,7]:= sTmp;
      Form_Bron.Edit1.Text:= sTmp;
    end
  else
  //если второй этаж
  begin
    kols2:=(length(arbron1));
    SetLength(arbron1,0);
    arpoints[Form_Bron.ComboBox1.ItemIndex,8]:= sTmp;
    Form_Bron.Edit2.Text:= sTmp;
  end;

  //общее кол-во мест брони
  arpoints[Form_Bron.ComboBox1.ItemIndex,4]:=inttostr(kols1+kols2);
end;


//************* ОБНОВИТЬ ДАННЫЕ ПО БРОНИ для выбранного перевозчика ************************************************
procedure TForm_Bron.Update_Bron();
var
  k: integer;
  sS,snum:string;
begin
  With Form_Bron do
  begin
      try
        strtoint(stringgrid4.Cells[0,stringgrid4.Row]);
      except
        exit;
      end;
     //обнулить массив брони
   for n:=low(arpoints) to high(arpoints) do
     begin
       arpoints[n,4] := '';
       arpoints[n,5] := '';
       arpoints[n,6] := '';
       arpoints[n,7] := '';
       arpoints[n,8] := '';
     end;
 // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   //запрос списка брони
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('SELECT a.createdate,a.id_user,a.id_point,a.bron_count,a.point_order,a.seats,a.seats2,b.name as username FROM av_shedule_bron AS a ');
    ZQuery1.SQL.add('LEFT JOIN av_users as b ON b.del=0 and b.id=a.id_user ');
    ZQuery1.SQL.add('WHERE a.del=0 AND a.id_kontr='+Stringgrid4.Cells[0,Stringgrid4.Row]+' AND a.id_shedule='+shedule_id+' ORDER BY a.point_order;');
    //showmessagealt(ZQuery1.SQL.text);
    try
       ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ ZQuery1.SQL.Text);
       ZQuery1.close;
       ZConnection1.disconnect;
      exit;
     end;
   if ZQuery1.RecordCount>0 then
     begin
     for k:=1 to Zquery1.RecordCount do
    begin
   //обновить массив брони
   for n:=low(arpoints) to high(arpoints) do
     begin
       If (strtoint(arpoints[n,0])=ZQuery1.FieldByName('point_order').asInteger) AND
       (strtoint(arpoints[n,3])=ZQuery1.FieldByName('id_point').asInteger)  then
       begin
       arpoints[n,4] := ZQuery1.FieldByName('bron_count').asString;
       arpoints[n,5] := ZQuery1.FieldByName('username').asString;
       arpoints[n,6] := ZQuery1.FieldByName('createdate').asString;
       arpoints[n,7] := ZQuery1.FieldByName('seats').asString;
       arpoints[n,8] := ZQuery1.FieldByName('seats2').asString;
       end;
     end;
      Zquery1.Next;
    end;
    end;

   setlength(ar_lock,0);
   // Запрос неснимаемой брони ОПП
   ZQuery1.SQL.clear;
   ZQuery1.SQL.add('Select a.seats FROM av_shedule_hard_bron a WHERE a.del=0 AND a.id_shedule='+(form15.StringGrid1.Cells[0,form15.StringGrid1.row])+';');
   //showmessage(ZQuery1.SQL.Text);//$
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    Stringgrid1.Enabled:=false;
    exit;
  end;
   if ZQuery1.RecordCount>0 then
      begin
        sS:=ZQuery1.FieldByName('seats').AsString;
      end;
     If (length(sS)>0) AND (sS[length(sS)]<>',') then sS:=sS+',';
 /// очистка строки брони от неправильных символов   // подсчет количества мест брони
   for n:=1 to length(sS) do
     begin
       If (sS[n]=',') and (trim(snum)<>'') then
        begin
          setlength(ar_lock,length(ar_lock)+1);
        try
         ar_lock[length(ar_lock)-1]:=strtoint(snum);
        except
        showmessagealt('ОШИБКА преобразования в целое !'+#13+snum);
        continue;
        end;
          //showmessage(snum);
          snum:='';
        end
       else
       begin
        snum:=snum+sS[n];
       end;
     end;
   ZQuery1.close;
   ZConnection1.disconnect;
  UpdateGridBron();
  end;
end;

// ******************* обновить данные по броне на форме и массиве бронированных мест ********************
procedure TForm_Bron.UpdateGridBron();
var
  snum:string;
begin
  with form_bron do
begin
   Form_Bron.StringGrid1.Row:=Form_Bron.Combobox1.ItemIndex+1;
   //обновить грид брони
   for n:=0 to Stringgrid1.RowCount-2 do
     begin
    Stringgrid1.Cells[3,n+1] := arpoints[n,4];
    Stringgrid1.Cells[4,n+1] := arpoints[n,5];
    Stringgrid1.Cells[5,n+1] := arpoints[n,6];
     end;
   n:= ComboBox1.ItemIndex;
   Edit1.Text := '';
   Edit2.Text := '';

  SetLength(arbron1,0);
  //если первый этаж
 If Stringgrid9.Cells[3,Stringgrid9.Row]='1' then
    begin
       Edit1.Text := arpoints[n,7];
  //заполняем массив мест брони первого этажа
  stmp := arpoints[n,7];
    end;
 //если второй этаж
  If Stringgrid9.Cells[3,Stringgrid9.Row]='2' then
   begin
   Edit2.Text:= arpoints[n,8];
  //заполняем массив мест брони второго этажа
  stmp := arpoints[n,8];
  end;
 If (length(stmp)>0) AND (stmp[length(stmp)]<>',') then stmp:=stmp+',';

    for n:=1 to length(sTmp) do
     begin
       If sTmp[n]='-' then continue;
       If (sTmp[n]=',') and (trim(snum)<>'') then
        begin
         setlength(arbron1,length(arbron1)+1);
        try
         arbron1[length(arbron1)-1]:=strtoint(snum);
        except
        showmessagealt('ОШИБКА преобразования в целое !'+#13+snum);
        continue;
        end;
          //showmessage(snum);
          snum:='';
        end
       else
       begin
        snum:=snum+sTmp[n];
       end;
     end;

  //while length(sTmp)>0 do
  //  begin
  //    n:=Pos(',',sTmp);
  //    try
  //      strtoint(copy(sTmp,1,n-1));
  //    except
  //      break;
  //    end;
  //    SetLength(arbron1,length(arbron1)+1);
  //    arbron1[length(arbron1)-1]:=strtoint(copy(sTmp,1,n-1));
  //    sTmp := copy(sTmp,n+1,length(sTmp));
  //  end;

   //если первый этаж
 If Stringgrid9.Cells[3,Stringgrid9.Row]='1' then
    begin
       kols1 := length(arbron1);
    end;
 //если второй этаж
  If Stringgrid9.Cells[3,Stringgrid9.Row]='2' then
   begin
     kols2 := length(arbron1);
  end;

    //обновить бронь на схеме
   Update_Schema_Bron();

   //Если формирующий - запретить ставить бронь
   If trim(arpoints[Form_Bron.Combobox1.ItemIndex,2])='1' then
     begin
        GroupBox1.Enabled:=false;
        //GroupBox3.Enabled:=false;
        GroupBox4.Enabled:=false;
     end
   else
   begin
        GroupBox1.Enabled:=true;
        //GroupBox3.Enabled:=true;
        GroupBox4.Enabled:=true;
     end
   end;
end;



 //============================    обновить схему расположения мест БРОНИ в автобусе  ==========
procedure TForm_Bron.Update_Schema_Bron();
var
  x : integer;
begin
  //очистить схему от брони
  for n:=1 to 5 do
    begin
      for m:=1 to 25 do
        begin
          IF (type_mesto1[n,m,2]>4) and (type_mesto1[n,m,2]<9)  then type_mesto1[n,m,2]:=type_mesto1[n,m,2]-4;
        end;
    end;

 for n:=1 to 5 do
         begin
          for m:=1 to 25 do
            begin
              //ищем это место в массиве мест брони
                     If length(arbron1)>0 then
                     begin
                       for x:=low(arbron1) to high(arbron1) do
                         begin
                           If arbron1[x]=type_mesto1[n,m,1] then
                            type_mesto1[n,m,2]:=type_mesto1[n,m,2]+4;
                         end;
                     end;
                     //If length(arbron2)>0 then
                     //begin
                     //  for x:=low(arbron2) to high(arbron2) do
                     //    begin
                     //      If arbron2[x]=type_mesto1[n,m,1] then
                     //       type_mesto1[n,m,2]:=type_mesto1[n,m,2]+4;
                     //    end;
                     //end;
                 //ищем место в неснимаемой брони
                     If length(ar_lock)>0 then
                     begin
                       for x:=low(ar_lock) to high(ar_lock) do
                         begin
                           If ar_lock[x]=type_mesto1[n,m,1] then
                            type_mesto1[n,m,2]:=type_mesto1[n,m,2]+8;
                         end;
                     end;
            end;
         end;
 Form_Bron.Stringgrid2.Repaint;
end;

//******************************** установка брони на схеме автобуса ***************************************
procedure TForm_Bron.set_Bron();
begin
    With Form_Bron do
     begin
  if (type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,1]=0) then exit;
  if (type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]>8) then exit;
  //если номер места больше количества мест самого маленького АТС, то выход
  If (trim(Stringgrid9.Cells[3,Stringgrid9.Row])='1') AND (type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,1]>maxbr) then exit;
  If (trim(Stringgrid9.Cells[3,Stringgrid9.Row])='2') AND (type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,1]>maxbr2) then exit;

       // Убираем текущий тип из информации
       //if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=1 then
       //   begin
       //     Edit7.text:=inttostr(strtoint( Edit7.Text)-1);
       //   end;
       //if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=2 then
       //   begin
       //     Edit8.text:=inttostr(strtoint( Edit8.Text)-1);
       //   end;
       //if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=3 then
       //   begin
       //     Edit9.text:=inttostr(strtoint( Edit9.Text)-1);
       //   end;

        // Если было забронировано лежачее, снимаем бронь
       if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=7 then
          begin
            type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]:=3;
            type_mesto1[StringGrid2.Col+1, StringGrid2.row+2,2]:=3;
             //Edit7.text:=inttostr(strtoint( Edit7.Text)+2);
             StringGrid2.Repaint;
             SaveBr();
            exit;
          end;
       // Если лежачее, ставим бронь
       if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=3 then
          begin
            type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]:=7;
            type_mesto1[StringGrid2.Col+1, StringGrid2.row+2,2]:=7;
             //Edit7.text:=inttostr(strtoint( Edit7.Text)+2);
            StringGrid2.Repaint;
            SaveBr();
            exit;
          end;
       //если не было, ставим бронь
       if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]<3 then
         begin
            type_mesto1[StringGrid2.Col+1,StringGrid2.row+1,2]:=type_mesto1[StringGrid2.Col+1,StringGrid2.row+1,2]+4;
            StringGrid2.Repaint;
            SaveBr();
            exit;
         end;
       //если установлена бронь, снимаем
       if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]>3 then
         begin
             type_mesto1[StringGrid2.Col+1,StringGrid2.row+1,2]:=type_mesto1[StringGrid2.Col+1,StringGrid2.row+1,2]-4;
             StringGrid2.Repaint;
             SaveBr();
            exit;
         end;

     //
     //     // Ставим текущий тип из информации
     //  if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=1 then
     //     begin
     //       Edit7.text:=inttostr(strtoint( Edit7.Text)+1);
     //     end;
     //  if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=2 then
     //     begin
     //       Edit8.text:=inttostr(strtoint( Edit8.Text)+1);
     //     end;
     //  if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=3 then
     //     begin
     //       Edit9.text:=inttostr(strtoint( Edit9.Text)+1);
     //     end;
     //  // Корректировка места на лежачее
     //  if type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]=3 then
     //     begin
     //       if ( StringGrid2.row=24) or (type_mesto1[StringGrid2.Col+1, StringGrid2.row+2,1]=0) then
     //          begin
     //             showmessagealt('Недостаточно доступных мест ниже для установки типа места [ЛЕЖА] !');
     //              Edit9.Text:=inttostr(strtoint( Edit9.Text)-1);
     //              Edit7.Text:=inttostr(strtoint( Edit7.Text)+1);
     //             type_mesto1[StringGrid2.Col+1, StringGrid2.row+1,2]:=1;
     //              StringGrid2.Repaint;
     //             exit;
     //          end;
     //      //Корректировка на лежачие
     //      if type_mesto1[StringGrid2.Col+1, StringGrid2.row+2,2]=2 then
     //         begin
     //            Edit8.Text:=inttostr(strtoint( Edit8.Text)-1);
     //         end;
     //      if type_mesto1[StringGrid2.Col+1, StringGrid2.row+2,2]=1 then
     //         begin
     //            Edit7.Text:=inttostr(strtoint( Edit7.Text)-1);
     //         end;
     //      type_mesto1[StringGrid2.Col+1, StringGrid2.row+2,2]:=4;
     //    end;
     //end;

     end;
end;



//======================   обновить схему расположения мест в автобусе =================
procedure TForm_Bron.Update_Schema();
 var
   n,m,k:integer;
   namepole:array[1..10] of string;
  // kolmest:array[1..6] of integer;
 begin
   With Form_Bron do
   begin
  //
   If trim(Stringgrid9.Cells[0,Stringgrid9.Row])='' then
   begin
     GroupBox4.Enabled:=false;
     GroupBox1.Enabled:=false;
     exit;
   end
   else
    begin
    GroupBox4.Enabled:=true;
    GroupBox1.Enabled:=true;
    end;

   if  StringGrid9.RowCount=1 then
     begin
       //StringGrid4.Cells[1,1]:='';
       //StringGrid4.Cells[1,2]:='';
       //StringGrid4.Cells[1,3]:='';
       //StringGrid4.Cells[2,1]:='';
       //StringGrid4.Cells[2,2]:='';
       //StringGrid4.Cells[2,3]:='';
          for n:=1 to 5 do
            begin
              for m:=1 to 25 do
               begin
                 StringGrid2.cells[n-1,m-1]:='';
                 type_mesto1[n,m,1]:=0;
                 type_mesto1[n,m,2]:=0;
               end;
            end;
      exit;
    end;
    namepole[1]:= 'one_one';
    namepole[2]:= 'one_two';
    namepole[3]:= 'one_three';
    namepole[4]:= 'one_four';
    namepole[5]:= 'one_five';
    namepole[6]:= 'two_one';
    namepole[7]:= 'two_two';
    namepole[8]:= 'two_three';
    namepole[9]:= 'two_four';
    namepole[10]:='two_five';

   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
   //запрос списка
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('SELECT * FROM av_spr_ats where id='+trim(StringGrid9.Cells[0, StringGrid9.row])+' and del=0;');
    try
       ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ ZQuery1.SQL.Text);
       ZQuery1.close;
       ZConnection1.disconnect;
      exit;
     end;
   if  ZQuery1.RecordCount=0 then
     begin
       ZQuery1.Close;
       Zconnection1.disconnect;
      exit;
     end;
    //for n:=1 to 6 do
    // begin
    //  kolmest[n]:=0;
    // end;
    If Stringgrid9.Cells[3,Stringgrid9.Row]='1' then k:=0 else k:=5; //определяем первый/второй этаж
    //КАРТА ПЕРВОГО И ВТОРОГО ЭТАЖА АВТОБУСА
    for n:=1 to 5 do
         begin
          for m:=1 to 25 do
            begin
               if strtoint(trim(copy(ZQuery1.FieldByName(namepole[n+k]).asString,((m-1)*4+2),3)))=0 then
                   begin
                    type_mesto1[n,m,1]:=0;
                    type_mesto1[n,m,2]:=0;
                     StringGrid2.Cells[n-1,m-1]:='';
                   end
               else
                   begin
                     type_mesto1[n,m,1]:=strtoint(copy( ZQuery1.FieldByName(namepole[n+k]).asString,((m-1)*4+2),3));
                     type_mesto1[n,m,2]:=strtoint(copy( ZQuery1.FieldByName(namepole[n+k]).asString,((m-1)*4+1),1));
                      StringGrid2.Cells[n-1,m-1]:=inttostr(strtoint(copy(ZQuery1.FieldByName(namepole[n+k]).asString,((m-1)*4+2),3)));
                      //место недоступно для установки брони
                      If (k=0) AND (type_mesto1[n,m,1]>maxbr) then
                        type_mesto1[n,m,2] := 4;
                      If (k=5) AND (type_mesto1[n,m,1]>maxbr2) then
                        type_mesto1[n,m,2] := 4;
                     //if type_mesto1[n,m,2]=1 then kolmest[1]:=kolmest[1]+1;
                     //if type_mesto1[n,m,2]=2 then kolmest[2]:=kolmest[2]+1;
                     //if type_mesto1[n,m,2]=3 then kolmest[3]:=kolmest[3]+1;
                     //ищем это место в массиве мест брони
                     //If k=0 then
                     //begin
                     //  for x:=low(arbron1) to high(arbron1) do
                     //    begin
                     //      If arbron1[x]=type_mesto1[n,m,1] then
                     //       type_mesto1[n,m,2]:=type_mesto1[n,m,2]+4;
                     //    end;
                     //end;
                     //If k=5 then
                     //begin
                     //  for x:=low(arbron2) to high(arbron2) do
                     //    begin
                     //      If arbron2[x]=type_mesto1[n,m,1] then
                     //       type_mesto1[n,m,2]:=type_mesto1[n,m,2]+4;
                     //    end;
                     //end;
                   end;
            end;
         end;
   ZQuery1.Close;
   ZConnection1.Disconnect;
   Stringgrid2.Row:=1;
   Stringgrid2.Col:=0;
   Stringgrid2.repaint;
   end;
 end;


procedure TForm_Bron.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   With Form_Bron do
   begin

    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[F4] - Копировать'+#13+'[F5] - Вставить'+#13+'[ПРОБЕЛ] - Установить\Снять бронь'+#13+'[ESC] - Отмена\Выход');
    //F2 - Сохранить
    if (Key=113) and (bitbtn5.enabled=true) then bitbtn5.click;
    //F4 - Копировать
    if (Key=115) and (bitbtn6.enabled=true) then BitBtn6.Click;
    //F5 - Вставить
    if (Key=116) and (bitbtn7.enabled=true) then BitBtn7.Click;
    //F8 - Удалить
    //if (Key=119) and (bitbtn3.enabled=true) then BitBtn3.Click;
    // ESC
    if Key=27 then BitBtn4.Click;
    //Пробел
    If (Key=32) AND (stringgrid2.Focused) then set_bron();

     If not(GroupBox1.Focused) AND not(Stringgrid2.Focused) then
       begin
         If (Key=38) then Combobox1.Setfocus;
         If (Key=40) then Combobox1.Setfocus;
       end;
   end;
    if (Key=112) or (Key=113) or (Key=115) or (Key=116) or (Key=119) or (Key=27) or (Key=32)  then  Key:=0;
end;


procedure TForm_Bron.BitBtn4Click(Sender: TObject);
begin
  Form_Bron.Close;
end;

//********************************** СОХРАНИТЬ ****************************************
procedure TForm_Bron.BitBtn5Click(Sender: TObject);
begin
 With Form_Bron do
  begin
  //Сохраняем данные
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
//помечаем на удаление броню для данного перевозчика на распсании
         ZQuery1.SQL.Clear;
         ZQuery1.SQL.add('UPDATE av_shedule_bron SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_shedule='+shedule_id);
         ZQuery1.SQL.add(' AND id_kontr='+Stringgrid4.Cells[0,Stringgrid4.Row]+' and del=0;');
         try
         ZQuery1.ExecSQL;
         except
           showmessagealt('Ошибка ! SQL запроса: '+ZQuery1.SQL.Text);
           ZQuery1.Close;
           Zconnection1.disconnect;
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
   for n:=low(arpoints) to high(arpoints) do
     begin
       If (trim(arpoints[n,7])='') AND (trim(arpoints[n,8])='') then
          //Если поле брони пустое, ищем запись в базе и удаляем
         begin
           //ZQuery1.SQL.Clear;
           //ZQuery1.SQL.add('UPDATE av_shedule_bron SET del=2,createdate=now() WHERE id_shedule='+shedule_id+' AND id_point='+arpoints[n,3]);
           //ZQuery1.SQL.add(' AND id_kontr='+Stringgrid4.Cells[0,Stringgrid4.Row]+' and del<2;');
           //ZQuery1.open;
           continue;
         end;
           //Производим запись новых данных
           ZQuery1.SQL.Clear;
           ZQuery1.SQL.add('INSERT INTO av_shedule_bron(createdate,id_user,del,id_shedule,id_point,point_order,id_kontr,bron_count,seats,seats2) VALUES (');
           ZQuery1.SQL.add('now(),'+inttostr(id_user)+',0,'+shedule_id+','+arpoints[n,3]+','+arpoints[n,0]+',');
           ZQuery1.SQL.add(Stringgrid4.Cells[0,Stringgrid4.Row]+','+Ifthen(trim(arpoints[n,4])='','0',arpoints[n,4])+','+QuotedStr(arpoints[n,7])+','+QuotedStr(arpoints[n,8])+');');
           //showmessage(ZQuery1.SQL.text);
          ZQuery1.ExecSQL;
   end;
  // Завершение транзакции
  Zconnection1.Commit;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
  ZQuery1.Close;
  Zconnection1.disconnect;
  fl_ch:=0;
  //fl_move:=0;
  //Close;
  showmessagealt('Сохранение Успешно!');
  Update_Bron();
  end;
end;


//*******************************  КОПИРОВАТЬ **************************
procedure TForm_Bron.BitBtn6Click(Sender: TObject);
begin
  With Form_Bron do
  begin
  If Edit1.Enabled then copy1:=Edit1.Text;
  If Edit2.Enabled then copy1:=Edit2.Text;
  end;
end;

//*******************************  ВСТАВИТЬ *******************************
procedure TForm_Bron.BitBtn7Click(Sender: TObject);
begin
  With Form_Bron do
  begin
  If Edit1.Enabled then Edit1.Text:= COPY1;
  If Edit2.Enabled then Edit2.Text:= copy1;
  end;
end;

procedure TForm_Bron.Button1Click(Sender: TObject);
var
  m: integer;
   s:string;
begin
  s:='';
  //for n:=low(arpoints) to high(arpoints) do
  //  begin
  //    for m:=0 to 8 do
  //       begin
  //         If m=1 then continue;
  //         s:=s+' | '+arpoints[n,m];
  //       end;
        //s:=s+#13+ ' |  | ';
      //for m:=7 to 8 do
      //   begin
      //     s:=s+' | '+arpoints[n,m];
      //   end;
    //    s:=s+#13;
    //end;
  //showmessage(inttostr(length(arpoints))+#13+s);

 for n:=low(arbron1) to high(arbron1) do
    begin
       s:= s + inttostr(arbron1[n])+ ' | ';
    end;
 showmessage(s);
  //for m:=1 to 25 do
  //  begin
  //    for n:=1 to 5 do
  //       begin
  //         s:=s+' | '+inttostr(type_mesto1[n,m,1])+' - '+inttostr(type_mesto1[n,m,2])+' || ';
  //       end;
  //    s:= s + #13;
  //  end;
  //
  //showmessage(inttostr(length(type_mesto1))+#13+s);
end;


procedure TForm_Bron.ComboBox1Change(Sender: TObject);
begin
   UpdateGridBron();
end;


//**************** изменение СТРОКИ БРОНИ *************************
procedure TForm_Bron.EditCheck();
VAR
  ss : string;
  k,comma, bron1, bron2: integer;
begin
  With Form_Bron do
  begin
    If trim(Edit1.Text)<>'' then
  begin
    bron1:=0;
    sS := Edit1.Text;
   k:=0;
   comma := 0;

   //проверка на корректность каждый символ
   For n:=1 to length(ss) do
    begin
     //если первый символ запятая, удаляем
     If (sS[n]=',') then
       begin
         If (k=0) then sS[n] := '-';
         If comma=1 then sS[n] := '-';
         If (comma=0) AND (k>0) then
           begin
             comma := 1;
             k :=0;
             end;
         continue;
       end;
     If not(sS[n] in ['0'..'9',',']) then
       begin
           ss[n]:='-';
           continue;
       end;
     If (sS[n] in ['0'..'9']) then
       begin
         If k>1 then sS[n] := '-';
         If k<2 then
           begin
             k := k + 1;
             comma := 0;
           end;
       end;
    end;
   Edit1.Text:= '';
 /// очистка строки брони от неправильных символов   // подсчет количества мест брони

   for n:=1 to length(sS) do
     begin
       If sS[n]='-' then continue;
       If sS[n]=',' then bron1 := bron1 + 1;
       Edit1.Text:= Edit1.text + sS[n];
     end;
   If comma=0 then bron1:=bron1+1;
  end;

    //бронь второго этажа
        If trim(Edit2.Text)<>'' then
  begin
    bron2:=0;
    sS := Edit2.Text;
   k:=0;
   comma := 0;

   //проверка на корректность каждый символ
   For n:=1 to length(ss) do
    begin
     //если первый символ запятая, удаляем
     If (sS[n]=',') then
       begin
         If (k=0) then sS[n] := '-';
         If comma=1 then sS[n] := '-';
         If (comma=0) AND (k>0) then
           begin
             comma := 1;
             k :=0;
             end;
         continue;
       end;
     If not(sS[n] in ['0'..'9',',']) then
       begin
           ss[n]:='-';
           continue;
       end;
     If (sS[n] in ['0'..'9']) then
       begin
         If k>1 then sS[n] := '-';
         If k<2 then
           begin
             k := k + 1;
             comma := 0;
           end;
       end;
    end;
   Edit2.Text:= '';
 /// очистка строки брони от неправильных символов   // подсчет количества мест брони

   for n:=1 to length(sS) do
     begin
       If sS[n]='-' then continue;
       If sS[n]=',' then bron2 := bron2 + 1;
       Edit2.Text:= Edit2.text + sS[n];
     end;
   If comma=0 then bron2:=bron2+1;
  end;
  try
    nbr:=strtoint(arpoints[Combobox1.ItemIndex,4]);
     except


     end;
   if nbr<>(bron1+bron2) then
     begin
      fl_ch:=1;//флаг внесений изменений
      nbr:=bron1+bron2;
     end;
end;
end;

procedure TForm_Bron.Edit1Exit(Sender: TObject);
VAR
  ss : string;
begin
  EditCheck();
  If trim(Edit1.Text)='' then
    begin
      arpoints[Combobox1.ItemIndex,7]:= '';
      exit;
    end;
  //проверка ввода мест брони
  sS := Form_Bron.Edit1.text;
  If ss[length(sS)]=',' then
  sS:=copy(sS,1,length(sS)-1); //убираем последнюю запятую
  Form_Bron.Edit1.Text:= sS;
  arpoints[Combobox1.ItemIndex,7]:= sS;
  arpoints[Combobox1.ItemIndex,4]:= inttostr(nBr);
  Stringgrid1.Cells[3,Combobox1.ItemIndex+1] := inttostr(nBr);
end;

procedure TForm_Bron.Edit2Exit(Sender: TObject);
VAR
  ss : string;
begin
  EditCheck();
  If trim(Edit2.Text)='' then
    begin
      arpoints[Combobox1.ItemIndex,8]:= '';
      exit;
    end;
  //проверка ввода мест брони
  sS := Form_Bron.Edit2.text;
  If ss[length(sS)]=',' then
  sS:=copy(sS,1,length(sS)-1); //убираем последнюю запятую
  Form_Bron.Edit2.Text:= sS;
  arpoints[Combobox1.ItemIndex,8]:= sS;
  arpoints[Combobox1.ItemIndex,4]:= inttostr(nBr);
  Stringgrid1.Cells[3,Combobox1.ItemIndex+1] := inttostr(nBr);
end;

procedure TForm_Bron.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //если были изменения
  If (fl_ch=1) then
      begin
       If dialogs.MessageDlg('Внесенные изменения НЕ будут сохранены !'+#13+'Продолжить выход ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
         CloseAction := caNone;
      end;
end;

//закраска схемы расположения мест
procedure TForm_Bron.StringGrid2DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  with Sender as TStringGrid, Canvas do
  begin
    if (gdFocused in aState) then
     begin
       pen.Width:=3;
       pen.Color:=clYellow;
      if (type_mesto1[aCol+1,aRow+1,2]=1) then Brush.Color:=clBlue; //сидячее
      if (type_mesto1[aCol+1,aRow+1,2]=2) then Brush.Color:=clPurple;//стоячее
      if (type_mesto1[aCol+1,aRow+1,2]=3) then Brush.Color:=clTeal; //лежачее
      if (type_mesto1[aCol+1,aRow+1,2]=4) then Brush.Color:=clSilver; // недоступно для брони
      if (type_mesto1[aCol+1,aRow+1,2]>4) and (type_mesto1[aCol+1,aRow+1,2]<9) then Brush.Color:=clBlack; //БРОНЬ
      if (type_mesto1[aCol+1,aRow+1,2]>8) then Brush.Color:=clRed; //БРОНЬ неснимаемая
       FillRect(aRect);
       Rectangle(aRect.left+1,aRect.Top+1,aRect.Right-2,aRect.Bottom-2);
       Font.Color := clWhite;
       font.Size:=10;
       Font.Style := [fsBold];
       TextOut(aRect.Left + 10, aRect.Top+2, Cells[aCol, aRow]);
    end
  else
     begin
  if (type_mesto1[aCol+1,aRow+1,2]=1) then Brush.Color:=clBlue; //сидячее
  if (type_mesto1[aCol+1,aRow+1,2]=2) then Brush.Color:=clPurple;//стоячее
  if (type_mesto1[aCol+1,aRow+1,2]=3) then Brush.Color:=clTeal; //лежачее
  if (type_mesto1[aCol+1,aRow+1,2]=4) then Brush.Color:=clSilver; // недоступно для брони
  if (type_mesto1[aCol+1,aRow+1,2]>4) and (type_mesto1[aCol+1,aRow+1,2]<9) then Brush.Color:=clBlack; //БРОНЬ
  if (type_mesto1[aCol+1,aRow+1,2]>8) then Brush.Color:=clRed; //БРОНЬ неснимаемая
       FillRect(aRect);
       Font.Color := clWhite;
       font.Size:=8;
       Font.Style := [fsBold];
       TextOut(aRect.Left + 10, aRect.Top+3, Cells[aCol, aRow]);
     end;
  end;
end;

procedure TForm_Bron.StringGrid4BeforeSelection(Sender: TObject; aCol,aRow: Integer);
begin
  ////если были изменения
  //If (fl_ch=1) then
  //    begin
  //      fl_ch:=0;//снимаем флаг изменений
  //     If dialogs.MessageDlg('Внесенные изменения НЕ будут сохранены для перевозчика!'+#13+'Все равно продолжить перемещение ?',mtConfirmation,[mbYes,mbNO], 0)=7 then
  //       begin
  //       fl_move:=1;
  //       end
  //     else
  //     begin
  //     fl_move:=0;
  //     end;
  // end;
   //если были изменения
  If (fl_ch=1) then
      begin
       If dialogs.MessageDlg('Сохранить изменения в брони для '+form_bron.StringGrid4.Cells[1,form_bron.StringGrid4.Row],mtConfirmation,[mbYes,mbNO], 0)=6 then
         begin
          form_bron.BitBtn5.Click;
         end
       else
       begin
        fl_ch:=0;//снимаем флаг изменений
       end;
   end;
end;

procedure TForm_Bron.StringGrid4Selection(Sender: TObject; aCol, aRow: Integer);
begin
  with Form_Bron do
  begin
 //If fl_move=1 then
 //  begin
 //    StringGrid4.Row := atprow;
 //    Stringgrid4.Repaint;
 //    Stringgrid9.SetFocus;
 //    fl_ch:=1;
 //    exit;
 //  end;
  UpdateGridATS();
  Update_schema(); //обновить схему расположения мест автобуса
  Update_Bron();
  //atprow := Form_Bron.StringGrid4.Row;
  Stringgrid9.SetFocus;
  end;
end;

//перемещение по гриду АТС
procedure TForm_Bron.StringGrid9Selection(Sender: TObject; aCol, aRow: Integer);
begin
  with Form_Bron do
  begin
//обновить схему расположения мест автобуса
    If Stringgrid9.Cells[3,Stringgrid9.Row] = '2' then
      begin
      Edit2.Enabled := true;
      Edit1.Enabled := false;
      Label3.Caption:= '2 этаж';
      end
      else
      begin
        Edit2.Enabled := false;
        Edit1.Enabled := true;
        label3.Caption:= '1 этаж';
      end;
  Update_schema();
  UpdateGridBron();
  end;
end;

// ============================= Все АТС перевозчика на расписании  ==========================================
procedure TForm_Bron.UpdateGridATS();
begin
     With Form_Bron do
      begin
        try
          strtoint(stringgrid4.Cells[0,stringgrid4.Row]);
        except
          exit;
        end;
      //проверка комбо
       If trim(ComboBox1.Text)='' then
         begin
           GroupBox3.Enabled:= false;
           exit;
         end
       else
         GroupBox3.Enabled:= true;

       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('SELECT a.id_ats,a.id_kontr,b.level,(b.m_down+b.m_up+b.m_lay) as placeone,(b.m_down_two+b.m_up_two+b.m_lay_two) as placetwo,b.type_ats,b.name FROM av_shedule_ats as a ');
       ZQuery1.SQL.add('LEFT JOIN av_spr_ats as b ON b.del=0 AND b.id=a.id_ats ');
       ZQuery1.SQL.add('WHERE a.del=0 and a.id_kontr='+stringgrid4.Cells[0,stringgrid4.Row]+' AND a.id_shedule='+shedule_id);
       ZQuery1.SQL.add('ORDER BY b.level,placeone,placetwo ASC;');
       //showmessage(ZQuery1.SQL.Text);
     try
       ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ ZQuery1.SQL.Text);
       ZQuery1.close;
       ZConnection1.disconnect;
      exit;
     end;
    If ZQuery1.RecordCount<1 then exit;
    StringGrid9.RowCount:=1;
    maxbr:=0;
    maxbr2:=0;
    for n:=0 to  ZQuery1.RecordCount-1 do
       begin
           StringGrid9.RowCount:= StringGrid9.RowCount+1;
           StringGrid9.cells[0, StringGrid9.RowCount-1]:=ZQuery1.FieldByName('id_ats').asString; //Код АТС
           StringGrid9.cells[1, StringGrid9.RowCount-1]:=ZQuery1.FieldByName('name').asString; //Марка АТС
           StringGrid9.cells[2, StringGrid9.RowCount-1]:=ZQuery1.FieldByName('type_ats').asString; //Тип АТС
           StringGrid9.cells[4, StringGrid9.RowCount-1]:=ZQuery1.FieldByName('placeone').asString; //Мест на первом этаже
           //устанавливаем максимальное возможное место брони на первом этаже
           If n=0 then maxBr := ZQuery1.FieldByName('placeone').asInteger;
        if ZQuery1.FieldByName('type_ats').asInteger=1 then StringGrid9.cells[2, StringGrid9.RowCount-1]:='М2' else StringGrid9.cells[2, StringGrid9.RowCount-1]:='М3'; //Тип
        StringGrid9.cells[3, StringGrid9.RowCount-1]:='1'; //этаж
//если второй этаж
        If ZQuery1.FieldByName('level').asInteger=2 then
        begin
          StringGrid9.RowCount:= StringGrid9.RowCount+1;
           StringGrid9.cells[0, StringGrid9.RowCount-1]:=ZQuery1.FieldByName('id_ats').asString; //Код АТС
           StringGrid9.cells[1, StringGrid9.RowCount-1]:=ZQuery1.FieldByName('name').asString + ' - 2 ЭТАЖ'; //Марка АТС
           StringGrid9.cells[2, StringGrid9.RowCount-1]:=ZQuery1.FieldByName('type_ats').asString; //Тип АТС
           StringGrid9.cells[4, StringGrid9.RowCount-1]:=ZQuery1.FieldByName('placetwo').asString; //Мест на 2 этаже
           //устанавливаем максимальное возможное место брони на 2-м этаже
           If maxBr2=0 then maxBr2 := ZQuery1.FieldByName('placetwo').asInteger;
        if ZQuery1.FieldByName('type_ats').asInteger=1 then StringGrid9.cells[2, StringGrid9.RowCount-1]:='М2' else StringGrid9.cells[2, StringGrid9.RowCount-1]:='М3'; //Тип
        StringGrid9.cells[3, StringGrid9.RowCount-1]:='2'; //этаж
        end;
        ZQuery1.next;
        end;
    //StringGrid9.Repaint;
    ZQuery1.close;
    ZConnection1.disconnect;
    atsrow := Form_Bron.StringGrid9.Row; //запомнить строку грида этажа atc
  end;
end;

// ============================= Все перевозчики на расписании  ==========================================
procedure TForm_Bron.UpdateGridATP();
begin
     With Form_Bron do
      begin
       //проверка комбо
       If trim(ComboBox1.Text)='' then
         begin
           GroupBox3.Enabled:= false;
           exit;
         end
       else
         GroupBox3.Enabled:= true;

       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('SELECT a.id_kontr,b.name FROM av_shedule_atp as a');
       ZQuery1.SQL.add('LEFT JOIN av_spr_kontragent as b ON b.del=0 AND a.id_kontr=b.id');
       ZQuery1.SQL.add('WHERE a.del=0 and a.id_shedule='+ shedule_id +';');
     try
       ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ ZQuery1.SQL.Text);
       ZQuery1.close;
       ZConnection1.disconnect;
      exit;
     end;
    If ZQuery1.RecordCount<1 then exit;
    StringGrid4.RowCount:=1;
    for n:=0 to  ZQuery1.RecordCount-1 do
       begin
           StringGrid4.RowCount:= StringGrid4.RowCount+1;
           StringGrid4.cells[0, StringGrid4.RowCount-1]:=ZQuery1.FieldByName('id_kontr').asString; //Код АТP
           StringGrid4.cells[1, StringGrid4.RowCount-1]:=ZQuery1.FieldByName('name').asString; //Наименование АТП
        ZQuery1.next;
        end;
    ZQuery1.close;
    //ZConnection1.disconnect;
    atprow := Form_Bron.StringGrid4.Row; //запомнить строку грида перевозчиков
  end;
end;


//********************************* ВОЗНИКНОВЕНИЕ ФОРМЫ ************************************************************
procedure TForm_Bron.FormShow(Sender: TObject);
begin
   try strtoInt(form15.StringGrid1.Cells[0,form15.StringGrid1.Row])
   except
      Close;
   end;
    if flag_access=1 then
     begin
        BitBtn5.Enabled:=false;
     end;
   shedule_id:= form15.StringGrid1.Cells[0,form15.StringGrid1.Row];
   Form_bron.StaticText4.Caption := form15.StringGrid1.Cells[2,form15.StringGrid1.Row];
    fl_ch:=0;

   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;

   SetLength(arpoints,0,9);

 //запрос   список остановочных пунктов расписания
 ZQuery1.SQL.clear;
 ZQuery1.SQL.add('SELECT a.id_point,a.point_order,a.form,b.name FROM av_shedule_sostav AS a ');
 ZQuery1.SQL.add('LEFT JOIN av_spr_point as b ON b.del=0 AND a.id_point=b.id ');
 ZQuery1.SQL.add('WHERE a.del=0 AND a.id_shedule='+ shedule_id +' ORDER BY a.point_order ASC;');
 //showmessage(ZQuery1.SQL.text);
 try
 ZQuery1.Open;
 except
   showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
 end;
 if ZQuery1.RecordCount<1 then
     begin
       ZQuery1.close;
       ZConnection1.Disconnect;
       Close;
       exit;
     end;
 SetLength(arpoints,ZQuery1.RecordCount,9);
// Заполняем combo
  ComboBox1.Clear;
  for n:=0 to ZQuery1.RecordCount-1 do
   begin
     If trim(ZQuery1.FieldByName('point_order').asString)='' then continue;
     If trim(ZQuery1.FieldByName('name').asString)='' then continue;
     arpoints[n,0] := trim(ZQuery1.FieldByName('point_order').asString);
     arpoints[n,1] := trim(ZQuery1.FieldByName('name').asString);
     arpoints[n,2] := trim(ZQuery1.FieldByName('form').asString);
     arpoints[n,3] := trim(ZQuery1.FieldByName('id_point').asString);
    If arpoints[n,2]='1' then
     ComboBox1.Items.Add(arpoints[n,0]+'  |  ' + arpoints[n,1])
     else
       ComboBox1.Items.Add(arpoints[n,0]+'  |  ^ ' + arpoints[n,1]);
     ZQuery1.Next;
   end;
   ComboBox1.ItemIndex:=0;


   //заполнить информационный грид брони внизу
   Stringgrid1.RowCount:=1;
  for n:=low(arpoints) to high(arpoints) do
   begin
     Stringgrid1.RowCount := Stringgrid1.RowCount + 1;
     Stringgrid1.Cells[0,Stringgrid1.RowCount - 1] := arpoints[n,0];
     Stringgrid1.Cells[1,Stringgrid1.RowCount - 1] := arpoints[n,3];
     If arpoints[n,2]='1' then
      Stringgrid1.Cells[2,Stringgrid1.RowCount - 1] := arpoints[n,1]
      else
        Stringgrid1.Cells[2,Stringgrid1.RowCount - 1] := '^ '+arpoints[n,1];
        Stringgrid1.Cells[3,Stringgrid1.RowCount - 1] := '-';
   end;

   UpdateGridATP();
   UpdateGridATS();
   Update_schema();
   Update_Bron();
end;

end.

