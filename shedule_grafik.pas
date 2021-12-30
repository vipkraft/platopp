unit shedule_grafik;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Spin, ExtCtrls, Buttons, dateutils, ZDataset, ZConnection;

type

  { TFormgr }

  TFormgr = class(TForm)
    BitBtn4: TBitBtn;
    Button1: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Image2: TImage;
    Image8: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Shape4: TShape;
    SpinEdit1: TSpinEdit;
    StaticText1: TStaticText;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn4ChangeBounds(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure calendar_day();
    procedure rulebus(); //НЕ ИСПОЛЬЗУЕТСЯ !
    procedure vihod; // запрос к базе на ПРИЗНАК ВЫХОДА НА КОНКРЕТНЫЙ ДЕНЬ
    procedure SpinEdit1Change(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;  aRect: TRect; aState: TGridDrawState);
    procedure sezonget;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Formgr: TFormgr;
  masday:array of array of byte;
  ardate: array of byte;

implementation
 uses
   mainopp,platproc,shedule_edit;

 { TFormgr }
 var
   nmonth, nyear : integer;
   minDate, maxDate,firstdate : TDateTime;
    sdate:string;

//======================   masday - описание массива   =====================================
//
// masday[n,0] - число месяца
// masday[n,1] - флаг активного числа месяца
// masday[n,2] - четное - 0,нечетное - 1
// masday[n,3] - номер недели месяца
// masday[n,4] - день недели
// masday[n,5] - 1 - если выбранный период не входит в диапазон действия расписания
//==================================================================================


//********************************** ПРИЗНАК ВЫХОДА НА КОНКРЕТНЫЙ ДЕНЬ  *******************************************************
procedure TFormgr.sezonget;
var
  n,m,days:integer;
  Check:boolean=true;
 arSezon : array of array of String;
begin

 //DecodeDate(firstdate,Y2, M2, D2);
 //IF M3>nmonth then  Check:=false;
 If firstdate>maxDate then Check:=false;

 //формируем основной массив
   setlength(masday,0,0);
   setlength(arSezon,0,2);

   If Check then GetSezon(firstdate,mindate+days-1,sdate,arSezon);
//showmas(arSezon);

  for m:=0 to days-1 do
    begin
      //заполняем массив
      SetLength(masday,length(masday)+1,6);
      masday[length(masday)-1,0] := m;
      masday[length(masday)-1,1] := 0;
      //день выходит за границу диапазона
      If ((mindate+m)<form16.DateEdit1.date) OR ((mindate+m)>form16.DateEdit2.date) then
         masday[length(masday)-1,5] := 1
         else masday[length(masday)-1,5] := 0;
     If not Check then continue;
     If (mindate+m) < Form16.DateEdit3.Date then continue;
     //определяем флаг выхода
     If arSezon[m+length(arSezon)-DaysInaMonth(nyear,nmonth),1]='1' then  //признак осуществления перевозки АТП
      masday[length(masday)-1,1] := 1;
    end;

  arSezon:=nil;
end;


 //**********************************ЗАПРОС    ПРИЗНАК ВЫХОДА НА КОНКРЕТНЫЙ ДЕНЬ  *******************************************************
procedure TFormgr.vihod;
var
  n,m:integer;
begin

 //формируем основной массив
   setlength(masday,0,0);

 // Подключаемся к серверу
   If not(Connect2(formGr.ZConnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

   for m:=0 to DaysInAMonth(nyear, nmonth)-1 do
    begin
      //заполняем массив
      SetLength(masday,length(masday)+1,6);
      masday[length(masday)-1,0] := m; //день месяца
      masday[length(masday)-1,1] := 0; //признак выхода

      //день выходит за границу диапазона
      If ((mindate+m)<form16.DateEdit1.date) OR ((mindate+m)>form16.DateEdit2.date) then
         masday[length(masday)-1,5] := 1
         else masday[length(masday)-1,5] := 0;

   //masday[n,3] - номер недели месяца
    FormGr.ZQuery1.SQL.Clear;
    FormGr.ZQuery1.SQL.add('Select case (cast(EXTRACT(WEEK FROM DATE '+quotedstr(datetostr(mindate+m))+') as integer) %4) when 0 ');
    FormGr.ZQuery1.SQL.add('then 4 else (cast (EXTRACT(WEEK FROM DATE '+quotedstr(datetostr(mindate+m))+') as integer) %4) END as num;');
    //showmessage(FormGr.ZQuery1.SQL.Text);//$
     try
      FormGr.ZQuery1.open;
    except
     showmessage('ОШИБКА запроса к базе данных !'+#13+FormGr.ZQuery1.SQL.Text);
     FormGr.ZQuery1.Close;
     FormGr.Zconnection1.disconnect;
    end;
     If FormGr.ZQuery1.RecordCount>0 then
          masday[length(masday)-1,3] := formGr.ZQuery1.FieldByName('num').AsInteger;

    //определяем флаг выхода
    FormGr.ZQuery1.SQL.Clear;
    FormGr.ZQuery1.SQL.add('SELECT getsezon('+quotedstr(sdate)+','+quotedstr(datetostr(form16.DateEdit3.date))+','+quotedstr(datetostr(mindate+m))+') as res;');
    //showmessage(FormGr.ZQuery1.SQL.Text);//$
    try
      FormGr.ZQuery1.open;
    except
     showmessage('ОШИБКА запроса к базе данных !'+#13+FormGr.ZQuery1.SQL.Text);
     FormGr.ZQuery1.Close;
     FormGr.Zconnection1.disconnect;
    end;

    If FormGr.ZQuery1.RecordCount>0 then
      If formGr.ZQuery1.FieldByName('res').AsBoolean=true then
        masday[length(masday)-1,1] := 1;
  end;
     FormGr.ZQuery1.Close;
     FormGr.Zconnection1.disconnect;

end;


//************************************(НЕ ИСПОЛЬЗУЕТСЯ !)      расчет массива выхода ************************************************


// ================================= ARDATE - описание массива =========================================
  //
  //   ardate[0]:= ;  id АТП
  //   ardate[1]-[12]:= ;  Номера месяцев
  //   ardate[13]:= ;        Категория /Дни месяца
  //   ardate[15]:= ;        Категория /Переодичность\недели
  //   ardate[16]-[19]:= ; Недели
  //   ardate[20]-[26]:= ; Дни недели
  //   ardate[27]-[29]:= ; Периодичность
  //   ardate[30]-[60]:= ; Дни месяца
  //   ardate[61]:= ;        Категория /Осуществление перевозки каждый n день
  //   ardate[62]:= ;        Каждый n день
 procedure TFormgr.rulebus();
 var
   n,s,z,m,k:integer;
   Y1, M1, D1:Word;
   Y2, M2, D2:Word;
   tekDate,tDate : TDateTime;
 begin
   // Заполняем массив первоначальными данными

  //ОТВАЛ, если месяц вне диапазона
    tekDate := EncodeDate(nyear,nmonth,1);
    If (tekDate>form16.DateEdit2.Date) then exit;
    tekDate := tekDate + 31;
    if (tekDate<form16.DateEdit1.Date) then exit;
//формируем основной массив
   setlength(masday,0,0);
   setlength(masday,DaysInAMonth(nyear, nmonth),6);
   s:=DayOftheWeek(EncodeDate(nyear,(nmonth),1)); //день недели 1-го числа месяца
   //showmessage('y='+inttostr(nyear)+' |m='+inttostr(nmonth)+' |s='+inttostr(s));
   //if s=0 then s:=1;
   z:=1;
   for n:=0 to DaysInAMonth(nyear, nmonth)-1 do
     begin
       // Число месяца
       masday[n,0]:= n+1;
       // Флаг активного числа месяца
       masday[n,1]:=0;
       // Чет\Неч
       if (((n+1) mod 2)>0) then masday[n,2]:=1 else masday[n,2]:=0;
       // Неделя
       if s>7 then
        begin
         s:=1;
         z:=z+1;
        end;
        if z>4 then z:=1;
        masday[n,3]:= z;
       // День недели
       masday[n,4] := s;

       s:=s+1;

       //Если не входит в диапазон действия расписания
       tekDate := EncodeDate(nyear,nmonth,masday[n,0]);
       if (tekDate<form16.DateEdit3.Date) or (tekDate>form16.DateEdit2.Date) then
             masday[n,5]:=1
       else
             masday[n,5]:=0;
     end;

   SetLength(ardate, 0);
   //переносим данные сезонности для выбранного перевозчика в массив ardate
    SetLength(ardate, length(mas_date[0]));
   for n:=0 to length(mas_date)-1 do
      begin
        if trim(mas_date[n,0])=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
         begin
           For m:=low(ardate) to high(ardate) do
             begin
               try
               ardate[m] := strToint(mas_date[n,m]);
               except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'formgr01');
               break;
             end;
             end;
         end;
      end;
      end;

    //1-Месяцы + Числа месяца
    if ardate[13]=1 then
      begin
       // Проверяем что месяц удовлетворяет
      if ardate[nmonth]=0 then exit;
       // Проверяем на доступные числа
       for n:=30 to 60 do
         begin
           if ardate[n]=1 then
             begin
               if n-29 <= DaysInAMonth(nyear, nmonth) then masday[n-30,1]:=1;
             end;
         end;
      end;

    //2-Дата активации +  Категория-  Осуществление перевозки каждый n день\ Порядок первозчиков выполения расписания
    if ardate[61]>0 then
      begin
       // Проверяем что месяц удовлетворяет
      if ardate[nmonth]=0 then exit;
      //определить дату активации и n-ый день перевозки в соответствии с порядком перевозчика в списке АТП данного расписания
      tDate := form16.DateEdit3.Date;
      k:= ardate[62];

      If ardate[61]>1 then
        begin
          tDate := tDate + ardate[62] -1;
          k := ardate[61];
        end;
       // Определяем точку отсчета
       s:=((DaysBetween(tDate,EncodeDate(nyear,(nmonth),1))) mod ardate[62])-1;
       // Расчет
       //Смещаем на количество дней реальной даты
       DecodeDate(tDate,Y1, M1, D1);
       DecodeDate(EncodeDate(nyear,(nmonth),1),Y2, M2, D2);
      if (M1=M2) and (Y1=Y2) then
         begin
          z:=D1-1;
          s:=k-1
         end
       else
         begin
          z:=0;
          if s<0 then s:=k-abs(s);
         end;

       for n:= z to DaysInAMonth(nyear, nmonth)-1 do
        begin
          if masday[n,5]=0 then
            begin
            s:=s+1;
            if s = k then
              begin
                masday[n,1]:=1;
                s:=0;
              end;
           end;
        end;
      end;
       //3-Месяцы + Условия
    if ardate[15]=1 then
      begin
      //если отмечены хотя бы одна неделя или день недели месяца
      If ((ardate[16]=1) or (ardate[17]=1) or (ardate[18]=1) or (ardate[19]=1)) and
         ((ardate[20]=1) or (ardate[21]=1) or (ardate[22]=1) or (ardate[23]=1) or
          (ardate[24]=1) or (ardate[25]=1) or (ardate[26]=1))    then
      begin
      // Проверяем что месяц удовлетворяет
      if ardate[nmonth]=0 then exit;

       for n:=0 to DaysInAMonth(nyear, nmonth)-1 do
          begin
            // Проверка что нужная неделя
            if  ((masday[n,3]=1) and (ardate[16]=1)) or
                ((masday[n,3]=2) and (ardate[17]=1)) or
                ((masday[n,3]=3) and (ardate[18]=1)) or
                ((masday[n,3]=4) and (ardate[19]=1)) then
                  begin
                    //День недели
                    if  ((masday[n,4]=1) and (ardate[20]=1)) or
                        ((masday[n,4]=2) and (ardate[21]=1)) or
                        ((masday[n,4]=3) and (ardate[22]=1)) or
                        ((masday[n,4]=4) and (ardate[23]=1)) or
                        ((masday[n,4]=5) and (ardate[24]=1)) or
                        ((masday[n,4]=6) and (ardate[25]=1)) or
                        ((masday[n,4]=7) and (ardate[26]=1)) then
                           begin
                            //Четное\Нечетное
                            //Все
                            if (ardate[27]=1) then masday[n,1]:=1;
                            //Четные
                            if (ardate[28]=1) and (masday[n,2]=0) then masday[n,1]:=1;
                            //Нечетный
                            if (ardate[29]=1) and (masday[n,2]=1) then masday[n,1]:=1;
                           end;
                  end;
          end;
      end;
      end;
 end;



procedure Tformgr.calendar_day();
 var
    n,m,k,y,days:integer;
 begin
   For n:=1 to formgr.StringGrid1.RowCount-1 do
     begin
       formgr.StringGrid1.Rows[n].Clear;
     end;
   if trim(formgr.ComboBox1.Text)='' then exit;

   sdate:='';
   nmonth := formgr.ComboBox1.ItemIndex+1;
   nyear :=  formgr.SpinEdit1.Value;
    days:=DaysInAMonth(nyear, nmonth);
  maxDate:= EncodeDate(nyear,nmonth,Days);
  minDate:= EncodeDate(nyear,nmonth,1);
  //DecodeDate(form16.DateEdit1.Date,Y1, M1, D1); //дата начала диапазона
  //DecodeDate(form16.DateEdit2.Date,Y2, M2, D2); //дата конца периода
  //DecodeDate(form16.DateEdit3.Date,Y3, M3, D3); //дата активации
  //ОТВАЛ, если вне диапазона
  //If (nyear<Y1) AND (nyear>Y2) then exit;
  //ОТВАЛ, если месяц вне диапазона
  //If (nmonth<M1) AND (nmonth>M2) then exit;
    If minDate>form16.DateEdit2.Date then exit;
    If maxDate<form16.DateEdit1.Date then exit;
  //поиск перевозчика в массиве
  for n:=0 to length(mas_date)-1 do
    begin
      if trim(mas_date[n,0])=trim(form16.StringGrid6.cells[0,form16.StringGrid6.row]) then
        begin
        For m:=1 to 62 do
          begin
            sdate := sdate + mas_date[n,m]; //строка сезонности
          end;
        break;
        end;
    end;

 //определяем местонахождение даты активации в месяце
 firstdate:= form16.DateEdit3.Date;
 If firstdate<minDate then firstdate:=minDate;
 //If M3<nmonth then firstdate:= tekdate;

If formgr.CheckBox1.Checked then
   formgr.vihod //ПРИЗНАК ВЫХОДА НА КОНКРЕТНЫЙ ДЕНЬ
   else
     sezonget;

 //Рисуем GRID
   y:=1;
   k:=DayOfTheWeek(EncodeDate(nyear,nmonth,1));
   //showmessage('y='+inttostr(nyear)+' |m='+inttostr(nmonth)+' |k='+inttostr(k));
   //if k=0 then k:=1;
   for n:=1 to DaysInAMonth(nyear, nmonth) do
     begin
       if k>7 then
        begin
         k:=1;
         y:=y+1;
        end;
       formgr.StringGrid1.Cells[k-1,y]:=inttostr(n);
       k:=k+1;
     end;
 end;

 procedure TFormgr.SpinEdit1Change(Sender: TObject);
 begin
    formgr.calendar_day();
 end;


 procedure TFormgr.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
 var
   nday:integer=0;
 begin
    // Рисуем GRID
  with Sender as TStringGrid, Canvas do
   begin
      Brush.Color:=clWhite;
      FillRect(aRect);
     {font.Name:='default';
      font.Pitch:=fpDefault;
      font.Quality:=fqDefault;}

    {if (gdSelected in aState) then
          begin
           pen.Width:=4;
           pen.Color:=clBlue;
           MoveTo(aRect.left,aRect.bottom-1);
           LineTo(aRect.right,aRect.Bottom-1);
           MoveTo(aRect.left,aRect.top-1);
           LineTo(aRect.right,aRect.Top);
           Font.Color := clGreen;
           font.Size:=10;
           font.Style:= [];
          end
        else
         begin}
           font.Style:= [];
           Font.Color := clBlack;
           font.Size:=12;
       //  end;
       If (aRow>0) and (trim(Cells[aCol,aRow])<>'') then
        begin
         //showmessage(Cells[aCol, aRow]);
         //sim:=trim(Cells[aCol, aRow]);
         try
          nday:=strtoint(Cells[aCol, aRow]);
         except
          on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+#13+'formgr02');
               exit;
             end;
         end;
        end;


     // Рисуем закрашенное число
     //if (aRow>0) and not(trim(Cells[aCol, aRow])='')  and (masday[nday-1,5]=0) then
      if (aRow>0) then
        If not(trim(Cells[aCol, aRow])='') then
          If (length(masday)>0) then
            If (masday[nday-1,5]=0) then
         begin
          if masday[nday-1,1]=1 then
             begin
               Brush.Color:=clYellow;
               FillRect(aRect.left+5,aRect.top+5,aRect.right-7,aRect.bottom-7);
             end;
         end;

     // Рисуем запрещенное число
     if (aRow>0) and not(trim(Cells[aCol, aRow])='') then
        If (length(masday)>0) then
        If  (masday[nday-1,5]=1) and (MonthOfTheYear(Form16.DateEdit3.Date)=(formGr.ComboBox1.ItemIndex+1)) then
         begin
            pen.Width:=4;
            pen.Color:=clRed;
            MoveTo(aRect.left+5,aRect.top+5);
            LineTo(aRect.right-5,aRect.Bottom-5);
            MoveTo(aRect.right-5,aRect.top+5);
            LineTo(aRect.left-5,aRect.bottom-5);
         end;

     //Перевозчики
     {if (aRow>0) and (aCol=3) and not(trim(cells[5,aRow]) = '') then
      begin
        Font.Size:=10;
        Font.Color := clGreen;
        TextOut(aRect.Left + 5, aRect.Top+18, 'Имеет договор перевозки');
      end;}

     // Числа
     if (aRow>0) then
        begin
         Font.Size:=18;
         if aCol<5 then Font.Color := clBlack else Font.Color := clRed;
         TextOut(aRect.Left + 10, aRect.Top+2, Cells[aCol, aRow]);
        end;

     // Четные\Нечетные
     if (aRow>0) and not(trim(Cells[aCol, aRow])='') then
        begin
         Font.Size:=12;
         Font.Color := clGreen;
         if (nday mod 2)>0 then TextOut(aRect.Left + 10, aRect.Top+30, 'Нечетное');
         if (nday mod 2)=0 then TextOut(aRect.Left + 10, aRect.Top+30, 'Четное');
        end;

     // Недели
     if (aRow>0) and not(trim(Cells[aCol, aRow])='') then
       If (length(masday)>0) then
        begin
         Font.Size:=12;
         Font.Color := clGray;
         TextOut(aRect.Left + 10, aRect.Top+45, inttostr(masday[nday-1,3])+'-Неделя');
         //if aRow<5 then TextOut(aRect.Left + 10, aRect.Top+45, inttostr(aRow)+'-Неделя');
         //if aRow>=5 then TextOut(aRect.Left + 10, aRect.Top+45, inttostr(aRow-4)+'-Неделя');
        end;

     // Массив
    { if (aRow>0) and not(trim(Cells[aCol, aRow])='') then
        begin
         Font.Size:=8;
         Font.Color := clGray;
         TextOut(aRect.Left + 10, aRect.Top+60, 'Ч\Н: '+masday[nday-1,2]+' Нед: '+masday[nday-1,3]+' ДНед: '+masday[strtoint(Cells[aCol, aRow])-1,4]);
        end;}


     // Реквизиты
    { if (aRow>0) and (aCol=2) then
        begin
         //tel+inn+adrur
         Font.Size:=10;
         Font.Color := clBlue;
         //TextOut(aRect.Left + 2, aRect.Top+18,'Тел: '+trim(Formsk.StringGrid1.Cells[6,aRow])+' ИНН: '+trim(Formsk.StringGrid1.Cells[7,aRow]));
         //TextOut(aRect.Left + 2, aRect.Top+30,'Адр.Юр.: '+trim(Formsk.StringGrid1.Cells[8,aRow]));
        end;}

     // Заголовок
      if aRow=0 then
        begin
          Brush.Color:=clMoneyGreen;
          FillRect(aRect);
          Font.Color := clBlack;
          font.Size:=12;
          TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
         end;
  end;
 end;

 procedure TFormgr.FormShow(Sender: TObject);
  var
    n:integer;
   myYear, myMonth, myDay : Word;
 begin
   Centrform(Formgr);
  // Заполняем combo месяцами
  formgr.ComboBox1.Items.Clear;
  for n:=1 to 12 do
     begin
       formgr.ComboBox1.Items.Add(GetMonthName(n));
     end;
  DecodeDate(Date(), myYear, myMonth, myDay);
  Combobox1.ItemIndex:=myMonth-1; //MonthOftheYear(date());
  SpinEdit1.Value:= myYear;
  // Выводим информацио о расписании и его действии
  formgr.Label2.Caption:='Расписание № '+upperall(trim(form16.Edit6.text))+'   '+upperall(trim(form16.Edit5.Text));
  formgr.Label4.Caption:='Активно с '+FormatDateTime('dd.mm.yyyy',strtodate(form16.DateEdit3.Text))+' по '+FormatDateTime('dd.mm.yyyy',strtodate(form16.DateEdit2.Text));
  formgr.Label5.Caption:='Перевозчик '+Form16.StringGrid6.Cells[1,Form16.StringGrid6.Row];
  formgr.calendar_day();
 end;

 procedure TFormgr.ComboBox1Change(Sender: TObject);
 begin
   formgr.calendar_day();
 end;

 procedure TFormgr.FormClose(Sender: TObject; var CloseAction: TCloseAction);
 begin
  //очистка памяти от массива
  SetLength(masday,0,0);
  masday := nil;
  SetLength(ardate,0);
  ardate := nil;
 end;

 procedure TFormgr.Button1Click(Sender: TObject);
  var
  n,m:integer;
   sss:string;
 begin
  sss:='';
  for n:=0 to length(masday)-1 do
     begin
      for m:=0 to 5 do
         begin
           sss:=sss+' | '+inttostr(masday[n,m]);
         end;
        sss:=sss+#13;
     end;
  showmessagealt(sss);
 end;

 procedure TFormgr.Button3Click(Sender: TObject);
     var
  n,m:integer;
  sss:string;
 begin

   //   ardate[n,0]:= ;  id АТП
  //   ardate[n,1]-[n,12]:= ;  Номера месяцев
  //   ardate[n,13]:= ;        Категория /Дни месяца
  //   ardate[n,15]:= ;        Категория /Переодичность\недели
  //   ardate[n,16]-[n,19]:= ; Недели
  //   ardate[n,20]-[n,26]:= ; Дни недели
  //   ardate[n,27]-[n,29]:= ; Периодичность
  //   ardate[n,30]-[n,60]:= ; Дни месяца
  //   ardate[n,61]:= ;        Категория /Осуществление перевозки каждый n день
  //   ardate[n,62]:= ;        Каждый n день
  sss:='month: ';
      for m:=0 to 13 do
         begin
           sss:=sss+' | '+inttostr(ardate[m]);
         end;
        sss:=sss+#13+'weeks: ';
       for m:=14 to 19 do
         begin
           sss:=sss+' | '+inttostr(ardate[m]);
         end;
        sss:=sss+#13+'day of weeks: ';
        for m:=20 to 26 do
         begin
           sss:=sss+' | '+inttostr(ardate[m]);
         end;
        sss:=sss+#13+'чет\нечет: ';
        for m:=27 to 29 do
         begin
           sss:=sss+' | '+inttostr(ardate[m]);
         end;
        sss:=sss+#13+'days: ';
        for m:=30 to 60 do
         begin
           sss:=sss+' | '+inttostr(ardate[m]);
         end;
         sss:=sss+#13+'n-day: ';
        for m:=61 to 62 do
         begin
           sss:=sss+' | '+inttostr(ardate[m]);
         end;
        //sss:=sss+#13;
  showmessagealt(sss);
 end;

procedure TFormgr.CheckBox1Change(Sender: TObject);
begin
   formgr.calendar_day();
end;

  procedure TFormgr.BitBtn4ChangeBounds(Sender: TObject);
 begin
   Formgr.Close;
 end;

  procedure TFormgr.BitBtn4Click(Sender: TObject);
  begin
    formgr.Close;
  end;

 procedure TFormgr.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
 begin
   // ESC
    if Key=27 then formgr.Close;
 end;

{$R *.lfm}

end.

